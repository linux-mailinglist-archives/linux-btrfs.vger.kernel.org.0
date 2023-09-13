Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5AC79DD04
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjIMAM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbjIMAM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:12:57 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB57710F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:12:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2E7E53200955;
        Tue, 12 Sep 2023 20:12:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Sep 2023 20:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563972; x=
        1694650372; bh=9JIs4/6JO5xrpSJLD/U6PzfBaWLugDO4W1+FC1bphgk=; b=q
        jmhbSJFTIHEANedJtAos6rDNUu/18Nc6DZRXlhtpwISGjLO0rGE2Qy45QzsoXr5h
        kOQZLb6Zr6GDFflvNyYlEGnlFfLY7LsVYHiuR/E6WDHOyCU6B0Hol79mFiqvqZA3
        TSjAU/l0uxtw4h5VSpyH5fkRTn0++CAKpP0TOweSKOhgG8K5hv2twydkvPYRM4BZ
        LF0DGwq0+ZcSKGaRO8SSVzFa+XQoBwXr3PDHx4JaNM+PO0rukcLJnK1qzZxfqnXP
        fEPSV56UoWIpeGIx4DNxZgvUb+4tvrgc0aVw528XK4GssLoQtqGCo3gK6idBu9ri
        wKkHNCDZuCbhXE8xmqZNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563972; x=1694650372; bh=9
        JIs4/6JO5xrpSJLD/U6PzfBaWLugDO4W1+FC1bphgk=; b=MsMdDL31YY9ppgf1A
        nrBTN1XRcZrzVADTVM7MipoV0aoPrFSF5sAPNc+yKoMiVp1nXno+2UlZo9xslpz/
        6QSIqLB7Gwx9COXvA2NNDCDzgzgCL9uUJoG0OaF4qqe5SaIrLXMpsTn5z83ALUEo
        MHspofS9VOTKueumqlkREt6QTdkrftpq7vGPdQPfstpOQY3FAgTsmiQ1ODK1ppvd
        VdipSQF+9PCWx3rjgA7W4zSOOBN9jEFg3sNgpm6ajo0KQaNHTZyF4fWTM7nFZKIP
        jANjh4nBIDN8IaEJPaDz8c/58YTvAxsGmUi2kB1DGbjX6LrMT9031dreXQEby6Yr
        +YxIA==
X-ME-Sender: <xms:hP4AZSTfGAFhtoeYup59oVsw0HCWKa7evGMGGOe6vp_ca5ovZBVVKA>
    <xme:hP4AZXx2NwXvKFrvlYsgv96xMJjGsykaJmr8SkPBDtvPzJBGS260F0xEgfjYezHA8
    oLIFFdzhsPZg0u_Mzc>
X-ME-Received: <xmr:hP4AZf0ywcZclhKNKuIc57lP-Gx23oyAsVwD3fGiKUUgJIbq2HJaEpTQ1LaWZx5f2Iv3XgjC7P0oHzCBnH9jIpUigCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:hP4AZeBvMeCo2UaePeTD8jmQGTZfueE4AM9J_VgMaINeP3Fvwgr9ug>
    <xmx:hP4AZbimU34RZVcdHdSVmgRgxOMWclOfSTeOMu5aA6XtMP07-s7iig>
    <xmx:hP4AZaro7bPddXDLjM6ZQgDGpwyLnqZh_gu8JXGwoXcdjSs0JZEQXA>
    <xmx:hP4AZbLScEfZr8wLmwDWmIFp72d2lPjK3nTdE5xbK7_zaCLePUTXWw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:12:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 04/18] btrfs: add simple_quota incompat feature to sysfs
Date:   Tue, 12 Sep 2023 17:13:15 -0700
Message-ID: <88ef63d3b102acd61920290d2ceca16f87cc3d99.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an entry in the features directory for the new incompat flag

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 98d935bc1ee4..6f1cf1c9aaec 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	BTRFS_FEAT_ATTR_PTR(block_group_tree),
+	BTRFS_FEAT_ATTR_PTR(simple_quota),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
-- 
2.41.0

