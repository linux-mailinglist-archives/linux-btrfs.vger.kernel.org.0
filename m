Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1962C8DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiKPTWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 14:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKPTWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 14:22:11 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA926F2E
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 11:22:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 515C95C00B9;
        Wed, 16 Nov 2022 14:22:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Nov 2022 14:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1668626527; x=1668712927; bh=b109huWG7L8opDDC6Ck7SHGzE
        azRXw9DOZKUETTLwNI=; b=sxnX4y8qJQHMbIODUHTAVFtChzKggd+pFDdKPf/9Q
        qfz598W+qID+qWei1VRdp/ic4zNki6nAWOfZdA/NsHkDDQKdxjRDuCy4L61EZ1Fy
        3AKOatRX1pfadF2xxOYQI6uODJzNEH2tbwkgzGqfQ6v8utCr1B5soZzCNOjtVaTg
        ltjgK/4Ef8yabYCBpwfA2ugOoa5CTlFdgjx8qD8H1Ss6/H/HHepVuaczGAxkXA2b
        ZDUKCWPW9XVUqUAv8AIdqo3rkToabRzQi9nhtrbw7vQwkLj/8T/QKqBk1LFE9ROE
        6bpEsuD4KUQd0bvN2y5a0Yeivc1+sb+KuZy4l7YHN/3hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668626527; x=1668712927; bh=b109huWG7L8opDDC6Ck7SHGzEazRXw9DOZK
        UETTLwNI=; b=A6XSR9b/M0ordFQLbfpkGIxCcZGc1+x8/nUaZt+U9j+nRvPMn/H
        4DoW+sLAtxOzaOJaXDOXXQ8I2S4m4LTwYPqsESsJzlJfhkB18Le05l96pj2Vj2sF
        zHyURDdy/scyM9F6XIQj+1mdzaPxE3Jajw+fObDsNu1GHNuHMtrDfSQeS76AoT6n
        Q4fVRxOKeG8PYNujpDdbzUHXt58q936sFrUC49txwpnDcLxQjVLkcKYcSICG0UOC
        UiOd/QojX3OrPrOCsIRLAEHXPSx/v1q56XDXnWJIMLqCBb5A2w0Rc2Y0/F5wMIoe
        /D1fFyn7oUm0AI9WRLSCMK7dGHgP523hxug==
X-ME-Sender: <xms:Xjh1YzMwZ-_6YU7Qd2UdIvTi1dafLP7noL1oiZ7tpHAdzqObSgT9DQ>
    <xme:Xjh1Y99zN5X4OpnFiy93KtgmCp-LSsqhfc1fVjYb4PfV0hLndaDATlbjJNmMnVnig
    PnkTXBzFlaXA37o9i8>
X-ME-Received: <xmr:Xjh1YyQIq4XZ_9G5Jj0Dv94nUHzJQEkThagHdla1aCWaX4CGywj-jbGy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeigdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Xzh1Y3s7NpFgUVNoJJ1mZ89EmMBfiyd8exwIZ81jNAHFDAyJykTbMQ>
    <xmx:Xzh1Y7eZL0mpCEUYNTqBTaZwahknADWLovbFO0MaGmoQkS9yx4DbFQ>
    <xmx:Xzh1Yz15-dRKwKOJd48c01EYePP4Y7kkhkRCStD7PKnrW2Ekdk8TbA>
    <xmx:Xzh1Y7mFmyYgCTFdN4yRKc8wdMZmQCAA6NVoxQf8NJ1DmOVemPNHQw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 14:22:06 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/4] btrfs: data block group size classes
Date:   Wed, 16 Nov 2022 11:22:01 -0800
Message-Id: <cover.1668626092.git.boris@bur.io>
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
 fs/btrfs/extent-tree.c       | 166 +++++++------------------
 fs/btrfs/extent-tree.h       |  81 ++++++++++++
 fs/btrfs/super.c             |   1 +
 include/trace/events/btrfs.h | 128 +++++++++++++++----
 6 files changed, 466 insertions(+), 159 deletions(-)

-- 
2.38.1

