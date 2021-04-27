Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7C36BF41
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 08:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhD0G1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 02:27:25 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:59362 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhD0G1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 02:27:24 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8F385A55425;
        Tue, 27 Apr 2021 08:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1619504791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKe3r64Pg00WoeteGW7jXgLyIIBSj1vgWqsfSEE0/0A=;
        b=aFEY/8weGUfvnZTkZVa93syeSAscOpHTQq+yciLSeKof/Ewde+2OujZF/TkTYQMwfH5klX
        pxa9ZYQE2BiiSCHEdWSrxTn2SHppuKkzKz5FTSKbcENSS5100YXoWCz5VYV7qjdK+Vb9d1
        PMY2gFWGfrVS5YveWSJZlAcpRiJD8HQ=
Date:   Tue, 27 Apr 2021 08:26:29 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>, Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [GIT PULL][PATCH v10 0/4] Update to zstd-1.4.10
Message-ID: <20210427062629.g5ob5bvcmx6z5rwm@spock.localdomain>
References: <20210426234621.870684-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426234621.870684-1-nickrterrell@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 04:46:17PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Please pull from
> 
>   git@github.com:terrelln/linux.git tags/v10-zstd-1.4.10
> 
> to get these changes. Alternatively the patchset is included.
> 
> This patchset lists me as the maintainer for zstd and upgrades the zstd library
> to the latest upstream release. The current zstd version in the kernel is a
> modified version of upstream zstd-1.3.1. At the time it was integrated, zstd
> wasn't ready to be used in the kernel as-is. But, it is now possible to use
> upstream zstd directly in the kernel.
> 
> I have not yet released zstd-1.4.10 upstream. I want the zstd version in the
> kernel to match up with a known upstream release, so we know exactly what code
> is running. Whenever this patchset is ready for merge, I will cut a release at
> the upstream commit that gets merged. This should not be necessary for future
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
> This patchset adds a new kernel-style wrapper around zstd. This wrapper API is
> functionally equivalent to the subset of the current zstd API that is currently
> used. The wrapper API changes to be kernel style so that the symbols don't
> collide with zstd's symbols. The update to zstd-1.4.6 maintains the same API
> and preserves the semantics, so that none of the callers need to be updated.
> 
> This patchset comes in 2 parts:
> 1. The first 2 patches prepare for the zstd upgrade. The first patch adds the
>    new kernel style API so zstd can be upgraded without modifying any callers.
>    The second patch adds an indirection for the lib/decompress_unzstd.c
>    including of all decompression source files.
> 2. Import zstd-1.4.10. This patch is completely generated from upstream using
>    automated tooling.
> 
> I tested every caller of zstd on x86_64. I tested both after the 1.4.10 upgrade
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
> The latest zstd also offers bug fixes. For example the problem with large kernel
> decompression has been fixed upstream for over 2 years
> https://lkml.org/lkml/2020/9/29/27.
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
> v4 -> v5:
> * Rebase onto v5.10-rc2
> * (6/9) Merge with other F2FS changes (no functional change in patch).
> 
> v5 -> v6:
> * Rebase onto v5.10-rc6.
> * Switch to using a kernel style wrapper API as suggested by Cristoph.
> 
> v6 -> v7:
> * Expose the upstream library header as `include/linux/zstd_lib.h`.
>   Instead of creating new structs mirroring the upstream zstd structs
>   use upstream's structs directly with a typedef to get a kernel style name.
>   This removes the memcpy cruft.
> * (1/3) Undo ZSTD_WINDOWLOG_MAX and handle_zstd_error changes.
> * (3/3) Expose zstd_errors.h as `include/linux/zstd_errors.h` because it
>   is needed by the kernel wrapper API.
> 
> v7 -> v8:
> * (1/3) Fix typo in EXPORT_SYMBOL().
> * (1/3) Fix typo in zstd.h comments.
> * (3/3) Update to latest zstd release: 1.4.6 -> 1.4.10
>         This includes ~1KB of stack space reductions.
> 
> v8 -> v9:
> * (1/3) Rebase onto v5.12-rc5
> * (1/3) Add zstd_min_clevel() & zstd_max_clevel() and use in f2fs.
>         Thanks to Oleksandr Natalenko for spotting it!
> * (1/3) Move lib/decompress_unzstd.c usage of ZSTD_getErrorCode()
>         to zstd_get_error_code().
> * (1/3) Update modified zstd headers to yearless copyright.
> * (2/3) Add copyright/license header to decompress_sources.h for consistency.
> * (3/3) Update to yearless copyright for all zstd files. Thanks to
>         Mike Dolan for spotting it!
> 
> v9 -> v10:
> * Add a 4th patch in the series which adds an entry for zstd to MAINTAINERS.

For the series:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

> 
> Nick Terrell (4):
>   lib: zstd: Add kernel-specific API
>   lib: zstd: Add decompress_sources.h for decompress_unzstd
>   lib: zstd: Upgrade to latest upstream zstd version 1.4.10
>   MAINTAINERS: Add maintainer entry for zstd
> 
>  MAINTAINERS                                   |   12 +
>  crypto/zstd.c                                 |   28 +-
>  fs/btrfs/zstd.c                               |   68 +-
>  fs/f2fs/compress.c                            |   56 +-
>  fs/f2fs/super.c                               |    2 +-
>  fs/pstore/platform.c                          |    2 +-
>  fs/squashfs/zstd_wrapper.c                    |   16 +-
>  include/linux/zstd.h                          | 1252 +---
>  include/linux/zstd_errors.h                   |   77 +
>  include/linux/zstd_lib.h                      | 2432 ++++++++
>  lib/decompress_unzstd.c                       |   48 +-
>  lib/zstd/Makefile                             |   44 +-
>  lib/zstd/bitstream.h                          |  380 --
>  lib/zstd/common/bitstream.h                   |  437 ++
>  lib/zstd/common/compiler.h                    |  151 +
>  lib/zstd/common/cpu.h                         |  194 +
>  lib/zstd/common/debug.c                       |   24 +
>  lib/zstd/common/debug.h                       |  101 +
>  lib/zstd/common/entropy_common.c              |  357 ++
>  lib/zstd/common/error_private.c               |   56 +
>  lib/zstd/common/error_private.h               |   66 +
>  lib/zstd/common/fse.h                         |  710 +++
>  lib/zstd/common/fse_decompress.c              |  390 ++
>  lib/zstd/common/huf.h                         |  356 ++
>  lib/zstd/common/mem.h                         |  259 +
>  lib/zstd/common/zstd_common.c                 |   83 +
>  lib/zstd/common/zstd_deps.h                   |  125 +
>  lib/zstd/common/zstd_internal.h               |  450 ++
>  lib/zstd/compress.c                           | 3485 -----------
>  lib/zstd/compress/fse_compress.c              |  625 ++
>  lib/zstd/compress/hist.c                      |  165 +
>  lib/zstd/compress/hist.h                      |   75 +
>  lib/zstd/compress/huf_compress.c              |  902 +++
>  lib/zstd/compress/zstd_compress.c             | 5105 +++++++++++++++++
>  lib/zstd/compress/zstd_compress_internal.h    | 1188 ++++
>  lib/zstd/compress/zstd_compress_literals.c    |  158 +
>  lib/zstd/compress/zstd_compress_literals.h    |   29 +
>  lib/zstd/compress/zstd_compress_sequences.c   |  439 ++
>  lib/zstd/compress/zstd_compress_sequences.h   |   54 +
>  lib/zstd/compress/zstd_compress_superblock.c  |  850 +++
>  lib/zstd/compress/zstd_compress_superblock.h  |   32 +
>  lib/zstd/compress/zstd_cwksp.h                |  482 ++
>  lib/zstd/compress/zstd_double_fast.c          |  521 ++
>  lib/zstd/compress/zstd_double_fast.h          |   32 +
>  lib/zstd/compress/zstd_fast.c                 |  496 ++
>  lib/zstd/compress/zstd_fast.h                 |   31 +
>  lib/zstd/compress/zstd_lazy.c                 | 1412 +++++
>  lib/zstd/compress/zstd_lazy.h                 |   81 +
>  lib/zstd/compress/zstd_ldm.c                  |  686 +++
>  lib/zstd/compress/zstd_ldm.h                  |  110 +
>  lib/zstd/compress/zstd_ldm_geartab.h          |  103 +
>  lib/zstd/compress/zstd_opt.c                  | 1345 +++++
>  lib/zstd/compress/zstd_opt.h                  |   50 +
>  lib/zstd/decompress.c                         | 2531 --------
>  lib/zstd/decompress/huf_decompress.c          | 1206 ++++
>  lib/zstd/decompress/zstd_ddict.c              |  241 +
>  lib/zstd/decompress/zstd_ddict.h              |   44 +
>  lib/zstd/decompress/zstd_decompress.c         | 2075 +++++++
>  lib/zstd/decompress/zstd_decompress_block.c   | 1540 +++++
>  lib/zstd/decompress/zstd_decompress_block.h   |   62 +
>  .../decompress/zstd_decompress_internal.h     |  202 +
>  lib/zstd/decompress_sources.h                 |   28 +
>  lib/zstd/entropy_common.c                     |  243 -
>  lib/zstd/error_private.h                      |   53 -
>  lib/zstd/fse.h                                |  575 --
>  lib/zstd/fse_compress.c                       |  795 ---
>  lib/zstd/fse_decompress.c                     |  325 --
>  lib/zstd/huf.h                                |  212 -
>  lib/zstd/huf_compress.c                       |  773 ---
>  lib/zstd/huf_decompress.c                     |  960 ----
>  lib/zstd/mem.h                                |  151 -
>  lib/zstd/zstd_common.c                        |   75 -
>  lib/zstd/zstd_compress_module.c               |  124 +
>  lib/zstd/zstd_decompress_module.c             |  105 +
>  lib/zstd/zstd_internal.h                      |  273 -
>  lib/zstd/zstd_opt.h                           | 1014 ----
>  76 files changed, 27299 insertions(+), 12940 deletions(-)
>  create mode 100644 include/linux/zstd_errors.h
>  create mode 100644 include/linux/zstd_lib.h
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
>  create mode 100644 lib/zstd/compress/zstd_ldm_geartab.h
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
> 2.31.1
> 

-- 
  Oleksandr Natalenko (post-factum)
