Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029F216B845
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgBYD5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603028; x=1614139028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p76b2Z9W1j9sNe0wGDijDSAPLjG4vHyi/VECMPT1Duc=;
  b=bvPi3JaR4gBNASKqSnC0KEUJhn3QUUIW8al41uWjy7qoj6y1RE+nt6J1
   Tlh0ffhPZKfshN8NADQrtNb9bVFX6n+zASyAuZumCyp6k2lsaEfM7UGqr
   3U3kKh06VW19NmpoVqKnSjPtg0Bx66tfjkDpUj+N+xPJL5ib++Y2r99sX
   8Zx9GIs+P15OtubsrN6hNSpjhA3wF3qhuJNL79Y40141A2uPf1UWRdlMs
   NSmN4lt4CYfBZkx5fMPaNMlnSgcpqI23/koDe4zeOgmDF+GiGxhJZgVwT
   JNqkHQMMrAz0Lt/pfPufV0Z2cRCStm9g1zhMlCcf/Ywfoas9wIZbasNCa
   w==;
IronPort-SDR: qKRdP/wVg66FC74EQzf+D+BJCJvmbjIJN5jf3fxCOy1NzzPg8vu5kVd2KteeScaNIAVQK87X/g
 9f9OF5JSPG8qx28NWYyThdeJ5f/ZZWyh2hkVAJARWu4CBv/nob+b8XHudrsPOUdnrkN0K89Su7
 l8zPYUdUQJH763rdj9gOmBBReoeTAU/+ieT48FDxIPh4SlTWAzUjzSbk0OmjHED24srKCuJW6r
 wvEUmh1oi5juyt3RhytqmDsrzrMJ6VlwRoK15fEku9INaJyI/cneQkobIbBur+0QadaAbUHVCR
 KNE=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168277"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:00 +0800
IronPort-SDR: P0iy3/Z6ZKKVTte6G8eNRqQkaJnjPXrCa3XbV9Tl9Fod8KgXetQYulS/gc6HW6qjTRm/BBtbPh
 tftw59/3ubWzA4NgBmGhm5nOeZr30XKuMzbj9hcVT6q/I7Wh8quoLBEcTctXywupwXgOsaOe4r
 EWbpUV/Zqsd2+pKbHRWKHfREqX5WjyAE1c1JvPrbfarTQHFDi8fiDE5gs9ywUSSILuwjlsvNHf
 rZSXP3Mpag9R0r3aNp8k/hj8J6gZyCDRP1bBFOf/JH0P+nNI52zOCaaC0fhRryoaqsFs4t+SCf
 nW3KnsMSXU22OfrwxqB2MI2g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:28 -0800
IronPort-SDR: PyI20wHEXcTfzvowH0Gj/vPNtk93S4lcAUVnc/KJEASRA2TNJYxlW76h5/+hBIe4jMX2ZkRh0s
 MVoNUZo5hNapbHT1CVTQNBAFyxJ9AiQHgkSvfdhWsY06Ui4W7C4npvRYDo1p95eQSQu6tGE5zX
 q9nVJciZj8CKUQ0crqa1Cexe/QcTvMXohSm+xElpyuiKB3vQFEIGgw8wdo+3cHme65Zvtyj7EF
 Koxg06L0XuAiepVUNjDlhNxiBfX1/q0idjUEIqenKLM8ECsMG9TuQYhYQjqRcp0rko/dZwcMyP
 1bA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:00 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 04/21] btrfs: refactor find_free_dev_extent_start()
Date:   Tue, 25 Feb 2020 12:56:09 +0900
Message-Id: <20200225035626.1049501-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out two functions from find_free_dev_extent_start().
dev_extent_search_start() decides the starting position of the search.
dev_extent_hole_check() checks if a hole found is suitable for device
extent allocation.

These functions also have the switch-cases to change the allocation
behavior depending on the policy.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 80 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9fcbed9b57f9..5f4e875a42f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1384,6 +1384,61 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 	return false;
 }
 
+static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
+{
+	switch (device->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		/*
+		 * We don't want to overwrite the superblock on the
+		 * drive nor any area used by the boot loader (grub
+		 * for example), so we make sure to start at an offset
+		 * of at least 1MB.
+		 */
+		return max_t(u64, start, SZ_1M);
+	default:
+		BUG();
+	}
+}
+
+/**
+ * dev_extent_hole_check - check if specified hole is suitable for allocation
+ * @device:	the device which we have the hole
+ * @hole_start: starting position of the hole
+ * @hole_size:	the size of the hole
+ * @num_bytes:	the size of the free space that we need
+ *
+ * This function may modify @hole_start and @hole_end to reflect the
+ * suitable position for allocation. Returns 1 if hole position is
+ * updated, 0 otherwise.
+ */
+static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
+				  u64 *hole_size, u64 num_bytes)
+{
+	bool changed = false;
+	u64 hole_end = *hole_start + *hole_size;
+
+	/*
+	 * Have to check before we set max_hole_start, otherwise we
+	 * could end up sending back this offset anyway.
+	 */
+	if (contains_pending_extent(device, hole_start, *hole_size)) {
+		if (hole_end >= *hole_start)
+			*hole_size = hole_end - *hole_start;
+		else
+			*hole_size = 0;
+		changed = true;
+	}
+
+	switch (device->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		/* No extra check */
+		break;
+	default:
+		BUG();
+	}
+
+	return changed;
+}
 
 /*
  * find_free_dev_extent_start - find free space in the specified device
@@ -1430,12 +1485,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int slot;
 	struct extent_buffer *l;
 
-	/*
-	 * We don't want to overwrite the superblock on the drive nor any area
-	 * used by the boot loader (grub for example), so we make sure to start
-	 * at an offset of at least 1MB.
-	 */
-	search_start = max_t(u64, search_start, SZ_1M);
+	search_start = dev_extent_search_start(device, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1493,18 +1543,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 		if (key.offset > search_start) {
 			hole_size = key.offset - search_start;
-
-			/*
-			 * Have to check before we set max_hole_start, otherwise
-			 * we could end up sending back this offset anyway.
-			 */
-			if (contains_pending_extent(device, &search_start,
-						    hole_size)) {
-				if (key.offset >= search_start)
-					hole_size = key.offset - search_start;
-				else
-					hole_size = 0;
-			}
+			dev_extent_hole_check(device, &search_start, &hole_size,
+					      num_bytes);
 
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
@@ -1543,8 +1583,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 */
 	if (search_end > search_start) {
 		hole_size = search_end - search_start;
-
-		if (contains_pending_extent(device, &search_start, hole_size)) {
+		if (dev_extent_hole_check(device, &search_start, &hole_size,
+					  num_bytes)) {
 			btrfs_release_path(path);
 			goto again;
 		}
-- 
2.25.1

