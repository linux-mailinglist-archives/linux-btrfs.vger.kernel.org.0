Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F16986D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBOVCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 16:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBOVB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:56 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C5457E2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:59:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8844D320096F;
        Wed, 15 Feb 2023 15:59:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Feb 2023 15:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1676494798; x=1676581198; bh=2t
        O+FB5ytAz8pksUZ+oOfDha2s2wAy6utpIBnygJwr0=; b=CqS/tR3gf9SF/McTcT
        Pm7uWGfigFVeVjH52lxZ9UKzobV8IxBVopwfx68mE4r5nIvoht9flRUiVWIA0SJb
        d8VEQ001jSvd+0dF3jjChAz95eIkIUSP+aPxsAfkLNunVZg1oVLdaZsB0fmmJDra
        SKCuABAB6iAk3rI+cp8VJIYzDcXjysdyAFAZ4oTo9/3Ghs5WEoB8T2FJ8yoCXNVh
        FZ1Hyz/fPF9utLRdDEZ13il8jU1rAek+ju1cGpueMDqQxXUIK30S+L/3WjSDX1Jg
        ON54ZDew/CR4qute+cNsRT2+OJcWQ6hCJKYb9Qx8pTPLE8XiHQWXTzgmg1tHImU2
        ma9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676494798; x=1676581198; bh=2tO+FB5ytAz8p
        ksUZ+oOfDha2s2wAy6utpIBnygJwr0=; b=nFP+58zGWH1ce0hml7hK5anQ5Bzd2
        0v9KrLN6XLPt/nu7J7yL9gGPCLAJ31wdk5pBiDzRrgOiCBl4AojiA8pfcgugs0Hc
        ti2ko7UXOTsY6o2zCiqxHGKU0DqtQqQFEDI/5yasM24zdRKbodWh65Df1wBTZryz
        E2CCAwKWBXdCBFILH/wVdBmIfBIly89Ki+G+mIHNWF2yvJITLnO3izpvaLm4JWc3
        y3wkZ1YuaPXowuQvsPw99M8kZI0Roo0hy6PU0RgLQjd1opG5ITZ0JQMC320l4nrZ
        ADAgv1gpvxqokRM2lWsi1Y/HQkrrHNQqNDtNyt6mO5S5y0mSs64GJN2tg==
X-ME-Sender: <xms:zUftY0JAxUD5tp9V7x01Dv_--IIKWIxj0Enhp2iHhscMbJJC9wwTrQ>
    <xme:zUftY0LEhYyWGz_iA7FoRs3RmN1qkv1WaVUxJbMjIG6MY93yhRH-DgcLpDuQvLWhB
    53mFmBZvvBOKJ7m5BI>
X-ME-Received: <xmr:zUftY0s0gCPl0q4Qmp9lJFA9r-_5Ct8L_QHglXYbKuNqiN9dG6M93vmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:zUftYxYSmdAa3D9IOatn_Npx-Bx0-7KHJOfKwao_jxfblZhA937NVQ>
    <xmx:zUftY7Y7-FOGjbm5VHPX8FtxZR552G8O67ItcKfz1A3I0TbCnWyXZg>
    <xmx:zUftY9CMBSfzsbjjQVYTHjK6irnaVHN_4R54DPxFtUJEr_-OGJOahg>
    <xmx:zkftY8BvJYDRUZL_UQqMjA87mrOOrppcczqoWN_prYSH_QUEDH5_LA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 15:59:57 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/2] btrfs: fix size class loading logic
Date:   Wed, 15 Feb 2023 12:59:50 -0800
Message-Id: <19e54cb085684ba1825709ba0b4e3040950895e6.1676494550.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676494550.git.boris@bur.io>
References: <cover.1676494550.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is another incremental patch fixing bugs in:
btrfs: load block group size class when caching
The use of search_forward was incorrect, and I have replaced it with
btrfs_for_each_slot. Since we only consider five samples (five search
slots), don't bother with the complexity of looking for commit_root_sem
contention. If necessary, it can be added to the load function in
between samples.
The mistake was
Reported-by: Filipe Manana <fdmanana@kernel.org>

The commit message should be:
btrfs: load block group size class when caching

Since the size class is an artifact of an arbitrary anti fragmentation
strategy, it doesn't really make sense to persist it. Furthermore, most
of the size class logic assumes fresh block groups. That is of course
not a reasonable assumption -- we will be upgrading kernels with
existing filesystems whose block groups are not classified.

To work around those issues, implement logic to compute the size class
of the block groups as we cache them in. To perfectly assess the state
of a block group, we would have to read the entire extent tree (since
the free space cache mashes together contiguous extent items) which
would be prohibitively expensive for larger file systems with more
extents.

We can do it relatively cheaply by implementing a simple heuristic of
sampling a handful of extents and picking the smallest one we see. In
the happy case where the block group was classified, we will only see
extents of the correct size. In the unhappy case, we will hopefully find
one of the smaller extents, but there is no perfect answer anyway.
Autorelocation will eventually churn up the block group if there is
significant freeing anyway.

There was no regression in mount performance at end state of the fsperf
test suite, and the delay until the block group is marked cached is
minimized by the constant number of extent samples.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b10401d803b..05102a55710c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -558,14 +558,15 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 static int sample_block_group_extent_item(struct btrfs_caching_control *caching_ctl,
 					  struct btrfs_block_group *block_group,
 					  int index, int max_index,
-					  struct btrfs_key *key)
+					  struct btrfs_key *found_key)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *extent_root;
-	int ret = 0;
 	u64 search_offset;
 	u64 search_end = block_group->start + block_group->length;
 	struct btrfs_path *path;
+	struct btrfs_key search_key;
+	int ret = 0;
 
 	ASSERT(index >= 0);
 	ASSERT(index <= max_index);
@@ -585,37 +586,24 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	path->reada = READA_FORWARD;
 
 	search_offset = index * div_u64(block_group->length, max_index);
-	key->objectid = block_group->start + search_offset;
-	key->type = BTRFS_EXTENT_ITEM_KEY;
-	key->offset = 0;
+	search_key.objectid = block_group->start + search_offset;
+	search_key.type = BTRFS_EXTENT_ITEM_KEY;
+	search_key.offset = 0;
 
-	while (1) {
-		ret = btrfs_search_forward(extent_root, key, path, 0);
-		if (ret != 0)
-			goto out;
+	btrfs_for_each_slot(extent_root, &search_key, found_key, path, ret) {
 		/* Success; sampled an extent item in the block group */
-		if (key->type == BTRFS_EXTENT_ITEM_KEY &&
-		    key->objectid >= block_group->start &&
-		    key->objectid + key->offset <= search_end)
-			goto out;
+		if (found_key->type == BTRFS_EXTENT_ITEM_KEY &&
+		    found_key->objectid >= block_group->start &&
+		    found_key->objectid + found_key->offset <= search_end)
+			break;
 
 		/* We can't possibly find a valid extent item anymore */
-		if (key->objectid >= search_end) {
+		if (found_key->objectid >= search_end) {
 			ret = 1;
 			break;
 		}
-		if (key->type < BTRFS_EXTENT_ITEM_KEY)
-			key->type = BTRFS_EXTENT_ITEM_KEY;
-		else
-			key->objectid++;
-		btrfs_release_path(path);
-		up_read(&fs_info->commit_root_sem);
-		mutex_unlock(&caching_ctl->mutex);
-		cond_resched();
-		mutex_lock(&caching_ctl->mutex);
-		down_read(&fs_info->commit_root_sem);
 	}
-out:
+
 	lockdep_assert_held(&caching_ctl->mutex);
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
 	btrfs_free_path(path);
@@ -659,6 +647,7 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
 				       struct btrfs_block_group *block_group)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_key key;
 	int i;
 	u64 min_size = block_group->length;
@@ -668,6 +657,8 @@ static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl
 	if (!btrfs_block_group_should_use_size_class(block_group))
 		return 0;
 
+	lockdep_assert_held(&caching_ctl->mutex);
+	lockdep_assert_held_read(&fs_info->commit_root_sem);
 	for (i = 0; i < 5; ++i) {
 		ret = sample_block_group_extent_item(caching_ctl, block_group, i, 5, &key);
 		if (ret < 0)
@@ -682,7 +673,6 @@ static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl
 		block_group->size_class = size_class;
 		spin_unlock(&block_group->lock);
 	}
-
 out:
 	return ret;
 }
-- 
2.38.1

