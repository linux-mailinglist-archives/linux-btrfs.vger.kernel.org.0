Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809D79DD03
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjIMAM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjIMAMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:12:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C810F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:12:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8464F320094A;
        Tue, 12 Sep 2023 20:12:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 20:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563970; x=
        1694650370; bh=8ZKqJFpf2MCiacH4RTQm2DLEUGqAaL/59FLXKRhsXME=; b=B
        Z8ueHear6fPXrg9Q8j994+3xlqcyAyhPiT/lbGraL+fZh9fQ2QBfJRxLMKU4LOZ1
        sv7exCyLhph6RlQFDFUppYuatW8PXB3nkJ6UA0a7PkwJfxkoi+/EyjqUk5f99qfN
        aj64gCzB1ODrDstEb1xPu5xytm6FQz6oc2EUk2PZIGL8LXnAFsaGPVh8lK1+XhZU
        0cSF2RYIHrMT23ddZB6Dq5MWCI0yjfRa+/7YuHo+shDu785GKdSR95yZVWigMSRk
        NS1BhtYbYg7/qNFORAClD0CUoS0Sjbm6M6DLU5sL2//OUAg+ebkCdKJ6RzNAuIGE
        HMrrgjNTIbHzKU7Tg4Hcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563970; x=1694650370; bh=8
        ZKqJFpf2MCiacH4RTQm2DLEUGqAaL/59FLXKRhsXME=; b=ugiHmt0dkQWK7KlrR
        CPypfalt7W2s2ouxPZHiluuAmjsld9ReLZQ2/cb0olMvdl3UBJ9JaCorv8B8kH63
        L0wUGxXDWvzVrrVlUvfOZOJ5sRGeD+4Py1Q3IRHu/4OEuQz3Grye6qRzsZ1MLTU1
        n7Ux1H9NjEhVha4kbMBcX6Ijybf0v0Ukh3VRfUYUJITGdSIMKoSWc+rg9kg2c4/s
        cGOfUpoDqciYbK+J0aBApxUf6+eXbhdNYvYCQME+iqzEdDGPIggt6okWtvAXzpcE
        IadRxcpTa/JSh7nxxssNOx6qJ4UQG2glW7wbP7wSedsMBE7iQYrpklrMvF0/McWY
        QoYng==
X-ME-Sender: <xms:gf4AZes0zTzfwzohTgf6tb187eRy7NSHgS_KcapkmYqGcgh3VqNFsg>
    <xme:gf4AZTfGhBtcn9dpz_lxyibDqrBxW2T5-gxKjBJBtOMXZbBhHJ1hzr32T-MAlQ5wS
    mzZq3f5X0NQrNb1G_4>
X-ME-Received: <xmr:gf4AZZwnsmU5Nlcj7m-iiRckR14idFHcPUl7H9PF_H_2uAw-5FhynyU7wMBmdWk-DHZIGRy8jX5NxL5Vkju2eyYFMx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:gf4AZZNxJG0m_MEcbAW5cjfkZ59Wxp0cK6nFMxOLoS_sHZ7yT9Bb5g>
    <xmx:gf4AZe8xVqD_2sj1xISVCMgqPMBQf4eT-HCoCyl01U_E_k9iaTNz9w>
    <xmx:gf4AZRWZyoB06D6yof0eY1wIKZEJ28BdQoeabVEhLwly60sTT4f52w>
    <xmx:gv4AZTEcaogyPRcQKrpOvKOxgNSzoRxVpmExKhyou98mNsX81WuXBw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:12:49 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 03/18] btrfs: expose quota mode via sysfs
Date:   Tue, 12 Sep 2023 17:13:14 -0700
Message-ID: <4446e7c0594be81d56f70184b12504a553d824af.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new sysfs file
/sys/fs/btrfs/<uuid>/qgroups/mode
which prints out the mode qgroups is running in. The possible modes are
qgroup, and squota.

If quotas are not enabled, then the qgroups directory will not exist,
so don't handle that mode.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b1d1ac25237b..98d935bc1ee4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2086,6 +2086,33 @@ static ssize_t qgroup_enabled_show(struct kobject *qgroups_kobj,
 }
 BTRFS_ATTR(qgroups, enabled, qgroup_enabled_show);
 
+static ssize_t qgroup_mode_show(struct kobject *qgroups_kobj,
+				struct kobj_attribute *a,
+				char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	ssize_t ret = 0;
+
+	spin_lock(&fs_info->qgroup_lock);
+	ASSERT(btrfs_qgroup_enabled(fs_info));
+	switch (btrfs_qgroup_mode(fs_info)) {
+	case BTRFS_QGROUP_MODE_FULL:
+		ret = sysfs_emit(buf, "qgroup\n");
+		break;
+	case BTRFS_QGROUP_MODE_SIMPLE:
+		ret = sysfs_emit(buf, "squota\n");
+		break;
+	default:
+		btrfs_warn(fs_info, "unexpected qgroup mode %d\n",
+			   btrfs_qgroup_mode(fs_info));
+		break;
+	}
+	spin_unlock(&fs_info->qgroup_lock);
+
+	return ret;
+}
+BTRFS_ATTR(qgroups, mode, qgroup_mode_show);
+
 static ssize_t qgroup_inconsistent_show(struct kobject *qgroups_kobj,
 					struct kobj_attribute *a,
 					char *buf)
@@ -2148,6 +2175,7 @@ static struct attribute *qgroups_attrs[] = {
 	BTRFS_ATTR_PTR(qgroups, enabled),
 	BTRFS_ATTR_PTR(qgroups, inconsistent),
 	BTRFS_ATTR_PTR(qgroups, drop_subtree_threshold),
+	BTRFS_ATTR_PTR(qgroups, mode),
 	NULL
 };
 ATTRIBUTE_GROUPS(qgroups);
-- 
2.41.0

