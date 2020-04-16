Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D621AD21E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgDPVqe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727829AbgDPVqd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC0C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m21so2269736pff.13
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPsyTmionOTiOukRnyarlmKAVehjY9Q84U6/54QPzhU=;
        b=EwFrz7IIVmTh3koaKxgDXgJblViK9ZPppVkB/qgIb+18FEzBK5+Fa8rYFB9lh/ctUz
         zpZPLCc1X1JKBEASy9FgVflsX5qpcstTuu2c8RrLF0Oyi8DwI6n1jW0eaTV2UtVv+AKf
         DoGT/y5IlDZoe2MOCaZqpXiAVFjiHKDWtD3IBKJlXoXs5PGzVY/vfpsL++jXYyJgeK8p
         8zuz/ec7iMyTmNKy4ee8lOktPEULjngnOprqD1efUTcG9CBn+LDpulb2qyGPskUpZmui
         Cx91/VV4k4q3xAMwAXwxMv2KhYoIB5NHqkl1z7tpJlNhXp4m/8k/ZnOwCsEYlYUenOci
         LHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPsyTmionOTiOukRnyarlmKAVehjY9Q84U6/54QPzhU=;
        b=fu3k/1NHn1KMhNgvWiCUB/XNNQCWGRUR5fPW+T2g5opgeI8X96V1mGphV7FpVq9Vsg
         MOAsio07F7CRE8iaMONeE7iHZiBScGefvYKB6ndBQw3hNylv5t2dBOcfeW//vTOg4mBP
         Mmf5Up+C+4/obPENoOAql9f0LgzOrBMCbh9fkFQmh/yfHkoDugMMcEuB0mmjMIt38I6l
         IrUf40TNuzIejsJkoUyVRBg+/f9sLAVxkn+S7PMrVE//12ikN1cs1wMcX5uHYR4DDEi4
         JjkGW7nt5MUqrY4n3w/aDS7z9JcuhNrt9Omqm0XRhvWK8FKfclzZybgQ4ZHxSFD7cn2V
         EBNw==
X-Gm-Message-State: AGi0Pua7uHvIRLzO3tJjGD1gon/LVgQQHKBudoVYF5pTGYGJBYp9gPQR
        PaBc1Qzjqd3I446jBY9/FELi0ziq8cY=
X-Google-Smtp-Source: APiQypJ6BUFWTMClIvndaQmdJ7Qgho8lH5liVj4LbJGy6AfNq/mC8kmPIFC4BICdP0l1gXcTLwCYzg==
X-Received: by 2002:a63:f963:: with SMTP id q35mr11270985pgk.271.1587073592955;
        Thu, 16 Apr 2020 14:46:32 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:32 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/15] btrfs: read repair/direct I/O improvements
Date:   Thu, 16 Apr 2020 14:46:10 -0700
Message-Id: <cover.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This is version 2 of my series of fixes, cleanups, and improvements to
direct I/O and read repair. It's preparation for adding read repair to
my RWF_ENCODED series [1], but it can go in independently.

Patch 1 adds a new bio helper needed for patch 4. Patches 2 and 3 are
direct I/O error handling fixes. Patch 4 is a buffered read repair fix.
Patch 5 is a buffered read repair improvement. Patches 6-9 are trivial
cleanups. Patch 10 converts direct I/O to use refcount_t, which would've
helped catch the bug fixed by patch 2. Patches 11-14 drastically
simplify the direct I/O code. Patch 15 unifies buffered and direct I/O
read repair, which also makes direct I/O repair actually do validation
for large failed reads instead of rewriting the whole thing.

Overall, this is net about -350 lines of code and actually makes direct
I/O more functional.

Note that this series causes btrfs/142 to fail. This is a bug in the
test, as it assumes that direct I/O doesn't do read validation. This is
fixed by the fstests patch "btrfs/14{2,3}: use dm-dust instead of
fail_make_request" which I sent up yesterday [2].

Jens and Christoph are cc'd for patches 1 and 4. Instead of looking at
the bio internals like I did in v1, I added a new
bio_for_each_bvec_all() helper.

Changes from v1 [3]:

* Added patch 1 with bio_for_each_bvec_all() helper
* Dropped patch 8 which moved struct definition
* Fixed performance regression [4] in patch 13 caused by accidentally
  making all direct I/O submission asynchronous
* Fixed uninitialized assert in patch 12
* Fixed misplaced assert in btrfs_check_read_dio_bio in patch 13
* Added reviewed-bys
* Refactored btrfs_submit_direct() and btrfs_submit_direct_hook() in
  patch 2 (I didn't add Nikolay's reviewed-by to that one because the
  new patch looks fairly different from patch 1 in v1)
* Rewrapped csum calculations in patch 10 for easier readability
* Clarified several commit messages and comments

This series is based on misc-next.

Thanks!

1: https://lore.kernel.org/linux-fsdevel/cover.1582930832.git.osandov@fb.com/
2: https://lore.kernel.org/fstests/d992390752c612acd0893ee3db929e77affded2b.1586983958.git.osandov@fb.com/
3: https://lore.kernel.org/linux-btrfs/cover.1583789410.git.osandov@fb.com/
4: https://lore.kernel.org/lkml/20200331090145.GH11705@shao2-debian/

Omar Sandoval (15):
  block: add bio_for_each_bvec_all()
  btrfs: fix error handling when submitting direct I/O bio
  btrfs: fix double __endio_write_update_ordered in direct I/O
  btrfs: look at full bi_io_vec for repair decision
  btrfs: don't do repair validation for checksum errors
  btrfs: clarify btrfs_lookup_bio_sums documentation
  btrfs: rename __readpage_endio_check to check_data_csum
  btrfs: make btrfs_check_repairable() static
  btrfs: kill btrfs_dio_private->private
  btrfs: convert btrfs_dio_private->pending_bios to refcount_t
  btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
  btrfs: get rid of one layer of bios in direct I/O
  btrfs: simplify direct I/O read repair
  btrfs: get rid of endio_repair_workers
  btrfs: unify buffered and direct I/O read repair

 .clang-format                   |   1 +
 Documentation/block/biovecs.rst |   2 +
 fs/btrfs/btrfs_inode.h          |  26 +-
 fs/btrfs/ctree.h                |   1 -
 fs/btrfs/disk-io.c              |   8 +-
 fs/btrfs/disk-io.h              |   1 -
 fs/btrfs/extent_io.c            | 152 ++++---
 fs/btrfs/extent_io.h            |  19 +-
 fs/btrfs/file-item.c            |  11 +-
 fs/btrfs/inode.c                | 745 ++++++++------------------------
 include/linux/bio.h             |   8 +
 11 files changed, 312 insertions(+), 662 deletions(-)

-- 
2.26.1
