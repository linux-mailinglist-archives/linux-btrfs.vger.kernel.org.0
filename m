Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4367D8D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjAZWwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 17:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjAZWwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 17:52:38 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F35867C;
        Thu, 26 Jan 2023 14:52:30 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o5so2647724qtr.11;
        Thu, 26 Jan 2023 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5BZjt9Q5+6X8KNTYdrTxRuSx/ZccXhnMaFcoYPpg2Rw=;
        b=VTTSPLVYHW8w23TDOIqFKauFX6z1pNznKNFw6hDmeGg4GyU3JikWZEdiKsSsbbVSlj
         AS2+HVXqcudnq3Tle37acqnOXDZOvtq7kQJjwhz/IHd4aVPQ80Uq7asfcqidz0JBzlRE
         fHkJKUQmccKdLPzqxUjoBzKMTb/dZW4H8JVAV3JDmjriUBBRoY9eXknZpsa9NZDjRCKv
         k7R+mgtGwPpgE7GtUpb/Lt4nHnjIxYuGJG1CpCQo+ZHPAcJ/cX7QGichZTx0Mx7mlOqi
         2LsD45V/XMuuyI91EgqMzm7gWQBfNh5kCC5kmOo86g4ZaV0SjfSNyVDdrV7EAnM1Gpxj
         W3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BZjt9Q5+6X8KNTYdrTxRuSx/ZccXhnMaFcoYPpg2Rw=;
        b=jjdRZXo3krTGsyOfOeb3UqwoSq0IKU8CDk2ze5tzeHIh9jpSkcY9jMipv8Z6cjk0ZL
         2kxPLldRNqCrp7w5dhmFVEP6/e9bxSdaZ/WNcwt6KZE9Lal+WDD4X4U6kHfBhK8UjhM2
         RDTxr1bz//SdzPEpFmSf2Q/zPPXsG2U1Wn3SDBLvc3AgI94g6sC7oCbJh5ESzwL0fbct
         miJOyKApWf/0aQSpQdxMJBE3D2GoWfHOCqS6jzYUYsNxcFKEhZmavEojvoWj6zwBeAui
         DFd2j7l9GQmrxZ2bLdrjGmP2AwU5Dmbas1fnh/BYz5l/70WBsDcR0I9+B+w9CBzZ3e6S
         vcGw==
X-Gm-Message-State: AFqh2koUTyXR9RtjJZZUXSrSoK/Vpcqssn0tupyqc5olZrF76ohxKxlR
        BFag7npyxZL5VzeCTH5ULf8=
X-Google-Smtp-Source: AMrXdXvvg0RsEgDfk2T+eZyAn10yRqkmTXjt2B/K4TVczmMKNC+OrTL/0PrDO0M+/IXigfvGYP8IDg==
X-Received: by 2002:ac8:6f09:0:b0:3a8:1789:73b1 with SMTP id bs9-20020ac86f09000000b003a8178973b1mr61371500qtb.2.1674773549252;
        Thu, 26 Jan 2023 14:52:29 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j7-20020a37b907000000b00706c1fc62desm1720623qkf.112.2023.01.26.14.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:52:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9295027C0054;
        Thu, 26 Jan 2023 17:52:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 26 Jan 2023 17:52:27 -0500
X-ME-Sender: <xms:KgTTYyq1VSD0FYjUUW7snQNLy4EU1GF2piejVlTSdoFd0VmPy0Sykw>
    <xme:KgTTYwr773siaGQMgU5DtGFckFA_EhV1okltRPHnNisPZ7S_zL9iNBZ6Eolytrh3D
    b_1nx5SJc_2n5hJ3A>
X-ME-Received: <xmr:KgTTY3M3UXHEiLs-P5sASvIekhljRlVIIUta8dI-ZONrB97WoaTsc-CsUjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfeduteelgeejledvffetiefhleef
    hedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:KgTTYx5aTVQaZOkYwZmi7UW6u6wPIPBMCbUs7BaHKsrA1M8nWu6aBw>
    <xmx:KgTTYx4X0rfqfP1eZleeg3wA-yuFmPa98pxF1dBEZ3XqB6q9550ejw>
    <xmx:KgTTYxhox9kRAgCSyGVIJ34eHjJoFFg_xVr8wvh6LTHkQ_9ETcvBug>
    <xmx:KwTTY2E-BTUJPUOhScYI9iDawtWyQHAgh7A0cPeeSXcD1pVSqDnPpg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 17:52:26 -0500 (EST)
Date:   Thu, 26 Jan 2023 14:51:42 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <Y9MD/q9Z9GbKpJRX@boqun-archlinux>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 03:42:52AM +0500, Mikhail Gavrilov wrote:
> On Thu, Jan 26, 2023 at 10:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > [Cc lock folks]
> >
> > On Thu, Jan 26, 2023 at 02:47:42PM +0500, Mikhail Gavrilov wrote:
> > > On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
> > > >
> > > > On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
> > > > > On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
> > > > > >
> > > > > > On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > > > > > > Hi guys.
> > > > > > > Always with intensive writing on a btrfs volume, the message "BUG:
> > > > > > > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> > > > > >
> > > > > > Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> > > > > > tends to work.
> > > > >
> > > > > Hi,
> > > > > Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
> > > > > low!" again even with LOCKDEP_CHAINS_BITS=18 and kernel 6.2-rc5.
> > > > >
> > > > > ❯ cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
> > > > > CONFIG_LOCKDEP_CHAINS_BITS=18
> > > > >
> > > > > [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > > > [88685.088124] turning off the locking correctness validator.
> > > > > [88685.088133] Please attach the output of /proc/lock_stat to the bug report
> > > > > [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
> > > > >   -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
> > > > > [88685.088154] Hardware name: System manufacturer System Product
> > > > > Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
> > > > >
> > > > > What's next? Increase this value to 19?
> > > >
> > > > Yes, though increasing the value is a workaround so you may see the
> > > > warning again.
> > >
> > > Is there any sense in this WARNING if we would ignore it and every
> > > time increase the threshold value?
> >
> > Lockdep uses static allocated array to track lock holdings chains to
> > avoid dynmaic memory allocation in its own code. So if you see the
> > warning it means your test has more combination of lock holdings than
> > the array can record. In other words, you reach the resource limitation,
> > and in that sense it makes sense to just ignore it and increase the
> > value: you want to give lockdep enough resource to work, right?
> 
> It is needed for correct working btrfs. David, am I right?
> 
> >
> > > May Be set 99 right away? Or remove such a check condition?
> >
> > That requires having 2^99 * 5 * sizeof(u16) memory for lock holding
> > chains array..
> >
> > However, a few other options we can try in lockdep are:
> >
> > *       warn but not turn off the lockdep: the lock holding chain is
> >         only a cache for what lock holding combination lockdep has ever
> >         see, we also record the dependency in the graph. Without the
> >         lock holding chain, lockdep can still work but just slower.
> >
> > *       allow dynmaic memory allocation in lockdep: I think this might
> >         be OK since we have lockdep_recursion to avoid lockdep code ->
> >         mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
> >         missing something. And even we allow it, the use of memory
> >         doesn't change, you will still need that amout of memory to
> >         track lock holding chains.
> >
> > I'm not sure whether these options are better than just increasing the
> > number, maybe to unblock your ASAP, you can try make it 30 and make sure
> > you have large enough memory to test.
> 
> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
> be done? In vanilla kernel on kernel.org? In a specific distribution?
> or the user must rebuild the kernel himself? Maybe increase
> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
> to distribute to end users because the meaning of using packaged
> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
> config and rebuild the kernel by yourself).
> 

Lockdep is a dev tool to help finding out deadlocks, and it introduces
cost when enabled, although it's possible, I doubt no one will run
LOCKDEP enabled kernel in production environment. In other words, it's
a debug/test-kernel-only option.

Regards,
Boqun

> It would be great if the chosen value would simply work always
> everywhere. 30? ok! But as I understand, btrfs does not have any
> guarantees for this. David, am I right?
> 
> Anyway, thank you for keeping the conversation going.
> 
> -- 
> Best Regards,
> Mike Gavrilov.
