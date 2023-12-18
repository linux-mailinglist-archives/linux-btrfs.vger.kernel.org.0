Return-Path: <linux-btrfs+bounces-1005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A08165BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 05:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479D9B210D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CB63BA;
	Mon, 18 Dec 2023 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6e07KHJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0695680
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jGpmtEB+cn2F/3PfIxw2xWkhull+ZgQeedcokwukZ0w=; b=B6e07KHJL7rSr5IjVFnr6f2eTP
	PHRu/ZR3qwVZfzo/E8HNV3qb1k4YYUlLlP3VgjwmUyMN16NwJizhbeXmwZgtG8IG4MraD7wbfeoMJ
	WKajxRh10BZWJxV72sII2Yrj/rfBujGW0QGkfKhvMHr7g7aQIqVQAo0KBVMxuJNldsJ3dgXw98Z8Y
	DY0Th/t8Oqv+LWe8QqPyjYnfm5z7EbBZFCdAIt2SG59wh+M+4lqU99CMY/SsmDK20GFQhX8+F99D0
	gFWS9cWqs6MfHphZQFOZ9yTkjX1/w00JZv78kdxtviT8fEAIug8Oq1wxS2/PfKIUoJTAKtaj7kAzO
	GV0M2xyw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF5ZS-0094Dh-1P;
	Mon, 18 Dec 2023 04:49:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/5] btrfs: always open the device read-only in btrfs_scan_one_device
Date: Mon, 18 Dec 2023 05:49:29 +0100
Message-Id: <20231218044933.706042-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218044933.706042-1-hch@lst.de>
References: <20231218044933.706042-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

btrfs_scan_one_device opens the block device only to read the super
block.  Instead of passing a blk_mode_t argument to sometimes open
it for writing, just hard code BLK_OPEN_READ as it will never write
to the device or hand the block_device out to someone else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c   | 9 ++++-----
 fs/btrfs/volumes.c | 4 ++--
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3a677b808f0f75..ba16ade1d79aea 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -295,10 +295,9 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_device: {
 		struct btrfs_device *device;
-		blk_mode_t mode = sb_open_mode(fc->sb_flags);
 
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(param->string, mode, false);
+		device = btrfs_scan_one_device(param->string, false);
 		mutex_unlock(&uuid_mutex);
 		if (IS_ERR(device))
 			return PTR_ERR(device);
@@ -1796,7 +1795,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
 	 * either a valid device or an error.
 	 */
-	device = btrfs_scan_one_device(fc->source, mode, true);
+	device = btrfs_scan_one_device(fc->source, true);
 	ASSERT(device != NULL);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
@@ -2198,7 +2197,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2216,7 +2215,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
 			ret = PTR_ERR(device);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4c32497311d2ff..02b61757798366 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1310,7 +1310,7 @@ int btrfs_forget_devices(dev_t devt)
  * the device or return an error. Multi-device and seeding devices are registered
  * in both cases.
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev)
 {
 	struct btrfs_super_block *disk_super;
@@ -1339,7 +1339,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_handle = bdev_open_by_path(path, flags, NULL, NULL);
+	bdev_handle = bdev_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
 	if (IS_ERR(bdev_handle))
 		return ERR_CAST(bdev_handle);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da779..3d35c4b92efb94 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -642,7 +642,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.39.2


