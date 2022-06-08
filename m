Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ECE543EBC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiFHVkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbiFHVkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:40:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6152BC4C7
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:40:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5AB6B1FD41;
        Wed,  8 Jun 2022 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654724435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nj0KJLoM6ir6cX1OqOXg+hxML7f8N0dZY74GiNfOX2I=;
        b=qgO2lCgcBIvbPdmngI0pcClU4nBLze5E+8zP/S3PZVEmExvpJP682VNZtaljL8wlrKuD8P
        1atBgOthwU5BKuuQRn4BONS2+s0sfBfOfa5axjKeK+JgLO66UxmQMRvp8bZ8lTSr44KqND
        VZHxKVtUwKOrLl6a7g7HXue6Z+oEB+E=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5197A2C141;
        Wed,  8 Jun 2022 21:40:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A68ABDA883; Wed,  8 Jun 2022 23:36:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: remove unused typedefs get_extent_t and btrfs_work_func_t
Date:   Wed,  8 Jun 2022 23:36:06 +0200
Message-Id: <19086c492dc4ba9fece368771cf56322f05b3b45.1654723641.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654723641.git.dsterba@suse.com>
References: <cover.1654723641.git.dsterba@suse.com>
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

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.h | 1 -
 fs/btrfs/extent_io.h    | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 07960529b360..6e2596ddae10 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -13,7 +13,6 @@ struct btrfs_fs_info;
 struct btrfs_workqueue;
 struct btrfs_work;
 typedef void (*btrfs_func_t)(struct btrfs_work *arg);
-typedef void (*btrfs_work_func_t)(struct work_struct *arg);
 
 struct btrfs_work {
 	btrfs_func_t func;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 72966cf21961..c0f1fb63eeae 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -142,10 +142,6 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 
 struct extent_map_tree;
 
-typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
-					  struct page *page, size_t pg_offset,
-					  u64 start, u64 len);
-
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-- 
2.36.1

