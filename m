Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595297640A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGZUkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGZUks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E44212F
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DC3E5C0161;
        Wed, 26 Jul 2023 16:40:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Jul 2023 16:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404045; x=
        1690490445; bh=cdAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=o
        P5EQ0ArY7mU1oeTCehUdoBvZOD3YWqiI4d22bqyfkhRRLCW3k7tj6PKKQSl1/+zc
        CTcZc4rtCWtdhCiz6YUFm15PrqZIrKMkxScSLS1KdygGT3UPfy9oNT6gk+UdT/q/
        RwZZHEWnnNQpI2ovGo5TPyB4XcAPZLX3c7WZSb8eY55WLFMMRB6dsfSvC11C5eAy
        XfBhwfgUHlaWwkGx7xnEROD8TzteJaQrcVUp6+T2KRFXHEdSQ+KkSMOM0gLKwVq4
        v/wzLBCzqP2wwNqatSDE1rW28C1WxAiet0fOq1FRW/IepliLI+nU++vj0zAA2zbw
        PSJeGBz4WigUZmznHn9rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404045; x=1690490445; bh=c
        dAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=AWKQxG60oqH2o4x7Q
        uAZ5kxiKn1QQATtHDvmrEauUNNgWQZefRqH33x7sZp0HjTKsD42cW1y57dCTpZq0
        IY0kbQnAydfvpXuZLenYJMbwa5rG2oFU0xtbmFKz8YbxJ+j5RxhP+N9TjLZOdU7P
        gNqWZHUZkzeD7aDFQBNZOBUgeOxPA+kTbrj77rQ5i50Jn/wcDtqVl5/iJFSx/G0K
        ieJ3TsBFoJP8YG7szVrOINnhQR8inFnYyKg2a6tRh3Sv15lN4w+hP325g8mgfmva
        6n1lM736D2NvPUTa7LRrwn3veq+oNXvvFMpdxFVvzDwWyJTb7iFTWMUUF6ghZbLX
        1Q0bw==
X-ME-Sender: <xms:zITBZItxt-B3XT7-jjKVNZv4inw6R6Twr6LB9ROqTEHfL15fQTXdvg>
    <xme:zITBZFdWOPzCOoJYZPCWUkL3wWiOjgqZFvxD0AtRvW5LKMAX-aTZDygjJHzKLlk5Q
    qYp54ALhcLYGZB8Xiw>
X-ME-Received: <xmr:zITBZDxFIwNRuao075Wlby-W-BG8xJVCJTgZ2AFOq5rYU0C6KVQUPUo9X4WudQ2SOhpZvb887InIVrXzfHEn4vwH7II>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:zYTBZLPOayaOY0g_MOJeCY4efbkQHWxQt_JEfCnqpvUuzZ6AvEbmLA>
    <xmx:zYTBZI-Y4zqlqc7xr850cSF_6_BZnlq8MqWEHvqPBeqJqrel38C_VQ>
    <xmx:zYTBZDULs7RkcNlH9AQqwFSjZAYeRhPjfSx62F8OKX9_AFscioC7OA>
    <xmx:zYTBZNFNhb3Yw9xXI0o0OaWetZrllGoqAq5WEbFPz-00xQnCjU8nNg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:44 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 01/18] btrfs: introduce quota mode
Date:   Wed, 26 Jul 2023 13:38:28 -0700
Message-ID: <0155748c3e1d0b92d942bb3026c0041c8ed933ae.1690403768.git.boris@bur.io>
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

In preparation for introducing simple quotas, change from a binary
setting for quotas to an enum based mode. Initially, the possible modes
are disabled/full. Full quotas is normal btrfs qgroups.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 7 +++++++
 fs/btrfs/qgroup.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2637d6b157ff..0a2085ae9bcd 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -30,6 +30,13 @@
 #include "root-tree.h"
 #include "tree-checker.h"
 
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return BTRFS_QGROUP_MODE_DISABLED;
+	return BTRFS_QGROUP_MODE_FULL;
+}
+
 /*
  * Helpers to access qgroup reservation
  *
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7bffa10589d6..bb15e55f00b8 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -250,6 +250,12 @@ enum {
 };
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
+enum btrfs_qgroup_mode {
+	BTRFS_QGROUP_MODE_DISABLED,
+	BTRFS_QGROUP_MODE_FULL,
+};
+
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
-- 
2.41.0

