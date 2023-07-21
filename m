Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8E75CD0F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjGUQE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjGUQE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:26 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E563E42
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A46AF32009A7;
        Fri, 21 Jul 2023 12:04:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 21 Jul 2023 12:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955464; x=
        1690041864; bh=0CHJNzZM/RWpi00nm5zdyC75DLQb8CIIgheWCiHULTA=; b=d
        USQh25D7RGpY8oFiZ+CqMJRIybRDjMwj3pAo+EawCvqk+nbjXAu47xuaKHlnNl45
        Ls0c37JxdLhXjaJnGddooqs6zlHQ0pQ179+i855+iMhHiel8hmj2pTLqBwoLaRUS
        hJIw+loVeeYRqA/ldyd/Euk2k2hL85EooNl1B7nAsAJzIl8Jc0xqxxaaDbQFoJ0J
        iPn73/11k0VSZfZlc/kvubU9FBMFBSnhVnqM1livwCxlbXRUp9CiOXBkE83IwQe+
        o7G3F1dz+y/li89hYg9YFwU8vdYLlfj3ruUo+QzdhHFOoe+sIwo8KORMJAogZ1UK
        gsBnjl8UQsYOBsBPobuvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955464; x=1690041864; bh=0
        CHJNzZM/RWpi00nm5zdyC75DLQb8CIIgheWCiHULTA=; b=ruu24fucUARMj5+xa
        5PABQuedXASWcxxU6bpN6Q7XQ3cP/dkjnJIBlveIo6bT0Bq1BGaKPbyjTZF8w36B
        bqk7o15VUft33CwuIBfo4YU0UnV47JWlBnYj5UnsE6KSHq9OKSpvBfO0bHqCKePV
        4M3nhc5BCEsvAOaRWtNUWELXdkE3HZlVzwlO5MqCl833jKvg6sqn3mT5NHbpVF+L
        rFefiZXT10nX6/dMhlHK0yAnTq/GX1iZ7cDESmQSwdKFd5mwmXJlas1lrdwjnEtb
        qa+kcWpiahbBScTjYbbvA/pYudpnHC/Vz9TzgPjJ207QS5Wf0YAqZBm6Z8kUGZD/
        z1ibQ==
X-ME-Sender: <xms:h6y6ZAXa1UUZ5PLMsQ0LtPIU9Gz2Oj9mJecmsSs99VJ2wpQ4E9JJPQ>
    <xme:h6y6ZElugHjtqTOHrpJ94hNVC51cGNXu0PvyXjAfKss8Cha2dcRjM-aSfRTqJ_VT6
    6VStS-M_6IKB6Ph1o0>
X-ME-Received: <xmr:h6y6ZEbjcKK0-tSEzM_ogbayyJkcKCeNqEKYJlZ2xgyhC3CEvNa_RPpbcHftE8u1OXi1VXrjbvj1oxY86ZiuleWQ4MY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:iKy6ZPUUrRP1Hw0CpC41Bu0_-Ws45UlFLsLyKzHci845xJnK5zdBmA>
    <xmx:iKy6ZKnOpeW-IZsyIt_U10AUW7rY_0E9XX_1l8Arx1sKOkZfMeinqw>
    <xmx:iKy6ZEdw91EuHp5QqDkCaypip6DBFF69zjAxGDMqwFvFqRtm4e0xMA>
    <xmx:iKy6ZBvjIIlQ2GkjnIcED9rkm6ISLHgj3feYnQH6QdHmKLoGFN6mlA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 08/20] btrfs: create qgroup earlier in snapshot creation
Date:   Fri, 21 Jul 2023 09:02:13 -0700
Message-ID: <91021c4a6d5cd9003744d5283948d04c761b76f9.1689955162.git.boris@bur.io>
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

