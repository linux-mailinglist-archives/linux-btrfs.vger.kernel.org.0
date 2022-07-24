Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF957F248
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiGXAyR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiGXAyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:16 -0400
X-Greylist: delayed 96 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 17:54:16 PDT
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0414D3B;
        Sat, 23 Jul 2022 17:54:16 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 80A6A807A4;
        Sat, 23 Jul 2022 20:54:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624056; bh=gJyPhOyUxpuePGvIu48Bao84uC8KU19ls1HXqO4P0zw=;
        h=From:To:Cc:Subject:Date:From;
        b=noJdIxB8rqpFElMEsxADiHgE/RuQxsLwGcswZgYVOMsy7fVqtbtxDbKM4ErYSImyz
         VFmRccPexJguj5wG/r7jlO6yG1G6LckZbvGc3Qyaf2G/f8UbsFIF5J1SI0i2f/lbZi
         2w+HmkbCmqSh82m6nmhLFYHapFnt5TU9ePLJzC2rxH866o1UcyXOmF1d3NY9rTxqST
         HHHgp8mOUn+4Zcno2sQWOpM1N5ompfiKvwtbIkJrnxALr0KaDPGY4i2sZX1RXPeZs+
         JbHTx06aEJkvygcexXWyyYIhiD1BwjzIKpuFLOl/WN2uUskNIj3eCv3vOJYqDNDMxf
         3oaUe4KJND4vA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 00/16] btrfs: add fscrypt integration
Date:   Sat, 23 Jul 2022 20:53:45 -0400
Message-Id: <cover.1658623319.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a draft set of changes adding fscrypt integration to btrfs.

Last October, Omar sent out a design document for having fscrypt
integration with btrfs [1]. In summary, it proposes btrfs storing its
own encryption IVs on a per-file-extent basis. fscrypt usually encrypts
files using an IV derived from per-inode information; this would prevent
snapshotting or reflinking or data relocation for btrfs, but by using an
IV associated with each file extent, all the inodes sharing a particular
key and file extent may decrypt successfully.

This series starts implementing it on the kernel side for the simple
case, non-compressed data extents. My goal in sending out this RFC is to
get feedback on whether these are going in a reasonable direction; while
there are a couple of additional parts, they're fundamentally minor
compared to this.

Not included are a couple of minor changes to btrfs-progs; additionally,
none of the fscrypt tool changes needed to use the new encryption policy
are included. Obviously, additional fstests will be needed. Also not yet
included are encryption for inline data extents, verity items, and
compressed data.

[1]
https://lore.kernel.org/linux-btrfs/YXGyq+buM79A1S0L@relinquished.localdomain/

Changelog:

v2: 
 - Fixed all warnings and known incorrectnesses.
 - Split fscrypt changes into their own patchset:
    https://lore.kernel.org/linux-fscrypt/cover.1658623235.git.sweettea-kernel@dorminy.me
 - Combined and reordered changes so that enabling fscrypt is the last change.
 - Removed unnecessary factoring.
 - Split a cleanup change off.

v1:
 - https://lore.kernel.org/linux-btrfs/cover.1657707686.git.sweettea-kernel@dorminy.me

Omar Sandoval (13):
  btrfs: store directories' encryption state
  btrfs: factor a fscrypt_name matching method
  btrfs: disable various operations on encrypted inodes
  btrfs: add fscrypt operation table to superblock
  btrfs: start using fscrypt hooks.
  btrfs: add a subvolume flag for whole-volume encryption
  btrfs: translate btrfs encryption flags and encrypted inode flag.
  btrfs: store an IV per encrypted normal file extent
  btrfs: Add new FEATURE_INCOMPAT_FSCRYPT feature flag.
  btrfs: reuse encrypted filename hash when possible.
  btrfs: adapt directory read and lookup to potentially encrypted
    filenames
  btrfs: encrypt normal file extent data if appropriate
  btrfs: implement fscrypt ioctls

Sweet Tea Dorminy (3):
  btrfs: use fscrypt_name's instead of name/len everywhere.
  btrfs: setup fscrypt_names from dentrys using helper
  btrfs: add iv generation function for fscrypt

 fs/btrfs/Makefile               |   1 +
 fs/btrfs/btrfs_inode.h          |   3 +
 fs/btrfs/ctree.h                | 113 +++++--
 fs/btrfs/delayed-inode.c        |  48 ++-
 fs/btrfs/delayed-inode.h        |   9 +-
 fs/btrfs/dir-item.c             | 120 ++++---
 fs/btrfs/extent_io.c            |  93 +++++-
 fs/btrfs/extent_io.h            |   2 +
 fs/btrfs/extent_map.h           |   8 +
 fs/btrfs/file-item.c            |  20 +-
 fs/btrfs/file.c                 |  11 +-
 fs/btrfs/fscrypt.c              | 224 +++++++++++++
 fs/btrfs/fscrypt.h              |  49 +++
 fs/btrfs/inode-item.c           |  84 ++---
 fs/btrfs/inode-item.h           |  14 +-
 fs/btrfs/inode.c                | 547 ++++++++++++++++++++++++--------
 fs/btrfs/ioctl.c                |  80 ++++-
 fs/btrfs/ordered-data.c         |  12 +-
 fs/btrfs/ordered-data.h         |   3 +-
 fs/btrfs/print-tree.c           |   4 +-
 fs/btrfs/props.c                |  11 +-
 fs/btrfs/reflink.c              |   8 +
 fs/btrfs/root-tree.c            |  20 +-
 fs/btrfs/send.c                 | 141 ++++----
 fs/btrfs/super.c                |   8 +-
 fs/btrfs/transaction.c          |  43 ++-
 fs/btrfs/tree-checker.c         |  56 +++-
 fs/btrfs/tree-log.c             | 261 ++++++++-------
 fs/btrfs/tree-log.h             |   4 +-
 fs/btrfs/xattr.c                |  21 +-
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  26 ++
 32 files changed, 1525 insertions(+), 520 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

-- 
2.35.1

