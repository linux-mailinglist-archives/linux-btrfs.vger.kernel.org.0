Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216C560F1B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 07:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGFFvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 01:51:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:52281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfGFFvo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Jul 2019 01:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562392302;
        bh=lEDFC+qzOAIg7EmdxLWsUqFOHbPBTvcPiKu/a+NiRZQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZxGroVkdBJi9+hfdmjlqaze5EYoiL0stAZjk/DnimJRuW60aOj/poLmE/BSK4kp9J
         WBpqS9wtYIcFrcnPHz1jzK8nx6/zkhb+pof48ET6xi6V8LNbSWASt4/6PHVEZPSlK9
         FkosY+w6oT+OZ4ZQKB4ICW3YzYswMbXwaYDyNTBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LlV71-1iKtMw2ivP-00bNmC; Sat, 06
 Jul 2019 07:51:42 +0200
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
 <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
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
Message-ID: <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
Date:   Sat, 6 Jul 2019 13:51:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o4yLztsxjG32cMZx7YolOXpYQLjQt5fcb"
X-Provags-ID: V03:K1:9Dhd4q6pJatLSBIomMM6mPbTSTlmF/UVsDhDRqFiBLs8BSwOTxD
 T29Vw5rns04LdrFDI4/+a/9xVzJjW4cce7TbKEHxswlP1NAz0VDIuuMAuztOnrpbrJlEMII
 cxs37qvKzy+VO4J3bCsMStGVqWNJV6bDb5yfA3N4sR10NnRodDVBMi8Y9utzg/pFxx0F7lP
 sMmI9CuivW1JtXsgkhmGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjH2P2riwoc=:apQvNqJWjKFG5Xohv6bySd
 QzQV5pbMcBr71Rvc6/t8vc6LIdpKPNUBnCMEjQ6d/QUqHyY0z0BuC0Qee8UcMU5AtcxTpg8Tr
 Gaipl//dWjyEWXW7ebNx1BlAHyoTr0KKf3tNRq34jYCSBM7MCdM76PWMAGImtLyubJodxPtkP
 THfMkE7tAp1UxMrsZcpowmyFPYWLk+Zn1HQWJrEfZjm3gOYg8vQ6nUF6XLVkXIK/Y5JF9EppX
 Nd/YubbmWZDhohciutBciNwLzOZ1jEF4BP67AaPZODv9rdV5ZMziLYoAtXCe1aL8GgoVWbb3j
 CiEnIo5xacyk1tsPgIFwgQGsj68ny8BzUxlfVY61o8iDbelfUIWAYRXoyP4kVSbGdKy+TsJHU
 /VtfhMN6Zlquih7ykUjlvBtSn3NCK7heXodYsQl4SGAIO3YrNaiIa215GKztjXEhBNmH2PEBT
 XrCK4gsAEyDjIBpZhRCAnyTVzvMU+glMuKiU/BNLK4ebs9U0fqMUejfMyVvIe38mPTzgFCgPj
 T72a0WxmsaykUWjH/UvZ//Nb8Jg6CJ74OrgErie2wBl0ZE5hiYmFBzIhfHX2p/XduC+jf8l4J
 RnDvH0dd28VGLVFUwbjeTD1Z9AF8k8GGbcpxt8GX20vjzwMDMP4ZNUdyEK8PdWWY0X5JHtXfx
 vMlQCslNki4AdiGd1gLLrT4gcuUjRQb+tPfXUuHzyIkRyuOtuGfDSvgvOzuTYgD+iPUEy4yqT
 9cA+8Bouqc/+yXg7XORWH6KNZZRpqesDxHPrRyAY1vxYKb0qvZm9ynXJvCPrm3btrMxRxHJfD
 KEZfnsevRk4YJaVDgjq7632KPnl8wHD227XID8kDAn49rlZmIzNB5ku9K2+JrChfVozqpp4nU
 3tCep5ehNy+OnPFxUlDCJ3s1hucKsZASPcNB7gMSSj0a4yncC5DShZCP5woIm0Vx6CcW8IcFs
 H4k9Z3EgAkLOx9xkhIpxFUOyMK2TFfYEPuoLB7ty+R1N2hJr8kDNrab9Jn7/Ug+ryYoIUtK1h
 fmj5AUKe47eLvAJ9XXCAjblH8lWNwMWuuPYGbXyOj/xOtQfNmIfZ/ZKYtJR4fu7zdyBRy0WE1
 F/3UAZo96Wlbz0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o4yLztsxjG32cMZx7YolOXpYQLjQt5fcb
Content-Type: multipart/mixed; boundary="aWwfhOdoc1UVG19pi2lEeUGLVDgrkN4mi";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Vladimir Panteleev <thecybershadow@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
 <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
In-Reply-To: <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>

--aWwfhOdoc1UVG19pi2lEeUGLVDgrkN4mi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/6 =E4=B8=8B=E5=8D=881:13, Vladimir Panteleev wrote:
[...]
>> I'm not sure if it's the degraded mount cause the problem, as the
>> enospc_debug output looks like reserved/pinned/over-reserved space has=

>> taken up all space, while no new chunk get allocated.
>=20
> The problem happens after replace-ing the missing device (which succeed=
s
> in full) and then attempting to remove it, i.e. without a degraded moun=
t.
>=20
>> Would you please try to balance metadata to see if the ENOSPC still
>> happens?
>=20
> The problem also manifests when attempting to rebalance the metadata.

Have you tried to balance just one or two metadata block groups?
E.g using -mdevid or -mvrange?

And did the problem always happen at the same block group?

Thanks,
Qu
>=20
> Thanks!
>=20


--aWwfhOdoc1UVG19pi2lEeUGLVDgrkN4mi--

--o4yLztsxjG32cMZx7YolOXpYQLjQt5fcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0gNuoACgkQwj2R86El
/qiWSQf+JHNrOVff3bWirTfdFIJ2FYkYX5V0sccqowkigApcYmCD5Nf21KOeWf4L
rhpc/hbKwLblryjwsN7fuyfi3yAVaC0WX/u8GvbZY+UfGeXfs4TOjnEE3VXuEcyh
rhZm0fpfmCzhqqYZiwWIUF11K4JeC3k1Jzh1qtlwG1wzjg9budHG7Mc13AanEIq1
5MQsjOHbWacB+GD2mTLS514U4aukFtrPcygnl2Mo4MwT5DQxiHbenJY0MZdJnCjM
f3gpO3suKtiBep3DbeyDtB8FwxpK9FO0iuApVfjiIIk5irwUoI8rjtY13Ju9wRe6
imetgw5US+rurccowl+wZwiT3RNhTA==
=zlWN
-----END PGP SIGNATURE-----

--o4yLztsxjG32cMZx7YolOXpYQLjQt5fcb--
