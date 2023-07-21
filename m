Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8B75CD09
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjGUQET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGUQES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:18 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679BB2D47
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A946B32000E5;
        Fri, 21 Jul 2023 12:04:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 12:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955456; x=
        1690041856; bh=1jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=g
        3YTqIf9gZGluVDqENIJEnesZayWy7L9o+dLOGAN8rH9FoRaui9jJteh2aGDDDZ2D
        mHHCeYtyeOyWWPHSLhFeGUVxy5BCVVGs13XwKux2r4AKVF7pZQWH8JSCfP88lJX3
        hOo8EPQAQWMOwQO3QnKQyDOtXDJh//7ggDp30iM7ZkNKyXF2o8JXBTAn0r8G16Up
        G5sLBve1TILwPhZ6Fu48KlGGq//VvBhtHNCid7LQtE54FKn2UZedyAO/vaecwEOW
        9BWKGM5/dYQhyuRC16XVLSeSCzhyO7kZutfmqviTNbergYF/j7iUUdasVfnQWsTd
        MoSDKFIfAbAkABNvvVBUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955456; x=1690041856; bh=1
        jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=e8bq3I2spcYlbGAIb
        RGiseSyIZKQKpQ892GZP7pO1P/JcN1jLutw5F7qsQB1kJusZIHCYpLBm7ZE2mk1h
        QWUHTjWz9Byz1aWvJ5E5Tvu8FaKx8vD0BVzPN3RJ8eMRdMhlC0/+q7VFj61C9pHz
        IrwevRaw1AnkMDJ6irYeKXXb4RRE3Nf8TB6idd2nteK5VUHfC/c3XQcV3vR9YUld
        z/B8G3TrS++kkovXk6G94f7Gjc52E6InZuC4VWQMsH1Djj363fB+etDRbbSRpJtx
        BPGnzFDCFssJldfJsqM+aluTKeWPcZzTXordpeXC8/nfcQUU8i2m3+792dWQG39v
        OrwCg==
X-ME-Sender: <xms:gKy6ZDnjQpyBYTb8SqYW61mh2ZMvP3lGxZ-I6nwWFFU4lV6MZRKjSA>
    <xme:gKy6ZG0RIs9lCj3CDYUsQtv5ycsNHVbg_fieMvim7bZzNSpLRnSy7sA3SG4bVbr4C
    3PGwqVjB3qoWnqxalw>
X-ME-Received: <xmr:gKy6ZJqxBVsNgETTetn-P6J5EuOdiNEY0IwdyUuLQxqvhxyrolu8i7ThNtRaAfBBo-bq7_3XyLmMRa3Oc_9QGaUc3W4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:gKy6ZLlm2GkahYMqIVbIJsc3lJ4RYlSD1nZOvS6h06R7EUBn_ukc8w>
    <xmx:gKy6ZB23Pdo0JB84aMLgVB51jBzHJKem43gEJ7RyDnBE7Rgj0gGnqA>
    <xmx:gKy6ZKuhbdRsTVnmUbb8NPZP0bnIVhSTCMpD_uaJAzHgOEoWlnCEgw>
    <xmx:gKy6ZO-nmb4phWaL_ORq3ccfzckLtwkhIIru5DYuTp0UMY8Dkz4AQg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:15 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 05/20] btrfs: expose quota mode via sysfs
Date:   Fri, 21 Jul 2023 09:02:10 -0700
Message-ID: <1b615d9dcaf2f58f107cda91f767690a2da310e3.1689955162.git.boris@bur.io>
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

