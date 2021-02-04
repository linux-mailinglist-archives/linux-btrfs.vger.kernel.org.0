Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C253310092
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBDXXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:23:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54631 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhBDXXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 18:23:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A56B95C00D7;
        Thu,  4 Feb 2021 18:22:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 18:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=J3dDpVNU4Gbdy9Rp7q5jjblp6N
        IL0xqOCbkQDvXjZIs=; b=oBVowBtAU7Ols+CEB6yA/HG6fipCxfMDi8F3f0vC0F
        mfPHfeUMJcqq9A0JDj+HwhjCB8IoixbhbaVZt2XftSRbZqTpKwO+TCnfX+wExiDi
        QBKTrvORc4m6YegYAbRITJrKwOruvHZ5KBdjkow+Yj0JBE58in6ByRMWTvQpclU+
        bIWvLvzDK8ueFUVSZRa/6TaYdxsSp7nz2byghibBDBLSEDLMY2GI27lGCgYsfjfu
        nvArUkrfcBk8dEdNFV4f8ZYcVm+fxE2voaiLJECKL1DGThIJkF99wTvuDSwsCgPP
        l1vfD5ciWnwc8zxTxxMFXCWQzggkupRt9Tv3tyCxJbkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=J3dDpVNU4Gbdy9Rp7q5jjblp6NIL0xqOCbkQDvXjZIs=; b=Yd1vlMtr
        FDXjXI15RdFzRYyO3+ebJ/OJHC01kWX4Qx0ShkpHqYfr9Vd7dTVeLDzQo/2iOq6I
        Kl2/Jx8xqEDgw7astJDMbjAUvu0atGXIYzp1uhrGMJeviYS27ZGSWE94UQ3GCncg
        WCLrgSOW1Hy+mY1oO52oum06V4iVqT9ADUh2MDuIOIiSDPP9nyrUuOVOtgMBBoFg
        7sW97EiaYnptu6mYcm5JCwT8FPnRbTEINjoTzrWSz0Ny01Rks9eTP1GGr5nMqWmZ
        Z+o5M2wzUiFdOiaNyLp4R0kAUt38jZ74SQN2LFwbBAHB7NkfDqedZk9USd+LxniP
        +ed4hQq2KmYhGA==
X-ME-Sender: <xms:mIEcYGYY7OgiaILYTDAeT6ugEMSjK8ycEuc3eBp8CR6gUtFO45UzVw>
    <xme:mIEcYJYjcISQDd-SUEvn1QE-06MbcXGfjQZ7PevrVHbqoVaDA0EITpG5FhnR_bYd3
    yZKos0e4HuVJlp0Zys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiue
    ffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:mIEcYA9DYP1n6Qutj_Ikrr2Xyasql10X28WHrcxAyABCywql984A6A>
    <xmx:mIEcYIpz83btyI1gt5guj4JOyIhBax10nLXNGYg_5kS6-V4LksrDpw>
    <xmx:mIEcYBry8cpcNUPMRKta8j7xw5wDJVCTdta89o3ZSG7CCtZxy-N4ow>
    <xmx:mIEcYAQTh52kklEAUC4NHnwAHy8h3xE2NStRdxDdpnechcH1rKQ2Cg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F8281080057;
        Thu,  4 Feb 2021 18:22:00 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5/5] btrfs: add sysfs feature for fsverity
Date:   Thu,  4 Feb 2021 15:21:41 -0800
Message-Id: <603ea427c87a482de165dae7b77425853b333f24.1612475783.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1612475783.git.boris@bur.io>
References: <cover.1612475783.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we support fsverity, enable a feature flag for it in sysfs.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c           | 6 ++++++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 19b9fffa2c9c..40e780724c03 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -267,6 +267,9 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 #ifdef CONFIG_BTRFS_DEBUG
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
+#ifdef CONFIG_FS_VERITY
+BTRFS_FEAT_ATTR_COMPAT(verity, VERITY);
+#endif
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -284,6 +287,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(zoned),
+#endif
+#ifdef CONFIG_FS_VERITY
+	BTRFS_FEAT_ATTR_PTR(verity),
 #endif
 	NULL
 };
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5df73001aad4..5e0eaf37b60c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -309,6 +309,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
+#define BTRFS_FEATURE_COMPAT_VERITY		(1ULL << 13)
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
 	__u64 compat_ro_flags;
-- 
2.24.1

