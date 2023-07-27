Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95343765F10
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjG0WPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjG0WPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:13 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B7187
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E70EB320046E;
        Thu, 27 Jul 2023 18:15:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 27 Jul 2023 18:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496111; x=
        1690582511; bh=qVHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=h
        +EtYMxkAoXGJ74DbM+kTAQIa3paf3IDZayKmSRf2FbALV831cS8IV1A87eleMfhG
        0wUbuftvtUVcKlzWVgF1rMjAXOipex5CS7M4EoWqta3KLORfPU/u7EoaIBbwPQwk
        4l1r7xupxOBY5WU9pJ8ljwUYzGPhv+I0j1UvMQ226Ihe1weLH+MiuccZH56pDaAa
        vovtRucEIIIqWPRCu8iEye3YrgIFx4OINcsP0HvXtadHqQEpR8DhvnBfZ0YjDNog
        Wk0i4stCOlM6J5VnoRUpf2RuVsE5nhE+z+jR1MBm1EDh0w6P0rnJ/t9dHhO9T8+q
        6eEMN8PK8rdwv3igZfqQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496111; x=1690582511; bh=q
        VHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=PlZIQHlNK+b/aHXZp
        s+XH6mGG0ImkGaodaexT6LdEfqsPxMY3hyd6Zsm3CzbHu3pK0dwNeo1KZxhmP40a
        UkjZP1oYvZXPeYFB0rked2XYelMIMwDSFFspnzwmPMXQQXJWmfTS6rIMX0WQvIxZ
        NuH7h196Qrg+nmQHp5HuanxHjPCaSfA9pQ7/Z5/fhARuFChNc2jPbi42EafGDCeg
        1vQSn+CRVcoHhcDEUK/4G24zslV3hT+yXjJt5Bbj1KRXcc9uLVeN6WKMoe8XRQe+
        fN0ZXtWVqwl4MX3Zc3C0BBJxApBsQkJinyWC+76f9apgozmyiI9BtB0jNM/1TXVu
        pFObw==
X-ME-Sender: <xms:b-zCZOAW62GPrM7tSbjZ2Ke5IU-sQvpIVLbg-tqefQiLHvwVyp4DAw>
    <xme:b-zCZIgZHIYJXoMqbZZ-zVCFYwtdXVTstouQmEwap8sI4m0dda1pyKbPuSgqgxzl9
    vMJPpn2S5ApUKHlvDU>
X-ME-Received: <xmr:b-zCZBlnp8mkHvhtY6aoylRbcE6DAfFqYflS8PmI5P28BzWo2GzQJZVugYqrBY5V_LNR4ZdiJfrYEk4cpSEK8Q5nAw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:b-zCZMzH1kA6Dg-Pw4IOIX-TgsyF0gWQwU46GxYy_mRCtBg3aVBjFw>
    <xmx:b-zCZDQeSOfF9psicetDgDVKHA-wrz4EGK656r3rXv6dt3S4SqhJuw>
    <xmx:b-zCZHYwrrWX5CnBYIjP5zVvfIekpau0Bmh3L0PeNW3J-pHfDNwcsw>
    <xmx:b-zCZE7uho1LuumYO18_KX2T8_B0c-T6qr0BtGGuaI8iuEhVyCm56g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:10 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 04/18] btrfs: add simple_quota incompat feature to sysfs
Date:   Thu, 27 Jul 2023 15:12:51 -0700
Message-ID: <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690495785.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690495785.git.boris@bur.io>
References: <cover.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an entry in the features directory for the new incompat flag

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e53614753391..f62bba0068ca 100644
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

