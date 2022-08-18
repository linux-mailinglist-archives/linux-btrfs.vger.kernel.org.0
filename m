Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC0597D59
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 06:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiHREVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 00:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243297AbiHREU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 00:20:56 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957B4A800;
        Wed, 17 Aug 2022 21:19:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6369D581196;
        Thu, 18 Aug 2022 00:19:14 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 00:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660796354; x=
        1660799954; bh=4YQTSfdZ352kAuAPv5CKShp5kenO9X49X3f9t0ZeXxk=; b=b
        ocDj0vLvQqz2vqNZ60dUWMdGbOuI9sRv8IEcKy/U2vYgds1oBLK4MzGF4Qq11LzB
        9ybNOkpGfEwIvUEejEl05hBedTgeghwkeMC3SgYNjY60sw6AdbOySSgbj04ytGN8
        nvRXb+Tyh1cuhpVRXezmiy9D9JtAbrtDR5tYEeT5RABU/YJgjaPWH7FOslyvMw7x
        vaNJPaxw0GhFeYmVGKUBV80RVmRESMq4PysL36tajxGJBTcoyyXccf1cKlb0t9v8
        6XED6nt/ZzKgHIIaSK2yuod4gyiSyaENzbipVt2DV3QeOQ+mrSV0kCL5QfGz4T6P
        QiZU1z/HQpuyEl4V0E6Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660796354; x=1660799954; bh=4YQTSfdZ352kAuAPv5CKShp5kenO
        9X49X3f9t0ZeXxk=; b=PR9SKN1sttok8qkfJSNCUuMvn9VvvaYFljJjKepnyuQ1
        t515RLdkgS0tPw3WKYVjdKxvs8jc4632zL0sDtQj+vCnJ3XhBsIP23puDKOzPf49
        cu9qmsgZuN1ffNjQNm7jkHUQFn8MGINTnJ4cH80Nu6f/PHXr1jE6wzAXen2wxx6n
        4+Qpb4oXPrhXn44nJxQn7BP8KipG0hjioT0Mmvuy/cIvY82XkpXD9Jlib4CZU4I2
        eaxeL1uFaJnjNm/f6p48O6N1TwTBtbGgxjw2CD+6LsMVWQbftxL7Lm8qPnSy9RIP
        /IxQtSW0ber6ReTcHptO6IMZF7gfAEAPkuhrCtDwnw==
X-ME-Sender: <xms:wb39YmgFW7oj307eYJGenkvy_zM4ypiiCempItWLnS9qev4rtpHD9A>
    <xme:wb39YnDZcpPzdvvMzcF_mFXCAIofBptUGok5Nzsp1v7uSiLPFjr9Yxlozd4JnTs5h
    ZeOkXS2idsPfESmZpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:wr39YuGM4YE6JkNNGS4-RsTYWiyPeT4r2dNcshmQVTFJ-uiysXegvw>
    <xmx:wr39YvSN6jNSinWrbnBiZ2gwfXl4x0mNz-2OUA9KHLUc7StfVAB7pQ>
    <xmx:wr39Yjxtm4cFLUpkexUuKS7v9um5Px_bObYV70g6lmtx8a76IPX__w>
    <xmx:wr39YqyfBc8VFuvaoZQbuxg1C1bdcKjvtRRfuCBvRfxjEnb9rQEuOA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E73591700083; Thu, 18 Aug 2022 00:19:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
In-Reply-To: <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
References: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
Date:   Thu, 18 Aug 2022 00:18:29 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Ming Lei" <ming.lei@redhat.com>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
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



On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>
>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
>
> https://drive.google.com/file/d/1n8f66pVLCwQTJ0PMd71EiUZoeTWQk3dB/view?usp=sharing
>
> This time it happened pretty quickly. This log is soon after triple 
> digit load and no IO, but not as fully developed as before. The system 
> has become entirely unresponsive to new commands, so I have to issue 
> sysrq+b - if I let it go too long even that won't work.

OK by the time I clicked send, the system had recovered. That also sometimes happens but then later IO stalls again and won't recover.  So I haven't issued sysrq+b on this run yet. Here is a second blk-mq debugfs log...

https://drive.google.com/file/d/1irHcns0qe7e7DJaDfanX8vSiqE1Nj5xl/view?usp=sharing


-- 
Chris Murphy
