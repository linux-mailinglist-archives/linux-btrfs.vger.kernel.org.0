Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202787640A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGZUkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjGZUku (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929EEC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 955E15C0195;
        Wed, 26 Jul 2023 16:40:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Jul 2023 16:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404048; x=
        1690490448; bh=1jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=O
        C4m1AR57jsEthT4ZTZC27594xGKx3II+ciqxiqudtIXzfkVneVGcWze3FvYxvtsP
        EOsfpHT8GLjNS9ExDwZfOmxLhAhfZPZc/L91D7yReqbKU0qbbesnfI1yFSQKJFY6
        p8WiD+Qx4d5Qu7Gpl6VTq1PNjxP7CySXftAamjUrZMTydGHVc6cFWw2znqvNhOX2
        cqgNKlNRpYjZUps9cjaVsioiH6Dy5VQtB4/yxcKb6Vdb8PbJedysdXtVbCJb8+sy
        lAvJoevIfSetngtCjEwTHa2HjPYjS/72GHC3ya6nvqfkdz4cGICU6SNU9jYXbNDH
        E8628z63tSQQ+KeHHBTEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404048; x=1690490448; bh=1
        jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=OkNAEk/gxvHpiW9tY
        Mz4UytnQF9qMcLsCMwHmWxH9/PmIziFpsR2W6Swk2f3RuI9plJ+7R1UiWcfeNpl7
        oh69PODZSlV6XSvEStJaBZTB6+lYIiME11/2e43w/G0Bqq5ne4a0QsbwteH/f9qc
        tklENG6ueCA2rIXGfc5q5Tyd2UF8bshKt4KaIvwYv27XzZPPsTw7UhrL7xsJPZh8
        l3rFoPZY2MFWv0gGYNm/Kb9vnflDIM+Q9e1p0wQiDW7qL6v8r9CqWvN9aHk98O2c
        Ulx+Y9YxkVirOkTsK9lxUh5o4lnqsaYtkszHHU2xyMW2l3Bt8sJAHHCMsr/xLERm
        iVJrg==
X-ME-Sender: <xms:0ITBZGqIRYJAv2vUECSVMEVM-K_YzPbRwbZZNnvvmgY0XCXjdEPB9g>
    <xme:0ITBZEpt2OWNlTQObNXgiitTRq0JjIcLAw_qxID4XDlPuQLmaKVpfVZB1swl5qf0O
    tWzFJo6wk6XKXr8E9s>
X-ME-Received: <xmr:0ITBZLNc7zLMmFNlm8dhD_hwfyodUedVV8k6e8f5UqQ9JUHo4GsZClW50fPmCZLD3S6YKdsqN-UQoC13OGshUHIWUoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:0ITBZF62GrENEpYyViNqlRmnSdiyiQHRrYthK-Sobz8bhDbj-P2BWQ>
    <xmx:0ITBZF7eI0erX3OYvf4PkVTIIYMDxSps3u1gL_EBE4quLlYOtBFbAg>
    <xmx:0ITBZFi-nIfR06HGxoMxRG4Z-7cdPxii7TgmLkBj2DUHtlhNJ1u-Tg>
    <xmx:0ITBZCg9mvYQha-ZDIEYmS8exXR_mSmcePuIE-m8uCtSPInFbPICZA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:48 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 03/18] btrfs: expose quota mode via sysfs
Date:   Wed, 26 Jul 2023 13:38:30 -0700
Message-ID: <9c9d150a93e91a5a648840ef77240e81b70ff769.1690403768.git.boris@bur.io>
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

