Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B3573433
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiGMKa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiGMKaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:21 -0400
X-Greylist: delayed 47036 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 03:30:19 PDT
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8241FB8FB
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:19 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 2435780025;
        Wed, 13 Jul 2022 06:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708219; bh=mo8Hn7AgzL+gApvkhAxpv4zormpI06WaQ9lTncood/E=;
        h=From:To:Cc:Subject:Date:From;
        b=xDwVLGOrm8VYWj/pZ6GnkpgUcEyh9tOBgFvxZeUd0yYHzfVGjX/0ESNzFKx4sHafa
         14cmQfaGkgWa43hDgApbTaKcxr1natm0qIeO2DRkmzhcnpwl1nAhU7lfiZ6Yh96vvU
         5pM/rz2Hm+J65ZdOCcnoi7a2/feaMbA+52nvEM/oZi0RVGVM1fxaU9z71P6tulcjuH
         ZPWU2hXJf0CR223be1U9gkPQVomlO1L7quJfHOSR9ccrBggZJD0KShlU7E+zIifqzX
         ZopuZYpmLj86kLlmNNCMnnCFo28hb162jQ5nrcuW+/d3W6H83mGNIRer77rL1em2Qr
         o/Znhtyiz2LSw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 00/23] btrfs: add fscrypt integration
Date:   Wed, 13 Jul 2022 06:29:33 -0400
Message-Id: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a first, partial draft of adding fscrypt integration to btrfs.

Last October, Omar sent out a design document for having fscrypt
integration with btrfs [1]. In summary, it proposes btrfs storing its
own encryption IVs on a per-file-extent basis. fscrypt usually encrypts
files using an IV derived from per-inode information; this would prevent
snapshotting or reflinking or data relocation for btrfs, but by using an
IV associated with each file extent, all the inodes sharing a particular
key and file extent may decrypt successfully.

This series starts implementing it on the kernel side for the simplest
case, non-compressed data extents. My goal in sending out this RFC is to
get feedback from btrfs folks whether these are going in a reasonable
direction; while there are a couple of additional parts, they're
fundamentally minor compared to this.

Not included are a couple of minor changes to btrfs-progs; additionally,
none of the fscrypt tool changes needed to use the new encryption policy
are included. Obviously, additional fstests will be needed.

Known issues are a couple of compile warnings; a mysterious EUCLEAN
return on file read that I've been trying to hunt down; no prevention of
other policies being used with btrfs, and probably other bugs and
missing code; I've been hunting bugs for the past month and keep finding
more, which is why this is so much later than I hoped last month.

Not sent out in this patchset are encryption for inline data extents,
verity items, and compressed data.

Also available as a branch at [2].

Feedback heartily appreciated.

[1] https://lore.kernel.org/linux-btrfs/YXGyq+buM79A1S0L@relinquished.localdomain/
[2] https://github.com/sweettea/btrfs-fscrypt/tree/draft-for-rfc

Omar Sandoval (12):
  btrfs: change btrfs_insert_file_extent() to btrfs_insert_hole_extent()
  btrfs: rename dir_item's dir_type field to dir_flags
  btrfs: add new FT_FSCRYPT flag for directories.
  btrfs: explicitly keep track of file extent item size.
  btrfs: factor out a memcmp for two extent_buffers.
  btrfs: factor a fscrypt_name matching method
  fscrypt: add fscrypt_have_same_policy() to check inode's compatibility
  btrfs: disable various operations on encrypted inodes
  btrfs: Add new FEATURE_INCOMPAT_FSCRYPT feature flag.
  btrfs: reuse encrypted filename hash when possible.
  btrfs: implement fscrypt ioctls
  btrfs: adapt directory read and lookup to potentially encrypted
    filenames

Sweet Tea Dorminy (11):
  btrfs: use fscrypt_name's instead of name/len everywhere.
  btrfs: setup fscrypt_names from dentrys using helper
  fscrypt: expose fscrypt_nokey_name
  fscrypt: expose a method to check whether a fscrypt_name is encrypted.
  btrfs: add fscrypt operation table to superblock
  btrfs: start using fscrypt hooks.
  btrfs: add a subvolume flag for whole-volume encryption
  btrfs: translate btrfs encryption flags and encrypted inode flag.
  fscrypt: Add new encryption policy for btrfs.
  btrfs: add iv generation function
  btrfs: enable encryption for normal file extent data

 fs/btrfs/Makefile               |   1 +
 fs/btrfs/btrfs_inode.h          |   3 +
 fs/btrfs/ctree.h                | 122 +++++--
 fs/btrfs/delayed-inode.c        |  48 ++-
 fs/btrfs/delayed-inode.h        |   9 +-
 fs/btrfs/dir-item.c             | 115 ++++---
 fs/btrfs/extent_io.c            | 139 +++++++-
 fs/btrfs/extent_io.h            |   6 +
 fs/btrfs/extent_map.h           |   8 +
 fs/btrfs/file-item.c            |  41 ++-
 fs/btrfs/file.c                 |  15 +-
 fs/btrfs/fscrypt.c              | 222 +++++++++++++
 fs/btrfs/fscrypt.h              |  49 +++
 fs/btrfs/inode-item.c           |  84 ++---
 fs/btrfs/inode-item.h           |  14 +-
 fs/btrfs/inode.c                | 551 +++++++++++++++++++++++---------
 fs/btrfs/ioctl.c                |  80 ++++-
 fs/btrfs/ordered-data.c         |  12 +-
 fs/btrfs/ordered-data.h         |   3 +-
 fs/btrfs/print-tree.c           |   4 +-
 fs/btrfs/props.c                |  11 +-
 fs/btrfs/reflink.c              |   8 +
 fs/btrfs/root-tree.c            |  20 +-
 fs/btrfs/send.c                 | 141 ++++----
 fs/btrfs/super.c                |   8 +-
 fs/btrfs/transaction.c          |  41 ++-
 fs/btrfs/tree-checker.c         |  56 +++-
 fs/btrfs/tree-log.c             | 307 ++++++++++--------
 fs/btrfs/tree-log.h             |   4 +-
 fs/btrfs/xattr.c                |  21 +-
 fs/crypto/crypto.c              |  28 +-
 fs/crypto/fname.c               |  56 +---
 fs/crypto/fscrypt_private.h     |   4 +-
 fs/crypto/inline_crypt.c        |  20 +-
 fs/crypto/keysetup.c            |   6 +
 fs/crypto/policy.c              |  34 +-
 include/linux/fscrypt.h         |  67 +++-
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  26 ++
 include/uapi/linux/fscrypt.h    |   1 +
 40 files changed, 1767 insertions(+), 619 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

-- 
2.35.1

