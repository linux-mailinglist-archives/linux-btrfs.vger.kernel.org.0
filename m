Return-Path: <linux-btrfs+bounces-9863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CE9D6EAC
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D1616315F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0751D5CC5;
	Sun, 24 Nov 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbg7qmAl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC61D5AB8;
	Sun, 24 Nov 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452093; cv=none; b=DeFUGUzF9KrjfxbDz3U7LgApFFg3Ym6+a8v2EoyhhtuPymvVQeEgqfAi39adchKB4zfDGbi32I2feOAsgmgVYPvv7RE7aEWAsMtllSjewfxFW4B3hfS/A2pSTNySxF8lv473cUj+4e6EjSZ+iFcRtyKDeVC3Y4daRz18kvdH1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452093; c=relaxed/simple;
	bh=6I4ppsJNqSfZDmqeUPufxjul3KL2provB5uRQbwLZz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak9ZzFIAT8YyC9IQmQYQ+4UG65xP+FssHItqKsoUvqsSf63K9VXEhrKsyRceaP/kzWA17P9jrsQh/aK95WNodVBq9n62OCRCqknfiJSgWdeROKe2Q2HIYAIHhg1gIyN4vyCiWGBD0SBN1C8Rg9S0U1v42vYSNlc1TBpqUFPYGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbg7qmAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC40C4CED1;
	Sun, 24 Nov 2024 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452093;
	bh=6I4ppsJNqSfZDmqeUPufxjul3KL2provB5uRQbwLZz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jbg7qmAlZZ7XUU5XKXExucZn8ZcIRaK5h2zTT8HvtdfKHmjgzxaA8WGxGyE33dAnm
	 9nliN4qtsR5wJTtUVsj85qDQ1imZmQBmZYoTol8eCfl2GDNp80m2glNzpCgn10jAXU
	 CyOko+q/65IIFOQod/XQiw2RvZKdUciCYa2BcWn7xF/gi2MApyIg2gFndSz+sOY5JC
	 Hn2nOBzGy7+dZcc0rcitErC4muDQzs6Q9htIkWf7oRCCps2QcSAxEezrdjQ9nrvfHj
	 QqLwDmhCQ2u3LJND5joukbB0xg2WZt+Nee3sOCPrX4+fgkm1gnAP4bUZEWpNTKMyMK
	 O/R58olmu9gAA==
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
Subject: [PATCH AUTOSEL 6.1 3/7] btrfs: avoid unnecessary device path update for the same device
Date: Sun, 24 Nov 2024 07:41:14 -0500
Message-ID: <20241124124126.3336691-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124126.3336691-1-sashal@kernel.org>
References: <20241124124126.3336691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 8c7e74499ed17..9779ab410f8fa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -671,6 +671,42 @@ u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
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
@@ -889,7 +925,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				disk_super->fsid, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || !is_same_device(device, path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
-- 
2.43.0


