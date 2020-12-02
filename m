Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110492CC732
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389838AbgLBTxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389828AbgLBTxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:33 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A0C08E861
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:09 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so1996118qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNrtG9846/kEJQvBoisAkpzRNcVVY2IovcaCwIO6TuA=;
        b=BTpdihMwoWKbedu43HITnSU8Q3/m5r48+7Ph5s17zepnX3SbzoZHczsJNWqObvRjd9
         5lEcbJYVifjDb4KYgS48tKn4xbdgf51WKM6UBcxTZ/ofHWraExsAfngJHIfpM8HSPME2
         jyesyk1ecVgdJHH1KURaEr7UqrSAU3t2v/QDqt8lDtLGjNeN5jpdXXZaiObxiD+Lc8yb
         lpyvxXzTdmJ1iV2sCQ3hejD1B2iOlqbn5v1Ia0x/nVrEGS4tnyuOuTBlFfXeCyBgkzpq
         6KfPBpARKu4SkB6lpn5k4F3t5vpG3xbkGdjKFRijT047gaiGZptVRL6sLnkPLK+XsymX
         DgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNrtG9846/kEJQvBoisAkpzRNcVVY2IovcaCwIO6TuA=;
        b=bGUbpQ/zxwQyKy9F6RW9LcKrKcIZpzw9x8wm7WY6mcnB9sNE8v5myronD8ZEe66Z1y
         IlXiSgjy5yVV3gzxAa2q76y5l2bkKcFK2pafI6CWjRwpTeIz3BbiE1jZtkHwlBehVYlE
         sAA3EkrUouOBSoGPW4TV036d0NIQALlunvnTIdGJpHFWszYwV8yw7hhsFSv81sxRrTRt
         W7DMZWKF6fvWE3emQCh8EQDGzOD37xPPEioudcIhbufcpzZFSK3tmfsxdoKJxxDd4UjH
         kGgWIi7k55Ulq+uSYddeYvpaGMfeBp37fPX3yRjgJdi1d/iAyxhsRf1p39/fdS13P4Fw
         JiQA==
X-Gm-Message-State: AOAM5318CLOsNWSkcvA52dszJia8iZgUIursfTUjC+qg4+Un+7ucSFFJ
        f3WlhtVu7K6ojon//YGAxwcfyGCVRlDIsQ==
X-Google-Smtp-Source: ABdhPJyhXS1p47Gjxw/jK7v89vBwC/aReTlhQIFfP6O6lHz6bZC7VNT7+1w8UxKpWoYPFE6rrX/pXg==
X-Received: by 2002:ac8:7316:: with SMTP id x22mr4321658qto.386.1606938728437;
        Wed, 02 Dec 2020 11:52:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m54sm3034535qtc.29.2020.12.02.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v3 30/54] btrfs: validate ->reloc_root after recording root in trans
Date:   Wed,  2 Dec 2020 14:50:48 -0500
Message-Id: <60d12b7256e6877061eaa9df99ce2ed1f0f3d012.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index cebf8e9d7d96..c9df05f02649 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2078,6 +2078,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -2579,6 +2586,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
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

