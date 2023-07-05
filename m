Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AE7491C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjGEXXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGEXXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4561997
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C72C5C028B;
        Wed,  5 Jul 2023 19:23:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 19:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599392; x=
        1688685792; bh=1jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=a
        poGWzWjZK7WHZ6DeJoWC8tyl+W8r2jXU7RBENN9cUblDdpPD/RNAwRTWDuMxDRyj
        IW2+mxu0AuxOAwt7opBSNke1FzxE3pwWZFnNI4Xyk1CjBCP+5XyVn5fyFkf1s3GN
        Lt6NDWmqE7d8luQ7kc+2wk7dPW+LjUsSt5WotPbugVu7q3/x9/7AHeq4sbsBv8ij
        7y77eqG9RXe6Ffr6Sifd/SSGh746ljY1hcry/N/4LaqI0UkmQMz/u82WZykSQuWj
        lJjC2IgIDj64uauMg/d5BQ5y8CnsNkXVU8084ZYGfeoWVXUUc1OYS/dJAFXeZjds
        bDf0CbeDfSSkR6dX5Yk7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599392; x=1688685792; bh=1
        jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=YgQjNeHrPfwyoFkAD
        OP/6yCl5Pqw9Y7pAKha3DmZuHGDQ2DwjomfCFY9bLYnuueOU5UPcCL0gOGn4krFO
        4CqqA8zRDHi4+t8uV8mV6Xg/cvpmbYeQ6zHguicI8a39/Ahdm1YEacPVOjr5zImO
        MoCezOKn2aOpe1coqFs8PgsBetKcwo8WDe8wvc91ZUq88VWBMEmT/eC8RTt/37zy
        9Pe/Va+Rg6jMCcNjHqdGmXzeIB7KtKibah0mrXhRFcJVMNZIphCoALBqQuZ0qjmA
        y7spOsQKkkhD2FYwfttOw9HXj/eFzDqq6/tVmP434e7UCJrfbqmDuRdnZht/8Cvw
        rBgtA==
X-ME-Sender: <xms:X_ulZEXSVFv-yLmMNe81le498g0A0YFwfS91piAdpJmsFHwys1ww6Q>
    <xme:X_ulZImhmQ307rrd7HPBP6FJL0k7aN96DLQdHObAITr5OcMVgusQCmAcpN4qDRrd6
    Te_D-vibOYZGmAWugw>
X-ME-Received: <xmr:X_ulZIY1N4ErJppeFSEvamQ20DFnmCp2NuI1WYHYlLLlepQ68YPtqbUY-ErLspoURzCO4jEES_4AJKCugfVIuaa93u4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:X_ulZDWaA2_OfQaXGqnRH91t711PRUH9tSSDNXnfIctFjGrMkZczMg>
    <xmx:X_ulZOkKNNzVdkNmkiic4qHitv5M9jtbo8QJWl3lAc-k1WZTkJEKMw>
    <xmx:X_ulZIeXqCEfz0U84h6AY8jO0XMSAQRjAlZEOckoU3kqOaQyCSCdQw>
    <xmx:YPulZFs9BxH4AtNLjdZjLt0wF0dwTnhDik3oKAr-jdTue5_2VAU-oQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:11 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/18] btrfs: expose quota mode via sysfs
Date:   Wed,  5 Jul 2023 16:20:42 -0700
Message-ID: <0628cfee8bca3506127b46ac49ee4e2603f081f0.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
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

