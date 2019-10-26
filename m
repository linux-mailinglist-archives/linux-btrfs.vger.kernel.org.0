Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816CAE597A
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJZJl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 05:41:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:37167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfJZJl1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 05:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572082884;
        bh=M8mewf7DbSi3jHXNt5KFA8tYZ9wtvEzgdJE3asfSvog=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DJ4HgB4po9LHUVOuHX0pthBD3JC2XHBeY5JR68W8E8IPwQpUWAwkCJkvZtv28UcEb
         /VlU4qWnc+UgZekezM0zy+3k3yEluET7S4pfQlaw7RmBf34AxSCShYaruMxZO5cVCk
         47x0Fese/FTzjkgRkFL7uyOf1tdcjcZsjInTSy4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4JmT-1iOZgg1u8v-000K5T; Sat, 26
 Oct 2019 11:41:24 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com>
 <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com>
 <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
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
Message-ID: <4a329da3-81ba-3240-8d76-6509dbe2983a@gmx.com>
Date:   Sat, 26 Oct 2019 17:41:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C2IFCdZGhgRv4LNUTcUzbEENAmNhmV8qn"
X-Provags-ID: V03:K1:h6E67/2cGbxvv8p7v7ALd/cUaLfs4GJL9xiKNwmKNQT/e/IANtl
 o1gDW4K2IjmvkPOgN4o7d2hGaSJLYobOlh1TYvHv6gv7hhT54sTyT68vtdPtznYu7ZFD7j+
 HGykJGLdiKVkjSj3yS9mxKa8ekJ4uUkBt5AE39Xu8ThI/IBAvzpJRzt8hO+MkvM//KHb3+d
 vufRDWBNNvWgKtyZX4lIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vA0aPpfZc0U=:VOKgzHtUzx1KfCRpBe+A2H
 9Yu1SYfcONpKBHL6qWzcmWoVtc0zUkMB4xA+rcG5vGIs93RQ6bkjWfVP+VNxGj1sLhTmHf7kt
 AmHwlQ/bR4oASfvYG+8aHIMflDlysITpVjF1wEWyCijsv+FeHZll25hVeqELp4x1B8ycUFD1p
 LhqkPyU14vPvEjTHSc/hWyJBUpb8Vmi/Fivd+kFc5c9qxPPB2CT6gHj5r2jnwEmE6wsj+uYDX
 kaLCF4mGe3xxw7gew8HegWuj/Frhi4s4P6AbaOXvunPCylG25K8rOzab5fbDExf8Xs/PosOQ/
 2uVHh20ghvryenj+TB5YeC05iQI7YjV4YuRYUatQHxbGLGoYptpDr7F4COR5ajYK9aUD1hpKN
 aAR9FOQvhN0Tw0LUin9M1O5X3oUB3or8ubJMiO3B/PJmy0wFXtCn5dSWGSKUSnt/IYNB3KVMw
 dcqpft0Z37ztgv1AmFNjNP5An6Fa+zeNf60UaE8ggDwOmsEPfGavYpGysoZqRvDRyRTzGNtyl
 33FyXpfIYCx20jS6OqwsVKOagxSuxTJ+CUpTGdD4BhYNKsydhuPYvba59kzX+Ohjinmk4RU/k
 HEjnTdvoxZ4F9ILRlmMsLwY29qE/A1Y2Nv0CNen9lYusF4oLPVvhr0Ooi20gMSywWkhhutCis
 ldrIJHNA45Iq/KAU5anwn/gkwG7vH7YRj0Y0i9a7hibtwIveXJGXTcqEBmJt8s5L+hJc93nXM
 gtGIkg/ULLFIe/+Ymt+et8Ls0/VXyq5LNq5F871IuASQ7NGRq+amYJGTyqK8TCYsEUdT9boLt
 AG843EvTWI5NP78PwCkOloBInQ2IX60IFpaDCkScAZCyDzyL/Xu6bY4vJ7Q3HS+B+xD3VEGz+
 CLgFkraijjxDyHU+bqNPYWh6SswKvWEnN7daWLxOpkGnY9V7a8i8QkntBnC76p6V0VGDNo6oj
 iEoYJd3Xol8XVL4YQK8pAkAEeKKkV3djuxbkf+h+zkiX+WKHx0yKjOI2ildZIdMv+RTs0lV6H
 jzaqQG/Tm2jgeDWLOQxEhYK/ld2Yniiu6E9FtYscDnsufhaU7ffsAW65OtTxOZnbqbYCBibkZ
 9ABvHA+dh7e3UDvIHvCJZ8Zw266nXvjMxWwm+ICDjBU0065g64byReYRFsmZlfCfnjFc1p0K9
 123z0OxNUhZzQHuD9omH+1GWO7cvLc3MlTgqddLebANEIL1CHlwDM2mN/4NaM8DIvdbJpnJ7R
 xUb8ZiUIpXgiH0Yoa6SBItPa35FfZ25wIqu8NIYF/3O/I78KQDuRY9Ymwtn0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C2IFCdZGhgRv4LNUTcUzbEENAmNhmV8qn
Content-Type: multipart/mixed; boundary="Wgm5zeBW7RWpZuFfPFUVHjB4uFbZwvbm7"

--Wgm5zeBW7RWpZuFfPFUVHjB4uFbZwvbm7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/26 =E4=B8=8B=E5=8D=885:23, Christian Pernegger wrote:
> Am Sa., 26. Okt. 2019 um 02:01 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> It's already working, the problem is, there is a dirty log while
>> nologreplay mount option doesn't really work.
>=20
> For the record, I didn't try to mount using nologreplay, only
> notreelog. (Apologies if notreelog and/or skipbg imply nologreplay.)

Then that's the problem.

With skipbg, all block groups are marked readonly, any write should go a
ENOSPC error.
Thus I put a log tree check in skipbg mount option, and if it detects
log tree, it refuse to mount and output kernel message to require
nologreplay.

>=20
>> You can btrfs-zero-log to clear the log, then try again using skipbg
>> mount option.
>=20
> I don't think I can, actually. At least, zeroing the log didn't work
> back when btrfs check --repair was still in the table. Admittedly,
> that was using Ubuntu eoan's 5.3 kernel, not yours, and with their
> btrfs-progs (5.2.1); I don't think I'd gotten around to compiling
> btrfs-progs 5.3, yet. So if you think trying again with the
> rescue_options kernel and/or latest btrfs-progs might allow me to zero
> the log, I'll try again.
> Alternatively, using backup super 1 or 2 got me past that hurdle with
> btrfs check --repair, so if there's an option to mount using one of
> these ...?
> (Output quoted below for reference.)
>=20
>>> $ btrfs check --init-extent-tree patient
>>> Opening filesystem to check...
>>> Checking filesystem on patient
>>> UUID: c2bd83d6-2261-47bb-8d18-5aba949651d7
>>> repair mode will force to clear out log tree, are you sure? [y/N]: y
>>> ERROR: Corrupted fs, no valid METADATA block group found
>>> ERROR: failed to zero log tree: -117
>>> ERROR: attempt to start transaction over already running one
>>> # rollback
>>>
>>> $ btrfs rescue zero-log patient
>>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000=

>>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000=

>>> bad tree block 284041084928, bytenr mismatch, want=3D284041084928, ha=
ve=3D0
>>> ERROR: could not open ctree
>>> # rollback
>>>
>>> # hm, super 0 has log_root 284056535040, super 1 and 2 have log_root =
0 ...
>>> [...]
>=20
>> And thanks for the report, I'll look into why nologreplay doesn't work=
=2E
>=20
> On the contrary, thank you! It's the least I can do. If there's
> anything else I can to help make it less likely (something like) this
> bites me or anyone else again, just say the word. Also, I'm curious as
> to the state of the data and btrfs restore doesn't care about
> checksums, so I'd love to be able to ro-mount the image sometime.

Then you can try btrfs-mod-sb, which modifies superblock without
mounting the fs.

# ./btrfs-sb-mod /dev/nvme/btrfs log_root =3D0

Of course, you'll need to compile btrfs-progs.
You don't need to compile the full btrfs-progs, which has quite some
dependencies, you only need to:
# cd btrfs-progs/
# ./autogen.sh
# make btrfs-sb-mod

Then try above command.
You should got something like:
$ ./btrfs-sb-mod /dev/nvme/btrfs log_root =3D0
super block checksum is ok
GET: log_root xxxxx (0xXXXXXX)
SET: log_root 0 (0x0)
Update csum

Then try mount with rescue=3Dskipbg,ro again.

Thanks,
Qu
>=20
> Cheers,
> C.
>=20


--Wgm5zeBW7RWpZuFfPFUVHjB4uFbZwvbm7--

--C2IFCdZGhgRv4LNUTcUzbEENAmNhmV8qn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl20FL0ACgkQwj2R86El
/qhYjgf9HW1OedIGbXaE8j7D+nZz3T2G9b3G88FeAywIc/Ig6EHxD6fkTvTc/XKQ
s4c/CIx60UenqYtdu5xJXbXHmvywv8doRM9x51xiBmRvaDZ4Oz7tPSB5cHtL4xhf
HJR2/WdRZDJf2DCi+qhOScve+eZJyMYejRxlHka4KmGBR10296U1Gc8kOpEExKNM
3MiGaBfke/DH5Skk4WC8LdsjXEfW7l4B7DDz6YfSBMVytdL7Rou5+rt5fixzOIT1
yfv8b5oq5BN1ldsKFqF3TuPT5Ldq+0JtYRgBlBWsB5bC3zi9OOzPRkg4Ox7yK9Ok
UXuqUI1wGiGESJblNUBE1IILsg/iwQ==
=tqvm
-----END PGP SIGNATURE-----

--C2IFCdZGhgRv4LNUTcUzbEENAmNhmV8qn--
