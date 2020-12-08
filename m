Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040B62D2F85
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgLHQZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgLHQZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:53 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE248C0619DB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:14 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c7so8155507qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qwL5s84QZDmX7sSsP0yjbdBzGtv5WBBR/E9NoqSDiN4=;
        b=STDb+Vvk7wZFViR4wWAfqYcJCbX2KJyKrneZZhj2z3mP2JWXvUDl1FXroNE3XUs5Aq
         TC9ACs9J1aux+9B9YA8HOElj/qxbs+TBKUBTa1mdxMxKPsi8SgZVZrk8oOYvF+JSfXAK
         uv1u4O5XBkqHEWr9dKrEf3IP1lHKDPxRC8YG1CipH+yqmZgu1JOqFt4tU/X28i9a6Ch8
         cCjqauehOgWtLo4y3U5P/+iEpkT6j/PYgZJoEcl35nZuQJRYyY2NH0Xx9TXw4sUqpKw3
         Rl6zvP63oCF5YbJbUCuntck55T0xQ1WOukx73aRElrhWXTp4Pq3acaXTxThXXs7JgNk4
         ferg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwL5s84QZDmX7sSsP0yjbdBzGtv5WBBR/E9NoqSDiN4=;
        b=eWM5Iq0bBA8pIiGZLAoxUERAziPyqY8eCx75ivRV/S5y7E5uhIC8EsZfM5x8Zm4eqo
         D8BRR5GFvzDaZNKiR5Reo3v8LW89daAHFaGycbpvaIzqNIYjvqbvRuV8XqfJua/p7LY4
         zNfsme/n6+nSVko0ngpNB8vxS8nTFZG1tJnPnfgKGLxRq5ufhfHNC1ecZ8zhZVcbiC+T
         UBg6LACzHwfHbLVw0IUp63y2RnyR7BWUw+O7loQNkOfDPWbf+WPE3VwLCbie883XUBXw
         ZyPsItL1IaFKifzgKKaS9KP68HJbjymia5lq5yVim5ae+dGDPho6TJ34P63w1CDO9kCD
         W7ag==
X-Gm-Message-State: AOAM531hGedjiZb132t3Lb7EHyJmhe/U1F38fJr+Xjc4RiInctalKbjV
        ziZWJestTU4mbMFC4kzfKjg6QBuTQSY6Si2d
X-Google-Smtp-Source: ABdhPJxo9ZNZbuRuDqPIOTUrT6XLCLIWAFD/zB7OPy2zOddPIsahQVyqhd3cCQSUmog8DQD7FVBnBg==
X-Received: by 2002:a37:b94:: with SMTP id 142mr18322374qkl.318.1607444713711;
        Tue, 08 Dec 2020 08:25:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y35sm15818777qty.58.2020.12.08.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 33/52] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Tue,  8 Dec 2020 11:23:40 -0500
Message-Id: <42df8df431a89627f6f640ac69726f3585697815.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 17bb2bb9a507..916f9ebedc8b 100644
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

