Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDADA5706C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiGKPQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 11:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGKPQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 11:16:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDE23BE2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 08:16:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB79820396;
        Mon, 11 Jul 2022 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657552579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GptR72rUMn3NLrfbeR1dL2xzaLONyE5+YTit1Xo+X1w=;
        b=tvQMFnOcQuUY1NoYRD9WZy0YOb6ATnpfCE6bwzotsXZT9i9x//xnXiwnAz30xttTBMDJ82
        JQIau/mVpN10ZREHzCUqJzR/wniibKIIKubuZmJ8DioTwmhBFofArtro+kRNz3NVf/Z5Ju
        ZLzV5ql0Etfon8E5bfsIJjI6tXUsgaQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA75E13322;
        Mon, 11 Jul 2022 15:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zBz3JsM+zGLnXQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Jul 2022 15:16:19 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: simplify error handling in btrfs_lookup_dentry
Date:   Mon, 11 Jul 2022 18:16:18 +0300
Message-Id: <20220711151618.2518485-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_lookup_dentry releasing the reference of the sub_root and the
running orphan cleanup should only happen if the dentry found actually
represents a subvolume. This can only be true in the 'else' branch as
otherwise either fixup_tree_root_location returned an ENOENT error, in
which case sub_root wouldn't have been changed or if we got a different
errno this means btrfs_get_fs_root couldn't have executed successfully
again meaning sub_root will equal to root. So simplify all the branches
by moving the code into the 'else'.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b17335555e0..1dd073e96696 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5821,11 +5821,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 			inode = new_simple_dir(dir->i_sb, &location, sub_root);
 	} else {
 		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
-	}
-	if (root != sub_root)
 		btrfs_put_root(sub_root);
-
-	if (!IS_ERR(inode) && root != sub_root) {
 		down_read(&fs_info->cleanup_work_sem);
 		if (!sb_rdonly(inode->i_sb))
 			ret = btrfs_orphan_cleanup(sub_root);
-- 
2.25.1

