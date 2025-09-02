@import SDWebImage;
@import SDWebImageSVGCoder;

// A no-op symbol we can call from Swift to force the linker to include this object file
void KYCAID_linkSVGBootstrap(void) {}

__attribute__((constructor))
static void KYCAID_RegisterSVGCoder(void) {
    SDImageCodersManager *mgr = SDImageCodersManager.sharedManager;
    for (id<SDImageCoder> c in mgr.coders) {
        if ([c isKindOfClass:SDImageSVGCoder.class]) return;
    }
    // Optional: put SVG coder first so it takes priority
    NSMutableArray *coders = [mgr.coders mutableCopy] ?: [NSMutableArray new];
    [coders insertObject:SDImageSVGCoder.sharedCoder atIndex:0];
    mgr.coders = coders;
}
