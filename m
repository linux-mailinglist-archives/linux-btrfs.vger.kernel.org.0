Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1535C75BAD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGTWzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGTWzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921AD269A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 808205C00E6;
        Thu, 20 Jul 2023 18:54:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 18:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893674; x=
        1689980074; bh=1jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=g
        UEXgJThE3rrE64mJB2ToKxPxc9u769BoIleqQOOOpxVpwt/JLyNDimlLaBpbwTxl
        55uJMreRv1/uniQ2z3PpodVFItjASC5HBY6Ia+XQQS5nnUQYoU/0GaviP1gP+PE3
        jltg7jNWOegqFN2fy0F4mMZsGCOe0JZEAQaxxgHugAUibjXESmqjOURbzgthh6OL
        Cs0i3tasrKRpQpbmVSFlz4umxdGZsM6noCM6jC2d/13LpymOpKQE+Qizal0eiLrp
        H3oc5vOTRfLNpuzFJDezqiyZ5eE6Lb+h+S3Vq5EYS/TOcTXxrwgX2kuJQrQGIAWS
        tBSfCXqfmqWs9FoZibrHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893674; x=1689980074; bh=1
        jI89jJpbcX+QlAxKYbnErOrqzmmXD3xHc3JW0HJ1/E=; b=QJyr+L0+QA8K/s4Jo
        yUrC+B9VwFrVLAhlSnlM0l79D0nJESbyqEQzKoePBHEYlyd6dHUSBHzDrqJmqxiT
        MdQoeqhOygzX0ddfRghRQ1+QDs2shxz6tkbsxLhPtiiNJDz3bwh6q/QJyPQLRfGg
        00Y+rEfYIKGKOU1aMujdLt7aWR1ulP50+gMTH4km7qBZkwgtMWgj9kCu47IS3j2J
        llg5YS4Mr4YxdrWFUeMN0f/1HnqVYVQqyX5AeHeRrRpEOmSwI0kOy3IWXHd0phk9
        vat6wshBorjBi4eZmkUrYESnExlEdvJqwDuMVN/6EB79zlG4LiwUYDGl6kwTyamN
        ojx5g==
X-ME-Sender: <xms:Kru5ZCvN4tfyuRAtVP2p1HhmQqEExrumy8EC3aUUu-wSWFaBVHSZQA>
    <xme:Kru5ZHcZgGUeNksu65BxTyfCwUbwz8C4jWsjavezE5VpNuWTP5OLqCorXs-XQ_RrM
    yigArGQT-YaNdGXQWI>
X-ME-Received: <xmr:Kru5ZNwZgPF_QH7D5PVxtMtRsR7ej-j043uWcQEW3BKkpnLrYm9Ri2MfKc2uZlD-u1IQe5Hx2ObivON3N0TZjK4BVQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Kru5ZNMWes4Z0a4tet9e_85bZS8SD4omcKpzqnX-0eqsCfgLQh-FsQ>
    <xmx:Kru5ZC8ORduz-zeiXrN8g7zjnEKR9JSn4Vcp3xWq81Ux2lbzs6ZkJA>
    <xmx:Kru5ZFXgX70dmhHumBM3JPXa4nGlBEPGN-rp7ryiNtXeGhip-G0CDg>
    <xmx:Kru5ZHEWrDoOGUiYSiwGpFvrFwKp1eVD5cs7HJh0dz-pErKmHEq_Tg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:34 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/20] btrfs: expose quota mode via sysfs
Date:   Thu, 20 Jul 2023 15:52:33 -0700
Message-ID: <1b615d9dcaf2f58f107cda91f767690a2da310e3.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

