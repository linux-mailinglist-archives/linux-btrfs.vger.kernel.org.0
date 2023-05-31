Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336B8718740
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjEaQWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjEaQWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 12:22:45 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31688139
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:22:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EDEE5C0078;
        Wed, 31 May 2023 12:22:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 31 May 2023 12:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1685550162; x=1685636562; bh=8ISBSWIzlX
        lIXwyhnaEXekvHLGCpUXeNX0kCILvfTlQ=; b=H0r7Tge2uiArMlzM7oIMoEqjl+
        r/qubomvQ+rZKlhbxVQxZw2gjYIkWWM6+t246EA+yfBUMVQRcqeTXnAcJc3KAwZB
        G8nLt9+0Edm4N6ixQ+4LILYGha6c09c3AG4XM6Bkp7z5xco1Wk94BYhW9pNywGDL
        wHYAX9uC5uM63IBEQDiojiAn7hoZ9OXmt6RsFh/tzxAPFpOhOSc0NwMbIu7BZssQ
        QZO46721CeWfT4Oz9Y1pXOVlmlW7MDxqsOlDTRxzC8xOtRagJE+N1bP1IUxuL1uQ
        pkH9daJdG+4ASYDRwVqOR0RdUtsB+a01lKlMCCo5bmDu0zA0IqE3jXYi9AoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1685550162; x=1685636562; bh=8ISBSWIzlXlIXwyhnaEXekvHLGCp
        UXeNX0kCILvfTlQ=; b=JljwFyeiyF7bNrOz+DUS2GWWKy4soheN3b/udzwrOXL3
        1dtHy1+6IPzRcx1MRvfEbLfppF1OS0/7zlWtYeNp9HAZI9RCtkU1PSiQ15FTQPdJ
        FngJgmzT0m2rhxx72tCkt0Rwhmp4CuYt+x65p5r3MRcsaNB5N7uMb6b2WrcIxBTc
        kAMjLmu92nmnqj1EfVv6OYwYb+KfuWYuMp3HXoEoFWBFSE5gJXLeWw5XenTNXmbw
        v8HlLy5xRYr3yWuHQyD6oh4GbzMUxjGOALN7VFKxSRCgHmolz8kM84kEBbIrX+Vv
        hguOzMzo4NAjCMi3gOqzkXTKx3TTXP4utduP2oIQQQ==
X-ME-Sender: <xms:UXR3ZHKUVXYxYKjPdnFvG48VPPApoDhOWl9mk1-5-f7RcAwBuro-MA>
    <xme:UXR3ZLK83ELRe_rIfGYAq-YRJAprRJSs5QmBmdXXGXU8jo5CHxA57KTbglJz5R1R2
    LjWRbD3JFsuO48bDxY>
X-ME-Received: <xmr:UXR3ZPub_BAULzjGWFoWEk6FAVhdL47MI3xNzCpKnHUySzKaIVWCR7X7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:UnR3ZAZY-ekczbioEjXOzip3iI1HtA9mNKfUoa8Mb4GSDOO9DSe5ug>
    <xmx:UnR3ZOaiCzpEkL5xnauFI8JAtGKXrev_6G1F03kWmhHo6jAN7hi7-A>
    <xmx:UnR3ZECcPUxGwBBoHp5doZG8dY-PNFpTcvhvHnONXrHTDykDVq4i9A>
    <xmx:UnR3ZBweBZWqq-qPzEn4AyYKbgoR5cHZGkpP8Xt_xV_ZCkbFWvFRvw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 12:22:41 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: [PATCH v2 0/2] btrfs: fix logical_to_ino panic in btrfs_map_bio
Date:   Wed, 31 May 2023 09:22:28 -0700
Message-Id: <cover.1685546114.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The gory details are in the second patch, but it is possible to panic
the kernel by running the ioctl BTRFS_IOC_LOGICAL_INO (and V2 of that
ioctl).

The TL;DR of the problem is that we do not properly handle logging a
move from a push_node_left btree balancing operation in the tree mod
log, so it is possible for backref walking using the tree mod log to
construct an invalid extent_buffer and ultimately try to map invalid
bios for block 0 which ultimately hits a null pointer error and panics.

The patch set introduces additional bookkeeping in tree mod log to warn
on this issue and also fixes the issue itself.

---
Changelog:
v2:
- move WARN to before the bad memmove
- change WARN to WARN_ON + btrfs_warn
- fix tm freeing bug in tree_mod_log_insert_move
- unify error handling for tm alloc failures on setting tm=NULL after
  setting ret=PTR_ERR(tm) and then calling kfree unconditionally
- tidying/nits

Boris Burkov (2):
  btrfs: warn on invalid slot in tree mod log rewind
  btrfs: insert tree mod log move in push_node_left

 fs/btrfs/ctree.c        | 17 +++++---
 fs/btrfs/tree-mod-log.c | 94 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.40.1

