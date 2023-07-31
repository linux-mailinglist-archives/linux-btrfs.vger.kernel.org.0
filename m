Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA81769F4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjGaRUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjGaRUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431D1BFD
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823969; x=1722359969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHm2FreoA/KcFawHVQ4EbCevBhfwbWxg31InugeYM1A=;
  b=CXPjz7jcj2B5HHWk/Rs/Y4G5ZjJpczpLrAUEOLyQttqRjk1RRXBkvkJ7
   b16RqcKDZnBv7eqUfmlasI4lGIUgvRLmD5VyE3mX6eeANwlQkDbT8+REC
   XeTe7ftjQZH9rbp/f3TOODdm4DtoSljiLDS1s+8k+Rfux8V4DzY74+uDX
   rh0O8RrAS08symOKq/0h6tLOkFXTsB4/aQo5ZFMG8wekZ0ELcH6Iuwk83
   wx3yW+r/hirhTeBiSSBS9aNijZAIcoXr40/qL92mm6zUmd+ZU4XIM3FK1
   NOz72CvI7JHIGWuV5Xl/5AYFXrHV+ZtJAPx+mTYDzbtk98g4eAb+NtiwD
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269574"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:41 +0800
IronPort-SDR: Dn/1QJlLyrEFNm1BSFiO/3QrOS+32KNdP2alg6RVIP/AMtbLKuonz9CDRlrfpr1bTYzwQkxEkc
 7O8dMHGEFMwZrwlTdJQ3oPCuXKYXG+XnPm3IMQ/gv6AVKcd+/QwBNgtghBKFkY037EisK4S4L8
 lxFkxMMCLcXlHutsLjKNQAR7RFSJgNVBbaRxO4C3EmL20WvUutyRZkjDg8IwMqr3yYb5rYF3Z9
 dEhcCBXDhFq3e8TkfH0vze6RY3OKMHKH6ymSbd5oeH1WIREG8L+agIKQq8U+ePCmUH+ati7NFl
 /18=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:18 -0700
IronPort-SDR: qNoEH2hWSRWVNjXsWCeJbDLMGS7yJ//983UweuKFtCgd1QBQEw7qPHEdIFHbQ/pESlyb6cYYEl
 FrGEWrJjzp+rSu6mXF/TlknVHnMFxcAiPXgebZapd70xQm1nENLUHQcg1sSai5jjyvoEcUvYRE
 DB1Qkb1yioZUa/mZcOju4+negKFVkeU9QDKX2a9MxQG/a6zkNY9UmwkwwAyyS/Bnqirk6bNwJa
 lfxVXUo5UHC8vKAM3H528Mp68hQ/S1Xf0tiWgXeDekS1EDsMqPVIr8NCIQKHFHyfK+c/ZyhCOP
 HF0=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:41 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 09/10] btrfs: zoned: don't activate non-DATA BG on allocation
Date:   Tue,  1 Aug 2023 02:17:18 +0900
Message-ID: <65989fd4940f6c936237f491fbebe9311ff8d1f4.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690823282.git.naohiro.aota@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that, a non-DATA block group is activated at write time. Don't activate
it on allocation time.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/extent-tree.c |  8 +++++++-
 fs/btrfs/space-info.c  | 28 ----------------------------
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b0e432c30e1d..0cb1dee965a0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4089,7 +4089,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 
 	if (IS_ERR(ret_bg)) {
 		ret = PTR_ERR(ret_bg);
-	} else if (from_extent_allocation) {
+	} else if (from_extent_allocation && (flags & BTRFS_BLOCK_GROUP_DATA)) {
 		/*
 		 * New block group is likely to be used soon. Try to activate
 		 * it now. Failure is OK for now.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 12bd8dc37385..92eccb0cd487 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3690,7 +3690,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	}
 	spin_unlock(&block_group->lock);
 
-	if (!ret && !btrfs_zone_activate(block_group)) {
+	/* Metadata block group is activated on write time. */
+	if (!ret && (block_group->flags & BTRFS_BLOCK_GROUP_DATA) &&
+	    !btrfs_zone_activate(block_group)) {
 		ret = 1;
 		/*
 		 * May need to clear fs_info->{treelog,data_reloc}_bg.
@@ -3870,6 +3872,10 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
 				    struct find_free_extent_ctl *ffe_ctl)
 {
+	/* Block group's activeness is not a requirement for METADATA block groups. */
+	if (!(ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA))
+		return 0;
+
 	/* If we can activate new zone, just allocate a chunk and use it */
 	if (btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
 		return 0;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 17c86db7b1b1..356638f54fef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -761,18 +761,6 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case ALLOC_CHUNK:
 	case ALLOC_CHUNK_FORCE:
-		/*
-		 * For metadata space on zoned filesystem, reaching here means we
-		 * don't have enough space left in active_total_bytes. Try to
-		 * activate a block group first, because we may have inactive
-		 * block group already allocated.
-		 */
-		ret = btrfs_zoned_activate_one_bg(fs_info, space_info, false);
-		if (ret < 0)
-			break;
-		else if (ret == 1)
-			break;
-
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
@@ -784,22 +772,6 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
 
-		/*
-		 * For metadata space on zoned filesystem, allocating a new chunk
-		 * is not enough. We still need to activate the block * group.
-		 * Active the newly allocated block group by (maybe) finishing
-		 * a block group.
-		 */
-		if (ret == 1) {
-			ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
-			/*
-			 * Revert to the original ret regardless we could finish
-			 * one block group or not.
-			 */
-			if (ret >= 0)
-				ret = 1;
-		}
-
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
-- 
2.41.0

