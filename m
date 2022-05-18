Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD452B5CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiERJRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiERJRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF219C3D
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865443; x=1684401443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwtEpad7clfcSJikOAaEnqnVTV2opFqaeGWePtafWlg=;
  b=m6eGwI+n6TnQFJ5lUCCLQS6K2bjtHw7xKoRqSG1keHIq4e65rbVl2YfB
   lx+PiVswC9HfCKdamQc0sDbAgqQHSrObx+5IHFgZusaHwNnTqPrUlkciT
   QtPe/qIrHCF4rGcV5BRHefEdGQmsFvVZOZ0Kp14wNbFBEc45j6I83gh0U
   1lYEg7UXVoI02ZrwTDdFHZuY2Bo76INBf01VqtiOuY2qR+fZRbnwvhSyL
   sqyNZUZe5/74w+dEKyep0/Zm5Yh4yJffMkdDRr4KShfiJQrO0N5Y81+Qo
   4vnxhCdNeFQzX3vDvahPM/AFht55r7w7oU7pCh7zlpR+qtSTXxVLuTiNG
   A==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514750"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:22 +0800
IronPort-SDR: 2suzW6XIdhD2frPIRvcjN/gK2QmtmSEjKtstLBFtpJ8j4pqx4gXdNQ77f+jjRJ5IzylVHrHH+D
 Fx9FrpjRPARfPCeVk3qH2xnY0sgXOUkS8FEj4yCFxkI1bt/akTvTu4bE5n7ODvzb9RS65ql/I+
 XeTfv3yXBzARvPTLQ+nfZGpOgK0tFg7J0KShZsDLZ8R7bCIn689DP7sOZzES/PK2l64EkL/jjG
 JBWXXVlIEWDtwrBP5udYoN+OTgeL6eeZ6U2WsTBMlizdvcAhpzl3dPdiK54d7J7RS9jhRTDXnd
 /llPkTuTsR+Xw4lTJYUIDN/p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:25 -0700
IronPort-SDR: 6Ih6JeLtS5SQb72YlX7vRK2UibMYNmbGQKVHuBSY0nsIUAYmLESBk7yzj9spWIvSKGiz8WIENE
 Tim/hMd47267piSFSPSm2UJYxb5k8lYUK//RpGbHy5dsL7EkUU5IMI0MopEGtG5pi3fLfyaYw2
 JxaAL3AsZDJH1KbeLUm/adqZ9VOmmAGx+XdLyqIx4vMBYHOTQjfwqdRKoHXZDvW3QmKphoRko/
 t4bstUVR2HRAtq8vwSsAxMzGIOtB358g1qI4XVY9B5nSDXPWGVUZH+V4FFSM9CBDvSkkIeFBQn
 hyc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:21 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 5/6] btrfs-progs: add raid-stripe-tree to mkfs runtime features
Date:   Wed, 18 May 2022 02:17:15 -0700
Message-Id: <20220518091716.786452-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
References: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/fsfeatures.c   |  8 ++++++++
 common/fsfeatures.h   |  1 +
 kernel-shared/ctree.h |  3 +++
 mkfs/main.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 23a92c21a2cc..ed34aadb4d7e 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -172,6 +172,14 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(safe, 4,9),
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
+	} , {
+		.name		= "raid-stripe-tree",
+		.flag		= BTRFS_RUNTIME_FEATURE_RAID_STRIPE_TREE,
+		.sysfs_name	= NULL,
+		VERSION_NULL(compat),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "raid stripe tree"
 	},
 	/* Keep this one last */
 	{
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 9e39c667b900..8d9a925af6c4 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -45,6 +45,7 @@
 
 #define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
 #define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
+#define BTRFS_RUNTIME_FEATURE_RAID_STRIPE_TREE	(1ULL << 2)
 
 void btrfs_list_all_fs_features(u64 mask_disallowed);
 void btrfs_list_all_runtime_features(u64 mask_disallowed);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 40e5e09897b1..b2348c4303fd 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -88,6 +88,9 @@ struct btrfs_free_space_ctl;
 /* hold the block group items. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* hold the raid-stripe entries */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 46dbc4c0c363..881de53b11fe 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -969,6 +969,38 @@ fail:
 	return ret;
 }
 
+static int setup_raid_stripe_tree_root(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *stripe_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
+	int ret;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	stripe_root = btrfs_create_tree(trans, fs_info, &key);
+	if (IS_ERR(stripe_root))  {
+		ret =  PTR_ERR(stripe_root);
+		goto abort;
+	}
+	fs_info->stripe_root = stripe_root;
+	add_root_to_dirty_list(stripe_root);
+
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret)
+		return ret;
+
+	return 0;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
@@ -1689,6 +1721,16 @@ raid_groups:
 			goto out;
 		}
 	}
+	if (runtime_features & BTRFS_RUNTIME_FEATURE_RAID_STRIPE_TREE) {
+		ret = setup_raid_stripe_tree_root(fs_info);
+		if (ret < 0) {
+			error("failed to initialize raid-stripe-tree: %d (%m)",
+			      ret);
+			goto out;
+		}
+	}
+
+
 	if (bconf.verbose) {
 		char features_buf[64];
 
-- 
2.35.3

