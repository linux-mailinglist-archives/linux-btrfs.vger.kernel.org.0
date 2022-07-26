Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DC581B44
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiGZUmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbiGZUmq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:42:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2837137FA5
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:42:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CF8A5C00CB;
        Tue, 26 Jul 2022 16:42:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 26 Jul 2022 16:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658868165; x=1658954565; bh=Jb
        Y/5+P008h1WrqtW3b0ELKLKSHZVIbkMW3pRXo6Q1c=; b=SRJu1AGhx1CZm557sG
        O4HACAn9r70paKS8spAI8EZsB40+VeCb6gc7cDR3ObPj5bxMUVMd05PPqtggBbna
        sSoEQbMFDRBtddb8RhbIzorZRagzLOlNGqVdmzxtVFnszUFcqR0LiIubd0u7bSDw
        KaZWCetas8cMuJr1yBFexASn8G/2JLDyDdAQxg6jdVZRULCJxnpu7myWSCdl4iKE
        paf0TjW2sLv24hPykcPjrdl4p1evIhJhpuK6REvpBS36dPHUTfWtXcyR48x7zApp
        s0+a+rARO3yFUsK4jMIfC+DZ0PdWY351mq1D3MRKTQZtO8LcT7kF/xiJoxzRFnpX
        VXhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658868165; x=1658954565; bh=JbY/5+P008h1W
        rqtW3b0ELKLKSHZVIbkMW3pRXo6Q1c=; b=tN2j4+vFFGSiPUlmajWi0esjRNAM2
        QPya7sA65CMdbT+VS9c7fS3Ep7Kgy08YRg9C3elrq2JAlcyQfaObQbXj88TAAW5T
        +Iku1xdKVpGkJCHzezMWciSf4fJ+mNquRmMy4W6HHU/N19sbv+HhrXOx/2Lj+RKu
        4NlEVN8BMzRSQCcGL9GRvlfYDHJkmrD7tfpLrOOMQhezc+ON/SoXwznN0GhEXj8X
        Kq+JYPj6MI8tGJ/I13zHHxr/ceL2z+uKDNhnIMibM9SgIKrfEPaguuZcL4RE1giN
        NLpDBDMqiO7ul6/XFi966B6WeKhY50I/+DmMenqVduGAegcFugtavh5DA==
X-ME-Sender: <xms:xVHgYnp3QJ8xdwTj7wwAt89fvnjduyk4_IWNRtpsfRKFribX9BpPRA>
    <xme:xVHgYhqXOPJsVRQe0Jb7ot69z29E0IDDFPVX-uaMB7cE39wyiZnsNWE3RT2wXqDbI
    0ETl4-9H39vPAztIgM>
X-ME-Received: <xmr:xVHgYkMKMsmrixrAuNB-QQHqgbck85dtjdcfM-obSAC4Hrtt_49IOMz6MyTQAgKmoX59Pmg50CXDZcnXF8WQIfLgRadpIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:xVHgYq78LXQAWTSVAD4KnFVt4GWkuR399BxrU-ZUHnk18HKuj4s7GA>
    <xmx:xVHgYm6uRNlXNDq_11oSaUjWQa0XKDEdYd0zvSZeVHHR21weD7E-Fw>
    <xmx:xVHgYii1Q-mXeeefgdNyrIJZHJbOiUwXcCzURAPCQD9d2q3FcgiJwQ>
    <xmx:xVHgYrgMz0Qjk4ohxQoGdf3iZ76wEtNZygt8zpnzp3UA9l9SA46NnA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 16:42:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 4/4] btrfs-progs: add VERITY ro compat flag
Date:   Tue, 26 Jul 2022 13:43:25 -0700
Message-Id: <363e74574fbad5252749b0a87e20e45e95c70fa0.1658867979.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658867979.git.boris@bur.io>
References: <cover.1658867979.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This compat flag is missing, but is being checked by mount, and could
well be present legitimately.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/ctree.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fc8b61eda..2070a6e51 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -484,6 +484,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  * tree.
  */
 #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
+#define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
 
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
@@ -514,7 +515,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |\
+	 BTRFS_FEATURE_COMPAT_RO_VERITY)
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
-- 
2.37.1

