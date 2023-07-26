Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8D7640A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGZUkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGZUkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C5211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E19F5C0192;
        Wed, 26 Jul 2023 16:40:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404050; x=
        1690490450; bh=qVHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=D
        UtDT3EkVTePTTO3qeX4UCuMpXF8nLu28uvgX7493YdhQOO/sY57wq2iRlk+ma0e8
        yr9al7EiPTTjhZTf/RFMAzGpLuh1g2Cegw5j810+/NkoimhVZBsn3SI8n9yXYUUE
        JhGJhTnncQTVxRrOGH7YLexa4YOErIRfuXI3lV8SNi+mk23NFP16rApPzko1ivfL
        ynLmkkHNLc2MeGjb1LMtvKBT5hTsJnEljEMbeJ2jcitUHixItT4VsRLFwKNKUzSP
        vc2ph/Qg8xxdqH+CxIPsNdwuAMBR1U0MeDC+njmCCnDWwOL9VXx+q2wh1/JK7rZm
        gjOJdLmW4jpQjFCtvfumQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404050; x=1690490450; bh=q
        VHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=FwNu76+p2T+y3ygcR
        YuKsJ7jL3VK1JUADhzJazd/6G7Nmymv/ZBz32kvQhyHP4mhnjVdfG7HP908HQz3f
        eBMbNXlI1E6R4A/oOq6qMyJ35x8XcYaQv+hV0GK2fDKHV+AKBDo6xWh7Mz3OuY2G
        HqO7IrDDb0juUVtgB1CvSdTMzXMHMXe8BAXRf7s1WhLunGvyypEmtniSFvQPXjY2
        wIPAuKcIByQPej9D59Sn9RgM6pZCvvHRs4rw1D1wDjHjuFgDZO+8kJNGH2mavCmn
        GfKeQ+XynOIZuPGRKGQPM6LcfpVmR1c8wtRaxjK3R04piEldmnLOtQb+7xWSzBkM
        Fn1SQ==
X-ME-Sender: <xms:0oTBZIbx5YKIzYkjBkPZTQv-Jzu90kvmeQ3arRb6rkskTqvTw5OvpA>
    <xme:0oTBZDZWZHaeXC2hnMZXgjMrHOOiodn-7fs3v85DAak3H8xkZ_F2V2vkXE5Fbi9td
    REqbxyAC3GLRFwpGWE>
X-ME-Received: <xmr:0oTBZC-RVdNYHq09QXMcCJ4haO5cKopkgUUr28IDFXN7ykrs3gFzw3LW2Q2gebA6-NdtPJB_1KxUacLSspGDJ5qzmPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:0oTBZCp3FrrBmyj8MmokMq5xnG9JQFsWCoNzskzyQpV8thpIkeGesg>
    <xmx:0oTBZDo9nO21BMTP3rSIPqR6lsl6Uj05LsB83c10IC-0_IXe05LUjw>
    <xmx:0oTBZATK5sglyD7BeeemAHdnmtjfDI5U9ojOy5mFcWatYjcOS7ZR7A>
    <xmx:0oTBZCQFTLhwNlqQL5GETjgyU6Knr4r0Zet6U74ImwcHhOm0vJJ_pA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:49 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 04/18] btrfs: add simple_quota incompat feature to sysfs
Date:   Wed, 26 Jul 2023 13:38:31 -0700
Message-ID: <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690403768.git.boris@bur.io>
References: <cover.1690403768.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an entry in the features directory for the new incompat flag

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e53614753391..f62bba0068ca 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	BTRFS_FEAT_ATTR_PTR(block_group_tree),
+	BTRFS_FEAT_ATTR_PTR(simple_quota),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
-- 
2.41.0

