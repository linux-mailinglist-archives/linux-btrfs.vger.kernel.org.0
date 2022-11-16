Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8150A62C8E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 20:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiKPTWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 14:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKPTWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 14:22:15 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C15802E
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 11:22:15 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 719E05C00B7;
        Wed, 16 Nov 2022 14:22:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 16 Nov 2022 14:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668626534; x=1668712934; bh=DA
        eJtF6tobwxAptAQgk/ly1jmxZLsRod9t9bc2TxzIg=; b=RygvDyYh8tp6sck53T
        xu0OlSmV7y+LvxvZ/nKNnsK8dWg+z42BA3JlXiBWM+fNW0w8T/SzbfC3OXZsANR4
        39ZypgvggoGvGXq17qnY724C3+iLN187lb/zmMD0eb0D6CSjrUNCWXLeZnjTPkKP
        MZLAxpwM2MKU2ewgiIMyLwXtd6UpZ+PvcV/X0GWQRlBOWE61SmEibaBCVm+EcamS
        R8VkbkOGVnyddl8aC9oim/4nDnoxHJzzkO+4xYvvYr8Tgw8aqYqNoCngXLLandEh
        Dk6Uf5GPlDk91us7BniELW84LQvAo37K1566mEwx4AYufEjeJSn5aR++5dDserUM
        xO0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668626534; x=1668712934; bh=DAeJtF6tobwxA
        ptAQgk/ly1jmxZLsRod9t9bc2TxzIg=; b=fsemfvXwZUQAE1ZGRJ01Q82edBYmk
        Z1Oeb6aQKAheN8CLfVh1GlAMwur+IkBKo4aIr7sDFScVnrbRlQGkW1cBq0ly/uM3
        //TmJwknNSTMzJ9mh5o/7Pj9SgxlarmRkDvwLyVaXtbAPhUWdV8xQU1g7lpEm99M
        sCbL/AKzy6VeRJw3z5HJi0AJHbvSNJbjzEAj1tk3zwoWtX052OKyLd1idD6N31fw
        +Qx0GNu+IjBExKzEMsuh42tuU1wyCuyUFPShHwD1yTDr/5/aduIleBU6kqGpNFB1
        ZDdcchXMX8aRT7m3bkGXpYIdwWzbTXrjG/IBy1jXVa4n+EV+yaaxZAeAg==
X-ME-Sender: <xms:Zjh1Y8kTRt-trY_ZltRYR_CciiTLbbf0JeX0q0V3cXo6GYxigJ7wGQ>
    <xme:Zjh1Y70e39n9Kx-sMUyyWpEgpFl4gZIRqRiP3vNVBWtw4scp_ASz8q8hCThIhFH8I
    ctLGw3DT68EacG3FBM>
X-ME-Received: <xmr:Zjh1Y6o8Om2YM4EVwXHXOnZzvXsCw3Ur_EAouXY4KiQKfz_wP2tVLEqB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Zjh1Y4n853GFUtYAdwd53O2oT8CLxKo4A5UfD_ngOsqaFyGP_LmoRA>
    <xmx:Zjh1Y61gOcWA0Da3T9zThClVf-A6tsCdHNBD4Ki6UEbdEAEeqBH_og>
    <xmx:Zjh1Y_szrCybrlWy2ageU0iIUOQnNnrMf64hEznJdlvkniyCFhkwoA>
    <xmx:Zjh1Y_-EDsPXPrMi_5QEtUIH_9g3HuUlc2VFFO8g2QuCnlAYmGIqUw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 14:22:13 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/4] btrfs: load block group size class when caching
Date:   Wed, 16 Nov 2022 11:22:05 -0800
Message-Id: <b0bf853ab9d2039ce883a5bc2086f8833c528ebf.1668626092.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668626092.git.boris@bur.io>
References: <cover.1668626092.git.boris@bur.io>
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

