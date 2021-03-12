Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3835A33984D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhCLU0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhCLU0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:09 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65EEC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:08 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 73so4837808qtg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ak7mkZmAI2IDSIeA3KonQf6HL04ORT5ZdZkXHPcqoxg=;
        b=1U8gxlV+2KIeZPBsQKBI01jXOdFGdho0ZhsP+SZpD0a9rJ1X3nzNcW/0IayeQHLhsL
         NueK2UnWBo1UXBqgN1CerZK8xD+UEPcD4zxZe4sbVzM2DKzu3RzDNcnAAP/XCM0fDSxa
         BR+lgQYwvXuzNF9RmTR7wsUkA5HuHyyXHD7O7PbehhexOy9Q/4Hiw6NSOACryq3iiEJB
         M4+pqcKqIrcmtEXhIRhEkqgVwiLPt0b/tTKPCVHkaMfPAjZbjDGJCAqYqBUu6vQveDda
         S2hMhz9vKgEOwJoSfuDkeAm7neK4IvfQ2bCdtCX9AWf8nF0nPXKjxsO/5Dt0vt0acBJv
         6LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ak7mkZmAI2IDSIeA3KonQf6HL04ORT5ZdZkXHPcqoxg=;
        b=cVPUdgQsX6rGmfXc97Jv0/YgBXWjn3113AakJucCThq5QPElhplJhVK3LFOiq2qk6+
         ckcFlFFnniepZq/hAb8bx3Gnz5gyRZ/eFqfD+HErKwYS+LRJefiKyuNVkVZDz4WhKFpt
         lMsEZZkp5adWrzzZrRT0ZW7CYW5ln16hXpik5M3V8n6Ftei1aPFzXpvfsBdYbniF+ctZ
         TGxFdqhH56BR5ZBinjaE7IGYtBZ6hakDzRE4/2pnvWAZNaSyd+/oP0x7vjhoICGd9+Mk
         w6b11sxEbmLjBCgHtRkTk1z/gUZ5Op0Me8RoTF9CMeSM6Bt2lbctbABSF4rElcnF2oSX
         P72Q==
X-Gm-Message-State: AOAM531TP2Bn0hgTkSBiY2ko8OuELjkAwPiSc8TrnOo6BFrxg+BFFRts
        e1Kq3Tl4DerdgH5kIqgAYKafu06q+vLCYAc1
X-Google-Smtp-Source: ABdhPJwBs7pRvCdJrT5c5V2FtDpwTaCsyP6pCzq2kecEj4vbGs8kY5Iozm63wpgGHQ/yU6KwYAAGYw==
X-Received: by 2002:ac8:649:: with SMTP id e9mr13618938qth.114.1615580767659;
        Fri, 12 Mar 2021 12:26:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c73sm5456016qkg.6.2021.03.12.12.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v8 20/39] btrfs: validate ->reloc_root after recording root in trans
Date:   Fri, 12 Mar 2021 15:25:15 -0500
Message-Id: <197e338ecea7071e9e5ea927843eaeb066f5feb3.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to setup a ->reloc_root in a different thread that path will
error out, however it still leaves root->reloc_root NULL but would still
appear set up in the transaction.  Subsequent calls to
btrfs_record_root_in_transaction would succeed without attempting to
create the reloc root, as the transid has already been update.  Handle
this case by making sure we have a root->reloc_root set after a
btrfs_record_root_in_transaction call so we don't end up deref'ing a
NULL pointer.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index df26d6055cc6..4022649e2365 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2081,6 +2081,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			return ERR_PTR(ret);
 		root = root->reloc_root;
 
+		/*
+		 * We could have raced with another thread which failed, so
+		 * ->reloc_root may not be set, return -ENOENT in this case.
+		 */
+		if (!root)
+			return ERR_PTR(-ENOENT);
+
 		if (next->new_bytenr != root->node->start) {
 			/*
 			 * We just created the reloc root, so we shouldn't have
@@ -2578,6 +2585,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			ret = btrfs_record_root_in_trans(trans, root);
 			if (ret)
 				goto out;
+			/*
+			 * Another thread could have failed, need to check if we
+			 * have ->reloc_root actually set.
+			 */
+			if (!root->reloc_root) {
+				ret = -ENOENT;
+				goto out;
+			}
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

