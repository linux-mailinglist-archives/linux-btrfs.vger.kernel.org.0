Return-Path: <linux-btrfs+bounces-9855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750A9D6E71
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2234A16282A
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30F1BCA1C;
	Sun, 24 Nov 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Hmxp72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F521BBBEE;
	Sun, 24 Nov 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452035; cv=none; b=ev79qsV8lloKPKmA3jRMh9FvDLeY9MG+l3gKS5vTeo/jh/WiDh7pZrlSXEUAvfm+cofVYwOApyTvCyIyAzU1QXm44K3RIbc0zaNiz6lXLchOQsa+WNxeAQm8+CD/UpAKob65lzbJGX3+PTnrOMQScbpejMOtX4WamCLZguuexgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452035; c=relaxed/simple;
	bh=4IMKq9Z3YSIHqCL7pYwtSXWBoL/aLGKCfBFOboQK908=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlvgZq5BG0McxwzRXBvjWb+pHdYCZqoMYPo+hVSBSp17FsTrB9KNdQnZ5/a1d8+JnB3R2iPFfBYgLp/EC+n6pNxlvUiVBt9CQ+UmWuaOSxJdC9Eu0djOlq1Y4ITek768AnbsvndMOh2hgiVRVnui6NdAs7h2V91Zsugc/KPVmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Hmxp72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C90C4CED6;
	Sun, 24 Nov 2024 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452034;
	bh=4IMKq9Z3YSIHqCL7pYwtSXWBoL/aLGKCfBFOboQK908=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4Hmxp72Kk67qZPvJSIpO0u6FZ/95PJdtPXL/ON0LcYGjjRKBIDROPjM0AkQMdKe7
	 sY2tYWEpt7x7XFVJ5mRQW9uHe+mD9f6nbDNbQe0HzyoOz0xN7ELsDGzuKEnNWyLsnJ
	 qANpP2ZQ0BweZQqU5nA54vDKRBpTbBCDR+Y+yu4nLVWJ1oneJsEsh/UIBxZBD07vED
	 jAAqADqGIjAgLfUBAk2g/LKjRxro+lFc3RqXOzOiLSUJtuI3uIqqSDC9z3NmD/Qy6y
	 VHEdPAJEihD4xjWYAiwpW4oKR72m1+8m/TpZ3UW/jtPZUPBssa8ici5WKyCkCOHDAw
	 C5/qGsczJjbOA==
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
Subject: [PATCH AUTOSEL 6.11 10/16] btrfs: canonicalize the device path before adding it
Date: Sun, 24 Nov 2024 07:39:47 -0500
Message-ID: <20241124124009.3336072-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7e06de7c83a746e58d4701e013182af133395188 ]

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
"/dev/test/scratch1" which is another symlink pointing to "/dev/dm-2".

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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
Reported-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 87 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bcb7f288510f0..a06d530835d4e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -730,6 +730,78 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
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
+	if (!dev_path)
+		goto out;
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
+	if (!dev_path) {
+		ret = -EINVAL;
+		goto out;
+	}
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
@@ -1417,12 +1489,23 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
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
@@ -1467,7 +1550,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto free_disk_super;
 	}
 
-	device = device_list_add(path, disk_super, &new_device_added);
+	device = device_list_add(canonical_path ? : path, disk_super,
+				 &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -1476,6 +1560,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 error_bdev_put:
 	fput(bdev_file);
+	kfree(canonical_path);
 
 	return device;
 }
-- 
2.43.0


