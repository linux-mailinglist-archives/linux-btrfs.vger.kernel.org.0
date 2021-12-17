Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A624782F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 03:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhLQCCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 21:02:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:40833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhLQCCC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 21:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639706437;
        bh=1XSw2zY1pwqhoJ/Bd+mq+ZEGjgcuW8AYYW2ruu5ArTc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=XCavK46Vhya3AhCVrC1U3xe0nMVHHEXhPUkMCuJ3XA4VkyOOdVeFNttT1pYPw2j1W
         VpUHxWmp7E46oFV/OWou3rxXG0vOMI/ZgUXqhH0yQdy1cnOTAISYfpZiU5dv0aJPH+
         aVNBPKZ89DZfcx4nLK8O9HxwDtIW6zJ5fkBaQndQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sHo-1mt6bW23bW-00515b; Fri, 17
 Dec 2021 03:00:37 +0100
Message-ID: <6ed64808-1161-6cea-214c-88a1ac883101@gmx.com>
Date:   Fri, 17 Dec 2021 10:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
 <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
 <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
 <20211207072128.GL17148@hungrycats.org>
 <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
 <20211207181437.GM17148@hungrycats.org>
 <2e0f4856d8132f39e5d668929f77aac7ed01d476.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: ENOSPC while df shows 826.93GiB free
In-Reply-To: <2e0f4856d8132f39e5d668929f77aac7ed01d476.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CTfyY08BKM9Au5OQYN0UIHyT3yjhNLWRo1PGK0UEjG5W7SUYo2z
 fkmR5WgXdLYO2Mgdn3O+js3Et/rz5QGiGTdc+dnNsBNqscDmyHnwv4AktuDO9fbKONOol0C
 wobWxA0TfmEV18e4NKbaX4MIx+hIKYa+RcMI1KMY/4eTDL7GlwtPHoRvtrKwmC+m3foJaRt
 n5voVoLiRphD2dqq34L0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gYQys8d1JHU=:5dH6ftFmuZP5FZykpU4DYR
 hNu70v/L/4jY5iDaP02KYKDciDD7qcos9uFxzjK9EPLh3uUpC5cCAW8vlf+xfFq+gmXfMwtLv
 2mk2fHfTzKv2c+mSsBbP99Ripm3M2fIyeoIK/dJaK4XoTFpZ2MYU4lmlYOyhbynPLvxFxHTLr
 jlfGBF2+vK4KLQsw6LkdFOpvBlK2niNOyo2b+bmuUyYMLSzHBzWYWAwRzf4zqcQdgmNlfxm9m
 326juJfRZuwE6UqMrsPMeEr8YfGr+3WUzF4gV/GAhGoqKMHayKAoBREM4RFgceUilkvLk/gPP
 Q9V4yRzOc00ywSXZJDOznxZjnhHHsVPDrewjqcTwm5vdb1ry0LlKL3juhM4SKfVxOQOennzwh
 pH9Z70IAHUSIWZGzoGaW6p7D1O82hVopVm+MOs+30MN7uSOsykcC051DVihogNy3LRV2+e1tT
 0LPMDiAXdnQtqCNyZuMsY/zUgHgaFeL1ZJqq0QiSrrOwtM3m0HkIDYk0uJvf9MPYi9xQdtKhR
 Kml7VsQqmgEdEwWxdhsLfWmDQB0JkjldljBD4/28+GdSgOFS+HzDs6cnhsNjKfnLrO60e3ui/
 dhbP4SO7ZuLdWQ521bWUKYC38Vsz6CLjFOla3cO6dNAfZsi1bGSjTADZ9uI1T0xNCaLmrvMdx
 S0MiCQToJhINXiGPG9IyWRv+uc2cm2L97iNlfTfDd2nK6rWhZ0k7TkbJJYmxCJAkCE55j9ofF
 b0Bg3P5v7cSdRHmHcEh5Cmcm/iFGPy5lWteKM3kMdjl70Y1foQjEp3PP3RTpJG1+KB4UWzJbm
 4Lg2WvZrV49zeMyXP/zkwPufpyz4tzJGVX3GeWSmLWf1Y/wGmnF2RRCZNyZgM1EzZQrEqY5AV
 Qb5aJLEtsXn9QIy2rLJEj3x1sIoL0baS4XTnAt8OEw21TGMQkIHyibwMMyYPHhQESDk6xLEgc
 0lKoq8cNnP6vPfD2aNAaDNLA2JR2JlO9LQY04GOxlMTZygrfWiGZv6p5ea9kcJvlcUDZFsowm
 mVOp4WRs2uz7y9wsVE8MnRBasQRboJGRf2vjvrBaljXj/Jq36onGyo1WmKmGX0f29Y1b8qK3o
 pU674GcYzBWNKA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



[...]
>> That's possible (and there are patches attempting to address it).
>> We don't want to be too aggressive, or the disk fills up with unused
>> metadata allocations...but we need to be about 5 block groups more
>> aggressive than we are now to handle special cases like "mount and
>> write until full without doing any backups or maintenance."
>
> Wouldn't a "simple" (at least in my mind ;-) ) solution be, that:
> - if the case arises, that either data or meta-data block groups are
>    full
> - and not unallocated space is left
> - and if the other kind of block groups has plenty of free space left
>    (say in total something like > 10 times the size of a block group...
>    or maybe more (depending on the total filesystem size), cause one
>    probably doesn't want to shuffle loads of data around, just for the
>    last 0.005% to be squeezed out.)
> then:
> - btrfs automatically does the balance?
>    Or maybe something "better" that also works when it would need to
>    break up extents?

Or, let's change how we output our vanilla `df` command output, by
taking metadata free space and unallocated space into consideration, like:

- If there are plenty unallocated space
   Go current output.

- If there is no more unallocated space can be utilized
   Then take metadata free space into consideration, like if there is
   only 1G free metadata space, while several tera free data space,
   we only report free metadata space * some ratio as free data space.

   And if by some magic calculation, we determined that even balance
   won't free up any space, we return available space as 0 directly.

By this, we under-report the amount of available space, although users
may (and for most cases, they indeed can) write way more space than the
reported available space, we have done our best to show end users that
they need to take care of the fs.
Either by deleting unused data, or do proper maintenance before reported
available space reaches 0.

By this, your existing space reservation tool will work way better than
your current situation, and you have enough early warning before
reaching the current situation.

But I doubt if this would greatly drop the disk utilization, as we will
become too cautious on reporting available space.

Thanks,
Qu

>
> If there are cases where one doesn't like that automatic shuffling, one
> could make it opt-in via some mount option.
>
>
>> A couple more suggestions (more like exploitable side-effects):
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Run regular scrubs.=
=C2=A0 If a write occurs to a block group
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while it's being scrub=
bed, there's an extra metadata block
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0group allocation.
>
> But writes during scrubs would only happen when it finds and corrupted
> blocks?
>
>
> Thanks,
> Chris.
