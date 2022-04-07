Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BF4F83B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbiDGPlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344850AbiDGPll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 11:41:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC551EAF1
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 08:39:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 35CE51F861;
        Thu,  7 Apr 2022 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649345980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2dT8QPd4p/GHdlsz4aSKzBSYJldRcze5Ri0jsIwfsE=;
        b=lPIriyJkgpAAbcwKWMwzkRVMXxWsANheRb9OUH6tGO8fINUXZQNVWintjTcxYV83E4dakb
        Ilu5tnEvIREO3X35QUTd+/sihQ7Y1WJLyLurueOUFiQUN1rmClfvG55eg+lQY2Bnz4Tfpn
        Hxvq/UW4KNRKKKSiKh01DwkZVuvJ4aQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0980413A66;
        Thu,  7 Apr 2022 15:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ULNWALwFT2LpdQAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 07 Apr 2022 15:39:40 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 2/6] btrfs_get_delayed_node: convert to using XArray API
Date:   Thu,  7 Apr 2022 17:38:50 +0200
Message-Id: <20220407153855.21089-3-gniebler@suse.com>
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
 fs/btrfs/delayed-inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 14d95ed62ac3..240c11b59098 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -78,7 +78,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	}
 
 	spin_lock(&root->inode_lock);
-	node = radix_tree_lookup(&root->delayed_nodes_xarray, ino);
+	node = xa_load(&root->delayed_nodes_xarray, (unsigned long)ino);
 
 	if (node) {
 		if (btrfs_inode->delayed_node) {
@@ -90,9 +90,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 
 		/*
 		 * It's possible that we're racing into the middle of removing
-		 * this node from the radix tree.  In this case, the refcount
+		 * this node from the XArray.  In this case, the refcount
 		 * was zero and it should never go back to one.  Just return
-		 * NULL like it was never in the radix at all; our release
+		 * NULL like it was never in the XArray at all; our release
 		 * function is in the process of removing it.
 		 *
 		 * Some implementations of refcount_inc refuse to bump the
@@ -100,7 +100,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 * here, refcount_inc() may decide to just WARN_ONCE() instead
 		 * of actually bumping the refcount.
 		 *
-		 * If this node is properly in the radix, we want to bump the
+		 * If this node is properly in the XArray, we want to bump the
 		 * refcount twice, once for the inode and once for this get
 		 * operation.
 		 */
-- 
2.35.1

