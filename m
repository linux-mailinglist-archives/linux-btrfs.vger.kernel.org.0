Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1616B5768CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGOVWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 17:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOVWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 17:22:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5271BEC
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 14:22:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BA945C006E;
        Fri, 15 Jul 2022 17:22:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Jul 2022 17:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1657920134; x=1658006534; bh=g6fmEXGFU9Rbp85+B3PiDijjl
        JN4/A9LmbfU81HFknI=; b=fDAO9W2Nkeyu+Fltab+CtTFICnKQW7gCZa+PPFgzg
        A3wZ9JiaaFVT1oNrYlfBebCt3/04a4cgSTDiGa884PvW0pFZu4OAvXmoVc4zZ0Es
        TgH3RvGMQzpyY3bJ06Iz26BkRWQxAdTJtWEG4EjQb4lmhBXOyBryt9HOCeHhK3f9
        1r9Il3Y7xsYVZYWLvxoz1M5yfvLCBd6/iWDTD3Q5nI9nwURhLiFk4K1QZ7VYZjzj
        R98PaiwVN3PjzIBbEr2xTCpH2eUnmvxD6/jouobe+tzaNfLM6NXbheFBwBG0dysK
        kvbu6tOJnNhaGKqhevQAIsVvOrBr+jyQjVuS/rKSRfSkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1657920134; x=1658006534; bh=g6fmEXGFU9Rbp85+B3PiDijjlJN4/A9Lmbf
        U81HFknI=; b=LSFxdj+i7cLBlj2xxMuYtN0U2r5J6pUdR9UeysZBRbw9h/n/vwd
        ROfr0wEFFw5aEdb1Pul/yMS87q4jZAF632hdkPZwLcp/pAvJXe4plx27bSSJjGKe
        Notm32WOjK8pwMt6gr+A+lLidpooLaI3swStC3xk0ltwsfoMLMB58f4oLmXpkYf5
        Tht8zFlO01JSj/RkhrVv/gCdPHJr0VenX/mCLwIFlLl/7Eer21IDaExIr80OrFnR
        TuncBrogcVZX04D4O038rLKFaTc/cjkzaivw/Y75CwXZ2TXDLOUemlJMULGKLkwi
        sAjP1BQFRu1J2Q7KyNfYCsPZWU4W18AYSDw==
X-ME-Sender: <xms:htrRYs3VyS-Ti7uwCBZF9M2tBK_KtLRS_-gxvNGdw1xhjvAN9SA9_Q>
    <xme:htrRYnFS-NW-KYX8ARgnqOopgjzuwXK46WOKN5drGSOK6sfm_NOAFFg_BOLxkwMtx
    NNhvuwZbh-te_1__oQ>
X-ME-Received: <xmr:htrRYk74WCoVQvSc5SwuzfmoVRIpORTAEAFDZnURtRRMnFW_7g1_eWiz5x6ePJog7ux8T9Ho1_kNXN42RliGaeC5k7teXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekuddgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:htrRYl05w8cv8tGiaAXUSCG_PtTwtY_w2RNkouepbCgVRQiisjvpeQ>
    <xmx:htrRYvG-qDdtvuxsuLHQ6LWgKrG9bCLK1J4lTtMvsTxvROrhWrSxJA>
    <xmx:htrRYu9ueNOswO1ASySqe1MjOZbNvCQylD8das9_N5Jv91-qw2oB4w>
    <xmx:htrRYiORQzUxYRC0wRxH0N88x72FFl_tqsGLj6GaoAG4ojCTf0gBRw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 17:22:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs-corrupt-block: btree data corruption
Date:   Fri, 15 Jul 2022 14:22:10 -0700
Message-Id: <cover.1657919808.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add some more generic corruption to btrfs-corrupt-block which allows
corrupting the data in metadata items.

Motivated by testing fsverity which requires rather specific corruption
of the metadata.

The first patch adds corrupting arbitrary regions of item data with -I.
The second patch adds corrupting holes and prealloc in extent data.

--
v2: minor cleanups from rebasing after a year

Boris Burkov (2):
  btrfs-progs: corrupt generic item data with btrfs-corrupt-block
  btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block

 btrfs-corrupt-block.c | 93 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 8 deletions(-)

-- 
2.37.1

