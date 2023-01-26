Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5207567D9F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 00:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjAZXuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 18:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjAZXuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 18:50:22 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E8366AF;
        Thu, 26 Jan 2023 15:50:21 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k12so2734075qvj.5;
        Thu, 26 Jan 2023 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7WbPvlwob819pC06iCi5pK75ouNH1PFzhWt1gArc/3Y=;
        b=ZbvpBTwrILLU5b3T2U3fE4Q6F6XR2fw1W1fTfPzzjD4TZtpFs8X7LN28Ar4vbDJcwG
         hN4bxpFvDb1qB5OWg9zXMhpdAC94nImjkUvCedqnGIESf7TZbeM587GK8szX9OSrC2ho
         TW887P3+ty5bHqWwH3ubig9PEPwwcf2y/8OTHl+EBIEE1qmpi4+Q1FU7h8dnBIIsSNCd
         JHG1o1mM5esWSlvME0DOTNeyPn8CfczolckCIUwrUUQhRdnTpacaqtizVKmOrDAxvvyF
         Q+r3gwSo0RHM3WzzuivweVI+AbtQz/q6UISF3ESl1/xNnFtQHXms4IWw3g1eQ0CxAt3e
         U/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WbPvlwob819pC06iCi5pK75ouNH1PFzhWt1gArc/3Y=;
        b=Thnr6VpVHZadLHxrtAY4Vyq1USIhIp4l81tOMSXsOqC7w8HQUfD28Egb6KQ7XUWiAr
         Ikzy/NjlckZ3HOQ+zckw3PCjNbH5i7AixKRW65fcT5RYvEqHE3a4Gx3TTeC2xWNHfVdA
         JVuKrXUqclVxcUywWByYH+ijjVBytAGuLarieII+OTwd0b0w3QvDfWG3olsqNrEH8JJX
         5IhW8m5wBjCsYrtUloo3LjI8B6vDsez5qJb6uUReQBSJt1XrEe+Fkhzfc+wNDGorXV1p
         qlfr8H5/tYVy8aaH6ltD1B73k3nc3QsYNxeE+++YYovKngPrIbcAdqeFlIQIx0YVY3ah
         xrig==
X-Gm-Message-State: AFqh2kod1oi6S73uqmlVoMnUWNQXBrK6UfrN7Srb6ViEhgNQjtl2mwQb
        J/HXQuFc9lhfIM0vlM8qVqo=
X-Google-Smtp-Source: AMrXdXvoQfMf+UcIl4DdFmML1BpRQtNCNeY0OEO0/y+7Fj6gWOk9o4oOhygJvGsnsfgqCqwWJULzdA==
X-Received: by 2002:a05:6214:378a:b0:535:564d:92b9 with SMTP id ni10-20020a056214378a00b00535564d92b9mr40386123qvb.1.1674777020120;
        Thu, 26 Jan 2023 15:50:20 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a15c700b007064e94ac07sm1829498qkm.45.2023.01.26.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:50:19 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E444027C0054;
        Thu, 26 Jan 2023 18:50:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 26 Jan 2023 18:50:18 -0500
X-ME-Sender: <xms:uhHTYwA_Z7ecGD6ilU-OTjFFK5nQuaCNnp3eHRe-XoAhBSsk9w6QXw>
    <xme:uhHTYyjvhTXqcXoVpVDPzPjVgyWe2O02xaLXjRtR9N8IL9WW-8pPWwa3q-5ZA6dAK
    qMQh-y6SSja0FM5UQ>
X-ME-Received: <xmr:uhHTYzkcJT_3T3hDDj-1J6e9tEvkyiyXL1peet4QT56_JSkQsu7SNixxUJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfeduteelgeejledvffetiefhleef
    hedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uhHTY2yml_H_sDXZOt4pEYpoTfTHrdMQC3DmBNFjcu9JH0qXqdE6qQ>
    <xmx:uhHTY1So6mxctLV7YIrhnAF_I-8x2VN1xxedLvWYBQvcSXCrUrHPew>
    <xmx:uhHTYxbAe7kgXbP7vveHSjg-C7CcSkTtoOAUk2XigDiuT7-QME4Jng>
    <xmx:uhHTYy8604y2LRIZTiNUgkjhSij0LCtAs48y4eJBZfNN8eI11VjwAQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 18:50:18 -0500 (EST)
Date:   Thu, 26 Jan 2023 15:49:33 -0800
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
Message-ID: <Y9MRjd0cZgSNVzi6@boqun-archlinux>
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

Lockdep is not needed for correct working btrfs in production. It's a
tool to help btrfs developers to find deadlocks in
development/test/debug environment. End users, i.e. the users of linux
kernel don't need it.

Regards,
Boqun

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
> It would be great if the chosen value would simply work always
> everywhere. 30? ok! But as I understand, btrfs does not have any
> guarantees for this. David, am I right?
> 
> Anyway, thank you for keeping the conversation going.
> 
> -- 
> Best Regards,
> Mike Gavrilov.
