Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8BB763BD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjGZP6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjGZP5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962DD100
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3318561B75
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EED8C433C9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387050;
        bh=M/MEkHbyaSvP8N8A9mdoC0hnYDd/2CiyTdAoZZ2jGtc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i9cX/6KugUqjzlNz1BmH8i2oG7hLKP6CbtF1uikR4CJcAXHcnNPdwgipCt4SiOLep
         CT+0OAjwVwMc8YxyaC7RLHRMdEVMxM8UpZiju6Q0AmVD0WPzYmuliBI/sa+tu3PlQ5
         J+AQjz4CY3ojrRztEfUJVTVb7MVsaxUC/IQ/dleZepVBD3KhG+L3DHyYK6h7F8wXlC
         1AF7hacB3pxrHf6P8Mm8OmQtClBefdBBqVso5PRqW2clpIo+nOSBHNEZE8TqvEnxAk
         fWw8GSD3bBS/fdgh2R9Kf27jbiGO6VnAaioA+n1/VKcDBHzmlVKEMruBvJrZslYH0E
         53AbZr+5HSguw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/17] btrfs: avoid starting new transaction when flushing delayed items and refs
Date:   Wed, 26 Jul 2023 16:57:10 +0100
Message-Id: <8d7f2507c523dddd0de8be3a5ae24cbc06836201.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When flushing space we join a transaction to flush delayed items and
delayed references, in order to try to release space. However using
btrfs_join_transaction() not only joins an existing transaction as well
as it starts a new transaction if there is none open. If there is no
transaction open, we don't have neither delayed items nor delayed
references, so creating a new transaction is a waste of time, IO and
creates an unnecessary rotation of the backup roots without gaining any
benefits (including releasing space).

So use btrfs_join_transaction_nostart() when attempting to flush delayed
items and references.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index be5ce209b918..2db92a201697 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -725,9 +725,11 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		else
 			nr = -1;
 
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction_nostart(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			if (ret == -ENOENT)
+				ret = 0;
 			break;
 		}
 		ret = btrfs_run_delayed_items_nr(trans, nr);
@@ -743,9 +745,11 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELAYED_REFS_NR:
 	case FLUSH_DELAYED_REFS:
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction_nostart(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			if (ret == -ENOENT)
+				ret = 0;
 			break;
 		}
 		if (state == FLUSH_DELAYED_REFS_NR)
-- 
2.34.1

