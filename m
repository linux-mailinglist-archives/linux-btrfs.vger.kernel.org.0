Return-Path: <linux-btrfs+bounces-478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0F8014DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACCB4B2116C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6160259B5B;
	Fri,  1 Dec 2023 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="AmFtPR/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Inc1CjCL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6610C2
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:59:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id AD3B45C0152;
	Fri,  1 Dec 2023 15:59:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 15:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1701464343; x=
	1701550743; bh=4PLRxsAkKGOULGwrl/bBXsUKf+Xgsyg4yVEAj580wDI=; b=A
	mFtPR/eMBvD+329hisuKPvWUe4/Y7o67S8e4n9DVqfulWhhb//4KrgYLuCuaaZfu
	hcI8l0hjxsKhT2ifFQjZvF8TAqk+NnuyXA+s3X1Pibe1zSCo3Ovjmw/jNAvwxyKz
	7Q2GIt0BkbNxPIvjypHikIBmqLaLeLYfn1we1+Gib8eZ9INhVnbrIvjwL15Q5MSB
	47cNWfO7xAjK1H59ZZr9DX8yRLeK8tviggveveidfWU9myH514/5EfiKSAQ4vBl2
	2+xnQdZ5tQqL+iz281IKer7SynGQUiMq+rZT0ZlTFP6wrP5+RLQavY9QcwDPLjrE
	kAbc2LHCTcfbgQfOfCbCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1701464343; x=1701550743; bh=4
	PLRxsAkKGOULGwrl/bBXsUKf+Xgsyg4yVEAj580wDI=; b=Inc1CjCLqsPwaDf0s
	HNdBxU97qznbx1wuCLOfKJtCtuZ4Vs1rKxd85Y+21OqJ8Hj9zyp3yx84fwY/kh/0
	zfOkkczYz1XzI6DskhnfS46fZHb6O5uqgXJaFbNuauOEuuk8krR6S3nkFbBknZ0e
	zdiqUSpJa+GxMbWy/dqRaT2APMqoqZvbt8r+Rt+s4Ry5O1e5wBB92SKeb/tOuSEb
	AQIAe+W3/6xabvdTYsmwPEDFYZLYIBcioEbVs9zmAJxyDnjwioaGub7oUD/nMfT5
	ONIzApcJ1Vkyad1zjvQxEk49jEG+0Bt1NjvYun3N+HQHlVlWH2+ytn+tt4ijCOsT
	kHDkg==
X-ME-Sender: <xms:F0lqZRFifGtn4zoxyRnCGql_mVXP-HFdkUgTseYeTvtoG5sYx2UoSA>
    <xme:F0lqZWUjs_FDDpu_vSHyEICfpomGzP0gJNZalgzBt9NvT9ZU3pipOzypAvo4kxLBB
    CGBiUWMm_o1OkqC9rU>
X-ME-Received: <xmr:F0lqZTIojwm5sLXEmzgF2YNrQ1dxIeGiY-wFHqdT_NpDtD3LC_AxltX58Au88PuLCr9a_ywBJveg831GYEoq2qB71v4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:F0lqZXF1DF8RnXyOzj2FnUMWKbKQdez0P6zohJbkE3Q9BJBydor6iA>
    <xmx:F0lqZXVLQSjSomnrp7va6utrZucDkpXczSM_sboH-SqQ9Fp_ab3VUA>
    <xmx:F0lqZSPbWlTm-2tcwZh_UpKa-C3ZS1rv6tohav7YMOTLb06Z3HypOQ>
    <xmx:F0lqZYdZ8iqy801gjl_CFMHM_ZwO8M3lIx5WWOQh-MAHQ2vUFYPN0A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:59:03 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: free qgroup pertrans rsv on trans abort
Date: Fri,  1 Dec 2023 13:00:11 -0800
Message-ID: <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701464169.git.boris@bur.io>
References: <cover.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we abort a transaction, we never run the code that frees the pertrans
qgroup reservation. This results in warnings on unmount as that
reservation has been leaked. The leak isn't a huge issue since the fs is
read-only, but it's better to clean it up when we know we can/should. Do
it during the cleanup_transaction step of aborting.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/qgroup.c  |  5 +++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9317606017e2..a1f440cd6d45 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4775,6 +4775,32 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
 	}
 }
 
+static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *gang[8];
+	int i;
+	int ret;
+
+	spin_lock(&fs_info->fs_roots_radix_lock);
+	while (1) {
+		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
+						 (void **)gang, 0,
+						 ARRAY_SIZE(gang),
+						 0); // BTRFS_ROOT_TRANS_TAG
+		if (ret == 0)
+			break;
+		for (i = 0; i < ret; i++) {
+			struct btrfs_root *root = gang[i];
+
+			btrfs_qgroup_free_meta_all_pertrans(root);
+			radix_tree_tag_clear(&fs_info->fs_roots_radix,
+					(unsigned long)root->root_key.objectid,
+					0); // BTRFS_ROOT_TRANS_TAG
+		}
+	}
+	spin_unlock(&fs_info->fs_roots_radix_lock);
+}
+
 void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				   struct btrfs_fs_info *fs_info)
 {
@@ -4803,6 +4829,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
+	btrfs_free_all_qgroup_pertrans(fs_info);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a953c16c7eb8..daec90342dad 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4337,8 +4337,9 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 
 		qgroup_rsv_release(fs_info, qgroup, num_bytes,
 				BTRFS_QGROUP_RSV_META_PREALLOC);
-		qgroup_rsv_add(fs_info, qgroup, num_bytes,
-				BTRFS_QGROUP_RSV_META_PERTRANS);
+		if (!sb_rdonly(fs_info->sb))
+			qgroup_rsv_add(fs_info, qgroup, num_bytes,
+				       BTRFS_QGROUP_RSV_META_PERTRANS);
 
 		list_for_each_entry(glist, &qgroup->groups, next_group)
 			qgroup_iterator_add(&qgroup_list, glist->group);
-- 
2.42.0


