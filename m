Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125A97CB237
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjJPSWA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPSV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:21:59 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14DA7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:21:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77386822cfbso332805085a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480515; x=1698085315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCMBkj9luOR2bCR4PL5CLQSCLxwzuxemcRbPfpqiUoM=;
        b=FEGbOOAX+IcalVPbibroMQ3DEAMI3YQxK+kmxaVjWPTuPZs5qTzFHwmbzf2h5zmMrb
         E2yxcmtYBsE9Lcrv/MvJdKUG1ebyVTY3eGRIIVLTVzrmcRgXwkJt0c8vc9Uk0zUuoATz
         LLO1nC2PI1+AlSQZgSfJynf4OlGyFqz00aKwXfNu9BYkoJ2Wk2CH/v6ezxFyQaPNZnNQ
         0jLmlCGDALipj7RQHVcfB1X/aODH82Tnzbe84AvJ8WP8iTf1NP4qMwVJ4GKvhNPXH+I5
         gSfAihQ2gofM+uGq2RkDi2TUUw33v62qjoBPOMun/PwVmWkfZX6WUqy8f74D+63cul9t
         LZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480515; x=1698085315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCMBkj9luOR2bCR4PL5CLQSCLxwzuxemcRbPfpqiUoM=;
        b=A8rmlRGSPGVRUXQEes5EO6NnDevaBs9gPnPCr17jAXbkJ31Chluq/c9Ig0Wegcg0cq
         fTT5GZ1zzMtMmHycP7Yc4YvEsyKzxYuduF6Pog9/iJyTeFS5oDlHDWAQkAAL4mT0btDC
         yJg4OmOb3YVfHVqOmil5wcGBc3pjQdtTSjuBN/d4VcmRUCGzAMATGoKWwM+cwX1hJ4Sl
         3co4ofPKZHsRlTeDUigsXY7DAyKjyf7oP0botPoIaK2F9JQ/ibrGSAuFg5CwstazS9Nt
         vJqiVcnH3WbBJzJp/Zg2SiboV4kt99Rz7sRoPsPkPQEJjg7oGYZVynVh05vJ1lRPh3B/
         Vjcg==
X-Gm-Message-State: AOJu0YyJsgmTiqTaf3oFNYEd+xdOBmfJ9nYkCEK5hwTz4TlSOAK2QSSh
        0QVY+vsQ0yx6LPyL2dmR28k43LmlWtbsOTNgW9y+qw==
X-Google-Smtp-Source: AGHT+IFZPy0k9OzblkNRHjL8kdYXqcI7iHBhqv442dETqpZZyKoJVJEU6oLqXXgn5vS9m8mCVYPysw==
X-Received: by 2002:a05:622a:3d1:b0:412:1e51:8fef with SMTP id k17-20020a05622a03d100b004121e518fefmr149481qtx.30.1697480515160;
        Mon, 16 Oct 2023 11:21:55 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ih6-20020a05622a6a8600b004197d6d97c4sm3150467qtb.24.2023.10.16.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:21:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 00/34] btrfs: add fscrypt support
Date:   Mon, 16 Oct 2023 14:21:07 -0400
Message-ID: <cover.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

v1 and v2 of these patches can be found here

https://lore.kernel.org/linux-btrfs/cover.1695750478.git.josef@toxicpanda.com/
https://lore.kernel.org/linux-btrfs/cover.1696970227.git.josef@toxicpanda.com/

v2->v3:
- Rebased onto Eric's "fscrypt: track master key presence separately from
  secret" patch.
- Fixed a problem where we weren't setting the logical offset for split bios
  properly, resulting in csum corruptions.
- Updated the documentation and changelog to call out that inline encryption was
  required for extent based encryption and why.
- Folded "fscrypt: disable all but standard v2 policies for extent encryption"
  into "fscrypt: add per-extent encryption support" per Eric's request.
- Changed the behavior of the secret clearing to only do this when we're using
  extent based encryption.
- Updated the blk-crypto patch to have a helper that made sure we're using the
  fallback profile instead of adding a flag to the profile.

I've run this through the tests and everything came out fine.  Thanks,

Josef

Josef Bacik (19):
  fscrypt: add per-extent encryption support
  fscrypt: conditionally don't wipe mk secret until the last active user
    is done
  blk-crypto: add a process bio callback
  fscrypt: add documentation about extent encryption
  btrfs: add infrastructure for safe em freeing
  btrfs: add fscrypt_info and encryption_type to ordered_extent
  btrfs: plumb through setting the fscrypt_info for ordered extents
  btrfs: populate the ordered_extent with the fscrypt context
  btrfs: keep track of fscrypt info and orig_start for dio reads
  btrfs: add an optional encryption context to the end of file extents
  btrfs: pass through fscrypt_extent_info to the file extent helpers
  btrfs: pass the fscrypt_info through the replace extent infrastructure
  btrfs: implement the fscrypt extent encryption hooks
  btrfs: setup fscrypt_extent_info for new extents
  btrfs: populate ordered_extent with the orig offset
  btrfs: set the bio fscrypt context when applicable
  btrfs: add a bio argument to btrfs_csum_one_bio
  btrfs: add orig_logical to btrfs_bio
  btrfs: implement process_bio cb for fscrypt

Omar Sandoval (7):
  fscrypt: expose fscrypt_nokey_name
  btrfs: disable various operations on encrypted inodes
  btrfs: start using fscrypt hooks
  btrfs: add inode encryption contexts
  btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs: adapt readdir for encrypted and nokey names
  btrfs: implement fscrypt ioctls

Sweet Tea Dorminy (8):
  btrfs: disable verity on encrypted inodes
  btrfs: handle nokey names.
  btrfs: add encryption to CONFIG_BTRFS_DEBUG
  btrfs: add get_devices hook for fscrypt
  btrfs: turn on inlinecrypt mount option for encrypt
  btrfs: set file extent encryption excplicitly
  btrfs: add fscrypt_info and encryption_type to extent_map
  btrfs: explicitly track file extent length for replace and drop

 Documentation/filesystems/fscrypt.rst |  41 +++
 block/blk-crypto-fallback.c           |  40 +++
 block/blk-crypto-internal.h           |   8 +
 block/blk-crypto-profile.c            |   2 +
 block/blk-crypto.c                    |   6 +-
 fs/btrfs/Makefile                     |   1 +
 fs/btrfs/accessors.h                  |  50 +++
 fs/btrfs/bio.c                        |  46 ++-
 fs/btrfs/bio.h                        |   6 +
 fs/btrfs/btrfs_inode.h                |   3 +-
 fs/btrfs/compression.c                |   6 +
 fs/btrfs/ctree.h                      |   4 +
 fs/btrfs/defrag.c                     |  10 +-
 fs/btrfs/delayed-inode.c              |  29 +-
 fs/btrfs/delayed-inode.h              |   6 +-
 fs/btrfs/dir-item.c                   | 108 +++++-
 fs/btrfs/dir-item.h                   |  11 +-
 fs/btrfs/extent_io.c                  |  81 ++++-
 fs/btrfs/extent_io.h                  |   3 +
 fs/btrfs/extent_map.c                 | 106 +++++-
 fs/btrfs/extent_map.h                 |  12 +
 fs/btrfs/file-item.c                  |  17 +-
 fs/btrfs/file-item.h                  |   7 +-
 fs/btrfs/file.c                       |  16 +-
 fs/btrfs/fs.h                         |   3 +-
 fs/btrfs/fscrypt.c                    | 326 ++++++++++++++++++
 fs/btrfs/fscrypt.h                    |  95 +++++
 fs/btrfs/inode.c                      | 476 ++++++++++++++++++++------
 fs/btrfs/ioctl.c                      |  41 ++-
 fs/btrfs/ordered-data.c               |  26 +-
 fs/btrfs/ordered-data.h               |  21 +-
 fs/btrfs/reflink.c                    |   8 +
 fs/btrfs/root-tree.c                  |   8 +-
 fs/btrfs/root-tree.h                  |   2 +-
 fs/btrfs/super.c                      |  17 +
 fs/btrfs/sysfs.c                      |   6 +
 fs/btrfs/tree-checker.c               |  66 +++-
 fs/btrfs/tree-log.c                   |  26 +-
 fs/btrfs/verity.c                     |   3 +
 fs/crypto/crypto.c                    |  10 +-
 fs/crypto/fname.c                     |  39 +--
 fs/crypto/fscrypt_private.h           |  44 +++
 fs/crypto/inline_crypt.c              |  87 ++++-
 fs/crypto/keyring.c                   |  18 +-
 fs/crypto/keysetup.c                  | 155 +++++++++
 fs/crypto/policy.c                    |  59 ++++
 include/linux/blk-crypto.h            |   9 +-
 include/linux/fscrypt.h               | 122 +++++++
 include/uapi/linux/btrfs.h            |   1 +
 include/uapi/linux/btrfs_tree.h       |  35 +-
 50 files changed, 2105 insertions(+), 217 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

-- 
2.41.0

