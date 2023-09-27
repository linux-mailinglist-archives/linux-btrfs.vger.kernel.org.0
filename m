Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2049B7B0A89
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjI0Qog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjI0Qof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 12:44:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86BDD
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 09:44:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 76A44320097E;
        Wed, 27 Sep 2023 12:44:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 12:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1695833068; x=1695919468; bh=Mz8jGV8dBl
        PbxW18COou8TivWtIe2fJljixUGBk0PJc=; b=ry325F2jUE4tSwLlqDWzAl6+Uj
        DW6i1nWzKr+G4l4fDJWC6Wbq6AkO5qg6TMowOE2/L03PUVT+Y1OLLEAvASy7S+RG
        Q20TjB3yNYIkLPu993SyoqyS2uLyletiGiPZvotlsNgfsxecbSucFZcZg4Ws8SbZ
        tHwepTI1MjNgXWJkiHJAop+Z+J2EWENVo1xzYc2sA/8CHAr7HNZCYhBDu2wj3VPk
        SaG9BBkPWk4yllIppEOu3RB4lxZpapW74sY+QUev2f1hu454cGCIRKBCezZ31lwO
        1w0pN8FidZRNqDphgE4KMbVV+ApsQ9uMlbdGXF0Sa3wwD2oW8PgQ7mTA6RVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1695833068; x=1695919468; bh=Mz8jGV8dBlPbxW18COou8TivWtIe
        2fJljixUGBk0PJc=; b=QbwL3kZS0R6thKtK/OkmhvDgs4FGvjT6qFQexNtpByCB
        HNjgdPYlltNSnQxFwd6HKB6FhjUYxuAmjBdPks0ZebbfkGE+JwvFfKbGOWODdU05
        z8peTmYaTPUL4sdsutuEcUnNDEXdlJahWiaiu2CU7raVbQF4MlMywMKhBofpYPUl
        V7yTCHXpRIo/XPxW4NFsIIOicFE060j2ar2gBWRA3Gf85FHdfPtktSLzw5cezYNm
        MmW4O3N6kxN8h9xVdkTuvUQr5EIcYaKzKUnE7IJ8gMscRwHIgB/u+Cmsh89K4q9T
        jhaIF0qJ5JYJ11O1ETRsU5lxC5SfwcRZbrr4BpTtTA==
X-ME-Sender: <xms:7FsUZUJZdEntQUHsH1hP_VIiacHLCFfbJ_B-3NtZscALiz6dfuLHVw>
    <xme:7FsUZUJpiZuBJemS7ZNUocIE8khe6VMhbuyhbmhNRYEgosfUT42w0iduBoE1mNuHt
    rB_6AvXq4dYzOpSeWw>
X-ME-Received: <xmr:7FsUZUt1S-pjHroKGQyRsmXUNoQpJbt_STLsmyhGsS2Tt8reJkfVFy-W2yFWMOFJzyIkSXbg5kvxdkRj_yjCRuIYRV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfeegke
    ehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:7FsUZRa_if3gFzKOcuex6zarCsg_fnirvGIQcNqPLVtj6GvA_9lg5A>
    <xmx:7FsUZbbk3y0oxwqzSGjC3empiPk2dl8S7f9KNz0TTBzDlOtCB54-Fg>
    <xmx:7FsUZdCBftywlUZrvClB3SyoJ2vmsPijxXU9XDun3EtLk2Ki1MmDHg>
    <xmx:7FsUZSxX9Z-JADt4hIx4MbR5QHV7BeJDJviltBGXV1muLfopVk8VDQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 12:44:28 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        dan.carpenter@linaro.org
Subject: [PATCH] btrfs: qgroup: fix double unlock in btrfs_quota_disable
Date:   Wed, 27 Sep 2023 09:45:14 -0700
Message-ID: <1ed61ba7891b9f86a20a46ee5bb42cb4649311af.1695833099.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Flushing reservations in quota disable is done while we do not hold the
qgroup ioctl lock, therefore jumping to releasing that lock on failure
is wrong. We don't have the transaction handle yet, either, so just jump
to unlocking the cleaner mutex. This was found by smatch.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-btrfs/dfadfecc-e50b-425a-80f7-3ae1290db2d3@moroto.mountain/T/#u
Fixes: 5e99a45f1f0f ("btrfs: qgroup: flush reservations during quota disable")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1a486d8a7b5a..7d9cb7064811 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1375,7 +1375,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 
 	ret = flush_reservations(fs_info);
 	if (ret)
-		goto out;
+		goto unlock_cleaner;
 
 	/*
 	 * 1 For the root item
@@ -1439,6 +1439,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_commit_transaction(trans);
+unlock_cleaner:
 	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
-- 
2.42.0

