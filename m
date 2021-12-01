Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59777464D5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 12:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbhLAL76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 06:59:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbhLAL74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 06:59:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 386861FD5B
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638359795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pNAQNZgciUY/KcL7aj4FPPX/MnRaUVtUCbyrydDdUMo=;
        b=S5I88pb+BkcGY6Csi12vXTxPDSF+ggxW3tUu5iOM4Jwfubo3Z4zLLu7asWDNMrkJ2oKez+
        IsXd51aw0ANwF4Gs+2e+3TEiBlkAlz8u1Nmp7O0ZC8PmCD5A/2s7/YMtE6svE8ydMKWExe
        RVlAoPUHxCBk8JgIR4E3RddKQDj9x6c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8251D1348A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 11:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kLVFEvJip2H7EwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 11:56:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: replace the BUG_ON() in btrfs_del_root_ref() with proper error handling
Date:   Wed,  1 Dec 2021 19:56:17 +0800
Message-Id: <20211201115617.144434-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I hit the BUG_ON() with generic/475 test case, and to my surprise, all
callers of btrfs_del_root_ref() are already aborting transaction, thus
there is not need for such BUG_ON(), just go to @out label and caller
will properly handle the error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/root-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index aa2809796c0e..3d68d2dcd83e 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -334,7 +334,8 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	key.offset = ref_id;
 again:
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
-	BUG_ON(ret < 0);
+	if (ret < 0)
+		goto out;
 	if (ret == 0) {
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
-- 
2.34.1

