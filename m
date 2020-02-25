Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84816B84E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgBYD5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34233 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603036; x=1614139036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Dm5xWcxeGHQQfziuoYwU9OlBKzzE4/PR/QwWTqCGu4=;
  b=QRjPE4+TT4vGwZ7sVdheOWNMPTIjjzoBOPamX8Rvc7I45LQ+qIi0aHbk
   j3uGULozUVKef+rQSgLM3zy41tG3+Fis6B+BpCLaOrOEYRYJRjhLt5QVk
   2/FnLTBoaTZ2zQjL0zF9k6WcYcm/jr5EWm6mKhJf/lRy70sHMJgIhULKO
   Fd6wgsjf3hJosdUQd1uSz/mcUn43GxgY6f420Um6qA5SGrhDMOQVKYubP
   7BTtuqOfETwW+TYgzSdmfHNMiKn/JCWVZma5X1UBhNJIaRU2YNRY9MPVd
   lXFCD6KZ8DBfXw4ollLlW5aDyXhMBqd75j8Ukq8NPC+aVn+0sSoA+2pSF
   Q==;
IronPort-SDR: Kdx7wWxfm75py5MoEqI7BktDEaFpi3pBdEuuD9nDqAYtdgEu24O9cpnqSCM0M+C243XlV0HlQj
 4WodE85RWKBwBrtdVukGeGiRqAFj8mk1ML8m/8ExPNPX6OEpSdxO/qvQJvlhBldpVMHbkKqPvH
 Y3ZHL35IhG/ptX6Kj2INnzOvhPRUIaymrqqtbqfOtqJ5Ry2s+ffwQs/q5HthprxfFrRuYn2kk1
 fTTCta720vjJEQZZkgUJQZRc0aXHY+RzxyoB8jjOPbIGYhT71R8h0Tt3/12TsokDiCAqZ2DxXL
 vQo=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168297"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:13 +0800
IronPort-SDR: uXhAI9yeWWIqa4IzFvOodnRBRIKY8uEMIiQz7M1D/d2c+N42iVTkzNVVl5qFp8EJ+lhTbDRQHx
 +x1OA4nJzBYYtkaNSVtOgubtN/7C6oCpMU1NmSf6ku8wIWPLM0Ryj9YfJdV2w77FckF0/Nezbc
 v++Q/0sjfKN7eKWpXSpBMTkJoTAjIaIdaeAnvgxJiJmE8VrpuVtmfzs0hybQfDH6PJ3sLGDNTu
 muZ+JzOj9SbSu9wDnbXyngdGgF4z1CVHoFinf7M+KC1WWslqp3G8Ci2vaw69J49lYHtrSiqAJ8
 X1X4L9DP4t8Esq1KRhpx1xXE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:41 -0800
IronPort-SDR: 66f2lL5FNr6NLa2QXeUf0+Bec05FA3uiSx95F/IQOsMCrsmCOoL+JGAd9PbSZusgpHihoypuUb
 Ao2t9dRo+FhI7a6hT5wLE93WzkWhgH/mb3b63LO6MKZeZoczlENNRQDxzV/PpakcoOF1CegAnA
 3AyuBPPMepaR+WdfIH7SEEDWD2q4AyPH6FgokimxaNVrsAllwf4nPYMZOhrbuc8r2Cg9mo4cu7
 FwAgIABBrew2bRHfBjIB/DkKEdxGd4e7kJoDCKRx6xhozSsUXF44WSmPEkumbiYDJrqDV4unCz
 eW0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:13 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 14/21] btrfs: factor out do_allocation()
Date:   Tue, 25 Feb 2020 12:56:19 +0900
Message-Id: <20200225035626.1049501-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out do_allocation() from find_free_extent(). This function do an
actual allocation in a given block group. The ffe_ctl->policy is used to
determine the actual allocator function to use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 78 +++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cbb89ac6cda3..1ed12a033ba9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3675,6 +3675,39 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 	return 0;
 }
 
+static int do_allocation_clustered(struct btrfs_block_group *block_group,
+				   struct find_free_extent_ctl *ffe_ctl,
+				   struct btrfs_block_group **bg_ret)
+{
+	int ret;
+
+	/*
+	 * Ok we want to try and use the cluster allocator, so lets look there
+	 */
+	if (ffe_ctl->last_ptr && ffe_ctl->use_cluster) {
+		ret = find_free_extent_clustered(block_group, ffe_ctl->last_ptr,
+						 ffe_ctl, bg_ret);
+		if (ret >= 0 || ret == -EAGAIN)
+			return ret;
+		/* ret == -ENOENT case falls through */
+	}
+
+	return find_free_extent_unclustered(block_group, ffe_ctl->last_ptr,
+					    ffe_ctl);
+}
+
+static int do_allocation(struct btrfs_block_group *block_group,
+			 struct find_free_extent_ctl *ffe_ctl,
+			 struct btrfs_block_group **bg_ret)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3942,6 +3975,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl.index], list) {
+		struct btrfs_block_group *bg_ret;
+
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro))
 			continue;
@@ -4002,40 +4037,21 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
-		/*
-		 * Ok we want to try and use the cluster allocator, so
-		 * lets look there
-		 */
-		if (ffe_ctl.last_ptr && ffe_ctl.use_cluster) {
-			struct btrfs_block_group *cluster_bg = NULL;
-
-			ret = find_free_extent_clustered(block_group,
-							 ffe_ctl.last_ptr,
-							 &ffe_ctl, &cluster_bg);
-
-			if (ret == 0) {
-				if (cluster_bg && cluster_bg != block_group) {
-					btrfs_release_block_group(block_group,
-								  delalloc);
-					block_group = cluster_bg;
-				}
-				goto checks;
-			} else if (ret == -EAGAIN) {
-				goto have_block_group;
-			} else if (ret > 0) {
-				goto loop;
+		bg_ret = NULL;
+		ret = do_allocation(block_group, &ffe_ctl, &bg_ret);
+		if (ret == 0) {
+			if (bg_ret && bg_ret != block_group) {
+				btrfs_release_block_group(block_group,
+							  delalloc);
+				block_group = bg_ret;
 			}
-			/* ret == -ENOENT case falls through */
-		}
-
-		ret = find_free_extent_unclustered(block_group,
-						   ffe_ctl.last_ptr, &ffe_ctl);
-		if (ret == -EAGAIN)
+		} else if (ret == -EAGAIN) {
 			goto have_block_group;
-		else if (ret > 0)
+		} else if (ret > 0) {
 			goto loop;
-		/* ret == 0 case falls through */
-checks:
+		}
+
+		/* checks */
 		ffe_ctl.search_start = round_up(ffe_ctl.found_offset,
 					     fs_info->stripesize);
 
-- 
2.25.1

