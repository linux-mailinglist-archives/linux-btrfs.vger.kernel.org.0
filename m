Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9CA655EF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 02:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiLZBBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 20:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLZBBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 20:01:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93355E3B
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 17:01:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43A364D956
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672016460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NR8PaKmXppvUna2fl5wkN/U5aaQ6t7ByPoSjWN7hIas=;
        b=kD0wo/gp2oW9hXa0R9luswYaurQVlrU0NyhygIFzqrU0nctEO2PIPb5fnfLRDej+MGbL4w
        a6a0SSBsf2l6EzZ+8k+uWvY00Jxk9OcDtH0BDcrPx62Vn9saLYPwjujvvVIolaEi1k3KX1
        mZ8s+NIJU+M+pqQr+8Zz1rElmIaE7jM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1228138F2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6PSSHEvyqGNFaQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: always report error for run_one_delayed_ref()
Date:   Mon, 26 Dec 2022 09:00:40 +0800
Message-Id: <e8249a59dd7a59869dfaa4fbcb76424f458e21c7.1672016104.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672016104.git.wqu@suse.com>
References: <cover.1672016104.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we have a btrfs_debug() for run_one_delayed_ref() failure, but
if end users hit such problem, there will be no chance that
btrfs_debug() is enabled.

This can lead to very little useful info for debug.

This patch will:

- Add extra info for error reporting
  Including:
  * logical bytenr
  * num_bytes
  * type
  * action
  * ref_mod

- Replace the btrfs_debug() with btrfs_err()

- Move the error reporting into run_one_delayed_ref()
  This is to avoid use-after-free, the @node can be freed in the caller.

This error should only be triggered at most once.

As if run_one_delayed_ref() failed, we trigger the error message, then
causing the call chain to error out:

btrfs_run_delayed_refs()
`- btrfs_run_delayed_refs()
   `- btrfs_run_delayed_refs_for_head()
      `- run_one_delayed_ref()

And we will abort the current transaction in btrfs_run_delayed_refs().
If we have to run delayed refs for the abort transaction,
run_one_delayed_ref() will just cleanup the refs and do nothing, thus no
new error messages would be output.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index eaa1fb2850d7..d1a4e51f8fbc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1713,6 +1713,11 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 		BUG();
 	if (ret && insert_reserved)
 		btrfs_pin_extent(trans, node->bytenr, node->num_bytes, 1);
+	if (ret < 0)
+		btrfs_err(trans->fs_info,
+"failed to run delayed ref for logical %llu num_bytes %llu type %u action %u ref_mod %d: %d",
+			  node->bytenr, node->num_bytes, node->type,
+			  node->action, node->ref_mod, ret);
 	return ret;
 }
 
@@ -1954,8 +1959,6 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		if (ret) {
 			unselect_delayed_ref_head(delayed_refs, locked_ref);
 			btrfs_put_delayed_ref(ref);
-			btrfs_debug(fs_info, "run_one_delayed_ref returned %d",
-				    ret);
 			return ret;
 		}
 
-- 
2.39.0

