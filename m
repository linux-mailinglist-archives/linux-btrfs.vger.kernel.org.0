Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F975263A1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 04:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgIJCTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 22:19:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:41207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbgIJCQ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 22:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599704215;
        bh=GghcEZ3m6J+DyDXfeTIFwDQi0HtklYVMT8qnNQYnx3s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TfXSLaYKDg6njOBH3rrHG7fMtZ8Fho27mqDK/lnmVvzAuWzQdKIOt7kpdtUtpfDWM
         /nzYvTn4s5YLFaInLgRdzIqAfFgVaxBJoIZHbD8jhbpOiMi/34u1U3Si53pCKZMWWo
         EYR9kE85IR34w18t32sYD/v8LiVe4X+KBR3MOfms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1kZh4Z3SyP-016ez0; Thu, 10
 Sep 2020 04:16:55 +0200
Subject: Re: backref mismatch / backpointer mismatch
To:     Johannes Rohr <jorohr@gmail.com>, linux-btrfs@vger.kernel.org
References: <0219bbee-9ca3-135a-8a2f-5d616000c1e0@gmail.com>
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
Message-ID: <f4317021-89e4-904b-6032-10bdfe455450@gmx.com>
Date:   Thu, 10 Sep 2020 10:16:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0219bbee-9ca3-135a-8a2f-5d616000c1e0@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i8ciaUXsb9pgj4GIKEwwvYyTqkvuzI0og"
X-Provags-ID: V03:K1:ZG9b9R0EmaLZkS+s3E029EE7uxsKm6VYlYgoQQpEU5dBjz1iLr/
 3QPccq/ypNneMDrBHHnaVb1lg32xYvPvqETUR0HZEGBw6wApPA1+fpBEpyPjBj68Do8OvUu
 RzJKPlrkf3IafKtVp+YnIrUVObxK5SQhxM/jGp7JYekIyMeAivpk1deHJb4sF7n9WDe/LtH
 Kh0ey7P7T1UKLULbaQw9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:okw0sAW8VE8=:SdMm2VLuYfYSJizXTG2UYq
 EsH/JKKwR0oDKxk3S9ED2RNZI2AzXeuWeXT6qzmtiOJpY7o8M0fARS3uYg5xIkOXyx/zCelfV
 M1fKNzwgJYKN0gxByHYYPtRx8djl+El2r6xzmhjD3PsmLQbMyDgo+e8eDZgiLaSLRjG5s7GQi
 8i+ZVl4tQzNgNgjLT7+k+B7T1TLNyL2upf1cM0dq0M0X3YMGm15/+0Q++MdUo1F71I9Ev1zHK
 Y1Wp00grD+BisQJe9THlNPJP8FRtKM9sSf89UwsbVrF0Vf3HQwjRkepuIk3otHb7FRHG1Tdsz
 pmHa7Jfi2BZi9cZ1g2JbNNnDG+ZmeZ0OnIm8tlGd/p7Vjip13vcloJ4xFLNixug7e0S3XEK5Z
 WIYlyrazgncd6prgwiVsc4XShLBHZyjbGET52bSZvWfKpT/laNAsM5LWEzRr1KmUV3pcoOcNY
 1ndCkg1y5/pMQQ6/vJrDp+VyO2hu6fGAc4a9OhGz1ZLL11ohove0LOowmpyu79iQUQEra4aUu
 SOMylp321CYN3uNCGH8tvi1AU5nLf6gmkpxMJ3mUFECYVOrnzM1wLRX9I0h/cx+Ljyc/wWE/H
 NMlaD/FpCmnsEPYTgFo2S0P3XF9kLLBO3jK4LifIjvAZQQZZ2ogiufj2OGwY0o6/CnDwXORoV
 SD6339jancmb8DuOwIe7uErPA/0C4vA+6PlEsnN4HeeqWMhmDTCJSod8Dg8B9xCjCgKfJi8Kn
 7FCSeDhU3COm05pV2LXh+AAvaBe4KDoziBb87w029PdpfiGdygBh8X8leHCn3brF5LpiPlyFx
 VZkydWK/1O6lCoADeOt4HnGjBUI1DzCbXXbIYIlcaR0qfcOdHGbUaUxmvf0QiR9+7CfhaBUiB
 cjp/Jj4rW9gRsbl6oP2ZV9jykDIm2KzUrUtXsF2tJhWMQ/n+JhavT45cMBK2+rlRf6wfWHJYu
 2b6YkuC7jY/52RUokO386LJn24ih8RT+3jP2nOT73oEnPqZ/gYn31+Z/9iUg/0cRMxuysQ8tD
 ENJfthv/y4P4av8eonRt3H5QW/a4AuEjd5CuP92zJjQHb8z6ZLHldvLov6FBmsCcj5kDMAEE0
 zIQIatNisviFLjbKCEs+poWYVaLVf4BEEwt9JwbhNp9SY6ZoWRxGi6QzbjidjyE2w0syNf4xp
 ksiyQB9KuUSGHdkdWGDNiDEceXMratqzZFZR3s/Cdly30GJcaoQiGQJRVeVfs8o0u01j8j1Vt
 JdIJNAWBPqCpuwmR5vgPgdcWgpqpv3Bd97trNfw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i8ciaUXsb9pgj4GIKEwwvYyTqkvuzI0og
Content-Type: multipart/mixed; boundary="1XYXRET6N965yt8Ynwyi5rMzf8OeKsaTM"

--1XYXRET6N965yt8Ynwyi5rMzf8OeKsaTM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/9 =E4=B8=8B=E5=8D=8810:51, Johannes Rohr wrote:
> Dear all,
>=20
> Last night I did a readonly offline check of our server's file system
> and I got a bunch of backref mismatch / backpointer mismatch errors.
>=20
> Since everybody is warning NOT to use btrfsck --repair, I wonder what
> options I have of fixing this issue, short of reformatting the whole di=
sk
>=20
> All the info (uname -a, btrfs fi usage, btrfs check output) is here:
>=20
> https://gist.github.com/vasyugan/45471206df5d9981f51b9bbf9362508f

What about `btrfs check --mode=3Dlowmem` result?

If your btrfs-progs is not uptodate, it may be a false alert.

Thanks,
Qu
>=20
> Thanks so much in advance for your advice,
>=20
> Johannes
>=20
>=20
>=20


--1XYXRET6N965yt8Ynwyi5rMzf8OeKsaTM--

--i8ciaUXsb9pgj4GIKEwwvYyTqkvuzI0og
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9ZjJQACgkQwj2R86El
/qiY4gf9EAgs+rgb0orfYvRVR0wbVSzKfljzaFMaXuVy+MEfMMffuRDrhynB413t
ZNm1N85/xQGy2QgiaER7PQZdnt0onbAbWDAbo+zox51ZyNS5ENJPtYx/tlkX5zsT
693qi6+1a8M4xuhOPLkCtNXHbjZ3KcJssGgFiTtLeYgA8A1Wcd60Z7lDaHgYbMqy
wkszd56Cf8/aDLATaxZrYPOz8suya8nSSpsQLkOOWPfCxLbTltD+k3zFC4KYhlTi
BeLAapaCbXVyKgwx2AW7o/cWs/RSmrLg8ZmALVWQ8Jb+rJu2LhUGTAO4KwQHBg55
zbM/V8RKVHPg5oZWxuoKFtQJTC9JEA==
=sbK4
-----END PGP SIGNATURE-----

--i8ciaUXsb9pgj4GIKEwwvYyTqkvuzI0og--
