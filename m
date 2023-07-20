Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC42075BAD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGTWy5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGTWyz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:54:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421CA2D6B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A61565C00F1;
        Thu, 20 Jul 2023 18:54:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 20 Jul 2023 18:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893670; x=
        1689980070; bh=cdAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=a
        F7RIusnb956H6CYn2ZU/oK/8T+yA76GT2J25v0cMGyvMgs64xiAtywCGtNGkmtcA
        DXTfxdLRI3tIahMrPTUgLRwA+GWqSlr8VyQOQi6JFj9YAK7hwghi3QvQJIXUmheu
        /BoycBwrB4xLWUWumRp/0/UeezlsgYbMLCoO1APfLWFZp8jhNkm5iP56I+yVcnd4
        j0BOtN+cgwlo4Cun7Zj89Kmeu42ql8Sk1p8t1YqLoIe6jePAkKK5DD4lyHd1F0Ep
        sR+JyQyFX5Mtq6aqybOvh63JCfAhVjLjInNCxIgPkNVHlRcTOqbwlvfdateR6JhI
        m+gNpcdmbu473atGGp52A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893670; x=1689980070; bh=c
        dAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=lwEzO0kAhsUgkoR7c
        PVGF6SkGhf3+bOqBHFxrk9Rrm1CF4pOG2Ww+eVAuwOCGJEBwAFWqZu5zNyj77YqN
        F49bXYufPKpEeIkXmet/fUmf0XeKQWbvj7rF2RLmNtbSRKYZWkgLy0xZvvYfgdIy
        t2ywVmF3ZEIVOEPkLf9rSHIHYESdOZvHi6raNv+8Hxj7o1kyCn0XlfibmfCrD7ZQ
        KnrwpRBH2SIrtSdSNWdqRGTQhK844cEFVnzKLib88CcxF8ER9yubFMx85w2RKr7V
        5sL20ShVTKoqrZmG8vtri9KABU396fOvA8G9f3Ax/S78gGnSvAgqSwjiVA7j3ZBe
        +9g5Q==
X-ME-Sender: <xms:Jru5ZHh7IjcnkY8dFJ8MzKNwAKZxaKvQUNDuv5O3ccPlD3ww5FwDsA>
    <xme:Jru5ZEB-Mp9HhgyxXRd6B1H5DlmKcu2u4qNoY0TTXEGjG3BQ9NpAQ3k6YDyR67TXi
    RwW2EexZ_bGAiI6YCQ>
X-ME-Received: <xmr:Jru5ZHGZTQBud6vxv9SAmGSsDTF4Wb1rxW68coqylgXpS5aq1_TmqBNfxKdJ-lSHsgvTxIavXQl9chJOFWIkMAkd1mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Jru5ZERH9Y9o4UdoO4h-Zg_77INuYlYASTGWPJ52G8wzBB7eSCH8SQ>
    <xmx:Jru5ZEw0apAU291abg-0yHyzUUGAOHqRD_HamJCSXJ1A0Es4BrQH5Q>
    <xmx:Jru5ZK4oK4ePGUQC7ioTO7SBLtzdsX4VyvMCd8ZsVmP-cy8zsxi2ZQ>
    <xmx:Jru5ZKYT8MBSsH2UYv7hUVlgWVT7En7Rbd_rAcSK7nA0ZXC65E28Ug>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:30 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/20] btrfs: introduce quota mode
Date:   Thu, 20 Jul 2023 15:52:31 -0700
Message-ID: <1f49b7f9cfa8480d54b0887f0d69f349b7f42e52.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

