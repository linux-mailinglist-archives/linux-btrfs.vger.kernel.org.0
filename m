Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798BB29550B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507047AbgJUXH1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:27 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56927 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507032AbgJUXH0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B94F312A4;
        Wed, 21 Oct 2020 19:07:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cyLT8ihDVMziZ
        JFq7nEmekggQ/kxhXwGRc2vSDc47tA=; b=RtPGbgd06gen2iie1bvsxqDsJ0Joq
        V+Z/LTnGZh5fyril1sv9SCZC39btahhnsMFoUO9wy19ctbft659l1waxOWQMQNy5
        X4TzndFHtZXeUbeoJbLOPMJ7o/neaaQ1N2/rPaSjlC/CR+zTdTOfJmvwQMWQTtGu
        mWvRHR+ukOEcvo59UX8WImIZdQhzLlNbnrxJflt+qsV22CbeiD8+t5aSSE1sGbJd
        qAjyewthgEXX7Lw9eMaAVnywoV7P70qiH2pkelpt2h/V3+IwkOE5hL2aMboHGp/A
        rflVvGEkK84ikEG3uzzj3e2fi8/0EX2REbso5qmiuyFTHGS6tq6ZB1ycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cyLT8ihDVMziZJFq7nEmekggQ/kxhXwGRc2vSDc47tA=; b=qvq0RmXu
        WG66nE8X/X8MR562LSv8hb930bMI1basylox1KD9bTwavyURvWDTvRDFecNoNq8l
        ii4kxXxOnBo5or+qLbxq2B9TCsk0z4t+2fllhn1ZioSR4KdmRC8emnvI3roGzknT
        cBwl34IWAjTpgM84/R40wbveCI2W/cCrzIpFeCLEEYwfVwkx8NR+y0edeR2uK0og
        4aQ6TAkJ90zMR66wtz9TTAJawpx843BUYVBv6EptcmqoIczNhSppf5/ZeewBtddS
        zMG/P9YzpVeVWChvDtS2nFfvhc5ByWohL0K3dcNHXDZbZglhhifEj6Q26oXFlVFQ
        Utc5jqJ3aOi1Gw==
X-ME-Sender: <xms:Lb-QX8RSQ1Ae1dtBTQ_AlcYWph9mmtmPXDNDIdsqpBtSyaP5jfr24g>
    <xme:Lb-QX5xxrDWZAqS0UhBuotzZkyHXjoKsAZchnr6_LwHEma4Du5vg3D6V34Oqmluyf
    wIbVdM1WO8X1XgNUtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:Lb-QX53frsOpq1dJzGzQKy9tNyfwbSnki6Fo6WMf1-gPsAIrF5SSmg>
    <xmx:Lb-QXwCw-_3yfzx-Vgazr6MQAEcjxUVFGJHW8ZVuldVz7wMNXHML9Q>
    <xmx:Lb-QX1i0jcDeMgTgodctK5sYDMACYcR4yTj60k0ZZMgkgBvcTLdkUg>
    <xmx:Lb-QX1Jza9PLnJ-9zsa2L3DHQOmvJRyguJWLLJ5wwE79ygQEd6VAQg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0EB8B3064683;
        Wed, 21 Oct 2020 19:07:25 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 8/8] btrfs: skip space_cache v1 setup when not using it
Date:   Wed, 21 Oct 2020 16:06:36 -0700
Message-Id: <92f5a39baff2daef37c5b5073afd5bbe876cd57b.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are not using space cache v1, we should not create the free space
object or free space inodes. This comes up when we delete the existing
free space objects/inodes when migrating to v2, only to see them get
recreated for every dirtied block group.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8938b11a3339..59a130fdcd5c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2325,6 +2325,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	int retries = 0;
 	int ret = 0;
 
+	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
+		return 0;
+
 	/*
 	 * If this block group is smaller than 100 megs don't bother caching the
 	 * block group.
-- 
2.24.1

