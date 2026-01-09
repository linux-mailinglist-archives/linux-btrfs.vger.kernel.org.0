Return-Path: <linux-btrfs+bounces-20318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9084BD07353
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 06:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AACB301CEBB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 05:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D71DE8BF;
	Fri,  9 Jan 2026 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gUWvGc7R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gUWvGc7R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F650097D
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936710; cv=none; b=JPDV0YelUD33NUYZTA2PyfLPnombakrs4tDULrqxRkTEJ7LV8e3mfonirfnBm1McY423IWlbTTcPwHncQrVTo2FGW7nw0lI5M0s4+UcG9xjt6QhyP9q0FjtGzdfi23nQE9XS6+Cux0irOnTFLw3NYyFoyHo/+GmIRNwuccV3Xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936710; c=relaxed/simple;
	bh=Oyx6/uwLyXEJdmXe2od27YpOv5d/npkUBMvyRpP50wQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2/BuvQFVl5iG3lVOU4OcQFFS3N9e8d9/EWhCtVIYvpddgbO+k9IsRu0HPDwKojFZHt5fnfuyjgQQGWXgWfe/5DNBKY1nK6fd78udBH7+U5h4OeYW7WdbuJEl3G3QhiF0SAiV4Kn9Nk3guko7KSfC70PPqqJlmS22dY/Dmo2pZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gUWvGc7R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gUWvGc7R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1951D347F0
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767936697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3MeSmHO5XbQ+RBCpDQ/Ymg6KGv6jdg3B9OAy+UJonI=;
	b=gUWvGc7R0F/AMuyp/plcFlOopQXjIYsPR+KZ0KCp01n9+hMTM/JVVhYhAX/7F4o3asA2oD
	Sz2vUWXN+HKKN/Zv/uaq43NUAGRq1Y9Rmvdt9/TFUG42dxg6ioqRapdK3G01Gk8ZdU1cbZ
	Q4jneJJoIGNach//+0BEyIuKePxXV3o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gUWvGc7R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767936697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3MeSmHO5XbQ+RBCpDQ/Ymg6KGv6jdg3B9OAy+UJonI=;
	b=gUWvGc7R0F/AMuyp/plcFlOopQXjIYsPR+KZ0KCp01n9+hMTM/JVVhYhAX/7F4o3asA2oD
	Sz2vUWXN+HKKN/Zv/uaq43NUAGRq1Y9Rmvdt9/TFUG42dxg6ioqRapdK3G01Gk8ZdU1cbZ
	Q4jneJJoIGNach//+0BEyIuKePxXV3o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50AF53EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +D3KBLiSYGk9IQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 05:31:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: mkfs: optimise the block group discarding behavior
Date: Fri,  9 Jan 2026 16:01:15 +1030
Message-ID: <1f1f133666434bdea42653274cda7d2bd528a897.1767936141.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767936141.git.wqu@suse.com>
References: <cover.1767936141.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 1951D347F0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

[PERFORMANCE REGRESSION]
After commit 4b861c186592 ("btrfs-progs: mkfs: discard free space"),
mkfs.btrfs is much slower in my VM, where /dev/test/scratch1 is an LV
from a virtio-blk device.
The virtio-blk device is backed by a file on ext4, and discard behavior
is already set to "ignore".

Good: (at 4b861c186592~1)

 $ time ./mkfs.btrfs  -f /dev/test/scratch1
 real	0m0.016s
 user	0m0.004s
 sys	0m0.007s

Bad: (at 4b861c186592)
 $ time mkfs.btrfs  -f /dev/test/scratch1
 real	0m0.782s
 user	0m0.012s
 sys	0m0.313s

The delay is enough to drive an impatient person (like me) crazy.

[CAUSE]
The idea of that commit is completely fine, and I see no problem in the
code itself.

However the problem is in the way we submit discard commands.

For the default mkfs profiles, we are using DUP for single device fses or
RAID1 for multi-device fses.

Especially for DUP, we will submit two discard commands to the same
device, but to different physical locations.
This makes the discard of metadata block groups more like some random
writes, as we have to switch between different device extents.

From my tests, that's the root cause, and if we re-order all those
discards into a more sequential submission, mkfs will become blazing
fast again.

[FIX]
Instead of submitting discard request for each hole we find, queue all
those per-device request into a cache_tree, which will merge any
adjacent ranges, and provide a proper sequential way to iterate each
range.

With this new optimization, the runtime is back to the <0.02 s range:

 $ time ./mkfs.btrfs  -f /dev/test/scratch1
 real	0m0.019s
 user	0m0.006s
 sys	0m0.007s

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/volumes.c |  4 +++
 kernel-shared/volumes.h |  3 ++
 mkfs/main.c             | 70 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 0a7301281470..b4093e0249e4 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -554,6 +554,7 @@ static int device_list_add(const char *path,
 			/* we can safely leave the fs_devices entry around */
 			return -ENOMEM;
 		}
+		cache_tree_init(&device->discard);
 		device->fd = -1;
 		device->devid = devid;
 		device->generation = found_transid;
@@ -643,6 +644,7 @@ again:
 		}
 		device->writeable = 0;
 		list_del(&device->dev_list);
+		free_extent_cache_tree(&device->discard);
 		/* free the memory */
 		kfree(device->name);
 		kfree(device->label);
@@ -2388,6 +2390,7 @@ static struct btrfs_device *fill_missing_device(u64 devid, const u8 *uuid)
 
 	device = kzalloc(sizeof(*device), GFP_NOFS);
 	device->devid = devid;
+	cache_tree_init(&device->discard);
 	memcpy(device->uuid, uuid, BTRFS_UUID_SIZE);
 	device->fd = -1;
 	return device;
@@ -2561,6 +2564,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device)
 			return -ENOMEM;
+		cache_tree_init(&device->discard);
 		device->fd = -1;
 		list_add(&device->dev_list,
 			 &fs_info->fs_devices->devices);
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 74fccd147d82..60ca4593a108 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -39,6 +39,9 @@ struct btrfs_device {
 	struct btrfs_fs_devices *fs_devices;
 	struct btrfs_fs_info *fs_info;
 
+	/* Record the ranges that needs to be discarded during mkfs. */
+	struct cache_tree discard;
+
 	u64 total_ios;
 
 	int fd;
diff --git a/mkfs/main.c b/mkfs/main.c
index ce85d34f077a..58e9b57b4c9f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1280,6 +1280,68 @@ cleanup:
 	return ret;
 }
 
+static int queue_discard_logical(struct btrfs_fs_info *fs_info, u64 start, u64 len)
+{
+	struct btrfs_multi_bio *multi = NULL;
+	int ret;
+	u64 cur_offset = 0;
+	u64 cur_len = 0;
+
+	while (cur_offset < len) {
+		struct btrfs_device *device;
+
+		cur_len = len - cur_offset;
+		ret = btrfs_map_block(fs_info, WRITE, start + cur_offset, &cur_len,
+				      &multi, 0, NULL);
+		if (ret)
+			return ret;
+
+		if (multi->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+			free(multi);
+			break;
+		}
+
+		cur_len = min(cur_len, len - cur_offset);
+
+		for (int i = 0; i < multi->num_stripes; i++) {
+			device = multi->stripes[i].dev;
+
+			ret = add_merge_cache_extent(&device->discard,
+					multi->stripes[i].physical, cur_len);
+			if (ret < 0) {
+				free(multi);
+				return ret;
+			}
+		}
+		free(multi);
+		multi = NULL;
+		cur_offset += cur_len;
+	}
+	return 0;
+}
+
+static int discard_all_devices(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_device *dev;
+
+	list_for_each_entry(dev, &fs_info->fs_devices->devices, dev_list) {
+
+		if (!dev->writeable)
+			continue;
+		for (struct cache_extent *cache = first_cache_extent(&dev->discard);
+		     cache; cache = next_cache_extent(cache)) {
+			int ret;
+
+			ret = device_discard_blocks(dev->fd, cache->start, cache->size);
+			if (ret == EOPNOTSUPP)
+				return 0;
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static int discard_free_space(struct btrfs_fs_info *fs_info, u64 metadata_profile)
 {
 	struct btrfs_root *free_space_root;
@@ -1329,7 +1391,7 @@ static int discard_free_space(struct btrfs_fs_info *fs_info, u64 metadata_profil
 		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
 
 		if (key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
-			ret = discard_logical_range(fs_info, key.objectid, key.offset);
+			ret = queue_discard_logical(fs_info, key.objectid, key.offset);
 			if (ret < 0)
 				goto out;
 		} else if (key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
@@ -1358,7 +1420,7 @@ static int discard_free_space(struct btrfs_fs_info *fs_info, u64 metadata_profil
 				addr = key.objectid + (start_bit * fs_info->sectorsize);
 				length = (end_bit - start_bit) * fs_info->sectorsize;
 
-				ret = discard_logical_range(fs_info, addr, length);
+				ret = queue_discard_logical(fs_info, addr, length);
 				if (ret < 0) {
 					free(bitmap);
 					goto out;
@@ -1372,8 +1434,10 @@ static int discard_free_space(struct btrfs_fs_info *fs_info, u64 metadata_profil
 
 		path.slots[0]++;
 	}
+	btrfs_release_path(&path);
 
-	ret = 0;
+	/* Every discard range is properly queued. Now submit the real discard request. */
+	return discard_all_devices(fs_info);
 
 out:
 	btrfs_release_path(&path);
-- 
2.52.0


