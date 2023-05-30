Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71805716D6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjE3TW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjE3TW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 15:22:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793808E
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 12:22:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B79FB3200065;
        Tue, 30 May 2023 15:22:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 May 2023 15:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1685474544; x=1685560944; bh=WfHVo1vfO9
        hY+0P/AsZbM3gu2Cv3fll1hrfGXOZvwik=; b=p6BMsBkykJY03qY4cU48h7sCbr
        7wj//1tbgt7/PqWftKJ8mZgeIxai/4uFhNqy9UxO/GRw5GFXHl79KxZFavIFiXAW
        daApcyU5p/birlaAQmXoTRxWiubB/OM0JQc0o5X0IB8xeagPGVAxUNTYpfPVgh0l
        2Ub/yDNXrvT2yik9apH68MlOvKvEkHgKFne7DmMuZVcBd3/cX7I95km35nISVIue
        mv74L+TPKCSTt+Z5hQKGgj/dBd65iXjQmTkwxbyhUjpWabeZhumS5FfeOtvD8rTj
        NDb8px3nhcIVzT8huWv+ki8o8pfJCDTCTZ+CWLztyNrNOlAgl26S+D4iWC8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1685474544; x=1685560944; bh=WfHVo1vfO9hY+0P/AsZbM3gu2Cv3
        fll1hrfGXOZvwik=; b=d/dcOz6yIQKdgbJt3z4HTlJSjmAGj5G9GCTwmkAZvlp9
        ZBjq2d+14FVY8OhWuGFYPozG34e4FuulgJspzpOM8S4hyunVxeFLpMHfUZoWXnkc
        McnK9iOF1t3qJ/Kej2/6FOSXN67/fFU0jX8I3/769zFquyiHYSeJ0D6jwttMyLc+
        mmvQFrFCTKGdgBAkeYpBW0jp6MHT6w1BbmV5EGYEHiO4JjXQaDEdato3axRXF00R
        BLTqQL7xA9EfCD9PgITkJmCQ0e5dDC5m+Ez3FrJw/Cb/uBdGHo8fScCZDpTVvVfS
        LxXRYPJ8a73xQvrgVtyZZNGTKUWOrKQjOfy44v35fA==
X-ME-Sender: <xms:70x2ZKe9bXtsbbJRdYtXjewvOy9mfCVMdsmGvC5VtrCmV245K7iNcQ>
    <xme:70x2ZEPmBxaklOo8STVRm00l_xpeaZ1ISwbi3i5tq4-D0LswCvGeMBPgA5gcH3xdM
    XPLMhWjBYWzLZkny54>
X-ME-Received: <xmr:70x2ZLiUYdEhT-9S9v2P0CmQutUE0WuaFp6p32SBZbcsbho5GvydIYkZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:8Ex2ZH8OrcArupGS24xnRzXo4W3rAwvTbnjbhQTePE6CfJieKPUPxQ>
    <xmx:8Ex2ZGsKDUBloZvos6SN50NL7e7KfgtfqCy1ryaP8yNYe3-snTVenw>
    <xmx:8Ex2ZOEtdOL_LTCMcIsHuCgM_aNhuArvQNG3_P1Zqp2sZMyjsVQ_Pw>
    <xmx:8Ex2ZM2Q14dHZBvQE4qdF1ImLlg7Jf1hN74MQiAHBWpf7fF8TTw0zA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 15:22:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: fix logical_to_ino panic in btrfs_map_bio
Date:   Tue, 30 May 2023 12:22:07 -0700
Message-Id: <cover.1685474139.git.boris@bur.io>
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

The gory details are in the second patch, but it is possible to panic the kernel by running the ioctl BTRFS_IOC_LOGICAL_INO (and V2 of that ioctl).

The TL;DR of the problem is that we do not properly handle logging a move from a push_node_left btree balancing operation in the tree mod log, so it is possible for backref walking using the tree mod log to construct an invalid extent_buffer and ultimately try to map invalid bios for block 0 which ultimately hits a null pointer error and panics.

The patch set introduces additional bookkeeping in tree mod log to WARN on this issue and also fixes the issue itself.

Boris Burkov (2):
  btrfs: warn on invalid slot in tree mod log rewind
  btrfs: insert tree mod log move in push_node_left

 fs/btrfs/ctree.c        | 19 +++++----
 fs/btrfs/tree-mod-log.c | 92 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 93 insertions(+), 18 deletions(-)

-- 
2.40.1

