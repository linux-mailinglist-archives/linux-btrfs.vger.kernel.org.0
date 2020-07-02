Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EECB2125FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgGBOTn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:19:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:38359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOTm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593699578;
        bh=huyYk6x/VuhVm/66yBszxJ9/3mcCLrVXzHQjLF1COOM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TwRGSpTrESXKBpOHQ+UkbZXJmvG3raWs37nmxnyhRIMmliceTnFW2coQ2EsmB5Eol
         9G34AHecS0xAUJg6FzR9aA7/5/Pkq0UYeZS9a3FXXCLLOIPiQb6vYuIf/OXU3G0W0L
         uK1r7IN9AJ5ToP8sOFuLbZA+V9U6q25d/0Npl/gI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1jDYlv3MQ7-00egAH; Thu, 02
 Jul 2020 16:19:37 +0200
Subject: Re: [PATCH 2/3] btrfs: qgroup: Try to flush qgroup space when we get
 -EDQUOT
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-3-wqu@suse.com>
 <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
 <f4f0e752-0166-538d-7376-17f7fefe44f2@gmx.com>
 <5ff3b488-d82a-fbc3-97d4-8b85cacab1c9@toxicpanda.com>
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
Message-ID: <16eb0345-6469-de3e-e091-43c75bc918bb@gmx.com>
Date:   Thu, 2 Jul 2020 22:19:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5ff3b488-d82a-fbc3-97d4-8b85cacab1c9@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MByfSyF8MAB8s9s56vDVwhFrDfiDs7yDd"
X-Provags-ID: V03:K1:ZCcAieNgG3Ce4XgSJKYqNcC08YajzWx01kCKUcAVeCzW7K+V/DX
 eOioAWKm5rGNIZDW7sQ/tF3p7lEdrIjG+VKUtYz+5AT9/rf7R/cbxjyU+wHYU/b4AOjD1MM
 ZK+DaIHCU5wWyavGbR7NeR5d0udFu7nMffCnfLXYJkMQAbeLr1fCzXPvTL89RJ9mPVBa1gg
 qr0KekSBfe8JmheUW/4aA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ydzvldzFhIo=:9TQ0KHCxVWsHNFFnahnQCU
 mvR5dSIKvqA8tF9znNWFOAOKYmPyAiSD984RxKPBnkZpNnZCZJi9AQ9qX+oozi1UDfesOxCdg
 9bqfkfXtpNg+Q4lq8GT2XGp8QVaRNlRuoAlY4uivtbJ6nlp+xZCL3SEwHqM4kBzrogyrIhMW1
 cEclB6Cin2VeEPTq+iygrtdKqlNMBskwqbfAvwXeueQq7gKlAr4PlFvqqhn9wvQrDCHPtGIxR
 H/wRocgq24R/gWSGGEPlIN8XTgJ8Lgi0RzRYmFWMhabjIKn+LXJTw3kebF9d9dO/xiXUZDof+
 q3Vm3FsYAa2FHODBwxV0di3wpZj0GCtRqaHaoebGpZadq/k6HFl8lAD6nSTjRl5XbCiorM03R
 JoB7U4l6cA7TrwmauvPFf0XGJPiASqhgHnEFqcIlFwnEG4O9l/hA5zXgPKZ1QAY+I/420gjPD
 WmIYXyKDiUE1oVLbEK9dvIaj+6vW4XqXhTlgIPdMkn0kYDUrh1hRkUXoZ6Op/5lY5QIeunrsu
 oyJqo77/VK8clEbshlvBOOu6dqPYY80S0E6UbOpRwszo+DFlJkh4X1crT/R8KFw1Ef6LzLZjl
 BbmTguDmTFUUI1M/PMoJNSvXXFYtNh4eOaI39GInq9nIu0joQcWtS0EP7JlGrKYypiFov87sb
 ZpFvdD5hGTWj5SCTTIOnSuKxeqX0XYE8ySJRHgVtO0Fo01zWSXjwGvAqQkwfpLearJ+y02/+P
 ChG2tNP4uzNO/rI1HPx7Vpb8oARXDVSMPEKtpvm150JyuSLfjW6QnIVU+n/DBYJo7LR76X8lb
 ppOPTmjnNJmkYJeFmUvWH9QycVkADRF2vMFBNr+ZKu8FIcJrdIcYmC8rCE1ahJFrdTtloBCYQ
 Zn9zKpx8HXNVK2EGKID3DaUyefxznZsGthGuQO+uYHleQsFX1CjiKZPRxY2TEGcwqCzipqcdd
 pdPfZS8/XevWJG3b5Gojapj5yuUSkTTQ5Ve1AD9HpuRWjQ7SqdDTqpFE5G8+tW2YeT+Oc5Mi7
 9+N6XZBXC8TrrZ1uBMxIW43O+ronrBvp47QEiecm9jesUy7eysolq880JchQg9HdTRuaZnmZ7
 wrVa2FIETcPk/ar/MDqEbjl089ahXJdZGPwYu14Zidz9Ye+S/d9Xx3rGMNECP32CDPdk9IEGy
 cgwI+Re/vX3gg3k6HDT0vPXJFwM92MEY2I8NJBOxnasD6zgWUQLDZ6vKUHT5IM2B3LELtvEa4
 1t5OutdFzWrzTefi7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MByfSyF8MAB8s9s56vDVwhFrDfiDs7yDd
Content-Type: multipart/mixed; boundary="T2ycKhBvOV3Eg2kxtTaOCsLJlW0QJBUl0"

--T2ycKhBvOV3Eg2kxtTaOCsLJlW0QJBUl0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=889:57, Josef Bacik wrote:
> On 7/2/20 9:54 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/2 =E4=B8=8B=E5=8D=889:43, Josef Bacik wrote:
>>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>>> [PROBLEM]
>>>> There are known problem related to how btrfs handles qgroup reserved=

>>>> space.
>>>> One of the most obvious case is the the test case btrfs/153, which d=
o
>>>> fallocate, then write into the preallocated range.
>>>>
>>>> =C2=A0=C2=A0=C2=A0 btrfs/153 1s ... - output mismatch (see
>>>> xfstests-dev/results//btrfs/153.out.bad)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/153.out=C2=
=A0=C2=A0=C2=A0=C2=A0 2019-10-22 15:18:14.068965341 +0800
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results/=
/btrfs/153.out.bad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2020-07-01
>>>> 20:24:40.730000089 +0800
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,2 +1,5 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created b=
y 153
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +pwrite: Disk quota excee=
ded
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +/mnt/scratch/testfile2: =
Disk quota exceeded
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +/mnt/scratch/testfile2: =
Disk quota exceeded
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Silence is golden
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-de=
v/tests/btrfs/153.out
>>>> xfstests-dev/results//btrfs/153.out.bad'=C2=A0 to see the entire dif=
f)
>>>>
>>>> [CAUSE]
>>>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we ha=
ve
>>>> to"),
>>>> we always reserve space no matter if it's COW or not.
>>>>
>>>> Such behavior change is mostly for performance, and reverting it is =
not
>>>> a good idea anyway.
>>>>
>>>> For preallcoated extent, we reserve qgroup data space for it already=
,
>>>> and since we also reserve data space for qgroup at buffered write ti=
me,
>>>> it needs twice the space for us to write into preallocated space.
>>>>
>>>> This leads to the -EDQUOT in buffered write routine.
>>>>
>>>> And we can't follow the same solution, unlike data/meta space check,=

>>>> qgroup reserved space is shared between data/meta.
>>>> The EDQUOT can happen at the metadata reservation, so doing NODATACO=
W
>>>> check after qgroup reservation failure is not a solution.
>>>
>>> Why not?=C2=A0 I get that we don't know for sure how we failed, but i=
n the
>>> case of a write we're way more likely to have failed for data reasons=

>>> right?
>>
>> Nope, mostly we failed at metadata reservation, as that would return
>> EDQUOT to user space.
>>
>> We may have some cases which get EDQUOT at data reservation part, but
>> that's what we excepted.
>> (And already what we're doing)
>>
>> The problem is when the metadata reservation failed with EDQUOT.
>>
>>> =C2=A0=C2=A0 So why not just fall back to the NODATACOW check and the=
n do the
>>> metadata reservation. Then if it fails again you know its a real EDQU=
OT
>>> and your done.
>>>
>>> Or if you want to get super fancy you could even break up the metadat=
a
>>> and data reservations here so that we only fall through to the NODATA=
COW
>>> check if we fail the data reservation.=C2=A0 Thanks,
>>
>> The problem is, qgroup doesn't split metadata and data (yet).
>> Currently data and meta shares the same limit.
>>
>> So when we hit EDQUOT, you have no guarantee it would happen only in
>> qgroup data reservation.
>>
>=20
> Sure, but if you are able to do the nocow thing, then presumably your
> quota reservation is less now?=C2=A0 So on failure you go do the compli=
cated
> nocow check, and if it succeeds you retry your quota reservation with
> just the metadata portion, right?=C2=A0 Thanks,

Then metadata portion can still fail, even we skipped the data reserv.

The metadata portion still needs some space, while the data rsv skip
only happens after we're already near the qgroup limit, which means
there are ready not much space left.

Consider this case, we have 128M limit, we fallocated 120M, then we have
dirtied 7M data, plus several kilo for metadata reserved.

Then at the next 1M, we run out of qgroup limit, at whatever position.
Even we skip current 4K for data, the next metadata reserve may still
not be met, and still got EDQUOT at metadata reserve.

Or some other open() calls to create a new file would just get EDQUOT,
without any way to free any extra space.


Instead of try to skip just several 4K for qgroup data rsv, we should
flush the existing 7M, to free at least 7M data + several kilo meta space=
=2E

Thanks,
Qu

>=20
> Josef


--T2ycKhBvOV3Eg2kxtTaOCsLJlW0QJBUl0--

--MByfSyF8MAB8s9s56vDVwhFrDfiDs7yDd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl797PUACgkQwj2R86El
/qjdDggArKwR/6s7HR/OCxcrQEPx8oVMcdxlSol148KokGt/OqdQNh/nVlvBifIK
HF8J7VnGTq792GC5MetbsZ3E+h4eoqK/D1cFilRpGYcp8XsQMfrXXc5JKw81IU8S
BaFjHULfO3hCiiRC//mCqyXoOB5LwOepwAOvfdPIlN+CK68kCht3JjC9+LK1fqra
WwMwC3CEVIV+3WUDs8S+x7AL5muKrOJHRTDjlOuLfEDV7YAeagzocvDyWldiLNpg
NQp4GZeOiAGpyH9+wW9xQ7oQb8jl1o6tU/vgJArBcRXxPzf2RLpEJItSYOWBhCHV
fuw9Lgks7KIjOCIHMzyagPaNPNm3EA==
=95X8
-----END PGP SIGNATURE-----

--MByfSyF8MAB8s9s56vDVwhFrDfiDs7yDd--
