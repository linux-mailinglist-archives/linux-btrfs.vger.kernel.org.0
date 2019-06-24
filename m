Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A814A4FEBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFXBwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 21:52:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:56905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFXBwu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 21:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561341164;
        bh=uVEfzkpM3RmdSdxcTB3Zlt2Eh7B51J0v7+t89QIUiVc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dgS3+VuTDdgqMEkEFLDgAWv4xI1CF53+dbCknjnE0Kp3ilAVV+6TiURlK6evUZPgC
         xoK/dVeDomEkXzs8yU8eDPOD6eW4+1U5ruA+lNX7QOH6jXbLiPWmdL6XRnCrmHcDC3
         uCENMrbPU+aADuL9Snotxb7jl1uTZ9V+UfaS6bNA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LjZhg-1iGjnV22Ei-00bXaT; Mon, 24
 Jun 2019 02:46:19 +0200
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not
 possible)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20190623204523.GC11831@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
Date:   Mon, 24 Jun 2019 08:46:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190623204523.GC11831@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AmhOlwV1F6h6krLWR08IBpK5IqY1SHkR8"
X-Provags-ID: V03:K1:L4nI1SyUHExr2SAIKv8/UeWnuqAWvDWOgESi14jpXT1yd2CWKhI
 UcYbcHSqAiQ2OcFWUANbx9K+wBIKrak1lz1QF+x9MjFwP6Tw43amy7MFOpBRj2GBkMGaFq8
 2+ynxVn9CyUfzt2Avgs8cE+Ull1jX8yGxomzyfolIA+f8EztqDV0NjNh88GfK9zq7orHsT+
 WT6vj6EwmvpznPr7Mqqvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o7tgMVbBnfY=:3/4Xeqp/Vp6j/Zmknwj66r
 dIzkDGVre7yHd64cXnxmSL5Lrnp8xlsmIakuMVPqZaEiO7oxVPJtaDkLc509Q+lTxA4o4mShH
 Z+HNAzlgvBBiCUjJLErZC1w+FS46HF5l0evU0P0hMpIdtkEW/i21ARrzwyn89up5lrtfJBbmQ
 RjhMgjy6wb+kTk3uhTchlTZfa50MMi59BC14WIUhySqJruAby0n8UbIyVv5zKgE2azWq0YjIw
 FkvtvPa3eIesOc0TdiIuD3sMkl2LGvGQDTb/Y+5rLALjP4PfKfxGwrVal0TzBjdl2hS2SifC4
 8XJ8qsdVlsNcr/iA1G7N8CdwPtdBcj9i+ZkfOKJ+yzt8LlpNyibcF29ix0naNFtUqoJLhUVVa
 PVNRXK+UB1bdBnoHiQSLDRNBQfvHwmT2ov+ZJrRFEWaDUJbYFPrbJMkm/E9zWvPyMveqKhNmo
 PtcmdJg198O/5RhfVIVLSpQeNc6O2y7OeXr+eUkg9oyFLqfpuNNmSoyKQuyAtHO1VDeyoZa24
 zmeJeHTxwuHa8VD3mIZs8A2zdhy+GJ18xrfZNzLw889Pn65PLnEIs77k6lKqF1+G24qILeyO3
 7W0Jh1HKxjbyEwZn39T2oAmkiPtoKgDOCaFkaoh9klkFmeDih6kGpy2L6jXfiZFuYHvMqE2ZR
 xttxv/gYqGVqu1+qKBh17r0mWL5dOpU0rVo27JuzdwQq4M+P5gsPxyX3PJk3AxujPFoFZ0CG0
 HWdAQo9nAtsgSutb19byXeiMD0RZHdyJ90lgIhLoPYbMqTZE/93qzAQvTYpTP0gY44IQI+PFT
 pP0t0Omx04BgcY6VonwAI8zhGD9x64bP0MgyyiUq8GefJPqSJVqEk81thJP95JQNma51SPeNB
 GUOnzwsm2X23B/nNK/zypGJ9U/wSwynP/JhjM20WomRMyJ1IRymqK+2ImV9dLhRbVJHeBgRlP
 BxBGYEFTYnIlp4uX9vqaqQ7luQ0Qag+U=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AmhOlwV1F6h6krLWR08IBpK5IqY1SHkR8
Content-Type: multipart/mixed; boundary="4ooNnT0OoMbJB699YZba3XsJT98xo5fK8";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not
 possible)
References: <20190623204523.GC11831@hungrycats.org>
In-Reply-To: <20190623204523.GC11831@hungrycats.org>

--4ooNnT0OoMbJB699YZba3XsJT98xo5fK8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/24 =E4=B8=8A=E5=8D=884:45, Zygo Blaxell wrote:
> On Thu, Jun 20, 2019 at 01:00:50PM +0800, Qu Wenruo wrote:
>> On 2019/6/20 =E4=B8=8A=E5=8D=887:45, Zygo Blaxell wrote:
>>> On Sun, Jun 16, 2019 at 12:05:21AM +0200, Claudius Winkel wrote:
>>>> What should I do now ... to use btrfs safely? Should i not use it wi=
th
>>>> DM-crypt
>>>
>>> You might need to disable write caching on your drives, i.e. hdparm -=
W0.
>>
>> This is quite troublesome.
>>
>> Disabling write cache normally means performance impact.
>=20
> The drives I've found that need write cache disabled aren't particularl=
y
> fast to begin with, so disabling write cache doesn't harm their
> performance very much.  All the speed gains of write caching are lost
> when someone has to spend time doing a forced restore from backup after=

> transid-verify failure.  If you really do need performance, there are
> drives with working firmware available that don't cost much more.
>=20
>> And disabling it normally would hide the true cause (if it's something=

>> btrfs' fault).
>=20
> This is true; however, even if a hypothetical btrfs bug existed,
> disabling write caching is an immediately deployable workaround, and
> there's currently no other solution other than avoiding drives with
> bad firmware.
>=20
> There could be improvements possible for btrfs to work around bad
> firmware...if someone's willing to donate their sanity to get inside
> the heads of firmware bugs, and can find a way to fix it that doesn't
> make things worse for everyone with working firmware.
>=20
>>> I have a few drives in my collection that don't have working write ca=
che.
>>> They are usually fine, but when otherwise minor failure events occur =
(e.g.
>>> bad cables, bad power supply, failing UNC sectors) then the write cac=
he
>>> doesn't behave correctly, and any filesystem or database on the drive=

>>> gets trashed.
>>
>> Normally this shouldn't be the case, as long as the fs has correct
>> journal and flush/barrier.
>=20
> If you are asking the question:
>=20
>         "Are there some currently shipping retail hard drives that are
>         orders of magnitude more likely to corrupt data after simple
>         power failures than other drives?"
>=20
> then the answer is:
>=20
> 	"Hell, yes!  How could there NOT be?"
>=20
> It wouldn't take very much capital investment or time to find this out
> in lab conditions.  Just kill power every 25 minutes while running a
> btrfs stress-test should do it--or have a UPS hardware failure in ops,
> the effect is the same.  Bad drives will show up in a few hours, good
> drives take much longer--long enough that, statistically, the good driv=
es
> will probably fail outright before btrfs gets corrupted.

Now it sounds like we really need some good (more elegant than just
random power failure, but more controlled system) way to do such test.

>=20
>> If it's really the hardware to blame, then it means its flush/fua is n=
ot
>> implemented properly at all, thus the possibility of a single power lo=
ss
>> leading to corruption should be VERY VERY high.
>=20
> That exactly matches my observations.  Only a few disks fail at all,
> but the ones that do fail do so very often:  60% of corruptions at
> 10 power failures or less, 100% at 30 power failures or more.
>=20
>>>  This isn't normal behavior, but the problem does affect
>>> the default configuration of some popular mid-range drive models from=

>>> top-3 hard disk vendors, so it's quite common.
>>
>> Would you like to share the info and test methodology to determine it'=
s
>> the device to blame? (maybe in another thread)
>=20
> It's basic data mining on operations failure event logs.
>=20
> We track events like filesystem corruption, data loss, other hardware
> failure, operator errors, power failures, system crashes, dmesg error
> messages, etc., and count how many times each failure occurs in systems=

> with which hardware components.  When a failure occurs, we break the
> affected system apart and place its components into other systems or
> test machines to isolate which component is causing the failure (e.g. a=

> failing power supply could create RAM corruption events and disk failur=
e
> events, so we move the hardware around to see where the failure goes).
> If the same component is involved in repeatable failure events, the
> correlation jumps out of the data and we know that component is bad.
> We can also do correlations by attributes of the components, i.e. vendo=
r,
> model, size, firmware revision, manufacturing date, and correlate
> vendor-model-size-firmware to btrfs transid verify failures across
> a fleet of different systems.
>=20
> I can go to the data and get a list of all the drive model and firmware=

> revisions that have been installed in machines with 0 "parent transid
> verify failed" events since 2014, and are still online today:
>=20
>         Device Model: CT240BX500SSD1 Firmware Version: M6CR013
>         Device Model: Crucial_CT1050MX300SSD1 Firmware Version: M0CR060=

>         Device Model: HP SSD S700 Pro 256GB Firmware Version: Q0824G
>         Device Model: INTEL SSDSC2KW256G8 Firmware Version: LHF002C
>         Device Model: KINGSTON SA400S37240G Firmware Version: R0105A
>         Device Model: ST12000VN0007-2GS116 Firmware Version: SC60
>         Device Model: ST5000VN0001-1SF17X Firmware Version: AN02
>         Device Model: ST8000VN0002-1Z8112 Firmware Version: SC61
>         Device Model: TOSHIBA-TR200 Firmware Version: SBFA12.2
>         Device Model: WDC WD121KRYZ-01W0RB0 Firmware Version: 01.01H01
>         Device Model: WDC WDS250G2B0A-00SM50 Firmware Version: X61190WD=

>         Model Family: SandForce Driven SSDs Device Model: KINGSTON SV30=
0S37A240G Firmware Version: 608ABBF0
>         Model Family: Seagate IronWolf Device Model: ST10000VN0004-1ZD1=
01 Firmware Version: SC60
>         Model Family: Seagate NAS HDD Device Model: ST4000VN000-1H4168 =
Firmware Version: SC44
>         Model Family: Seagate NAS HDD Device Model: ST8000VN0002-1Z8112=
 Firmware Version: SC60
>         Model Family: Toshiba 2.5" HDD MK..59GSXP (AF) Device Model: TO=
SHIBA MK3259GSXP Firmware Version: GN003J
>         Model Family: Western Digital Gold Device Model: WDC WD101KRYZ-=
01JPDB0 Firmware Version: 01.01H01
>         Model Family: Western Digital Green Device Model: WDC WD10EZRX-=
00L4HB0 Firmware Version: 01.01A01
>         Model Family: Western Digital Re Device Model: WDC WD2000FYYZ-0=
1UL1B1 Firmware Version: 01.01K02
>         Model Family: Western Digital Red Device Model: WDC WD50EFRX-68=
MYMN1 Firmware Version: 82.00A82
>         Model Family: Western Digital Red Device Model: WDC WD80EFZX-68=
UW8N0 Firmware Version: 83.H0A83
>         Model Family: Western Digital Red Pro Device Model: WDC WD6002F=
FWX-68TZ4N0 Firmware Version: 83.H0A83

At least there are a lot of GOOD disks, what a relief.

>=20
> So far so good.  The above list of drive model-vendor-firmware have
> collectively had hundreds of drive-power-failure events in the last 5
> years, so we have been giving the firmware a fair workout [1].
>=20
> Now let's look for some bad stuff.  How about a list of drives that wer=
e
> involved in parent transid verify failure events occurring within 1-10
> power cycles after mkfs events:
>=20
> 	Model Family: Western Digital Green Device Model: WDC WD20EZRX-00DC0B0=
 Firmware Version: 80.00A80
>=20
> Change the query to 1-30 power cycles, and we get another model with
> the same firmware version string:
>=20
> 	Model Family: Western Digital Red Device Model: WDC WD40EFRX-68WT0N0 F=
irmware Version: 80.00A80
>=20
> Removing the upper bound on power cycle count doesn't find any more.
>=20
> The drives running 80.00A80 are all in fairly similar condition: no err=
ors
> in SMART, the drive was apparently healthy at the time of failure (no
> unusual speed variations, no unexpected drive resets, or any of the oth=
er
> things that happen to these drives as they age and fail, but that are
> not reported as official errors on the models without TLER).  There are=

> multiple transid-verify failures logged in multiple very different host=

> systems (e.g. Intel 1U server in a data center, AMD desktop in an offic=
e,
> hardware ages a few years apart).  This is a consistent and repeatable
> behavior that does not correlate to any other attribute.
>=20
> Now, if you've been reading this far, you might wonder why the previous=

> two ranges were lower-bounded at 1 power cycle, and the reason is becau=
se
> I have another firmware in the data set with _zero_ power cycles betwee=
n
> mkfs and failure:
>=20
> 	Model Family: Western Digital Caviar Black Device Model: WDC WD1002FAE=
X-00Z3A0 Firmware Version: 05.01D05
>=20
> These drives have 0 power fail events between mkfs and "parent transid
> verify failed" events, i.e. it's not necessary to have a power failure
> at all for these drives to unrecoverably corrupt btrfs.  In all cases t=
he
> failure occurs on the same days as "Current Pending Sector" and "Offlin=
e
> UNC sector" SMART events.  The WD Black firmware seems to be OK with wr=
ite
> cache enabled most of the time (there's years in the log data without a=
ny
> transid-verify failures), but the WD Black will drop its write cache wh=
en
> it sees a UNC sector, and btrfs notices the failure a few hours later.
>=20
> Recently I've been asking people on IRC who present btrfs filesystems
> with transid-verify failures (excluding those with obvious symptoms of
> host RAM failure).  So far all the users who have participated in this
> totally unscientific survey have WD Green 2TB and WD Black hard drives
> with the same firmware revisions as above.  The most recent report was
> this week.  I guess there are lot of drives with these firmwares still
> in inventories out there.
>=20
> The data says there's at least 2 firmware versions in the wild which
> have 100% of the btrfs transid-verify failures.  These are only 8%
> of the total fleet of disks in my data set, but they are punching far
> above their weight in terms of failure event count.
>=20
> I first observed these correlations back in 2016.  We had a lot of WD
> Green and Black drives in service at the time--too many to replace or
> upgrade them all early--so I looked for a workaround to force the
> drives to behave properly.  Since it looked like a write ordering issue=
,
> I disabled the write cache on drives with these firmware versions, and
> found that the transid-verify filesystem failures stopped immediately
> (they had been bi-weekly events with write cache enabled).

So the worst scenario really happens in real world, badly implemented
flush/fua from firmware.
Btrfs has no way to fix such low level problem.


BTW, do you have any corruption using the bad drivers (with write cache)
with traditional journal based fs like XFS/EXT4?

Btrfs is relying more the hardware to implement barrier/flush properly,
or CoW can be easily ruined.
If the firmware is only tested (if tested) against such fs, it may be
the problem of the vendor.

>=20
> That was 3 years ago, and there are no new transid-verify failures
> logged since then.  The drives are still online today with filesystems
> mkfsed in 2016.
>=20
> One bias to be aware of from this data set:  it goes back further than =
5
> years, and we use the data to optimize hardware costs including the cos=
t
> of ops failures.  You might notice there are no Seagate Barracudas[2] i=
n
> the data, while there are the similar WD models.  In an unbiased sample=

> of hard drives, there are likely to be more bad firmware revisions than=

> found in this data set.  I found 2, and that's a lower bound on the rea=
l
> number out there.
>=20
>> Your idea on hardware's faulty FLUSH/FUA implementation could definite=
ly
>> cause exactly the same problem, but the last time I asked similar
>> problem to fs-devel, there is no proof for such possibility.
>=20
> Well, correlation isn't proof, it's true; however, if a behavior looks
> like a firmware bug, and quacks like a firmware bug, and is otherwise
> indistinguishable from a firmware bug, then it's probably a firmware bu=
g.
>=20
> I don't know if any of these problems are really device firmware bugs o=
r
> Linux bugs, particularly in the WD Black case.  That's a question for
> someone who can collect some of these devices and do deeper analysis.
>=20
> In particular, my data is not sufficient to rule out either of these tw=
o
> theories for the WD Black:
>=20
> 	1.  Linux doesn't use FLUSH/FUA correctly when there are IO errors
> 	/ drive resets / other things that happen around the times that
> 	drives have bad sectors, but it is OK as long as there are no
> 	cached writes that need to be flushed, or
>=20
> 	2.  It's just a bug in one particular drive firmware revision,
> 	Linux is doing the right thing with FLUSH/FUA and the firmware
> 	is not.
>=20
> For the bad WD Green/Red firmware it's much simpler:  those firmware
> revisions fail while the drive is not showing any symptoms of defects.
> AFAIK there's nothing happening on these drives for Linux code to get
> confused about that doesn't also happen on every other drive firmware.
>=20
> Maybe it's a firmware bug WD already fixed back in 2014, and it just
> takes a decade for all the old drives to work their way through the
> supply chain and service lifetime.
>=20
>> The problem is always a ghost to chase, extra info would greatly help =
us
>> to pin it down.
>=20
> This lack of information is a bit frustrating.  It's not particularly
> hard or expensive to collect this data, but I've had to collect it
> myself because I don't know of any reliable source I could buy it from.=

>=20
> I found two bad firmwares by accident when I wasn't looking for bad
> firmware.  If I'd known where to look, I could have found them much
> faster: I had the necessary failure event observations within a few
> months after starting the first btrfs pilot projects, but I wasn't
> expecting to find firmware bugs, so I didn't recognize them until there=

> were double-digit failure counts.
>=20
> WD Green and Black are low-cost consumer hard drives under $250.
> One drive of each size in both product ranges comes to a total price
> of around $1200 on Amazon.  Lots of end users will have these drives,
> and some of them will want to use btrfs, but some of the drives apparen=
tly
> do not have working write caching.  We should at least know which ones
> those are, maybe make a kernel blacklist to disable the write caching
> feature on some firmware versions by default.

To me, the problem isn't for anyone to test these drivers, but how
convincing the test methodology is and how accessible the test device
would be.

Your statistic has a lot of weight, but it takes you years and tons of
disks to expose it, not something can be reproduced easily.

On the other hand, if we're going to reproduce power failure quickly and
reliably in a lab enivronment, then how?
Software based SATA power cutoff? Or hardware controllable SATA power cab=
le?
And how to make sure it's the flush/fua not implemented properly?

It may take us quite some time to start a similar project (maybe need
extra hardware development).

But indeed, a project to do 3rd-party SATA hard disk testing looks very
interesting for my next year hackweek project.

Thanks,
Qu

>=20
> A modestly funded deliberate search project could build a map of firmwa=
re
> reliability in currently shipping retail hard drives from all three
> big vendors, and keep it updated as new firmware revisions come out.
> Sort of like Backblaze's hard drive reliability stats, except you don't=

> need a thousand drives to test firmware--one or two will suffice most o=
f
> the time [3].  The data can probably be scraped from end user reports
> (if you have enough of them to filter out noise) and existing ops logs
> (better, if their methodology is sound) too.
>=20
>=20
>=20
>> Thanks,
>> Qu
>=20
> [1] Pedants will notice that some of these drive firmwares range in age=

> from 6 months to 7 years, and neither of those numbers is 5 years, and
> the power failure rate is implausibly high for a data center environmen=
t.
> Some of the devices live in offices and laptops, and the power failures=

> are not evenly distributed across the fleet.  It's entirely possible th=
at
> some newer device in the 0-failures list will fail horribly next week.
> Most of the NAS and DC devices and all the SSDs have not had any UNC
> sector events in the fleet yet, and they could still turn out to be
> ticking time bombs like the WD Black once they start to grow sector
> defects.  The data does _not_ say that all of those 0-failure firmwares=

> are bug free under identical conditions--it says that, in a race to
> be the first ever firmware to demonstrate bad behavior, the firmwares
> in the 0-failures list haven't left the starting line yet, while the 2
> firmwares in the multi-failures list both seem to be trying to _win_.
>=20
> [2] We had a few surviving Seagate Barracudas in 2016, but over 85% of
> those built before 2015 had failed by 2016, and none of the survivors
> are still online today.  In practical terms, it doesn't matter if a
> pre-2015 Barracuda has correct power-failing write-cache behavior when
> the drive hardware typically dies more often than the host's office has=

> power interruptions.
>=20
> [3] OK, maybe it IS hard to find WD Black drives to test at the _exact_=

> moment they are remapping UNC sectors...tap one gently with a hammer,
> maybe, or poke a hole in the air filter to let a bit of dust in?
>=20
>>> After turning off write caching, btrfs can keep running on these prob=
lem
>>> drive models until they get too old and broken to spin up any more.
>>> With write caching turned on, these drive models will eat a btrfs eve=
ry
>>> few months.
>>>
>>>
>>>> Or even use ZFS instead...
>>>>
>>>> Am 11/06/2019 um 15:02 schrieb Qu Wenruo:
>>>>>
>>>>> On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
>>>>>> HI Guys,
>>>>>>
>>>>>> you are my last try. I was so happy to use BTRFS but now i really =
hate
>>>>>> it....
>>>>>>
>>>>>>
>>>>>> Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC=
 2019
>>>>>> x86_64 x86_64 x86_64 GNU/Linux
>>>>>> btrfs-progs v4.15.1
>>>>> So old kernel and old progs.
>>>>>
>>>>>> btrfs fi show
>>>>>> Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS byt=
es used 4.58TiB
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0=
 1 size 7.28TiB used 4.59TiB path /dev/mapper/volume1
>>>>>>
>>>>>>
>>>>>> dmesg
>>>>>>
>>>>>> [57501.267526] BTRFS info (device dm-5): trying to use backup root=
 at
>>>>>> mount time
>>>>>> [57501.267528] BTRFS info (device dm-5): disk space caching is ena=
bled
>>>>>> [57501.267529] BTRFS info (device dm-5): has skinny extents
>>>>>> [57507.511830] BTRFS error (device dm-5): parent transid verify fa=
iled
>>>>>> on 2069131051008 wanted 4240 found 5115
>>>>> Some metadata CoW is not recorded correctly.
>>>>>
>>>>> Hopes you didn't every try any btrfs check --repair|--init-* or any=
thing
>>>>> other than --readonly.
>>>>> As there is a long exiting bug in btrfs-progs which could cause sim=
ilar
>>>>> corruption.
>>>>>
>>>>>
>>>>>
>>>>>> [57507.518764] BTRFS error (device dm-5): parent transid verify fa=
iled
>>>>>> on 2069131051008 wanted 4240 found 5115
>>>>>> [57507.519265] BTRFS error (device dm-5): failed to read block gro=
ups: -5
>>>>>> [57507.605939] BTRFS error (device dm-5): open_ctree failed
>>>>>>
>>>>>>
>>>>>> btrfs check /dev/mapper/volume1
>>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
>>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
>>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
>>>>>> parent transid verify failed on 2069131051008 wanted 4240 found 51=
15
>>>>>> Ignoring transid failure
>>>>>> extent buffer leak: start 2024985772032 len 16384
>>>>>> ERROR: cannot open file system
>>>>>>
>>>>>>
>>>>>>
>>>>>> im not able to mount it anymore.
>>>>>>
>>>>>>
>>>>>> I found the drive in RO the other day and realized somthing was wr=
ong
>>>>>> ... i did a reboot and now i cant mount anmyore
>>>>> Btrfs extent tree must has been corrupted at that time.
>>>>>
>>>>> Full recovery back to fully RW mountable fs doesn't look possible.
>>>>> As metadata CoW is completely screwed up in this case.
>>>>>
>>>>> Either you could use btrfs-restore to try to restore the data into
>>>>> another location.
>>>>>
>>>>> Or try my kernel branch:
>>>>> https://github.com/adam900710/linux/tree/rescue_options
>>>>>
>>>>> It's an older branch based on v5.1-rc4.
>>>>> But it has some extra new mount options.
>>>>> For your case, you need to compile the kernel, then mount it with "=
-o
>>>>> ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".
>>>>>
>>>>> If it mounts (as RO), then do all your salvage.
>>>>> It should be a faster than btrfs-restore, and you can use all your
>>>>> regular tool to backup.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> any help
>>
>=20
>=20
>=20


--4ooNnT0OoMbJB699YZba3XsJT98xo5fK8--

--AmhOlwV1F6h6krLWR08IBpK5IqY1SHkR8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0QHU4ACgkQwj2R86El
/qiXpgf+OOewT65hs/LJgjT3GQ/4U5auHh9zKaVMTpirOFbIS8uJIMo0U3Hrgyh4
VWuRYYCB0/O6tSbv7AdrqmdUlJFTjmLE6IG6NV1vsdnTA5tsxGnD7ZhP85f9n0TE
/rlEQ3rb3rnPbfSCRJilH7vNCDqEL42aMw+GUOJVbYE9LL534DGJf2ujtY7cyH0t
uUU37Jou0e8YyBVD8MCzuvxz0THuoxj2jJ0f+faM5AJSX1iFkd9XksLeydYpgXdW
t1jr+h967jxJf6tyCP+Bu9G8VCouwQHaXQZKQAVDDQw+WfwcDVTa9OvopjZ3spbJ
/bzSIxgLbyppXmqOL4vthIz+0yDeQw==
=3kkP
-----END PGP SIGNATURE-----

--AmhOlwV1F6h6krLWR08IBpK5IqY1SHkR8--
