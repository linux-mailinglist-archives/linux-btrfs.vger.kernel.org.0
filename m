Return-Path: <linux-btrfs+bounces-12159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD64A5A460
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D827A3ADC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D821DE3CE;
	Mon, 10 Mar 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="EjMc7Po7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxzKDDun"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC71DE2A6
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637184; cv=none; b=EBPDF4nNI2m6lcLLs0aj+DYftZZvzGLAnnDKbRpGHkBRDsKXjfPr1vbjir5O182qbVI3/vxIzK3qnUn8VNKiSOiaOAdaZVknFARp22lIG5t7cRq8tugY4/H7g40vXIKLuR9AmxVMwF9VGoADCHb5m37uSCE1qcvnhJ/08EOPHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637184; c=relaxed/simple;
	bh=xGGT14VPhh/Uo+9JTKMT1PMatod+wRauSDI6CdGptjk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owWH8Tz2Cja8GhGkS871riDlMKnBr43jXEuhlBuYkhSxUshLPBdnEkVkZfnqXPNu47uaCjNFb7f4NgTsqd5tIBXiltYO7Hkjdhi4VKM2n56crdvC2R8hh5shKjCUzIeHlwy3xDNU3fYNrHGPXxxtEHSM2vz3WC0mnt7B+0QFhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=EjMc7Po7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxzKDDun; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DA1A25401E9;
	Mon, 10 Mar 2025 16:06:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 16:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741637181; x=
	1741723581; bh=KHgs5nOLPLlVN3QM8ii9OZ6nLIRyyuZX2L3xIG4reOE=; b=E
	jMc7Po7xu+h4TFfOmEH5RnMUY6ilNyeI55nek6ezW+wLRV/RNQ5ijKsJyLNLxECQ
	F7AjrqHwHXy6jioBIRpNYcoEgfO7v3aSdO/V7M+9JgNCQ+fQhzQ2ZMzVo1XRm+N9
	M7pdmEuhzsae/d9KBeTJQ/dMMwa3/Oh0jsa5GECjsulBfN9xHmx6zXAawre3kJTl
	sF3x0AVdKQzkyXr2Mw/T2TkqnEmaojNWtVdFN5tvfLuWtaCpsyXVjR1AMCR/k63m
	IgJEQEePDZ8/nsNci09cyru201nC+zdNVq87rUWazCHDrC3dXmbFBvOka1lNRI39
	eZMt4OOSXjdd2anfqDExQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741637181; x=1741723581; bh=KHgs5nOLPLlVN3QM8ii9OZ6nLIRy
	yuZX2L3xIG4reOE=; b=LxzKDDunMI7JM0/yfxtsn3mvK/XfHuZsI0QvpV0/cUmA
	Lgfb+n6O0HM0pxsaUdm30GLfI2EpXl7xBOB7vldqNjQxC/zpI6LP8t+j7oBFkDrD
	KIGOIPAF3o5EoTENrFBaUBVzVzx+Mu6to7k8w1eGrJ9YIunZndV/0RB7DCp3msGX
	+MVNH4Ql6G2IICOOeB3x37OXj1lxlYwhl5hVayuROLn21TaeOaqqEkbVAmaA1Ypc
	SiVhV8sIMWCPTyAOHlrQYaDsFMKTXWsvqd/djA67TDrCgF1ZH4iae91TFjdxJXP8
	rp5N/Hh2mvuBTbCZoihA0ZGbCBEDiaTMnO3JERq54w==
X-ME-Sender: <xms:PUbPZ_zhkl912wmKCDWXwXnsAJ-Jl2EriLgSkUhMhGYUZrlhdcDu0w>
    <xme:PUbPZ3S82Mya3rdIfeiN9sBIZyYRgf43X8ZQAU0tRRY32CrO4BDAmm1NV6l4wNzOo
    Fj8YkqWzU6Z3e3vxbA>
X-ME-Received: <xmr:PUbPZ5XN6Ds5BX3XbOnc3pHtinwlav9D79V7Qs5GFF5iO-Yp5kYkky3uQcCu6PekwKELjgKRaPhQe5-RabfjjQW1bS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:PUbPZ5jSEqsT4d5H-U62UFrX1RWS3xfQ232V0kbIJFAzr94ys916gw>
    <xmx:PUbPZxD_m_B_-vVUCfkgfi2A0Sl0lBG3v2uWd1DGkvQiKAKSrVIFtw>
    <xmx:PUbPZyKWOh1WZTQdy43TSv5IFlKBx5rQhPG8d9g9fHv65aicNTxELw>
    <xmx:PUbPZwAKymoeWKbJA9t824mHLyFNs6mTk2ZZwK0Sv9v4Q9w4uYd-GQ>
    <xmx:PUbPZ0PeoXEhWFno8_FY23Zj2sO75STrN1V-fYi4fBMnL2tf9JMBJNYX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:06:20 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/5] btrfs: harden bg->bg_list against list_del races
Date: Mon, 10 Mar 2025 13:07:02 -0700
Message-ID: <35f34b992427ea8a8c888d3e183b9ea024d1dfcc.1741636986.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741636986.git.boris@bur.io>
References: <cover.1741636986.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As far as I can tell, these calls of list_del_init on bg_list can not
run concurrently with btrfs_mark_bg_unused or btrfs_mark_bg_to_reclaim,
as they are in transaction error paths and situations where the block
group is readonly.

However, if there is any chance at all of racing with mark_bg_unused,
or a different future user of bg_list, better to be safe than sorry.

Otherwise we risk the following interleaving (bg_list refcount in parens)

T1 (some random op)                       T2 (btrfs_mark_bg_unused)
                                        !list_empty(&bg->bg_list); (1)
list_del_init(&bg->bg_list); (1)
                                        list_move_tail (1)
btrfs_put_block_group (0)
                                        btrfs_delete_unused_bgs
                                             bg = list_first_entry
                                             list_del_init(&bg->bg_list);
                                             btrfs_put_block_group(bg); (-1)

Ultimately, this results in a broken ref count that hits zero one deref
early and the real final deref underflows the refcount, resulting in a WARNING.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/transaction.c | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5de1a1293c93..5ead2f4976e4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2868,7 +2868,15 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 						   block_group->length,
 						   &trimmed);
 
+		/*
+		 * Not strictly necessary to lock, as the block_group should be
+		 * read-only from btrfs_delete_unused_bgs.
+		 */
+		ASSERT(block_group->ro);
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
+		spin_unlock(&fs_info->unused_bgs_lock);
+
 		btrfs_unfreeze_block_group(block_group);
 		btrfs_put_block_group(block_group);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index db8fe291d010..470dfc3a1a5c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -160,7 +160,13 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 			cache = list_first_entry(&transaction->deleted_bgs,
 						 struct btrfs_block_group,
 						 bg_list);
+			/*
+			 * Not strictly necessary to lock, as no other task will be using a
+			 * block_group on the deleted_bgs list during a transaction abort.
+			 */
+			spin_lock(&transaction->fs_info->unused_bgs_lock);
 			list_del_init(&cache->bg_list);
+			spin_unlock(&transaction->fs_info->unused_bgs_lock);
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 		}
@@ -2096,7 +2102,13 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 
        list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
                btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+		/*
+		* Not strictly necessary to lock, as no other task will be using a
+		* block_group on the new_bgs list during a transaction abort.
+		*/
+	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
 
-- 
2.48.1


