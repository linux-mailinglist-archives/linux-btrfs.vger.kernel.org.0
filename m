Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0752D12E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgLGOAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLGOAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:02 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3507C094243
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:45 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id y15so1813037qtv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsrfk6ueoE77Saz+ki+XrNDk2dErjLeVhhzz9vbaZ34=;
        b=rGkeh8bB+h9rO+CMBjhil1qvj5Rfda4q4LqAuEc4yMmtzz+HuUqUABperM5G3IMRFy
         OddZh3eNl4rkdCeJDTw2IbWjSwkjhCWkXFoom9N2rdSSP1uTNR/EFJlSh/IAGnWqpXh7
         UxIskE96NE85q0Kn5+O1kOEj+r9aJWNhO4LFimyL2xF/ggZToVa8CigyS/Jj9jjGdwF1
         /yTaiiIMqfuTmBH0rGyyKevPgk6SWRQlcXQoTwmYr6LOjuKbzpclxOiJGc+pi7IL9F3H
         vgcVewFGCPfB6LxmmQxwXRYQQXvyUlTXi26gheCt/Wy7zcbkHpXHiiqJBWt+L09PJWmT
         +DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsrfk6ueoE77Saz+ki+XrNDk2dErjLeVhhzz9vbaZ34=;
        b=fnYzyYfmzxaKzFE914xy95msgFN1MrxDseielx926JsFT2YM9k+aEc0mp72ITcXgHH
         BnfzTCUQwrKFFbKgf4oXKNOjqKBEQ8qSkj0kREGhoj5DqEQD0+9lpD3551Ss6ALIOpjo
         QHg05vw7IezbCEmCP69lCRN80eq//IJfjgrEeilB5l6DtYMq7JTrR9SHmfeHv2vP1IwH
         1G8KvgqpQlYyhHfAsC4d9Yn8/HyIIr5IhCzaLMNOP8s4u2pn/iysntJWP22gUXMCDTyB
         zMOGuk+xgudbW8FiTqhmozWE9Pcrz9iUSbz1fM2Lsik4jjzzdpD19BvclHZjRtP+mvGo
         rrrQ==
X-Gm-Message-State: AOAM532aw/hqbeksDiYX/8XJOP0KuKJXJIiGLezLf7M2/WHM7JuaPSRn
        mBPA+eIE9xS8YCHyHdTdxpSXZKGBNQ0cy6cU
X-Google-Smtp-Source: ABdhPJxpGzwU5775tP6Smo8RCj3V5jEbj5Ne0aPX2zAaeJa8nV3Qrbx5VHwtXEUbezu8GHLIsyl6Uw==
X-Received: by 2002:ac8:b07:: with SMTP id e7mr11336092qti.311.1607349524467;
        Mon, 07 Dec 2020 05:58:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11sm12119890qkm.124.2020.12.07.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v5 30/52] btrfs: validate ->reloc_root after recording root in trans
Date:   Mon,  7 Dec 2020 08:57:22 -0500
Message-Id: <bbadccc46005510ced7ce5a7fbe667b03340b688.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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
index 627c1bcfdd33..5770f4212772 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2073,6 +2073,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -2572,6 +2579,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
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

