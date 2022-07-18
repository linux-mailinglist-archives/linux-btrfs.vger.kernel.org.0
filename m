Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD2578D5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 00:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiGRWNT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 18:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiGRWNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 18:13:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EEE313AD
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 15:13:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E78425C016D;
        Mon, 18 Jul 2022 18:13:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Jul 2022 18:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1658182393; x=1658268793; bh=wdWdwaEIhUyoRKste0G1+R61v
        VCK3WBL6md7MtZaBO0=; b=Wi+4RUJ7e3gucBuEaiFbfdEMLTVjpFxtoXN0GbpyJ
        /19nYql9fMTR9SNu4/7Fn7fTai7I03LskPicqJ8pN6PEQLnhOnXNr/0Iarxh1Kha
        ZKc/QKlFYI19k0iMe1TWTt+q3CTBQR4hQcNPz3HWaqV2s5j+UxVm4sv/3kyIOPXa
        AgqRvJLWGTff/p3UsZ5F9CNksl0w2Ck+E/ngHDp3ZNWMSJ2gKOXPaGUf+m3JhSNp
        tVVNpcttgqjuS/WVJpHTg0CRpc4WovDKieeHmBv/C5jQ2mM7A6vHuYoTjcK/QTsW
        /ygHqvZT3zcdNCeh6HQydJXUsGTZQrrrySvheOOJKUpwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1658182393; x=1658268793; bh=wdWdwaEIhUyoRKste0G1+R61vVCK3WBL6md
        7MtZaBO0=; b=tQc3B9rk+yc+RWXowFbforSfMYQfzY3KeOafZYWlgNodLw4H0Xn
        GwOBajXEeGhs5wkuSbNsgmbKc1J0R5cbYreOpStV+Zf8E7URQP+gM2SXSmR8PUph
        8smMknCbRpHyZ1/tk8RSuUOPYmg1Lb7np2PHxvuPjBt4DOeQga7qwziTg/bwygMV
        pm34w6/lD4Mkbd8+hz6rrSi3U/VBnfVhbQOZgsJQTlA3IZlF07QfZWeO9mojc4lx
        Um5utahNRtKr0baT6hhlwk+WM4zihZ+kFljqztE+icDdZ1N4psFJ1mXidW+FCYp8
        PVJLtbyJs9T/dhUyHt73NkNPmAYGjO5vwEw==
X-ME-Sender: <xms:-drVYrf0YGzqmeSPS__u9HiVNi1l7LjMg1JFw_ParOGwt0GLNv0kJw>
    <xme:-drVYhO4ztOItOMrOvsaEfq2y86Vcp-W-5ot9Am2tKS51dJK035zeTXHzmWWJ-hL2
    eMVhKyYj8-RRkh7iz0>
X-ME-Received: <xmr:-drVYkjKSQsKgI_av51W3DK1VBr46gjsdUH-CpVNqm1_r7ZMQkIPDmD_s7nMq8lfi0vczcK3NZE59tQyg1npNFiJbwoqJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:-drVYs88a0k-c3xWANbpHCFIPRROQKvR9z0f_iFVrfJPTqOh_HXjLg>
    <xmx:-drVYnuiYmi9WNSlMefisLG8l0U0nqZAvamii8m59KQrY39Ub51BnQ>
    <xmx:-drVYrFMRAR6py-Tub01-Rrk5YOa_Q_I9ESyEKThtSECSXJGhNxJuw>
    <xmx:-drVYl3o2mVeANFrXCj6cIyETCNygQnUbPYw2R5B7QF-9e6QRF0AYQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 18:13:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/4] btrfs-progs: support for fs-verity fstests
Date:   Mon, 18 Jul 2022 15:13:07 -0700
Message-Id: <cover.1658182042.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
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

Adding fstests for fs-verity on btrfs needs some light support from
btrfs-progs. Specifically, it needs additional device corruption
features to test corruption detection, and it needs the RO COMPAT flag.

The first patch defines (u64)-1 as "UNSET_U64"
The second patch adds corrupting arbitrary regions of item data with -I.
The third patch adds corrupting holes and prealloc in extent data.
The fourth patch includes BTRFS_FEATURE_RO_COMPAT_VERITY to ctree.h

--
v3: add patch #defining (u64)-1 in btrfs-corrupt-block
    check item bounds in corruption function
    improve usage message for new corruption use case
    add patch with verity ro compat flag
v2: minor cleanups from rebasing after a year  

Boris Burkov (4):
  btrfs-corrupt-block: define (u64)-1 as UNSET_U64
  btrfs-progs: corrupt generic item data with btrfs-corrupt-block
  btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
  btrfs-progs: add VERITY ro compat flag

 btrfs-corrupt-block.c | 128 ++++++++++++++++++++++++++++++++++--------
 kernel-shared/ctree.h |   4 +-
 2 files changed, 109 insertions(+), 23 deletions(-)

-- 
2.37.1

