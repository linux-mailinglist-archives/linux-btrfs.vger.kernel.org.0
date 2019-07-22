Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0556F9A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 08:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGVGsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 02:48:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:40051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfGVGs3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 02:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563778106;
        bh=XRJ8ND1uN6oOaV+3UrE376gdyq5Qu2PeA4Y9KMu2kiw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vv7s0E+/+gaJhjnK2kG+Sox7vTWth2gxeBI0q7RdwnRl3+V1p4iSEWasD2s/VYmlv
         uKcScA4B70zKYFX+sINXUMOZ+q4iH6AD55nUjdRdFCS+meH7/SDZVugmF2OpcA1Lc/
         jfQzg6jDn9wmSV2Tuni+z5IZpPc5UF+0JQ8phY3M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MKKaI-1hottH2wkA-001haa; Mon, 22
 Jul 2019 08:48:26 +0200
Subject: Re: reading/writing btrfs volume regularly freezes system
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
 <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
 <f950f86e-e42e-4360-f6bd-0502a7070b91@gmx.com>
 <CAEEhgEu09Bn74-P++eGWD89o5ynopgdHMUtzyyC-M-x5rdoavQ@mail.gmail.com>
 <a20c7328-99ba-09ac-2b32-ac3d0b6b87d6@gmx.com>
 <CAEEhgEsoHhR=newte0mqvQo99y2WbJjr2MH1DTWpkqMnJ3Vgig@mail.gmail.com>
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
Message-ID: <cdaf2923-9f10-beff-c2c4-99b94fd14257@gmx.com>
Date:   Mon, 22 Jul 2019 14:48:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEEhgEsoHhR=newte0mqvQo99y2WbJjr2MH1DTWpkqMnJ3Vgig@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9BIKKjAl2YQW8qKRSlKwcIGVSUl8vL4LR"
X-Provags-ID: V03:K1:A3pA0exg+sWYgIdsz8LendSD47NukYT8crzh4KSWRPaagoZZ9K8
 Ibrqp+pxG8wJ9kDDQ4V8hJQO7Xw+TcTtFMInJ0oXrXWjClNYOerEjaStydNi2w5cJk0AaNn
 2X2aQ1KWkRLYrnU0s0LPudYXM3Og4621+8HILC7pc8WZoTyBLtSuvznGqxL/wEiGOwLhxD3
 xXdhRcVr3LjQk5ing99Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/1JVifU3LwQ=:b6yKKuKPPoPk9vwxkDoTxx
 59AYyK0Eq5LOC54CrHGIO+EvORbb0Lgx7RPp8k3a32YqM0XSFd1FFq17XQCTejqJn0r6ux/En
 rLqX9vgCCvUV5/6XOeFw3h/sqgBGMKVIOmcxPP0yRdw3i2INDwdFpAbe/3cI4xJ0qOUpXf9D4
 oHCZkwCKVuQsk/+R8dDU6KwsNWOm+CtbMmEAMfrO6Ne3YZZAMzK7p5a3WbSwrac0FM4UIHgC6
 kB2GmSYrtmdKwejnoksXPh/jsSBptYi932+tgdR/mizB9mCgtPwXcglzhJ+/fd/dv1WawsFDv
 d1omyWXQ+ZAr0PEk+26uYW7jgq6g5ffuiRmDKs8YJAEennBgMYidDfo+P9mvpihJXDpbLHnfM
 ZMzaMCAH/BAoxM1PNvVgxdzRZLLk/hIAV/pQQvToJAwer01gEIG0HFPuP9Bq82KJ7BIcQ49pB
 A2gn7ELFEl/NCjShHAJr+5/SOzJ0cvd6Lwi+4qxVb5daC1815qJVf4/8Gwqwn7Uao74oEiw6a
 LWTuQHG55dYMN1ObmWOP7Bc0YdUoUZZCgi9EeRBj8sTJicBRXKToChlBT3foD2bTHoxQ4rvSx
 UyB1xL2jxpzxbI2ZZA+JfWC+gr6a0mm7kmyyQSdYVddZ4XR4nz22lRoYP6tis0qkHm0qn3/KE
 jjne5VHoDHNMkVdPDuokZ8vVk3uQAekTN9rBTHS/E/lKfUlcYzXCpcyA2S8KLWCu1rrGpUm2b
 1D38XaxJwBoFVHg8digiWvya+xgAxIsI4x2MrFvcrt3IoJ92YRCnoBIjZHOv5e7n6EZ0f6nnw
 u8ub4w2zm2h4EP6HmA0+ouoFbIgwd3ywHpmBVLMOJB0k8XPvaJG5s7t5TFYF1B3GA9qfY/E2p
 4k3qFVp+hizb0MU4slZaojopWy+GZWnLrrxegZ3zM062Vj9atnFjeCLI6oWrqHBh614AIYKXv
 NuqlD0J5SYSmFY4EjV7CSSQ7tLI8lRzvwk4LDKkU2fvzGHdHtxzhflR1vB8Wtz/axhcEyZqLf
 Fgwze7X9JIKNIusZZHlzx2w+g5CHE3juN4Eo8qz8/GXLU47t1ki/TuQGvXk4Jkyd1aDZo9AhJ
 WMsllTAaDTu+Zg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9BIKKjAl2YQW8qKRSlKwcIGVSUl8vL4LR
Content-Type: multipart/mixed; boundary="QilnnE67g7SVegu0UUV0Vq5CZOfpxasf4";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Nathan Dehnel <ncdehnel@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <cdaf2923-9f10-beff-c2c4-99b94fd14257@gmx.com>
Subject: Re: reading/writing btrfs volume regularly freezes system
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
 <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
 <f950f86e-e42e-4360-f6bd-0502a7070b91@gmx.com>
 <CAEEhgEu09Bn74-P++eGWD89o5ynopgdHMUtzyyC-M-x5rdoavQ@mail.gmail.com>
 <a20c7328-99ba-09ac-2b32-ac3d0b6b87d6@gmx.com>
 <CAEEhgEsoHhR=newte0mqvQo99y2WbJjr2MH1DTWpkqMnJ3Vgig@mail.gmail.com>
In-Reply-To: <CAEEhgEsoHhR=newte0mqvQo99y2WbJjr2MH1DTWpkqMnJ3Vgig@mail.gmail.com>

--QilnnE67g7SVegu0UUV0Vq5CZOfpxasf4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/22 =E4=B8=8B=E5=8D=882:15, Nathan Dehnel wrote:
> How do I get a longer backtrace?

If your dmesg output includes regular message other than the backtraces,
it should be complete.

If not, some dmesg may lost, you need to either check your system
journal (if it catches all dmesg), or enlarge kernel message buffer
(log_buf_len=3D<size> kernel parameter), or find a way to catch the
message early enough to avoid unnecessary noise.

Thanks,
Qu

>=20
> On Mon, Jul 22, 2019, 12:02 AM Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>=20
>=20
>=20
>     On 2019/7/22 =E4=B8=8B=E5=8D=8812:25, Nathan Dehnel wrote:
>     > I'm still experiencing freezes with kernel 5.2. Here's a backtrac=
e:
>     >
>     [snip]
>=20
>     This time, there is no backtrace of btrfs functions at all, nor nfs=

>     ones.
>=20
>     Is the backtrace complete? If so, it would be something else causin=
g the
>     problem.
>=20
>     Thanks,
>     Qu
>=20
>=20
>     >
>     >
>     > On Sat, May 11, 2019 at 6:21 AM Qu Wenruo <quwenruo.btrfs@gmx.com=

>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     >>
>     >>
>     >>> [362108.291969]=C2=A0 btrfs_tree_read_lock+0xbb/0xf1
>     >>> [362108.291973]=C2=A0 ? wait_woken+0x6d/0x6d
>     >>> [362108.291978]=C2=A0 find_parent_nodes+0x91d/0x12b8
>     >>> [362108.291985]=C2=A0 ? btrfs_find_all_roots_safe+0x9c/0x107
>     >>> [362108.291988]=C2=A0 btrfs_find_all_roots_safe+0x9c/0x107
>     >>> [362108.291992]=C2=A0 btrfs_find_all_roots+0x57/0x75
>     >>> [362108.291997]=C2=A0 btrfs_qgroup_trace_extent_post+0x37/0x7c
>     >>
>     >> It's qgroup.
>     >>
>     >> We have upstream fix for it, 38e3eebff643 ("btrfs: honor
>     >> path->skip_locking in backref code").
>     >> It's supported to be backported for all kernels after v4.14.
>     >> But I'm not sure if it's backported for your kernel.
>     >>
>     >> As you're gentoo user, it shouldn't be hard to check the kernel
>     source
>     >> to find if the fix is backported.
>     >> If not, feel free to backport for your kernel.
>     >>
>     >> Thanks,
>     >> Qu
>     >>
>     >>
>     >>> [362108.292002]=C2=A0 btrfs_add_delayed_tree_ref+0x305/0x32b
>     >>
>=20


--QilnnE67g7SVegu0UUV0Vq5CZOfpxasf4--

--9BIKKjAl2YQW8qKRSlKwcIGVSUl8vL4LR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl01XDUACgkQwj2R86El
/qhkTQf/TOgCQgYqnRxspFfbg0lxC9YZg3TFApCszHkysnd59cez8j1MaBrvR2PY
ylc+Cs1ou5BojqE7QcwIDIiXOsVcsY3PNC7lNiGo/3aobBp9N7d/RZ2YV8Y487iS
pimWdBrHXf1SEa/9Am3lv43LDEJ4o6BLUzRctlTfGh6joMkUCT03RsQMScYX6eaM
F+3+T8udSLwk850KPHDGyAUd40EQPofaCD+m8ZmDxQJqk9+DAE2X8dY8Ze5OYjBr
feU81W8aC+B2gsRtJJjHmLLMiK55EvNL1QfU/PveCupoXDXJOCLXt35iEfVbMOE5
s3TxIGRg+yij7w0XfpY+sxSM3Z5TVA==
=Cp17
-----END PGP SIGNATURE-----

--9BIKKjAl2YQW8qKRSlKwcIGVSUl8vL4LR--
