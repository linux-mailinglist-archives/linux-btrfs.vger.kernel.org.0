Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4564E4F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLPAGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 19:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLPAGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 19:06:46 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA85C0DD
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 16:06:45 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E9AB5C007D;
        Thu, 15 Dec 2022 19:06:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 15 Dec 2022 19:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671149204; x=1671235604; bh=DA
        eJtF6tobwxAptAQgk/ly1jmxZLsRod9t9bc2TxzIg=; b=Pr6Q/l5AhytA8feVEm
        1Y503//Ke/h1OB4ZnyeAZmGyVHmkSsDx31kNFd/UVeTrwLVvTgesFJpdceuutMc3
        /HZJSyEIXZrJA2hKuYLDxl20nF0WtCllz6LBe8xDtdeu1EdgqjPxxxH4FcuQOI+A
        UW8scTcyD9jJUzWgytD5LMhROrPrmod3Z6nirfZJMWgTZFvPVeKLqq8EkfXDjxKZ
        ePkMH7YK9EsMwGqrvN50wiNXLUwJ4Zmy5U04jHISXJYMKNwKBdSWy8Ja1eh7jXSm
        UVfSwv9W+/I/oLLSiAfbzHTjaciraOsGri3lRFEYsD7J1Jcw9pZTyx0zuefhLRdH
        0E6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671149204; x=1671235604; bh=DAeJtF6tobwxA
        ptAQgk/ly1jmxZLsRod9t9bc2TxzIg=; b=gm4WfpaLpTOk2IPdZ3wgQEyFE8PeQ
        uIzcZT5oSktN0vF+3QcWin1UqbyGA0+OQlWsbrescZdEDn+GdsvJqAZB1NVa3pnk
        qQJUYr9U3Pe6kt1pGnlUbSymAIwT0ggUw+KK5Yl/7vksDBqDdq+l1Nz2GFLnezm1
        03UaGwQhhF/5/AHrfpKCEEwuYOzGR7Cq4SH00FX8Vh7spk2xI1bHg0I3seXBscXJ
        ioG4qr2JrS49OuFJjP4RjtI+ejDU8xywK1JCEVeIZUSniSyL+9qu1vyhxLoxK+Zp
        hstZhDqkYSB2UY4eN0xKiW1mYJ2/qEslSFtD75FuNut40OzZ7IU3ZfRHA==
X-ME-Sender: <xms:lLabY0X8XqrtrAq9eYdTgXXXwz2mqPduwsVuhEAQG4hoOM9ugZlxGw>
    <xme:lLabY4mDqY5Uetj0EB3aYYDpond6-ra5aKzJqi_7mPoes8wR-WbUPBSHQrXmyonfe
    sAvguT5-fhXeTn8j3U>
X-ME-Received: <xmr:lLabY4ZvBhKr_18eTeQ29mRNnnVd21K7JPZ-JoFbhLX8sIQP-yjTrDeP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:lLabYzVMW728ql45xkx3xj-7GjjqFyOORmLX-r2hpKhnrVRIfUHdrQ>
    <xmx:lLabY-nUdhmU2P6xi6IJw4ih3D181t1z2F_10OJZ4F5VBfIgn6W0dw>
    <xmx:lLabY4eZlHA8XRNB6QZha2ImHDwxlouOq_v1f0gEF0x7_ZxP02k-uw>
    <xmx:lLabY1u3w9KD36KsZUETsWLYdluLb5FBYskwirvXZZaMXfq1DxeXxA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 19:06:44 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 4/5] btrfs: load block group size class when caching
Date:   Thu, 15 Dec 2022 16:06:34 -0800
Message-Id: <aea46ca71307f875c7ed4042c3c8d11def37dbbe.1671149056.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671149056.git.boris@bur.io>
References: <cover.1671149056.git.boris@bur.io>
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
significant free-ing anyway.

The work is done in the caching thread but after marking the block group
cached, as we tradeoff classification accuracy vs. slowing down
allocations.

There was no regression in mount performance at end state of the fsperf
test suite.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 130 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fa1ab56fe6b3..75d5f952067a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -540,6 +540,134 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 	return total_added;
 }
 
+/*
+ * Get an arbitrary extent item index / max_index through the block group
+ *
+ * @block_group: the block group to sample from
+ * @index: the integral step through the block group to grab from
+ * @max_index: the granularity of the sampling
+ * @key: return value parameter for the item we find
+ *
+ * pre-conditions on indices:
+ * 0 <= index <= max_index
+ * 0 < max_index
+ *
+ * Returns: 0 on success, 1 if the search didn't yield a useful item, negative
+ * error code on error.
+ */
+static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
+					  int index, int max_index,
+					  struct btrfs_key *key)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_root *extent_root;
+	int ret = 0;
+	u64 search_offset;
+	struct btrfs_path *path;
+
+	ASSERT(index >= 0);
+	ASSERT(index <= max_index);
+	ASSERT(max_index > 0);
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	down_read(&fs_info->commit_root_sem);
+	extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
+						       BTRFS_SUPER_INFO_OFFSET));
+
+	path->skip_locking = 1;
+	path->search_commit_root = 1;
+	path->reada = READA_FORWARD;
+
+	search_offset = index * (block_group->length / max_index);
+	key->objectid = block_group->start + search_offset;
+	key->offset = 0;
+	key->type = BTRFS_EXTENT_ITEM_KEY;
+
+	ret = btrfs_search_slot(NULL, extent_root, key, path, 0, 0);
+	if (ret != 0)
+		goto out;
+	if (key->objectid < block_group->start ||
+	    key->objectid > block_group->start + block_group->length) {
+		ret = 1;
+		goto out;
+	}
+	if (key->type != BTRFS_EXTENT_ITEM_KEY) {
+		ret = 1;
+		goto out;
+	}
+out:
+	btrfs_free_path(path);
+	up_read(&fs_info->commit_root_sem);
+	return ret;
+}
+
+/*
+ * Best effort attempt to compute a block group's size class while caching it.
+ *
+ * @block_group: the block group we are caching
+ *
+ * We cannot infer the size class while adding free space extents, because that
+ * logic doesn't care about contiguous file extents (it doesn't differentiate
+ * between a 100M extent and 100 contiguous 1M extents). So we need to read the
+ * file extent items. Reading all of them is quite wasteful, because usually
+ * only a handful are enough to give a good answer. Therefore, we just grab 5 of
+ * them at even steps through the block group and pick the smallest size class
+ * we see. Since size class is best effort, and not guaranteed in general,
+ * inaccuracy is acceptable.
+ *
+ * To be more explicit about why this algorithm makes sense:
+ *
+ * If we are caching in a block group from disk, then there are three major cases
+ * to consider:
+ * 1. the block group is well behaved and all extents in it are the same size
+ * class.
+ * 2. the block group is mostly one size class with rare exceptions for last
+ * ditch allocations
+ * 3. the block group was populated before size classes and can have a totally
+ * arbitrary mix of size classes.
+ *
+ * In case 1, looking at any extent in the block group will yield the correct
+ * result. For the mixed cases, taking the minimum size class seems like a good
+ * approximation, since gaps from frees will be usable to the size class. For
+ * 2., a small handful of file extents is likely to yield the right answer. For
+ * 3, we can either read every file extent, or admit that this is best effort
+ * anyway and try to stay fast.
+ *
+ * Returns: 0 on success, negative error code on error.
+ */
+static int load_block_group_size_class(struct btrfs_block_group *block_group)
+{
+	struct btrfs_key key;
+	int i;
+	u64 min_size = block_group->length;
+	enum btrfs_block_group_size_class size_class = BTRFS_BG_SZ_NONE;
+	int ret;
+
+	if (!btrfs_is_block_group_data_only(block_group))
+		return 0;
+
+	for (i = 0; i < 5; ++i) {
+		ret = sample_block_group_extent_item(block_group, i, 5, &key);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			continue;
+		min_size = min_t(u64, min_size, key.offset);
+		size_class = btrfs_calc_block_group_size_class(min_size);
+	}
+	if (size_class != BTRFS_BG_SZ_NONE) {
+		spin_lock(&block_group->lock);
+		block_group->size_class = size_class;
+		spin_unlock(&block_group->lock);
+	}
+
+out:
+	return ret;
+}
+
 static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 {
 	struct btrfs_block_group *block_group = caching_ctl->block_group;
@@ -739,6 +867,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 
 	wake_up(&caching_ctl->wait);
 
+	load_block_group_size_class(block_group);
+
 	btrfs_put_caching_control(caching_ctl);
 	btrfs_put_block_group(block_group);
 }
-- 
2.38.1

