Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0612D2F7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgLHQZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbgLHQZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:38 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0638EC0611CC
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:33 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z11so7251118qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c/EeopVBpvJsFnN/RzjRSQSr/uhaS1KTGxGHh5R/LH0=;
        b=iN7vUMcIDtX75ymI2RE97HgJXfu9JalN70fcMa4oVqiOFcs+8smCYL44ea1V4XFyq2
         akxS0bTxyFyRfIEW1mSgnvIU2v5eEloAOzu/1sju4nTK/ccZ3Vrx1GuMerQ8WKvoe4E8
         Cr4g6tamtQ059dqdRxmj3VqxjoDUA8B/fSPjEaCWaRJ0/tr3k7qAbS7ShKUiTgdlkwvT
         SPJlI1VMS0IzQfOxD0FI6wWLraqNI0EhP7Jm/gpPNLl5yIAlB7VqaehvbAwt1vj/QoIC
         UT35AHFeh57yCWLGGvbvbrL4jSrY6xzRxQ0ale4NjLp4qXl/99LXg7deDK3rpgWU+Mys
         bqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/EeopVBpvJsFnN/RzjRSQSr/uhaS1KTGxGHh5R/LH0=;
        b=lvMzCJ3aQUE6HrtzjQ6dBngBq1z2ABaYSJg1UYof8Xoh6HHc5xgQ5X3J9NkRjMFHB6
         0YnXlra2jBiGKzV87qy5kSp/mXhnujyklnrlqF6EYBlacKxxsEKTwBTdqvMMDnZy4OoV
         YY9DM//19DDmmX2b4/vLhI390KWpCDKxecX94m2/C57hceMSy1p9Xk0aVlnF8rnuQHtb
         O0ZU9fRQOdZy988yzBKtjUdwkNV1GUlzpuTK5rhHb2dwEIXaZZmIXwDQdGEAHEdI0MuE
         k12eMPGNsbbuomZpW55lCPq6dGDR1hLnpJrNRY621XBs00wYShztWvghTXcTxd2En8Pe
         2OEw==
X-Gm-Message-State: AOAM530NT6wy5agwrYI20MVCgCOJSBpTmA4bXa1J7ncztI2N1O5f4HkO
        cYSxp6wZamXp7TRVtHHlMjUW2ztYHPtg7jE1
X-Google-Smtp-Source: ABdhPJwgSOO7RZF6qUdnGrJA+6vbywBXeho73VhufbcfTV16UVCg3e/XJVU/57OAe+sLPY4QbTYzBw==
X-Received: by 2002:a37:a80f:: with SMTP id r15mr9697948qke.84.1607444671859;
        Tue, 08 Dec 2020 08:24:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x22sm13688500qts.53.2020.12.08.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 14/52] btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
Date:   Tue,  8 Dec 2020 11:23:21 -0500
Message-Id: <a4d509cfdddb7bb255a9be3565df2a4ba65b1e42.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have several BUG_ON()'s in select_reloc_root() that can be tripped if
you have extent tree corruption.  Convert these to ASSERT()'s, because
if we hit it during testing it really is bad, or could indicate a
problem with the backref walking code.

However if users hit these problems it generally indicates corruption,
I've hit a few machines in the fleet that trip over these with clearly
corrupted extent trees, so be nice and spit out an error message and
return an error instead of bringing the whole box down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 47 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9a5293efe695..0d4c4e250a89 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1996,8 +1996,33 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		cond_resched();
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
-		BUG_ON(!root);
-		BUG_ON(!test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
+
+		/*
+		 * If there is no root, then our references for this block are
+		 * incomplete, as we should be able to walk all the way up to a
+		 * block that is owned by a root.
+		 *
+		 * This path is only for SHAREABLE roots, so if we come upon a
+		 * non-SHAREABLE root then we have backrefs that resolve
+		 * improperly.
+		 *
+		 * Both of these cases indicate file system corruption, or a bug
+		 * in the backref walking code.
+		 */
+		if (!root) {
+			ASSERT(0);
+			btrfs_err(trans->fs_info,
+		"bytenr %llu doesn't have a backref path ending in a root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
+		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+			ASSERT(0);
+			btrfs_err(trans->fs_info,
+"bytenr %llu has multiple refs with one ending in a non shareable root",
+				  node->bytenr);
+			return ERR_PTR(-EUCLEAN);
+		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
 			record_reloc_root_in_trans(trans, root);
@@ -2008,8 +2033,22 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-			BUG_ON(next->new_bytenr);
-			BUG_ON(!list_empty(&next->list));
+			/*
+			 * We just created the reloc root, so we shouldn't have
+			 * ->new_bytenr set and this shouldn't be in the changed
+			 *  list.  If it is then we have multiple roots pointing
+			 *  at the same bytenr which indicates corruption, or
+			 *  we've made a mistake in the backref walking code.
+			 */
+			ASSERT(next->new_bytenr == 0);
+			ASSERT(list_empty(&next->list));
+			if (next->new_bytenr || !list_empty(&next->list)) {
+				btrfs_err(trans->fs_info,
+"bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
+					  node->bytenr, next->bytenr);
+				return ERR_PTR(-EUCLEAN);
+			}
+
 			next->new_bytenr = root->node->start;
 			btrfs_put_root(next->root);
 			next->root = btrfs_grab_root(root);
-- 
2.26.2

