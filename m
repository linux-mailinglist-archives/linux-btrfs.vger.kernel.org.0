Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C845F5ABF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJETtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJETtj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 15:49:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF68CC
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 12:49:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D7DFA5C0121;
        Wed,  5 Oct 2022 15:49:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Oct 2022 15:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664999372; x=1665085772; bh=5u
        8fAVxRoI8o5bWXQiIYZVMC3/nQuZLdnjSVvLYjGQc=; b=sd4G7T8reXFEkn3MIT
        ddoYcvnifvNBru01718L+JkXPH5fzfsTbUnSFNrnueKi9sq+9K/oPO5EwWZftWEx
        RtXHMPfNW3/1uBijGrWtVbWy/CkNtB7WzIjvHKRVn+a8Z/55/DO97cGrIL/q2kwv
        LDX/gSpKXLznGz58LGEAz9IVahTjaVzCw8bpax05PP0VawS+ZfH0bKlp+IHwnOId
        pinKKT9Ymo22oLoSzHP1LtnbjQEYSfjLPAGfaANEtpM3Z0kP7oN58weBB7zIGZHF
        ESNh1cqcdfC16k/3GOaLVu0ojj/cLH1nLY8vYMWMakpT+V/emM3yiE4icUTmrrnf
        NPMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664999372; x=1665085772; bh=5u8fAVxRoI8o5
        bWXQiIYZVMC3/nQuZLdnjSVvLYjGQc=; b=b8D85MoLylqsfpNgSkmOfzzqA//by
        pFRHiBOS+Dn/N6ofG20jlElZQn5/USJMLNdbFIjUD4K1o1cti57k454065QfSD11
        EZ7QjCI87lUxA0tbWVJQcjPUNBMn8VQeg/15jYgXM4ffHDC2Me7IJ0g2XLsfH2wE
        UAuqrgioW1tNLxZfamqpitSN99hGEk8wHeNnkZ6kQrzneBdB0Knj4z6qWQKJboVZ
        4F/MEKPjNBzioZ1v5SQH0TczY/d+dCUxoJZHAHsEDNI1KkRuf0AZq9/+KDitRaXA
        Ho/eYT7BBvOGLuI2UIN6Hf44a9akTpAn2z2TKZ05v1DuY8LujVx/Tcd9g==
X-ME-Sender: <xms:zN89Y0oGJ7nltAK2apLcRi-n74jI0EZxqgndz0M0_OzICcpWiobzEA>
    <xme:zN89Y6pFciUpHO0584eIcIz5L5sc4_i-gROCqaqt3RaFN6W6z6qOvff_16wfPFLVu
    jyh_JXFCXvAYpu5xw0>
X-ME-Received: <xmr:zN89Y5O9VjhzPFHqZQtkojP-zi9FVQj1xjkY1SyN6whQa8v122KVby6XZy4LAcekvpxpfB5RGi9axwoDTL6rYl0l9iHIqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:zN89Y741qG3RtA28K-3x5cebqJE6-QBkhgQi897XGULsGthRgrCRWw>
    <xmx:zN89Yz5aU1xH1GVK0OHI_ckbW4D6FKJR94mLuUBNn4QoFtXu102uRg>
    <xmx:zN89Y7i8n6g48dRUWvw0jCxBsN5LSabkauZfDLmfC1w4KOWUWtO8aw>
    <xmx:zN89YwjaeP6do0il_eTCFPs3cSPCN6kFpBDVQHU1Fl7_VvhXYCxbTA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 15:49:32 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: load block group size class when caching
Date:   Wed,  5 Oct 2022 12:49:22 -0700
Message-Id: <9ba155f3d9ed5c1025dc0f497d621171df06d95d.1664999303.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1664999303.git.boris@bur.io>
References: <cover.1664999303.git.boris@bur.io>
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
index d16a982aa593..26cae88d3659 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -527,6 +527,134 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
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
@@ -726,6 +854,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 
 	wake_up(&caching_ctl->wait);
 
+	load_block_group_size_class(block_group);
+
 	btrfs_put_caching_control(caching_ctl);
 	btrfs_put_block_group(block_group);
 }
-- 
2.37.2

