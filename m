Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42756986D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 22:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBOVC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 16:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBOVBu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:50 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D17457EC
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:59:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C8FD8320097E;
        Wed, 15 Feb 2023 15:59:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 Feb 2023 15:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1676494792; x=1676581192; bh=LQHOwDNxn5AmFZ2wriC/j5aUP
        N0Q6DhqmfOUCrtBuY0=; b=ULB/vOCVZoijGisJ9twjkiVld3l/vLAJu+j0RwTI8
        3N3k8fa9h7kBPnCAmEdLz8M/24b9JbjsOtRsYhBSYPV0AQ6AQGbQ737f/BORM7hn
        3BPRBXqm2n8C4lrmGZXpGVej3O/jatDeoNXkJjvg+IAr3V9nbY2GgL362LDdT1km
        1sj8KNAoocl+AwQSE25ZBPJ145eZtofu/B7k6lSndAsNeYZY9NA8ZRDR4sdYTliO
        zRSUoCeQY2H/P+rSQu7RJIfNhdwSsTiruIW8e4/7wu+lBGVOvZNmJ2B4r0/dVjqm
        wNlsZvS5Tyq1y/tNLWzohOIidg6Z2Mviz6BY31G8p7Hgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676494792; x=1676581192; bh=LQHOwDNxn5AmFZ2wriC/j5aUPN0Q6DhqmfO
        UCrtBuY0=; b=sQCgdmoP9jmY+as8lCTdoRxGyJQCWLGjejCgo7y1RnzM8F4Fpk3
        MC63fFYMwxYKkg+dtG9rqqs15t6RYbYDTy9qRLAjb8ehlncMq0KNSZoeA8LOniti
        /haocLRGXYXecnlFLD4WIdx2VE4+wlyEp20mVZdb9xOsJ6AiUMdns0bCt6XXsRcD
        75muAGPWF8I7RCyRCMIQ6JJzwnjnTdsXUnA4P1crEmzT892Ar5ZDmQ84yf3mmVqv
        Bl3dA2bsn6Nwop8lXEcnsavtSStZYQAFj0ejlszJRzYQTfdkxtUBhcvHY2WyNtv2
        KpwD63eCCRukDrJTRVpu8mIWjdn/DWIeDrA==
X-ME-Sender: <xms:yEftY8wVvI4mK-gAQrgHT5fBnHKltJO_veVr9Yx6N95EeI3ezpDf1w>
    <xme:yEftYwSssAkQaPchEDR2N5yBVIfjt1p-r1y-ooJ9Xyl4KQLJV7v4-gUKGq3I9S3b9
    npSrQV8ljDEoeu3ubg>
X-ME-Received: <xmr:yEftY-Ut1d2caBZsQE6F7YaLa3qbpaXRK-kVh-RlWUqOr9eWlNvvh6Da>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:yEftY6i0_yTz5cxB9-AvbTgpVJ_Zei_456EDedcW22CSsKKBNnZ1qA>
    <xmx:yEftY-CfUvSUaq4N-d_uQpvqU7PWfygNI6lTdIxnAQ3YQBFgUm3Y-A>
    <xmx:yEftY7LuN2ZIZH0AOdHQb8xSUnnwBskQ3N-pUTHxnu-BIqfieyuWSw>
    <xmx:yEftY5pCYgXeLbuW29aOIgYmAXk3plBdYXM5uJTZMDsZ7tTb4n85gA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 15:59:51 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/2] btrfs: fix size class loading logic
Date:   Wed, 15 Feb 2023 12:59:48 -0800
Message-Id: <cover.1676494550.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unfortunately, this code needs another fixup, as Filipe discovered that
the fixup's use of search_forward caused a deadlock with a thread
holding the tree root lock and blocked on caching.

---
Changelog:
V3: move to btrfs_for_each_slot, drop contention checking logic. Sysfs
patch holds groups sem, but releases it between raid loops if it is
contended, matching the behavior of the raid_bytes file.
V2: just organizational changes to how the original fixup was sent

Boris Burkov (2):
  btrfs: add size class stats to sysfs
  btrfs: fix size class loading logic

 fs/btrfs/block-group.c | 42 +++++++++++++++-------------------------
 fs/btrfs/sysfs.c       | 44 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 26 deletions(-)

-- 
2.38.1

