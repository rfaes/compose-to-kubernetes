#!/bin/bash

# Test script for workshop content validation
set -e

echo "================================================"
echo "Kubernetes Workshop - Content Validation Tests"
echo "================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASSED=0
FAILED=0
WARNINGS=0

# Function to print test result
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}: $2"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAIL${NC}: $2"
        ((FAILED++))
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠ WARNING${NC}: $1"
    ((WARNINGS++))
}

# Test 1: Check if kubectl is available
echo "Test 1: Checking kubectl installation..."
if command -v kubectl &> /dev/null; then
    print_result 0 "kubectl is installed"
else
    print_result 1 "kubectl is not installed"
fi

# Test 2: Validate Part 1 YAML files
echo ""
echo "Test 2: Validating Part 1 YAML files..."
YAML_ERRORS=0
while IFS= read -r file; do
    if kubectl apply --dry-run=client -f "$file" &> /dev/null; then
        echo "  ✓ $file"
    else
        echo "  ✗ $file"
        ((YAML_ERRORS++))
    fi
done < <(find part-1 -name "*.yaml" -type f 2>/dev/null)

if [ $YAML_ERRORS -eq 0 ]; then
    print_result 0 "All Part 1 YAML files are valid"
else
    print_result 1 "Found $YAML_ERRORS invalid YAML files in Part 1"
fi

# Test 3: Validate Part 2 YAML files
echo ""
echo "Test 3: Validating Part 2 YAML files..."
YAML_ERRORS=0
while IFS= read -r file; do
    if kubectl apply --dry-run=client -f "$file" &> /dev/null; then
        echo "  ✓ $file"
    else
        echo "  ✗ $file"
        ((YAML_ERRORS++))
    fi
done < <(find part-2 -name "*.yaml" -type f 2>/dev/null)

if [ $YAML_ERRORS -eq 0 ]; then
    print_result 0 "All Part 2 YAML files are valid"
else
    print_result 1 "Found $YAML_ERRORS invalid YAML files in Part 2"
fi

# Test 4: Check for required documentation files
echo ""
echo "Test 4: Checking required documentation files..."
REQUIRED_FILES=(
    "README.md"
    "LICENSE"
    "CONTRIBUTING.md"
    "CODE_OF_CONDUCT.md"
    "SECURITY.md"
    "PREREQUISITES.md"
)

DOC_ERRORS=0
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file exists"
    else
        echo "  ✗ $file missing"
        ((DOC_ERRORS++))
    fi
done

if [ $DOC_ERRORS -eq 0 ]; then
    print_result 0 "All required documentation files present"
else
    print_result 1 "Missing $DOC_ERRORS required documentation files"
fi

# Test 5: Check workshop structure
echo ""
echo "Test 5: Checking workshop structure..."
STRUCTURE_OK=true

# Check Part 1 sections
for i in {01..11}; do
    if [ ! -d "part-1/$i-"* ]; then
        print_warning "Part 1 section $i directory not found"
        STRUCTURE_OK=false
    fi
done

# Check Part 2 sections
for i in {01..08}; do
    if [ ! -d "part-2/$i-"* ]; then
        print_warning "Part 2 section $i directory not found"
        STRUCTURE_OK=false
    fi
done

if [ "$STRUCTURE_OK" = true ]; then
    print_result 0 "Workshop structure is complete"
else
    print_result 1 "Workshop structure has missing sections"
fi

# Test 6: Check setup files
echo ""
echo "Test 6: Checking setup files..."
SETUP_FILES=(
    "setup/Dockerfile"
    "setup/README.md"
    "setup/kind/simple.yaml"
    "setup/kind/multi-node.yaml"
    "setup/kind/ha.yaml"
    "docker-compose.yml"
)

SETUP_ERRORS=0
for file in "${SETUP_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file exists"
    else
        echo "  ✗ $file missing"
        ((SETUP_ERRORS++))
    fi
done

if [ $SETUP_ERRORS -eq 0 ]; then
    print_result 0 "All setup files present"
else
    print_result 1 "Missing $SETUP_ERRORS setup files"
fi

# Test 7: Check for broken markdown links (if markdown-link-check is available)
echo ""
echo "Test 7: Checking for broken links in markdown..."
if command -v markdown-link-check &> /dev/null; then
    LINK_ERRORS=0
    while IFS= read -r file; do
        if ! markdown-link-check "$file" -q &> /dev/null; then
            ((LINK_ERRORS++))
        fi
    done < <(find . -name "*.md" -type f -not -path "*/node_modules/*" 2>/dev/null)
    
    if [ $LINK_ERRORS -eq 0 ]; then
        print_result 0 "No broken links found"
    else
        print_warning "Found $LINK_ERRORS markdown files with broken links"
    fi
else
    print_warning "markdown-link-check not installed, skipping link validation"
fi

# Summary
echo ""
echo "================================================"
echo "Test Summary"
echo "================================================"
echo -e "${GREEN}Passed:${NC}   $PASSED"
echo -e "${RED}Failed:${NC}   $FAILED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All critical tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed. Please review the output above.${NC}"
    exit 1
fi
