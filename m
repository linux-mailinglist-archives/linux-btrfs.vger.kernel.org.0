Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B662FCC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbiKRS3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 13:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbiKRS3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 13:29:21 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0062E002
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 10:28:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 25D9C32003F4;
        Fri, 18 Nov 2022 13:28:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 18 Nov 2022 13:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668796093; x=1668882493; bh=DA
        eJtF6tobwxAptAQgk/ly1jmxZLsRod9t9bc2TxzIg=; b=lIu0g+i/pLB0JXx8qP
        PN5zpvrHc+2Q6VNtGv4zR2T6tuDwB0kNGJfHXZi7tuYuNOL+md9fN+U4qsCKOiOt
        U6mhCk6MAeJz4K69jn3bWRrchWbDef80OjFFtFOHCRb03CLZCleZrdm1KDlecr71
        pmrVF+/3v+B1wEZ8ipR0Lb3eoZXNdQQyasYzmFVLPi0pox1PQOdpJ3RA5tBnEKwW
        AzmiXVwqoJDHJ3+LwpuCZCYeFSqQ/gdYi6DfjyFsdWC2znYzYBfcGb+nkxwvB8S1
        8EiAeIQTUQap9KE73XEBLfG02JkZfhvv9Aup2gsdN7ScgmjqTrnwH1Bjg0XW+/G4
        CXfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668796093; x=1668882493; bh=DAeJtF6tobwxA
        ptAQgk/ly1jmxZLsRod9t9bc2TxzIg=; b=Sf3hr9je8Ia/+wMPDkW6e4c9ay2/h
        HdwaYlXp45+JpO6RedUqqiqNAk/qjygf7GH7oun3y+8+NXHXt3gZkkltERXPjJVW
        opit6PkTfFp1CIrDE6lq1ZRq9KJX01Ya1saqXQZyEUJasRM0S+rkY51AmB0fgLvR
        K6Sq7p3sTAJxv420AsGeCyWBuAxtzICd9JaG+oMg3sVvwwyWE4kRAmfLkd4u1juU
        WOo3oD4x+bdG1lMACQSFnBGihwKpx64qWAbTXAFPyp8BLHmxyF5QYoDpzn7WgLMz
        6Rz/5D0uWKLQqJlcfNLhzBhPCMu2+t+GApf0ZxXs6a0DX1cQ4Z1xN0mzQ==
X-ME-Sender: <xms:vc53Y-uQSA3s96WSALRTooMVwbWly9__YaYycnYus9zIV6934LqAKA>
    <xme:vc53YzfysoR6-YFH6jM7fjrBkqHVIx-ifcoKpwJymOuRFf3WVJRITcZxA4-tD2v6H
    kpCic4aJOaLdMHsAnw>
X-ME-Received: <xmr:vc53Y5zj4jkBUdS7yuNae1NSJGQS2M-6rcoAoy9KOjyasgRJLQhgmCkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:vc53Y5N9zN7SktY0w_kVTz2sQDO_AQXKFOPmNG51fLfA3VdRNpGE6A>
    <xmx:vc53Y-9Nqw_CVnqnaoM0PkRgKKfHk8zo34w2jkOj5zArwiNHz2-oJQ>
    <xmx:vc53YxWFLy_PP9bXQMag6WQorV09oyHy7kMTxOt-7daF47WLP8i7GQ>
    <xmx:vc53YzFYdlPcWqIR5-i8xnbsqVQI67glyxFWqskjSWkMo8eflvayPA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 13:28:13 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/4] btrfs: load block group size class when caching
Date:   Fri, 18 Nov 2022 10:28:01 -0800
Message-Id: <0c427fdabb4e518538b2ee14d8c211a18fa0e5b9.1668795992.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668795992.git.boris@bur.io>
References: <cover.1668795992.git.boris@bur.io>
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

