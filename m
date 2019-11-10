Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D299F67EC
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 08:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfKJHp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 02:45:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:54997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfKJHp2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 02:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573371918;
        bh=2inww00bXhYQcrjvBmtxi2xIrcHjDzP/pl2Z9mh8ao0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k9G2pfgAQSSAxYaAfdmfEyOqVXJHodiXo/ziN9AsTkGwSxrwMYXZqMSFgekS4YSoT
         9wGBwvFn+MVC9kPu65jPGQqC2GwyhD0k1E0uSx4MK0o8WsclwySq7ROnk2VJc+GOA+
         UVB7V4FEWEJ2Q/bZc27VhODVsx+nWUnjmpLbSgA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDj4-1id6dn1fEk-00CkDy; Sun, 10
 Nov 2019 08:45:18 +0100
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
 <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
 <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
 <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com>
 <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
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
Message-ID: <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com>
Date:   Sun, 10 Nov 2019 15:45:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lF3MYNuRTFmD5ThH4cjbKMOB7Z3sDwhsC"
X-Provags-ID: V03:K1:+KIPDxoRF5M5zst82k6Z6t/SzbJ6JJrHIy0qld4Ygc5eJsoM6EE
 Hoa3SN5oH14kqRttZ4suojBpvVnf7PsnWB2f7GoyOtrMqGT8ZUhgVvzHWytbXs+pErJI3ES
 QzS8Qc98XcPMQqt9adjyaepyXhBnSz3Qm/zQhzdhDQxVspTQ+pcwxPA31A0dydoGKiPz2Fh
 dSsDauxxgCh36lWVP4dmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8H52WVw2MSA=:oV+p6FsziZ3UkHuinktNTo
 X4bRI9qfTIPb2yyeKSe1/BhPFEZMbJ9XR4+eew3d81+p+Fs97nR5C/OsgCUWhfKHtiTuWo+3K
 5Cbt1XhsjKSnNDpay8+ezKbGd0jLmITvgFHqR1IFK6wzq0lpC1rCKW6wm1iOyUEROQeJwTp1e
 BdRu1OpaFnVf1S7SB93YkETARzGr4xUAkQ2x0XKsF+63ZMtqG6haI2ypZzEzJQvifz2X4BIJs
 5ZggbaMJOsamXGEM5+EDrV8qbiCPKklaY1APSGBxuBGuPS0FiE+7CXwh5+wQWop/0M0SShzuy
 zaTby5REJkNMj+RYK9k1pyPAyE2M6Emb+iWhVyZRIalcp5iwafDkVFtnzbK75EXIDc901fIgg
 zmqpxd1hq+JaIxj4HIvhJvh6DO8WcARwVZs8QNxaZP/9juIuqllKieuiU2Bk6BmX/Ygq8Dync
 dgd2ypnMHLEC103RY+hJpnWNWrurYw2qGDLskbZzJwevCUlp3bxWYlt3TanI0rDwZ3aSKkcsB
 cqQY34/0D7jjmq6zqLOU2lXCq++AuVZ7OdGcwgdxwCBJavvM1zxPrJGTDzYXyV3I+nKu2dn94
 N45K6cPjduYYpW53E3O/cEysdke/JPk0BkOEUr55iO4lbBtCJZ5/Hlc/WLCHL2wWS7ZNMQccQ
 LTs+KOzJVPjd7UMW9RU8rcPm8M8qfImn3tqFaMc2OZmGeJ7cfJVcs1GRVCp6fMQjD71flMtk+
 HKG+9AYET7r6QBmGO+0aVDl+0rcwX+bjH4mPa5iX2N9uWPpWUPw34myiD+BzaxWH81FVI0sDM
 YkGk4GJiUY11zR5iEGMNjqHgMGLl+x59nRw1YChD+HNGA4hByvnKYwi3NtH2GFaBbMEvdvqnE
 ZT9lz/EqM6//PNvWigVsBfOVzqKh5UPV3KXM6/W0XjjV81Jrp1LlY96euo0YWfvftrX5WN3su
 NTotKCy6raLU2WIcQ5vdJ9tIve9l2iSvM/HolWVaWN/5Bk5e2fbzxBRhGFGJgfsrPgx3KC3x5
 rjlxMPj78VvyCRV4G8VgGflyvkllJFtEo32Wzz2/WW+oYhpKhG1TkvoKxPKfvx0XSDsGy9Lnm
 osEEy1B/bStiRZrzQM5VFxdSzhcbU7S1MDb5b5BKfZGVkCBsnxrzs66Ty5ekhWJ+hnnbDZRdk
 +YccIUaW90zn/1LB+Y0ZEvJh+gvViYce3RO7Fq3h5l/oNpgjyftGsgxJXvSM0NO9jeZJRoIej
 16Xl2YULESIH2jD7dLR4K1M1CIRJvN4yO4SASRZYxpg11zdoA4BpC0yDDTqw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lF3MYNuRTFmD5ThH4cjbKMOB7Z3sDwhsC
Content-Type: multipart/mixed; boundary="TuemGRn68Pryz37l8rv4CYc4XdOtBYYpM"

--TuemGRn68Pryz37l8rv4CYc4XdOtBYYpM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/10 =E4=B8=8B=E5=8D=883:18, Timothy Pearson wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
>> Sent: Sunday, November 10, 2019 6:54:55 AM
>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>=20
>> On 2019/11/10 =E4=B8=8B=E5=8D=882:47, Timothy Pearson wrote:
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrfs=
"
>>>> <linux-btrfs@vger.kernel.org>
>>>> Sent: Saturday, November 9, 2019 9:38:21 PM
>>>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>>>
>>>> On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
>>>>> We just experienced a very unusual crash on a Linux 5.3 file server=
 using NFS to
>>>>> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no =
apparent
>>>>> underlying disk subsystem problems, and when the server was hard re=
booted to
>>>>> clear the D wait the BTRFS filesystem remounted itself in the state=
 that it was
>>>>> in approximately two weeks earlier (!).
>>>>
>>>> This means during two weeks, the btrfs is not committed.
>>>
>>> Is there any hope of getting the data from that interval back via btr=
fs-recover
>>> or a similar tool, or does the lack of commit mean the data was store=
d in RAM
>>> only and is therefore gone after the server reboot?
>>
>> If it's deadlock preventing new transaction to be committed, then no
>> metadata is even written back to disk, so no way to recover metadata.
>> Maybe you can find some data written, but without metadata it makes no=

>> sense.
>=20
> OK, I'll just assume the data written in that window is unrecoverable a=
t this point then.
>=20
> Would the commit deadlock affect only one btrfs filesystem or all of th=
em on the machine?  I take it there is no automatic dmesg spew on extende=
d deadlock?  dmesg was completely clean at the time of the fault / reboot=
=2E

It should have some kernel message for things like process hang for over
120s.
If you could recover that, it would help us to locate the cause.

Normally such deadlock should only affect the unlucky fs which meets the
condition, not all filesystems.
But if you're unlucky enough, it may happen to other filesystems.

Anyway, without enough info, it's really hard to say.

>=20
>>>
>>> If the latter, I'm somewhat surprised given the I/O load on the disk =
array in
>>> question, but it would also offer a clue as to why it hard locked the=

>>> filesystem eventually (presumably on memory exhaustion -- the server =
has
>>> something like 128GB of RAM, so it could go quite a while before hitt=
ing the
>>> physical RAM limits).
>>>
>>>>
>>>>>  There was also significant corruption of certain files (e.g. LDAP =
MDB and MySQL
>>>>>  InnoDB) noted -- we restored from backup for those files, but are =
concerned
>>>>>  about the status of the entire filesystem at this point.
>>>>
>>>> Btrfs check is needed to ensure no metadata corruption.
>>>>
>>>> Also, we need sysrq+w output to determine where we are deadlocking.
>>>> Otherwise, it's really hard to find any clue from the report.
>>>
>>> It would have been gathered if we'd known the filesystem was in this =
bad state.
>>> At the time, the priority was on restoring service and we had assumed=
 NFS had
>>> just wedged itself (again).  It was only after reboot and remount tha=
t the
>>> damage slowly came to light.
>>>
>>> Do the described symptoms (what little we know of them at this point)=
 line up
>>> with the issues fixed by https://patchwork.kernel.org/patch/11141559/=
 ?  Right
>>> now we're hoping that this particular issue was fixed by that series,=
 but if
>>> not we might consider increasing backup frequency to nightly for this=

>>> particular array and seeing if it happens again.
>>
>> That fix is already in v5.3, thus I don't think that's the case.
>>
>> Thanks,
>> Qu
>=20
> Looking more carefully, the server in question had been booted on 5.3-r=
c3 somehow.  It's possible that this was because earlier versions were sh=
owing driver problems with the other hardware, but somehow this machine w=
as running 5.3-rc3 and the patch was created *after* rc3 release.

If that's the case, just upgrade the kernel should prevent such problem
from happening.
And it's a relief that we don't need to face another deadly deadlock.

Thanks,
Qu

>=20
> Thanks!
>=20


--TuemGRn68Pryz37l8rv4CYc4XdOtBYYpM--

--lF3MYNuRTFmD5ThH4cjbKMOB7Z3sDwhsC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3HwAoACgkQwj2R86El
/qit2Qf+O8px1yTRz68Bg7btzgi+LM6TOAJ6aZ7tl+vRWhaXUZPy7DyPedjDEkHx
peiPOjyl9I3Etnb+zimtUkJSHMG0DD9Rh0zM8rL08A4XJ3IhJWu4Y8wV80XLPKoo
3p1d/L+u4ybAxiAqMG5LRbX/cqTYiDfV8OTioL04bQm2Dc2Pd1KSs3EtfqQCtLyl
u5HaRUOqGRm/aBrbk41gfz0uiaXy0minWL9WAWi+oBREcOHPDuusUWrWsliuseUn
JcP0ADiFl5LL8C5/SLNoLSRxtusAwAofCKgTbAI1H6DW8j52eK7BDGzFhfQKONhh
PfzDGlgxNPJ1q6gxDbHiG2V449pxnA==
=24ZO
-----END PGP SIGNATURE-----

--lF3MYNuRTFmD5ThH4cjbKMOB7Z3sDwhsC--
