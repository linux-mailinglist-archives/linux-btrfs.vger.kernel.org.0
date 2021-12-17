Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D519D478129
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 01:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhLQAO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 19:14:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:45041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhLQAOZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 19:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639700058;
        bh=kAlD+V7tIYnxjSOaQoMmegWJ7vF5KYG71pJ2AqIfNzo=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=hKhIAdDzaMuwNvtNY6dsQThc379Uc3F17g64X8T/cX4nm1qJY8T8BxIJhUCWQGv4x
         5FXltT3Rzltl9i9Ggs0lU42Ql70R9DMG4cCA8Hsek/321HaYrSbX6NeGnb457IfUVF
         fKjCOdeCpquE7vNAzGeUfHGgxBvUAzJzthMcOMhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1mgThm44ed-00syUZ; Fri, 17
 Dec 2021 01:14:18 +0100
Message-ID: <4976f2a8-a40d-cb0a-4257-80c01727089f@gmx.com>
Date:   Fri, 17 Dec 2021 08:14:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20211217000515.0e087027@thinkpad>
 <aff0b294-b7f2-b016-3628-348812268607@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: U-Boot btrfs implementation - will there by syncing?
In-Reply-To: <aff0b294-b7f2-b016-3628-348812268607@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dMVYQNy1cdCNEMSMkSwV2PhoQF+aq2ywXmW+SH7g489dJg1Ma6t
 r4vNQXEa/UsLvpXFTSL+h/EQnQgpQusJoJN+EIK0Fh8HtjUG0DSVY21tepow0iW75FRznl1
 /7GNvShN7eHBpo0oepWtqISmRDaR6otsgvaayzdUcZNChUFDLGByxne8rVMSUzQiu6eSmPe
 kjbPaxTjiV7veffrZ5xfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dg6tnOyc14U=:srJC75XJgXZTPgj03EQcy1
 uyByv4ZJ3WEAvCZdOvNNbWu5VV+pVP9Sza3fXcO7hpny04qnDKXifWJ7zOMkLdVH4orzj471b
 qPGjKW8iBK8S0HvsP6/kfBiSijw8twqmQgJzGGHAp5gcZgAB06qwF5plxAEFYRGQKI2K/NxhU
 VPLnQuwex1vNRhb+Sa+tPqs+tN3vAlr3ousSvXeZOo6r6gpHrVC7RTLPiNbELHDCON8OiXu3u
 frdWDn03Ej9GwgRoXZUJ7p7TmwxF5So8oTSwCsDRxm8ZUM/XbT9bAagoCFzEYZTHHFhoRZq9H
 SabyWSpMHA8FIw/3sROToO5d8hLT6rDzKgS8FjWFIqQKZ2yFJVbeH/GTJEt1tox6uJsRuvCpL
 eTSq6P4jyhYdkIkFsGyg50yqqlmGz428sD+I1/grS1FQJvC0bTzxWT3cXMH0Tzz0sdhD6yzCu
 ewxXP+8hKnCoge7lKXWy9nKflqY4hDjPfLbXebg8AMg2zj/KzPoD+b5Jdh0nHGMQC3pHFPIYr
 GrPV+LGv6kJGZEdYTA1lzXPdQ70WWGAi931hC2QE1eOXnsNBIoVFbVkQbwk6imJ51AogvXR71
 oP2BwR89VNjvM9ykRN+B9RtBulEURRDg/oqwfjqM4EZyEn3zqsETEpMl1JnEp3SG1utqCeUer
 vjXTQ0HRHGSikQrfdJEkliLEOaPuCLWTdq1uvWZZEeOyi0O/C43JewqZz1wQt4XzVL1vvsjTI
 z0DlkGZVYcLU+UfRcAReylzt2rlfWDnUFELfSd9bMvcGqkiSoPAmFG2msxnbu5zLvZUkeFvLt
 YmAcZDKOBjtBTx/0oMs6Nq7qswrHq6s+jnJ/eauqC9eNYMgbc2qMuGKrG+JwJTslUeU+Uhw4d
 ujsRiT8PfeANjQ50IDMY4k08KXk5XtzSnWZENPXbDkunH5RDK8DkLZadOtizhuxSGnHtQZpo+
 HhYAtc+C6w5Ozg0d/kFB6oPxnkg57B/PsEgOZqfjaDB8XRvmn/M3OhdWC6+3DUd3chu+ApjYO
 nrFLonxLMvlWhppHA/y4R9Hp4uBbH1wJZ4nGtTkg68N3TaiSnsxZq3wqvrc7QFdNBykcsfsyE
 N3/rEoawPPVG7U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/17 07:45, Qu Wenruo wrote:
>
>
> On 2021/12/17 07:05, Marek Beh=C3=BAn wrote:
>> Hello Qu and others,
>>
>> one of the points of Qu's reimplementation of U-Boot's btrfs code that
>> made it somehow synced with btrfs-progs, was that the old
>> implementation was, quote
>>
>> =C2=A0=C2=A0 pretty different from btrfs-progs nor kernel, making it pr=
etty hard to
>> =C2=A0=C2=A0 sync code between different projects
>>
>> Another point was that afterwards Qu wanted to bring some of the missin=
g
>> btrfs features into U-Boot, since they should be much easier to
>> implement after the reimplementation.
>>
>> I was looking at current btrfs-progs, and noticed that there were many
>> changes since then, but only one or two were ever synced to U-Boot.
>
> Yep, those changes are mostly preparation for the incoming extent-tree
> v2 feature, they bring no real behavior change for now.
>
> And I'm planning to cross-port them just to make later cross-port easier=
.

Forgot to mention that, a lot of btrfs-progs changes are not to the core
implementation, but ioctls/user-interafaces/check/image tools, thus you
may need to do more filtering to figure out what's really needed to be
backported.

But I may not cover all changes, so if you find some aspects missing,
feel free to point it out, or even better, try to crossport if possible.

>
> Thanks for the reminder.
>
>>
>> I would like to know if Qu, or anyone else, is planning to do this
>> code-syncing, and maybe implement some of the missing features?

Some missing features, are blocked by lacking of interfaces and knoledge.

Currently the missing hash (BLAKE2) needs BLAKE2 support in U-boot,
which is still not yet in U-boot.

If really needed, I may crossport BLAKE2B to Uboot then implement the
support in btrfs.


The similar case is for multi-device support, I'm not familiar enough on
how to iterate through all block devices in Uboot.

If there is already such interfaces or someone could provide some help,
I'm pretty happy to implement it in Uboot.

>>
>> The reason I am asking this is that in the meantime I've reached the
>> opinion that the idea of code-syncing in this sense almost never really
>> works. It is usually proposed by one person who ports the code from
>> another project, and then keeps it synced for a time, but then stops
>> doing it because they have too much other work, or change employer, or
>> another reason.

Personally speaking, my current employer (SUSE) is super awesome, and
there is no plan to move to another employer.

Furthermore, SUSE is a super strong supporter for btrfs, thus
maintaining a common base to provide better btrfs support is definitely
benefiting SUSE.

Thus you could count on such long term support, and personally speaking
I'm pretty happy to work on btrfs, even not paid for.

So the long term support, at least from myself, should be something you
can rely on.

Although there are indeed cases where I'm buried by other btrfs work,
thus such reminder is really helpful.

Thanks,
Qu

>>
>> It happened multiple times. One example is U-Boot's Hush shell, which
>> was imported from busybox, with the intention to keep it in sync, but
>> the reality is that U-Boot's implementation is now years (decade?) old,
>> and there were so many ad-hoc fixes done in U-Boot that currently the
>> only way to sync is basically to change the whole code (which will also
>> cause issues with existing user scripts, but maybe it should be done
>> anyway).
>>
>> Another reason why I am writing this is that I think that with the
>> amount of work Qu put into that reimplementation last year, he could
>> have instead implemented some of the new features in the old
>> implementation and spend a similar amount of time doing that, and the
>> result would be those new features in U-Boot for over a year by now.
>
> I doubt that, the original interface is completely different than the
> interface we have in kernel/progs.
>
> That means, if one wants to cross port the recent extent-tree v2
> changes, it will be a hell.
>
> So in the long run, it's still beneficial, even they get de-synced someh=
ow.
>
>>
>> Also, I've come to the opinion that maybe two different and maintained
>> implementations are a good thing for such a project as a filesystem,
>> similar to how multiple implementations of C/C++ compiler are a good
>> thing.
>>
>> For the last few months I was on-and-off thinking about whether it
>> would make sense to revert to the original implementation and then
>> implement some of the missing features. But it would not make sense if
>> Qu, or anyone else, is planning to do that code syncing and bringing of
>> new features from btrfs-progs, so that's why I am asking.
>
> The worst example for different implementations are another bootloader,
> GRUB.
>
> Its btrfs implementation has way less features, no sanity checks, and is
> super easy to craft an image to cause infinite loop for GRUB.
> And it even can not handle the new default mkfs features (NO_HOLES,
> which is there for long long time).
>
> Thus I even re-implemented a new license compatible project from
> scratch, btrfs-fuse, to provide a basis for later cross-port.
> (That only has read-only support, and is mostly MIT licesnsed, the
> interface is almost the same as progs/kernel).
>
> It may be possible for simpler filesystems, but for complex filesysmtes
> like btrfs, a completely different implementation with completely
> different interfaces is really not an ideal situation.
>
> I don't really want to do it again and again, using different (and
> sometimes very crappy) interfaces to do the same work.
>
> Thanks,
> Qu
>
>>
>> Please give your opinions, people.
>>
>> Thanks.
>>
>> Marek
