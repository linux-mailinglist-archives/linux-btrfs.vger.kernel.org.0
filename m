Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E88602E6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJRO1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJRO1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:27:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15569C0980
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9EC333C47;
        Tue, 18 Oct 2022 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666103259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMjiTvbHZ4CsftTSUPkQuxqR4+sK5DhkNu8qbBwk4vk=;
        b=giaJ5KorJ7FL/4pyfCVz6mojQMiXv81oyImtclKHgwizQWvdj9zlKvzDmUrAbVQg4UaBo2
        aYCy/yIPCQzMDsIJCL66KiupS5hZmF3Arh5fg/GxUUEPZCbHnO6eEf5taTlxDc/26A5ah8
        wpW7SsIcpsAI1Vlry/LRTtHUg/SmeT8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BD7E72C141;
        Tue, 18 Oct 2022 14:27:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F03CDA79B; Tue, 18 Oct 2022 16:27:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
Date:   Tue, 18 Oct 2022 16:27:31 +0200
Message-Id: <c7040cb687cebc01e3155a330146fd55cc04f6f1.1666103172.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666103172.git.dsterba@suse.com>
References: <cover.1666103172.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's only one caller that passes GFP_NOFS, we can drop the parameter
an use the flags directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 5 ++---
 fs/btrfs/backref.h | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e6b69ac1a77c..a5e548f30242 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2634,12 +2634,11 @@ void free_ipath(struct inode_fs_paths *ipath)
 	kfree(ipath);
 }
 
-struct btrfs_backref_iter *btrfs_backref_iter_alloc(
-		struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
+struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_backref_iter *ret;
 
-	ret = kzalloc(sizeof(*ret), gfp_flag);
+	ret = kzalloc(sizeof(*ret), GFP_NOFS);
 	if (!ret)
 		return NULL;
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 6dac462430b0..ea8b59a201e6 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -155,8 +155,7 @@ struct btrfs_backref_iter {
 	u32 end_ptr;
 };
 
-struct btrfs_backref_iter *btrfs_backref_iter_alloc(
-		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
+struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
 
 static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
 {
-- 
2.37.3

