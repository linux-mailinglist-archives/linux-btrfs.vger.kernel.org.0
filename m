Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAF6F4E40
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjECBAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 21:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjECBAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 21:00:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD72D5E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 38DA55C030D;
        Tue,  2 May 2023 20:59:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 20:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075599; x=
        1683161999; bh=kiz1WuRnLGG9Z3fuMX6gyOK8LAOaY29ruDhICDGePII=; b=d
        /gPUDshhxeKqF/ywVcC/fA1ZS3b6TdtrZr7HGc+KY+FRkt0DyOuLI105MsdlJdHm
        u1Su2OSJ4XQx/qoosFcCRZWJe5j85VgKMUi37NEoQuXsPjZWI5Iu+Ez+TCHX87AY
        1wOrgyx6P7vQnWxLRUQRx/9PZnvbhnmblVfnmaxfvuZNewYlT/WXgIW6RPqB7rcV
        BHz1pHNChMoiz9qSVBylw235DpPyWl42xlwHZfxdR4Rycyi7Gvjqf2cjy00jc0oM
        HZDNLVj9X+FARBOEAFUF1vBun4PEXwsYDIVgUwnJ6vegtToZCwxWPfyCZ8YguRXO
        e97HVHmTVmp5DUPUGcETA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075599; x=1683161999; bh=k
        iz1WuRnLGG9Z3fuMX6gyOK8LAOaY29ruDhICDGePII=; b=kODHeuXB1srf+Bg3d
        zNsegZ2UUOxU+yxxDkAXzxUyNhCIVOeVLGlvu+62JQaJ28AUbdROKmwZsRUScGy7
        Pz+CvjpArFNF0LqyWbBx/h4RmXTSYRVpg0DQPaohFFa99JN21HJhRc9OJRncRZZK
        YJ0GwdWuxQKJ8f8y1BbMLqHgqXGULfcIYgXfGD8tWJti8BNz4Ajy/OCVeDoCtWnZ
        Wk0Dv0Jra2udipoXBuntkUXtNY+3Zyxw5vNTXzbBMqjlSgyzhT4JR1yO64O3SRKU
        dJ0MYWfza7lH5TSoP971j1ckFBZJy5pRVVZYQngbrcw48XJD1rKIZOTsSiXu77p3
        JJ7lA==
X-ME-Sender: <xms:D7JRZBmESif7gGME8APTshROxQsYY_MVM4sbzLHvxvOnZsz6KJNHeA>
    <xme:D7JRZM3QamqssBv7j6Epi4MzvxvUrNsWMWXepMGu8er3BEtBXX1A45i_pI7vJR_6h
    HZE680kM_ApxyVIh-8>
X-ME-Received: <xmr:D7JRZHptb4HnlpuE6eB77_VSh-VpXIhZ1nuqSKcUK2xP-4nxSZN6NWLO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:D7JRZBmlKDbA7mVpNyk-sPYQ-lbexOFQI329d9vVrW7JeClNjz08MA>
    <xmx:D7JRZP2F8rBWa7fDVeiVUfNG2se0jXjPLguh-9UNfmhmzXGDxRbDjQ>
    <xmx:D7JRZAv3xqeJWLjLuv_QLALMfDyeH6A2Dl_Wv3ZEuL06YmzunvxptA>
    <xmx:D7JRZM__SqWRxcM9JhgARDqwCd9tnu_J7rSLXRgo7XijfoHZyy1f7Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:58 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] btrfs: expose the qgroup mode via sysfs
Date:   Tue,  2 May 2023 17:59:29 -0700
Message-Id: <e88dd7e4c65087333ce40af69d8ee4b3a14ad71e.1683075170.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1683075170.git.boris@bur.io>
References: <cover.1683075170.git.boris@bur.io>
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
index 25294e624851..d2de2207120a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2079,6 +2079,31 @@ static ssize_t qgroup_enabled_show(struct kobject *qgroups_kobj,
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
@@ -2141,6 +2166,7 @@ static struct attribute *qgroups_attrs[] = {
 	BTRFS_ATTR_PTR(qgroups, enabled),
 	BTRFS_ATTR_PTR(qgroups, inconsistent),
 	BTRFS_ATTR_PTR(qgroups, drop_subtree_threshold),
+	BTRFS_ATTR_PTR(qgroups, mode),
 	NULL
 };
 ATTRIBUTE_GROUPS(qgroups);
-- 
2.40.0

