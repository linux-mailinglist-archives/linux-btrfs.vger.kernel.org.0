Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626F2763DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWWiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 18:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 18:38:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C59C0613CE;
        Wed, 23 Sep 2020 15:38:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so552446pfn.9;
        Wed, 23 Sep 2020 15:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhHqqkSVKn6rZ4h6XeZh497gPkwQtyjzH2cEirTfl7k=;
        b=HTFV7I6cg6RNDv/NMnGOkI2NzsxeG8ieol0iIYXAaAO6Kin5NsDiLzuK5hKSNJPWnd
         36k23K10QZt7NJnnN0j1QjZvDhb/jZs+YA1UvlFcptGPXyTTF+p957V/jxrCmoEBpQU3
         sEB1jaRE5JFRtrSVSGOKCNxs1XVaGTgKmL2hXlrCIQeQPwWIib4ZnKo1TbZa9J4zgy5F
         UkZTwCPJ1IJVFdhK8s2h/6DGf286EW+RbFgLZmB247BIyQf5+SrLykn1h5Qt3ZVGkmpd
         wnPG37PuCxKyu4GMgh3HpZW1/qhfOdWnhNPvmVSmxotzDq+xW5AbvCExslIDA3Fxcgbj
         Hx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhHqqkSVKn6rZ4h6XeZh497gPkwQtyjzH2cEirTfl7k=;
        b=p9yDhzpA1PGGcq1gZMMRhn+agqTa3F6ZA2V7OEpyyKX7pxNTYFWVIq4At034ZmcDr4
         heAMR9s/QbX0n13Xzm0tI73wl3T98lH46XtgJoB/qI+tNRXWTX+fUdS9X02hYNxYP74o
         m9dXUX6KXNtTgB6LZNxBAPjDyrNdozpmT9a++66ZlTouIKLzJobsO0Nt2xgMQHgEleES
         hvOOJERhMuBRQ8IGEJDscuRMk+FKnNqFUr24Fd26QLPUydLLonN4kYImNV+YeuWama0u
         F6qKOwAGHijzdlZb/Y1ED8tfhHVyXo2/o9ACXY7nF7Y2WNZN7xgIiDXLJx2JpnbOM0xQ
         nStw==
X-Gm-Message-State: AOAM533PwlAxpNIGqxm/v0ixlB8GQkMbx1S1lqUXu7tcyayCQxXuuqWq
        EkX5rtnKxXaMnAjRXNZjliU=
X-Google-Smtp-Source: ABdhPJxiMKj2yoif21j40vRTaPVDy3hg5wLMP0JRrQqUP0wQWw82oV0WLcXpxTFx0Map42TKIV1TDg==
X-Received: by 2002:a63:1a19:: with SMTP id a25mr1449275pga.359.1600900690725;
        Wed, 23 Sep 2020 15:38:10 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id d20sm417964pjv.39.2020.09.23.15.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 15:38:09 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 0/9] Update to zstd-1.4.6
Date:   Wed, 23 Sep 2020 15:41:57 -0700
Message-Id: <20200923224206.68968-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

This patchset upgrades the zstd library to the latest upstream release. The
current zstd version in the kernel is a modified version of upstream zstd-1.3.1.
At the time it was integrated, zstd wasn't ready to be used in the kernel as-is.
But, it is now possible to use upstream zstd directly in the kernel.

I have not yet release zstd-1.4.6 upstream. I want the zstd version in the kernel
to match up with a known upstream release, so we know exactly what code is
running. Whenever this patchset is ready for merge, I will cut a release at the
upstream commit that gets merged. This should not be necessary for future
releases.

The kernel zstd library is automatically generated from upstream zstd. A script
makes the necessary changes and imports it into the kernel. The changes are:

1. Replace all libc dependencies with kernel replacements and rewrite includes.
2. Remove unncessary portability macros like: #if defined(_MSC_VER).
3. Use the kernel xxhash instead of bundling it.

This automation gets tested every commit by upstream's continuous integration.
When we cut a new zstd release, we will submit a patch to the kernel to update
the zstd version in the kernel.

I've updated zstd to upstream with one big patch because every commit must build,
so that precludes partial updates. Since the commit is 100% generated, I hope the
review burden is lightened. I considered replaying upstream commits, but that is
not possible because there have been ~3500 upstream commits since the last zstd
import, and the commits don't all build individually. The bulk update preserves
bisectablity because bugs can be bisected to the zstd version update. At that
point the update can be reverted, and we can work with upstream to find and fix
the bug. After this big switch in how the kernel consumes zstd, future patches
will be smaller, because they will only have one upstream release worth of
changes each.

This patchset changes the zstd API from a custom kernel API to the upstream API.
I considered wrapping the upstream API with a wrapper that is closer to the
kernel style guide. Following advise from https://lkml.org/lkml/2020/9/17/814
I've chosen to use the upstream API directly, to minimize opportunities to
introduce bugs, and because using the upstream API directly makes debugging and
communication with upstream easier.

This patchset comes in 3 parts:
1. The first 2 patches prepare for the zstd upgrade. The first patch adds a
   compatibility wrapper so zstd can be upgraded without modifying any callers.
   The second patch adds an indirection for the lib/decompress_unzstd.c including
   of all decompression source files.
2. Import zstd-1.4.6. This patch is completely generated from upstream using
   automated tooling.
3. Update all callers to the zstd-1.4.6 API then delete the compatibility
   wrapper.

I tested every caller of zstd on x86_64. I tested both after the 1.4.6 upgrade
using the compatibility wrapper, and after the final patch in this series. 

I tested kernel and initramfs decompression in i386 and arm.

I ran benchmarks to compare the current zstd in the kernel with zstd-1.4.6.
I benchmarked on x86_64 using QEMU with KVM enabled on an Intel i9-9900k.
I found:
* BtrFS zstd compression at levels 1 and 3 is 5% faster
* BtrFS zstd decompression+read is 15% faster
* SquashFS zstd decompression+read is 15% faster
* F2FS zstd compression+write at level 3 is 8% faster
* F2FS zstd decompression+read is 20% faster
* ZRAM decompression+read is 30% faster
* Kernel zstd decompression is 35% faster
* Initramfs zstd decompression+build is 5% faster

The latest zstd also offers bug fixes and a 1 KB reduction in stack uage during
compression.

Please let me know if there is anything that I can do to ease the way for these
patches. I think it is important because it gets large performance improvements,
contains bug fixes, and is switching to a more maintainable model of consuming
upstream zstd directly, making it easy to keep up to date.

Best,
Nick Terrell

v1 -> v2:
* Successfully tested F2FS with help from Chao Yu to fix my test.
* (1/9) Fix ZSTD_initCStream() wrapper to handle pledged_src_size=0 means unknown.
  This fixes F2FS with the zstd-1.4.6 compatibility wrapper, exposed by the test.

v2 -> v3:
* (3/9) Silence warnings by Kernel Test Robot:
  https://github.com/facebook/zstd/pull/2324
  Stack size warnings remain, but these aren't new, and the functions it warns on
  are either unused or not in the maximum stack path. This patchset reduces zstd
  compression stack usage by 1 KB overall. I've gotten the low hanging fruit, and
  more stack reduction would require significant changes that have the potential
  to introduce new bugs. However, I do hope to continue to reduce zstd stack
  usage in future versions.

Nick Terrell (9):
  lib: zstd: Add zstd compatibility wrapper
  lib: zstd: Add decompress_sources.h for decompress_unzstd
  lib: zstd: Upgrade to latest upstream zstd version 1.4.6
  crypto: zstd: Switch to zstd-1.4.6 API
  btrfs: zstd: Switch to the zstd-1.4.6 API
  f2fs: zstd: Switch to the zstd-1.4.6 API
  squashfs: zstd: Switch to the zstd-1.4.6 API
  lib: unzstd: Switch to the zstd-1.4.6 API
  lib: zstd: Remove zstd compatibility wrapper

 crypto/zstd.c                                 |   22 +-
 fs/btrfs/zstd.c                               |   46 +-
 fs/f2fs/compress.c                            |  100 +-
 fs/squashfs/zstd_wrapper.c                    |    7 +-
 include/linux/zstd.h                          | 3021 ++++++++----
 include/linux/zstd_errors.h                   |   76 +
 lib/decompress_unzstd.c                       |   44 +-
 lib/zstd/Makefile                             |   35 +-
 lib/zstd/bitstream.h                          |  379 --
 lib/zstd/common/bitstream.h                   |  437 ++
 lib/zstd/common/compiler.h                    |  134 +
 lib/zstd/common/cpu.h                         |  194 +
 lib/zstd/common/debug.c                       |   24 +
 lib/zstd/common/debug.h                       |  101 +
 lib/zstd/common/entropy_common.c              |  355 ++
 lib/zstd/common/error_private.c               |   55 +
 lib/zstd/common/error_private.h               |   66 +
 lib/zstd/common/fse.h                         |  709 +++
 lib/zstd/common/fse_decompress.c              |  380 ++
 lib/zstd/common/huf.h                         |  352 ++
 lib/zstd/common/mem.h                         |  347 ++
 lib/zstd/common/zstd_common.c                 |   83 +
 lib/zstd/common/zstd_deps.h                   |  134 +
 lib/zstd/common/zstd_internal.h               |  434 ++
 lib/zstd/compress.c                           | 3485 --------------
 lib/zstd/compress/fse_compress.c              |  625 +++
 lib/zstd/compress/hist.c                      |  165 +
 lib/zstd/compress/hist.h                      |   75 +
 lib/zstd/compress/huf_compress.c              |  764 +++
 lib/zstd/compress/zstd_compress.c             | 4160 +++++++++++++++++
 lib/zstd/compress/zstd_compress_internal.h    | 1103 +++++
 lib/zstd/compress/zstd_compress_literals.c    |  158 +
 lib/zstd/compress/zstd_compress_literals.h    |   29 +
 lib/zstd/compress/zstd_compress_sequences.c   |  433 ++
 lib/zstd/compress/zstd_compress_sequences.h   |   54 +
 lib/zstd/compress/zstd_compress_superblock.c  |  849 ++++
 lib/zstd/compress/zstd_compress_superblock.h  |   32 +
 lib/zstd/compress/zstd_cwksp.h                |  524 +++
 lib/zstd/compress/zstd_double_fast.c          |  521 +++
 lib/zstd/compress/zstd_double_fast.h          |   32 +
 lib/zstd/compress/zstd_fast.c                 |  496 ++
 lib/zstd/compress/zstd_fast.h                 |   31 +
 lib/zstd/compress/zstd_lazy.c                 | 1138 +++++
 lib/zstd/compress/zstd_lazy.h                 |   61 +
 lib/zstd/compress/zstd_ldm.c                  |  619 +++
 lib/zstd/compress/zstd_ldm.h                  |  104 +
 lib/zstd/compress/zstd_opt.c                  | 1200 +++++
 lib/zstd/compress/zstd_opt.h                  |   50 +
 lib/zstd/decompress.c                         | 2531 ----------
 lib/zstd/decompress/huf_decompress.c          | 1205 +++++
 lib/zstd/decompress/zstd_ddict.c              |  241 +
 lib/zstd/decompress/zstd_ddict.h              |   44 +
 lib/zstd/decompress/zstd_decompress.c         | 1836 ++++++++
 lib/zstd/decompress/zstd_decompress_block.c   | 1540 ++++++
 lib/zstd/decompress/zstd_decompress_block.h   |   62 +
 .../decompress/zstd_decompress_internal.h     |  195 +
 lib/zstd/decompress_sources.h                 |   18 +
 lib/zstd/entropy_common.c                     |  243 -
 lib/zstd/error_private.h                      |   53 -
 lib/zstd/fse.h                                |  575 ---
 lib/zstd/fse_compress.c                       |  795 ----
 lib/zstd/fse_decompress.c                     |  325 --
 lib/zstd/huf.h                                |  212 -
 lib/zstd/huf_compress.c                       |  772 ---
 lib/zstd/huf_decompress.c                     |  960 ----
 lib/zstd/mem.h                                |  151 -
 lib/zstd/zstd_common.c                        |   75 -
 lib/zstd/zstd_compress_module.c               |   79 +
 lib/zstd/zstd_decompress_module.c             |   79 +
 lib/zstd/zstd_internal.h                      |  273 --
 lib/zstd/zstd_opt.h                           | 1014 ----
 71 files changed, 24509 insertions(+), 13012 deletions(-)
 create mode 100644 include/linux/zstd_errors.h
 delete mode 100644 lib/zstd/bitstream.h
 create mode 100644 lib/zstd/common/bitstream.h
 create mode 100644 lib/zstd/common/compiler.h
 create mode 100644 lib/zstd/common/cpu.h
 create mode 100644 lib/zstd/common/debug.c
 create mode 100644 lib/zstd/common/debug.h
 create mode 100644 lib/zstd/common/entropy_common.c
 create mode 100644 lib/zstd/common/error_private.c
 create mode 100644 lib/zstd/common/error_private.h
 create mode 100644 lib/zstd/common/fse.h
 create mode 100644 lib/zstd/common/fse_decompress.c
 create mode 100644 lib/zstd/common/huf.h
 create mode 100644 lib/zstd/common/mem.h
 create mode 100644 lib/zstd/common/zstd_common.c
 create mode 100644 lib/zstd/common/zstd_deps.h
 create mode 100644 lib/zstd/common/zstd_internal.h
 delete mode 100644 lib/zstd/compress.c
 create mode 100644 lib/zstd/compress/fse_compress.c
 create mode 100644 lib/zstd/compress/hist.c
 create mode 100644 lib/zstd/compress/hist.h
 create mode 100644 lib/zstd/compress/huf_compress.c
 create mode 100644 lib/zstd/compress/zstd_compress.c
 create mode 100644 lib/zstd/compress/zstd_compress_internal.h
 create mode 100644 lib/zstd/compress/zstd_compress_literals.c
 create mode 100644 lib/zstd/compress/zstd_compress_literals.h
 create mode 100644 lib/zstd/compress/zstd_compress_sequences.c
 create mode 100644 lib/zstd/compress/zstd_compress_sequences.h
 create mode 100644 lib/zstd/compress/zstd_compress_superblock.c
 create mode 100644 lib/zstd/compress/zstd_compress_superblock.h
 create mode 100644 lib/zstd/compress/zstd_cwksp.h
 create mode 100644 lib/zstd/compress/zstd_double_fast.c
 create mode 100644 lib/zstd/compress/zstd_double_fast.h
 create mode 100644 lib/zstd/compress/zstd_fast.c
 create mode 100644 lib/zstd/compress/zstd_fast.h
 create mode 100644 lib/zstd/compress/zstd_lazy.c
 create mode 100644 lib/zstd/compress/zstd_lazy.h
 create mode 100644 lib/zstd/compress/zstd_ldm.c
 create mode 100644 lib/zstd/compress/zstd_ldm.h
 create mode 100644 lib/zstd/compress/zstd_opt.c
 create mode 100644 lib/zstd/compress/zstd_opt.h
 delete mode 100644 lib/zstd/decompress.c
 create mode 100644 lib/zstd/decompress/huf_decompress.c
 create mode 100644 lib/zstd/decompress/zstd_ddict.c
 create mode 100644 lib/zstd/decompress/zstd_ddict.h
 create mode 100644 lib/zstd/decompress/zstd_decompress.c
 create mode 100644 lib/zstd/decompress/zstd_decompress_block.c
 create mode 100644 lib/zstd/decompress/zstd_decompress_block.h
 create mode 100644 lib/zstd/decompress/zstd_decompress_internal.h
 create mode 100644 lib/zstd/decompress_sources.h
 delete mode 100644 lib/zstd/entropy_common.c
 delete mode 100644 lib/zstd/error_private.h
 delete mode 100644 lib/zstd/fse.h
 delete mode 100644 lib/zstd/fse_compress.c
 delete mode 100644 lib/zstd/fse_decompress.c
 delete mode 100644 lib/zstd/huf.h
 delete mode 100644 lib/zstd/huf_compress.c
 delete mode 100644 lib/zstd/huf_decompress.c
 delete mode 100644 lib/zstd/mem.h
 delete mode 100644 lib/zstd/zstd_common.c
 create mode 100644 lib/zstd/zstd_compress_module.c
 create mode 100644 lib/zstd/zstd_decompress_module.c
 delete mode 100644 lib/zstd/zstd_internal.h
 delete mode 100644 lib/zstd/zstd_opt.h

-- 
2.28.0

