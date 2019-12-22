Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19969128D47
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfLVJhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 04:37:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:46323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfLVJhw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 04:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577007470;
        bh=VZgEn2yurWNeZYTsub84E1KvIrqS/vL3wgGsj0gXVpw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a/KZvhWYn1dFBXN/OAlJZqp8xjHtVx3qNKV5iCQAQxO1jhOmSTCuPkHeNlTRdVDtH
         HICyFW9dN9afGHlgbcPsn3BF28tOfvSPDjE2lI/9Cp9HsbY9e8TioBM+dkf2S75eAk
         bR8Sj1X+GfEibflO3JslifatAygBYjEmpQj24XVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1i8G5L2nFm-00b63P; Sun, 22
 Dec 2019 10:37:50 +0100
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
 <e743df15-4830-8d83-bc36-6ddd33c1e720@petaramesh.org>
 <dd37e99c-e087-2b6d-830a-96811b337ba2@gmx.com>
 <bd183df9-4742-301d-251c-443d99d170c7@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <a39bd758-69d2-cf16-de39-36e22cefe233@gmx.com>
Date:   Sun, 22 Dec 2019 17:37:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <bd183df9-4742-301d-251c-443d99d170c7@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hx/RLmi1fTSn9x4QSMo5cuE0jms1DL8F6/JQM4+YELr6upuEWd9
 ttUXszCQHP1Dg2GsKO46wkiB3s9NvL1yPB5hLAhlmSc7fxFLK0gBYy9c+oDVvPL7/jaXN/E
 Bs5tgTTitv8/vHZnrCz8dytpdQ11Rm8aNEBDOMUjnMGsHWbYf7m0d1DcTJsIjquhhak67XH
 bYINfVbujYaJYNM4pzxQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pjqjGs+g6nQ=:p+Ik/j1X14LFL1lJwm+Tne
 MYGYRB4BcxUruct9TPqrKWJ+5lYgQ3t1jpK3mNMHYEu6c+D0Nq9oeF3fBdhqLX26zdSgy7Rm1
 nryXoyWZt53CV06n/t6Euwf3znCtCn8XTHnoxDITqLN0urRE0amIv7bKBr0xWhkcTfjrDYteh
 njROkD0Ago8NM+cJa3kN+dpdeQqpHmny+bqFwQ0r/lxR91e2p58TFNvrz/Otz30TMvXZ3+f63
 OowToe6I70HXApXyFloKhfdAp76nzaM9e3vev8kGuD2rJsb+qnxws7rcUa0V4ChZGJfu5qs+P
 jMlMNtzi0UZprIEBz7Oba8lKJEPS2HmrkdCplm/YZr31Xdsx3zIWK1ldTSFwglixS3qP/LO3M
 /h+4q71ZK+2o4vhrsLwg1LFFjHs3BBBO4oBgh/b4Hp2DPOLmFAfXFQJp5eTUaAvzyGnl1gx7K
 tnN1d1tk1vvUmRYDbzAH/TBAhyWXm1jsQqUtylkmfu8LeGWI/LeyTNHNHL6OWh6JqkBFSd25L
 XCF9ea1rFAbUSOap1pfeq3ai7TRtg276e1hPfQFk+nhx9GNjeN0wmFUWiN0qg+iVGBUtFTcms
 7uQSuFLp6T2eDD3ZnjwOyp9QSSDu7zomF39oZVW45OZxSSFBp0sVrmzUCm1ywALuxHEYCRC6T
 CD2B83al70nHY/pOaEjJdG0VUqwTLwDww8Nk0asH24Za8DWLl4Hs7gE9qWZz0LucFbHB8Zk4W
 qoijXP5MbK+tKIieSzVOD2TgWCTI1/8+Db4D03Ng7/sXrg2IBq+Nuu0bPVOMuxpxmplbQ0qjz
 jjhYRp8DkGp2oNs6SuHuHaiavfNZhSWN3KFU74Z1qASiaXujuO6Vq74X0rH3SZEtYCcIo31I8
 f+GEzdq7AN7Dc3gAEgdM5OhnXobEDZpatZvWtZ+gdk34OM91muUEE7uCXQyvfxIPUDtCUI8Hg
 zgc+YlTMKBB0ot0JTO9UPNbDvQRZ+bo7RVaWH37SbYWocgDhbieFg5lYkhNGvQZH4N3DmJHnX
 rX9WjlUs7vwu8z4xxcXR9GVUkLuMkhg7DcPYSb0b4uh/8CqxLGPJmdIGYSh0UqbDwM00amLl2
 wvbfl10TLjrZLnhYK3rtmKLkeG+dlg3z7GxjyF4hMBHzUDuFkJ+5Lw88oiqlGl43CJ8i4dd3V
 7qb0pZaE0TthO3x8QkU2RpFiyeo5FujU5MKlBskiYCEoUUQGSAX7EBI+54kRZRT+lMADMUbls
 HcvixgryDehGbVv+Wn+z0htuwTYakwarrb63zRtKNyFF3EbDlEtkCbWD0Oow=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/22 =E4=B8=8B=E5=8D=885:00, Sw=C3=A2mi Petaramesh wrote:
> Hi again,
>
> Le 22/12/2019 =C3=A0 09:12, Qu Wenruo a =C3=A9crit=C2=A0:
>> So if you have enough uncommitted metadata, that check will be triggere=
d
>> and suddenly returns 0 available space, even 1 sec early you still get
>> tons of available space.
>
> With =C2=AB uncommitted metadata =C2=BB do you mean that this situation =
is only
> temporary and should end once all transactions are commited to disk ?

Yes. The temporary part also matches with one kind reporter's description.
So for that v5.4 temporary 0 available, it should be the case.

>
> Because in the one disk on which I observe this (and which passes a full
> btrfs check with bells and whistles) it still shows 0% free after 2 days
> and several unmounts / remounts...
>
> Furthermore I've conected it to machines using 5.3 and even 4.15
> kernels, and they *ALL* state that the free disk space is zero - even
> though I can understand if =C2=AB That check is from 2015 =C2=BB.

Then for older kernels, I'm afraid you're seeing a different problem.
If you feel like to try to start hacking the kernel, I could provide
some snippet to add debug output and pin down the problem.



But there is one valid behavior which may cause such 0 available space
situation.
Are you using RAID1 or RAID10 with hugely unbalanced disk size?
If so, there could be a case that btrfs can't find two devices with
enough un-allocated space to fulfill a chunk allocation.

E.g. 1T + 1T + 10T disks RAID1. You can only utilize 2T space (1T from
each smaller devices, and 2T from that larger device).
The remaining 8T from that larger device can't be utilized for RAID1.

In that case, you will still have unallocated space, but any profile
requiring two disks is unable to use it.

>
> That still seems to boild down to : Once I got this error it seems I
> cannot step out of it using any reasonably recent kernel.
>
> So I may have either to patch my kernel or wait for the patch to reach
> #Arch kernels... and hope it actually fixes it.
>
> (I have to admit that I haven't yet fully understood the technical
> aspects of this overcommit story...)
>
> I'm also worried that on my machines that does NOT show this problem on
> their own main filesystems, this could happen anytime soon ?

We need extra info to further determine the cause of the persistent 0
available space problem.
`btrfs fi usage` output would help a lot.

But still, that 2015 check can still cause 0 available space, if your
metadata available space is pretty low.

Thanks,
Qu

>
> Thanks anyway very much for your help.
>
> Kind regards.
>
> =E0=A5=90
>
