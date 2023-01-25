Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3367BFFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjAYWhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 17:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 17:37:45 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3715A826
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 14:37:43 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2149D5C052B;
        Wed, 25 Jan 2023 17:37:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 25 Jan 2023 17:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674686263; x=1674772663; bh=Ebtx3BBy5eScQHlZf0gRMI3Gf
        HIhQlOzuWGpAlpFiKY=; b=i8sJeK1ID4oZcMlrXA6VIfIyj6gj+06BRNqHjJvZd
        xOUdNGcQOhRnHuDza16iOlsDBecEXmCq6ETCqxHW2qm02VlYPFqKMm885iqv6ZvD
        aW3RhQmbgHmTWyNf0wWeUinmuq2DeMkUcPxh2XidKmHkPIoDKbwb24ubPobJQRpf
        w60gNNdJZnUQRlnBgyA7hiDZFg5Wbti7qjjZDAaeubzoUEzsY0gwiWBznU5Bu3VY
        LQF+61cveH0x7YOgwOgZzn01xn8p4otcImRSFEubaenH8F5eB7rdr6tKaZChndHB
        4qniO79mnFJCqYZACu30pLDT/1/v0Ux4Wv8K4CC/DyL1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674686263; x=1674772663; bh=Ebtx3BBy5eScQHlZf0gRMI3GfHIhQlOzuWG
        pAlpFiKY=; b=C2qH2U8QaDKpun/l1zJNIoq8++v0EHNX0qyTZB+1MauIs3nBJZZ
        x53bKvXy4JWUmbab4JqKkGlwkTLP0gqB7UG9zaTpi1mHV6qk0QOuVuK7MxbTkzO1
        7sxr0FIb12Ktl5/pYgI2L88DqwkcNUrff2fiPqNY0zhDzconwvdmO7fkBLi1wpXf
        M8AT9qT3LK+qDHXAz3mY3pwxqIb/lNjKtuG8T3z7SNGYdbewbWwAj/cynBhh3c7+
        8MLm3BiQ9EweICePNTRoC1XqVJiaUwt0sOgtFk6hPbxUlkd7ytMt7AoS+fQRezlz
        QjoB4qXMSlz5qQdq4Gd3p/YGBlm2LP56vWg==
X-ME-Sender: <xms:Nq_RY_9f-88tCBEzF-teod5Aoz4mudAkKu4lM454j7yQ5JU6u9s7JQ>
    <xme:Nq_RY7sVUU_gOfntKIr49aFXiLWuFXi9Q40fdcDCddrJyspXF-kE9AGW0SxuRdg-g
    pEMH6LW8-OMbENT-qA>
X-ME-Received: <xmr:Nq_RY9Ca0Mgj-k7_3CRTOtihGThQo7Ru-UuNCF2pFMU2_2O5YvUM5_bd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:N6_RY7c2jEgKWMr_uBbwMoWNLWZX5BlHc_CfMlp2FRQ8smHtv68YPw>
    <xmx:N6_RY0N60zuSrpE1f6J2UeX2goiSqcwNzCudMnfsVPVK3jIolGNXXw>
    <xmx:N6_RY9ncjcmcZI7CU8_i2_N3LUv3gEWq3Oe6RkZkzEuP_6H8dLqEzw>
    <xmx:N6_RY-VBaCtrpjiWGVgaE945onLvuPtsLptFKr5--nq65ke45iiMjQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 17:37:42 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix size class loading logic
Date:   Wed, 25 Jan 2023 14:37:41 -0800
Message-Id: <1c4c25be5fa66e14ae772f134045f64cf1fb74a6.1674686119.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an incremental patch fixing bugs in:
btrfs: load block group size class when caching

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
v2: just commit message stuff to make it a nicer incremental fixup
patch. Also, drop the sysfs patch since it isn't a fixup.

 fs/btrfs/block-group.c | 56 ++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 73e1270b3904..45ccb25c5b1f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -555,7 +555,8 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
  * Returns: 0 on success, 1 if the search didn't yield a useful item, negative
  * error code on error.
  */
-static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
+static int sample_block_group_extent_item(struct btrfs_caching_control *caching_ctl,
+					  struct btrfs_block_group *block_group,
 					  int index, int max_index,
 					  struct btrfs_key *key)
 {
@@ -563,17 +564,19 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
 	struct btrfs_root *extent_root;
 	int ret = 0;
 	u64 search_offset;
+	u64 search_end = block_group->start + block_group->length;
 	struct btrfs_path *path;
 
 	ASSERT(index >= 0);
 	ASSERT(index <= max_index);
 	ASSERT(max_index > 0);
+	lockdep_assert_held(&caching_ctl->mutex);
+	lockdep_assert_held_read(&fs_info->commit_root_sem);
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	down_read(&fs_info->commit_root_sem);
 	extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
 						       BTRFS_SUPER_INFO_OFFSET));
 
@@ -586,21 +589,36 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
 	key->type = BTRFS_EXTENT_ITEM_KEY;
 	key->offset = 0;
 
-	ret = btrfs_search_slot(NULL, extent_root, key, path, 0, 0);
-	if (ret != 0)
-		goto out;
-	if (key->objectid < block_group->start ||
-	    key->objectid > block_group->start + block_group->length) {
-		ret = 1;
-		goto out;
-	}
-	if (key->type != BTRFS_EXTENT_ITEM_KEY) {
-		ret = 1;
-		goto out;
+	while (1) {
+		ret = btrfs_search_forward(extent_root, key, path, 0);
+		if (ret != 0)
+			goto out;
+		/* Success; sampled an extent item in the block group */
+		if (key->type == BTRFS_EXTENT_ITEM_KEY &&
+		    key->objectid >= block_group->start &&
+		    key->objectid + key->offset <= search_end)
+			goto out;
+
+		/* We can't possibly find a valid extent item anymore */
+		if (key->objectid >= search_end) {
+			ret = 1;
+			break;
+		}
+		if (key->type < BTRFS_EXTENT_ITEM_KEY)
+			key->type = BTRFS_EXTENT_ITEM_KEY;
+		else
+			key->objectid++;
+		btrfs_release_path(path);
+		up_read(&fs_info->commit_root_sem);
+		mutex_unlock(&caching_ctl->mutex);
+		cond_resched();
+		mutex_lock(&caching_ctl->mutex);
+		down_read(&fs_info->commit_root_sem);
 	}
 out:
+	lockdep_assert_held(&caching_ctl->mutex);
+	lockdep_assert_held_read(&fs_info->commit_root_sem);
 	btrfs_free_path(path);
-	up_read(&fs_info->commit_root_sem);
 	return ret;
 }
 
@@ -638,7 +656,8 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
  *
  * Returns: 0 on success, negative error code on error.
  */
-static int load_block_group_size_class(struct btrfs_block_group *block_group)
+static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
+				       struct btrfs_block_group *block_group)
 {
 	struct btrfs_key key;
 	int i;
@@ -646,11 +665,11 @@ static int load_block_group_size_class(struct btrfs_block_group *block_group)
 	enum btrfs_block_group_size_class size_class = BTRFS_BG_SZ_NONE;
 	int ret;
 
-	if (btrfs_block_group_should_use_size_class(block_group))
+	if (!btrfs_block_group_should_use_size_class(block_group))
 		return 0;
 
 	for (i = 0; i < 5; ++i) {
-		ret = sample_block_group_extent_item(block_group, i, 5, &key);
+		ret = sample_block_group_extent_item(caching_ctl, block_group, i, 5, &key);
 		if (ret < 0)
 			goto out;
 		if (ret > 0)
@@ -812,6 +831,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 	mutex_lock(&caching_ctl->mutex);
 	down_read(&fs_info->commit_root_sem);
 
+	load_block_group_size_class(caching_ctl, block_group);
 	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
 		ret = load_free_space_cache(block_group);
 		if (ret == 1) {
@@ -867,8 +887,6 @@ static noinline void caching_thread(struct btrfs_work *work)
 
 	wake_up(&caching_ctl->wait);
 
-	load_block_group_size_class(block_group);
-
 	btrfs_put_caching_control(caching_ctl);
 	btrfs_put_block_group(block_group);
 }
-- 
2.38.1

