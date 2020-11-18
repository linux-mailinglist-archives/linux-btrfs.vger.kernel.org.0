Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191942B8819
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKRXGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:34 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42875 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:33 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 25696D1B;
        Wed, 18 Nov 2020 18:06:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=o/qP6jVfo7jqebTt1uvcTepx+U
        0+6+5bcy7oaUSqaUw=; b=wRcWWahU53oHTPxvGVcqiL+evull3vb19CK1f7RYBA
        ll+bd8j8ZDAbdBlHw3W8gdjeCnqEnGtzyMkLPrmRdvEU7RVQ+yJF+Knd5RKjbHMm
        YmKf2UfgaxpV9+GNJZxbsryiCuDUPitI5ngx/3HzbCM0wOMcdsBWj25GtjJ2FL6h
        ZO0ZkQ9V39mLRKA47GslxmAlTggXmZ6fN5ccF+4Km/R0jTAFFb6dFkZ+C8XrwXjK
        CVBLiyF3hiUJoIJEDkdjc9oEmdW0BP8OctmrDwWAVD6YR6VPUfAkEPGbDltE6OOc
        6UCnA88hsYUJICi/dT2QXU0O0gA9EdWtsLastqgjshXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=o/qP6jVfo7jqebTt1uvcTepx+U0+6+5bcy7oaUSqaUw=; b=Hr6xtLxK
        mkI4AsZA4cKrWngWhvyODZW/FUMSfupYPY6MlbXFNPZiIY3tKDi/vuJZS66vjhWm
        G4/FMnxK8rQfiu1F0gqfbwE9grL+ojyVhWTTKmxujVQcKIR4i777/9D23gXR8H6h
        89qomdo7+k7MVp+T92HUFsWirHPJ4kXJstGfOcGyVn1QMV54/Xw/yH3am7otcZVV
        N6Jpxl5t9hSJWsWXoLjFh8kopfSgF7Fn7i13jEx9ZCKUZfk1aYOZ3ZeXgbVU1Lcw
        S1qeowsOS7vlh7xrfBBMjEfCCS8BWmjns6nQVBQB3YXJSFPd/PHQ0CHUHwiaw1YU
        E2uH1yettfoD3Q==
X-ME-Sender: <xms:Cam1Xxp3myy_EEkvW8vc7-kFV6zjpj3LzTpZx498GKxO0fDJoOCK_w>
    <xme:Cam1XzouIUvLlzH9CUQvozSKzlx9mS8u5V9H50Q1_1Q_0teT4Ksf2xN5fzQPzibzu
    bDFCgWuwgbRBNVv53Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:Cam1X-Miga1GPuQEGkiteyir_IgkiU8TX7-lzlj7r0lqOnPRw89ipg>
    <xmx:Cam1X844ey3OtErx7FoKEUELIxxzwDCCsqjMtrq74QBDunNdwqjbNQ>
    <xmx:Cam1Xw4IrFApOkQ4pegD5RgUFG4GCxNWltD9-DKNirTk1WHXmloaaA>
    <xmx:Cam1X1UuI29NCaIbVUIIGbNkQGIv_Ig_V2p5AZEcaKI9LJIiVe8HlA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56E5C3280064;
        Wed, 18 Nov 2020 18:06:49 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 03/12] btrfs: only mark bg->needs_free_space if free space tree is on
Date:   Wed, 18 Nov 2020 15:06:18 -0800
Message-Id: <c821817babc7501e53657501c5803157924fcb4e.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we attempt to create a free space tree while any block groups have
needs_free_space set, we will double add the new free space item
and hit EEXIST. Previously, we only created the free space tree on a new
mount, so we never hit the case, but if we try to create it on a
remount, such block groups could exist and trip us up.

We don't do anything with this field unless the free space tree is
enabled, so there is no harm in not setting it.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ccc3271c20ca..00e2fe1d0f32 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2156,7 +2156,8 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	cache->flags = type;
 	cache->last_byte_to_unpin = (u64)-1;
 	cache->cached = BTRFS_CACHE_FINISHED;
-	cache->needs_free_space = 1;
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		cache->needs_free_space = 1;
 	ret = exclude_super_stripes(cache);
 	if (ret) {
 		/* We may have excluded something, so call this just in case */
-- 
2.24.1

