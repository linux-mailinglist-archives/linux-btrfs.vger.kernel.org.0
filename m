Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE60016B84D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgBYD5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:17 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34233 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgBYD5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603035; x=1614139035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L6l356z3pl1I86GSIvQvTqyGvqY8mUX91kLnKVgQnAo=;
  b=NSRQ9xDs0OSVrvy6sr9fdzYB5Gf3g4Zw/yyiCksOwNsks7TMRnL8UxVh
   T8dvf1uiH4wIoR14BaBhcG1Kc4IVka4n3W09Xdv4y8ZpEIMX46oTNDzPM
   MRrk80e5/tr9QZy4s7zTQZAesk0/13mAkVqmcc79MysK6/7oudY3c/0fb
   aimYWLsVDReFd+WbnlTh8thcmlsnGedjZUpr0tH81fjBELDoVdWAJVzcg
   cUH+QYDmf3Kj7Bo1obpqhVhn51UbdC6Z/7T10tWahLD4Ar+tuQEw8neKb
   3W1c2pQUXs4vFZ9MvLVOWdB3w5tpDXpwilrx5HN2Mxnpbe2rr5mJ4gUp1
   A==;
IronPort-SDR: a9cm32hx9RnyUmFHyIK+2HFsGS5Yl2Up+MpssTvbUf0rxZDOSsbB1hDngQU6dSXHwPfc54qFyZ
 zGSDv4d59bDPu3ZaYZ/ea10B3ajMmze/8QdkOeTJj4Y20GhcrdQfLQN6r9sCYHxwL+HXLzz0F3
 +ITkcTlMZwdLOV7Jp4TfXE5+vrCTrbD7AxDzryunvMKwI0VYHsgiHDcJ1uqz9qGAZorAGO/QSN
 +CrOhp+2CPeRqwW4CzSBi87EbqS80N5wh6sjaf2PRPGRFbiGKq4LB4D3LIWXGm9yMD22LrD8I7
 PtE=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168295"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:12 +0800
IronPort-SDR: iz2MBQTwuZLDEaKNJkMrrMmNkE+Mlx5bfNesAN73imF1tombx4j0FD4Oz2C3PPdIu77YPy35mt
 H605poY3CahTYVsc1Mm578YG8wgwKeF8mj1yKEDqCMuH0w1xP2MPdnzrxcPWPPd93Oh6WXipHf
 ABm/7TWf8exj5Gx1ByPoGJS3V58AsyZSPI8+3LjxWfyqxY7bzrGbmDlr9OPbIZUgqegzZ4hqhR
 ToXbPEH3z7sXPNWaH9p241WD6O+9OT2ON478SMBw3+roHgJiv8GiOHH1sJoLANXQPo2MrVi0pG
 i/QOKlzKKm9+uMUo9hrtc08s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:40 -0800
IronPort-SDR: mZheM10dLWLQ0VDJAKsypsX37gfQHQGRAn3IZGq2zB0lIcC5NqjenlkXu9YGzZZPvtQ/BZRlVy
 Mu42LFxQ/ggxx4GMHTeFSoINUhveIpqau8mIs+zQFBvUGrC6mSnxGRG84FZx6e5Mli4XPpYJUP
 JddPS4E0PI+HMQ5v9eGlNEZxsrPwcNGFkTCxh6xdFA7nPiRXxz6+L2mbrZuFDNgt09qA8oOp/8
 aHS2Z7fbWBr4NSom9SJi2SmW2PoNt3+una9HMtKc+WfiltCQ6d3LiDHG7fHpiI9S0TMaG4+PFe
 Tug=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 13/21] btrfs: move variables for clustered allocation into find_free_extent_ctl
Date:   Tue, 25 Feb 2020 12:56:18 +0900
Message-Id: <20200225035626.1049501-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move "last_ptr" and "use_cluster" into struct find_free_extent_ctl, so that
hook functions for clustered allocator can use these variables.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 93f07988d480..cbb89ac6cda3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3458,6 +3458,8 @@ struct find_free_extent_ctl {
 
 	/* For clustered allocation */
 	u64 empty_cluster;
+	struct btrfs_free_cluster *last_ptr;
+	bool use_cluster;
 
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
@@ -3816,11 +3818,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 {
 	int ret = 0;
 	int cache_block_group_error = 0;
-	struct btrfs_free_cluster *last_ptr = NULL;
 	struct btrfs_block_group *block_group = NULL;
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
-	bool use_cluster = true;
 	bool full_search = false;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
@@ -3829,8 +3829,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.empty_size = empty_size;
 	ffe_ctl.flags = flags;
 	ffe_ctl.search_start = 0;
-	ffe_ctl.retry_clustered = false;
-	ffe_ctl.retry_unclustered = false;
 	ffe_ctl.delalloc = delalloc;
 	ffe_ctl.index = btrfs_bg_flags_to_raid_index(flags);
 	ffe_ctl.have_caching_bg = false;
@@ -3839,6 +3837,12 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.hint_byte = hint_byte_orig;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
+	/* For clustered allocation */
+	ffe_ctl.retry_clustered = false;
+	ffe_ctl.retry_unclustered = false;
+	ffe_ctl.last_ptr = NULL;
+	ffe_ctl.use_cluster = true;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -3869,14 +3873,16 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			spin_unlock(&space_info->lock);
 			return -ENOSPC;
 		} else if (space_info->max_extent_size) {
-			use_cluster = false;
+			ffe_ctl.use_cluster = false;
 		}
 		spin_unlock(&space_info->lock);
 	}
 
-	last_ptr = fetch_cluster_info(fs_info, space_info,
-				      &ffe_ctl.empty_cluster);
-	if (last_ptr) {
+	ffe_ctl.last_ptr = fetch_cluster_info(fs_info, space_info,
+					      &ffe_ctl.empty_cluster);
+	if (ffe_ctl.last_ptr) {
+		struct btrfs_free_cluster *last_ptr = ffe_ctl.last_ptr;
+
 		spin_lock(&last_ptr->lock);
 		if (last_ptr->block_group)
 			ffe_ctl.hint_byte = last_ptr->window_start;
@@ -3887,7 +3893,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			 * some time.
 			 */
 			ffe_ctl.hint_byte = last_ptr->window_start;
-			use_cluster = false;
+			ffe_ctl.use_cluster = false;
 		}
 		spin_unlock(&last_ptr->lock);
 	}
@@ -4000,10 +4006,11 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		 * Ok we want to try and use the cluster allocator, so
 		 * lets look there
 		 */
-		if (last_ptr && use_cluster) {
+		if (ffe_ctl.last_ptr && ffe_ctl.use_cluster) {
 			struct btrfs_block_group *cluster_bg = NULL;
 
-			ret = find_free_extent_clustered(block_group, last_ptr,
+			ret = find_free_extent_clustered(block_group,
+							 ffe_ctl.last_ptr,
 							 &ffe_ctl, &cluster_bg);
 
 			if (ret == 0) {
@@ -4021,8 +4028,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			/* ret == -ENOENT case falls through */
 		}
 
-		ret = find_free_extent_unclustered(block_group, last_ptr,
-						   &ffe_ctl);
+		ret = find_free_extent_unclustered(block_group,
+						   ffe_ctl.last_ptr, &ffe_ctl);
 		if (ret == -EAGAIN)
 			goto have_block_group;
 		else if (ret > 0)
@@ -4071,8 +4078,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, last_ptr, ins, &ffe_ctl,
-					   full_search, use_cluster);
+	ret = find_free_extent_update_loop(fs_info, ffe_ctl.last_ptr, ins,
+					   &ffe_ctl, full_search,
+					   ffe_ctl.use_cluster);
 	if (ret > 0)
 		goto search;
 
-- 
2.25.1

