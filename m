Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAE26E39D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIQSbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 14:31:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55691 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgIQSbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 14:31:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4821F95D;
        Thu, 17 Sep 2020 14:14:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 14:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3TNmGDPNYcSrl
        uzWTGYLMRVlfFber1rMdlo8lV9Jf7M=; b=aP3Li1Fq6eF985/BFxXDiKnPeeLg5
        LrSQMjBT2ZcO4R638T5Lz3OvgApuV1li73vUPmd3UOraNPlHUwK+d0G7LjkbLA+o
        k03XwoR+v6VswPEQuOSgcguPFV/WwO7ZnMENCLRp/J+y0F5Hu/OWJTeDHjuM32vX
        kKJl3KAwlEo3G/Mp26KLTftRWQfI7ykSpmCY66Lw+0BXa0HaCS8ZXvt+r6zBTtr8
        NU1n9ND/5c+q7qiouD1eOIwqDqfRyRqax0k/krQYqa529Y1O+PbKS49YNHjqssap
        3mvOLRBIExdu+6uNgS8sBW6lkjqB+pTS3YFqt2fU62Loi9VPcCm8Xzv1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3TNmGDPNYcSrluzWTGYLMRVlfFber1rMdlo8lV9Jf7M=; b=Th6aAXec
        HxUYh4zRjHu1HBNAm5ckY8D8h04hwYJMJZhe+FJH3T9ptu2fsZpc7uDq6m29zo6W
        5WNQai8pUqXSBseaxl7yhqpXb5hFt6XkI/L1hkYQ+0UvmUGY5oXjlv7wJCK9znkV
        v17Kj1BSudJ54FgOZ4d+i2rubzkmL+lNwEgTv7JDEbFRu1ZIpQQc4C4KS32CZIR3
        ioZZLAGhZqa0Fh9j2iH8z61eMVQcN13hQfoyU/5j25YSfDyr8U2zEXSxwyDpic2/
        DXK8yLbnFjA/YjMZGtaSETZ+X7qZWnlc6y0AJzsiiIutehMDzOTIljRwzoCDLhI4
        UkfxNkbw8r9tzQ==
X-ME-Sender: <xms:eadjXy8kE8SngRbxUsKCLE0nF4z4dlvA4D9HFLwOQzYByXuSRrurOw>
    <xme:eadjXyu-8hOe8cQh49D3JvRE-mUNTIt2TRsMXZXjHruze8yIwHaYm4HMF0T7GKUzV
    nAV44m2qJO0tQUysvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:eadjX4DyOSaF9YYr5snTtT_py-Q6slBDPAHMf6mDwEb1FeuSRUdomA>
    <xmx:eadjX6esbimwgw_oOUABxgqW2vaWsPaeQxXNyN2Hm9p0f_geYbcqAQ>
    <xmx:eadjX3NRdUvoMzIkSKIHdTNBItHLJaiScpMgrj5NcokTfHp8Dgy_lg>
    <xmx:eadjX5Xf4p-XO0UTeHzsgEE7PQpKezSzxfHE5HJwUnQSf2nml3saOg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 553B93064674;
        Thu, 17 Sep 2020 14:14:17 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH 4/4] btrfs: skip space_cache v1 setup when not using it
Date:   Thu, 17 Sep 2020 11:13:41 -0700
Message-Id: <2e63f1a18438150a8d4029c6b77ec8a661b6a3f6.1600282812.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1600282812.git.boris@bur.io>
References: <cover.1600282812.git.boris@bur.io>
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
index 717b3435c88e..002b3b3d9a30 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2308,6 +2308,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
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

