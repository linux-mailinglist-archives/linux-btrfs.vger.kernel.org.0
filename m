Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AE79DD06
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjIMAND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjIMANC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:02 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C011706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:12:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 78223320093C;
        Tue, 12 Sep 2023 20:12:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Sep 2023 20:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563977; x=
        1694650377; bh=6IvEpnpGHmhKZx01M9taeNawAipMUx6oDLlNde+G5is=; b=u
        HdX+eO05vzCMEW6d5BfskL6e75aVuYxVLhW1v1A6qGALeUQf5H97aQgrlr7NrUBL
        tgrDJ/nck5j+UB9e8bhHs40kxAtTecWWDf43gTfdbFcnthyyBNPKyDgUAAJ64Kz5
        4Ohl3ZCfPe7DvnEqgmGr5scn09rMVI/qK95UVcqfyDbVX24LmZ6kRp9Cuhj+uPy4
        7nJEGI3FD8AF6ODSpyuh2/CGmVTwMFO5BqDtpDq5KPzzyg7gQQ5/DveTs7VTQIdv
        J/MPFCbgnLos/W0VrvWkfcDzWrus52nb4bPjP2l+kh4tVz7eBwdYqNj/L3poW4wW
        zXw6zrDZ9qmnPfUt5DEVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563977; x=1694650377; bh=6
        IvEpnpGHmhKZx01M9taeNawAipMUx6oDLlNde+G5is=; b=Ld+y92jl+aJY3vr+M
        gXX9tEtvxI6GgMhBHsv/Ms2wY6XZZHnGBgQbnx434vxv1sFo9WIGhYUZqePPSecP
        aA33FUAWo5R/d4bsHneMdqqiO1T+q7NgZ92WOaKvxWdcIHQwQwktybM3+8/7lFQ6
        jYMfsCk5WoLF5pdnJR0svjadVKli6NffftYA1faBOek9rYVQ+4zz9i2VXCT+6C9e
        9WyzPV62+I9+OsXRU99tn+QleUs2N3wUsPUCG8lsTVscIZQO9p2PIIbzxbu/zD8B
        b4DzxVG33i1xo6L3gzveoOQqFV0Y3n4pw3mYxtSALGWG7rVsIliHT727+TqzLmN3
        yhfHQ==
X-ME-Sender: <xms:if4AZYNm7_HSI0O1-EB5n4JCBzwHiGCRM5P3SHI9NISiOxsrNLQ2Tw>
    <xme:if4AZe9zwnu2rQNrU-By4EOoRt2cs4rCVclp35QNqqVA2hOqGD870DLmJ2Ilbsen3
    _QvcahXTUBB8pe3oeg>
X-ME-Received: <xmr:if4AZfRuqH93xWkeqWV_ytiEh7JrA4lfcMyMNqLjJifBAjZvJym423Gn1NjOUE3e58ngpT9Wv69AvtMz9t4RBFR-EYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:if4AZQviOdQonYgW_Pkwk289qZ48H00IG-iLwknnrQwqThL-tsb-EQ>
    <xmx:if4AZQflIoY66NpVQT-ZPsBI2yTzJ5q9iAvRVPmDhwqRd0aRxEemoA>
    <xmx:if4AZU1q-iv4qqNJnq5NHNnjopBol25xE4BcE-bveZXxHDkRu2iFYw>
    <xmx:if4AZYn2MM8nsqzcw2OrZyap2E337ov669R6POrzAiWE28kzBgq3CA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:12:57 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 06/18] btrfs: create qgroup earlier in snapshot creation
Date:   Tue, 12 Sep 2023 17:13:17 -0700
Message-ID: <6355e2bf2ef93b5c998659f59e2b576ece7b7e1b.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 84030f81a1d8..ae6ccf1eb0e4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1700,6 +1700,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_qgroup *prealloc = NULL;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+		return 0;
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 12876517c29e..eb649860ecfb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1813,6 +1813,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

