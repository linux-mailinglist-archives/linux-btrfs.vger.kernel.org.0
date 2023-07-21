Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46975CD1B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjGUQFA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGUQE6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAE2D47
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 621B83200958;
        Fri, 21 Jul 2023 12:04:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 12:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955496; x=
        1690041896; bh=viAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=Y
        zEP0Cqx8d8oH2RrZJMYeUCo/91JJAM75Yhe4Qk/nA1UZyVlwhWFC6Ds+WJvyZ37Q
        a7NrPQyFzXEG2YlubUf36ry+rJaxNH7RCO/zGcNMXbm0EmL8/P2CoHBqg8dzLt46
        FCzNNIzWIQQzwiYyQLF8mn5aCXvOt3yBG7Q0OYamHMkL+uqKW6UiiBnydjax1iTE
        oZohqMTgN7YWq9cav+wXvDeIooMy3TSlHSg1HHzW5F1HfMVa1D+I0gb/FtqTWSCv
        X0c1Ooq/rmnwojU20QgckLAKZrZc8ZrBDpVA9lSKOpw5PSpUTfeE9Is+SG1D+Ugg
        l+EJLTis+kxrwIgMyvtdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955496; x=1690041896; bh=v
        iAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=JWi8U5XLXFALpcP6/
        YzK7EQVOYKHlEx/imwJZOxDvcLY3spgqedHcmniKbhYqvmwcLka67cyD9PXoA4tz
        gbcKQbIQgWJH038MfE6yH1r7U54kjtdQsKzXS3vCsrkN8zCD8As6MaDg5Wscy7w2
        q1t4IYTr96JUpwjfCDPimil1MUbmip31Bk81HFnt65K11ZJXUbPaQZHY9K1ptC4O
        Eh8ycHsO+/1XpyfC7H4wAobrcUTa55ZkPNOFZcgqktSOYFae2Jcp+NGa+9gQ/TfX
        I7H16vTQYxY7ipmGrsAPEmkehLK7Oh2pV5hk6u85FcmjJafdsaKmIySAIst1FelD
        kmy8A==
X-ME-Sender: <xms:qKy6ZKHOoS_4agfc0k7lMfmX-jRc9VZ__DHeFD2BaC2L67-zJhXZcg>
    <xme:qKy6ZLW86wnjsT1xIiUQnkHEt8P9yfrMC9GKo8p16w0ptiX3nd6Xs7wKdqrqwrXew
    7ZCdPzR0PJbFOMh6H0>
X-ME-Received: <xmr:qKy6ZEJPJulYBPWKeDLzz6HrVrddQkIEffvwWexfNqQFKgl_hsESzVf_2VhvNbFVOP9eVkZSmrhAI_cddu5ZtGEFdks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:qKy6ZEF3QEKlsyICdIuQPzcKme4wSK_YXE9iA25YF_WnBIOCQiB2NA>
    <xmx:qKy6ZAXxxqoXfgLHU0WE7lRN0Hubek_VhMb0VyJ4wlVHmScRPG792w>
    <xmx:qKy6ZHO5wXpUs_HsL0psmT2rg907Zzo3u7rThBo3zwRSACcBNCSd7Q>
    <xmx:qKy6ZJdSAXQaoWvAMemFljSSmMx-c8Ew4dLRuHEoP2uW2Q7mxHH4FA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:56 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 20/20] btrfs: only set QUOTA_ENABLED when done reading qgroups
Date:   Fri, 21 Jul 2023 09:02:25 -0700
Message-ID: <329535630fa186762fbc36afb3ba7b6bd100475f.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In open_ctree, we set BTRFS_FS_QUOTA_ENABLED as soon as we see a
quota_root, as opposed to after we are done setting up the qgroup
structures. In the quota_enable path, we wait until after the structures
are set up. Likewise, in disable, we clear the bit before tearing down
the structures. I feel that this organization is less surprising for the
open_ctree path.

I don't believe this fixes any actual bug, but avoids potential
confusion when using btrfs_qgroup_mode in an intermediate state where we
are enabled but haven't yet setup the qgroup status flags. It also
avoids any risk of calling a qgroup function and attempting to use the
qgroup rbtrees before they exist/are setup.

This all occurs before we do rw setup, so I believe it should be mostly
a no-op.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c |  1 -
 fs/btrfs/qgroup.c  | 15 +++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e2b0e11800fc..874685c84df2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2254,7 +2254,6 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (!IS_ERR(root)) {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 		fs_info->quota_root = root;
 	}
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a8a603242431..1f915d70b99d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -402,7 +402,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	u64 rescan_progress = 0;
 	bool simple;
 
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+	if (!fs_info->quota_root)
 		return 0;
 
 	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
@@ -565,13 +565,12 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 out:
 	btrfs_free_path(path);
 	fs_info->qgroup_flags |= flags;
-	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
-		clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	else if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN &&
-		 ret >= 0)
-		ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
-
-	if (ret < 0) {
+	if (ret >= 0) {
+		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON)
+			set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
+			ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
+	} else {
 		ulist_free(fs_info->qgroup_ulist);
 		fs_info->qgroup_ulist = NULL;
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
-- 
2.41.0

