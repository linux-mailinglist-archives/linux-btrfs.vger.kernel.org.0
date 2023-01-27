Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D867E989
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjA0PeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 10:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjA0Pd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 10:33:59 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CF8001D;
        Fri, 27 Jan 2023 07:33:57 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8247D5C0152;
        Fri, 27 Jan 2023 10:33:54 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Fri, 27 Jan 2023 10:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674833634; x=
        1674920034; bh=mMkolRQqhFuhBHkGFRthWYVcxUjVGgmdiIZP3rWXfo8=; b=b
        VEGclL3nsewBRTBMu/WqMlqsX8fl+FJdzJ5b2A5Snb10ykrRUHAE4XUpSM0UuAt8
        a9V21AZ6a4wJTIEq2YDN7XPjIki3A+VA/PFPSR0qDKqdrN2GLSnzIvKwBBcmAnXG
        B3Yca93Tg+1/dulbg6P9/je/f7EQGf7A5A2a16KVineHhir3bwVZ7lTBEyQATKrv
        ZPnSUp57f8llV2g1kB8xGylm/iCe3mp5pOClS+TKm2sHvqiJzJM9yE0iC79JQflb
        ZjeLtrVSaiBaHWMN+RcrZYRYGAlPXMC0xyo99xfh1Et2AXtYKN86Dc1sIEKtbJTA
        WrikxhsUUwOmygpBxYPzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674833634; x=1674920034; bh=mMkolRQqhFuhBHkGFRthWYVcxUjV
        GgmdiIZP3rWXfo8=; b=qxccOcN+/vO9IvT4kOjvaKLq4uVrD3qFuLEqbhVIrl6m
        eAvNrMdq1rwe+JZk/f9t+SIpkiwjEOEQYWkfgWq72vapMqzrYWmRg7ba1OA1TXkV
        1oFWwFkuK4zdvS9q1yIkn52yAPYr7gt7U8KCy6CdSbFnO/X1vzsGkbmVKREh06ka
        Gy44b5KmTQVlhtntz5InPbXlhkG1fnRz5wuoObOKF16eZVQtEIr7xLgj1Z6B2AOj
        o8CY99hPvo3hZqlPDAUrWQGML7w/WmqJc/z8aygpKjv7TTvHDHPo9hlineiGgMyD
        XtRf5Zvld7+5p6Rm3+ZSCKL3zvEd7klTJnQmd97CnA==
X-ME-Sender: <xms:4u7TY_E_R4dab93dc7-YityhMsA9W6lhZp8UE7En10UXPRaO9iQ9Ng>
    <xme:4u7TY8Xb6tQeMB6lhno7Kdqm10v9yFYlSwfbmZZRwosWUC9IPB1R4csMsNPFggjRO
    -hRe4yiSxX-QvkTwCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeehueelhfehhfeivdfgheeuffetgffhveetffetgefh
    udejgeffgefgkefhfedtudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlh
    grsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:4u7TYxLpbhAov5g3E0TjYC780cI67GUcavIAbL0jPcf0usGIunCOPg>
    <xmx:4u7TY9HUGmLM-FQQRhE2-BMiCNeizB4d_Jz4oN-8lVcM_0CByX7meA>
    <xmx:4u7TY1UnkIv7o2AGolqrgYxfO-3dNnbaz0VCZF42u7d9uq7CXD5THA>
    <xmx:4u7TY0HhBk2RIz-ffLnwvHAa7rNYraMJIaSJl9UETzDEHQkhM93MtQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22BD41700090; Fri, 27 Jan 2023 10:33:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <2ffd1b69-76c2-4e15-a139-1406746ae4ef@app.fastmail.com>
In-Reply-To: <b112394d-7efa-c6f9-bbef-a73c501ff02c@redhat.com>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
 <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
 <Y9NN9CFWc40oxmzP@boqun-archlinux>
 <b112394d-7efa-c6f9-bbef-a73c501ff02c@redhat.com>
Date:   Fri, 27 Jan 2023 10:33:27 -0500
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Waiman Long" <longman@redhat.com>,
        "Boqun Feng" <boqun.feng@gmail.com>
Cc:     =?UTF-8?Q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=93=D0=B0=D0=B2=D1=80?=
         =?UTF-8?Q?=D0=B8=D0=BB=D0=BE=D0=B2?= 
        <mikhail.v.gavrilov@gmail.com>, "David Sterba" <dsterba@suse.cz>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>,
        "Joel Fernandes" <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Fri, Jan 27, 2023, at 9:26 AM, Waiman Long wrote:
> On 1/26/23 23:07, Boqun Feng wrote:
>> On Thu, Jan 26, 2023 at 10:37:56PM -0500, Chris Murphy wrote:
>>>
>>> On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
>>>> On 1/26/23 17:42, Mikhail Gavrilov wrote:
>>>>>> I'm not sure whether these options are better than just increasing the
>>>>>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
>>>>>> you have large enough memory to test.
>>>>> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
>>>>> be done? In vanilla kernel on kernel.org? In a specific distribution?
>>>>> or the user must rebuild the kernel himself? Maybe increase
>>>>> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
>>>>> to distribute to end users because the meaning of using packaged
>>>>> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
>>>>> config and rebuild the kernel by yourself).
>>>> Note that lockdep is typically only enabled in a debug kernel shipped by
>>>> a distro because of the high performance overhead. The non-debug kernel
>>>> doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough
>>>> when testing on the debug kernel, you can file a ticket to the distro
>>>> asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build
>>>> your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.
>>> Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
>>> https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
>>>
>>> If 19 the recommended value I don't mind sending an MR for it. But if
>>> the idea is we're going to be back here talking about bumping it to 20
>>> in six months, I'd like to avoid that.
>>>
>> How about a boot parameter then?
>
> A boot parameter doesn't work for a statically allocated array which is 
> determined at compile time. Dynamic memory allocation isn't enabled yet 
> at early boot when lockdep will be used.

Also, at least in Fedora Rawhide where the mainline debug kernels appear, mostly get used non-interactively with automated tests. So if we're going to discover lockdep issues, we need the kernel logs to be reliable at the time those tests are run, and we don't have a practical way of adding another boot parameter just for these tests.

Anyway I went ahead and submitted an MR to bump this to 19.
https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2271



-- 
Chris Murphy
