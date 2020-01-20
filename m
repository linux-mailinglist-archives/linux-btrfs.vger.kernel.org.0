Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BF1434A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 00:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATX7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 18:59:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:56397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgATX7q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 18:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579564784;
        bh=12tnKBaOdOQGGes5adLVMdMfHVjjkS8cycCZf9scSc4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LRAatUupUvBVplJyhxKtFk9gclqHHnI9r5t9N8s30nS7HLRbP4ynDfsEukShTVpHj
         f6nwQEt9g7CtrzP6Ujktob1MgAlByDnCQFk8bY4C+JBC3FKit1nC4KrnBWGJId2Dbu
         RbqjljTNV2zoEvZz0yqKGah1BXdVuv/KtrqrblPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1jTIp42bb7-00Zie2; Tue, 21
 Jan 2020 00:59:44 +0100
Subject: Re: btrfs raid1 balance slow
To:     kjansen387 <kjansen387@gmail.com>, linux-btrfs@vger.kernel.org
References: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
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
Message-ID: <da1b8f09-648c-3f30-263b-bac314973cb9@gmx.com>
Date:   Tue, 21 Jan 2020 07:59:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZYAcigEb0ZXvUh1EkJJ1WIWoU6lO5sMCK"
X-Provags-ID: V03:K1:0ZN84g6sARhOhVulcTNW7i/Ob4SPeuyoElD65kL1vmTEc6jLV3i
 NYUdIyevm5nzr0ZXe5HOJynGzF7WplQtTHm3WMbzV9dK052outfmQHlQ6qKqmy7a1iD9tQK
 +TJjbJHhrAEAhGKmzQYLENEfKKJQG/EGOGILqhJJzIMh7y4XcxTXd3qyY9n4emho+QGgXQq
 oRsQn8fTtYTkFRkXbDUBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LDg3j5EnKdQ=:E8HGwMmXRJnwCT1qo3aBzV
 u/3tUnKS+nP0wJxE57qDeMXeKrm/NOk1MsLyUE/oytHu+OTyPxWyo4nrP8Vzr11ALVul3Nf5T
 vwNua4FKQxBLXCfniFb1BCO4+kGhO/z7hBNMlmzO0ptrgMWAKt8shjCjRibkOJm9atiuTjMY8
 vQsJhc2puTvdw9zKuWKaBIMFDjiJRiONwC3btc4Febjg/qdSMpexHOApzMufF8p7Z09YifbYh
 AJWuDCYV9Xy6rwzyHC5ojUXZQXMVNrSZhKnYjPaKbueiHtlNFr+SfIvBEb4CgqjWo4GXPJLR5
 tNnLb4ZTQo6w5FRN0Bv/r4YpeJezbmhZVnESAxPi6Ptw2EpBQ5Jp0m+bJmS75miiE0ngAnn9J
 16/MtqVqVtf9+KpdAe5RQLjm3StM0Mrm6ATYpzn+Q/Qn+itRA6XiML2jmaxB8vyLJ3NEq/rwg
 b7ambpiiy/pUKBEbG+o12UKeSNKlNKns+5I+oAp6nAmQiufvmeUT8at83QYCSgfF8eZ/aVXCn
 lRrbNiIasZh5iEN0T+mDDpGMSQlYtVWCMm712buPWwzEwD8b1ZzbojfBOQwJAJmDxulDQveAM
 eCmx7ZliXrZ9C1Qm4MCg9QNRy5lCYZlt+dzjAl9Cy1dUD6iV+W5Z+SSxKDulFSOsRZ/g/EgY6
 0kKYGd9htZKcI2TE3Bqr+KttDhBFcq/bTI9j0QehFKkxziPf8rHbbj1+wv9ftOMHkPKSLK2Ox
 lGt3hCri+NT36kR9XCEgZOb2/wZN/5QqGVEz4i39WMFK7vq4XiGVLtnjAtgktPY57MLuKPNKj
 HXxRu1TQvSL6hsT3zhHHVE5v/Y7ZPZS5e10Qbjid+MYeBqw7dimRTu+tWNn+IzOhdalM/HXR+
 CRUPsoFvsP/ZQSJT4DUv0JA9wwaMM/ZmRWpaLmk2REf06/SLHoopv6OeX5iXkB67pfy+ULars
 2iBDYKiWr+Xi5qR438Tqs+kvgdetOpx/+B4S/OCRykt4hDEtr/7chgKZSPJdVLZUPX5GMr2eO
 gqqoqW9ZPt5RbKcB/3uPd0v5wLLTJ55YUcRHe9a4KuzaFVxp3BbN30Hb66z+BRgtb8Sczmm9/
 En0uNUS9Dznt/CyoUc9rqpjxExCMVXNkVNXLjJT0K6ecy7+tlvjZqGGMnhPFnV10t4xjeh4dJ
 ZwSr1KOm7PnHOtPaWFbPknvOEWY32jGBEIRU6M3tLlqmDCADUnXXMEkFCWOk0ThXg3M8A/hea
 pGPbn3LoaFFliFc6PAPz0Li16DWewoSm8gI2zJOGdh0fpP3ENKvK3vJpezBI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZYAcigEb0ZXvUh1EkJJ1WIWoU6lO5sMCK
Content-Type: multipart/mixed; boundary="p4XNpjCL7o2wIu4UsYOIZfqzrdrMdkphi"

--p4XNpjCL7o2wIu4UsYOIZfqzrdrMdkphi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/21 =E4=B8=8A=E5=8D=886:08, kjansen387 wrote:
> Hello,
>=20
> I had a btrfs raid1 with 2 4TB SATA 5400RPM disks . Regular disk I/O is=

> about 2MB/sec per drive, ~40IOPS, mostly write. I had ~150GB free and
> added one 2 TB disk and started the balance:
>=20
> btrfs device add -f /dev/sdb /export
> btrfs filesystem balance /export
>=20
> It's now running for 24 hours, 70% remaining:
>=20
> # btrfs balance status -v /export
> Balance on '/export' is running
> 1057 out of about 3561 chunks balanced (1058 considered),=C2=A0 70% lef=
t
> Dumping filters: flags 0x7, state 0x1, force is off
> =C2=A0 DATA (flags 0x0): balancing
> =C2=A0 METADATA (flags 0x0): balancing
> =C2=A0 SYSTEM (flags 0x0): balancing
>=20
> I have searched for similar cases, but, I do not have quotas enabled, I=

> do not have compression enabled, and my CPU supports sse4_2 . CPU
> (i7-8700K) is doing fine, 80% idle (average over all threads).

Are you using qgroup?

If so, that would be the cause.
Please use kernel newer than v5.2, which contains the optimization.

>=20
> Is this normal ? I have to repeat this process 2 times (adding more 2TB=

> disks), any way I can make it faster ?

Just as Hugo said, cancel the current one, add all device, then rebalance=
=2E

Thanks,
Qu

>=20
> Thanks!
> Klaas
>=20


--p4XNpjCL7o2wIu4UsYOIZfqzrdrMdkphi--

--ZYAcigEb0ZXvUh1EkJJ1WIWoU6lO5sMCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4mPuwACgkQwj2R86El
/qj3cgf+Lrn31TzP9Lb4jnnNrtlWkxgT2IPS/MHocAsBwSzSiphcTXgpTPY3Hfpb
mTN7GfIAIxwWoM1mRmcMKU0G7HYS7GF4fXeqLs0P7WgVVVCdpoSwCyvFp3nCbzc7
1hGV5b75yHncMj2ylja8pjIL5rv/MCkS7KkNcVlz+5ItPlHybvpMMl2cNqJzu8QK
bPN7uIvoIBH7Y4AELeiOzEl11LI7uaRXwmZMbqZSdeiE3xf8DQ8XxC7neDjvW+Ad
7klQwz8B+bRbji3+b0NQ2ktOl3mhJfLEqvh19gKYF+8G+lZT52GBayGUAcMcziXx
Szbe/nqnJGq7zvbliuz4o3xcWG+ZpQ==
=5KJM
-----END PGP SIGNATURE-----

--ZYAcigEb0ZXvUh1EkJJ1WIWoU6lO5sMCK--
