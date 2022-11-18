Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA662FCC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 19:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiKRS3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 13:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbiKRS3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 13:29:18 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0B99E8F
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 10:28:06 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8AE6F3200413;
        Fri, 18 Nov 2022 13:28:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 18 Nov 2022 13:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1668796083; x=1668882483; bh=5d4uOgJ66q4TKOdJ4ILy08Wzx
        R1HfJkzXMl+8rQT7LI=; b=n5UUSzY2tJXOIFgelbedt9T2CwswcAMNryMJU5L6k
        SlU4wl9e244+IfVRJTGgJYTafw6OLumlMdmfhvd/mL0AQN25/VTt3tEM7ND4Kjl6
        5GKYjhQlR0G0eQ5WQ4ew4XNSZqByIk2UJTcbJLotYrs5fCmYft9usNLsOe61lb9X
        RmBJSUPexjFdTG72SNBandtMSL+d+6DOLzmsCnRgTN6Cbvq3Ksrjp6FG+TIvOPfX
        Asp39bRK18cme/Cs8xixVO3ruPsmZNnKob7GGQ/1o16EoqOFvYHMDive7tBzOhva
        ytHbxZIsZjhsFaxbFsqP/pMjgR4AhVbZQO3RlF1d/hhOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668796083; x=1668882483; bh=5d4uOgJ66q4TKOdJ4ILy08WzxR1HfJkzXMl
        +8rQT7LI=; b=Dilsy5WQKtRVJLwnimD+nSMEg0FBw4UtEd4gnh/gJpVJm0CfFZL
        CrHzB5Yswsh0Iw2gSjU+lyC6J5FGriOwGo7TT9DD9G/DjSdsgVZULQRfV30Wtu5W
        YbSHlvxKRjxsRhEkTTf0dlaDotp9YrgcvKKj3OGK6fiVAUnCV/1x4/FuzV624++Z
        IEdKodl8QjxGnoknjj4wchaCe84ZcIhq13tTeicwiaxqBKVBvcnZFdx3ppw4o+7f
        y263IHiBF8cahUr0oM2xOQWZoyPNSx/OMNNzae8YBlIQBT7d3/3bJL7IeG4j6Ssz
        JisDez3kn18Dq+HkKzvhDC9c3J+NbwcqGsw==
X-ME-Sender: <xms:s853Y4J75JNDiHhdPW2AkXMgsi5J4HJgTb7PCBXSt_q8QQy0hDaT8Q>
    <xme:s853Y4J-DR_d80NDhWR4HDRGSM8ezGBmtAD0ScEXJZIJ5c0kUQXuHDOhXKKwx6y1Z
    YQ3IY7pbxdU87Jmaiw>
X-ME-Received: <xmr:s853Y4sBoKurGk8_stUczcYZBrDluN0f44mBF72eRxMC0JYE97dA25Eh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:s853Y1b2ig89gFSNeoAGj2SNev1zKq0qOY5FXtr5jSECTAJG8GMcrw>
    <xmx:s853Y_bqB18LdxgxH5GIgiLMag_ggb3cxxMnhPfXVrA6PkdSjnJiiA>
    <xmx:s853YxCrJgOGrARiW3G7YSY6Z_L8qurHaWNySVY0n3V1tpCI5cQxgw>
    <xmx:s853YwCl-TYz9BDP-NszJhWQ9WfRlMJxLF-7GRVl4YVXCPc0zGLHfg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 13:28:02 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/4] btrfs: data block group size classes
Date:   Fri, 18 Nov 2022 10:27:57 -0800
Message-Id: <cover.1668795992.git.boris@bur.io>
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

This patch set introduces the notion of size classes to the block group
allocator for data block groups. This is specifically useful because the
first fit allocator tends to perform poorly when large extents free up
in older block groups and small writes suddenly shift there. Generally,
it should lead to slightly more predictable allocator behavior as the
gaps left by frees will be used by allocations of a similar size.

Details about the changes and performance testing are in the individual
commit messages.

The last two patches constitute the business of the change. One adds the
size classes and the other handles the fact that we don't want to
persist the size class, so we don't know it when we first load a block
group.
---
v3:
- fix double newline in extent-tree.h
- fix ctree.h include in extent-tree.h refactor
v2:
- removed 1G falloc extents patch
- rebased tracepoints patches onto significant header file refactor

Boris Burkov (4):
  btrfs: use ffe_ctl in btrfs allocator tracepoints
  btrfs: add more ffe tracepoints
  btrfs: introduce size class to block group allocator
  btrfs: load block group size class when caching

 fs/btrfs/block-group.c       | 234 ++++++++++++++++++++++++++++++++---
 fs/btrfs/block-group.h       |  15 ++-
 fs/btrfs/extent-tree.c       | 167 +++++++------------------
 fs/btrfs/extent-tree.h       |  81 ++++++++++++
 fs/btrfs/super.c             |   1 +
 include/trace/events/btrfs.h | 128 +++++++++++++++----
 6 files changed, 467 insertions(+), 159 deletions(-)

-- 
2.38.1

