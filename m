Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A686D838B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDEQVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDEQVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 12:21:11 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487461B2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 09:20:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EC6D5C0068;
        Wed,  5 Apr 2023 12:20:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 12:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1680711641; x=1680798041; bh=wskrRJPjQc
        GtpgriZ1PBDUGePxm/HKM062HT+OfXivw=; b=soH8/ddNN/WvCeaDoelXo7AoTv
        iaEIlLt/lCCIxEVumh1viBzQvZwnDbvqmj5ZRQigvlKjwChWmOklAPCajTR6dPfS
        FcN9cpiIioIbanN0IOU/F1WPs1y1OJtyqVmpJTCZVmiMbul82PLy/3wkNVf+71+X
        8DBDgQGeeAUSrEFuhWH8TBum4Q6BKx6RuBiaS4SGWZ+wOFtH6B4+i82pSI+nk2lH
        2GYchKJd1Lm++PCoDph0Og5f+eo6+aSoo2XwCs8RKX4C4ypDzA02r2iciSmpXRQm
        EFpIQ3cXUIjGQmPKQ1UPxIfP2Pndx65aDEN5lZZijRoYjPJ6ryB9ga9ernyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1680711641; x=1680798041; bh=wskrRJPjQcGtpgriZ1PBDUGePxm/
        HKM062HT+OfXivw=; b=WRagUuEFc7DuX17vMiby4mHiYAR9a55CCGctuRWDeBbV
        7GUQnRp8vTq+2wER1NY5yXJzMQVV8xYKCx2aFzWGtbcUVa6I31SQsyhIAvyLrJof
        LCyNxlrPeZgyq6qi1hPYRTjQOO+RnRDlEmfRRvSALfyw3RK+FflH68OvrOAqnLXF
        GqwDFszBjMQzexMUg9ixbgd/V+bwHjzpYslTGttIZTSoO6vL3nOw7bjzD7Vi9pMu
        Iwu8c8/JcXBtaSRT8m51IvYiddTbuyFd7mY++ps21507s+PzqgwercFHaSul8N+X
        O7NoFptl9wQUfAIfcntQvexNRT0Drtg2CeZUDIn41g==
X-ME-Sender: <xms:2Z8tZD05NXsnYR1r4cp2_KXFCZ4QGg3-83NsON9hJZbCsrvZyMfP8g>
    <xme:2Z8tZCFJSDkqwQOuR0pitSF91zyA03jMY4ST91fC0G2DwFfnFke2RbAMwZuv4JKld
    rzXz6PSNhfqSp2C9ro>
X-ME-Received: <xmr:2Z8tZD4hR1UhGMrWM184eiMKvneBFR1Sne_njHQdemR1zegLyADHKWeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephfdttedufeetudegvdeihfejlefgiefhheehfeejle
    evjedvteejjeehueefkeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprhgvughh
    rghtrdgtohhmpdhrvgguughithdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:2Z8tZI1HMuVLTX47vHMoibRyCIZsrslLsraof9QCpeInBOQN8_mW-g>
    <xmx:2Z8tZGHp8DqGD9lnOPX-cHAgfWtiEhg5AL94BLyU3ZuJYfLfzNY7MQ>
    <xmx:2Z8tZJ8gk06wtomS2DDZELTYo7y_ck6_kb6nfPVyxn3GIz_xaIEMmw>
    <xmx:2Z8tZBPoE6SbsgUueVkqTTv7T9RC1T8GHBDQYivBzu1UoxUIGDpJqg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 12:20:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: adjust async discard tuning
Date:   Wed,  5 Apr 2023 09:20:31 -0700
Message-Id: <cover.1680711209.git.boris@bur.io>
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

Boris Burkov (2):
  btrfs: set default discard iops_limit to 1000
  btrfs: reinterpret async discard iops_limit=0 as no delay

 fs/btrfs/discard.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.40.0

