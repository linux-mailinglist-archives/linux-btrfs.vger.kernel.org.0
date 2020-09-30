Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA527E1D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgI3Gxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Gxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:53:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F0C061755;
        Tue, 29 Sep 2020 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G/n6/1rP0Qqf5HaH5WVsR9tsYWNcYqUmsmpO1k+lz5c=; b=orZaxFcAemVyRaDyAyB5WhklYE
        mYl6U5XyM1Td1vDMJ40i48XsUXhL3uxRqtF5oy4IlCRKCGKr/db57/lYznhyuAteNvIEytvLoOQkn
        VHBlP5hkysOyztaAz78gvy47oSE9480Jv0thT7WNVZj4qBNrGdP5/gEp2Sd4J6vNC3j3dX54to5uG
        64C0CuVzgv/dlClgPQT2I2HOIM01sG7iCvgBWJ2emxikSnZeAS8Ydtfcya4rTjsP1c883S1d7Vy/J
        3ATvac0v+RBNK/86OJnnR+tOUajUIgu9gME0HjwSF150EzgRUSsN0qsz4twUcX4yEepM36+eWlhWa
        yl8GIKyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNVzc-0003b0-7d; Wed, 30 Sep 2020 06:53:36 +0000
Date:   Wed, 30 Sep 2020 07:53:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/9] Update to zstd-1.4.6
Message-ID: <20200930065336.GA13656@infradead.org>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930065318.3326526-1-nickrterrell@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As you keep resend this I keep retelling you that should not do it.
Please provide a proper Linux API, and switch to that.  Versioned APIs
have absolutely no business in the Linux kernel.

On Tue, Sep 29, 2020 at 11:53:09PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> This patchset upgrades the zstd library to the latest upstream release. The
> current zstd version in the kernel is a modified version of upstream zstd-1.3.1.
> At the time it was integrated, zstd wasn't ready to be used in the kernel as-is.
> But, it is now possible to use upstream zstd directly in the kernel.
> 
> I have not yet release zstd-1.4.6 upstream. I want the zstd version in the kernel
> to match up with a known upstream release, so we know exactly what code is
> running. Whenever this patchset is ready for merge, I will cut a release at the
> upstream commit that gets merged. This should not be necessary for future
> releases.
> 
> The kernel zstd library is automatically generated from upstream zstd. A script
> makes the necessary changes and imports it into the kernel. The changes are:
> 
> 1. Replace all libc dependencies with kernel replacements and rewrite includes.
> 2. Remove unncessary portability macros like: #if defined(_MSC_VER).
> 3. Use the kernel xxhash instead of bundling it.
> 
> This automation gets tested every commit by upstream's continuous integration.
> When we cut a new zstd release, we will submit a patch to the kernel to update
> the zstd version in the kernel.
> 
> I've updated zstd to upstream with one big patch because every commit must build,
> so that precludes partial updates. Since the commit is 100% generated, I hope the
> review burden is lightened. I considered replaying upstream commits, but that is
> not possible because there have been ~3500 upstream commits since the last zstd
> import, and the commits don't all build individually. The bulk update preserves
> bisectablity because bugs can be bisected to the zstd version update. At that
> point the update can be reverted, and we can work with upstream to find and fix
> the bug. After this big switch in how the kernel consumes zstd, future patches
> will be smaller, because they will only have one upstream release worth of
> changes each.
> 
> This patchset changes the zstd API from a custom kernel API to the upstream API.
> I considered wrapping the upstream API with a wrapper that is closer to the
> kernel style guide. Following advise from https://lkml.org/lkml/2020/9/17/814
> I've chosen to use the upstream API directly, to minimize opportunities to
> introduce bugs, and because using the upstream API directly makes debugging and
> communication with upstream easier.
> 
> This patchset comes in 3 parts:
> 1. The first 2 patches prepare for the zstd upgrade. The first patch adds a
>    compatibility wrapper so zstd can be upgraded without modifying any callers.
>    The second patch adds an indirection for the lib/decompress_unzstd.c including
>    of all decompression source files.
> 2. Import zstd-1.4.6. This patch is completely generated from upstream using
>    automated tooling.
> 3. Update all callers to the zstd-1.4.6 API then delete the compatibility
>    wrapper.
> 
> I tested every caller of zstd on x86_64. I tested both after the 1.4.6 upgrade
> using the compatibility wrapper, and after the final patch in this series. 
> 
> I tested kernel and initramfs decompression in i386 and arm.
> 
> I ran benchmarks to compare the current zstd in the kernel with zstd-1.4.6.
> I benchmarked on x86_64 using QEMU with KVM enabled on an Intel i9-9900k.
> I found:
> * BtrFS zstd compression at levels 1 and 3 is 5% faster
> * BtrFS zstd decompression+read is 15% faster
> * SquashFS zstd decompression+read is 15% faster
> * F2FS zstd compression+write at level 3 is 8% faster
> * F2FS zstd decompression+read is 20% faster
> * ZRAM decompression+read is 30% faster
> * Kernel zstd decompression is 35% faster
> * Initramfs zstd decompression+build is 5% faster
> 
> The latest zstd also offers bug fixes and a 1 KB reduction in stack uage during
> compression. For example the recent problem with large kernel decompression has
> been fixed upstream for over 2 years https://lkml.org/lkml/2020/9/29/27.
> 
> Please let me know if there is anything that I can do to ease the way for these
> patches. I think it is important because it gets large performance improvements,
> contains bug fixes, and is switching to a more maintainable model of consuming
> upstream zstd directly, making it easy to keep up to date.
> 
> Best,
> Nick Terrell
> 
> v1 -> v2:
> * Successfully tested F2FS with help from Chao Yu to fix my test.
> * (1/9) Fix ZSTD_initCStream() wrapper to handle pledged_src_size=0 means unknown.
>   This fixes F2FS with the zstd-1.4.6 compatibility wrapper, exposed by the test.
> 
> v2 -> v3:
> * (3/9) Silence warnings by Kernel Test Robot:
>   https://github.com/facebook/zstd/pull/2324
>   Stack size warnings remain, but these aren't new, and the functions it warns on
>   are either unused or not in the maximum stack path. This patchset reduces zstd
>   compression stack usage by 1 KB overall. I've gotten the low hanging fruit, and
>   more stack reduction would require significant changes that have the potential
>   to introduce new bugs. However, I do hope to continue to reduce zstd stack
>   usage in future versions.
> 
> v3 -> v4:
> * (3/9) Fix errors and warnings reported by Kernel Test Robot:
>   https://github.com/facebook/zstd/pull/2326
>   - Replace mem.h with a custom kernel implementation that matches the current
>     lib/zstd/mem.h in the kernel. This avoids calls to __builtin_bswap*() which
>     don't work on certain architectures, as exposed by the Kernel Test Robot.
>   - Remove ASAN/MSAN (un)poisoning code which doesn't work in the kernel, as
>     exposed by the Kernel Test Robot.
>   - I've fixed all of the valid cppcheck warnings reported, but there were many
>     false positives, where cppcheck was incorrectly analyzing the situation,
>     which I did not fix. I don't believe it is reasonable to expect that upstream
>     zstd silences all the static analyzer false positives. Upstream zstd uses
>     clang scan-build for its static analysis. We find that supporting multiple
>     static analysis tools multiplies the burden of silencing false positives,
>     without providing enough marginal value over running a single static analysis
>     tool.
> 
> Nick Terrell (9):
>   lib: zstd: Add zstd compatibility wrapper
>   lib: zstd: Add decompress_sources.h for decompress_unzstd
>   lib: zstd: Upgrade to latest upstream zstd version 1.4.6
>   crypto: zstd: Switch to zstd-1.4.6 API
>   btrfs: zstd: Switch to the zstd-1.4.6 API
>   f2fs: zstd: Switch to the zstd-1.4.6 API
>   squashfs: zstd: Switch to the zstd-1.4.6 API
>   lib: unzstd: Switch to the zstd-1.4.6 API
>   lib: zstd: Remove zstd compatibility wrapper
> 
>  crypto/zstd.c                                 |   22 +-
>  fs/btrfs/zstd.c                               |   46 +-
>  fs/f2fs/compress.c                            |  100 +-
>  fs/squashfs/zstd_wrapper.c                    |    7 +-
>  include/linux/zstd.h                          | 3021 ++++++++----
>  include/linux/zstd_errors.h                   |   76 +
>  lib/decompress_unzstd.c                       |   44 +-
>  lib/zstd/Makefile                             |   35 +-
>  lib/zstd/bitstream.h                          |  379 --
>  lib/zstd/common/bitstream.h                   |  437 ++
>  lib/zstd/common/compiler.h                    |  150 +
>  lib/zstd/common/cpu.h                         |  194 +
>  lib/zstd/common/debug.c                       |   24 +
>  lib/zstd/common/debug.h                       |  101 +
>  lib/zstd/common/entropy_common.c              |  355 ++
>  lib/zstd/common/error_private.c               |   55 +
>  lib/zstd/common/error_private.h               |   66 +
>  lib/zstd/common/fse.h                         |  709 +++
>  lib/zstd/common/fse_decompress.c              |  380 ++
>  lib/zstd/common/huf.h                         |  352 ++
>  lib/zstd/common/mem.h                         |  258 +
>  lib/zstd/common/zstd_common.c                 |   83 +
>  lib/zstd/common/zstd_deps.h                   |  124 +
>  lib/zstd/common/zstd_internal.h               |  438 ++
>  lib/zstd/compress.c                           | 3485 --------------
>  lib/zstd/compress/fse_compress.c              |  625 +++
>  lib/zstd/compress/hist.c                      |  165 +
>  lib/zstd/compress/hist.h                      |   75 +
>  lib/zstd/compress/huf_compress.c              |  764 +++
>  lib/zstd/compress/zstd_compress.c             | 4157 +++++++++++++++++
>  lib/zstd/compress/zstd_compress_internal.h    | 1103 +++++
>  lib/zstd/compress/zstd_compress_literals.c    |  158 +
>  lib/zstd/compress/zstd_compress_literals.h    |   29 +
>  lib/zstd/compress/zstd_compress_sequences.c   |  433 ++
>  lib/zstd/compress/zstd_compress_sequences.h   |   54 +
>  lib/zstd/compress/zstd_compress_superblock.c  |  849 ++++
>  lib/zstd/compress/zstd_compress_superblock.h  |   32 +
>  lib/zstd/compress/zstd_cwksp.h                |  465 ++
>  lib/zstd/compress/zstd_double_fast.c          |  521 +++
>  lib/zstd/compress/zstd_double_fast.h          |   32 +
>  lib/zstd/compress/zstd_fast.c                 |  496 ++
>  lib/zstd/compress/zstd_fast.h                 |   31 +
>  lib/zstd/compress/zstd_lazy.c                 | 1138 +++++
>  lib/zstd/compress/zstd_lazy.h                 |   61 +
>  lib/zstd/compress/zstd_ldm.c                  |  619 +++
>  lib/zstd/compress/zstd_ldm.h                  |  104 +
>  lib/zstd/compress/zstd_opt.c                  | 1200 +++++
>  lib/zstd/compress/zstd_opt.h                  |   50 +
>  lib/zstd/decompress.c                         | 2531 ----------
>  lib/zstd/decompress/huf_decompress.c          | 1205 +++++
>  lib/zstd/decompress/zstd_ddict.c              |  241 +
>  lib/zstd/decompress/zstd_ddict.h              |   44 +
>  lib/zstd/decompress/zstd_decompress.c         | 1836 ++++++++
>  lib/zstd/decompress/zstd_decompress_block.c   | 1540 ++++++
>  lib/zstd/decompress/zstd_decompress_block.h   |   62 +
>  .../decompress/zstd_decompress_internal.h     |  195 +
>  lib/zstd/decompress_sources.h                 |   18 +
>  lib/zstd/entropy_common.c                     |  243 -
>  lib/zstd/error_private.h                      |   53 -
>  lib/zstd/fse.h                                |  575 ---
>  lib/zstd/fse_compress.c                       |  795 ----
>  lib/zstd/fse_decompress.c                     |  325 --
>  lib/zstd/huf.h                                |  212 -
>  lib/zstd/huf_compress.c                       |  772 ---
>  lib/zstd/huf_decompress.c                     |  960 ----
>  lib/zstd/mem.h                                |  151 -
>  lib/zstd/zstd_common.c                        |   75 -
>  lib/zstd/zstd_compress_module.c               |   79 +
>  lib/zstd/zstd_decompress_module.c             |   79 +
>  lib/zstd/zstd_internal.h                      |  273 --
>  lib/zstd/zstd_opt.h                           | 1014 ----
>  71 files changed, 24368 insertions(+), 13012 deletions(-)
>  create mode 100644 include/linux/zstd_errors.h
>  delete mode 100644 lib/zstd/bitstream.h
>  create mode 100644 lib/zstd/common/bitstream.h
>  create mode 100644 lib/zstd/common/compiler.h
>  create mode 100644 lib/zstd/common/cpu.h
>  create mode 100644 lib/zstd/common/debug.c
>  create mode 100644 lib/zstd/common/debug.h
>  create mode 100644 lib/zstd/common/entropy_common.c
>  create mode 100644 lib/zstd/common/error_private.c
>  create mode 100644 lib/zstd/common/error_private.h
>  create mode 100644 lib/zstd/common/fse.h
>  create mode 100644 lib/zstd/common/fse_decompress.c
>  create mode 100644 lib/zstd/common/huf.h
>  create mode 100644 lib/zstd/common/mem.h
>  create mode 100644 lib/zstd/common/zstd_common.c
>  create mode 100644 lib/zstd/common/zstd_deps.h
>  create mode 100644 lib/zstd/common/zstd_internal.h
>  delete mode 100644 lib/zstd/compress.c
>  create mode 100644 lib/zstd/compress/fse_compress.c
>  create mode 100644 lib/zstd/compress/hist.c
>  create mode 100644 lib/zstd/compress/hist.h
>  create mode 100644 lib/zstd/compress/huf_compress.c
>  create mode 100644 lib/zstd/compress/zstd_compress.c
>  create mode 100644 lib/zstd/compress/zstd_compress_internal.h
>  create mode 100644 lib/zstd/compress/zstd_compress_literals.c
>  create mode 100644 lib/zstd/compress/zstd_compress_literals.h
>  create mode 100644 lib/zstd/compress/zstd_compress_sequences.c
>  create mode 100644 lib/zstd/compress/zstd_compress_sequences.h
>  create mode 100644 lib/zstd/compress/zstd_compress_superblock.c
>  create mode 100644 lib/zstd/compress/zstd_compress_superblock.h
>  create mode 100644 lib/zstd/compress/zstd_cwksp.h
>  create mode 100644 lib/zstd/compress/zstd_double_fast.c
>  create mode 100644 lib/zstd/compress/zstd_double_fast.h
>  create mode 100644 lib/zstd/compress/zstd_fast.c
>  create mode 100644 lib/zstd/compress/zstd_fast.h
>  create mode 100644 lib/zstd/compress/zstd_lazy.c
>  create mode 100644 lib/zstd/compress/zstd_lazy.h
>  create mode 100644 lib/zstd/compress/zstd_ldm.c
>  create mode 100644 lib/zstd/compress/zstd_ldm.h
>  create mode 100644 lib/zstd/compress/zstd_opt.c
>  create mode 100644 lib/zstd/compress/zstd_opt.h
>  delete mode 100644 lib/zstd/decompress.c
>  create mode 100644 lib/zstd/decompress/huf_decompress.c
>  create mode 100644 lib/zstd/decompress/zstd_ddict.c
>  create mode 100644 lib/zstd/decompress/zstd_ddict.h
>  create mode 100644 lib/zstd/decompress/zstd_decompress.c
>  create mode 100644 lib/zstd/decompress/zstd_decompress_block.c
>  create mode 100644 lib/zstd/decompress/zstd_decompress_block.h
>  create mode 100644 lib/zstd/decompress/zstd_decompress_internal.h
>  create mode 100644 lib/zstd/decompress_sources.h
>  delete mode 100644 lib/zstd/entropy_common.c
>  delete mode 100644 lib/zstd/error_private.h
>  delete mode 100644 lib/zstd/fse.h
>  delete mode 100644 lib/zstd/fse_compress.c
>  delete mode 100644 lib/zstd/fse_decompress.c
>  delete mode 100644 lib/zstd/huf.h
>  delete mode 100644 lib/zstd/huf_compress.c
>  delete mode 100644 lib/zstd/huf_decompress.c
>  delete mode 100644 lib/zstd/mem.h
>  delete mode 100644 lib/zstd/zstd_common.c
>  create mode 100644 lib/zstd/zstd_compress_module.c
>  create mode 100644 lib/zstd/zstd_decompress_module.c
>  delete mode 100644 lib/zstd/zstd_internal.h
>  delete mode 100644 lib/zstd/zstd_opt.h
> 
> -- 
> 2.28.0
> 
---end quoted text---
