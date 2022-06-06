Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68C53EB4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiFFQlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbiFFQlH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 12:41:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48814642F
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 07A671FA3D;
        Mon,  6 Jun 2022 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654533665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zv0uirwAZ4HP5qtZzi9ZN423m1B0xyVNbYH2JOl0ynA=;
        b=hVewz6xYjluR/cTMZ5ZcLTig26Ydp6ZLbRpbhpj66+tSWqmoHlGndXeVr8AAj8//T1+OzO
        eSYooOvEYPsI6NjibxT0iLVLJWml5BMSN+ElUzmZ5mrwTrIdfmOkE8aB7rkVwd758oamtF
        bKUoec6maN7cYRTiPWV3cDIwmvmIYd0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F0B322C141;
        Mon,  6 Jun 2022 16:41:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52D78DA8E2; Mon,  6 Jun 2022 18:36:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: sysfs: advertise zoned support among features
Date:   Mon,  6 Jun 2022 18:36:35 +0200
Message-Id: <20220606163635.28869-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've hidden the zoned support in sysfs under debug config for the first
releases but now the stability is reasonable, though not all features
have been implemented.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index ebe76d7a4a64..3554c7b4204f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -289,9 +289,10 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
-#ifdef CONFIG_BTRFS_DEBUG
-/* Remove once support for zoned allocation is feature complete */
+#ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
+#endif
+#ifdef CONFIG_BTRFS_DEBUG
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 #endif
@@ -320,8 +321,10 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
+#endif
+#ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 #endif
 #ifdef CONFIG_FS_VERITY
-- 
2.36.1

