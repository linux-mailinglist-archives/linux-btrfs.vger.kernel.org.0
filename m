Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121787BD265
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 05:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbjJIDeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Oct 2023 23:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbjJIDef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Oct 2023 23:34:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54161A6
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 20:34:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 039262184E
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 03:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696822472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DU/sXgBR2SNCq6Z8AXjtQZHb3Jkek8I9OsEe3xwaTik=;
        b=Yfo0dgDByWwl2u9Y0s6xnGaLArMcmTKYdY8M1VmkLcR4WF+O0KtSkd7wE5hdj6R6j17F9J
        tKGJeQPnWoXQMVXbk2K9oMqblHmzip7qdMd+e7ExXNi8ANRN/D6L0jqztT0GZvizjd+pnw
        /7S5Id23I5F/lKYSmWHAiMxL4ALscII=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD1C1138F1
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 03:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDf+GsZ0I2X8PQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Oct 2023 03:34:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: mkfs/rootdir: add the missing xattr for the rootdir inode
Date:   Mon,  9 Oct 2023 14:04:08 +1030
Message-ID: <e1291beb0f3aead7d491e879f7348c4ef58f01e4.1696822345.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696822345.git.wqu@suse.com>
References: <cover.1696822345.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using "mkfs.btrfs" with "--rootdir" option, the top level inode
(rootdir) will not get the same xattr from the source dir:

  mkdir -p source_dir/
  touch source_dir/file
  setfattr -n user.rootdir_xattr source_dir/
  setfattr -n user.regular_xattr source_dir/file
  mkfs.btrfs -f --rootdir source_dir $dev
  mount $dev $mnt
  getfattr $mnt
  # Nothing <<<
  getfattr $mnt/file
  # file: $mnt/file
  user.regular_xattr <<<

[CAUSE]
In function traverse_directory(), we only call add_xattr_item() for all
the child inodes, not really for the rootdir inode itself, leading to
the missing xattr items.

[FIX]
Also call add_xattr_item() for the rootdir inode.

Issue: #688
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index a413a31eb2d6..f6328c9df2ec 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -466,6 +466,14 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 	dir_entry->inum = parent_inum;
 	list_add_tail(&dir_entry->list, &dir_head->list);
 
+	ret = add_xattr_item(trans, root, btrfs_root_dirid(&root->root_item),
+			     dir_name);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to add xattr item for the top level inode: %m");
+		goto fail_no_dir;
+	}
+
 	root_dir_key.objectid = btrfs_root_dirid(&root->root_item);
 	root_dir_key.offset = 0;
 	root_dir_key.type = BTRFS_INODE_ITEM_KEY;
-- 
2.42.0

