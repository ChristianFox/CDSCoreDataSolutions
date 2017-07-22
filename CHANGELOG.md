
# CDSCodeDataSolutions ChangeLog #

## v0.9.1.0 Adds support for NSInMemoryStoreType
- CDSPersistentStoreDescriptor: makes type readwrite, url returns nil if NSInMemoryStoreType, updates type property doc comment
- Adds CDSInMemoryStoreTests.m

## 0.9.0 synchronous configuration 
- Adds synchronous configuration methods to CDSCoreDataStack
- Changes CDSTestsAppDelegate to include code for both configuration methods (async & synch). One must always be commented out.


## 0.8.0 Update non-code files & documentation
- Adds CHANGELOG.md
- Update Licence File
- Updates Podspec
- Fixes documentation warnings
