Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B737640A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGZUk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGZUkz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FC211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B20695C00DD;
        Wed, 26 Jul 2023 16:40:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404053; x=
        1690490453; bh=JgLNaFWXSdi6uWAozbbhEQ7kwMFt39/5JiSvxhZRXv0=; b=L
        PWZXXI65Zfi1vm3kMAXj9ofKOpaAnZkUJlQ/o4WBkjb6blAIqc9fjkHicJ1nMj3s
        IzKqQQxODeoD8AQ4xx+aprmCQO9jPwMDOcl+11zQZi16ih7MIgQyrG2zRTWz8WY4
        EPtO8ogJRYzts/6Xi/hTddxJDIAPFegbOUKqGkJLlb1XGhKW94JTzeczr7yynQpQ
        kBxaVfUDpIeJqfCRx7GYPK4n8UHKJECng5PFGhnQPM6TOs7v/baGSEGiILkns7Lk
        qY1gCGYb5l86Uw1Tz6dcFeGENu6seEtaYWj4kLU+fGf671FPktSq8NI0zDZ2xJNo
        N50oMxXBZGgsHql19czZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404053; x=1690490453; bh=J
        gLNaFWXSdi6uWAozbbhEQ7kwMFt39/5JiSvxhZRXv0=; b=J22a29OS105BtfM2L
        TnfaWmRygUkqHJ0I9YIY29WckhXgEC5v4q2Vw/HPJewcMZe1oUGT7MnxnAGxnTvi
        HMatF2F6b3VNGcOjgv+g1MzgbOe/rEaJdx4CCwHbjPSAGcjCET7Y5JpgmuDXyboK
        qckuP9oH8PmZKkkLOA1BKYw42udVzV4i292QVcc4W2NeS7/U0ALxyKGZFZLcFIFF
        X9XTlJCaS1cmc9u9UKSPjtwvaDF6X1W+r226J/bxWgjGwOdzmUDH+MIPE8DvoEDN
        Fj5reNe49VoLhEdbA29tF/H3OPnq8AtfsM5rOvit0BMgWH7EQ0ZYdEsuryc06umH
        EiSiQ==
X-ME-Sender: <xms:1YTBZKm0fFIUbd7QEJ7SRcA40bkKiYIzU-YATRUzxjLypC6Tk5_M_g>
    <xme:1YTBZB3eKouMMtuwbtsX40vm_pfTNubkBkgTa9q5NbnSXA9rTveM5rSjl5rzXzCBc
    blYNlVCyNgZL8N2I9s>
X-ME-Received: <xmr:1YTBZIr46qQuKk854yBuYKVmE5VG6sBiLhpFj8zZVaCJfNi9nS4wBni1wzws3BEZTIxlSxKt9GZznae-W6Pwz4ZqGpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:1YTBZOk6c2OsM-Fm3mpAIVOZYVxq97axHNJNS4wspINyMBB1skRa8Q>
    <xmx:1YTBZI0vDXiwzx-60Yvr6eWrjs-tZmkVDme2p13h0J1dmQJQmsQvNQ>
    <xmx:1YTBZFuJOJMb7dHq1HhY0NXVH-l1xwOc4-bSn6B0FixElwmPZg6URA>
    <xmx:1YTBZN_c5vyfOWYhpOBQtLLUPSvlAK2O2QekzFwr_DiEK6kAt0onEQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:53 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 06/18] btrfs: create qgroup earlier in snapshot creation
Date:   Wed, 26 Jul 2023 13:38:33 -0700
Message-ID: <4418d4544e16023fb0b7db6969b657b32cd25f93.1690403768.git.boris@bur.io>
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

