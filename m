Return-Path: <linux-btrfs+bounces-1682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34EB83AF80
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B981F24882
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD17E79E;
	Wed, 24 Jan 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PGE4/v/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE807CF18
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116765; cv=none; b=s2Bupe4gBa/7khpjVnobiSf5lJdDkts5YSZzvxcZPsDdur8GDLU1d/6v2DuxWqj9BF64F4+lX/jhAh9wjjVL7SYNcSu7aazOqQNhG2XacOxJ50J00szNyOrQt6OerCGVqAsqlAQpCV0SYjrVqPBkMRzggeZ8T7S47F/pqYf+oRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116765; c=relaxed/simple;
	bh=8TCipElJWrrVGSZ8SfH6pqBHnJ8vR4ZAFVvUuzH1T/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iPrMYFGOJTr8ZQr+wXH1Dx6QEtL/7j4P6wI4agcVvzut0aYB3opNndhdvXmtQKoGapjcU1Jjz4Bvo92TfnvZ1J+Krj41n3zByZuWxR+ra4U5ugz9k/Oz/9j2NzQEarcjlLvuzbmvBRqx6+eZi9klASO5jtKgUgH1PNPeH8b4IjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PGE4/v/l; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc24ead4428so3963442276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116762; x=1706721562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ms+OTBBhZis0eqOryrejDyJG6p0OPn544rYhzRiAIdE=;
        b=PGE4/v/lwNPHGVS1NN1fOZq5tw8mSaQ1J9yzVMHGXVIrOs/e8jxdQtpeESNL6kJCaB
         kvTFIOmHdyhoDMxsSI0vjjgs+Vnjt/Q19ry0oaqhscdg6lIKJ8rLF5TiRWq50TIP7Oeq
         bOJ2EGxe9sMu0zYAxyyqBgCivxAuW5tDVDG0taElm5azPp0OwrHLDqrSW/Tb9ZstlgLG
         kaFb9bQlC5adi1MqAAHhz8ki3ni9qj5x1c/noyqxSVb8IdqKVipKOeQucIfem0Te4Cu6
         dugbaDXaEv+56GRgk+PqNFwGCRp46gvQJIx61Ucx/BOpDEEY5HVgUYtxQYEPQx5YS/fa
         2tQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116762; x=1706721562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms+OTBBhZis0eqOryrejDyJG6p0OPn544rYhzRiAIdE=;
        b=fhnGbeFglXSuiAguTNIw81hF+FvXqe2o8foxJLvcFTviyp3njYQP5fvr0gL8MHYaVv
         Z5jrQkBF51U6Sew10NvlS0DzzZv6w4MQe6fYnHpPfBgaPnxNpT+wOtvpVQl5b0mTUTnU
         pBwg/ykVwOfGfexcQ3kzl/QuNq2eziLwQxTBDB1w/GaYcjkNT9CdtmB5pFhtByygYxSg
         D0lEJkX/IpP2370jpTb4UBk12aLbhL5I9hy22nv5FrmS7rKzUpIQO/ItSWxNriABGORq
         aWO9Er9iBbWUp8IDZKfktpkBi7hV6U9Xb6F8E+nd3T3GYXe4qASJ3WaZLotAgfLzCA12
         E5pw==
X-Gm-Message-State: AOJu0Yy7303xHHPcnMz4wjJr6wKPnRosfJOLVvZpHqD7tCsNR4DPNNl6
	t7QRwQaZlQu7Bnhe1pBDbguzIct7NMzDmyRLH1GoD2VlRhDBD/EDjxHZuZCiXUJxO+kj5GE/r2D
	r
X-Google-Smtp-Source: AGHT+IFX123zdYbeBCiZGnjnTiyjjecCXEshornTGlvc3hpcu+si3+pnAa0rmZvyjq9U3byIxGgBGg==
X-Received: by 2002:a25:c3c7:0:b0:dc2:2604:4585 with SMTP id t190-20020a25c3c7000000b00dc226044585mr957540ybf.74.1706116761781;
        Wed, 24 Jan 2024 09:19:21 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m187-20020a2526c4000000b00dc2324b3cddsm2949781ybm.37.2024.01.24.09.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:21 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 00/52] btrfs: add fscrypt support
Date: Wed, 24 Jan 2024 12:18:22 -0500
Message-ID: <cover.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is based on 

https://github.com/btrfs/linux.git for-next

which has the recent pull from the fscrypt tree.

I've reworked a lot of this to incorporate Eric's suggestions.  There are a few
more patches because of bugs I've found in testing, and I've disabled a few
features, namely RAID5/6 and send, as they will require more work to support
with encryption and that can be done after the core work is merged.

Thanks,

Josef

v4->v5:
- Addressed all the comments from Eric and then reworked the rest of the code to
  handle the various changes.
- Fixed read repair.
- Fixed log replay.
- Disabled send for encrypted file systems.
- Disabled turning on encryption on RAID5/6 file systems.

v3->v4:
- Added support for '-o test_dummy_encryption' at Eric's suggestion, this
  uncovered a load of issues.
- Preliminary work to support decrypting names for our various name resolution
  ioctls.  I didn't get everything but I got the ones we depend on in fstests.
- Preliminary work for send of an encrypted directory with the key loaded.
  There's probably still bugs in here, but it doesn't crash anymore.
- Fixed how we limit the bio size to work with direct and buffered io.
- Fixed using the wrong fscrypt extent context for writes into prealloc extents.

Josef Bacik (38):
  fscrypt: add per-extent encryption support
  fscrypt: allow inline encryption for extent based encryption
  fscrypt: add a fscrypt_inode_open helper
  fscrypt: conditionally don't wipe mk secret until the last active user
    is done
  blk-crypto: add a process bio callback
  fscrypt: add a process_bio hook to fscrypt_operations
  fscrypt: add documentation about extent encryption
  btrfs: add infrastructure for safe em freeing
  btrfs: select encryption dependencies if FS_ENCRYPTION
  btrfs: add fscrypt_info and encryption_type to ordered_extent
  btrfs: plumb through setting the fscrypt_info for ordered extents
  btrfs: plumb the fscrypt extent context through create_io_em
  btrfs: populate the ordered_extent with the fscrypt context
  btrfs: keep track of fscrypt info and orig_start for dio reads
  btrfs: add an optional encryption context to the end of file extents
  btrfs: pass through fscrypt_extent_info to the file extent helpers
  btrfs: implement the fscrypt extent encryption hooks
  btrfs: setup fscrypt_extent_info for new extents
  btrfs: populate ordered_extent with the orig offset
  btrfs: set the bio fscrypt context when applicable
  btrfs: add a bio argument to btrfs_csum_one_bio
  btrfs: add orig_logical to btrfs_bio
  btrfs: limit encrypted writes to 256 segments
  btrfs: implement process_bio cb for fscrypt
  btrfs: implement read repair for encryption
  btrfs: add test_dummy_encryption support
  btrfs: don't rewrite ret from inode_permission
  btrfs: move inode_to_path higher in backref.c
  btrfs: make btrfs_ref_to_path handle encrypted filenames
  btrfs: don't search back for dir inode item in INO_LOOKUP_USER
  btrfs: deal with encrypted symlinks in send
  btrfs: decrypt file names for send
  btrfs: load the inode context before sending writes
  btrfs: set the appropriate free space settings in reconfigure
  btrfs: support encryption with log replay
  btrfs: disable auto defrag on encrypted files
  btrfs: disable encryption on RAID5/6
  btrfs: disable send if we have encryption enabled

Omar Sandoval (7):
  fscrypt: expose fscrypt_nokey_name
  btrfs: disable various operations on encrypted inodes
  btrfs: start using fscrypt hooks
  btrfs: add inode encryption contexts
  btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs: adapt readdir for encrypted and nokey names
  btrfs: implement fscrypt ioctls

Sweet Tea Dorminy (7):
  btrfs: disable verity on encrypted inodes
  btrfs: handle nokey names.
  btrfs: gate encryption behind BTRFS_DEBUG
  btrfs: add get_devices hook for fscrypt
  btrfs: set file extent encryption excplicitly
  btrfs: add fscrypt_info and encryption_type to extent_map
  btrfs: explicitly track file extent length for replace and drop

 Documentation/filesystems/fscrypt.rst |  41 ++
 block/blk-crypto-fallback.c           |  43 +++
 block/blk-crypto-internal.h           |   8 +
 block/blk-crypto-profile.c            |   2 +
 block/blk-crypto.c                    |   6 +-
 fs/btrfs/Kconfig                      |   3 +
 fs/btrfs/Makefile                     |   1 +
 fs/btrfs/accessors.h                  |  50 +++
 fs/btrfs/backref.c                    | 114 ++++--
 fs/btrfs/bio.c                        | 163 +++++++-
 fs/btrfs/bio.h                        |  16 +-
 fs/btrfs/btrfs_inode.h                |   3 +-
 fs/btrfs/compression.c                |   9 +
 fs/btrfs/ctree.h                      |   5 +
 fs/btrfs/defrag.c                     |  18 +-
 fs/btrfs/delayed-inode.c              |  29 +-
 fs/btrfs/delayed-inode.h              |   6 +-
 fs/btrfs/dir-item.c                   | 108 +++++-
 fs/btrfs/dir-item.h                   |  11 +-
 fs/btrfs/disk-io.c                    |   3 +-
 fs/btrfs/extent_io.c                  | 120 +++++-
 fs/btrfs/extent_io.h                  |   3 +
 fs/btrfs/extent_map.c                 | 104 ++++-
 fs/btrfs/extent_map.h                 |  26 ++
 fs/btrfs/file-item.c                  |  33 +-
 fs/btrfs/file-item.h                  |   7 +-
 fs/btrfs/file.c                       |  12 +-
 fs/btrfs/fs.h                         |   6 +-
 fs/btrfs/fscrypt.c                    | 423 ++++++++++++++++++++
 fs/btrfs/fscrypt.h                    | 116 ++++++
 fs/btrfs/inode.c                      | 529 ++++++++++++++++++++------
 fs/btrfs/ioctl.c                      |  69 ++--
 fs/btrfs/ordered-data.c               |  36 +-
 fs/btrfs/ordered-data.h               |  21 +-
 fs/btrfs/reflink.c                    |   8 +
 fs/btrfs/root-tree.c                  |   8 +-
 fs/btrfs/root-tree.h                  |   2 +-
 fs/btrfs/send.c                       | 140 ++++++-
 fs/btrfs/super.c                      | 106 +++++-
 fs/btrfs/super.h                      |   3 +-
 fs/btrfs/sysfs.c                      |   6 +
 fs/btrfs/tree-checker.c               |  66 +++-
 fs/btrfs/tree-log.c                   |  37 +-
 fs/btrfs/verity.c                     |   3 +
 fs/crypto/crypto.c                    |  10 +-
 fs/crypto/fname.c                     |  36 --
 fs/crypto/fscrypt_private.h           |  42 ++
 fs/crypto/hooks.c                     |  46 ++-
 fs/crypto/inline_crypt.c              |  84 +++-
 fs/crypto/keyring.c                   |  18 +-
 fs/crypto/keysetup.c                  | 166 ++++++++
 fs/crypto/policy.c                    |  47 +++
 include/linux/blk-crypto.h            |  15 +-
 include/linux/fscrypt.h               | 125 ++++++
 include/uapi/linux/btrfs.h            |   1 +
 include/uapi/linux/btrfs_tree.h       |  35 +-
 56 files changed, 2798 insertions(+), 350 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

-- 
2.43.0


