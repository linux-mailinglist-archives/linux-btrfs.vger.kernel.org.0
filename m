Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3172D12D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgLGN7q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLGN7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:45 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91059C09424C
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:51 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id x25so12513980qkj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=veWjAVm1EUr4XAlzMRvjKGkkM3ajrvwj5nc9cZ/TPV8=;
        b=G90mUy+Pekrzone4VFu5t0eOtfY3/dPOQjDKhbRPgcuTsXQNNfx1hvp5fTgC/ja8NY
         PYjH0A7BbhxHXp6gV1jV5+DK2MC2lP/zG452mleQQazBVu8g9//nOZsYzuRlQIlOLFFW
         e7NfIx8RDU9jWJmiqqrcihwhVhu3GZWA7xcslRJD2ZcjwCjG4G2K7gCAPhxf3pE9dIry
         3JUB8QEAiyxBr2iEffzgBhUuRNh28FdbqFZFbXcN/zABFUtaR3Bkgdlag7ujz1MQWIGp
         1Cl0dOUxxFUALf7AKJELi0ni6ZOdMdr2PMblxlImvzhdTov1Do1imhMXMknJFHbfKB+P
         AucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veWjAVm1EUr4XAlzMRvjKGkkM3ajrvwj5nc9cZ/TPV8=;
        b=fLFn6juyeB04CdwwtRAkW08UcO0uHRuK5STKZRbMFt7gSuDLougEBukw4hH9EGMW+R
         OlupbCgv6OHj4cCdDijXEuOmtsod88+CmoeQ/5S62pNKb1Iif3b+lOCRzTduziSqgIbT
         GXNZtMyIEXKIlbcvb/zkGhnr91cZE2KJFHcU4nRMurOZ4SwzeC5AL4IVKQfC5lBXXb2N
         HaqhI4XNIZvnAv/qxzwGd4CuQBODgM1zH9a0E5HZ8lmNSePUhY4gZO/jpI5xYloW5imO
         x9Stvf8APZXZgWLUC8jUpqWPIsk86vulmzefqnl+g35IHVz4d4tPogHSXUkQC+NFBfsD
         9N0w==
X-Gm-Message-State: AOAM532QEnTMylL43DIOZ/KsOLDFKgnDa76AP9P9gFlXdocdSn9/+V4F
        Z9KIC1ejrOZhFAvBzMvRG4+KK1eKlQjlw3Bx
X-Google-Smtp-Source: ABdhPJxW0Wvmtd4lecNEUqTfUnhYyENM10zIXe47ZxasvLu3aXLywmXkyf0je4EDEnDMyf11Jf+6pg==
X-Received: by 2002:a37:6c1:: with SMTP id 184mr3013746qkg.381.1607349530480;
        Mon, 07 Dec 2020 05:58:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o22sm12974049qto.96.2020.12.07.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 33/52] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Mon,  7 Dec 2020 08:57:25 -0500
Message-Id: <6b3e989013716fee356437727f47c733e7f66bf8.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in insert_dirty_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f41044d2b032..f329903024b0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1562,6 +1562,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1572,7 +1573,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		sizeof(reloc_root_item->drop_progress));
 	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
-	btrfs_update_reloc_root(trans, root);
+	ret = btrfs_update_reloc_root(trans, root);
+	if (ret)
+		return ret;
 
 	if (list_empty(&root->reloc_dirty_list)) {
 		btrfs_grab_root(root);
-- 
2.26.2

