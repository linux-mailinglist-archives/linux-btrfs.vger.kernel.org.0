Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B237491CB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGEXXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGEXXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2011995
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6ADC55C029A;
        Wed,  5 Jul 2023 19:23:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 19:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599395; x=
        1688685795; bh=jTyOEqNYdagK2IClPxvnIhRUEyMLn8dHeQHShqmQheE=; b=S
        abB11yPau/A9Fzq9PUAMJ9wmo/ket+Ekqx5YcBs3VQiGXOW6+ZCv/GAvxMg2JYm4
        sD+6isTSQqtPIKZghwAwjqXNINWDBX9AySMMOguEVyQfVoz1pbwQFqeciWTW/7yY
        5vrboIYuFZZLF/2/2EOasaol24Z8FXzbb1WIVYzBzEf1/En3uu1K+mQzxuOFexuq
        rUiMDxCG1cFqgxWa2fYfsyYbzr5Ry+5vrKUPtj5kIr2Ny6ARgkageD6obWRCCc4o
        7pShtlf4Ps3OuWULBNdNBik7yKnn0/gB7I1rlBfxWNSx3AJxywqp8yFzkl7W0ZqP
        BLyJOBX2j3CwmoHS+t06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599395; x=1688685795; bh=j
        TyOEqNYdagK2IClPxvnIhRUEyMLn8dHeQHShqmQheE=; b=ITHp/ZF+AO4djRFE6
        zELjSgDXJfKVrgg9HYDNdfDDSRtm8utLBUcUpNVUitJlEfQjJbNFnDcqfZxYay2z
        Q5NB/huwJJIIl9DYEVL07L9GGWjP8Yk/5UaQpVdsZzZzA9vk7M5Yq2fFgufOQHpy
        zjNyEjCdBQeiOZTSqkpRLdpKZUh1tY133739wyBwdeCCDEtTFPZ2p+afuK516lXZ
        cS+Uu2BMVoNVWS/4Va9eMvX7yglGpaBjB9HetAPltvPFMqWEhfYS52yGHXyfPV0L
        OEsCYNFrGkwjQ6ipXzJH4i40Dp7fRH4A6/2LkVaZIEMvGty8PkOyyJBgV1lLoM7a
        R2XJA==
X-ME-Sender: <xms:Y_ulZCQi3eWVb46fjq4SjeG-fjnwfB8tMP4kSYAnobJxt3Ueq5FjoA>
    <xme:Y_ulZHz9-YQIrXhPip_YQy8__9ti900YRqiVa_jduTibc0FyYEFoDBIIW5HzOoVsk
    HFzETy7o-Rs4ICqYyM>
X-ME-Received: <xmr:Y_ulZP2t3mU8qos-OEiDaFuGX1-bcaOtt6JZB3cAwPQCiojybcUQhsrqTDiL7Hb4-jkU0ntj_tnXHOEj1X6f_5OWECc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Y_ulZODOQIAOks9iQWYW0DynBDK3dNbgEw1LlO382W3MRvI23fC1-g>
    <xmx:Y_ulZLgZOQgBDxSbKIcqkKRkB5SbL1mQYzGpld6cWVTnbkx9oioNEw>
    <xmx:Y_ulZKrf8ZMwhnAoC0eIjVbTNQWkkB5TTxrySSZnoNAXWJdzA9d6ZA>
    <xmx:Y_ulZLKtouCBaWC8kfTybRCIC4nt_1YWB_iSBzLFw5LywPStajeBCw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:14 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/18] btrfs: create qgroup earlier in snapshot creation
Date:   Wed,  5 Jul 2023 16:20:44 -0700
Message-ID: <5aff5ceb6555f8026f414c4de9341c698837820b.1688597211.git.boris@bur.io>
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

Pull creating the qgroup earlier in the snapshot. This allows simple
quotas qgroups to see all the metadata writes related to the snapshot
being created and to be born with the root node accounted.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c      | 3 +++
 fs/btrfs/transaction.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 75afd8212bc0..8419270f7417 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1670,6 +1670,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_qgroup *qgroup;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+		return 0;
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f644c7c04d53..2bb5a64f6d84 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1716,6 +1716,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
+	ret = btrfs_create_qgroup(trans, objectid);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 	/*
 	 * pull in the delayed directory update
 	 * and the delayed inode item
-- 
2.41.0

