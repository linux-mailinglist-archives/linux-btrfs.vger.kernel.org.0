Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8FE21302B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 01:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGBXg2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 19:36:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:36433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBXg1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 19:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593732981;
        bh=UXE/vjRjjRcxSehl8H5I0y2c3kQ7cgOB4/37UtBbB+8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZuCewcVQh1FKnBxo7v2oUYzz0Ok2qAwSMjXnxHgRIu3FS4U9ijQzyd6iQ2H/HD4Hp
         i33YxNoV10vWt7OCgrZ+YNz2yxFRmZu9FCrBMLTr0yR+OXur5K2TcGGt3PdM0ejPvq
         A4DcrmRUIDpbGaptmLZoL/Voaar8aivECFkY9dF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1jW9xR0c72-00Kziu; Fri, 03
 Jul 2020 01:36:21 +0200
Subject: Re: [PATCH 2/3] btrfs: qgroup: Try to flush qgroup space when we get
 -EDQUOT
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-3-wqu@suse.com>
 <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
 <f4f0e752-0166-538d-7376-17f7fefe44f2@gmx.com>
 <5ff3b488-d82a-fbc3-97d4-8b85cacab1c9@toxicpanda.com>
 <16eb0345-6469-de3e-e091-43c75bc918bb@gmx.com>
 <a32444a5-f965-c2d5-ca4b-c2365fba106c@toxicpanda.com>
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
Message-ID: <daa7f868-b8a4-fd79-7140-c1f8ff1f32a4@gmx.com>
Date:   Fri, 3 Jul 2020 07:36:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a32444a5-f965-c2d5-ca4b-c2365fba106c@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kYqGKyBqVZzDCqJcwGHqWBrnQyzp7TEHp"
X-Provags-ID: V03:K1:tocuYoANArHIHRJT2RSSTeHNlZlP44jQnu7D/ltwMhsGKdMB5jh
 +n8NHU/jkkWlfOJ2kesT4nOXvUG/ypDr6EPsorspUYs/uPILMIz3CH2Y6wFdsjfjEWHF4ZM
 Z/ByB++nfhaT/+xMdXXrhud77R6lt7JJdeLQ/qA6QkTmY26qBtkQ4Cf2J47ST5Klo8BngSF
 xkeWJgPxJazySqXCs3xqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9m932GEW/A=:FaLn4pFhgVR1t/UTZ9k4rl
 uUEPIaNoZDRlAEOWCGUwTV+Nkch8okiEzr7a5qxohrRDoVRszy+CZ2iVMbq2v3RE9kSOnn5I/
 n+U3u8G1U8N1u7RZzO3ZLCxEevzw9tZFp340cI8cO6RToGkvmpEfMRoJ8PA4imKZfSqr4A786
 0idwDqOz15tBYGC0Z5SUruOOMeg/mga+E+oaEmh/Czx8n2/PpubVshxNuS57sqom6ShV6AtT6
 nGiM0kyBK19A8t467NGPd/qmg1RrRvyuRDMLRqK0dsIYCakY5lqLz2XsuQfwdVAlNxibYwQxA
 zQBtuQduN6rc7jML9oLmc/R7KYqiqfhGt+7T1TxUDIgkAIyHNeAs2KpjGLai0gpRAkDLGJJEb
 DuNzjJNBG9VdUxfSYs0wlHxG+3pB1TAR4cpI5yCnn3hbmEhlNvsCxD9meVjeydjAZaM1xk1om
 16ZGPeabmOJ48AoTchUL52TzY4Z4nRNrglCiZiF4Yq2LcGeJ0MgVT6Jj+j4+7VKYFiNfW1TcE
 w1H8nt3W4MtVODHnk4td5EREi5pbMUtxyHeSYCrOym/GQnCHp58aq80PCa58JjvfZhM8AIEBB
 XRkQfVaJp6kTXoLaZyGfAJteAz1/v+GPK1GzZfJW5KwX4JMtDfogq4b7tJGD841FJKZOh+Ckr
 4vodgnobWj5e2lXoRTKTUnn+/1pRnbfZ06gkc4mzYSSCNDBwzl7YlUXk6hjSpaDxjA0JC1mTb
 V5QcdjErqKiXVt7+WFfjPwtsqzMgRALYKk7+3VkEgF/eyZ4OcC0S1EGoXZhEpYQPvgX6mngR5
 Ljq3BT1iCVcPmpJz9WrcSpbQW5Xk2seSU1BmzBtnZiKm58mh8tm4JPlkKH9/FiAnMuk6lgdP4
 eDt0jWELY9MuFoCroag4gEGbwyFQE9GUY7ti4qxqvEHAxuSAvzuhhpdRl+wGgCyCvKqJiaAYl
 k1ioEaSiDiYdf7rQpdTTL3FerjDtYbfPxr/OF1eAWM6wimfc8YGj20R9fSezfKbWoxHIEdpzr
 Tg1CzTNEITJ8qya0U1Zt7PiJrdl0NDf71jRkos4Am/NIHAKFdpECe2px4/jyN8diHxIdBb20O
 kaHGLXkoe9bxxQcfOr1VsHzthNGS0NN+yUtO5ptyzvbxbP/1D779wLGtbOXXW9M1qa49KbSl9
 m1NGYipcHws2gPgL0MberVpcVoO/9KjXj/izi2p3MAJPejnufrw3wgApoGgvuqSvONCWHlD6H
 TJp54s4mQ1cArIoqyYZcAAKxaPRjpxHKBG4GAfg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kYqGKyBqVZzDCqJcwGHqWBrnQyzp7TEHp
Content-Type: multipart/mixed; boundary="KRmhumUCGlri4fG5ofZwrhgLMYbcewsKm"

--KRmhumUCGlri4fG5ofZwrhgLMYbcewsKm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=8810:58, Josef Bacik wrote:
> On 7/2/20 10:19 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/2 =E4=B8=8B=E5=8D=889:57, Josef Bacik wrote:
>>> On 7/2/20 9:54 AM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/7/2 =E4=B8=8B=E5=8D=889:43, Josef Bacik wrote:
>>>>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>>>>> [PROBLEM]
>>>>>> There are known problem related to how btrfs handles qgroup reserv=
ed
>>>>>> space.
>>>>>> One of the most obvious case is the the test case btrfs/153, which=
 do
>>>>>> fallocate, then write into the preallocated range.
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs/153 1s ... - output mismatch (see
>>>>>> xfstests-dev/results//btrfs/153.out.bad)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/1=
53.out=C2=A0=C2=A0=C2=A0=C2=A0 2019-10-22 15:18:14.068965341
>>>>>> +0800
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +++ xfstests-dev/=
results//btrfs/153.out.bad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2020-07-01
>>>>>> 20:24:40.730000089 +0800
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,2 +1,5 @@
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output c=
reated by 153
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +pwrite: Disk quo=
ta exceeded
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +/mnt/scratch/tes=
tfile2: Disk quota exceeded
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +/mnt/scratch/tes=
tfile2: Disk quota exceeded
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Silence is =
golden
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u xfs=
tests-dev/tests/btrfs/153.out
>>>>>> xfstests-dev/results//btrfs/153.out.bad'=C2=A0 to see the entire d=
iff)
>>>>>>
>>>>>> [CAUSE]
>>>>>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we
>>>>>> have
>>>>>> to"),
>>>>>> we always reserve space no matter if it's COW or not.
>>>>>>
>>>>>> Such behavior change is mostly for performance, and reverting it
>>>>>> is not
>>>>>> a good idea anyway.
>>>>>>
>>>>>> For preallcoated extent, we reserve qgroup data space for it alrea=
dy,
>>>>>> and since we also reserve data space for qgroup at buffered write
>>>>>> time,
>>>>>> it needs twice the space for us to write into preallocated space.
>>>>>>
>>>>>> This leads to the -EDQUOT in buffered write routine.
>>>>>>
>>>>>> And we can't follow the same solution, unlike data/meta space chec=
k,
>>>>>> qgroup reserved space is shared between data/meta.
>>>>>> The EDQUOT can happen at the metadata reservation, so doing NODATA=
COW
>>>>>> check after qgroup reservation failure is not a solution.
>>>>>
>>>>> Why not?=C2=A0 I get that we don't know for sure how we failed, but=
 in the
>>>>> case of a write we're way more likely to have failed for data reaso=
ns
>>>>> right?
>>>>
>>>> Nope, mostly we failed at metadata reservation, as that would return=

>>>> EDQUOT to user space.
>>>>
>>>> We may have some cases which get EDQUOT at data reservation part, bu=
t
>>>> that's what we excepted.
>>>> (And already what we're doing)
>>>>
>>>> The problem is when the metadata reservation failed with EDQUOT.
>>>>
>>>>> =C2=A0=C2=A0=C2=A0 So why not just fall back to the NODATACOW check=
 and then do the
>>>>> metadata reservation. Then if it fails again you know its a real
>>>>> EDQUOT
>>>>> and your done.
>>>>>
>>>>> Or if you want to get super fancy you could even break up the metad=
ata
>>>>> and data reservations here so that we only fall through to the
>>>>> NODATACOW
>>>>> check if we fail the data reservation.=C2=A0 Thanks,
>>>>
>>>> The problem is, qgroup doesn't split metadata and data (yet).
>>>> Currently data and meta shares the same limit.
>>>>
>>>> So when we hit EDQUOT, you have no guarantee it would happen only in=

>>>> qgroup data reservation.
>>>>
>>>
>>> Sure, but if you are able to do the nocow thing, then presumably your=

>>> quota reservation is less now?=C2=A0 So on failure you go do the comp=
licated
>>> nocow check, and if it succeeds you retry your quota reservation with=

>>> just the metadata portion, right?=C2=A0 Thanks,
>>
>> Then metadata portion can still fail, even we skipped the data reserv.=

>>
>> The metadata portion still needs some space, while the data rsv skip
>> only happens after we're already near the qgroup limit, which means
>> there are ready not much space left.
>>
>> Consider this case, we have 128M limit, we fallocated 120M, then we ha=
ve
>> dirtied 7M data, plus several kilo for metadata reserved.
>>
>> Then at the next 1M, we run out of qgroup limit, at whatever position.=

>> Even we skip current 4K for data, the next metadata reserve may still
>> not be met, and still got EDQUOT at metadata reserve.
>>
>> Or some other open() calls to create a new file would just get EDQUOT,=

>> without any way to free any extra space.
>>
>>
>> Instead of try to skip just several 4K for qgroup data rsv, we should
>> flush the existing 7M, to free at least 7M data + several kilo meta
>> space.
>>
>=20
> Right so I'm not against flushing in general, I just think that we can
> greatly improve on this particular problem without flushing.=C2=A0 Chan=
ging
> how we do the NOCOW check with quota could be faster than doing the
> flushing.

Yep, but as mentioned, the uncertain timing of when we get the EDQUOT is
really annoying and tricky to solve, thus have to go the flushing method.=


The performance is definitely slower, but it's not acceptable, since
we're near the limiting, slowing down is pretty common.

>=20
> Now as for the flushing part itself, I'd rather hook into the existing
> flushing infrastructure we have.

That's the ultimate objective.

>=C2=A0 Obviously the ticketing is going to be
> different, but the flushing part is still the same, and with data
> reservations now moved over to that infrastructure we finally have it
> all in the same place.=C2=A0 Thanks,

Before the needed infrastructure get merged, I'll keep the current small
retry code and look into what's needed to integrate qgroup rsv into the
ticketing system.

Thanks,
Qu

>=20
> Josef


--KRmhumUCGlri4fG5ofZwrhgLMYbcewsKm--

--kYqGKyBqVZzDCqJcwGHqWBrnQyzp7TEHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7+b3IACgkQwj2R86El
/qgPVQf/df7eL4DI/avRMqW8v/fyRvOK2d39xHAYo2F5zIgvIJVdmGa5jWkkkTgQ
TnJ8X+osdSlCId97n3q2ncQGW/rd/i+XWG0EAsiM4DWcvCC0MRwgurchPy1JWwC4
H3a2AjOt5F/4l/qRkIPQhkIledIDIXZhoFnwiJD7iyyuYsAACv28gaSVFexyy/Om
1fmN903wVVMFkITds0eGUKisRiG9eMDj1T8f5uQ9dblo5Sqg2L85MJxQd9+Te/ko
tHt08UZwvmLo7qsSVYQcz1wL9YdnToo9u/ratmpe1rLEVrlP6lkPFDliKO4WTOd2
ZLh3NrX49cgucEqcPKkv/SE4zaFk3w==
=JUcr
-----END PGP SIGNATURE-----

--kYqGKyBqVZzDCqJcwGHqWBrnQyzp7TEHp--
