Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F236A67BD5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjAYUum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 15:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjAYUuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 15:50:39 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2540C1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 12:50:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 92B3C5C02ED;
        Wed, 25 Jan 2023 15:50:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Jan 2023 15:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674679836; x=1674766236; bh=s+
        15ED4V5/W6abgBcCr5twOb4ZpnpnjrcFaoGQJDzvM=; b=JhckGjpjyW6BCxQ/Ia
        u6feA8/aWOt1LeSCaAOk41BQitoY6kNN0nEYhZYhDYyFP8t17Hx79JrBKGLaocda
        xtKzFluKx+5EXC2ZPqOwj/Qttkgk/QcpRk0hHm/jhJI4nHtRbQu6Q1dS4UGzq1d1
        EOtpBHpsjmD+6tghAcPDUnjOCGrulzxAQK33VN06Okhf3CzDtFf29sCHfkxoacux
        8GVGlfQFFrUTC8qAT9HtmDFbY8eoxAcjYNtp04cK1bj1suoswUZm0ikJkQqU5Tnu
        FCUn+xh5IUAZ88MX57if8uEZas8GTO8WX5Q3+wuNhK04Edjeh/IHjAHBfGU8Fyn0
        xkSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674679836; x=1674766236; bh=s+15ED4V5/W6a
        bgBcCr5twOb4ZpnpnjrcFaoGQJDzvM=; b=m76qz6axDjXKlAdHhOIpoC9hMnI5d
        toYzlyH9RJadobKDcxlFXa0lNsLj3kh/Rc8z2tPdBDFTjC6CFud4kHfOUhZljGXp
        PHhDuhxwLyHiRsl2FlvThLFH+SzwPWOyl/7lNNJLsc3oAug166XkOEyAMWShD7mj
        69CuaX0qVpbpByWQaugpE4U2Em84LKma01GEL0Hrtos1zVP2Jo/T/9dBnQv299kg
        /EIO2a1X1WTUi2YVME+ie4HJcvBjjEYZH0vSgBYRWVCSib2u2NWrZAe5uP7S4p1v
        gdIyDFqXaSLx8ldWX1FE1gEFtfyzBpH2zs9svKW8hfI0gQt9RgWUkWqwA==
X-ME-Sender: <xms:HJbRY4yZHAZ5Kidr0RkViO0rrzh0Xcm3TwfMswkqR83HmmOPJuOpSQ>
    <xme:HJbRY8REJ4mlmKuNsqR6FSWJ-QSOxuT0YlHHUNSjHjiCrrO_KTGCARrjTtKdv1zor
    1aawr1tckpVkRHh_vM>
X-ME-Received: <xmr:HJbRY6W3kAFNGKvYOW8gJrZtw3fxRK9j_2absKgi-HZ8tfNJ27-LxAXt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:HJbRY2jbm1Z6sQUYg3Y3jO_rizHYuUHoLrdb_yUv8H_75L_GuOG2Vg>
    <xmx:HJbRY6Cfn5ejxIWluR3oHnLSCBnM4nR7Gs-3NP0naKHAMZYtHENHcg>
    <xmx:HJbRY3JTx2BqdiQ9K4xeUWqyiluUnQALDorZGpYpuUtC-XgiihH5hg>
    <xmx:HJbRY1pE3UNKGpZtItI6ca1HkQjE4igvCkp49-QwuJ63H7vjOfbyGA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 15:50:36 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: fix size class loading logic
Date:   Wed, 25 Jan 2023 12:50:32 -0800
Message-Id: <a88ac5fba9dadaba4c04edd0782d0f2e8cf5b8e6.1674679476.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1674679476.git.boris@bur.io>
References: <cover.1674679476.git.boris@bur.io>
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

The original implementation was completely incorrect. It used
btrfs_search_slot to make an inexact match, which simply returned >0 to
indicate not finding the key.

Change it to using search_forward with no transid to actually walk the
leaves looking for extent items. Some small tweaks to the key space
condition checking in the iteration were also necessary.

Finally, since the sampling lookups are of fixed complexity, move them
into the main, blocking part of caching a block group, not as a
best-effort thing after. This has no effect on total block group caching
throughput as there is only one thread anyway, but makes it simpler and
reduces weird races where we change the size class simultaneously from
an allocation and loading.

Signed-off-by: Boris Burkov <boris@bur.io>
---
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

