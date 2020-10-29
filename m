Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727F329F8F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJ2XSJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:18:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60021 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbgJ2XSI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:18:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C0595C01C5;
        Thu, 29 Oct 2020 19:18:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Oct 2020 19:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=sUVdLcDMLXZbJwvIloH7jpFhg/
        xLyevGNEkUgHuERHc=; b=hdCVHld1uZlXMYzYA4obiFdL9SDqd1t9PvrGhu5Ab+
        5isYTwOTB3ADYd8xAxA8urEpt27XBWfldzdhJd6d8KjPEsAqHIIQx/J3ZCvLlrMn
        7gQH9hKSaiV5VQsPm+Dixh9BboqbgzMvyGrptv4xpDOP6IE1aCnzP41JVtnw1ITb
        6vkIsCfnWH0iUm1ODA3vJdADDXDzGtqcYSIi4HYfBEg+CIQwWPc9/I04kqDb/oR6
        LrWiK9ZyfGkn2hD70amfTDTwHQQ0qwWIeHjepEx+0/CJg7UAi8p1bYqaPSin9QWS
        zL2uIr2Lig333j789phWAPOVx1Y6NKtBg/8cUskoh+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sUVdLcDMLXZbJwvIl
        oH7jpFhg/xLyevGNEkUgHuERHc=; b=RHih5xdONJYgS/fRTCaDYUeu00w0YVHuJ
        9tiG6W7X1A8DmEVQ4P31KqJDbJ/dwcpvZYZwiyI4zQlKFycdLapNd0wcCLL+guqw
        fjT3pKMiN7ueuPMGsMIrb2AICpaBPgJZ6UD24rCUYfqN6ks6PGJ/S5TAU9912ZB9
        k7Ii0cSIDvLOOEBNqLmNw4dBL3ng6oeAjfRsrxUI41ynbfwRHT7RWi/AreBRwIhJ
        zWehmReh/bjkYbEP5RaG3YeH5HpV4obT6oHt7zz+fAcWiQMsfCJwSx2NTwUapfef
        nm8YWocWld7n91WpO/evxLzTX7WTXKuILOIC+iBfzSEnMrytuz4TA==
X-ME-Sender: <xms:rk2bXy89nW9caHKGsB0_wKjueziASHsbo8JJQiUSPvh3ro_2PV_nhw>
    <xme:rk2bXytjNTxl1x4BiWjPaczwPgcNBm1guBT3W_TuXsdjk_m08zb5Wo4_syGtlwEVf
    TlqbIze7VasxtHE-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeejudehlefgtddukeeije
    fggeehheejgfeijeevveetieevueekgfehkeejnecuffhomhgrihhnpehgihhthhhusgdr
    tghomhenucfkphepudeifedruddugedrudefvddrudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:rk2bX4Az2EYGcj8G_9a1CzY7v0BdF6jGCZle1DecCzav9Sd9eZ5T0A>
    <xmx:rk2bX6dZNicER-kn9J0bQVXWqH1jtPi_fb9oQG5nmkPJrZLPkUYpvA>
    <xmx:rk2bX3P65zqQKZRzVvY6ijFtpuWOrWAy32au-QoqHieCNEVK-tRjWg>
    <xmx:r02bX91SKplA4vXejFEJ9VnAQC4BLyQBW2xQsVYgpeJBtRIxOXY5bQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57E8D3064682;
        Thu, 29 Oct 2020 19:18:05 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs-progs: rescue: Add create-control-device subcommand
Date:   Thu, 29 Oct 2020 16:17:35 -0700
Message-Id: <cover.1604013169.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset adds a new `btrfs rescue create-control-device` subcommand
that acts as a convenient way to invoke:

	# mknod --mode=600 c 10 234 /dev/btrfs-control

on systems that don't have `mknod` installed or when you're lazy.

Link: https://github.com/kdave/btrfs-progs/issues/223

Daniel Xu (3):
  btrfs-progs: rescue: Add create-control-device subcommand
  btrfs-progs: bash: Update completion script with create-control-device
  btrfs-progs: rescue: Update docs with create-control-device

 Documentation/btrfs-man5.asciidoc   |  8 ++++++-
 Documentation/btrfs-rescue.asciidoc |  5 +++++
 btrfs-completion                    |  2 +-
 cmds/rescue.c                       | 35 +++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

--
2.26.2

