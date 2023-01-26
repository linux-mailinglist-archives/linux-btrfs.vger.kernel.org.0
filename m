Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BB67D8B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 23:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjAZWnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 17:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAZWnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 17:43:07 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A045F6B;
        Thu, 26 Jan 2023 14:43:04 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id k2so2579550qvd.12;
        Thu, 26 Jan 2023 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQTH5iCah1FP2x9WKr5XrRV0wZBo+AefYkRVKX7uGhg=;
        b=B3xswdfEcfO/qyMhYpZB3KsgnA7LApXU3UffOfCL8MaKK7LcmlIbnOdyyAutsttOZl
         9XIiElrB948y+mVlkap8paUXw0Oxy6HP5KcoFsPHCcao2T4mxGNBCCoNLw1NoQpqGKOa
         bM5vKKA4yxx4ns6mBovlBX6ysJWrf0JvpHD5kAEWrMLCmhmoueoPevWTE/SuelXPKDjB
         jfxhCcECDPp7a7xj/rQR9CAsFEylf7j+REU0indcK1IOQynUvbUXNVyWCePjIFwOpWqr
         /w1wZsEAChR/1KZ2Ap39jsiiYGrBeCOP6+fvHMZchQUjIBVYlZLBA+JS8HJaO2G+MZB9
         wtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQTH5iCah1FP2x9WKr5XrRV0wZBo+AefYkRVKX7uGhg=;
        b=y3WefQZNP0YvfHRhoTvcN0tZ3S7aC+jVYhLGNu4Vx0wXuetsjjIpJ8CRYlDfcE9TQD
         ara9teFOZguUVebaMu9iLY9NRr2eDA3vjxzhoE518SprkqDv4CHjKifpFXe7WG8tuSeG
         7pzQiVEFd6NGv0zeZK75LI/MFQSK6w4laAjwPCfYL4/X+p64021n7zaEBdpeNfSkljXn
         F8ZOgnNsXvzPFIkXeaHQtQ0ZvkMg9cfw7YNrQUPplyDgTS+Krt1l0HFChsiu1CpSfiuX
         maN4mKawBVsAdgS6NTxuu9O61R7MjEnbNJpvNTpqlbRykUO8e5ABr5ypkqBGaRzfhXFy
         3IbQ==
X-Gm-Message-State: AO0yUKULKavljxVSQlDz0JDFx5eiVY/wzATQ+5O3nRNluG1WcOPO3CEW
        u/FN6ToIejlM9bFCgZkQh3D/es09JZjy/39tdYQ=
X-Google-Smtp-Source: AK7set/GP31tlQzIKhQe2uNsROk0VfM6oJ5yONHSQEvGrN3cwpCTVJnp1Jbol4KbNXyYIqaJ4f/8n4AtcRVW31Bpixg=
X-Received: by 2002:ad4:4b68:0:b0:537:6e55:eeb7 with SMTP id
 m8-20020ad44b68000000b005376e55eeb7mr613764qvx.66.1674772983589; Thu, 26 Jan
 2023 14:43:03 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz> <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz> <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
In-Reply-To: <Y9K6m5USnON/19GT@boqun-archlinux>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 27 Jan 2023 03:42:52 +0500
Message-ID: <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 26, 2023 at 10:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> [Cc lock folks]
>
> On Thu, Jan 26, 2023 at 02:47:42PM +0500, Mikhail Gavrilov wrote:
> > On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
> > > > On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrot=
e:
> > > > >
> > > > > On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > > > > > Hi guys.
> > > > > > Always with intensive writing on a btrfs volume, the message "B=
UG:
> > > > > > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> > > > >
> > > > > Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, =
18
> > > > > tends to work.
> > > >
> > > > Hi,
> > > > Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS =
too
> > > > low!" again even with LOCKDEP_CHAINS_BITS=3D18 and kernel 6.2-rc5.
> > > >
> > > > =E2=9D=AF cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
> > > > CONFIG_LOCKDEP_CHAINS_BITS=3D18
> > > >
> > > > [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > > [88685.088124] turning off the locking correctness validator.
> > > > [88685.088133] Please attach the output of /proc/lock_stat to the b=
ug report
> > > > [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W   =
 L
> > > >   -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 =
#1
> > > > [88685.088154] Hardware name: System manufacturer System Product
> > > > Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
> > > >
> > > > What's next? Increase this value to 19?
> > >
> > > Yes, though increasing the value is a workaround so you may see the
> > > warning again.
> >
> > Is there any sense in this WARNING if we would ignore it and every
> > time increase the threshold value?
>
> Lockdep uses static allocated array to track lock holdings chains to
> avoid dynmaic memory allocation in its own code. So if you see the
> warning it means your test has more combination of lock holdings than
> the array can record. In other words, you reach the resource limitation,
> and in that sense it makes sense to just ignore it and increase the
> value: you want to give lockdep enough resource to work, right?

It is needed for correct working btrfs. David, am I right?

>
> > May Be set 99 right away? Or remove such a check condition?
>
> That requires having 2^99 * 5 * sizeof(u16) memory for lock holding
> chains array..
>
> However, a few other options we can try in lockdep are:
>
> *       warn but not turn off the lockdep: the lock holding chain is
>         only a cache for what lock holding combination lockdep has ever
>         see, we also record the dependency in the graph. Without the
>         lock holding chain, lockdep can still work but just slower.
>
> *       allow dynmaic memory allocation in lockdep: I think this might
>         be OK since we have lockdep_recursion to avoid lockdep code ->
>         mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
>         missing something. And even we allow it, the use of memory
>         doesn't change, you will still need that amout of memory to
>         track lock holding chains.
>
> I'm not sure whether these options are better than just increasing the
> number, maybe to unblock your ASAP, you can try make it 30 and make sure
> you have large enough memory to test.

About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
be done? In vanilla kernel on kernel.org? In a specific distribution?
or the user must rebuild the kernel himself? Maybe increase
LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
to distribute to end users because the meaning of using packaged
distributions is lost (user should change LOCKDEP_CHAINS_BITS in
config and rebuild the kernel by yourself).

It would be great if the chosen value would simply work always
everywhere. 30? ok! But as I understand, btrfs does not have any
guarantees for this. David, am I right?

Anyway, thank you for keeping the conversation going.

--=20
Best Regards,
Mike Gavrilov.
