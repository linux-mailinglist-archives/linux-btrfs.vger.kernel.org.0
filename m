Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8727F2B8825
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKRXHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:07:00 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54197 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbgKRXHA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:07:00 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 7E2B6CBA;
        Wed, 18 Nov 2020 18:07:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=nXVj75UA0RVNvHxdPgqbuB+m79
        bB9FyBPUnsfg1PbRs=; b=aD8OZGLaQNsaLiqIt1QJUVZlTKdHT12budnWQQGH13
        pON9XEnlljSztlGxYqnBFwPzSE3Azlm/yygVdj/xGBTIhcKUCz9ODoPofVqMtxvA
        DBLzrF+rdWrKz9DiU0nEdP3N66l+xsF/XnB667GWvstoGcmkhDYVMOKXOwgOzA0t
        /yFQ+wIRMr8UbIVOzEQKVzQtOtlRCW144lZF7WJPK6wERCd15gsqkXoLW1ph6r+F
        6hMSZxu6V50HRaP5rRPc8o2fdVJlxQU4Noi7iOgOXQt63S5swgpNg1pyg42YeZ6a
        HopnYxXqnCxtaOxtwufVKWr/plWXnLGRP/cJ4rVZFNvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nXVj75UA0RVNvHxdPgqbuB+m79bB9FyBPUnsfg1PbRs=; b=Q658ZxnR
        HNjIPGkLnQbUDPQlx9sW7QAL0G3JOMkNRlv3AEjvzlf4o9h64JAmzLvlTo8XpGfV
        +TKV3aRabHmpbgJkCmOS4Xq7Ds+F3O6wNb3/7DgWLEPWW6YrupWa6pGoKys8z2db
        aGxTrxgjOhRuFXO1NQe97KwFp8xwGa44zEYNYMyDZ/2T8y4WxSiz6weekNjr3xO3
        xbvBZSn8CuYlYf1fZo1jvF3Bq7DFnbnVHaW53XZ92EFZPCwK/gFKvYr/XDTbXbWA
        HP1hci3C/7c86Osc3Ikc4GdiMsF5G//xPz6DdPNzfQ2F94H5a7k43JGan8mbviXC
        1XLxHQdwTtR5oQ==
X-ME-Sender: <xms:JKm1X4864TFFJn4p4xpISE-87bAXKwQyX5geFSeB7okXoDRIewpsEw>
    <xme:JKm1XwuFTN39n_PQhYLBF_oNFGVl8erRuduqvF_oIeHa0AA4ZBdOERlj-S2WXtx2l
    9HRmXlsD4Ijkgx61Fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:JKm1X-DfoCBj96czDtCTZikvkN-CIQLkS5w5A-Oesluw9fZ6_tk_Rw>
    <xmx:JKm1X4f-BVUrQgZPyOqA7kXIyVKRxNkveMRncG6T-dOJCUKrNCjT8Q>
    <xmx:JKm1X9Nt8ojy7EOKHqZMhHhqVE6htz8qdsTaBOG5OovwumPQ9O9R_Q>
    <xmx:JKm1X0Yu2oxnRbhR7vXZzvgxM5Zk2cZFmvRVnxwqMwIqpr22Sme0hw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id AAC35328005E;
        Wed, 18 Nov 2020 18:07:15 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 11/12] btrfs: skip space_cache v1 setup when not using it
Date:   Wed, 18 Nov 2020 15:06:26 -0800
Message-Id: <4661fbae3fd777faae4ef2f50a41a2ab1842b65f.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are not using space cache v1, we should not create the free space
object or free space inodes. This comes up when we delete the existing
free space objects/inodes when migrating to v2, only to see them get
recreated for every dirtied block group.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d5104560dfc9..24e3eb13f173 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2331,6 +2331,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	int retries = 0;
 	int ret = 0;
 
+	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
+		return 0;
+
 	/*
 	 * If this block group is smaller than 100 megs don't bother caching the
 	 * block group.
-- 
2.24.1

