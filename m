Return-Path: <linux-btrfs+bounces-9860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A59D6E87
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC136281614
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237E1D2B13;
	Sun, 24 Nov 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQlvL/R0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092F1D0E20;
	Sun, 24 Nov 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452069; cv=none; b=V+ZxAlOHdu3C3DD/mk/5ITX6cDCBpJHshhnJpDT2aEI5+RPersp63YK9LwJLaRAwQDLz0ttOCUterz7RIFQqSGO6jNw7TKtvz2hCsz52AAR91HesN7CseHmnVnyuv5R3F3yxV5A1njgN0+nnbbIPMrBm5JPWndv1pcVWcAtnKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452069; c=relaxed/simple;
	bh=RPt5+8s6ujwDfuNPt20TovcACE7aB3GKDaxSEJpy8WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icGWmzQ6neaOTYDEzr7M9UKNJojvTKRh+G433lsQU4L+GaTQQVsNl7qoGb2okfFkBZsUNPxU8bYJ7dAox9IAsrsWLa+8+121qgxD9uL46QW5m33kY5pRJ4bJTQn/5qSzjC/Q3v2SdTXHzaNFZ/R8YlfNbrTvM3DfRF/OxTLh3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQlvL/R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6ADC4CED1;
	Sun, 24 Nov 2024 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452069;
	bh=RPt5+8s6ujwDfuNPt20TovcACE7aB3GKDaxSEJpy8WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQlvL/R0SEyZq/JbCbEJWeM7En9gPWn7TRia3/p3O7YhdC0S9BbSBtTEa3mXEtjdv
	 fjnUuCi/eoWhd4vk+wZeMjMHebjwrCmbXP8H3ghmZHNZ6LYN7jXrcQWLXrlyBFFqUJ
	 kJKLyI6DcEtiee1N5BxeI5KT8+HuVkGBWQL+SCYK9538vQeBo4/wAw8Q9TW60YcA2O
	 ozLGQpIeQelAiK2mum/0H+9VHp8yqsERkTfWxKB+pDsORzbVp18ww3NkUH7s2QpHZp
	 aZuN5R6cIVgUSiNvni6Rr74S544v61+PzZHupsdaGKFpZMmm2qALOZizCZg72LzxXT
	 nI7atafhVnJ/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Fabian Vogt <fvogt@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 5/9] btrfs: avoid unnecessary device path update for the same device
Date: Sun, 24 Nov 2024 07:40:43 -0500
Message-ID: <20241124124057.3336453-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124057.3336453-1-sashal@kernel.org>
References: <20241124124057.3336453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 2e8b6bc0ab41ce41e6dfcc204b6cc01d5abbc952 ]

[PROBLEM]
It is very common for udev to trigger device scan, and every time a
mounted btrfs device got re-scan from different soft links, we will get
some of unnecessary device path updates, this is especially common
for LVM based storage:

 # lvs
  scratch1 test -wi-ao---- 10.00g
  scratch2 test -wi-a----- 10.00g
  scratch3 test -wi-a----- 10.00g
  scratch4 test -wi-a----- 10.00g
  scratch5 test -wi-a----- 10.00g
  test     test -wi-a----- 10.00g

 # mkfs.btrfs -f /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs
 # dmesg -c
 [  205.705234] BTRFS: device fsid 7be2602f-9e35-4ecf-a6ff-9e91d2c182c9 devid 1 transid 6 /dev/mapper/test-scratch1 (253:4) scanned by mount (1154)
 [  205.710864] BTRFS info (device dm-4): first mount of filesystem 7be2602f-9e35-4ecf-a6ff-9e91d2c182c9
 [  205.711923] BTRFS info (device dm-4): using crc32c (crc32c-intel) checksum algorithm
 [  205.713856] BTRFS info (device dm-4): using free-space-tree
 [  205.722324] BTRFS info (device dm-4): checking UUID tree

So far so good, but even if we just touched any soft link of
"dm-4", we will get quite some unnecessary device path updates.

 # touch /dev/mapper/test-scratch1
 # dmesg -c
 [  469.295796] BTRFS info: devid 1 device path /dev/mapper/test-scratch1 changed to /dev/dm-4 scanned by (udev-worker) (1221)
 [  469.300494] BTRFS info: devid 1 device path /dev/dm-4 changed to /dev/mapper/test-scratch1 scanned by (udev-worker) (1221)

Such device path rename is unnecessary and can lead to random path
change due to the udev race.

[CAUSE]
Inside device_list_add(), we are using a very primitive way checking if
the device has changed, strcmp().

Which can never handle links well, no matter if it's hard or soft links.

So every different link of the same device will be treated as a different
device, causing the unnecessary device path update.

[FIX]
Introduce a helper, is_same_device(), and use path_equal() to properly
detect the same block device.
So that the different soft links won't trigger the rename race.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
Reported-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 790e30e2101a6..fdd392334916f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -689,6 +689,42 @@ u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
+static bool is_same_device(struct btrfs_device *device, const char *new_path)
+{
+	struct path old = { .mnt = NULL, .dentry = NULL };
+	struct path new = { .mnt = NULL, .dentry = NULL };
+	char *old_path = NULL;
+	bool is_same = false;
+	int ret;
+
+	if (!device->name)
+		goto out;
+
+	old_path = kzalloc(PATH_MAX, GFP_NOFS);
+	if (!old_path)
+		goto out;
+
+	rcu_read_lock();
+	ret = strscpy(old_path, rcu_str_deref(device->name), PATH_MAX);
+	rcu_read_unlock();
+	if (ret < 0)
+		goto out;
+
+	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
+	if (ret)
+		goto out;
+	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
+	if (ret)
+		goto out;
+	if (path_equal(&old, &new))
+		is_same = true;
+out:
+	kfree(old_path);
+	path_put(&old);
+	path_put(&new);
+	return is_same;
+}
+
 /*
  * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
  * being created with a disk that has already completed its fsid change. Such
@@ -888,7 +924,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				disk_super->fsid, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || !is_same_device(device, path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
-- 
2.43.0


