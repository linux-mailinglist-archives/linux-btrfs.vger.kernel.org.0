Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550656A074
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 04:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfGPCJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 22:09:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:48137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfGPCJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 22:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563242964;
        bh=T2FwbWvuJKrBpYrptTRgL5602LG2LwUPSoKG4HVPdy4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IHahG3sicqKXgKjCo9PYdsZut6L00QzgVHt9HIo0RuFI7mUHwZ6kY6i+OG2lRxYPi
         UMnEm6P3BA0c7hQMfVzVBb04khFhmv7+FZ7gwec2Sm3S3fOOpbAHmib4qf6ZCuXyDk
         amTiGifISnw/56Wp8n5iLYTGV1Vkj8ZPDOVBIiRE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lb5Tp-1iBEzq0TsX-00kevs; Tue, 16
 Jul 2019 04:09:24 +0200
Subject: Re: Best Practices (or stuff to avoid) with Raid5/6 ?
To:     Robert Krig <robert.krig@render-wahnsinn.de>,
        linux-btrfs@vger.kernel.org
References: <6f5f659ce3967c7cef2c6f8f9c07e8be8e5a2a70.camel@render-wahnsinn.de>
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
Message-ID: <fddf59e6-b4c5-307b-2cb4-fbb8e120ac61@gmx.com>
Date:   Tue, 16 Jul 2019 10:09:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6f5f659ce3967c7cef2c6f8f9c07e8be8e5a2a70.camel@render-wahnsinn.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iGtA5F6gpuxpRE20PquCVhjEmCp5BsfPu"
X-Provags-ID: V03:K1:VTm8+H6zP6avpElJeiVwpifPNeEPriX3Z+C9sRQbGGWjCEiV3gy
 hMFb5csm2MD29NM8NUXQ7mWQ1jILuiM5p+pUKCr3L73C5Wbgm1RE/M5kUdaHLxyRgGbeExT
 Tw+RKOyfbldTPBkLVFMjGoG+RmFmDZueMwiON7dMGlXaMRjJ4iYhYtTbm5aOhrM61/tziLi
 sy+8/XsYUzxswTdoxmuyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tce6H3Qw1Jw=:5yX4exv7gi5citfNI77bDC
 +Q13rJTBMBZb83Tkrbq7Af1yrLwwPU3ZS21gfWOozRuyvnOIiVXXGAaLNq3ys7WKgxVKA8vUV
 RrSqjCxfLjE41Ak6v7HpSI/JdN0wVC+JfNKmS3LTx3Q/XC9lkBUZ3jgOm9zxAO6EqR8fkwyWj
 XUpZVuPboqu721f7NVyN27RhUr9+G8k5DwbzqfPAUa28OLSQsUCpe2Nz309cux7u9iTAdxYqc
 wlUnxtbqsWLv/85C9uUBLZwMKf9d+JdwQONDFr+iB3Q0MwADnWJctMbNv5aRQ5yrVUe+kIKv5
 93MHjwK3/mp0H/szti2OarYf0mGiylvdXcBVxhVi331dy7h36ExB+Qp+pmhmHmVbdh+6xd1KI
 LVqJEynYyg0LllfRWtenzBHhkaTDSel5pZns7VYB3QJqt7Y8Owwt1x3W981lzByUyBzeYhDpk
 CWQlaY3/uD/XWt9osm8cHSKOJ5ZuVqT8U1UOD7kTNuAyaSMaz/+zhDn2xMfptNT60Rt4oOQRx
 adaPcvC4Nk/7IRiFLV9S4fNCCW5nLV1N7CjwtQ4lI5qcOGlJl1rm5q8CoYPNGtEyRy7TMRWBl
 JPQjt19CFz7SyTLEjgHXjkBlvhsoEI5td6zJYyLhESeB1caYbckgmDpAITV5EPPdY6hFnJJPa
 2aC0IW66uTvvAgInyJWXIu2t5qot3lC3YeAzGhWGH1sTXLEkUsWj4egQyAjBJUIRgMVmYAeam
 vDgc9avPcBL4l1AJlor9lxmMMHMGpgTd/Cfk97kVu6pLP0G3hA8ckpSga7lc2rQ32PyXzu9mU
 1/VYkhzgoK228Qijbq9OpTQp1V2FSPsIUaIksqG1z74NT2MIyShaivim3cfYKIV7XLkiOropb
 nS0EBlU1wVtWE0wLlceJyOOq8EsOiC65wOeLdni8jGFtjh7qXgnrnS9ajobOWz2SW/lG8LIZw
 zQGCP/b5LI+M9QV8G8v/t3f80qJS6TEu46o3JSlehOlDRhBuVYhi3P0avDG/m4GABP53PaQH3
 hiWyCjbyhZYkha/291XvqQkLiGEjtlfIPqT5g5Ryi1K6ED4WVKLCuFn4dounpCLdHqOtK/Ah1
 u9o3ifsAFHNwVs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iGtA5F6gpuxpRE20PquCVhjEmCp5BsfPu
Content-Type: multipart/mixed; boundary="mWspxByNAbXMljcmQqZ0cCMrtBnQz8doI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Robert Krig <robert.krig@render-wahnsinn.de>, linux-btrfs@vger.kernel.org
Message-ID: <fddf59e6-b4c5-307b-2cb4-fbb8e120ac61@gmx.com>
Subject: Re: Best Practices (or stuff to avoid) with Raid5/6 ?
References: <6f5f659ce3967c7cef2c6f8f9c07e8be8e5a2a70.camel@render-wahnsinn.de>
In-Reply-To: <6f5f659ce3967c7cef2c6f8f9c07e8be8e5a2a70.camel@render-wahnsinn.de>

--mWspxByNAbXMljcmQqZ0cCMrtBnQz8doI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/15 =E4=B8=8B=E5=8D=8811:02, Robert Krig wrote:
> Hi guys.=20
> I was wondering, are there any recommended best practices when using
> Raid5/6 on BTRFS?
>=20
> I intend to build a 4 Disk BTRFS Raid5 array, but that's just going to
> be as a backup for my main ZFS Server. So the data on it is not
> important. I just want to see how RAID5 will behave over time.

If we live in a perfect world, no power loss or kernel panic, then btrfs
raid5/6 would be good.
But that's not the case.

>=20
> That being said, are there any recommended best practices when
> deploying btrfs with raid5?

If there is any possibility of powerloss, kernel panic, or even unstable
cable connection, then raid5/6 feature from btrfs is not as good as
mdraid, mostly due to the write hole problem which hasn't been addressed
in btrfs.

If you want flexible device management, especially dynamically
adding/removing devices, then btrfs raid10/raid1 would be more suitable.

>=20
> According to the wiki a good recommendation seems to be to have
> metadata as RAID1 and data as RAID5.
>=20
> Other than that, are there any mount options which should be used or
> completely avoided when using raid5/6? (autodefrag,commit=3D,...)

I haven't heard such report yet.

>=20
> Anything to consider when using realtime compression?

It shouldn't be a problem for raid5/6.

Although btrfs code doesn't has good enough separation for different
layers, but compression happens at extent level, while raid5/6 is at
chunk level, they have nothing to do with each other.

> Balancing issues? e.g. should you always do a full balance (when you
> decide you need one)?

Full balance makes no sense.

For older kernel we used to recommend balance based on usage filter to
free empty block groups, but now empty block groups are automatically
freed thus should cause no problem.

Balance should be triggered when:
- There is very unbalanced data/metadata block groups usage.
  E.g. a lot of data block groups are almost empty while metadata block
  groups are almost full.
  However this should be really rare.

- You want to convert profile


For raid5/6 what you really want to scrub, not only routinely but also
after each power loss/kernel panic/disk lost.
This should reduce the possibility of write hole.

>=20
> Whats the best/proper way to replace a failing disk? What about a
> sudden faulty disk? e.g. won't spin up anymore. Just use btrfs replace
> as it says in the wiki?

Yes, btrfs replace.

Although for such case mdraid may be a safer solution.

Thanks,
Qu

>=20
> Thanks guys.
>=20
>=20
>=20
>=20


--mWspxByNAbXMljcmQqZ0cCMrtBnQz8doI--

--iGtA5F6gpuxpRE20PquCVhjEmCp5BsfPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0tMc4ACgkQwj2R86El
/qhdZgf+KlWcmQ6k92+PM1DZ2gf4Zs56mE2+lpmm0l2gF+B68Rz2J2ttbbTG3uje
QXzzIH5LB6kVEeRW+V7oZ3RfRmAfny37PFn1P+pXjXg+VKOD7rqXAdjXfqnYQ1vx
urd8/OKkCToCLtn/AiAQ2m+89bBP7RIv9rgSlXSDdSLOeR5eMj4kjAqnucR7HAcv
t5FLrSl1jQezbLvDSriFw/DjB3hzz5fOFmfJkYToLX4KsWcu7Pm1t/JVAxoX9ZsV
1nEUrww9iytNrNuhVDqMOx5H6jg2rXTs01NP6Nn7wePeaSrU/IdjMkQ3z+eFT2Eq
JXWQ3mI/WLwQU4JCiSDkck4Lcn61sg==
=lxdA
-----END PGP SIGNATURE-----

--iGtA5F6gpuxpRE20PquCVhjEmCp5BsfPu--
