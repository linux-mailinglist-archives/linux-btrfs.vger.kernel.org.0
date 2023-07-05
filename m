Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B177491ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGEXhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEXhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404412A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D124A5C0056;
        Wed,  5 Jul 2023 19:37:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 19:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600259; x=
        1688686659; bh=52gjYiNz8XzyDtqbnO3KbZg0Np9UaQt5epFL2VKj0/c=; b=b
        Mr7RGYmzrQ0uSPWYO4SSbEsCehSKc52YX62P2Iy0NH4DxDZE5NpAEzTzU+TWOCC2
        vRg3QbUdsd/wnz3gz8IyeNr2KdiZig7OaKm3IsNZAtSHaBdGyQp6LD01aex57H42
        Ur5QFA5np7awimZPv+mwVhMWcdtThU+4234Yjta4JMZRiHFBHbwphODJYN0V8aWV
        JwQcPHUUyXc3pEZ2nu82wkj54WbjwF+SjxzWCJWeZQP6RtzSTcIS8midk7uOdrv/
        rbzZ0nXpClyiXh5UMiwgGrfCwHaIRyKCI/+w6b5cmHQ3kWHa/bs1G1x3/o+B+KcG
        ta0GQokAcp/qdrNoq/cvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600259; x=1688686659; bh=5
        2gjYiNz8XzyDtqbnO3KbZg0Np9UaQt5epFL2VKj0/c=; b=Rk9O2WhtPPEnBGSuJ
        EvjUFJTQQHzvi3CbQ2r0XBtos3nADq4fuPmv4aTZg43pfdBB8yJ+o1qNE3XpkqTv
        krNQ+6Mk2PETslx+TKF728fcluF1NWVXsDZ4KmeLLoBJWr9VVhEorZi2EJJaqN18
        JBriDyGEprGu0t0peyUk1T/o3BAysMsJdVi6xP9ua2HUFw+TLkwzqP0D6yM3PXVI
        r5db6fSMlgpWbPNprA9dCaEiwFp8tLiEIwUPEm8wS7F2YNC0TYduUssRHsOGsYvD
        biu3vvLPEVHzGhj0PcotI5gV8nuJKKTojbQ+tMwuQeVLuhVywVJ0PHSIwk9s/Kh6
        QVPig==
X-ME-Sender: <xms:w_6lZBqh__BsizlIcC4PPsnmYIgZ8tbr-pARdw76oZnL2fL7ztIw8Q>
    <xme:w_6lZDoQg58SCQ5c6DTzp09o8iTetlGl9PqfQ6OGrgO8n44KUQT1PwcFrMGVKn2ZQ
    azyscr0ePiEoBcisDw>
X-ME-Received: <xmr:w_6lZONcOuRc0B2s9CPGR4FLl_X3YAcZJBmp_mr50A--oWbb_InSywGFtzkdfIrOovUzFRP-Q8PB0FqB7Iz6Dze8Gzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:w_6lZM7qdFwbRfZN9Tqu1TZwPHKYFKeRrcUnh5z8owu_HPyeiQQOgg>
    <xmx:w_6lZA7S6L5KqKrkb_HUzcOSseG3dqB28TnZnEKGPMnCiiWP7VnHqQ>
    <xmx:w_6lZEigqL_h8dUIOWuqvk4LjUE1QHiLtstnMSys4juwky_mrWpZgw>
    <xmx:w_6lZFgTUz3S2jAGth3FP59tiZnZzp0PsWjM_m-fgnrVX6lBkcrk8w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:39 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs-progs: simple quotas fsck
Date:   Wed,  5 Jul 2023 16:36:23 -0700
Message-ID: <929adaf2889519f82cb79db3077eef2d8938a247.1688599734.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688599734.git.boris@bur.io>
References: <cover.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
on-disk state of the qgroup items

Signed-off-by: Boris Burkov <boris@bur.io>
---
 check/main.c          |   2 +
 check/qgroup-verify.c | 122 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 102 insertions(+), 22 deletions(-)

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
index 1a62009b8..0d079f3b7 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -85,6 +85,8 @@ static struct counts_tree {
 	unsigned int		num_groups;
 	unsigned int		rescan_running:1;
 	unsigned int		qgroup_inconsist:1;
+	unsigned int        simple:1;
+	u64         enable_gen;
 	u64			scan_progress;
 } counts = { .root = RB_ROOT };
 
@@ -341,14 +343,14 @@ static int find_parent_roots(struct ulist *roots, u64 parent)
 	ref = find_ref_bytenr(parent);
 	if (!ref) {
 		error("bytenr ref not found for parent %llu",
-				(unsigned long long)parent);
+		      (unsigned long long)parent);
 		return -EIO;
 	}
 	node = &ref->bytenr_node;
 	if (ref->bytenr != parent) {
 		error("found bytenr ref does not match parent: %llu != %llu",
-				(unsigned long long)ref->bytenr,
-				(unsigned long long)parent);
+		      (unsigned long long)ref->bytenr,
+		      (unsigned long long)parent);
 		return -EIO;
 	}
 
@@ -364,8 +366,8 @@ static int find_parent_roots(struct ulist *roots, u64 parent)
 			prev = rb_entry(prev_node, struct ref, bytenr_node);
 			if (prev->bytenr == parent) {
 				error(
-				"unexpected: prev bytenr same as parent: %llu",
-						(unsigned long long)parent);
+				      "unexpected: prev bytenr same as parent: %llu",
+				      (unsigned long long)parent);
 				return -EIO;
 			}
 		}
@@ -717,9 +719,6 @@ static int travel_tree(struct btrfs_fs_info *info, struct btrfs_root *root,
 	u64 new_bytenr;
 	u64 new_num_bytes;
 
-//	printf("travel_tree: bytenr: %llu\tnum_bytes: %llu\tref_parent: %llu\n",
-//	       bytenr, num_bytes, ref_parent);
-
 	eb = read_tree_block(info, bytenr, btrfs_root_id(root), 0,
 			     0, NULL);
 	if (!extent_buffer_uptodate(eb))
@@ -915,20 +914,24 @@ static int add_qgroup_relation(u64 memberid, u64 parentid)
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
 	 */
 	counts->qgroup_inconsist = !!(flags &
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
+				      BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
 	counts->rescan_running = !!(flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN);
 	counts->scan_progress = btrfs_qgroup_status_rescan(eb, status_item);
 }
@@ -948,6 +951,8 @@ static int load_quota_info(struct btrfs_fs_info *info)
 	int i, nr;
 	int search_relations = 0;
 
+	if (btrfs_fs_incompat(info, SIMPLE_QUOTA))
+		counts.simple = 1;
 loop:
 	/*
 	 * Do 2 passes, the first allocates group counts and reads status
@@ -981,7 +986,7 @@ loop:
 					if (ret) {
 						errno = -ret;
 						error(
-		"failed to add qgroup relation, member=%llu parent=%llu: %m",
+						      "failed to add qgroup relation, member=%llu parent=%llu: %m",
 						      key.objectid, key.offset);
 						goto out;
 					}
@@ -990,7 +995,7 @@ loop:
 			}
 
 			if (key.type == BTRFS_QGROUP_STATUS_KEY) {
-				read_qgroup_status(leaf, i, &counts);
+				read_qgroup_status(info, leaf, i, &counts);
 				continue;
 			}
 
@@ -1038,6 +1043,51 @@ out:
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
@@ -1045,6 +1095,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_extent_data_ref *dref;
+	struct btrfs_key key;
 	u64 flags, root_obj, offset, parent;
 	u32 item_size = btrfs_item_size(ei_leaf, slot);
 	int type;
@@ -1052,6 +1103,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 	unsigned long ptr;
 
 	ei = btrfs_item_ptr(ei_leaf, slot, struct btrfs_extent_item);
+	btrfs_item_key_to_cpu(ei_leaf, &key, slot);
 	flags = btrfs_extent_flags(ei_leaf, ei);
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !meta_item) {
@@ -1062,6 +1114,15 @@ static int add_inline_refs(struct btrfs_fs_info *info,
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
@@ -1083,6 +1144,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 			parent = offset;
 			break;
 		default:
+			error("unexpected iref type %d", type);
 			return 1;
 		}
 
@@ -1212,13 +1274,19 @@ static int scan_extents(struct btrfs_fs_info *info,
 				ret = add_inline_refs(info, leaf, i, bytenr,
 						      num_bytes, meta);
 				if (ret)
+				{
+					error("add inline refs error: %d", ret);
 					goto out;
+				}
 
 				level = get_tree_block_level(&key, leaf, i);
 				if (level) {
 					if (alloc_tree_block(bytenr, num_bytes,
 							     level))
+					{
+						error("enomem 1");
 						return ENOMEM;
+					}
 				}
 
 				continue;
@@ -1241,7 +1309,10 @@ static int scan_extents(struct btrfs_fs_info *info,
 			ret = add_keyed_ref(info, &key, leaf, i, bytenr,
 					    num_bytes);
 			if (ret)
+			{
+				error("add keyed ref error: %d", ret);
 				goto out;
+			}
 		}
 
 		ret = btrfs_next_leaf(root, &path);
@@ -1330,10 +1401,10 @@ void report_qgroups(int all)
 	if (!opt_check_repair && counts.rescan_running) {
 		if (all) {
 			printf(
-	"Qgroup rescan is running, a difference in qgroup counts is expected\n");
+			       "Qgroup rescan is running, a difference in qgroup counts is expected\n");
 		} else {
 			printf(
-	"Qgroup rescan is running, qgroups will not be printed.\n");
+			       "Qgroup rescan is running, qgroups will not be printed.\n");
 			return;
 		}
 	}
@@ -1342,7 +1413,7 @@ void report_qgroups(int all)
 	 */
 	if (counts.qgroup_inconsist && !counts.rescan_running)
 		printf(
-"Rescan hasn't been initialzied, a difference in qgroup accounting is expected\n");
+		       "Rescan hasn't been initialzied, a difference in qgroup accounting is expected\n");
 	node = rb_first(&counts.root);
 	while (node) {
 		c = rb_entry(node, struct qgroup_count, rb_node);
@@ -1445,6 +1516,12 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 			goto out;
 		}
 	}
+	/*
+	 * As in the kernel, simple qgroup accounting is done locally per extent,
+	 * so we don't need * to do all the logic resolving refs.
+	 */
+	if (counts.simple)
+		goto check;
 
 	ret = map_implied_refs(info);
 	if (ret) {
@@ -1454,6 +1531,7 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 
 	ret = account_all_refs(1, 0);
 
+check:
 	/*
 	 * Do the correctness check here, so for callers who don't want
 	 * verbose report can skip calling report_qgroups()
@@ -1568,8 +1646,8 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 
 	if (!silent)
 		printf("Repair qgroup %u/%llu\n",
-			btrfs_qgroup_level(count->qgroupid),
-			btrfs_qgroup_subvolid(count->qgroupid));
+		       btrfs_qgroup_level(count->qgroupid),
+		       btrfs_qgroup_subvolid(count->qgroupid));
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
@@ -1596,14 +1674,14 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 					 trans->transid);
 
 	btrfs_set_qgroup_info_rfer(path.nodes[0], info_item,
-					 count->info.referenced);
+				   count->info.referenced);
 	btrfs_set_qgroup_info_rfer_cmpr(path.nodes[0], info_item,
-					    count->info.referenced_compressed);
+					count->info.referenced_compressed);
 
 	btrfs_set_qgroup_info_excl(path.nodes[0], info_item,
-					count->info.exclusive);
+				   count->info.exclusive);
 	btrfs_set_qgroup_info_excl_cmpr(path.nodes[0], info_item,
-					   count->info.exclusive_compressed);
+					count->info.exclusive_compressed);
 
 	btrfs_mark_buffer_dirty(path.nodes[0]);
 
-- 
2.41.0

