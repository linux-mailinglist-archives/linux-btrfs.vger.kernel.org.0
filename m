Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A5714CD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjE2PRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE2PRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB1C4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55B460B28
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E685C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373437;
        bh=H9vUovm2qM2PAxTNd2pifilI43wuvFqPwQSE/44Necs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uT7XTKVlPHifNtwjtSHvrr+jN6CqKzCggRJMN3KrS0bgGVXhWtJrFbixS+OS0a3Zg
         Ap3PP/ooN9DvcZjPgxk8Vyb7yLnhirCeHyM4agKXng0K+LeVESL2/3nFS25jQ0VmoN
         DxaVbUghp3G/BBLEmQNgE7xNjKAChNXKCq1gtqbQZUzEYsTPF5fKG0Y1CYGeDn9tVu
         iPgWJo43lKNvAkWCbAwifV8pGvPkNcNsAMNUS1jCTw3YjHLlDwZvG1gC2awEw0+UDb
         geUcxmD5mcWw58a/uucneaO8y8zwjd0NOesvkRLG7yDqlKnf0WJpObAxL66Mjb3CYE
         3yl/XhQDix2ZQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: remove unused is_head field from struct btrfs_delayed_ref_node
Date:   Mon, 29 May 2023 16:16:58 +0100
Message-Id: <4221611ef72c981c934c2328ae01f8aa47622df2.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The 'is_head' field of struct btrfs_delayed_ref_node is no longer after
commit d278850eff30 ("btrfs: remove delayed_ref_node from ref_head"),
so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 1 -
 fs/btrfs/delayed-ref.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 0b32432d7d56..be1d18ec5cef 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -853,7 +853,6 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	ref->num_bytes = num_bytes;
 	ref->ref_mod = 1;
 	ref->action = action;
-	ref->is_head = 0;
 	ref->in_tree = 1;
 	ref->seq = seq;
 	ref->type = ref_type;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 9b28e800a604..77b3e735772d 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -48,8 +48,6 @@ struct btrfs_delayed_ref_node {
 
 	unsigned int action:8;
 	unsigned int type:8;
-	/* is this node still in the rbtree? */
-	unsigned int is_head:1;
 	unsigned int in_tree:1;
 };
 
-- 
2.34.1

