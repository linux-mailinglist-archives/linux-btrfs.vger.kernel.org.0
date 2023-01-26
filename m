Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6675167D35F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 18:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjAZRj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 12:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjAZRjZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 12:39:25 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D956D5C3;
        Thu, 26 Jan 2023 09:39:24 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k4so2694572vsc.4;
        Thu, 26 Jan 2023 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vb9epZRW8435qSvZzcf96fwvCBEy+9pZZqKh/fMzFQ=;
        b=VEmRMQLlNxIP1Q3v7hrkwZvqJI320iemUMeKbHAoRjfUGNPYqgS4Tk/BmSIxlApeBB
         nIs/FKkF01nOXQdMKSXjMn+s+sS/cZ1THe71k1RYpd3O2ghqBzD89Tsl6A81XdM5DVhM
         zEt9KHcWHfDoxaOtGlgASzcb0G4/qHPjQmPvH/klW9sorSqfbaRiwupSDH4JMvwm8ko7
         CIUK92Hmly+2ZZNLVPZsy8z+LkPyNfU6sUMEt0B/4WN7s7z7QFvj0VWVWrFKB0kQg22E
         N+ErF5iq1vzky8EmlALOchNW2WPcxaEc6Qfba+MBjSDvP4saHfhrWvJzXlSMUvAWljYi
         CmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Vb9epZRW8435qSvZzcf96fwvCBEy+9pZZqKh/fMzFQ=;
        b=WECm7qHF0NK/T3QsUnlCwbrzkaeLoLG0eksKUmhes8UKqfCBqFC1PzQYXx0I19YGNV
         7TTjLqYsGkjLN582gzRl1HqKT1h7uK5X50cJqaJITFuHTzRA7sxF8PNn3x0bt3ID1euW
         a1aMhrs/HRXJZOv77DYgc2NebnmczJ0dwuL9iy72Tzi0wLhaz+KOeDzm6fgKBOk/qRFH
         NxuqCO6VqVyevYLEahVkzeh9UFmRGil9NJgAygsOK477y9rs4kahOWPOOgw8nfiHOY9G
         sXExOxTnSxioad00Ldhh24Hkl4lAkp83yhXabnSfn5cWvyaF3lR4mJAOGC5JD01ig8sH
         vyDw==
X-Gm-Message-State: AFqh2koCck651hMPeVJ0JRpLKHo/5xCiRBV624CXckB0ginvALTdBW/W
        cFuV5eC6Ebcyy2HaPJxV2QQ=
X-Google-Smtp-Source: AMrXdXtlX0WPqWXPLDpE4tROyEg2mz13hzSgzSVJ/eJ6g5TJu4Qb46V58iilh7yLKkpsIBzomGqPNA==
X-Received: by 2002:a05:6102:548a:b0:3a7:a0fa:91f2 with SMTP id bk10-20020a056102548a00b003a7a0fa91f2mr28076609vsb.0.1674754763105;
        Thu, 26 Jan 2023 09:39:23 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dy31-20020a05620a60df00b0070531c5d655sm1255197qkb.90.2023.01.26.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:39:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 39CD227C0054;
        Thu, 26 Jan 2023 12:39:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 26 Jan 2023 12:39:20 -0500
X-ME-Sender: <xms:x7rSYwzgESckePPqoy1k_8kliapu8ZUS7q1l4GTSSBNvfcUdk-Db0w>
    <xme:x7rSY0RJ7eyAFVi4BSi8JlQYT4wU2-YsN4DFWLzTV3bGw6tuy8yIIFXkQxtG4pHaB
    SrRmgbeUZoXbHDP2Q>
X-ME-Received: <xmr:x7rSYyWi64qwG3iFowm6luUjJOMoq46bBZm07MJUV4IEcLYTEi6JudwwG1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:x7rSY-izAK9rofmogjcEj67NAmn3Uge3adUwgC3A51IY_uUzwXFD7g>
    <xmx:x7rSYyDOEmu8HpSfkdP6H3hMT0oGYuXYYk13tM9H0Cw48n05hEY41w>
    <xmx:x7rSY_IfmcLxPsz5omNEqF3HCBzhDmJ5lfJ3OUATktpZm02SMja5ZA>
    <xmx:x7rSY6ueyhLnMKO2J3wGT1cYLD9CNvm-OhMOov52IQHhoYYJNFlNSQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 12:39:18 -0500 (EST)
Date:   Thu, 26 Jan 2023 09:38:35 -0800
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
Message-ID: <Y9K6m5USnON/19GT@boqun-archlinux>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Cc lock folks]

On Thu, Jan 26, 2023 at 02:47:42PM +0500, Mikhail Gavrilov wrote:
> On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
> > > On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
> > > >
> > > > On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > > > > Hi guys.
> > > > > Always with intensive writing on a btrfs volume, the message "BUG:
> > > > > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> > > >
> > > > Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> > > > tends to work.
> > >
> > > Hi,
> > > Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
> > > low!" again even with LOCKDEP_CHAINS_BITS=18 and kernel 6.2-rc5.
> > >
> > > ❯ cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
> > > CONFIG_LOCKDEP_CHAINS_BITS=18
> > >
> > > [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > [88685.088124] turning off the locking correctness validator.
> > > [88685.088133] Please attach the output of /proc/lock_stat to the bug report
> > > [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
> > >   -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
> > > [88685.088154] Hardware name: System manufacturer System Product
> > > Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
> > >
> > > What's next? Increase this value to 19?
> >
> > Yes, though increasing the value is a workaround so you may see the
> > warning again.
> 
> Is there any sense in this WARNING if we would ignore it and every
> time increase the threshold value?

Lockdep uses static allocated array to track lock holdings chains to
avoid dynmaic memory allocation in its own code. So if you see the
warning it means your test has more combination of lock holdings than
the array can record. In other words, you reach the resource limitation,
and in that sense it makes sense to just ignore it and increase the
value: you want to give lockdep enough resource to work, right?

> May Be set 99 right away? Or remove such a check condition?

That requires having 2^99 * 5 * sizeof(u16) memory for lock holding
chains array..

However, a few other options we can try in lockdep are:

*	warn but not turn off the lockdep: the lock holding chain is
	only a cache for what lock holding combination lockdep has ever
	see, we also record the dependency in the graph. Without the
	lock holding chain, lockdep can still work but just slower.

*	allow dynmaic memory allocation in lockdep: I think this might
	be OK since we have lockdep_recursion to avoid lockdep code ->
	mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
	missing something. And even we allow it, the use of memory
	doesn't change, you will still need that amout of memory to
	track lock holding chains.

I'm not sure whether these options are better than just increasing the
number, maybe to unblock your ASAP, you can try make it 30 and make sure
you have large enough memory to test.

Regards,
Boqun

> 
> -- 
> Best Regards,
> Mike Gavrilov.
