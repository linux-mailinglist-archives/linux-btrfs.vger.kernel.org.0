Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E393D4C15
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 07:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhGYErg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 00:47:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:60721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhGYErf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 00:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627190882;
        bh=yk4HC/WglYbeVnohzOEFPf9A56hcayIyAd5yeJYBTYg=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Brnxux4dd/vaV1MVrxIe0wNKhwYlYBez+uOhIU/CyMtuSEcRIALNUvKZq+A/RMCSP
         IsUWJ8dHjF7qvTTUA7hm2/Lv2unKNcBReDBz6yLw3pjZMA+OxJwdQjFAs+xRfVlkfp
         Y5B+H32OTgyDTa7pyO2kwos4unJBHLl34RHErN5s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1lWp9W0iaZ-00cRlS; Sun, 25
 Jul 2021 07:28:01 +0200
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz>
 <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
 <20210722135455.GU19710@twin.jikos.cz>
 <20210724231527.GF10170@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Maybe we want to maintain a bad driver list? (Was 'Re: "bad tree
 block start, want 419774464 have 0" after a clean shutdown, could it be a
 disk firmware issue?')
Message-ID: <7cc3c882-6509-ffde-ac32-2d4dba6ade94@gmx.com>
Date:   Sun, 25 Jul 2021 13:27:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210724231527.GF10170@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7gZAwAsne9ST6k1GtPa3Eu4idwR+tKcq85dWnvak3N7rcH7y6mj
 DY7bInu2Y817P2IPkXWsjEUCpcnnX/gRWfxhW7nhkDz/lsDLz/jwM80wFgBFwMCq/KireOU
 M7QXpRu4gRzIbbuRb5+KHGsnG0qSU4MVaniyvnkYoyQvtGrmel7GaZHVTaVz0Zqc+SmoKn9
 0pg1iKxyeZnpq027qB9FA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xT5dfOvgmis=:+dLRf3J+ZW7dSiiu5kX2r2
 KdpwcirI7K3UBt47YN3ErH//VcCOKsLxbtxUQNm0LLtOt17cPrHNwEt46XdfVhBYb4kggStoD
 6tk1c5eF0QRK3K+7QMcxCM3nYaDU04taWIu0QYw2TvYvCiq7B74bgAhKx7ORqslxkX1WBM5Ru
 cORe3i6If/FsoFo41WpUx80QsPuFdjFK0mXyu/WEqbpuySijPaKnelRO9mOuHw3kY1t0LUv4r
 jIomifVGDy4pjOa8lyoWmJhZXXKiSqnj2MXIIdTnmxjJjpudybjlNwMNongP9Oa2uQ6vfioUi
 HJ6xsqCiQo1ZzhLLeYXS+nUBUUM0R3+D9Sj/rsz2I2N2e0TuJYhoyMrMDed0eHqnR9LYcGhkH
 L3QqraBFRDKR4bWkkA16DGDZbGB4bRaMF54rxa0zCNWonVQLjUFV7mAj89ZCFOsKP2V7krUck
 DbM1lI0Ugd/r9BNQ4YOJnszKXUepElyAwRdbMOP39U4lVNL+ck8+raKDLiD64zHu7yiQfeGC8
 lmkzZQ6x7lLHWkqIKML5T53tGTViQlAcUh+j0E4A0E5HXnGVTBb0ThvLYFAO9OczUqfOVKXPE
 /h4DNVbPXcbqdsdZGVUHmrzgH7x65mfpLLNZC4sJomZ5iN6Du9VCulAo0DLbGew0A4S8cV1WS
 ObC5lZBHyUAl6Uimp+t1UmsCsNytn2XlND5Z2BenMwKE4lUpbfE1XXQFe3/Kw+5syMnT4tJVv
 eFaxsT9TpFqvlxXSc0e5uKFasfMEwjhlpSOBl8QV2u6OdK0OI5z//iTKn8kLRBOVLYJjbK1Rj
 sKKqPcMWLMhstI7AYeTQilPkBs5CFv2Yd938T2aYJMu8fzb8jZnNxtxhWl0PES+q0lcOuzieh
 LfujksUwyFwZ1/GUp/L7X0Gajod0HnXL1APLVgEAZO3frsctn/uDG5pLyVetJFX32oyQbrqrI
 0MJ062V7t6TSTseNagg66yz78n+upYqSvWYi/zJ+2e8I7DI/9vXA0w4XitChd397VeYYWXxwu
 6DIdj3W2md5QnA1xvxo5HXXNNSoaVfJ8MZrypxFCXwfz8wucNMH1uIAyKGSslPz4NfRBFmC8u
 ut+h1GFpODXLxrTkeTzrl4Ns0JjlLkmjByRtptGSbTyxOarp8JTapmzEQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/25 =E4=B8=8A=E5=8D=887:15, Zygo Blaxell wrote:
> On Thu, Jul 22, 2021 at 03:54:55PM +0200, David Sterba wrote:
>> On Thu, Jul 22, 2021 at 08:18:21AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/22 =E4=B8=8A=E5=8D=881:44, David Sterba wrote:
>>>> On Fri, Jul 16, 2021 at 11:44:21PM +0100, Jorge Bastos wrote:
>>>>> Hi,
>>>>>
>>>>> This was a single disk filesystem, DUP metadata, and this week it st=
op
>>>>> mounting out of the blue, the data is not a concern since I have a
>>>>> full fs snapshot in another server, just curious why this happened, =
I
>>>>> remember reading that some WD disks have firmware with write caches
>>>>> issues, and I believe this disk is affected:
>>>>>
>>>>> Model family:Western Digital Green
>>>>> Device model:WDC WD20EZRX-00D8PB0
>>>>> Firmware version:80.00A80
>>>>
>>>> For the record summing up the discussion from IRC with Zygo, this
>>>> particular firmware 80.00A80 on WD Green is known to have problematic
>>>> firmware and would explain the observed errors.
>>>>
>>>> Recommendation is not to use WD Green or periodically disable the wri=
te
>>>> cache by 'hdparm -W0'.
>>>
>>> Zygo is always the god to expose bad hardware.
>>>
>>> Can we maintain a list of known bad hardware inside btrfs-wiki?
>>> And maybe escalate it to other fses too?
>>
>> Yeah a list on wiki would be great, though I'm a bit skeptical about
>> keeping it up up to date, there are very few active wiki editors, the
>> knowledge is still mostly stored in the IRC logs. But without a landing
>> page on wiki we can't even start, so I'll create it.
>
> Some points to note:
>
> Most HDD *models* are good (all but 4% of models I've tested, and the
> ones that failed were mostly 8?.00A8?),

That's what we expect.

> but the very few models that
> are bad form a significant portion of drives in use:  they are the cheap
> drives that consumers and OEMs buy millions of every year.
>
> 80.00A80 keeps popping up in parent-transid-verify-failed reports from
> IRC users.  Sometimes also 81.00A81 and 82.00A82 (those two revisions
> appear on some NAS vendor blacklists as well).  I've never seen 83.00A83
> fail--I have some drives with that firmware, and they seem OK, and I
> have not seen any reports about it.

In fact, even just one model number is much better than nothing.

We know nowadays btrfs is even able to detect bitflip, but we don't
really want weird hardware to bring blame which we don't deserve.

>
> 80.00A80 may appear in a lot of low-end WD drive models (here "low end"
> is "anything below Gold and Ultrastar"), marketed under other names like
> White Label, or starring as the unspecified model inside USB external
> drives.
>
> The bad WD firmware has been sold over a period of at least 8 years.
> Retail consumers can buy new drives today with this firmware (the most
> recent instance we found was a WD Blue 1TB if I'm decoding the model
> string correctly).  Even though WD seems to have fixed the bugs years
> ago (in 83.00A83), the bad firmware doesn't die out as hardware ages
> out of the user population because users keep buying new drives with
> the old firmware.
>
> It seems that _any_ HDD might have write cache issues if it is having
> some kind of hardware failure at the same time (e.g. UNC sectors or
> power supply issues).  A failing drive is a failing drive, it might blow
> up a btrfs with dup profile that would otherwise have survived.  It is
> possible that firmware bugs are involved in these cases, but it's hard
> to make a test fleet large enough for meaningful and consistent results.

For such case, I guess smart is enough to tell the drive is failing?
Thus it shouldn't be that a big concern IMHO.

>
> SSDs are a different story:  there are so many models, firmware revision=
s
> are far more diverse, and vendors are still rapidly updating their
> designs, so we never see exactly the same firmware in any two incident
> reports.  A firmware list would be obsolete in days.  There is nothing
> in SSD firmware like the decade-long stability there is in HDD firmware.

Yeah, that's more or less expected.

So we don't need to bother that for now.

Thanks for your awesome info again!
Qu

>
> IRC users report occasional parent-transid-verify-failure or similar
> metadata corruption failures on SSDs, but they don't seem to be repeatab=
le
> with other instances of the same model device.  Samsung dominates the
> SSD problem reports, but Samsung also dominates the consumer SSD market,
> so I think we are just seeing messy-but-normal-for-SSD hardware failures=
,
> not evidence of firmware bugs.
>
> It's also possible that the window for exploiting a powerfail write cach=
e
> bug is much, much shorter for SSD than HDD, so even if the bugs do exist=
,
> the probability of hitting one is negligible.
>
