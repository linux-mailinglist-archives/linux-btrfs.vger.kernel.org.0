Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB8467DCC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 05:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjA0EIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 23:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0EIJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 23:08:09 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072371421C;
        Thu, 26 Jan 2023 20:08:04 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z9so3159536qtv.5;
        Thu, 26 Jan 2023 20:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J72BV0+KgDqX6s1tgTk17iV9RaqoC3RKEX14cAy2+HQ=;
        b=XzJni/5QOino+Ic0/HYew7tzh1524ldKFcwOvS0ZCvWg+zaCN+zpQdUJQY7sxXidbY
         E7PlJf5HTkP8J1kbn+dj/mgKevJ0YaAjQR3WaEc8u8qfMShcHRubmeaGYmovJFWWJ667
         fWDXHsvSGHuH3r+h92Cq0usgfqxPMzai794B2Db9X+BBA00GOt6fY3RRX6PKLcciZIs7
         4yVuYs0Z0jBe+X0HMDoBssHh/j+oaJkYcbK0v49IZkgFvlqzucb8cHIqRRle3MctNwVr
         OJzzP28ht/ze4+QHAWRv9b5LGcrbuQkVQhk7hZ2GX0Sd+1B/MvJGpWKGXSmd/zRtKb0I
         ungg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J72BV0+KgDqX6s1tgTk17iV9RaqoC3RKEX14cAy2+HQ=;
        b=cN/wExrhRUc3w57GpWw3MLBpNYtXuVHixAV+Z1wkcW2KsECog38pECVT33x1uu6Soc
         CyWlsVSjBB2gEKIJOhg99nP/GeO9pq+f6esJN0L+z6nzXbMaF8TiHX9Y/AW1RNBVgxU0
         E9F3FX+apCWfbxSEQGJAxFyf0pIV9/EqAhXSheVekG2LnsXxjuiYvn8mxreobESPTRD9
         MjXiYzU1GDp3uLeHmiredcjCVdoHMFPnX8NwKvspIhBVYVu4YqNWgREyGaMuUnktevj5
         eSDK64swYzj8s4fUlRQ8tNjYCwPH+EGnsK46Nc5lQKN2zSuIzH4/QPy+3RpxCR6KiQ/I
         pMJA==
X-Gm-Message-State: AFqh2kpEHHQxIFg2e+Upu8/POouDM5MpnJh5UP81OpdKg/j5s4OQLo6w
        w99U6FM1HlL09pPuQEQJlgU1FDknA6M=
X-Google-Smtp-Source: AMrXdXs0mtrjmyIHtaK261Og5HIvwQxOAWr4SxsZ9tk2qVbbnx+p3HHFZLjKoZKwUQIqQtIeTd5SlQ==
X-Received: by 2002:ac8:5a95:0:b0:3b6:3b1e:e8e4 with SMTP id c21-20020ac85a95000000b003b63b1ee8e4mr70736754qtc.27.1674792483156;
        Thu, 26 Jan 2023 20:08:03 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id br40-20020a05620a462800b006fcc3858044sm2169632qkb.86.2023.01.26.20.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:08:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 06BF227C0054;
        Thu, 26 Jan 2023 23:08:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 26 Jan 2023 23:08:02 -0500
X-ME-Sender: <xms:IU7TY39vdtO_b7MDhZqPZN1HBTVJc_7TTklawagqkRl0vrj0l3BAfA>
    <xme:IU7TYzuvo6TNzlvUjhy-lKdtyY_xZ4Xn_jVwM9nn5o0ay6zKqQ59IrTMIBkavLoJh
    X_vKq9MqLpsmhRDiw>
X-ME-Received: <xmr:IU7TY1D25NQ6HcjqZJJy9pfJBJOR2xwVXoJCLoo3O_HJ6oobZH97-N4aKS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevlefghfevleegudevfeefgefgvdehleektedtudehvdeftefgvdevudff
    iedvvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:IU7TYzcsbBFnXP923Lze42wAgV8FZMv2U7V-VxkW8y9iq35GNjwAIw>
    <xmx:IU7TY8MBwEss30cWh27iHnYD-K2Ll7SynAXunDZcBGsxj_RDCsfuFg>
    <xmx:IU7TY1mOAP1A3q5s7me4hEzzyXQ_z06fndlHOObe_IUblXQDabHK0g>
    <xmx:IU7TY7rI0Ap1Jd5KoB3uOUWvl43SyDdfonmv3spl8rdbGK9JtO5Sbg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 23:08:00 -0500 (EST)
Date:   Thu, 26 Jan 2023 20:07:16 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Waiman Long <longman@redhat.com>,
        =?utf-8?B?0JzQuNGF0LDQuNC7INCT0LDQstGA0LjQu9C+0LI=?= 
        <mikhail.v.gavrilov@gmail.com>, David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <Y9NN9CFWc40oxmzP@boqun-archlinux>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
 <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 26, 2023 at 10:37:56PM -0500, Chris Murphy wrote:
> 
> 
> On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
> > On 1/26/23 17:42, Mikhail Gavrilov wrote:
> >>> I'm not sure whether these options are better than just increasing the
> >>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
> >>> you have large enough memory to test.
> >> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
> >> be done? In vanilla kernel on kernel.org? In a specific distribution?
> >> or the user must rebuild the kernel himself? Maybe increase
> >> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
> >> to distribute to end users because the meaning of using packaged
> >> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
> >> config and rebuild the kernel by yourself).
> >
> > Note that lockdep is typically only enabled in a debug kernel shipped by 
> > a distro because of the high performance overhead. The non-debug kernel 
> > doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough 
> > when testing on the debug kernel, you can file a ticket to the distro 
> > asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build 
> > your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.
> 
> Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
> https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
> 
> If 19 the recommended value I don't mind sending an MR for it. But if
> the idea is we're going to be back here talking about bumping it to 20
> in six months, I'd like to avoid that.
> 

How about a boot parameter then?

Regards,
Boqun

> 
> 
> -- 
> Chris Murphy
