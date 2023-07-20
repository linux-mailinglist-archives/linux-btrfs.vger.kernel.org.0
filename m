Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE075BAD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGTWzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjGTWzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23582D47
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 657B05C018F;
        Thu, 20 Jul 2023 18:54:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 18:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893679; x=
        1689980079; bh=0CHJNzZM/RWpi00nm5zdyC75DLQb8CIIgheWCiHULTA=; b=a
        /yQbLh2KJhNWFtBNaoKEnqr7gXY+iU3lET1WMqYHuii8rsGgSs1v4TWz6EFdnT00
        fLsIqP4X8eQMxAi/LRwICOysLHOmCQleBf4rcx3JEhPNVPT6VREI7w9JhfYLuSAo
        1DkS1AL5HbV7Bl23I0fc0Yq/hip9rMUFrLrnawzchzYaYySaiY3AmR4mogVc/tzc
        ym11aapv/Ld/l42UBLt1HhfjAySbX+a6Il3VXMm2WHx16UMEwM4EeScUpQ/OAgy2
        jKgtI+lLgY3awzNB3i6h9krxKHcF+8k6MtGlWXpHDr8F28do2doabYX0HeIVUcjC
        xO8FVzJ90+ZgJ63ud+ojA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893679; x=1689980079; bh=0
        CHJNzZM/RWpi00nm5zdyC75DLQb8CIIgheWCiHULTA=; b=xf5zoHs9QIXTWZCz0
        LXFuFq6tyGHwZp0bwXXs0y75DWMaTB2MVQm8zz78gJutI2y2qUbaVW11FCt0MUeg
        70T1nWJh10bUm0YEg9ngG5wJSlezaBXNXoizpoZW+hDLdtPO+WJugG+/9oq61d6u
        JpPMCsSh3fxgFBy42PYcpwkFlmDqEPEO+SKETLoqfvPbIWOQlGXIRjF6XN787IGZ
        H6p5XNXp5TVVR5RswitAg/ihmM94w6kB4z49C55ccdHK4Sm6I6acnaIiYl8oR+Ar
        vxMJmjli8le0w3vFz7PGtBFcqRJgPrGkBK3Gl3YSw0O0fZOdhX+hQreDSUnTfJC8
        Gl8Fw==
X-ME-Sender: <xms:L7u5ZKUakN-tWwtt6zuX21z2HSx8_HVouuJxMnMEXPwdjYLZEb5Rgg>
    <xme:L7u5ZGmyXZaic5l56JL6UGtwHk_b3ClOfuaJnb_KwuiMJ-7jS6YpP8OdmIAWbBK_9
    8IfLFx8pC6XkCW6stc>
X-ME-Received: <xmr:L7u5ZOakW7LslqoefggjBpGw14VcOzP4kuTK7zNA0movzULFCFQpzuWv3tUIBIu8i8fhqlxiXK1y6GC8SUTLGv-KsrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:L7u5ZBVGFwQj1TDNn04yz6gX13UwviZS1PNaHDrQiba_h1XrSpypbw>
    <xmx:L7u5ZEl5f7RS9D2Ho6TpqxVCXNq4OUcp_P7heVHyBETgREPzVKgpXw>
    <xmx:L7u5ZGfWcP_HxddBFH3Vwgoq_ygJ8DkGl-uAtqH9-bqyTyUBdPM29w>
    <xmx:L7u5ZLs4xsD9eRDa3q7vGxJJFxXrrieNuhm2_bRIHCNvlj65s1r7Zw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:38 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/20] btrfs: create qgroup earlier in snapshot creation
Date:   Thu, 20 Jul 2023 15:52:36 -0700
Message-ID: <91021c4a6d5cd9003744d5283948d04c761b76f9.1689893021.git.boris@bur.io>
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

Pull creating the qgroup earlier in the snapshot. This allows simple
quotas qgroups to see all the metadata writes related to the snapshot
being created and to be born with the root node accounted.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c      | 3 +++
 fs/btrfs/transaction.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 18f521716e8d..8e3a4ced3077 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1672,6 +1672,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_qgroup *qgroup;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+		return 0;
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index df3db36515eb..71213083f97e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1716,6 +1716,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
+	ret = btrfs_create_qgroup(trans, objectid);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
+
 	/*
 	 * pull in the delayed directory update
 	 * and the delayed inode item
-- 
2.41.0

