Return-Path: <linux-btrfs+bounces-14601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF3AD50D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25B43A7A3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA58263C91;
	Wed, 11 Jun 2025 10:03:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C326463A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636206; cv=none; b=YEk4RFFcKpscWk/CYXNNaJjNoPYTAsaKaJZAzkLE18XSl6R6OWKukWGt5ijClRh9bWQarMi1CFgu/gFtIAwbn/WwNoBxzLejHPC5eHCXVqu0G8UH0j8x3WLo414Zpd25aNUcZijjjQZZELBQ78cUckD6wBljHHFLvRA2SaBqBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636206; c=relaxed/simple;
	bh=+TSGp1kUx2hMUSGSCH7U8oM9BajjKhR/YDIdqkrCfYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNmaG4aTMmh8ODz7Q/uMVnhyohDR7msF+k2vC4Lb4LneHtix4TfyviKdEopXsCaFwksegyLIV9ujkkmtdBKZUvyqRxkc99tcCezOI/eNEBl58GtMjwi0sDzlF92tw8fyvpyg/o0ZiFfqmpdhgLnMOnc5SLn0DRa9E2hRS81Jxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a53359dea5so2847488f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 03:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636203; x=1750241003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmo6/Ig4UqEJHwdWeiC13CUSMhP9Oi1ZT/FxtiysYdU=;
        b=MXsB3J45jpebNQ5pmG4bdfAjdLhn5CmG56IT6HoFykoJs18P66w0CPrHVFEpqQ+wU2
         oQmfPPo0BR8zoPqkklgZCPtNfAaOxhZPDeNf+WV5uv2Jfcrn/hCHkcf1sBnMI0RX3Do4
         00ypM5Zsf/4/BzW4qtIHdPv++Qh/tmJGgftKP6T4Nf3wYVgltSftkY3wJ/rExutabfG/
         ZLmLQn31y4BIqyV/4+cY6Zjwjm16T3zw/Lt0jGT34zlmXhGB/ODhnnHYZyLebc5dzjBt
         pkKE3JpM/4kIxaxs25BjunEwh06b2ywIYC/MmuMyYxrTkQ0seGvHxBbmKGTGMdFp0p0k
         FXBg==
X-Gm-Message-State: AOJu0YyYgge93iA0ovjAGA5lXwppHV/i4Ps3WGq68eESBqDDj77VYaFf
	cc49NPeGJS4UMA9cXoVnZhYC2WNY/xrwJVN4oDVmQB6Xke2WO6LHT2JMNe6aDw==
X-Gm-Gg: ASbGnctoOK4153Bak0tGsbAV446gPAil4Qcl1cChF8j3Ef7G96w/L9TDbFQSjddaNq1
	4QW3F8W9selnO/1b1I35J9aNZicdHwrm4RXJymyCgBzUr/Vx5vb7fWhBbbhLKlVagaIcPveSqvN
	k4xGdywJgsmgUt1TMCneuWkxw7tOBNxkUZ9cVDhDarA4PGG6RVexkRVoSHCfPqDsYO9fLsPpx2q
	tVjjUUdQym1JcjXeCg0ovscr0Hh7i20adYhLfrB8fbCWo43+yqKsMIU6nZR9+KUCjLRh3s699S8
	Z7Ph015DxGv0uBKWsIX1KoVvbmQvjIrL6vaOeg6YCdscopqUyk7VgaYrilmSuC7TrNYZfU5IH9t
	CnqHlky9n3Nj1/P72ejP6ySDMyRzc/GkQi61CofijxsAJ9CjszQ==
X-Google-Smtp-Source: AGHT+IEoQII/x3NfqGi76o+S8CB3V0EMiWwI0SfDd/iEMuYjvsqG9fu6w0uR8AmfQhytltj2CTVfBA==
X-Received: by 2002:a05:6000:220d:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3a558a32568mr1983070f8f.31.1749636203028;
        Wed, 11 Jun 2025 03:03:23 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm14654274f8f.83.2025.06.11.03.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/5] btrfs: open block devices after superblock creation
Date: Wed, 11 Jun 2025 12:03:02 +0200
Message-ID: <20250611100303.110311-5-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100303.110311-1-jth@kernel.org>
References: <20250611100303.110311-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Currently btrfs_mount_root opens the block devices before committing to
allocating a super block. That creates problems for restricting the
number of writers to a device, and also leads to a unusual and not very
helpful holder (the fs_type).

Reorganize the code to first check whether the superblock for a
particular fsid does already exist and open the block devices only if it
doesn't, mirroring the recent changes to the VFS mount helpers.  To do
this the increment of the in_use counter moves out of btrfs_open_devices
and into the only caller in btrfs_mount_root so that it happens before
dropping uuid_mutex around the call to sget.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c   | 40 +++++++++++++++++++++++++---------------
 fs/btrfs/volumes.c | 15 +++++----------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eaecf1525078..eafa524c7c81 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1841,7 +1841,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_devices *fs_devices = NULL;
-	struct block_device *bdev;
 	struct btrfs_device *device;
 	struct super_block *sb;
 	blk_mode_t mode = btrfs_open_mode(fc);
@@ -1864,15 +1863,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
-	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+	fs_devices->in_use++;
 	mutex_unlock(&uuid_mutex);
-	if (ret)
-		return ret;
-
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
-		return -EACCES;
-
-	bdev = fs_devices->latest_dev->bdev;
 
 	/*
 	 * From now on the error handling is not straightforward.
@@ -1896,23 +1888,41 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * mismatch and reconfigure with sb->s_umount rwsem held if
 		 * needed.
 		 */
-		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
+		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY) {
 			ret = -EBUSY;
+			goto error_deactivate;
+		}
 	} else {
-		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
+		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+		mutex_lock(&uuid_mutex);
+		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		mutex_unlock(&uuid_mutex);
+		if (ret)
+			goto error_deactivate;
+
+		if (!(fc->sb_flags & SB_RDONLY) && !fs_devices->rw_devices) {
+			ret = -EACCES;
+			goto error_deactivate;
+		}
+
+		snprintf(sb->s_id, sizeof(sb->s_id), "%pg",
+			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices);
-		if (ret) {
-			deactivate_locked_super(sb);
-			return ret;
-		}
+		if (ret)
+			goto error_deactivate;
 	}
 
 	btrfs_clear_oneshot_options(fs_info);
 
 	fc->root = dget(sb->s_root);
 	return 0;
+
+error_deactivate:
+	deactivate_locked_super(sb);
+	return ret;
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 00b64f98e3bd..3e219a1a4c75 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1301,8 +1301,6 @@ static int devid_cmp(void *priv, const struct list_head *a,
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder)
 {
-	int ret;
-
 	lockdep_assert_held(&uuid_mutex);
 	/*
 	 * The device_list_mutex cannot be taken here in case opening the
@@ -1311,14 +1309,11 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	 * We also don't need the lock here as this is called during mount and
 	 * exclusion is provided by uuid_mutex
 	 */
-	if (!fs_devices->is_open) {
-		list_sort(NULL, &fs_devices->devices, devid_cmp);
-		ret = open_fs_devices(fs_devices, flags, holder);
-		if (ret)
-			return ret;
-	}
-	fs_devices->in_use++;
-	return 0;
+	ASSERT(fs_devices->in_use);
+	if (fs_devices->is_open)
+		return 0;
+	list_sort(NULL, &fs_devices->devices, devid_cmp);
+	return open_fs_devices(fs_devices, flags, holder);
 }
 
 void btrfs_release_disk_super(struct btrfs_super_block *super)
-- 
2.49.0


