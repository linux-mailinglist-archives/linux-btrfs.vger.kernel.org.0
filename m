Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA358967F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 06:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHLEyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 00:54:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:47467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfHLEyK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 00:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565585648;
        bh=LUo1Af2UitGpJnV7MyxwNqgoIa592Jd8zorA1IoP4vY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SXBNAtovRMTOPf3EWSqt67XQRcKSRXkwrOsuMEWWPffSUWG0XhbyH3D0ZwkLQ2eP2
         ctYNJ/8A9mBQRSDk4PLUi7HB1wzyzhHlIds5OQUXjGadS8DcdOYt+XBDRlReUZAAtJ
         qMGLG2NEz8QugOh6Gk1/e0FuqX5pGECW1nJR1LxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1i0Lj91UVQ-003NTG; Mon, 12
 Aug 2019 06:54:08 +0200
Subject: Re: [bug] btrfs check clear-space-cache v1 corrupted file system
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQrLLpX8uZwp2BYfgaF1QPfuf1_XRjVxG24cbDHfEo2uA@mail.gmail.com>
 <4dfdc5a4-a6d7-e96b-afa1-a9c71b123a96@gmx.com>
 <CAJCQCtT+VnSp_8i-QWT6iwCv9yaqQv2XfsVtsdvQmoG70aQZ7w@mail.gmail.com>
 <afe23216-7d73-4d33-d80c-15d29f24c64f@gmx.com>
 <CAJCQCtRyStqPLOXHVWkcha3GkA7wt2u00qSH7DfUyL_ift5ppQ@mail.gmail.com>
 <CAJCQCtQ7aFpyQ+g_YWZJCuwuqOSXH-Gany9s-CgEQM6f2RK5bA@mail.gmail.com>
 <CAJCQCtTwxW65Ftiu6Ts3FKF8bKef9cvnOrFrXo8ikvGcwog+9Q@mail.gmail.com>
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
Message-ID: <1f386080-e460-bb51-5c89-47fc986564f4@gmx.com>
Date:   Mon, 12 Aug 2019 12:54:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTwxW65Ftiu6Ts3FKF8bKef9cvnOrFrXo8ikvGcwog+9Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9xDqv16kfP6Hk1Km87TcteliDH3mAn5Yl"
X-Provags-ID: V03:K1:5vXwv82GVnsZ8sntvqjqDi+sIqeUSG+UBsOWUEXldTc/hd1PjnY
 6Dq8QlSqNt7J7MsTcefiQPxqbdTy1uy2QCbeoeA+T2v5fXnxul07xaFd3K3o+UZ/iKZCEJf
 nF6egKcO9VZqbhBuhBNZtXeb2Zyil+fbX3r04vOfeMgoQ/ccaxl4FYgumk5r8hpUxiEdNae
 gSScRvxe/wzEpMiZxNt7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B59YgH4j9k8=:sht5XNXzbao/cychAQVl9O
 KnMCBnOsmV5jP+tyOhVgepbtke5GVbJHBDLQTUaxnL9kFWhOfO7B/MKIibV1hRBtpJzI/LiEw
 C3YSytEWypI40E+r4hp8eN09kaUJc+FmBrsRlDfr0pN/Le7jX1U7hPG8/dUf8uOgAdTWP+9aB
 9BHAKhV7cEPjsHTLkMbe94lWEK9ejdha22lALFagpmhR4HkmyKgrv4doxF1uBUi9Lie4caTpn
 kjEJRzrEn/oMm7yKMUUdLbYYCfsgiiHORNfSLeYbHrI4dcBn/l85w2emB5+oNBb1BeAVvxHJ8
 c3HkFxTMuF96RPXdo9nViHe8+8E3oOcqjbVqD/NkLXzyGNwA1nPWDKGkwrz/e792YWj1pNwj8
 z5NnSsBnorAqQgb96PnacALTx+2IdYFG24KZFY6aThazZhYN5+CWy9pAZm+EJt1qGiQhV2h0/
 0HhGT40CQB3Y20VOBPnVHjOsNcKLOg15K01xMcMVcrAn9cEXMZpob+JCXkAJMLI+9fEfB5lNB
 TREwvdZ7wGYPGpiLHO7+5MEqgBWe/81JWhVQZ1DcjoyTAEDLHACWN0gClM8x6ACLrkyldcXiP
 +i1tK7XunnBmjF8E9JsDa65RjELTaaq6c6Ksm8VXQr9htwsfjyHNjNLzEyA334CmlGEpXnte5
 jfN+inIie0qVGUily6lU8iBYAIc7hG9YiPlRfhNuEM3yyCfhd6QR2Wk5cYD4ICKwlz29LZDXr
 aRdXw9g6GMcAp5pWWAoMuatBQNbGt1by/7+Bpqtq44AjY3GcUxY2w9OKoZ07bIhARpoMu1dWG
 kY6WKD2IfJWkMmSA4S6UvMABTEg2vXZ1//041nimjcJm8y3uIqX5nDWJzXlxcU6KOMESyMNUc
 3W6NwA4Xs8h5v86O+LD6rUVfDIEqHJbytQPTNRGpR1tzvNIDNs7W3brxugVHHuQSb3ZZgSRW9
 1gDiHO5EQ7e4i0iQCgICJam3tssK+DLK/m4Md6RAztSvXTiD68lr65toGc8va2gG0zl5ujXGF
 JwYfAItI53+u9+at9FwBLPzJDo5ZMZNJxI7wffGzxVlz6mmyg30EU1cg3gp1hC3221/SlTgH0
 g9EXPaO1Iy3Bp1/zsG6epuikGixXTzGln6DRhp8HRgnsD3tNmIBCqKF7w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9xDqv16kfP6Hk1Km87TcteliDH3mAn5Yl
Content-Type: multipart/mixed; boundary="kJcPDni8iUKwZTxPq0cml03N1WHMsi0XI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <1f386080-e460-bb51-5c89-47fc986564f4@gmx.com>
Subject: Re: [bug] btrfs check clear-space-cache v1 corrupted file system
References: <CAJCQCtQrLLpX8uZwp2BYfgaF1QPfuf1_XRjVxG24cbDHfEo2uA@mail.gmail.com>
 <4dfdc5a4-a6d7-e96b-afa1-a9c71b123a96@gmx.com>
 <CAJCQCtT+VnSp_8i-QWT6iwCv9yaqQv2XfsVtsdvQmoG70aQZ7w@mail.gmail.com>
 <afe23216-7d73-4d33-d80c-15d29f24c64f@gmx.com>
 <CAJCQCtRyStqPLOXHVWkcha3GkA7wt2u00qSH7DfUyL_ift5ppQ@mail.gmail.com>
 <CAJCQCtQ7aFpyQ+g_YWZJCuwuqOSXH-Gany9s-CgEQM6f2RK5bA@mail.gmail.com>
 <CAJCQCtTwxW65Ftiu6Ts3FKF8bKef9cvnOrFrXo8ikvGcwog+9Q@mail.gmail.com>
In-Reply-To: <CAJCQCtTwxW65Ftiu6Ts3FKF8bKef9cvnOrFrXo8ikvGcwog+9Q@mail.gmail.com>

--kJcPDni8iUKwZTxPq0cml03N1WHMsi0XI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/12 =E4=B8=8B=E5=8D=8812:24, Chris Murphy wrote:
> On Sun, Mar 10, 2019 at 5:20 PM Chris Murphy <lists@colorremedies.com> =
wrote:
>>
>> On Sat, Mar 2, 2019 at 11:18 AM Chris Murphy <lists@colorremedies.com>=
 wrote:
>>>
>>> Sending URL for dump-tree output offlist. Conversation should still b=
e on-list.
>>
>>
>> Any more information required from me at this point?
>=20
> This file system has been on a shelf since the problem happened. Is
> the lack of COW repairs with btrfs check solved? Can this file system
> be fixed? Maybe --init-extent-tree is worth a shot?
>=20
>=20
Latest btrfs check has solved the problem of bad CoW. In fact it's
solved in btrfs-progs v5.1 release.

So, if you run btrfs check --clear-space-cache v1 again, it shouldn't
cause transid mismatch problem any more.

Although IIRC that fs already got transid error, thus enhanced
btrfs-check won't help much to solve the existing transid mismatch proble=
m.

Thanks,
Qu


--kJcPDni8iUKwZTxPq0cml03N1WHMsi0XI--

--9xDqv16kfP6Hk1Km87TcteliDH3mAn5Yl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1Q8OsACgkQwj2R86El
/qipVgf/R2a3XB/Pt96HVsqKu9Iv3x9+6DmdfXFjK6ML8+t3X1ve+PRhbA4cGLo1
5KhiESfFScwUeAJmmvr6OTpzwZiYleuBAuNDG46u9OW/hqzdtyfp8cLCDAuxEOWh
66HOsMi/wkyrGSKLQL1SS/cTmJw7nDqX6McVbUP7GQbwxBCJ1AkM4jYcD7PpCR1S
77ZSNUvFgUmwf2HImBgTQOf5+IRNv5Z2weFnbQid5u2GflIfL/vfxevzWz2PJ+6d
yUd1SB+pkUha9lw9iH8889kExdfG+S/Bu3O9pBRuDWJvrf/+RPqlLNvfAYWSsx5q
u15t1fefpOsajD0BYNg70LjtOuRWWQ==
=b6mJ
-----END PGP SIGNATURE-----

--9xDqv16kfP6Hk1Km87TcteliDH3mAn5Yl--
