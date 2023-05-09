Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3A6FCEBA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjEITsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEITsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 15:48:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEB530CF
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 12:48:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DD7763200997;
        Tue,  9 May 2023 15:48:26 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Tue, 09 May 2023 15:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1683661706; x=1683748106; bh=qe0tg1V9aBgZ1zgnWfwmBu4kTB5Dn1mv+2p
        8sRFKtqU=; b=XkviMO3d2jIronYglXyx1T6nKMDNaZGtM4OJ10ESdxu+RjIKjij
        +7jOFEk7IeN40EbaC5DW5ISFZ7XFb6EapOQBtLonW1OJ4WoRKzGfr0Ho+p+y9MJw
        ZovXa+Omw0rVewOwb7zGoahEvJ6s5Fg85yJxqHv+V+MfUqiuh5wZQn7lz4i50YPi
        lu37uKtQq1JEW9vfgezmIMLcFTOFSqsfRxYrKnLIGHatYobM7Pv+raC7YvFeBhpL
        SFnU5qsBAfTkJc0RlYxKqTIA8CAQ5XJW8TYZz1cY9mHpGkvrW//4nMTB1qmpFG4W
        iQBDXKshpXoFjCQK9eGMS4jNTwicktOwmmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683661706; x=1683748106; bh=qe0tg1V9aBgZ1
        zgnWfwmBu4kTB5Dn1mv+2p8sRFKtqU=; b=GF59KwuLNrQ1XzPGqkvLLCjv2iWx3
        T9AjGJnrj8ztFTecD/AmNGWMb9+cMFcGGhRgoft/N+sYOExucOcKUtu/8Kk1NooT
        iRUPMaj1AMgFgBR1N0FxPqyTjFbIEuYmL/XzxXtXelAVe5wlHERrjcVr2zeSfJO9
        3ml6l4C3vRIMNzaEj5mm6UMt8Vvs3OAJaqy+Ev4Gns64CW/RmUgdexW58Fh4T1mQ
        YDzEoUkO/VbFHN1eNyaL1xOoGEDL5mjfYS2/ubi86VDXIVCa779/J55MDNJjyfJh
        MTJWIppmJVr0Et5/AuAyx4lSzgK9rrtmSEtf3KfHzb3oC2MxtyGZA67Kw==
X-ME-Sender: <xms:iqNaZByfGRiDBfsYR2n-ProMxyleVsy_RDsE2s6ML4y6TLql0vwmug>
    <xme:iqNaZBQDooVrQYjRl_Nwq_J5ECV62RF1cdc9-p_a81Lqxf91X2VMMFsMrLJd1S63x
    nHd2Q2CtpF_PAS6_w0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:iqNaZLWfj5q00GL1oQQwi3v9cHpif43tlT5NXdFofUYdW-T63lQi8A>
    <xmx:iqNaZDgKY06mN3w8HwFR0bB0bUh35-w-xbZOhUbzSVN5U-HHgsRK3Q>
    <xmx:iqNaZDBuPZPBTzXqhohaWzFPSaN3kpcSfz95JzmyrKtyWTTXHWRRHQ>
    <xmx:iqNaZGoeK8mwS-XIq37d9yf9qTGlIhTeWYnSPk68vAuah-NTf5M24Q>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E49651700167; Tue,  9 May 2023 15:48:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com>
In-Reply-To: <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de>
 <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de>
 <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com>
 <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de>
 <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
Date:   Tue, 09 May 2023 15:48:05 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Christian Kujau" <lists@nerdbynature.de>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Cc:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs-transaction stalls
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, May 9, 2023, at 8:30 AM, Christian Kujau wrote:
> After upgrading from Fedora 37 to Fedora 38 the problem did NOT magically 
> go away (heh!) and I've run another full balance (and a scrub too), 
> although this did not help much in the past.
>
> I've since switched the mount option from "discard" to "discard=async" and 
> the problem has not recurred....yet :-)


There are some edge case performance issues with async discards that should be fixed in 6.2.13 or newer. I suggest upgrading your kernel andremoving the discard inhibition so it is used (the default). And report back if it fixes the problem or not.


-- 
Chris Murphy
