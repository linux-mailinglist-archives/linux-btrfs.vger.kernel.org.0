Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34C46D8721
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjDEToN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDEToJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 15:44:09 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FD3596
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 12:44:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4FE4632008FE;
        Wed,  5 Apr 2023 15:44:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 15:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1680723847; x=1680810247; bh=FBoMOA+geU
        pAKM3pFZLHyTZ1YeFh84riXMRw+/n/BdU=; b=vU/hN7csJv6eTLWAfSNsNWq9lI
        Bh+0jebb1pUJXbKilImnDb2KEDj1vPYsoLZ1IJR1UT+0pgoHcH1CVmmkhcD6hssP
        8jcDPHSO+etYFM1/kTI21ucQE8g5trz06QD4yP2bYJMn2acmZqHM3Dc25QhSmO0j
        QXJG3hrOFQcSi8tLpeWTryENOLerwzUCvodN5THof+6+vf27Qp/Qfco3l03cX5C+
        7fi5w608txa/g5V+eK1xlkig5tBaAq2zlkcdSS2VrRPIYjPrrxImFeexvRA7gvsc
        PgYaoKuxW8WKPo4sxyJvWUkCEPrKXjcTHXFKTeAXjuBVKun1RKEzMwE6+pdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1680723847; x=1680810247; bh=FBoMOA+geUpAKM3pFZLHyTZ1YeFh
        84riXMRw+/n/BdU=; b=bfOddHzgDZwQ1ZzX3Q9mdxReeMZT/OkqzSlIPY3Ki7ZD
        8blnIr+4Sm2z6l9k4YNJNPoniDm61R/FifD6ChKRZEt046ZvyIWvFWV0UlI2U05e
        knGh6Cr8ZHSgLnbO8PkZdcr0JZFxfY9WaoK0Ss8f/x2BXfdLyvHkYAR8Y0glG5Ka
        WPG30vcwP2pOoAMEO9FY+QujIylfKDBKvp25Osrwv3/stu0DSCdeMj8z75qP44dQ
        rP3Z5cfzq9okNbBr+eANvGI00FqNsm4TaERbzEs5HqwdV11kRuPheut3fyFBeq5H
        9jzLs2OnptR9O+W3sl7pJxYBvdNQjG/cFuCBtWX5hg==
X-ME-Sender: <xms:h88tZObkX33lKfN0hpX4myS2UbRaJggAS8bnhg2RNTIaH24AqM1D2Q>
    <xme:h88tZBY2eUm749cERWOXTWnyRri0lkB45iI78rdNNLJRYhzoTPzcgaveCTMVRv3RA
    DhTqcj3xl9aXpWsIAg>
X-ME-Received: <xmr:h88tZI8j3BYuT-4BTcjDHDZFZ1nlSrappKwYxXJJU1FgnvLQZDnb2SYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephfdttedufeetudegvdeihfejlefgiefhheehfeejle
    evjedvteejjeehueefkeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprhgvughh
    rghtrdgtohhmpdhrvgguughithdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:h88tZAoKZZLffgy1b3CS_PEaajCXxmYuR0AS2WZD03sgpCfq8Upgsw>
    <xmx:h88tZJoGhkWLNfTx7QvU_dA8Nou48qOuDqSjKQdiI6vyztWBoJcUPw>
    <xmx:h88tZOTH3SYL0E6BUeYqo0GWdLQIgQ2wDjt00FlMKjDixj7xarluVg>
    <xmx:h88tZISDbsmtWJboGuxQE3TrkwQsce1OVjuc_hv4mD2YUPNIGRXLEA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 15:44:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs: adjust async discard tuning
Date:   Wed,  5 Apr 2023 12:43:57 -0700
Message-Id: <cover.1680723651.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since discard=async became the implicit default in btrfs in the
6.2 kernel, there have been numerous complaints about discard being
too spread out on workstation systems. This results in situations like
a users drive not being idle for an unexpectedly long period of time.

This is caused by a relatively low default iops limit of 10, so this
series raises the default limit to 1000 (1ms delay) and modifies a
weird fallback behavior for limit=0 to be interpreted as unlimited.

Link: https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2182228
Link: https://www.reddit.com/r/archlinux/comments/121htxn/btrfs_discard_storm_on_62x_kernel/

---
Changelog:
v2: actually set the limit to 1k, not 10k.

Boris Burkov (2):
  btrfs: set default discard iops_limit to 1000
  btrfs: reinterpret async discard iops_limit=0 as no delay

 fs/btrfs/discard.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.40.0

