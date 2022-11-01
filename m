Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D176614EF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKAQQO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKAQQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D91C90E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD956118E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E867C43144
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319369;
        bh=a+oHdRyfanntEWk8r2LPgSO+Ilr1llMwhkoFklk6sUk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NdQP+7+WQt77zoPIvc/wAW6yQx194aK3wnfdQBlqzeV/iUMKBWZaceF388zyzifEP
         VlaXvsZj69OWB4LyJaHheiLHldsE+hb3hdwJOQA9NA5oF+nREuSWCdxzWewUK5WGmG
         BqxKVADOz0BW5A+Taf14GXW38MkvrW9p/fRDSXUeijTVeaGOj31IooRQKmBZeTEH+O
         l5P1HaPfc0OJOn0i+tXZ0pm4wsmxipwWMycVgqEXo8GMjukk9B//j+RUaih10TAZEq
         v6hfgkSCNGoTAvfDc94bSakDOJyZbDas12PMeZAfVpIKO02nJf/c3WKlisSvnFvuPh
         kBsaxa9QBh1eg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/18] btrfs: constify ulist parameter of ulist_next()
Date:   Tue,  1 Nov 2022 16:15:49 +0000
Message-Id: <056c766f0411fceba7880ae20c68d9b4d16edbb1.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The ulist_next() iterator function does not need to change the given ulist
so make it const. This will allow the next patch in the series to pass a
ulist to a function that does not need, and should not, modify the ulist.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ulist.c | 2 +-
 fs/btrfs/ulist.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 13af1e41f9d7..33606025513d 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -266,7 +266,7 @@ int ulist_del(struct ulist *ulist, u64 val, u64 aux)
  * It is allowed to call ulist_add during an enumeration. Newly added items
  * are guaranteed to show up in the running enumeration.
  */
-struct ulist_node *ulist_next(struct ulist *ulist, struct ulist_iterator *uiter)
+struct ulist_node *ulist_next(const struct ulist *ulist, struct ulist_iterator *uiter)
 {
 	struct ulist_node *node;
 
diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
index 02fda0a2d4ce..b2cef187ea8e 100644
--- a/fs/btrfs/ulist.h
+++ b/fs/btrfs/ulist.h
@@ -66,7 +66,7 @@ static inline int ulist_add_merge_ptr(struct ulist *ulist, u64 val, void *aux,
 #endif
 }
 
-struct ulist_node *ulist_next(struct ulist *ulist,
+struct ulist_node *ulist_next(const struct ulist *ulist,
 			      struct ulist_iterator *uiter);
 
 #define ULIST_ITER_INIT(uiter) ((uiter)->cur_list = NULL)
-- 
2.35.1

