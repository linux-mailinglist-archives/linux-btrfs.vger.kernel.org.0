Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF474780D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 00:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhLPXpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 18:45:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:50139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhLPXpN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 18:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639698306;
        bh=cAlJmF0+xD3XIhS7orFoLLZQKqUelaIhEBjGxcUDlYc=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=OCHo/eh0hKqV/kWMUxtQzwn8MHFrZq2QSzETUsHzyVi8rGWdABfXI16rwccecouW3
         TZl6qXtLXBgBvnkmxp/b5lZpuK5JGGGGVWw9r32x+cned51K0yHmB2Mwt4pcxytAL/
         gu7UhHAlHpLxOOHNzbtPNh2/32162KGAx+tNnaGk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6qC-1mEnCH1nrQ-00lXmf; Fri, 17
 Dec 2021 00:45:06 +0100
Message-ID: <aff0b294-b7f2-b016-3628-348812268607@gmx.com>
Date:   Fri, 17 Dec 2021 07:45:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20211217000515.0e087027@thinkpad>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: U-Boot btrfs implementation - will there by syncing?
In-Reply-To: <20211217000515.0e087027@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fjYGTBIV8FdTCAUUuTb2j1c0Qz0iTmbl8ZFuiDkrmf538mtJ1VI
 T52jCbHeaP0iwI1D9VsykYCspwS5Kmype3WSa4D3nEI1vVsv1ObZETCAfaRseFsZS88NAPy
 xSJ6H9y9OTaNqDvqdyVVLl1aYeWRMxuV2/A4oVX/R1yujiu/kUOwsCUFRHiRukaaCjAAssU
 iQdTe+49asoLt4UvKL6aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pHKk83dGJPE=:gjN2RKy1xZvfPozjX5sdlH
 KhXvnUKObvhJhB5SSDRk/1bpw06pHhtqoicT0k0stBe4eFG336Wfbb4OIhgBNOofvJ/wzDoOG
 S7k5rBAbj6PTp9nwNxecjG0tDS5AT/gMf1oS/t8NqEd+2k3NRE+TDAJ1NtiAjto9QcXfyVFDE
 rTg343DklgkBIs4mqKLJJe9IDf3MXGvJSru1chVNdPPSBRbfbLkt4MM2J2UriS5S+RUnsk9H3
 GNXV6kSJ1gRneD5dRgipHigNGelM5gFk+Qp6ylU1EgsfUb5O7BY4Mp0XbPbvWIE/Xp1Mc+3ro
 SYQqAePWqzU1s9t3hEWq8sIcecfLwgxYmvZCky/juBaW3xJZn1ajEXlZrSy3oHTNXuq9c+XH9
 oztHHLUSzy0GUfA/SuTaeYSEHFd126qTPBg9hNv68GU68UMJJFvTH+rBpYmmd09KEbmg9rXM4
 kHXS9UMLLv5uubN1NlcLOIrdAWJS8Z4OJT2C6ZZ+vsnPM/EucITLWVat1e+bUwKgPPLIJ2Q/o
 Axa2Aj3BbKfyCNq9OHg/jUR2SeuZJ91oXTd7w/0tMDE+cgq7E/zznN95B3tf34xyCuqQjbWW2
 Hy8Uh0tISjYz/dIOqroZ36qf8eZX1uyjJnoy8SHZrIquwj3bY3cC+vQjRdJW6Wx5Bqiv8w/1j
 6fj2q0oUTGxu3jHYY2maxqNhqXnWCKC9d11YoFasXhJjSlFuLWhABhdh2kAoUOhmXAzG3Vu+L
 AiIn5WY9F1lTAx7SeSTTVIu5lmetX9TUcRUy5oanKk2SAeIMqwIntF5NH0oHADkruqcuTDUIS
 ftmT3LjxzUvnIQ9RD2yH6p3YsZfj+WbJGV4GTy23vFO3DCqxvhBOMuvbF6t8Pv2VsfMn9RRvP
 0uTpCeh58BjVr9OKAFfr4ViysivszwrEkr3JAjrPbWQLrOW3CaTEQiZf0GfYZjUcD8r+Q87en
 FS9IS7njbG9vYzHgVLyqhsAFQlUkRvKZMP5nXym8YRrsAjg0jzYU83yhlA3G9ar23Bsy4cR7c
 OUrbAj/tQ+E+Rb9ecYQamEmMDiBOB0ysZ1UbaB3zyNVV6AyZs0/7InwEU+Nra3J6oFBsT9hX3
 UYofq1DkVmpsCI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/17 07:05, Marek Beh=C3=BAn wrote:
> Hello Qu and others,
>
> one of the points of Qu's reimplementation of U-Boot's btrfs code that
> made it somehow synced with btrfs-progs, was that the old
> implementation was, quote
>
>    pretty different from btrfs-progs nor kernel, making it pretty hard t=
o
>    sync code between different projects
>
> Another point was that afterwards Qu wanted to bring some of the missing
> btrfs features into U-Boot, since they should be much easier to
> implement after the reimplementation.
>
> I was looking at current btrfs-progs, and noticed that there were many
> changes since then, but only one or two were ever synced to U-Boot.

Yep, those changes are mostly preparation for the incoming extent-tree
v2 feature, they bring no real behavior change for now.

And I'm planning to cross-port them just to make later cross-port easier.

Thanks for the reminder.

>
> I would like to know if Qu, or anyone else, is planning to do this
> code-syncing, and maybe implement some of the missing features?
>
> The reason I am asking this is that in the meantime I've reached the
> opinion that the idea of code-syncing in this sense almost never really
> works. It is usually proposed by one person who ports the code from
> another project, and then keeps it synced for a time, but then stops
> doing it because they have too much other work, or change employer, or
> another reason.
>
> It happened multiple times. One example is U-Boot's Hush shell, which
> was imported from busybox, with the intention to keep it in sync, but
> the reality is that U-Boot's implementation is now years (decade?) old,
> and there were so many ad-hoc fixes done in U-Boot that currently the
> only way to sync is basically to change the whole code (which will also
> cause issues with existing user scripts, but maybe it should be done
> anyway).
>
> Another reason why I am writing this is that I think that with the
> amount of work Qu put into that reimplementation last year, he could
> have instead implemented some of the new features in the old
> implementation and spend a similar amount of time doing that, and the
> result would be those new features in U-Boot for over a year by now.

I doubt that, the original interface is completely different than the
interface we have in kernel/progs.

That means, if one wants to cross port the recent extent-tree v2
changes, it will be a hell.

So in the long run, it's still beneficial, even they get de-synced somehow=
.

>
> Also, I've come to the opinion that maybe two different and maintained
> implementations are a good thing for such a project as a filesystem,
> similar to how multiple implementations of C/C++ compiler are a good
> thing.
>
> For the last few months I was on-and-off thinking about whether it
> would make sense to revert to the original implementation and then
> implement some of the missing features. But it would not make sense if
> Qu, or anyone else, is planning to do that code syncing and bringing of
> new features from btrfs-progs, so that's why I am asking.

The worst example for different implementations are another bootloader,
GRUB.

Its btrfs implementation has way less features, no sanity checks, and is
super easy to craft an image to cause infinite loop for GRUB.
And it even can not handle the new default mkfs features (NO_HOLES,
which is there for long long time).

Thus I even re-implemented a new license compatible project from
scratch, btrfs-fuse, to provide a basis for later cross-port.
(That only has read-only support, and is mostly MIT licesnsed, the
interface is almost the same as progs/kernel).

It may be possible for simpler filesystems, but for complex filesysmtes
like btrfs, a completely different implementation with completely
different interfaces is really not an ideal situation.

I don't really want to do it again and again, using different (and
sometimes very crappy) interfaces to do the same work.

Thanks,
Qu

>
> Please give your opinions, people.
>
> Thanks.
>
> Marek
