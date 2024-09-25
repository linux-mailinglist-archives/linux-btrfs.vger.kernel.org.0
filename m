Return-Path: <linux-btrfs+bounces-8210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E58C984F51
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 02:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D85B22A88
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 00:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A55234;
	Wed, 25 Sep 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f/jQd8H1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f/jQd8H1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15036B
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222787; cv=none; b=otbraSmWOmW7x7263Wg5jgZFPAQFfJ05VolGOxYEf5Rb5GObcqm56SGNWVqzY0Ul5NCpQ/MRMjqQ14PIJNkgR8SVKVjEP8ROH6JRrecxjakK3XgOHpkcEARLEbmm6/usw3g25mv/nI/i79YLQqY+8r30MwHxhUwKCmqzK5PN00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222787; c=relaxed/simple;
	bh=dQL4ddH+wOxlhxtxXcsmbOexwOB0AxAazW66d0bXOis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwX/SqZfX8D2sD/7+EMTRh92ei9qoxLQHN0hCVbBNTol97CHtlthKXoe/Gt/L2z9VGWZ8mopo+cy6AvlW27eCzphs8rcSayNc8w6I+C2GIXuKei/wKyPtfZaENakm8zULxCt0Rj9tnaej8XLAeB91t8vAIVqLlDPb1sw/F2PHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f/jQd8H1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f/jQd8H1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25C0421A19;
	Wed, 25 Sep 2024 00:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727222782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2SFqcQJU1+uTXmpLkBX8Kuq5ghwZg5hNWrxo5X8sNI=;
	b=f/jQd8H1U6a73yTUuUWz71w2aOxQwrnQF3H36cAtkatp6ZyQehGZGqOXCkD2DmnrplMIcJ
	hSs5s8qcX4BdqbxollPWtwzXdKFO850CTuoSxP2r7UtdAwjBfKS9UujCUvkaNgnJfvLN39
	GLhj31IK85xVUB8KlqyphU+EXvTrTzk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="f/jQd8H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727222782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2SFqcQJU1+uTXmpLkBX8Kuq5ghwZg5hNWrxo5X8sNI=;
	b=f/jQd8H1U6a73yTUuUWz71w2aOxQwrnQF3H36cAtkatp6ZyQehGZGqOXCkD2DmnrplMIcJ
	hSs5s8qcX4BdqbxollPWtwzXdKFO850CTuoSxP2r7UtdAwjBfKS9UujCUvkaNgnJfvLN39
	GLhj31IK85xVUB8KlqyphU+EXvTrTzk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1338213A66;
	Wed, 25 Sep 2024 00:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IE5RMfxT82a1AgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 25 Sep 2024 00:06:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Fabian Vogt <fvogt@suse.com>
Subject: [PATCH v2 2/2] btrfs: canonicalize the device path before adding it
Date: Wed, 25 Sep 2024 09:36:00 +0930
Message-ID: <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727222308.git.wqu@suse.com>
References: <cover.1727222308.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25C0421A19
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:url,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[PROBLEM]
Currently btrfs accepts any file path for its device, resulting some
weird situation:

 # ./mount_by_fd /dev/test/scratch1  /mnt/btrfs/

The program has the following source code:

 #include <fcntl.h>
 #include <stdio.h>
 #include <sys/mount.h>

 int main(int argc, char *argv[]) {
	int fd = open(argv[1], O_RDWR);
	char path[256];
	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
	return mount(path, argv[2], "btrfs", 0, NULL);
 }

Then we can have the following weird device path:

 BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 transid 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)

Normally it's not a big deal, and later udev can trigger a device path
rename. But if udev didn't trigger, the device path "/proc/self/fd/3"
will show up in mtab.

[CAUSE]
For filename "/proc/self/fd/3", it means the opened file descriptor 3.
In above case, it's exactly the device we want to open, aka points to
"/dev/test/scratch1" which is another softlink pointing to "/dev/dm-2".

Inside kernel we solve the mount source using LOOKUP_FOLLOW, which
follows the symbolic link and grab the proper block device.

But inside btrfs we also save the filename into btrfs_device::name, and
utilize that member to report our mount source, which leads to the above
situation.

[FIX]
Instead of unconditionally trust the path, check if the original file
(not following the symbolic link) is inside "/dev/", if not, then
manually lookup the path to its final destination, and use that as our
device path.

This allows us to still use symbolic links, like
"/dev/mapper/test-scratch" from LVM2, which is required for fstests runs
with LVM2 setup.

And for really weird names, like the above case, we solve it to
"/dev/dm-2" instead.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
Reported-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b713e4ebb362..668138451f7c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
+/*
+ * We can have very weird soft links passed in.
+ * One example is "/proc/self/fd/<fd>", which can be a soft link to
+ * a block device.
+ *
+ * But it's never a good idea to use those weird names.
+ * Here we check if the path (not following symlinks) is a good one inside
+ * "/dev/".
+ */
+static bool is_good_dev_path(const char *dev_path)
+{
+	struct path path = { .mnt = NULL, .dentry = NULL };
+	char *path_buf = NULL;
+	char *resolved_path;
+	bool is_good = false;
+	int ret;
+
+	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!path_buf)
+		goto out;
+
+	/*
+	 * Do not follow soft link, just check if the original path is inside
+	 * "/dev/".
+	 */
+	ret = kern_path(dev_path, 0, &path);
+	if (ret)
+		goto out;
+	resolved_path = d_path(&path, path_buf, PATH_MAX);
+	if (IS_ERR(resolved_path))
+		goto out;
+	if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
+		goto out;
+	is_good = true;
+out:
+	kfree(path_buf);
+	path_put(&path);
+	return is_good;
+}
+
+static int get_canonical_dev_path(const char *dev_path, char *canonical)
+{
+	struct path path = { .mnt = NULL, .dentry = NULL };
+	char *path_buf = NULL;
+	char *resolved_path;
+	int ret;
+
+	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!path_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
+	if (ret)
+		goto out;
+	resolved_path = d_path(&path, path_buf, PATH_MAX);
+	ret = strscpy(canonical, resolved_path, PATH_MAX);
+out:
+	kfree(path_buf);
+	path_put(&path);
+	return ret;
+}
+
 static bool is_same_device(struct btrfs_device *device, const char *new_path)
 {
 	struct path old = { .mnt = NULL, .dentry = NULL };
@@ -1408,12 +1472,23 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
+	char *canonical_path = NULL;
 	u64 bytenr;
 	dev_t devt;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
 
+	if (!is_good_dev_path(path)) {
+		canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (canonical_path) {
+			ret = get_canonical_dev_path(path, canonical_path);
+			if (ret < 0) {
+				kfree(canonical_path);
+				canonical_path = NULL;
+			}
+		}
+	}
 	/*
 	 * Avoid an exclusive open here, as the systemd-udev may initiate the
 	 * device scan which may race with the user's mount or mkfs command,
@@ -1458,7 +1533,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto free_disk_super;
 	}
 
-	device = device_list_add(path, disk_super, &new_device_added);
+	device = device_list_add(canonical_path ? : path, disk_super,
+				 &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -1467,6 +1543,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 error_bdev_put:
 	fput(bdev_file);
+	kfree(canonical_path);
 
 	return device;
 }
-- 
2.46.1


