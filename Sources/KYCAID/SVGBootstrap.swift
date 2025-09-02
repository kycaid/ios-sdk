import SDWebImage
import SDWebImageSVGCoder

private let _registerSVGCoder: Void = {
    if SDImageCodersManager.shared.coders?.contains(where: { $0 is SDImageSVGCoder }) != true {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}()

// run at module load
private let _ = _registerSVGCoder
