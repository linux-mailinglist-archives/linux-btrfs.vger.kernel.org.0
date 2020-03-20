Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1618D715
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCTSeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:34:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34412 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgCTSep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:34:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id f3so8001644qkh.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZFLYdBmpqX2NdyKxuBSwbdTdr8noadgqHxA4MjdW6yo=;
        b=Dt0lCyJkSF3LQi4uucE/bNSzVhfCxCXX4CDCv6XNBkBOMEMMS+8zCLq8QrGJMujjAD
         4x+XyIrROnSeS47P3ljeh3PeYtosQZ8KHvpjud4leJkinNMJU+axEtSZENMpGvqzJKEn
         R4AffhoFp8JIv0mDAdceUgCkAG/Wy1pJnpum5r/oGBjR0p5oJwvRdsQIWGEsm81IEwBi
         a9cQZ2UL5Tm4IAIopnuZmDSkKtN4Vr55oQ3BpROVBoJpIiCwXDELoBnO6QZWQ415tlzK
         IGui26Jlfo/mF5rrgXORtmHd5svw3giud1GN8KucZV1/042jMuIvugC9OiNs7pQyNAC/
         mbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFLYdBmpqX2NdyKxuBSwbdTdr8noadgqHxA4MjdW6yo=;
        b=EkFEcCEhj6hICXMHFcvHGZGabyZ6IqArI6wTEaK330wtn4pqFcFwS9dIKWr5jCE86c
         MizQoXsS4Xmstt3xfEncZjPkPr4XuYuXVZlhvu4sb0x408//RzEp68OJzw9yHjv2T3Tw
         +dC+cc5FMsnV8/ZkLIZYSdw5cQmKX072g8gRvBwTf6TCVWG43d4RQuvOXSKfmSgkjUZe
         cTfu4qwmPjpF2VO4uyrKgiUuWJ2HV5FU7A4ZFmhkF4hixHuOkre9K0l/Tjq56V+100+G
         rsIylq2sCgfgIRsXDaCSpCxscYhL0cr+xq8PYkckEzJ2plJGWRlmwn/27gZpxz7VX7nZ
         ZHuQ==
X-Gm-Message-State: ANhLgQ2VLaB4Ffk79aaKN17t/B2l8bic7OEIM5k34VmtrTRlspULOd/c
        NT0azsz9aIadyHEiRDA0IkzDz0nyeLU+dQ==
X-Google-Smtp-Source: ADFU+vs0G9vXah+O5EqqdS8clrm9M0XZNS3hoi96+t9Vy6TsUF7oQbF9RVWUpvWue19RZNrQzTx3Ww==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr5326979qkf.269.1584729281706;
        Fri, 20 Mar 2020 11:34:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k66sm4898515qke.10.2020.03.20.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:34:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: reorder reservation before reloc root selection
Date:   Fri, 20 Mar 2020 14:34:32 -0400
Message-Id: <20200320183436.16908-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320183436.16908-1-josef@toxicpanda.com>
References: <20200320183436.16908-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're not only checking for metadata reservations but also if we
need to throttle our delayed ref generation, reorder
reserve_metadat_bytes() above the select_reloc_root() call in
reserve_metadat_bytes().  The reason we want this is because
select_reloc_root() will mess with the backref cache, and if we're going
to bail we want to be able to cleanly remove this node from the backref
cache and come back along to regenerate it.  Move it up so this is the
first thing we do to make restarting cleaner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3ccc126d0df3..df33649c592c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3134,6 +3134,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	if (!node)
 		return 0;
 
+	/*
+	 * If we fail here we want to drop our backref_node because we are going
+	 * to start over and regenerate the tree for it.
+	 */
+	ret = reserve_metadata_space(trans, rc, node);
+	if (ret)
+		goto out;
+
 	BUG_ON(node->processed);
 	root = select_one_root(node);
 	if (root == ERR_PTR(-ENOENT)) {
@@ -3141,12 +3149,6 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (!root || test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
-		ret = reserve_metadata_space(trans, rc, node);
-		if (ret)
-			goto out;
-	}
-
 	if (root) {
 		if (test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
 			BUG_ON(node->new_bytenr);
-- 
2.24.1

