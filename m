Return-Path: <linux-btrfs+bounces-12073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB2A55C00
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26A2189E49A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC122940B;
	Fri,  7 Mar 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Zt4CKgUm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwPnGAPN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C508BE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307298; cv=none; b=N7z8BdnQ+WvT1jWvhP/OhedN4bw/NquZ1c79OfOr0OCnbfpiSDZEKflq+yEKb2Q2hLc1VM5K3K4le1x692RgjMBLD2/ubUtTbqM8XOQqHY8ZrIv6kZEUuH6SACQmnXZhn+hoYoM84uVZZaKjjIbbCNL6gLasrKIulvBwRrDCMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307298; c=relaxed/simple;
	bh=Brsv55xiz6XbuyAwZiyK5xdL5xwTpZ+DzABrVmMXyWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw54pVYMKG9yVAxlSfpdbungMhqSqIqYB+Pod9V6r8ZVpJTdhr6dTzUTh6GraWhMdsd8N5q+FbN4kms7QPlPHx9Q1/JrIMMTCQx9j5gJeOLQLpwN6dO95ngX/2zTgE2LpGYzGWpsqMBBD7fCOomTYTefdC+J+Q8zqSVp6fA1YUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Zt4CKgUm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwPnGAPN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F5D113814FA;
	Thu,  6 Mar 2025 19:28:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Mar 2025 19:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741307295; x=
	1741393695; bh=4oASwHp+PTuoKLofQVT8u6bofO42RkiWG1gho51M/ow=; b=Z
	t4CKgUmCoEeVwE5LGEA66RcNMOtVCdrBQ4N/Hh2O1RpvIo9qOcQe6SzMVlsJxpD9
	+gz646sAbi4rLXTGWrg9xz1BX3COpP9+p7c/0ii6la46Dolz7ycBNiJsPYmpmzmU
	Rwc2OBi/s7W6ZUybn7DxScfjx8tzOV/DQI2pKGwbS/RmwItDs1OOpCa68pyep4uT
	1Wvr1nFSXTPPTAIIDY0UbOJHqX4ESrhpv8yp7wComzPWsw03WGuAYRocY09LMraJ
	XknKxwv/ayO3bFFeU4B+qcquguCru0XQkHv5WT53xNhaDG188aiYBU83HvZ8QSvL
	timKpa6bj2xtxdRfTpB+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741307295; x=1741393695; bh=4oASwHp+PTuoKLofQVT8u6bofO42
	RkiWG1gho51M/ow=; b=jwPnGAPNH6+VmlD0TdzIAgBsEtVpLGHdY/yyt70HYw+7
	nBdw5AaRbuOeokg9XOUwmMiywwUdrZT53Q5vY7AOoB9ZevjA2psZdFlh3XeZz6RA
	OV0QanuUfYCYhiQOFAxUlWc/c07x9x7JsmHs2wfx9lUg90Ukl28fVG3eYl75pWa9
	EKk9jRnK/PJA89hy+MJbD2b7vt61sQfc8Jqv6lambH/BwO/FG1E0OaoK3rwGcfcP
	4esQ+8BNZoJ6yZko/p/GWZSLXZL+cC+ETQSgrYhW3mgB26n+8sy8yATXJNcff/W6
	WhQizgc0ku4kJbK9xw0MStELfdAjBfSbNmXwDYbo0Q==
X-ME-Sender: <xms:nz3KZ4vZwXreBUzl7CDfFju0x273alJz_rUd0Z7fO8NSrhSsCpGKyw>
    <xme:nz3KZ1eeFsxh6zTxrnuCseN7jKPi3d7m13JvNimugcKgVAsQ_V6M1g_tkTpWy-wPa
    GcM3uCETOZMy87VrNE>
X-ME-Received: <xmr:nz3KZzztd5lYLvJHPpbYdkklpv-4T2-bZggiJjYaCqBuwIUKcVYp2iM86KJdXZelK5_RTvB8oXXrYaBdCS_zHeU_Kvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:nz3KZ7NWZxeBryaZayenQZtqreexm09CS0ND5q9zGXaUXSYQwKPISA>
    <xmx:nz3KZ4-ALDKrF4wUBtnR8eW_neAvvMIEe07SXfv2dR60iqT6b5NvbA>
    <xmx:nz3KZzXTLV-aK8ky1SZNjm08kAPV0T43-bTaG4GAjltnFXNx0-rcyg>
    <xmx:nz3KZxcdvs-Hq5SmboxSkUPgIgxkjluiDghaPNbw39tNKPbr8uN3WA>
    <xmx:nz3KZ6JwCz78W94R4MLMv8AkXYS95iwPoFS6IjVfjffxyLbfRu-l_kGT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 19:28:15 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: fix bg->bg_list list_del refcount races
Date: Thu,  6 Mar 2025 16:29:02 -0800
Message-ID: <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741306938.git.boris@bur.io>
References: <cover.1741306938.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is any chance at all of racing with mark_bg_unused, better safe
than sorry.

Otherwise we risk the following interleaving (bg_list refcount in parens)

T1 (some random op)                         T2 (mark_bg_unused)
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c | 3 +++
 fs/btrfs/transaction.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5de1a1293c93..80560065cc1b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2868,7 +2868,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 						   block_group->length,
 						   &trimmed);
 
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
+		spin_unlock(&fs_info->unused_bgs_lock);
+
 		btrfs_unfreeze_block_group(block_group);
 		btrfs_put_block_group(block_group);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index db8fe291d010..c98a8efd1bea 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -160,7 +160,9 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 			cache = list_first_entry(&transaction->deleted_bgs,
 						 struct btrfs_block_group,
 						 bg_list);
+			spin_lock(&transaction->fs_info->unused_bgs_lock);
 			list_del_init(&cache->bg_list);
+			spin_unlock(&transaction->fs_info->unused_bgs_lock);
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 		}
@@ -2096,7 +2098,10 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 
        list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
                btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       btrfs_put_block_group(block_group);
+	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
 
-- 
2.48.1


