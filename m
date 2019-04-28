Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E39BD9FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 01:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfD1XyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Apr 2019 19:54:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:42057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfD1XyA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Apr 2019 19:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556495636;
        bh=wEuGU/gFvseOIYRvIDyghB8bSmy2MjOdJxV9GNke8+g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XaD72uOpHcXdHLFByjF7+5Q2olmkXR36dRJt64EYce4QRRvvooG/Zg/yp9u57k4I3
         uxTHihqayR1EHIt2IbL8gMtSD+XkI6nREmSBW9qVgf710FGHm5K2/uCJogNZTv71x3
         QZoZxsBwlSUJ0/ZhG9mO/u2w52yQRbi3Kq9HZ+vA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LtJ5T-1gezNo0JVT-012nHZ; Mon, 29
 Apr 2019 01:53:56 +0200
Subject: Re: btrfs and write barriers
To:     Hendrik Friedel <hendrik@friedels.name>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <emae84cb43-e9f5-41a7-8a47-efca08cea36e@laptophendrik>
 <05127205-0d35-1028-559e-66ba2b1dcea1@gmx.com>
 <em07dd5637-7710-4eaa-8659-8d8eef1fc709@ryzen>
 <9e438df4-f477-9aac-103b-fea479caacc9@gmail.com>
 <emf90f6f49-9542-47ad-aad7-7ed271887782@ryzen>
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
Message-ID: <aa8774cd-d337-b527-c6ec-72c4495ad9d9@gmx.com>
Date:   Mon, 29 Apr 2019 07:53:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <emf90f6f49-9542-47ad-aad7-7ed271887782@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aKVffSzYPh22Yj7xBDilhmGX4oWKEkCQr"
X-Provags-ID: V03:K1:51NAL/mXXuRrwp9UPM7EzNWc53hBL1U7SWNv68TQsP05D3wYLoN
 k0Qs7PYJ0zvLIMnLCBlTQRgGsBTXJ5M5FE/HQnu6WwHIAaIVGQ2Tof6+zehUj5OYeu34wD7
 kYRk+FaMiptRQRUe25f8odFWKB3nm2X6xTk9a/jHypKi4GbpUAMkVW2foPBOWBs4ANM0g14
 Xr+wIKtHaXLbbJr68dJhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnPtEkV5T+A=:D11BjixMqOACA/1Z2/bI7E
 kQ6c9DPtLUUbwFbVN+j8xMgXO9O/oh6Re72JZmMxYWwdILD0ec2xCjmgBGimRnZXB2T41EMwU
 XmMHGn12rSMg2YKWMh499G5lHXXBA81I5xwiA+/s8T18LgRDwPdg5CuCrAWSwTlEZS0+bf4te
 KvvM/BZ0DSi+7VPfobRjcaj+yqlA4ARcPSRt5gfpmjzpvfcjAxTskLsNXJtzR2taD+7FOak5y
 N2uGoBufkuOuNJFVupSnfuRbVYDSEL56sZYdP9z1S2r6I1D4OZgeABQZ++yRJ8G27+R17aQVB
 R56A25eDkAhYjsA2ZPRzpXuTvkyulzeq/+j6OXBy9tqISD6TMNPa1UP5WQWfZO/DD2pNbDyQc
 MisgtYDxGqoJyC5SAjUvZUG1a3d0XB5gP0tSdtEtu20UaEPhRbEDDgSFY/nok7Qe4kAj6/1p1
 MyWqtpEFKWK9k4w/kCD9qXOcagx3vQVIZdJCSeqDOHuY7Z4rVQv1kqkuv9jkMyxFt0ajcSkZ2
 OjTOmLmF/V/zzNiJWGZ06oFa/W23B+FR8TOxwBzX95YvZmGhKA3DEaxxYeTsqvJGhNWjF7Pyf
 MDYGNWBH4TL1o6li1lKTv2BOHV+9x2re4VXS+QuArQ2kN4jOxNTLlVKmKG923dstzB/ipc/D7
 i9TH3437KkMP5w2sQgz9Bm2hWq49z/dbm7gHHefqq/IIMNtE5/2iOHDB/kQdrmFQ8vNdfiL77
 9hN1C7nH8eo0+zI9qoT7U/C5HmWYJe4FUbDlLyITozXWUHP7UOG3h57VMFF1DVMQGcapHAizs
 fORMyL3TppN341vjLTSuoNtJQwjLxNS5fOsA5jkhF0VjgqiZ0dCYaP47T2m3MJzNEaZ/bnHqR
 Nkn64j51MjzWAjsbO8QoBZfseT8rbmarYWXG8GTytMtmlnii6WfZ2seKU3D7zj
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aKVffSzYPh22Yj7xBDilhmGX4oWKEkCQr
Content-Type: multipart/mixed; boundary="bFVbgzOuTgp0eWioNLn45xla9FuMlJRtf";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Hendrik Friedel <hendrik@friedels.name>,
 "Austin S. Hemmelgarn" <ahferroin7@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <aa8774cd-d337-b527-c6ec-72c4495ad9d9@gmx.com>
Subject: Re: btrfs and write barriers
References: <emae84cb43-e9f5-41a7-8a47-efca08cea36e@laptophendrik>
 <05127205-0d35-1028-559e-66ba2b1dcea1@gmx.com>
 <em07dd5637-7710-4eaa-8659-8d8eef1fc709@ryzen>
 <9e438df4-f477-9aac-103b-fea479caacc9@gmail.com>
 <emf90f6f49-9542-47ad-aad7-7ed271887782@ryzen>
In-Reply-To: <emf90f6f49-9542-47ad-aad7-7ed271887782@ryzen>

--bFVbgzOuTgp0eWioNLn45xla9FuMlJRtf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/4/29 =E4=B8=8A=E5=8D=883:27, Hendrik Friedel wrote:
> Hello,
> thanks for your reply.
>=20
>>>3) Even more, it would be good, if btrfs would disable the write cache=

>>> in that case, so that one does not need to rely on the user
>>
>>Personally speaking, if user really believes it's write cache causing
>>the problem or want to be extra safe, then they should disable cache.
> How many percent of the users will be able to judge that?
>=20
>>As long as FLUSH is implemented without problem, the only faulty part i=
s
>>btrfs itself and I haven't found any proof of either yet.
> But you have searched?
>=20
>>>2) I find the location of the (only?) warning -dmesg- well hidden. I
> think it would be better to notify the user when creating the file-syst=
em.
>>A notification on creating the volume and ones when adding devices
> (either via `device add` or via a replace operation)
>>would indeed be nice, but we should still keep the kernel log warning.
>=20
> Ok, so what would be the way to move forward on that? Would it help if =
I
> create an issue in a https://bugzilla.kernel.org/ ?

No need. See comment below.

>=20
>>>3) Even more, it would be good, if btrfs would disable the write cache=

> in that case, so that one does not need to rely on the user
>> I would tend to disagree here. We should definitely _recommend_ this
> to the user if we know there is no barrier support, but just
>> doing it behind their back is not a good idea.
>=20
> Well, there is some room between 'automatic' and 'behind their back. E.=
g.
> "Barriers are not supported by /dev/sda. Automatically disabling
> write-cache on mount. You can suppress this with the
> 'enable-cache-despite-no-barrier-support-I-know-what-I-am-doing' mount
> option (maybe, we can shorten the option).

There is no problem using write cache as long as the device supports
flush. SATA/NVME protocol specified all devices should support flush.

As long as flush is supported, fua can be emulated.
Thus write cache is not a problem at all, as long as flush is
implemented correctly.

>=20
>> There are also plenty of valid reasons to want to use the write cache
> anyway.
>=20
> I cannot think of one. Who would sacrifice data integrity/potential
> total loss of the filesystem for speed?

No data integrity is lost, and performance is greatly improved with
write cache.

Thanks,
Qu
>=20
>> As far as FUA/DPO, I know of exactly _zero_ devices that lie about
> implementing it and don't.
> ...
>> but the fact that Linux used to not issue a FLUSH command to the disks=

> when you called fsync in userspace.
>=20
> Ok, thanks for that clarification.
>=20
>=20
> Greetings,
> Hendrik
>=20
> ------ Originalnachricht ------
> Von: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
> An: "Hendrik Friedel" <hendrik@friedels.name>; "Qu Wenruo"
> <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
> Gesendet: 03.04.2019 20:44:09
> Betreff: Re: btrfs and write barriers
>=20
>> On 2019-04-03 14:17, Hendrik Friedel wrote:
>>> Hello,
>>>
>>> thanks for your reply.
>>>
>>>>> 3) Even more, it would be good, if btrfs would disable the write ca=
che
>>>>> in that case, so that one does not need to rely on the user
>>>> Personally speaking, if user really believes it's write cache causin=
g
>>>> the problem or want to be extra safe, then they should disable cache=
=2E
>>> How many percent of the users will be able to judge that?
>>>> As long as FLUSH is implemented without problem, the only faulty
>>>> part is
>>>> btrfs itself and I haven't found any proof of either yet.
>>> But you have searched?
>>>
>>> =C2=A0>>2) I find the location of the (only?) warning -dmesg- well hi=
dden.
>>> I think it would be better to notify the user when creating the
>>> file-system.
>>> =C2=A0>A notification on creating the volume and ones when adding dev=
ices
>>> (either via `device add` or via a replace operation)
>>> =C2=A0>would indeed be nice, but we should still keep the kernel log =
warning.
>>>
>>> Ok, so what would be the way to move forward on that? Would it help
>>> if I create an issue in a https://bugzilla.kernel.org/ ?
>> The biggest issue is actually figuring out if the devices don't
>> support write barriers (which means no FLUSH or broken FLUSH on Linux,=

>> not no FUA/DPO, because as long as the device properly implements
>> FLUSH (and most do), Linux will provide a FUA emulation which works
>> for write barriers).=C2=A0 Once you've got that, it should be pretty
>> trivial to add to the messages.
>>>
>>> =C2=A0>>3) Even more, it would be good, if btrfs would disable the wr=
ite
>>> cache in that case, so that one does not need to rely on the user
>>> =C2=A0> I would tend to disagree here. We should definitely _recommen=
d_
>>> this to the user if we know there is no barrier support, but just
>>> =C2=A0> doing it behind their back is not a good idea.
>>>
>>> Well, there is some room between 'automatic' and 'behind their back.
>>> E.g.
>>> "Barriers are not supported by /dev/sda. Automatically disabling
>>> write-cache on mount. You can suppress this with the
>>> 'enable-cache-despite-no-barrier-support-I-know-what-I-am-doing'
>>> mount option (maybe, we can shorten the option).
>> And that's still 'behind the back' because it's a layering violation.
>> Even LVM and MD don't do this, and they have even worse issues than we=

>> do because they aren't CoW.
>>>
>>> =C2=A0> There are also plenty of valid reasons to want to use the wri=
te
>>> cache anyway.
>>> I cannot think of one. Who would sacrifice data integrity/potential
>>> total loss of the filesystem for speed?
>> There are quite a few cases where the risk of data loss _just doesn't
>> matter_, and any data that could be invalid is also inherently stale.
>> Some trivial examples:
>>
>> * /run on any modern Linux system. Primarily contains sockets used by
>> running services, PID files for daemons, and other similar things that=

>> only matter for the duration of the current boot of the system. These
>> days, it's usually in-memory, but some people with really tight memory=

>> constraints still use persistent storage for it to save memory.
>> * /tmp on any sane UNIX system. Similar case to above, but usually for=

>> stuff that only matters on the scale of session lifetimes, or even
>> just process lifetimes.
>> * /var/tmp on most Linux systems. Usually the same case as /tmp.
>> * /var/cache on any sane UNIX system. By definition, if the data here
>> is lost, it doesn't matter, as it only exists for performance reasons
>> anyway. Smart applications will even validate the files they put here,=

>> so corruption isn't an issue either.
>>
>> There are bunches of other examples I could list, but all of them are
>> far more situational and application specific.
>>>
>>> =C2=A0> As far as FUA/DPO, I know of exactly _zero_ devices that lie =
about
>>> implementing it and don't.
>>> ...
>>> =C2=A0> but the fact that Linux used to not issue a FLUSH command to =
the
>>> disks when you called fsync in userspace.
>>> Ok, thanks for that clarification.
>=20


--bFVbgzOuTgp0eWioNLn45xla9FuMlJRtf--

--aKVffSzYPh22Yj7xBDilhmGX4oWKEkCQr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzGPQ0ACgkQwj2R86El
/qhJBggAqvV++WNYlb/xSqmiT7Ywg3velM5L/HiczhlHuHkMGMwleB/GZgzdUQ8o
h2OpZQDZy/pffwHcG54fgbSLOZ32Xp/odlzcF7CMh/Y9+nDEjwFEkmOsDxGJw3h4
y2ZqGAwxXBySd1QmtLPpZf4pNPncsdLPq460Agag69GXF6HBeZDuFsuzkLsqZ6ii
5+Kr89SAVnFM6OGCVd8vTe06yK2QpptTyLGl326Xm6IU409Mijp1ASiZcaVx3GBY
A2GJqT54bIsrMWq/l4m2PtcXDcencJWx+pcWXymLX6d6fxgWDggClEazTt5wwcaB
cYD/cDmPTyCvpXj0ieKHKPS9ysyhUw==
=AL1w
-----END PGP SIGNATURE-----

--aKVffSzYPh22Yj7xBDilhmGX4oWKEkCQr--
