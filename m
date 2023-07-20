Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC275BADF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTWzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGTWzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF41BC1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:55:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A6755C0183;
        Thu, 20 Jul 2023 18:54:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893699; x=
        1689980099; bh=viAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=m
        MNm26YsY/vW0xLhFTXP2jwUKoCFAOkrXrOUMXeyDoY68yoLCoYpAviM2iWyi42tO
        UQQNV6AvwCVzGfmaOU4+aP+iR2Wd90b9nisSJIGsrKdJROuFApdx9/mj7uAucSdx
        wadn3+ZV3SgRs652N48PEwLQmFNNtM4yS1RiI/m6sfzmnUeLBbfOC30FQFtsMCx5
        6E6bBbeagRp8e7+lBx6IH6TkDpjcVXhrG/HuLI2G3ohVDaAPVM9sMtnTe2Kmr6mx
        8AKUI0yCOkY1ul+FriYqDJ8rvHt5zsTOOsd0CbOPRtn5Rf3N49ndTfI4JO4JgL21
        DTHZCKXdqmoFZ8FMLEBEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893699; x=1689980099; bh=v
        iAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=XT1fk3h5lma7huSjf
        vntc0vuYJR/MoIatmAfLVsPcK0hSNtBhMdpVwIhWi6B9FD/BPLD+7AILDcdY7oH7
        Ik7XfDleDrJhxNKa9CT7/qJDrJLxnbZooqI8DDwOgWw9lfvhSy0Yoj0Ou7+cAaWD
        J0Qh0fwGxeT19uTyEL0vx0k2pnVTSRuHF665HVlIMXwSFuAkJljIbW1PMQq6L5UR
        Rkq2eE0N3WvTXYqoJ9c3VKFWgmXoh4YPVmVxgH+CBgqs1ruCSLpPC8Hi0CMCa0dd
        J8jKYPa32Zt26zyOVtj1FVp5g1pt3ipqMhzZ2v11WYHm71VQuxF444ZgoDx0g7wo
        B+OGw==
X-ME-Sender: <xms:Q7u5ZA6xXMlIEEWAc_Y-R-vwKjySgnsZTVP9dwFgGi0-k2-dPy48kA>
    <xme:Q7u5ZB4TaKhtyMYVtmQmSkmPM-PhgR8FlYq7VMJ-h4ul8VKj3HD9PMS6g6ZUJMWvi
    8K4jlcurVrJGU9NB5I>
X-ME-Received: <xmr:Q7u5ZPdvhdBdbpKXqDWz2J4z3UcFJNCMGxqJ3B3UJxmz7zc5Q8ZE2MGKzUZlbOzsxBw-26DpjhvWtH1lnhulI-u2FYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Q7u5ZFICAFqhQf0jmv2C-pIWzVZhqyJrEupp3kOwmml9SKfyDuZN5w>
    <xmx:Q7u5ZEJt8s8ILKpDeG_Z6g4ZIIT3moBl30qPIhIM9T_emzHOCg0pkA>
    <xmx:Q7u5ZGxtIM6Egthc8RIg9w7J2E_NQNecX2eQMA0Lc3Waed0FqrYvcw>
    <xmx:Q7u5ZOz0vYEGVKG9U0qj3Nfbx6Owo9UH4Cn-MDJsrwipiwz_tNXR4w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:58 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 20/20] btrfs: only set QUOTA_ENABLED when done reading qgroups
Date:   Thu, 20 Jul 2023 15:52:48 -0700
Message-ID: <ba005e0732d8a72cbe92091ba02ac8aa32edecc5.1689893021.git.boris@bur.io>
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

