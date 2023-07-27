Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600A765F0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjG0WPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjG0WPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FAF19B
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E9C73320090C;
        Thu, 27 Jul 2023 18:15:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Jul 2023 18:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496103; x=
        1690582503; bh=cdAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=U
        xpJL9LqWYZ4nhbAY5rPEvXmS7PE3JN5aR4j6O3GtYgnfBKIEvxZDNXOTeH7tTBQ6
        n5gJwN5bl4dewbaynaMe3NsQnNSOwr+XGyfPlZyflr9mVMzaVA1prUzF8NINmoZB
        uRTD4PUZVx9toLiZYlUM+VABAeshwJtuBQ+VynMSrW8YJYdj7laNyNXLwUGmu+p3
        ghHGYhH8ClIBZWSdz/VlzVpLoIYZtg+MpwARq2oNaFbB2rZf3kUEmOA0n9c01yzm
        RylQKC8sgGbTbS9WSphUOsqLA5rHjvFmoLs3GQEutFv4EWjpdBYAqJro/ZxnsdGl
        +xN5621OaSP8bnLyzjE7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496103; x=1690582503; bh=c
        dAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=B9vDTWsC5vrwpp8Z6
        cDz/brZBuk1QFBZleS2SmerHHptr8+lBsZzyyDXriyk5tSFE1da+3wEU3SKq7Lw1
        DOLQQveTTpP2nejtt/A5cg+xtTN/lSU1hgkg2ewe0IQSqGDOZ3PVYDBze48HjRNt
        1CPTva/6KPpoI98vlFzR6LVme11O5oceXGVIfc/zII04pzh2Or/Ai+d0WHUHB/Wl
        lvLZj8whYBsimdTdFYKY53PaF8kkvF2IbeJgKGdJ2DDI004NVDGcc+xbs2906LJ1
        ZralEd8B9/hG5Nb7RDoTZyjyt2t0Lo+SsMo4TJMeDZSsSwjDYQCxYBtOpA0kCW2A
        Y2n4w==
X-ME-Sender: <xms:Z-zCZAxPz8UMstqyjLjUsyeMgYwMJsIHKjB6D9LKhh_LnW_YKUHEmw>
    <xme:Z-zCZESMTwn8gnyDJSkyGA9Wl_nqVMb0nwhO3TRlzKky_0O6Z-21ZIvFEwsnHU4qs
    T0LqwhckwtYRYTxsug>
X-ME-Received: <xmr:Z-zCZCUp9KxwNMZqsaNhuE9MPNCcqKqrS-PuDQylPQiG1WBiOf7kr8hIj0Qaw1O0SlfGjkiGmUPLMObelqscaoUNiQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Z-zCZOgu7El928asllua9v9dH4SFwQyjSfWhAjZt4nO17OYvAoUibQ>
    <xmx:Z-zCZCAt2FWoxXMtBPUj9ZS3aTBFIuQELfg95lRbSrw__myXP1ovtg>
    <xmx:Z-zCZPKS_J8A591rkEi-09--Pa0VhLj9TRsyGvUp5qqfPL_hya_krQ>
    <xmx:Z-zCZNplrQaS9eL6d95eoon3nC0N76JkxT9ia70iagXCHvv5IxqiFw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:02 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 01/18] btrfs: introduce quota mode
Date:   Thu, 27 Jul 2023 15:12:48 -0700
Message-ID: <0155748c3e1d0b92d942bb3026c0041c8ed933ae.1690495785.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690495785.git.boris@bur.io>
References: <cover.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

