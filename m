Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31019D4B4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgDCKMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 06:12:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:50389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgDCKMG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 06:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585908718;
        bh=FNujXfGNriZYjs2XhEkagdlwD9Payvc0s5lt10oKbfo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d6AWU6NEhLTiWzVxdKg3xHeVdwOQBB4+2yq1+H+77+oAV1GujQSEHNYJuPKLqnWxz
         IBJJeUzuqNDmzt0Sv1yIJG40AgMcEp1hWhMlR/iWIuVbKWtIc/HR/uDZY0DYz9AUN1
         pFh/g4HJERY/aBDO3gr5vhm6hFehdLH2rFgSt6Ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0JW-1iwH4v3Pku-00kMwu; Fri, 03
 Apr 2020 12:11:58 +0200
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
 <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com>
 <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
 <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com>
 <CAL3q7H7GXpnaK-jPQybi3PfoMJtr7gJQ0tha9fYG-he0vrzdXw@mail.gmail.com>
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
Message-ID: <fb1a7773-8166-6ed5-8a63-d3ec86e1a70c@gmx.com>
Date:   Fri, 3 Apr 2020 18:11:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7GXpnaK-jPQybi3PfoMJtr7gJQ0tha9fYG-he0vrzdXw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6hQuMaX9Fn0axeGzlEuHCQ2Kw1C4V66do"
X-Provags-ID: V03:K1:vZkR2GZlhRT85xjq6pCAFDknaIZqEUE5LYudRMkmwNxbWbgnxBc
 kDZv8zGUmeJa4rDZHISnO9NjTssrlIsVranej/fcEui696oEGPjwjLGxe80PN0KwoC6cTHA
 uqxk2tKMpf2tx7Pi84ULiKueQieWTh3k6/3qObtkt23+09CUT54iosoVCEKIRcqq7QOBMBm
 moCQCuFx3UVavNoEn0Lsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iX4woaUlr+E=:JZtfCOYJxrPjToTpQe7dSv
 jcLUiyjGSYE27o0SIUmlyCTOZDVrr+ZXChwdPZjsO+2pfu/lXeo3xXDTMqO9g/Ca0vqwRYqwN
 7ul+JMBzqja/XtIHZDjEC3XCo9viFetsUvdU5lc4j/n/nPAZA1aOpZmBuWicCD7xjx6yjTU7z
 2ksCcxU8eEaUFcykLJaYfTVlXQI68Jyo9vurCd573b1J0f7aT6wz7LfhJOzszoBHn+NKDd5MU
 STC0YugXotbwtSc5QILFqQ0C40sXNxDc9AujTaP90ExxLl58RzxH2YDfJiOqrpUJG27mi/L00
 dJ7xHoodceYAhhs9zIWgWAdz6E9TtlRogAh5k98a7OxBjkBdq0WpWco7DwhTHZ6yYYU7gfmqp
 LRyQCvQpgrDsC3LB6FXMG5kvXAnLuS0Rx18kylTwC0aQdkvpFeHxynxfvRoXp4HL63OJIiM3B
 i3KdcqDla1CdJl9tlYZo3BkWJw5L/FtdQ8fw+TPcL5S5udTsRZt4HJMYF9NwEO6pO1jmwk4E0
 p6Ah3cKcOjxo0wwjWITXR0z0GKQrjrbxWMO97SYMuwXI4ch42USJnsAJE/niKGKtoqjpQn8yR
 quOI01JRgseJqCt3lfstkilGUHet7sjQ2oQKtnGiyPKS+4oG7XnRPSp8opehtL8yNGDSg9LwL
 OB578S++9wnMrLzn1LTscWn7WhgrNRSSnJLoaXbwV704X9znUXXsD+Y3DhBnz5+9ZbmoMa6fa
 JhZllzzaPPsgFjXxrIXFEg4kQwU2ByUtn5Z5/Xu1u7xm+eqwBp1pw4Dxo4Z+qNBH+adws9brf
 c999l4KNEkwsd9mn9TFDrc5G57DHMpvGmCfTb2z4Na3rRNsQFSv5y9Vb2Y4i6aSGwjlbo/eve
 43/nBWCyBfSUJcq7qe4ADfvl+OA7ZNnKdo2zbhWATPx8XvZP23Tca/WiwWqXGvwOvT///ranD
 kLcj2RBp8mwJ+whbvqgdvKcE1rH9CqGgQlEPnMhZZii2pAOcEKza8aIcOReZiQc6L19Mv8jCn
 xE7n+v+7MRlB2sFZx5bZ3sC2cB5AEitDtBg7127FEhqI/UxSM6qOs66j0kQBXIQrJuxjueMTJ
 oIdfF3g6HZLvm1rUdgaFmbj0fFgjXHniNl5IT1YL+rI0E6hWOi/Jh/+kgWFJM7d/98VpFfLzg
 LbdJvZfcyWgXjOL9kOZN5XlbUQORnI7eYP+zwQ3AUgimzhhR7pNnb6Yp/d6pWjcqBz/5hdBuO
 JYrKpF13f0Lh+XKhs
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6hQuMaX9Fn0axeGzlEuHCQ2Kw1C4V66do
Content-Type: multipart/mixed; boundary="rNOSJYYEOUdls7Toji4WSlZAQQwnZBVXS"

--rNOSJYYEOUdls7Toji4WSlZAQQwnZBVXS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/3 =E4=B8=8B=E5=8D=886:04, Filipe Manana wrote:
> On Fri, Apr 3, 2020 at 1:00 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/4/2 =E4=B8=8B=E5=8D=889:26, Filipe Manana wrote:
>>> On Thu, Apr 2, 2020 at 1:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/4/2 =E4=B8=8B=E5=8D=888:33, Filipe Manana wrote:
>>>>> On Thu, Apr 2, 2020 at 12:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2020/4/2 =E4=B8=8B=E5=8D=887:08, Filipe Manana wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Recently I was looking at why the test case btrfs/125 from fstest=
s often fails.
>>>>>>> Typically when it fails we have something like the following in d=
mesg/syslog:
>>>>>>>
>>>>>>>  (...)
>>>>>>>  BTRFS error (device sdc): space cache generation (7) does not ma=
tch inode (9)
>>>>>>>  BTRFS warning (device sdc): failed to load free space cache for =
block
>>>>>>> group 38797312, rebuilding it now
>>>>>>>  BTRFS info (device sdc): balance: start -d -m -s
>>>>>>>  BTRFS info (device sdc): relocating block group 754581504 flags =
data|raid5
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39059456 ha=
ve 0
>>>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 3905945=
6
>>>>>>> (dev /dev/sde sector 18688)
>>>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 3906355=
2
>>>>>>> (dev /dev/sde sector 18696)
>>>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 3906764=
8
>>>>>>> (dev /dev/sde sector 18704)
>>>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 3907174=
4
>>>>>>> (dev /dev/sde sector 18712)
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376=
256
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380=
352
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445=
888
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384=
448
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388=
544
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392=
640
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396=
736
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400=
832
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404=
928
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409=
024
>>>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>>>  BTRFS info (device sdc): read error corrected: ino 257 off 13803=
52
>>>>>>> (dev /dev/sde sector 718728)
>>>>>>>  BTRFS info (device sdc): read error corrected: ino 257 off 13762=
56
>>>>>>> (dev /dev/sde sector 718720)
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 ha=
ve 0
>>>>>>>  BTRFS info (device sdc): balance: ended with status: -5
>>>>>>>  (...)
>>>>>>>
>>>>>>> So I finally looked into it to figure out why that happens.
>>>>>>>
>>>>>>> Consider the following scenario and steps that explain how we end=
 up
>>>>>>> with a metadata extent
>>>>>>> permanently corrupt and unrecoverable (when it shouldn't be possi=
ble).
>>>>>>>
>>>>>>> * We have a RAID5 filesystem consisting of three devices, with de=
vice
>>>>>>> IDs of 1, 2 and 3;
>>>>>>>
>>>>>>> * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
>>>>>>>
>>>>>>> * We have a single metadata block group that starts at logical of=
fset
>>>>>>> 38797312 and has a
>>>>>>>   length of 715784192 bytes.
>>>>>>>
>>>>>>> The following steps lead to a permanent corruption of a metadata =
extent:
>>>>>>>
>>>>>>> 1) We make device 3 unavailable and mount the filesystem in degra=
ded
>>>>>>> mode, so only
>>>>>>>    devices 1 and 2 are online;
>>>>>>>
>>>>>>> 2) We allocate a new extent buffer with logical address of 390430=
72, this falls
>>>>>>>    within the full stripe that starts at logical address 38928384=
, which is
>>>>>>>    composed of 3 stripes, each with a size of 64Kb:
>>>>>>>
>>>>>>>    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
>>>>>>> stripe 3, offset 39059456 ]
>>>>>>>    (the offsets are logical addresses)
>>>>>>>
>>>>>>>    stripe 1 is in device 2
>>>>>>>    stripe 2 is in device 3
>>>>>>>    stripe 3 is in device 1  (this is the parity stripe)
>>>>>>>
>>>>>>>    Our extent buffer 39043072 falls into stripe 2, starting at pa=
ge
>>>>>>> with index 12
>>>>>>>    of that stripe and ending at page with index 15;
>>>>>>>
>>>>>>> 3) When writing the new extent buffer at address 39043072 we obvi=
ously
>>>>>>> don't write
>>>>>>>    the second stripe since device 3 is missing and we are in degr=
aded
>>>>>>> mode. We write
>>>>>>>    only the stripes for devices 1 and 2, which are enough to reco=
ver
>>>>>>> stripe 2 content
>>>>>>>    when it's needed to read it (by XORing stripes 1 and 3, we pro=
duce
>>>>>>> the correct
>>>>>>>    content of stripe 2);
>>>>>>>
>>>>>>> 4) We unmount the filesystem;
>>>>>>>
>>>>>>> 5) We make device 3 available and then mount the filesystem in
>>>>>>> non-degraded mode;
>>>>>>>
>>>>>>> 6) Due to some write operation (such as relocation like btrfs/125=

>>>>>>> does), we allocate
>>>>>>>    a new extent buffer at logical address 38993920. This belongs =
to
>>>>>>> the same full
>>>>>>>    stripe as the extent buffer we allocated before in degraded mo=
de (39043072),
>>>>>>>    and it's mapped to stripe 2 of that full stripe as well,
>>>>>>> corresponding to page
>>>>>>>    indexes from 0 to 3 of that stripe;
>>>>>>>
>>>>>>> 7) When we do the actual write of this stripe, because it's a par=
tial
>>>>>>> stripe write
>>>>>>>    (we aren't writing to all the pages of all the stripes of the =
full
>>>>>>> stripe), we
>>>>>>>    need to read the remaining pages of stripe 2 (page indexes fro=
m 4 to 15) and
>>>>>>>    all the pages of stripe 1 from disk in order to compute the co=
ntent for the
>>>>>>>    parity stripe. So we submit bios to read those pages from the =
corresponding
>>>>>>>    devices (we do this at raid56.c:raid56_rmw_stripe()). The prob=
lem is that we
>>>>>>>    assume whatever we read from the devices is valid - in this ca=
se what we read
>>>>>>>    from device 3, to which stripe 2 is mapped, is invalid since i=
n the degraded
>>>>>>>    mount we haven't written extent buffer 39043072 to it - so we =
get
>>>>>>> garbage from
>>>>>>>    that device (either a stale extent, a bunch of zeroes due to t=
rim/discard or
>>>>>>>    anything completely random). Then we compute the content for t=
he
>>>>>>> parity stripe
>>>>>>>    based on that invalid content we read from device 3 and write =
the
>>>>>>> parity stripe
>>>>>>>    (and the other two stripes) to disk;
>>>>>>>
>>>>>>> 8) We later try to read extent buffer 39043072 (the one we alloca=
ted while in
>>>>>>>    degraded mode), but what we get from device 3 is invalid (this=
 extent buffer
>>>>>>>    belongs to a stripe of device 3, remember step 2), so
>>>>>>> btree_read_extent_buffer_pages()
>>>>>>>    triggers a recovery attempt - this happens through:
>>>>>>>
>>>>>>>    btree_read_extent_buffer_pages() -> read_extent_buffer_pages()=
 ->
>>>>>>>      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_=
bio() ->
>>>>>>>        -> raid56_parity_recover()
>>>>>>>
>>>>>>>    This attempts to rebuild stripe 2 based on stripe 1 and stripe=
 3 (the parity
>>>>>>>    stripe) by XORing the content of these last two. However the p=
arity
>>>>>>> stripe was
>>>>>>>    recomputed at step 7 using invalid content from device 3 for s=
tripe 2, so the
>>>>>>>    rebuilt stripe 2 still has invalid content for the extent buff=
er 39043072.
>>>>>>>
>>>>>>> This results in the impossibility to recover an extent buffer and=

>>>>>>> getting permanent
>>>>>>> metadata corruption. If the read of the extent buffer 39043072
>>>>>>> happened before the
>>>>>>> write of extent buffer 38993920, we would have been able to recov=
er it since the
>>>>>>> parity stripe reflected correct content, it matched what was writ=
ten in degraded
>>>>>>> mode at steps 2 and 3.
>>>>>>>
>>>>>>> The same type of issue happens for data extents as well.
>>>>>>>
>>>>>>> Since the stripe size is currently fixed at 64Kb, the issue doesn=
't happen only
>>>>>>> if the node size and sector size are 64Kb (systems with a 64Kb pa=
ge size).
>>>>>>>
>>>>>>> And we don't need to do writes in degraded mode and then mount in=
 non-degraded
>>>>>>> mode with the previously missing device for this to happen (I gav=
e the example
>>>>>>> of degraded mode because that's what btrfs/125 exercises).
>>>>>>
>>>>>> This also means, other raid5/6 implementations are also affected b=
y the
>>>>>> same problem, right?
>>>>>
>>>>> If so, that makes them less useful as well.
>>>>> For all the other raid modes we support, which use mirrors, we don'=
t
>>>>> have this problem. If one copy is corrupt, we are able to recover i=
t,
>>>>> period.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Any scenario where the on disk content for an extent changed (som=
e bit flips for
>>>>>>> example) can result in a permanently unrecoverable metadata or da=
ta extent if we
>>>>>>> have the bad luck of having a partial stripe write happen before =
an attempt to
>>>>>>> read and recover a corrupt extent in the same stripe.
>>>>>>>
>>>>>>> Zygo had a report some months ago where he experienced this as we=
ll:
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungry=
cats.org/
>>>>>>>
>>>>>>> Haven't tried his script to reproduce, but it's very likely it's =
due to this
>>>>>>> issue caused by partial stripe writes before reads and recovery a=
ttempts.
>>>>>>>
>>>>>>> This is a problem that has been around since raid5/6 support was =
added, and it
>>>>>>> seems to me it's something that was not thought about in the init=
ial design.
>>>>>>>
>>>>>>> The validation/check of an extent (both metadata and data) happen=
s at a higher
>>>>>>> layer than the raid5/6 layer, and it's the higher layer that orde=
rs the lower
>>>>>>> layer (raid56.{c,h}) to attempt recover/repair after it reads an =
extent that
>>>>>>> fails validation.
>>>>>>>
>>>>>>> I'm not seeing a reasonable way to fix this at the moment, initia=
l thoughts all
>>>>>>> imply:
>>>>>>>
>>>>>>> 1) Attempts to validate all extents of a stripe before doing a pa=
rtial write,
>>>>>>> which not only would be a performance killer and terribly complex=
, ut would
>>>>>>> also be very messy to organize this in respect to proper layering=
 of
>>>>>>> responsabilities;
>>>>>>
>>>>>> Yes, this means raid56 layer will rely on extent tree to do
>>>>>> verification, and too complex.
>>>>>>
>>>>>> Not really worthy to me too.
>>>>>>
>>>>>>>
>>>>>>> 2) Maybe changing the allocator to work in a special way for raid=
5/6 such that
>>>>>>> it never allocates an extent from a stripe that already has exten=
ts that were
>>>>>>> allocated by past transactions. However data extent allocation is=
 currently
>>>>>>> done without holding a transaction open (and forgood reasons) dur=
ing
>>>>>>> writeback. Would need more thought to see how viable it is, but n=
ot trivial
>>>>>>> either.
>>>>>>>
>>>>>>> Any thoughts? Perhaps someone else was already aware of this prob=
lem and
>>>>>>> had thought about this before. Josef?
>>>>>>
>>>>>> What about using sector size as device stripe size?
>>>>>
>>>>> Unfortunately that wouldn't work as well.
>>>>>
>>>>> Say you have stripe 1 with a corrupt metadata extent. Then you do a=

>>>>> write to a metadata extent located at stripe 2 - this partial write=

>>>>> (because it doesn't cover all stripes of the full stripe), will rea=
d
>>>>> the pages from the first stripe and assume they are all good, and t=
hen
>>>>> use those for computing the parity stripe - based on a corrupt exte=
nt
>>>>> as well. Same problem I described, but this time the corrupt extent=
 is
>>>>> in a different stripe of the same full stripe.
>>>>
>>>> Yep, I also recognized that problem after some time.
>>>>
>>>> Another possible solution is, always write 0 bytes for pinned extent=
s
>>>> (I'm only thinking metadata yet).
>>>>
>>>> This means, at transaction commit time, we also need to write 0 for
>>>> pinned extents before next transaction starts.
>>>
>>> I'm assuming you mean to write zeroes to pinned extents when unpinnin=
g
>>> them- after writing the superblock of the committing transaction.
>>
>> So the timing of unpinning them would also need to be changed.
>>
>> As mentioned, it needs to be before starting next transaction.
>=20
> That would be terrible for performance.
> Any operation that needs to start a transaction would block until the
> current transaction finishes its commit, which means waiting for a lot
> of IO.
> Would bring terrible stalls to applications - most operations need to
> start/join a transaction - create file, symlink, link, unlink, rename,
> clone/dedupe, mkdir, rmdir, mknod, truncate, create/delete snapshot,
> etc etc etc.

Exactly.

>=20
>>
>> Anyway, my point is, if we ensure all unwritten data contains certain
>> pattern (for metadata), then we can at least use them to detect out of=

>> sync full stripe.
>=20
> That would also cause extra IO to be done if the device doesn't
> support trim/discard, as we would to have to write the zeroes.

And even for trim supported device, there is no guarantee that read on
trimmed range would return 0.
So that zero write is unavoidable.

>=20
> Sadly, it wouldn't solve the data extents case.

And the zero write is in fact a compromise to make raid56 to do
verification work without looking up extent tree.

It trades tons of IO, just to get some bool info about if there are any
extents in the partial stripes of the full stripe.

So this crazy idea lends more towards extent tree lookup in raid56 layer.=

(And now I think it's less crazy to do extent tree lookup now)

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> Thanks,
>> Qu
>>
>>> But
>>> way before that, the next transaction may have already started, and
>>> metadata and data writes may have already started as well, think of
>>> fsync() or writepages() being called by the vm due to memory pressure=

>>> for example (or page migration, etc).
>>>
>>>> This needs some extra work, and will definite re-do a lot of parity
>>>> re-calculation, which would definitely affect performance.
>>>>
>>>> So for a new partial write, before we write the new stripe, we read =
the
>>>> remaining data stripes (which we already need) and the parity stripe=

>>>> (the new thing).
>>>>
>>>> We do the rebuild, if the rebuild result is all zero, then it means =
the
>>>> full stripe is OK, we do regular write.
>>>>
>>>> If the rebuild result is not all zero, it means the full stripe is n=
ot
>>>> consistent, do some repair before write the partial stripe.
>>>>
>>>> However this only works for metadata, and metadata is never all 0, s=
o
>>>> all zero page can be an indicator.
>>>>
>>>> How this crazy idea looks?
>>>
>>> Extremely crazy :/
>>> I don't see how it would work due to the above comment.
>>>
>>> thanks
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> It would make metadata scrubbing suffer, and would cause performan=
ce
>>>>>> problems I guess, but it looks a little more feasible.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>=20
>=20


--rNOSJYYEOUdls7Toji4WSlZAQQwnZBVXS--

--6hQuMaX9Fn0axeGzlEuHCQ2Kw1C4V66do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6HC+oACgkQwj2R86El
/qgu+Qf9F6kD1Wq5aESH9iMWIm9LHmvzRP27xI8KzV2UPwyiqsrHH1UopZ/vDLXC
RUGDjbC3IV6p8CODaiGaO8qdbKZKIZkE3TC7p2qRhRXxjcsv3gT7NsPZLYn4tuAl
kqijkW9lgPn7KlUKWjHHLTR3SqinOO/wdYrktztIyMtuLmg9fOTO9TkkfbxMALbZ
jdaMOB5X5Egdxrr4ApFSdavmYHM82DPazJxNuneYgX0jKLTJmahvy6dSRJrenS1z
mggN/5nReX93LW4us7TcHfkjW6aU3R23R5OE0W+B+M7NdOmv69fdqQMMFEINrJS1
YoFUyvhlhPIgP+NhTmeDH8Mqoeh45w==
=6DtZ
-----END PGP SIGNATURE-----

--6hQuMaX9Fn0axeGzlEuHCQ2Kw1C4V66do--
