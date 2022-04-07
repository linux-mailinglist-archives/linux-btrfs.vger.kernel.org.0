Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B34F83BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbiDGPlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbiDGPlm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 11:41:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DB1EAF3
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 08:39:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6915E215FE;
        Thu,  7 Apr 2022 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649345980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mj4kDWxyBbhoQzqKPEba48FwsiUqPO7K5THT9UyVF1U=;
        b=AgrnKkWmR0ppLNf3FyG6TC9egYOggBMH9THyi5HB7zTt7lW/lxs2bFWNE6VN5cd5c4QVxq
        EuFdFb34toXBlZ2Xujmga0F68SmETgeyp2r4YOsbIrG7lrbFHaXvlhx4iCEnAPc5GtS5JE
        CfUUFiRKUuqPiEecZBeHJXjnNBPWCek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E80413A66;
        Thu,  7 Apr 2022 15:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qBz2DbwFT2LpdQAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 07 Apr 2022 15:39:40 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 3/6] btrfs_get_or_create_delayed_node: convert to using XArray API
Date:   Thu,  7 Apr 2022 17:38:51 +0200
Message-Id: <20220407153855.21089-4-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153855.21089-1-gniebler@suse.com>
References: <20220407153855.21089-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 fs/btrfs/delayed-inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 240c11b59098..9ee0c446478f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -141,23 +141,17 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	/* cached in the btrfs inode and can be accessed */
 	refcount_set(&node->refs, 2);
 
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(ret);
-	}
-
 	spin_lock(&root->inode_lock);
-	ret = radix_tree_insert(&root->delayed_nodes_xarray, ino, node);
-	if (ret == -EEXIST) {
+	ret = xa_insert(&root->delayed_nodes_xarray, ino, node, GFP_NOFS);
+	if (ret) {
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, node);
-		radix_tree_preload_end();
-		goto again;
+		if (ret == -EBUSY)
+			goto again;
+		return ERR_PTR(ret);
 	}
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);
-	radix_tree_preload_end();
 
 	return node;
 }
-- 
2.35.1

