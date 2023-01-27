Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EBA67DCB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 04:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjA0DiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 22:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA0DiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 22:38:22 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758429167;
        Thu, 26 Jan 2023 19:38:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9EDA53200B81;
        Thu, 26 Jan 2023 22:38:17 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Thu, 26 Jan 2023 22:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674790697; x=
        1674877097; bh=C7xf/GcToydZj0kMltSVm/LD8pL4U8U3xYvE85UGPTQ=; b=P
        oDrAwN8911tCEwdICDDovN/hYa1u9mDLgjhUMPL8aXT6fUl+LzrPHk0Q04E8CVyq
        1h2CV3/tHmO89e9Aa/neVgIvxHCjhQxB4G3VlXbEeFuH7+MzCkx+Pu9g6PNtfJr8
        bldU2I0NYgzh+wSN88d2jb8tln7de7/lYTqtu5U1H/ZkNl2/Wy2L9SbMgHiWLZJj
        Mc8ktQ6fc+580CFIMgvwCPTMKgm5S86qIVP59BaSe4v5FxVCpjAR/Uy0TxEhVUJP
        YZ5AT8nqbzuLtPJjL4c1SA3S7/RjmWHPGw2Rmdqn9pSmbUHVlRXuMwdE+pffoBdN
        51p1tVkEbwbkz2jWPwZsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674790697; x=1674877097; bh=C7xf/GcToydZj0kMltSVm/LD8pL4
        U8U3xYvE85UGPTQ=; b=pBcny3NAHhV/iYEJzX5O+a04pzhLdL8uY1Ebdpp9PbIc
        WyUcFGKwScVlTx7CZ8JagMvSVGabZuemP9Y+mAe0PQ4Kul+LI+C1wxYbNTj2X6XA
        hzPVpAaklPrt57r3b63XifWPVONRm5M0XEEQAeIel/gwQrBCWI+BZsEVrXztq9ra
        FuJ/YGhpL2CZ2c9FbX7Xe4bHtTjbc3JitpQ7OZdP8oJMA7P5oGROtFlAA6vYPzdM
        zTZTulG3dDUSm+i4nmiAQOsXHUnXMo5PaZ8mOMpUcgAkA/I4vHxF0aN5Wo/ICMl+
        akXevVVEFRfBif2vQ1W7me/4WselSoFdnlup3fTaag==
X-ME-Sender: <xms:KEfTY9coqSRfOfidRmBR8t7ZtKdMaiLPP0HL5QgHrBuSzWnWb_XZvQ>
    <xme:KEfTY7Op4fb4lEv0u0kKLZbIswTt-nHq8c9buYuWZs9wURSJ4dY946de7k3BG7WXF
    xOG7SgHBaiKTEEggVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeehueelhfehhfeivdfgheeuffetgffhveetffetgefh
    udejgeffgefgkefhfedtudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlh
    grsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:KEfTY2hr8H5dqZ6860LzzqlwemGYOO7DeMb1haWLsF2uH1pyoFoZJA>
    <xmx:KEfTY2-XoIVOdtDtHsfA0KPuF2gBmaF1lXYZoH9jOZa9hCFEZOsL9A>
    <xmx:KEfTY5v4BUbF7hnIcYaHE6JM-bi8XKBrDIWmoQO2XlocGiNot3ZNFg>
    <xmx:KUfTY68GJWodMsLkBlfwPKr97UO9Fhh28Vh9Z9KGv0zW6T_qlA8UlQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7BD71700089; Thu, 26 Jan 2023 22:38:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
In-Reply-To: <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
Date:   Thu, 26 Jan 2023 22:37:56 -0500
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Waiman Long" <longman@redhat.com>,
        =?UTF-8?Q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=93=D0=B0=D0=B2=D1=80?=
         =?UTF-8?Q?=D0=B8=D0=BB=D0=BE=D0=B2?= 
        <mikhail.v.gavrilov@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>
Cc:     "David Sterba" <dsterba@suse.cz>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>,
        "Joel Fernandes" <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
> On 1/26/23 17:42, Mikhail Gavrilov wrote:
>>> I'm not sure whether these options are better than just increasing the
>>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
>>> you have large enough memory to test.
>> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
>> be done? In vanilla kernel on kernel.org? In a specific distribution?
>> or the user must rebuild the kernel himself? Maybe increase
>> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
>> to distribute to end users because the meaning of using packaged
>> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
>> config and rebuild the kernel by yourself).
>
> Note that lockdep is typically only enabled in a debug kernel shipped by 
> a distro because of the high performance overhead. The non-debug kernel 
> doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough 
> when testing on the debug kernel, you can file a ticket to the distro 
> asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build 
> your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.

Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921

If 19 the recommended value I don't mind sending an MR for it. But if the idea is we're going to be back here talking about bumping it to 20 in six months, I'd like to avoid that.



-- 
Chris Murphy
