Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A541269EC13
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 01:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBVAuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 19:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBVAuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 19:50:06 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B3730B26
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 16:50:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 195BA5C0162;
        Tue, 21 Feb 2023 19:50:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Feb 2023 19:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1677027002; x=1677113402; bh=z2NvaQwdguHeIKWqwG6MwVh1K
        AAgj7NPU/a4DByJCoI=; b=mY/nPyc78dV+FEhaXItQSXEmFBlB3e/2j4jlyU/1V
        ulNm+D0NBbU4TZfKt83tHf6e0KH2azpW+YDKF1FXR+enJ6WcTxmowvna7bsyDn8a
        zHLM6Xq3sJ+Po07drBcGt5jkqER+WCk7fhcne5f5d9aRo2TkRbE2Hq3wIgLb4xv1
        SnRAA1O+9Sn5FJmJvyKnRp5bH1qjs5M6VsGE9hfR6pJy6lWwYBWLXScMWS+s9ptY
        cQqKiQO+xTyOPVfa0LqZJpP0F+g9l9vy7T0mQ9TtvbLmiLhdFEJjVtW26mDFKnxB
        koUfNGRizAZXbJAlXdNx4W8L349vFbXND4h9oYuIf3RaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677027002; x=1677113402; bh=z2NvaQwdguHeIKWqwG6MwVh1KAAgj7NPU/a
        4DByJCoI=; b=QJITgAJdeu/qwTcWxPDmBRV6UTqssbr411ohpM7oihdhOl7E3wV
        xmegcyJ/7hPwoJIwWO67gAVRqj2nWITiRnIx9tJSTu9Hz028cvkRdOz8onmBoX79
        gIyRCgu7+1e8Wi0qyGubitsGcCtqSXFCpHm3yUCgweE7JoJm45i7+7++t++xuL4i
        7GDLXL706Hl1pqkeCCmxo6saGOMJ4bvm9B9IBl0nUqBwxTNwVeIuRTnbVhnkH/la
        BPtRIDyAz+UNS5SwMUpuHcTo9c30tiazymCWh6t0YikdniLYAMYjwpayi501okAn
        uA3N/zMrF7u393hJ5h4vrHKAyp6JLnt2j2A==
X-ME-Sender: <xms:uWb1Y08c4R9LXVFQJfz1jSyqKrAB37kaJVd3CEgf4jXk9LGaRh3CLQ>
    <xme:uWb1Y8sjErVvPEPHkCUny-zwLA5e9tBrpoXqwtsl06A9v99AyYduC5HdPXvJjy6XT
    6AGM7-midi15Lqg_SE>
X-ME-Received: <xmr:uWb1Y6D3ZWUtSnx44wjlGZkJymekt4Dp-VcrF0zi-c8u86gIO2FZ_6zy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:uWb1Y0ebRxXlVIgcaM1X9Jog9-R5TEn9tQYBez1PWCW1AVEueC-BEw>
    <xmx:uWb1Y5Ortlg-R2e0gTKCjdZEe3WPYTU5E10RxMa4la7zKK1yNrAvDw>
    <xmx:uWb1Y-m7Vwqj45BLPHqukDIZ1gHxwTtQfkXONJWsRF4jEDL9QixK7g>
    <xmx:umb1Y7VoXrmxSanWh29L9GKbsFf5rhxy-ogK2WlL6aMs-mRmQS6x3Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 19:50:01 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs: dio partial write corruption fix
Date:   Tue, 21 Feb 2023 16:49:58 -0800
Message-Id: <cover.1677026757.git.boris@bur.io>
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

If there is a page fault while btrfs reads the write buffer for a dio
write, then iomap will issue a partial bio which ultimately results in
an effective hole in the btrfs representation of the file. If what was
being written was not zeros, this means incorrect file contents.

The patch series consists of a prep patch creating a new ordered extent
allocation function and the business patch, which contains the fix
as well as the gory details of the bug itself.

---
Changelog:
v2:
- rename new ordered extent function
- pull the new function into a prep patch
- reorganize how the ordered_extent is stored/passed around to avoid so
many annoying memsets and exposing it to fs/btrfs/file.c
- lots of small code style improvements
- remove unintentional whitespace changes
- commit message improvements
- various ASSERTs for clarity/debugging

Boris Burkov (2):
  btrfs: btrfs_alloc_ordered_extent
  btrfs: fix dio continue after short write due to buffer page fault

 fs/btrfs/btrfs_inode.h  |  1 +
 fs/btrfs/file.c         | 11 +++++-
 fs/btrfs/inode.c        | 75 ++++++++++++++++++++++++++++++-----------
 fs/btrfs/ordered-data.c | 45 ++++++++++++++++++++-----
 fs/btrfs/ordered-data.h |  7 +++-
 5 files changed, 109 insertions(+), 30 deletions(-)

-- 
2.38.1

