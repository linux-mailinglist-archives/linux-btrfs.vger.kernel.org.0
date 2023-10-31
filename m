Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07EA7DD090
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbjJaPdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJaPdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 11:33:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAACE9F
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 08:33:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 010755C00CC
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 11:33:24 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Tue, 31 Oct 2023 11:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1698766403; x=1698852803; bh=0M
        lL+7a6x6YBqZWkYu9HdTZisomnYooGJ1HKEGII4R0=; b=cpn0WfqYgMp8cWL+bW
        B6XgPR8xWri/nRUaq/L/2ZltKFhYsFn9i80KMbfXgbiD76pcUQ58AUh/AIBhlgLo
        Js/lkpX3rF7fD8gyVX2iUWiF9NBcn4tUAAVfjPQNGZdfflLYN76UtPw0xNW/68og
        pIoYdYym88d8kCBq/wApNR6FpweetnBYjfJbVdRhrFyUhOWkDDIMKPYvMOZUdHT9
        xDuJ8tBZrgz4ejGN4XM9wy6bInoXhvPPgf+Nq4mFgcly39+5yJBN4hairELob3c0
        eAFEL3sbOOppAUngWBTpfJhZlH07NXuej/GgT++UpL+i+zurxGJaKGFwiRHOyJaA
        kVGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698766403; x=1698852803; bh=0MlL+7a6x6YBqZWkYu9HdTZisomnYooGJ1H
        KEGII4R0=; b=JvmgLtEwla9mBoPBFgqaqp2x1OlaEN3LzoPUuasNxdsFaKWISPo
        AaLSL1gJ930MaTVhzYXDcM7oC/eBnM6Drk7HKGtvFSmWU9MYqozSrqhNnz4CNbC0
        ZYAcEwI5Lcw84Q7HGfYeQlBe7u4Y6qNWcaEC5qAw67mEvDv9hZHoxfcD9xlmRdrV
        qrQ8F/r0m1jeBS8kN0+IaZ6KQyB6BVNP7OJEMUASZTluZ3WXPGAWAJhwQcxjxFhL
        dIYog6U6Z7gKWCG7UVssxH7AUcxRtfV61B3g4qA6uMnz/pvDoxKO63jpkvaDHupY
        7Ry01wEApWLzyp8fnoRDPghEkalHG9gGD0A==
X-ME-Sender: <xms:Qx5BZcalOdk4UHYqMf2nUog2BA__bro5eKUHlxdwa2--bN19fB7qjw>
    <xme:Qx5BZXaV-RZMR53-DFs9DxhFlYKkf3C8R8eBH8huwHDt36oaNQpkQkw3CU_YTODmY
    vOo1huZ_cRiupqyaR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceotghhrhhishestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepheehgeeltdehhfdtgefhgeekvedvjeejkeehveektdevjeet
    vdeufeekkefhueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheptghhrhhishestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:Qx5BZW__tBgQlF-7qYuEDl7gV4UQ-Z41Vk7hoWmA1WLoiqPeLOHzkQ>
    <xmx:Qx5BZWroxSP_U6vgdUmoizTXcw7njF0Vqk2YLtQDrBHgVPg8FKt75w>
    <xmx:Qx5BZXr1DnTA89IhlaV-CqJdY6b8wW8U6IjPu_LSRLg6umjV9eZzQw>
    <xmx:Qx5BZU3DUkq72bWKgUlD_hIZlgVnu07Oy-AMxtyXV8aejJ0rFyiGfg>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9A411700089; Tue, 31 Oct 2023 11:33:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <ac9a50ca-be0f-4fbb-8e52-09b9ae087a9b@app.fastmail.com>
Date:   Tue, 31 Oct 2023 11:33:03 -0400
From:   "Chris Murphy" <chris@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: btrfs restore documentation problems
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs-6.5.1-1.fc39.x86_64

       -r|--root <rootid>
              only restore files that are under a specified subvolume whose objectid is rootid


       -l|--list-roots
              list subvolume tree roots, can be used as argument for -r


However, -l option does not show any subvolume IDs at all, it only shows bytenr. So in fact it cannot be used as an argument for -r

$ sudo btrfs restore -l /dev/nvme0n1p4
 tree key (EXTENT_TREE ROOT_ITEM 0) 13586432 level 1
 tree key (DEV_TREE ROOT_ITEM 0) 12439552 level 0
 tree key (FS_TREE ROOT_ITEM 0) 12656640 level 1
 tree key (CSUM_TREE ROOT_ITEM 0) 13414400 level 2
 tree key (UUID_TREE ROOT_ITEM 0) 5287936 level 0
 tree key (FREE_SPACE_TREE ROOT_ITEM 0) 12664832 level 0
 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 5283840 level 0

I'm not finding a way to simply list everything on the file system using btrfs restore.

$ sudo btrfs restore -D /dev/nvme0n1p4 .
This is a dry-run, no files are going to be restored
$ sudo btrfs restore -Dv /dev/nvme0n1p4 .
This is a dry-run, no files are going to be restored
$ sudo btrfs restore -Dd /dev/nvme0n1p4 .
Using objectid 256 for first dir
This is a dry-run, no files are going to be restored
$ sudo btrfs restore -Ddv /dev/nvme0n1p4 .
Using objectid 256 for first dir
This is a dry-run, no files are going to be restored


If I use -d alone, I get a restore. But there seems to be no way to just list filenames without restoring. What am I missing?


--
Chris Murphy
