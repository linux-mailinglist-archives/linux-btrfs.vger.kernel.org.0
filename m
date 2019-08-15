Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF088E2C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 04:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfHOCfb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Aug 2019 22:35:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:42743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfHOCfb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Aug 2019 22:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565836509;
        bh=91IRaUL3KdevzR5dP0EvLxaBtXJAfSV0ujkiigfB7s0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QPH/LyAZMoEsUem8cwULiOSEAO2FGCG287ValU4KbUNu620juKWypoAX3Douru77D
         nCzwqW1oiNmfIRYh4INXzM0QMFBnMkpai0AdW6J/2IKz82WTmFhwK3VvdhiAdNU1J8
         ZKoS85CbyO4JXnCK+cNuW2tCAi2LxSkavnJsZRYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MNIAz-1hwBvB0m9h-006sPP; Thu, 15
 Aug 2019 04:35:09 +0200
Subject: Re: recovering from "parent transid verify failed"
To:     Tim Walberg <twalberg@comcast.net>, linux-btrfs@vger.kernel.org
References: <20190814183213.GA2731@comcast.net>
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
Message-ID: <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
Date:   Thu, 15 Aug 2019 10:35:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814183213.GA2731@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q2tIupfBzsRreJgv29GSTTIH22HiDlL2Y"
X-Provags-ID: V03:K1:Oc76ZjMC6SEbcN89GWR1VyCYCENKRgFQ0TouRrvwE+UDtU9Nx6U
 9DCqY+4OAgxlYKzMOiz6I2eZDyS6ALp3Oayb7t9oYa02SESMdPCg9fYjgabzP0HatR/7KZe
 0l0PAsFcSi8c9XIoK+ZO0MS1kJ+EtV9u8Oml82yOzDjjJasyoCeYZm6ZZcHoFshuhzZE6y5
 d57Qmk4K17pURL4jDqysA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/yI/pzFhb68=:niB8WBuFPxAWX4q3/NwQj0
 e1EHfnChJCyaqaJJ95AVaeMUgFC3XVNpL/JkNH8+IX6SctK3uH5txMxoEPHrI/ayf1gNvtFVO
 zPO8slPA3nb7ToEggh1Fn9qpUJiTgto7MUqRQmwhlHXsUyyz7KbnLYFexPQJOD2HBNYbOaRPV
 45icnK/2qEqMSowqL/piUber2b4lX0D8/tA89PVOxmS53TWfi4b1P3gSam2GvhYiKw4Q7irbK
 7iIDI3+dxq1jMh/yKv0eQh7gCgA1mVLse4D4sINV64IG67v7JF9ziQgwSkVqf6t3ycXhjJtHV
 xjDxp91MsUHPMhojNPEBZw/e27ytFKC272gnnJfWzN5K33OYgV4ElAdD9w9n+A0dMGjJ4pWWa
 s7jXh3OPbL6Xk6SVOOjIui3RosatOHBS2RGP5tbdwhAryawxheXWBsmJGz5hg5G8gGH89xPJ1
 GOVN0IKLmeuu8x7QDBh4QruKfgGSlA1Fpyf3z3Z9UFo0Ahyi7OQdTd2bLPUvix94un1Y82Bkd
 KwCCwWcQAzXkbh5NqA1LrTPZL/+2FebRB7lZZR9Wj5oRCu3w15KrGtPNpuRnkLcua1ehiO3w6
 W37aJizWvZ0+mNPYjyhRAL6dXsrjn8If7A/bn9P/cza9fEpV/9UmDrojfb1eO8wzq8qGA+yeo
 meY0AvKj6EHVw51HePQVrHQ/U3W6VBztlxEG01JhxAoWIauGq3zCE5xVnlGIWVxMlFvtX0v7O
 oINtBxbBcp4DIdBg4TTZEeBCYiqlks1/coh47HAB5qIo9y2D1KtZkrYRYNk0ApAUsmLFOALVl
 YC2skD3f6bGoqZclyTZsK5zgTsgDpa0y0Z6gEmo4wVoFFORbMS3IMt304XK1XcMlRWjAP5xrU
 pPfznP4+dD0+eVTfKsyT+JiSnim+zc7Ujh6jlmlJ41rzhh5lPrVfcOLjjdkhjL4PGh/cv1VGb
 Kfmsg0C2ATvlCm7Oy4lbr9G87PgYE1/2UbFVb7FmSW1EUJftkdb/DdQ9MPtI3bvgkiczsiMIs
 qx48SscjJwpMRhNGfq1mP//5lI5aqCU9L06fDJz9d5Ev5nm3fZUAA/sm38hNK1oT55eJmtDgm
 vnbgQSrmRGe332/MntpuZT3Dxi0379gPEABXF0etMXuyMASKwISfBgj2A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q2tIupfBzsRreJgv29GSTTIH22HiDlL2Y
Content-Type: multipart/mixed; boundary="LG2D4VRVbm9e4T8GJArzdmpqpoKwD1jJi";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Tim Walberg <twalberg@comcast.net>, linux-btrfs@vger.kernel.org
Message-ID: <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
Subject: Re: recovering from "parent transid verify failed"
References: <20190814183213.GA2731@comcast.net>
In-Reply-To: <20190814183213.GA2731@comcast.net>

--LG2D4VRVbm9e4T8GJArzdmpqpoKwD1jJi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/15 =E4=B8=8A=E5=8D=882:32, Tim Walberg wrote:
> Most of the recommendations I've found online deal with when "wanted" i=
s
> greater than "found", which, if I understand correctly means that one o=
r
> more transactions were interrupted/lost before fully committed.

No matter what the case is, a proper transaction shouldn't have any tree
block overwritten.

That means, either the FLUSH/FUA of the hardware/lower block layer is
screwed up, or the COW of tree block is already screwed up.

>=20
> Are the recommendations for recovery the same if the system is reportin=
g a
> "wanted" that is less than "found"?
>=20
The salvage is no difference than any transid mismatch, no matter if
it's larger or smaller.

It depends on the tree block.

Please provide full dmesg output and btrfs check for further advice.

Thanks,
Qu


--LG2D4VRVbm9e4T8GJArzdmpqpoKwD1jJi--

--q2tIupfBzsRreJgv29GSTTIH22HiDlL2Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1UxNkACgkQwj2R86El
/qjO0gf/Ssx+k11WAWRWJneYyk7AG6DZl3lDx0bFirnpRw6YOLzRz6I9rlFPjQSE
LA8HYYfKph5opc8gxUtUcem4dW9LQ2q9a5T/pqtdaYIprBbGTUE/jtUTJm/z/IW3
XwzC0vZ1S84Wp/kzaRz4MFMIc5316iXlyL7CJBNwrpI/0bYHzVPdCPTcDV6NMK8t
2jvzghPBHBbq7R25DyMrTfFeAbnsZdi5I50vvfiFPHB4Gaf6AZQbnakquCjPVO8B
Gyn9pOP0m0Ik7odmw7aKr+KsZsTLMsG43ew5Bha8ncFDkOc2s3EbnsPh9kuudPqK
dTnW7Dd8tRbvjv7g8mqMjvDLWbAHkA==
=YXG+
-----END PGP SIGNATURE-----

--q2tIupfBzsRreJgv29GSTTIH22HiDlL2Y--
