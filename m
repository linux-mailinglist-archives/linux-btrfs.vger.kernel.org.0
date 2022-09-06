Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CEF5ADD30
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 04:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIFCPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIFCPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 22:15:22 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443B440E10
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 19:15:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 26FC23200903;
        Mon,  5 Sep 2022 22:15:17 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Mon, 05 Sep 2022 22:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662430516; x=
        1662516916; bh=PXEwQfhwN+7sbMxwKe3o+TCY6atdZ0CIasmi+z3IGVI=; b=B
        qwLlQVd8VHCyOD6d3/O/y9qwMaRzH3vXok3hqpwfXK5vl92W9U2TqqWud8ZjSlUq
        XSzqXeFRRel7WwHV2Gelg4lbJ19qOyGHOvO/Z8zfhz+TFlCZ6ijhrZ7q5lXEZAZL
        c85xvzzG00dPCQ+UK75ZjZrjxdjlrIww+WMfgxpN5jxcz0CHA/IA1yCT3LS3dRjg
        LXCJhmV1XuGeU1+6pC9ntqOa+w/FInKVu8DjMzHf0aUotvWHqlfx7J6W51kKeK2p
        em6RysnaWlHFLgJ8qkIt1lKgKVhnBlHYxghQDSu1el4j6fpLG9HVIrY4IqoAMcwT
        gGLFoKAfDZ6VEZfgMIcNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662430516; x=1662516916; bh=PXEwQfhwN+7sbMxwKe3o+TCY6atd
        Z0CIasmi+z3IGVI=; b=QOdkfAlJBfRXRi84bow4Y3LMQ1pS4HjSiVXy07l6J16e
        LXr+8H5m5fIzbrmiedY1mzgqjgOIxl4Qj+HjEdv3IaVjBq1mx6yXctTWeP6Q3xRF
        udiZrdNSvz1PxdREHiOrceoDnUlNkDMOpcFB8Ieun2DvVXakFTiSeewurs3CtwEa
        YsOJ6jRtr9k4NSiNaBkFJC0/WyYxoiUncDL/xHVYK1+FNIg+ghNjuiaXLmGh0fsK
        7zpbHsl5baOW7LBoaOrXrb7q2IHa8Wa6tQIea/MJ4oELJ1Jud0ocK+JzJhMwU0fv
        edJBXk07OPtTerZRQR+ZcZXmHtEfVOjbQnGCgvlucQ==
X-ME-Sender: <xms:NK0WYx1gtLnwHMb7tIdr8HS_rmN5s-78DuNuNfXLUeQZgY5PwULvLg>
    <xme:NK0WY4EW2SjvSB0lTzEFlpGqd7n-Y-wQxfBEEQsrIRKvHnxtNGArupLfNe4-BDUwF
    U2QkLrgIIcu5u-IpAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeljedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepudehieevueetgffhkeetkeelveffueeltdejvdejveev
    vdeggfefhfegvddugeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:NK0WYx7T8gI3oRmfJiLFoHYPxI2ikV_ZFcS4261ubif7E14bCB-ilA>
    <xmx:NK0WY-1DnFMcQ32HRWneDQAQRMy9WEYCLpz8PNmbY3zOv0xSKHb2mg>
    <xmx:NK0WY0GeT18ySzi0_g2X0_GbBujUlgnxgnq7JOOgSz65D0brRLbm3w>
    <xmx:NK0WY3w4X-gjwX5dgvlQ7xEOjTzejr-GktN5y-mvrWKtfaF83011eg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 679511700082; Mon,  5 Sep 2022 22:15:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <d759fd64-fe5c-491e-9c24-c27067cbb195@www.fastmail.com>
In-Reply-To: <trinity-2ed29f2d-59e7-439a-893d-3fc3b41be07f-1662419772647@3c-app-gmx-bap56>
References: <trinity-2ed29f2d-59e7-439a-893d-3fc3b41be07f-1662419772647@3c-app-gmx-bap56>
Date:   Mon, 05 Sep 2022 22:14:56 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Steve Keller" <keller.steve@gmx.de>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID1/RAID0, online replace
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Mon, Sep 5, 2022, at 7:16 PM, Steve Keller wrote:
> A few questions on RAID1 on BTRFS:
>
> 1. With RAID1, can I replace a failed disk online, i.e. without
>    unmounting the filesystem?  If yes, what happens with files that
>    have data blocks which have only one copy?  Are they deleted?  Will
>    the FS still be in a clean state?
>
> 2. Can I have some files with data blocks in RAID1 and other files in
>    RAID0 or single mode?  Can I set this per directory?  E.g. I have
>    directories with large multimedia files which change seldom or
>    never, which I have in the backup, and for which I don't need high
>    availability by RAID1.  Other directories, e.g. source code, change
>    often which I'd like to have RAID1 for.
>
>    If that's not possible, can RAID1 for data vs. RAID0 be configured
>    per sub-volume?

Ostensibly it's all one profile per block group type. But if the conversion was interrupted or cancelled, yeah you'd have mixed profile block groups, thus some files could be one or the other. But this is not really controllable.

`btrfs replace` is an online command.


-- 
Chris Murphy
