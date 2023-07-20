Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0249F75BAEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGTW7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTW7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:59:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E88F92
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:59:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B9EB5C0166;
        Thu, 20 Jul 2023 18:59:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 18:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893940; x=
        1689980340; bh=GFV+uKPRk4Am+jixPfXNfontdo+7MbTMnFGc/XraWBI=; b=g
        2k1tAU+OO9zTU1WBbt+Q+KsUk3pCzz3XnwL46dWUTHwfN06J9PJqlQkWZIy42MQo
        MyYYb7+Svm5dYXqGETl+14bvWNfcwPJVMREVIQK/IyTZ0d+CRrx7JDWv9PbqptgB
        WCY76eWM+UauXvxf4r886nueV4saEBl0XSYjq5hie590NUPnsDkWLkqXWiZWD+/u
        B4ovx9bTtXZ38mDYI7RARUI4OPSHzyem74f2nWnjI1PCtB9OiPAyv7lg8z3kbdxA
        k1BfX5cSdQIFfBF2+5LMe/Mbp5pJ1PVGIRZ+wCKxe1snTIgk7MzwBrkblZJ0FQGU
        mG3cZXRc7YNTlOiJrC4nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893940; x=1689980340; bh=G
        FV+uKPRk4Am+jixPfXNfontdo+7MbTMnFGc/XraWBI=; b=xNhlfByLp+BWMxZGu
        RJKq9Sa4fiZS+zYYEdZ2YLzFWHgYNPe6kaSsaKFGqvAgyTDTEnCcrFaU4OJ/Ax8H
        pQMItWxQsVNxzQCqgWdkmRJD+O9n0tfeg7DWHQN/Hg4Z2SVBKSfaT3iurH0lIJ3W
        gP/owo6IBfbOEY0COS8fra1thW1dNDVl5PwQqVj47nH3mDl4ijE05OzgQBxXLroh
        FRf2Wlxird8D3pPYsCmWn++f5hsMelRFUMtXRbQftyR9vn3XOUYnFC/6+s5lD1Pd
        iG+650kIm//a/vH6fw6+S7xmixA9EGUPPgHuFn0gAH08rv6H+Hs7JrPvhjN9egce
        9bVFQ==
X-ME-Sender: <xms:NLy5ZJ18UyYfkiLG0NWBnMOg3sVgIayurwVhsZJjWwXjgBZLxTxeYA>
    <xme:NLy5ZAE5M6Kbz6twQsvwryYa0UDmHGOvebhBT2URAnLvmtusp7RFDNvS5xSQfwUN0
    -T-f_C3aYjU7BS97ms>
X-ME-Received: <xmr:NLy5ZJ6DUnd-RpQYdeXZN-7b8hIYUJEZNmlntA3jYDCYNB3sv_Z7O8es6FtDgkkpoIhZCoxmsudrpvsuibtcY6wZ6nI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:NLy5ZG1q7Y4nMZYP44eN1PFNNjlcelih_NGhChNNxOSabOlXzuH3Ow>
    <xmx:NLy5ZMECdAfR6WqNL9lYlLHhfgR6Sw2WVKSJ9YoJxVYSuE_HqCxTGw>
    <xmx:NLy5ZH8usc8_-9VzIE0LL6lpFnKkY1sEgocMAEuBkeodvRcZFKbk-A>
    <xmx:NLy5ZHM2hfGWVcF1QTAxzOOYYOBtW__JVIwmtjY4qFW5p8AmQdYGuw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:59:00 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/8] btrfs-progs: simple quotas fsck
Date:   Thu, 20 Jul 2023 15:57:20 -0700
Message-ID: <b8aedf1c9ca1f3f632f87babf1f83d8cc4703c3b.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893698.git.boris@bur.io>
References: <cover.1689893698.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add simple quotas checks to btrfs check.

Like the kernel feature, these checks bypass most of the backref walking
in the qgroups check. Instead, they enforce the invariant behind the
design of simple quotas by scanning the extent tree and determining the
owner of each extent:
Data: reading the owner ref inline item
Metadata: reading the tree block and reading its btrfs_header's owner

This gives us the expected count from squotas which we check against the
on-disk state of the qgroup items.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 check/main.c          |  2 ++
 check/qgroup-verify.c | 79 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 77bb50a0e..07f31fbe0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5667,6 +5667,8 @@ static int process_extent_item(struct btrfs_root *root,
 					btrfs_shared_data_ref_count(eb, sref),
 					gen, 0, num_bytes);
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			break;
 		default:
 			fprintf(stderr,
 				"corrupt extent record: key [%llu,%u,%llu]\n",
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 1a62009b8..c95e6f806 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -85,6 +85,8 @@ static struct counts_tree {
 	unsigned int		num_groups;
 	unsigned int		rescan_running:1;
 	unsigned int		qgroup_inconsist:1;
+	unsigned int		simple:1;
+	u64			enable_gen;
 	u64			scan_progress;
 } counts = { .root = RB_ROOT };
 
@@ -915,14 +917,18 @@ static int add_qgroup_relation(u64 memberid, u64 parentid)
 	return 0;
 }
 
-static void read_qgroup_status(struct extent_buffer *eb, int slot,
-			      struct counts_tree *counts)
+static void read_qgroup_status(struct btrfs_fs_info *info,
+			       struct extent_buffer *eb,
+			       int slot, struct counts_tree *counts)
 {
 	struct btrfs_qgroup_status_item *status_item;
 	u64 flags;
 
 	status_item = btrfs_item_ptr(eb, slot, struct btrfs_qgroup_status_item);
 	flags = btrfs_qgroup_status_flags(eb, status_item);
+
+	if (counts->simple == 1)
+		counts->enable_gen = btrfs_qgroup_status_enable_gen(eb, status_item);
 	/*
 	 * Since qgroup_inconsist/rescan_running is just one bit,
 	 * assign value directly won't work.
@@ -948,6 +954,8 @@ static int load_quota_info(struct btrfs_fs_info *info)
 	int i, nr;
 	int search_relations = 0;
 
+	if (btrfs_fs_incompat(info, SIMPLE_QUOTA))
+		counts.simple = 1;
 loop:
 	/*
 	 * Do 2 passes, the first allocates group counts and reads status
@@ -990,7 +998,7 @@ loop:
 			}
 
 			if (key.type == BTRFS_QGROUP_STATUS_KEY) {
-				read_qgroup_status(leaf, i, &counts);
+				read_qgroup_status(info, leaf, i, &counts);
 				continue;
 			}
 
@@ -1038,6 +1046,51 @@ out:
 	return ret;
 }
 
+static int simple_quota_account_extent(struct btrfs_fs_info *info,
+				       struct extent_buffer *leaf,
+				       struct btrfs_key *key,
+				       struct btrfs_extent_item *ei,
+				       struct btrfs_extent_inline_ref *iref,
+				       u64 bytenr, u64 num_bytes, int meta_item)
+{
+	u64 generation;
+	int type;
+	u64 root;
+	struct ulist *roots = ulist_alloc(0);
+	int ret;
+	struct extent_buffer *node_eb;
+	u64 extent_root;
+
+	generation = btrfs_extent_generation(leaf, ei);
+	if (generation < counts.enable_gen)
+		return 0;
+
+	type = btrfs_extent_inline_ref_type(leaf, iref);
+	if (!meta_item) {
+		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
+			struct btrfs_extent_owner_ref *oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
+			root = btrfs_extent_owner_ref_root_id(leaf, oref);
+		} else {
+			return 0;
+		}
+	} else {
+		extent_root = btrfs_root_id(btrfs_extent_root(info, key->objectid));
+		node_eb = read_tree_block(info, key->objectid, extent_root, 0, 0, NULL);
+		if (!extent_buffer_uptodate(node_eb))
+			return -EIO;
+		root = btrfs_header_owner(node_eb);
+		free_extent_buffer(node_eb);
+	}
+
+	if (!is_fstree(root))
+		return 0;
+
+	ulist_add(roots, root, 0, 0);
+	ret = account_one_extent(roots, bytenr, num_bytes);
+	ulist_free(roots);
+	return ret;
+}
+
 static int add_inline_refs(struct btrfs_fs_info *info,
 			   struct extent_buffer *ei_leaf, int slot,
 			   u64 bytenr, u64 num_bytes, int meta_item)
@@ -1045,6 +1098,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_extent_data_ref *dref;
+	struct btrfs_key key;
 	u64 flags, root_obj, offset, parent;
 	u32 item_size = btrfs_item_size(ei_leaf, slot);
 	int type;
@@ -1052,6 +1106,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 	unsigned long ptr;
 
 	ei = btrfs_item_ptr(ei_leaf, slot, struct btrfs_extent_item);
+	btrfs_item_key_to_cpu(ei_leaf, &key, slot);
 	flags = btrfs_extent_flags(ei_leaf, ei);
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !meta_item) {
@@ -1062,6 +1117,15 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 		iref = (struct btrfs_extent_inline_ref *)(ei + 1);
 	}
 
+	if (counts.simple) {
+		int ret = simple_quota_account_extent(info, ei_leaf, &key, ei, iref,
+						      bytenr, num_bytes, meta_item);
+
+		if (ret)
+			error("simple quota account extent error: %d", ret);
+		return ret;
+	}
+
 	ptr = (unsigned long)iref;
 	end = (unsigned long)ei + item_size;
 	while (ptr < end) {
@@ -1083,6 +1147,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 			parent = offset;
 			break;
 		default:
+			error("unexpected iref type %d", type);
 			return 1;
 		}
 
@@ -1445,6 +1510,13 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 			goto out;
 		}
 	}
+	/*
+	 * As in the kernel, simple qgroup accounting is done locally per extent,
+	 * so we don't need to resolve backrefs to find which subvol an extent
+	 * is accounted to.
+	 */
+	if (counts.simple)
+		goto check;
 
 	ret = map_implied_refs(info);
 	if (ret) {
@@ -1454,6 +1526,7 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 
 	ret = account_all_refs(1, 0);
 
+check:
 	/*
 	 * Do the correctness check here, so for callers who don't want
 	 * verbose report can skip calling report_qgroups()
-- 
2.41.0

