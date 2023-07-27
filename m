Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF56B765F22
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjG0WPw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjG0WPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:50 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB8213E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3CFD332000D7;
        Thu, 27 Jul 2023 18:15:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jul 2023 18:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496148; x=
        1690582548; bh=viAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=X
        jE1m/kfsRMw5NSzVKaUfUjYk9qXteZ+ac8sFn/94XKsEMDYbI23hvSOI+jwWkJC3
        ZvFqWRuD/P1BHZGMqDRzgt3pvVHa1YWUnfz8iV0SQBT0I+7DG23wJAEXxVWEGEtP
        MTrj4aANz5Kl+715axTmY/BSVG7KD1OOH+bBjnn9oYipE+Jfk3/Y4i7O3Ete2Y3v
        TjpyP8Py5+k25ls8tt7Gkxb4q5MqBN/6ETRgcFu1wVVhY7OPiItJheTED6XNKO8K
        8U+lnRPrEGBhaVCrhnA8GuABv1xnJUDnZn1IjVSx4hlc4isySsf3WgDIJT3+bpqs
        WCJwQOF131/lwyzwqLzPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496148; x=1690582548; bh=v
        iAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=FYKs+PGos8Psk9i2p
        ZaeRweVoj/TOlf2NmxLQhWg0dtkZeXtpiGcIvyc79ZvAZkahgNtsmwuxR/JDgyGb
        /aKHftuqeaBSoJwxr52HkpDzbauyax0YTZmADpyBsqWVavgbBK7KxjXEUXENmdtO
        nH3Y48xKBNGz8zfTXbW+8jiXSCBQYTvsGgNTJbj3EMYhiVOio5HX+FZpeSNMx5s8
        FY0WIoKA2lTWTf6JK9ttJ+WFDt/kstzBSvZRB45ySffEYLJoZRMzi3b7VZtBsm1I
        EoJifnEraWRzhuWlV1ZD7bA0dK47VWSebXSiKHWlWFbmbOYKofWfw6YGsvxYn2ho
        i3x1w==
X-ME-Sender: <xms:lOzCZBvSjNV8PjJuMUGb9VOQAiE_e1rgywDn5RWtBtNMUO647zf3zQ>
    <xme:lOzCZKfTk9S6mDH1eKTran0pkN1qRghcyNuT8723ZqbStx_ANCzDsGEYHk757cbp-
    XyuVPZHQLQqRHjO5bM>
X-ME-Received: <xmr:lOzCZEyAbTrOOUPhItO_R6zXTkf5UCnMDsjs9F2-zgj3ecS4tVavTlGii92h9OMAxFvjh6vcc_QoTcTCj9-4c5lRC1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:lOzCZINU17RW5naU0v0RW2KortCBatXtZKP5WKAkUMZFn-omHMzQJQ>
    <xmx:lOzCZB9ypDQ_0Q_I0NfRjdq28tY_8nUR7HMsfcQLaZUlvGy6relVng>
    <xmx:lOzCZIUNB8CSK9MVjCrH9lY-Bq00W0qvSvHQKS7N5__gGasMClTQMg>
    <xmx:lOzCZOHaFXIXcVpIMtZIwbdjTSEXNz7-XdzEiya_euIr5nkBRYyTTg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:48 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 18/18] btrfs: only set QUOTA_ENABLED when done reading qgroups
Date:   Thu, 27 Jul 2023 15:13:05 -0700
Message-ID: <e834e5ffa72d6eb19163164b8e822f6879cd7381.1690495785.git.boris@bur.io>
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

