Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F21868F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 11:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgCPK1W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 06:27:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:42575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgCPK1W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 06:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584354426;
        bh=UqT5xZwJKeOzOXn71LHEnhGUqZ35vPrZJq0TQkik4wg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UfS+n9XAjmRq6BIMAsYJe07Kf8b/Yur39LV/iOzAe7HvoTlGIvQVbDAAzw8BXLymg
         awgeA+mIerQNuLiQcvkRUZgLbhueH7iMT4XFP5mn0KogJPtcuRjoDwtqmgvy8zXF3d
         U9LgscmUInUX3Yf09gQI9hyu2ZTBzxWe3E1Fb+qQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVN6j-1ilQha1Srf-00SOwQ; Mon, 16
 Mar 2020 11:27:06 +0100
Subject: Re: kernel panic after upgrading to Linux 5.5
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
 <fa4d1bf5-b800-edba-1fce-ae7108ae023b@gmx.com>
 <553b4596301e2e7bfa05476065c195d0@wpkg.org>
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
Message-ID: <9711f986-0083-0866-68b7-f1cd8e35db11@gmx.com>
Date:   Mon, 16 Mar 2020 18:26:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <553b4596301e2e7bfa05476065c195d0@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dtzcB8zm70kdD7MT5XwOHk7SW9m29jyBG"
X-Provags-ID: V03:K1:1nMPeRbANdkuY7wFSQjzXW18zmgrNkPZ+gp0NtNExv3ZIWXuhoQ
 A/JT7xXztfIsPmhSj2LLaU3isyEl4kZkWnMkKG6J3qysXsKaLAg/wQbQSBeQB56XFctV5lk
 0QsYVwbaMoj44+1EWus12NadPOVsUa/Q5gwBAuxH+vsyPKifUOzWg5p4xmtXXDreDyAFUAx
 EcrLwIQYlHn1B2uJQCXfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gsZ57HyTPpo=:ZgS3L6OFKXEjsL1j98k7le
 ojj4RymRq5urU0drDDoTw21kaOoyf9LY1RXwsQTecT4SDaHgof3G9zoPjZHZGKO8M9Kdrej/T
 CMLY0aIG9DPw/nqCrgZ1Xj2gnw6hag404gj7mDXUu/cC5enHw6vsXvwml83o0P8TAGVheMZ9K
 j+yq2rMNuiJw847eRjBaEsy5RMeXJIzTOY9HnKc1q+69vTwfQO5p75cSm4O53MRCrtvPnCoI7
 1yAXraksxXyY/clhqFAhfQWLZM7H9nqYGhow1k1Re7u5T2Q3lyEzNKHH2m71DCZdzq0NJl9MP
 eISdUZw9DfyhJLsW+4cd45Dqc+56H/SSaobywnlQJ2+yNqB6LvK6YIL7rWCr1+owBFnrIOHyC
 eEfaUg4A1A81e2qesASyCJLWkJ1m6XCJb8XQZZMWVQVDXpezMKGEwEzDgb/A1Vgof9ZoUWooK
 gppRiVbw4WVq3cQzs6B2YYNgQS0jYZjoud4z9wNI/ZhnHyszTYABaOWwZYDIHt88dPHPCUeMJ
 q0ePDOp6XR0S9JDsbCFbGd7T6pk2kTEOmOetD+oo2je0ENJ128nVchGJiiC+shLriVUwMbW7p
 +ShmijF5z76IbtRs2RXWrb7+B/BBlndFCIG27l5Pbrd7YKllCJlyu1VEwfKqx8foTLR8sCf0J
 osHtYe2UqYwGrep0kHxnzAq2NNU5bru9+uF5+4dnqshGqTFm7hEWWNof2/Vw5IdFDj6dUYemh
 UGKzx49IO8lt1BVfLKyNN2LskqgYomyc/8Am1xNI3fytOh4BY5Zjm/gGTNRlsO0WfkKA6+iGo
 md8cG3MUj84LhWrF4LrLuKccmhv6BM5Ky2EgsXD2NquCneHJcnpe5S/Y1RXZP3lHSFkfA4YIJ
 Tm9JapwtnCFXQ3xOCXFpEDbW/vXXjqcfMPjjNJb2jiehdpo2wRcc3afSpIZydWNqWTxbuvMaF
 gbrV9j7fo4IIqS8ZeD0hFy8t6ZfEetULghQrE+B/l2l1ucHJjpmT/ZM251HEgepCFluACGbCf
 5UkBKdFqkElX2vj0FpBtT3VV/kAVJKgX0G2Et7e2zk4PvjKA9cBMsNhAi/Nvjor7w6mHt/I0+
 rMVB+7HYGkjWTM9YiKkqvS0ekAR9meIZkp+cNp0kGWIQyEIPgiGieFxWhBcjeZwpU93VaXHDC
 M0lE5GE1hgVHbFHqyu7UzqDFZGXiqzYEtdRHE4RXw0ECKw8F2M7HYGdgqi9W/yUrlDiNbD5Iu
 xVUFwVaNuYQRf9coH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtzcB8zm70kdD7MT5XwOHk7SW9m29jyBG
Content-Type: multipart/mixed; boundary="20NaT6GESZufje66xlKtdhdLPbOta5LLr"

--20NaT6GESZufje66xlKtdhdLPbOta5LLr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/16 =E4=B8=8B=E5=8D=881:19, Tomasz Chmielewski wrote:
> On 2020-03-16 14:06, Qu Wenruo wrote:
>> On 2020/3/16 =E4=B8=8A=E5=8D=8811:13, Tomasz Chmielewski wrote:
>>> After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), th=
e
>>> system panics shortly after mounting and starting to use a btrfs
>>> filesystem. Here is a dmesg - please advise how to deal with it.
>>> It has since crashed several times, because of panic=3D10 parameter
>>> (system boots, runs for a while, crashes, boots again, and so on).
>>>
>>> Mount options:
>>>
>>> noatime,ssd,space_cache=3Dv2,user_subvol_rm_allowed
>>>
>>>
>>>
>>> [=C2=A0=C2=A0 65.777428] BTRFS info (device sda2): enabling ssd optim=
izations
>>> [=C2=A0=C2=A0 65.777435] BTRFS info (device sda2): using free space t=
ree
>>> [=C2=A0=C2=A0 65.777436] BTRFS info (device sda2): has skinny extents=

>>> [=C2=A0=C2=A0 98.225099] BTRFS error (device sda2): parent transid ve=
rify failed
>>> on 19718118866944 wanted 664218442 found 674530371
>>> [=C2=A0=C2=A0 98.225594] BTRFS error (device sda2): parent transid ve=
rify failed
>>> on 19718118866944 wanted 664218442 found 674530371
>>
>> This is the root cause, not quota.
>>
>> The metadata is already corrupted, and quota is the first to complain
>> about it.
>=20
> Still, should it crash the server, putting it into a cycle of
> crash-boot-crash-boot, possibly breaking the filesystem even more?

The transid mismatch in the first place is the cause, and I'm not sure
how it happened.

Did you have any history of the kernel used on that server?

Some potential corruption source includes the v5.2.0~v5.2.14, which
could cause some tree block not written to disk.

>=20
> Also, how do I fix that corruption?
>=20
> This server had a drive added, a full balance (to RAID-10 for data and
> metadata) and scrub a few weeks ago, with no errors. Running scrub now
> to see if it shows up anything.

Then at least at that time, it's not corrupted.

Is there any sudden powerloss happened in recent days?
Another potential cause is out of spec FLUSH/FUA behavior, which means
the hard disk controller is not reporting correct FLUSH/FUA finish.

That means if you use the same disk/controller, and manually to cause
powerloss, it would fail just after several cycle.

Thanks,
Qu

>=20
> btrfs filesystem stats also shows no errors:
>=20
> # btrfs device stats /data/lxd
> [/dev/sda2].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sda2].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/sda2].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sda2].corruption_errs=C2=A0 0
> [/dev/sda2].generation_errs=C2=A0 0
> [/dev/sdd2].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdd2].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/sdd2].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdd2].corruption_errs=C2=A0 0
> [/dev/sdd2].generation_errs=C2=A0 0
> [/dev/sdc2].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdc2].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/sdc2].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdc2].corruption_errs=C2=A0 0
> [/dev/sdc2].generation_errs=C2=A0 0
> [/dev/sdb2].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdb2].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/sdb2].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdb2].corruption_errs=C2=A0 0
> [/dev/sdb2].generation_errs=C2=A0 0
>=20
>=20
> Tomasz Chmielewski
> https://lxadm.com


--20NaT6GESZufje66xlKtdhdLPbOta5LLr--

--dtzcB8zm70kdD7MT5XwOHk7SW9m29jyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5vVHMACgkQwj2R86El
/qjtVQf+JWQe224fWPnC0ct5ZaRq6CJrQefhxgOw73kWy62/vlOp7iH761wcT87p
BRuowbOt0ZMhj9BgkJTuTiNJMifHWZ6lVYKZa+p4fxfHoz3kOLTp6DyFWk6J5aUy
C59OQjyqAFkFq4v93UiLChBFeyvu4tZ1mHSnMrLaP40P7NwXjfsEmX4VlMCQcNs6
QSiti64zD/OoBX/KQFhXiAG0eT+0RRJisLKyf9/X8h1bY4iZe06Ja5uj5EV7qLGm
wtTuMUiJRI04TfzbIZ0H+JXdR2aaQVSGg3d2n1bRYBiivwFSC4BPhDZfNY0NDsh0
zBdE3sSGVK5TyuVWC9yBl/EjeNbDSw==
=FjLi
-----END PGP SIGNATURE-----

--dtzcB8zm70kdD7MT5XwOHk7SW9m29jyBG--
