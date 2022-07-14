Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC14574094
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 02:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGNAeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiGNAeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 20:34:19 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E31114A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o26so197402qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J7Yrqgt9wgAS/AZGxXB1F4kB1MK+0i8XC9EJG1CmxsE=;
        b=KO2/ScrLnIcNutz2Dvx3tyiYOFODdaD/2IPVtKhLQiKcork/woK1WmwqiziynYCvBC
         Hz3vJQobWOVPYkU8AbiyyC4hyjCrJFcceDBRMJe1BGi/yC0D+5ZOlfZSYp1xH0xYXR/9
         yZ73FpTbZhw1TPeyq3rBTlCaUIKIgrEFUMp36vkE6Ew63jrWjujprHYAjfHpJSx5iOSB
         HaHYwtJWXkoTEXb+eEgdhgfR7HtreU6+hYPnRdq35bG21llWljuWqkdgf7da0go4acC1
         /zmlw1rP1qPlvLhx4ToxDgnvuq/RFbtDs20HT5yJrf32DcmcSbU499mechYbkNYAj1H6
         uDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7Yrqgt9wgAS/AZGxXB1F4kB1MK+0i8XC9EJG1CmxsE=;
        b=ibmOKkzWKypLzfRVgBhdr3aLsqWhji008EVDj6ADte7dTz/x953bGghkBOMzP86pv8
         7YOtEYnpE+p1oc7MelzGMLKgWC+/7p1kSPZqVrEiNjfmZpQFYOXb+UNoCIcLC/ZXZsf8
         WdIqYIcudqjlrsl9IeSSBXmzj28/ehoLzeWgVx+R8mIKMh0J2MsIQQnoXxPe6uoVOpBX
         ulVowRAVToRDbJTaTMzbdUxlA230CfUQhNFsPXF9rJP/iSJOEWqL/2Sj8GSaozCQfnQC
         mZU7zY4cn/xjOV4aQsYMjkI7ptHfVOHUr0/A7e203M8KobJsq49dDnJ87ZS+1bz5GX8g
         h+1w==
X-Gm-Message-State: AJIora/jOd4wSWL5EdT8a/Lo3ik8ovmGM0gj5q7BD+aA8ZpHAr97xxYj
        vDPgAFKTg5jiCTx7IE+hEn64TaLgKCeFGQ==
X-Google-Smtp-Source: AGRyM1vN2S/HWRXvduNddmtL1RqGNLmZdoyJgVNlece7gdZ7H2vnu9qkcM75ISggQOZ8sVmk/w0Y6w==
X-Received: by 2002:a05:620a:4592:b0:6b5:ad7e:373 with SMTP id bp18-20020a05620a459200b006b5ad7e0373mr4256658qkb.127.1657758856869;
        Wed, 13 Jul 2022 17:34:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fz20-20020a05622a5a9400b00307cac53129sm223943qtb.42.2022.07.13.17.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:34:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: simplify btrfs_put_block_group_cache
Date:   Wed, 13 Jul 2022 20:34:08 -0400
Message-Id: <e826fefe2457137d3aa8bf904de3c1bde250d667.1657758678.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657758678.git.josef@toxicpanda.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're breaking out and re-searching for the next block group while
evicting any of the block group cache inodes.  This is not needed, the
block groups aren't disappearing here, we can simply loop through the
block groups like normal and iput any inode that we find.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e27098571011..51096f88b8d3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3984,36 +3984,24 @@ void btrfs_reserve_chunk_metadata(struct btrfs_trans_handle *trans,
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group *block_group;
-	u64 last = 0;
 
-	while (1) {
-		struct inode *inode;
-
-		block_group = btrfs_lookup_first_block_group(info, last);
-		while (block_group) {
-			btrfs_wait_block_group_cache_done(block_group);
-			spin_lock(&block_group->lock);
-			if (test_bit(BLOCK_GROUP_FLAG_IREF,
-				     &block_group->runtime_flags))
-				break;
+	block_group = btrfs_lookup_first_block_group(info, 0);
+	while (block_group) {
+		btrfs_wait_block_group_cache_done(block_group);
+		spin_lock(&block_group->lock);
+		if (test_and_clear_bit(BLOCK_GROUP_FLAG_IREF,
+				       &block_group->runtime_flags)) {
+			struct inode *inode = block_group->inode;
+
+			block_group->inode = NULL;
 			spin_unlock(&block_group->lock);
-			block_group = btrfs_next_block_group(block_group);
-		}
-		if (!block_group) {
-			if (last == 0)
-				break;
-			last = 0;
-			continue;
-		}
 
-		inode = block_group->inode;
-		clear_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags);
-		block_group->inode = NULL;
-		spin_unlock(&block_group->lock);
-		ASSERT(block_group->io_ctl.inode == NULL);
-		iput(inode);
-		last = block_group->start + block_group->length;
-		btrfs_put_block_group(block_group);
+			ASSERT(block_group->io_ctl.inode == NULL);
+			iput(inode);
+		} else {
+			spin_unlock(&block_group->lock);
+		}
+		block_group = btrfs_next_block_group(block_group);
 	}
 }
 
-- 
2.26.3

