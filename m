Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4464D765F0F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjG0WPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjG0WPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:10 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9313E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 45DB932000D7;
        Thu, 27 Jul 2023 18:15:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 27 Jul 2023 18:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496108; x=
        1690582508; bh=1jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=m
        3iyHf4jF4i43MbbqSoLQ5nwMM9H9Un21bKGfFOBUo9JFXWew5cCizB4sWZbYWq+d
        QPEAwbfGzeRlBIg5GtLn2xb8VV/cD4lF3+2b2YNwKlGNgapO6fQpat2068/rfpeM
        EdTwjsmkQJ8CKCdTqMXr0g/KgOxHZxeddJGVymGmlAaDqxGr5pRS20Uiep1Q3Qi8
        EQOBAV4sm7voQZGmx6jKLS8qScGD9HERIw9dS/5IEPgxYz3XHwrhsq1BRLq7ZZuB
        hK54tzJ7xg38F6caBCdjvSXMudqFCVtvSFsc9TvEP2RK4DBWT0hUyGRdwiFd/MIx
        TJr8fixxq0+sSr48AXPmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496108; x=1690582508; bh=1
        jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=ycl1tWKsUkKdG9Kx9
        0HZKYLfPw6+50CwqlSDb+/+nItZdfVUYeha4DBrU8EmXwpvX09Zqe40Oz58iQzOy
        b8hCHofZZn77es9b00joqtwFooLcNTzYk+2VB8tqGCcKQKrRJaen1An73+4cehr/
        ZYGSTikhbkbOdMSSYO+Atj9zleBxe66AhHNf5j/JmVGTwOaK5m8vDd0csf/nJYfV
        0iScPz2M6Z/PJ5oX/l6feXigjczNz6l6nKMLRxRoSD8o5nhaqkH7GxAKcQUxIxky
        yuYcyFcUIOpPSHs7vna6KDyU2ninMefW/b8h0+THt5SUWPtBC/3eWsgNdxxWoRFR
        ihapw==
X-ME-Sender: <xms:bOzCZGIsH3Noo-IT76mzGF1YK4liMGQkULFjRj_J4fZeZ_ITd5IBxw>
    <xme:bOzCZOINdDRDtXJP_dsosBdfZ5vAnxXsBTip7URzSwmGDwDQIeaWXM3t_TO70QF3z
    FYpPtTeFi2Uvbsgk6w>
X-ME-Received: <xmr:bOzCZGtNm1nxjhz9vxyWj5Tt9GLkPW-CtAt029QcxXON9b7WdCk5X3YFCVpujZkqgPVP4EBWtzj2Qq_qBtSmVZ-J-K0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:bOzCZLaENRwzTxzlqwrTP2oByg5BmYGmieRmVBVWR9ekw1kHbKuqtQ>
    <xmx:bOzCZNbJEIBbr5Y3cCIUC3sO5IvusFcCy3FQ2AhEtL2Wgk9rJe0zTQ>
    <xmx:bOzCZHDQqsKvwQnr7QS18kquRNLIfsmRd-c4C9XFNFtQjHckvJZrrw>
    <xmx:bOzCZOCM3s8cjsI4Sh-0tS2jYe8gp1UWuzIktyzXW_Gbhvyj97ulxg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:08 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 03/18] btrfs: expose quota mode via sysfs
Date:   Thu, 27 Jul 2023 15:12:50 -0700
Message-ID: <9c9d150a93e91a5a648840ef77240e81b70ff769.1690495785.git.boris@bur.io>
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

Add a new sysfs file
/sys/fs/btrfs/<uuid>/qgroups/mode
which prints out the mode qgroups is running in. The possible modes are
disabled, qgroup, and squota

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b1d1ac25237b..e53614753391 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2086,6 +2086,31 @@ static ssize_t qgroup_enabled_show(struct kobject *qgroups_kobj,
 }
 BTRFS_ATTR(qgroups, enabled, qgroup_enabled_show);
 
+static ssize_t qgroup_mode_show(struct kobject *qgroups_kobj,
+				struct kobj_attribute *a,
+				char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	char *mode = "";
+
+	spin_lock(&fs_info->qgroup_lock);
+	switch (btrfs_qgroup_mode(fs_info)) {
+	case BTRFS_QGROUP_MODE_DISABLED:
+		mode = "disabled";
+		break;
+	case BTRFS_QGROUP_MODE_FULL:
+		mode = "qgroup";
+		break;
+	case BTRFS_QGROUP_MODE_SIMPLE:
+		mode = "squota";
+		break;
+	}
+	spin_unlock(&fs_info->qgroup_lock);
+
+	return sysfs_emit(buf, "%s\n", mode);
+}
+BTRFS_ATTR(qgroups, mode, qgroup_mode_show);
+
 static ssize_t qgroup_inconsistent_show(struct kobject *qgroups_kobj,
 					struct kobj_attribute *a,
 					char *buf)
@@ -2148,6 +2173,7 @@ static struct attribute *qgroups_attrs[] = {
 	BTRFS_ATTR_PTR(qgroups, enabled),
 	BTRFS_ATTR_PTR(qgroups, inconsistent),
 	BTRFS_ATTR_PTR(qgroups, drop_subtree_threshold),
+	BTRFS_ATTR_PTR(qgroups, mode),
 	NULL
 };
 ATTRIBUTE_GROUPS(qgroups);
-- 
2.41.0

