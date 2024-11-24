Return-Path: <linux-btrfs+bounces-9866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79E9D6EAD
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA7B25CAF
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227991DD520;
	Sun, 24 Nov 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrqoicLS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A81DB377;
	Sun, 24 Nov 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452117; cv=none; b=G13QsbdJe0tUG09XsphiC7IVW3efPv/gD4oIcHeuhLV1beDlR1LD/Xe65A88TcPoQHaUuQo5O1KFzSmMgxStwg0mcqshj0c529dWLOV+wOG2LVk9XhenGeb06qU2s0h2tsCUhno+zvndRVz2D8laqfGZY46lp79lJNssKoIkBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452117; c=relaxed/simple;
	bh=Fc+J3Xuj6IZqP09rAOh+c2pGGsVqwtgUToUQ5wc77gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsUOYq1FXnvAXpnv+51HJ1k5+ipPpztgYQ4a/tgfkga1EREHqB+gfN0piZ4sOmZbpWJlSOjWDbOByNpEhqOljYt0GBb9OeF8j2/nXhjXO7utUTQ9Fnwk6Wm9whnP51J9VqNKs9f8geQ3Aj6ns8LymwY+Tue2nEGwZjKjZoEm5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrqoicLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE9EC4CED1;
	Sun, 24 Nov 2024 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452117;
	bh=Fc+J3Xuj6IZqP09rAOh+c2pGGsVqwtgUToUQ5wc77gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrqoicLS8W3oVCSFFE9mx/gItSz85PfLdkVP8LdGy4JZeHLI74i+eKe6+PEZ3qREO
	 Ptt61reTNenpT2uDKmW0vnvFabJ1HwoU8UsXYEjWEZqh5ER0qnHS4uyYZCgsk0+o0o
	 BnGR+AqHflej6E+og7hgIarLwr05cwnUzk9EOhSRme2dexvDzGOz3CR7Qs+U8M20SE
	 oPV42DuMgYLoAZAcLWj9f1GX8ghpxy/GY2x7kW3TCafdWPFWAQRUwOG+WEyImKsEYg
	 60ftnPI1sbyZvDGNqFSV5XHVfTetkff1TPwh0Pw//X/U/B2Z27SyzsVPyJxGNnCEPd
	 zuiTvzVO5VBkg==
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
Subject: [PATCH AUTOSEL 5.15 3/6] btrfs: avoid unnecessary device path update for the same device
Date: Sun, 24 Nov 2024 07:41:39 -0500
Message-ID: <20241124124149.3336868-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124149.3336868-1-sashal@kernel.org>
References: <20241124124149.3336868-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index b5e2daf538d49..c0fcac0a1b8e4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -717,6 +717,42 @@ u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
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
@@ -922,7 +958,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				disk_super->fsid, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || !is_same_device(device, path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
-- 
2.43.0


