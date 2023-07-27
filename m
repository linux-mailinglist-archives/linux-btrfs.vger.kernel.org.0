Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748D765F12
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjG0WPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjG0WPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:18 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DF13E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4A74232003F4;
        Thu, 27 Jul 2023 18:15:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Jul 2023 18:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496116; x=
        1690582516; bh=JgLNaFWXSdi6uWAozbbhEQ7kwMFt39/5JiSvxhZRXv0=; b=a
        Zzxz+440cCMtrjCArV1DtmiFfFyNwbCg1zCwu2wzFIFP9RsKzK7JTo4lAPocuNMT
        gc2EFoeqSrRCB5F4hDP51G4RnGc/SO5C+ToUJh5SWFR4Ys2GC0MZpa1UfBSggei8
        L53D5r/dqbFhw4B89ZI2tZgxBLEu37woZPs533yakcp6vo3DFQcBQzIkbqs5JWKn
        Ww1sQtoSRfwFZIkti9leqVDrkUPPM6y4mJThU8FJpTuoBSUHTu0TuM8lYdAb9CR8
        n9cqkrL2tUZxS1qTcLy5IQ1pI74iWHt/gJeMThBuDWc4aTbBkR0tdhD8K7V9p8xq
        5P7jN9yOPShRBOyDPV7iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496116; x=1690582516; bh=J
        gLNaFWXSdi6uWAozbbhEQ7kwMFt39/5JiSvxhZRXv0=; b=xQ1GPd8F4PZ3zd4Zq
        Ycu7GtzCgO6fyM+TdgOi87SNjqXAIWIleeA7f5Sm8eo1F0X7ABLJB4VI+9VDZOcr
        T+LbrhYT+VTgQAtAZiL/nvzpaDExq4lAoIx4O8Cj97zj4U+DegkbJNb/NwWKm9W8
        bq+SVhn1+hx8e6JGIIl4W1L1u95+PDgNXcMXnQ56F75ZQbdBOJRJx42b0C2gAoCg
        3YFl+vPLEa/ADiAldjdL41FV45GmQ85sPA3BrGqrrFCwepql+eeYz5sgXL3NtPiR
        NDzHUCqWqWDB07WXyaaSRXwz0FWLLjSInc0yfro8b4hoYmBrKw+1pNDHFVWwgkn3
        M7aHg==
X-ME-Sender: <xms:dOzCZGQH8ExjGZjs5Rur33HRu6uRt4XQewAFkIEzAXka452oWQyTZQ>
    <xme:dOzCZLwZ_TiVReLYj7OZIo9A46LH8sLT2sli8J_0Ht3G5pjSP4Dlqeb7hSLDl9jix
    BYmSteTF2GPCcHCkcA>
X-ME-Received: <xmr:dOzCZD01k2EBWBFvD11wNB8grIi8XOCoZdrMUItQMaNerV7rrdMW5975XOm-bDOZyWNpq1L0w9Du0-ccY4AycruBbzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:dOzCZCDloQxMil5X8CefTAkO7S8_E_0B97vzS3tlaNYJJ-JOPHsm3Q>
    <xmx:dOzCZPgSjQpF9k1YODR3FpU-3npF9fIaWtSaBPBMZYlZ10xzdntXAg>
    <xmx:dOzCZOp_okpBJi4Bb8rIPaUCMSu671mXxM1gdKj6E3cejBXBxxNKkQ>
    <xmx:dOzCZPLcKL9TSSXHnSJ_xw46pAqSbJWksd-UhrXC2GcNoTg83uRGeA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:16 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 06/18] btrfs: create qgroup earlier in snapshot creation
Date:   Thu, 27 Jul 2023 15:12:53 -0700
Message-ID: <4418d4544e16023fb0b7db6969b657b32cd25f93.1690495785.git.boris@bur.io>
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
index 89ff15aa085f..25217888e897 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1722,6 +1722,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

