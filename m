Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BE181908
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 14:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgCKNCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 09:02:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:37447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgCKNCB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 09:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583931714;
        bh=Vm8kvVAsiP0wEMFc+kO/+oHAiFLYcuay6dKD87YC/Kk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jGlWRW1Q22lCjKbauyjzh/qgnnvTOzDwUxWUas+aw94o4X35uj4Py15m9Ss5e2bhi
         Y0wOhNKVIRCW8Jwi94xTNlgykWJOK9S+nPkskUa08KPdVzcVBs4xpTy7Wd7R6TsmHn
         H67WbU5hw5L/uBEDj3WD5310AriV7RhEX0eGwzcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1jlczg0WfK-00ZydZ; Wed, 11
 Mar 2020 14:01:54 +0100
Subject: Re: [PATCH] btrfs-progs: match the max chunk size to the kernel
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1583926429-28485-1-git-send-email-anand.jain@oracle.com>
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
Message-ID: <7e91f1a2-cb34-1330-9a11-1edca8232d4c@gmx.com>
Date:   Wed, 11 Mar 2020 21:01:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583926429-28485-1-git-send-email-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UlAZHgFHyJ9iXcUdFC13Gz6Qz9kPgZxFU"
X-Provags-ID: V03:K1:gA/PH+YHeHg7caCti4P0H+WPPlLoECs6xJkWkv/S3SNWVaBLsp1
 v60roSfu6d3zvbELkE2XqhFqpCkJfSCD9+e8Wy/OHwACOqNaa9+BPz9SFMKE16hAnR8EGhB
 BPR5GT2UjnWqk8A0EHf0Nsl/UdVoY0HrJYYRbQDLnkUlhHkkm+6p4BAwkc4heXdpCVkFVMw
 EAof5ZAKlqEaAB+NS4JDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2r7Dpb55JHU=:NMIonnZf3E4uCJJ0Z1184c
 7pVRfbgt69zA+2q20fSJ+HpdZgAI3FAZyj6MPlsj0RpS49vt95yUUJ3T6bpqO2QlRk6Gf7/Z8
 MUS5cCKasG/8bii4P+d6b6dk+SfaQUpV2y+qNdSp5jqnnxLFI8RCFq/GhLGzW+AxOQaR7BAu2
 tCvDcitrwIpNG/1lpmi8ju5GmT7yAFk+JjGXchPKibQdvLtA9EJyMrLgVQGk+jj4SxwjaXM7K
 s3FM3jRxljEDY4OuNXSwNTx8HK5VGatdva6I7JnmjoDiHqOKPf/pR1EyhGwUKiWwEF9BEBroq
 4W8Cnrhtdf410aCsecPw+n9CGrp0T+eVhE55pZF2ofpdu+06oANuxD+2pWezwHCUTbRLhRlHj
 XfVbZMF0sMhZg8HJiuGBeEwr72DSdLY9gmaxPQhjpvq89phaLhvMMC3cbwg+d8273j+s5yP/V
 ZSYMA+TomEWcpoOmjxkpsVyf+uHBh0aDkRijQTZNDuqumOLc/Hf1fqFwE+dgcHL96/lUjlx5i
 HMmfESInuj4M3GUZwdSVgAEf+ozPIeVYWN291N886lgx7XiyQ9DIh+CiriK1x7M1bhItDDh9G
 Wtghb1hTSfX4KpGsqgB7/Vh/zmcOaDbX+TIxNEZ1bGbuIk5vZXxkaMMqeEtr+GMogI+nQbFM0
 BqMp4IzrHObJa6wtQ7WaYhwQbOvFL9a5pSf6dcy2RVYzn2JTB5xo5VIZfndQl91yzJf0XR9cZ
 LuEXNJISNbtesuPPOO8nQuP9n0qsSE/cyLnYIfsF1V3dYqa/W6IdqlWMLsGXMokgHkzkSs58s
 Z1/bfCRmmVqPlK1qtPMoYEcOPXQdUWxYPxVVw6ydIL1a3wRSPepdrBTj4CICmXrDlq/Z7NO4c
 dzrmAqAU9zc13Yvr8J8gS+GX97H6rHDgbbOo9aOmEQpA9TMNt4Rmdlo6RDDLeTm49AxuBe/Ye
 XFff1aCD2aglGFXAW9amBY2+mb6KRY77X7qWJaQZB3g3J+fVaJHjZkBBBehe7H2h1B18A0/jH
 N6uEPREpkL8Lst9obsSvGf2qy3B9klMb/FgBLS8O1yU0o5Dyjo0cL4+GqhQyFRIw5vdN1XN6N
 2WXJe65Y7Mcnf47x7fgUoOphK2N+MSW8/fnjiJcp/8OAcNFHIiqFNzYDSV7Z+RLdFtVkSoYG9
 XLJjsENZLXYkG9rwUZzGqvVjutkY20XxrlNopiZ5qufGbU/9Lai9zqQt3eq3zV1ca5zSo5D6r
 y0McdmIAtvVurqi09
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UlAZHgFHyJ9iXcUdFC13Gz6Qz9kPgZxFU
Content-Type: multipart/mixed; boundary="rbmaS1UZxwUrSZ7zBIPqUMGOkNOUw3Vr5"

--rbmaS1UZxwUrSZ7zBIPqUMGOkNOUw3Vr5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/11 =E4=B8=8B=E5=8D=887:33, Anand Jain wrote:
> For chunk type Single, %metadata_profile and %data_profile in
> create_raid_groups() is NULL, so we continue to use the initially
> created 8MB chunks for both metadata and data.
>=20
> 8MB is too small. Kernel default chunk size for type Single is 256MB.
> Further the mkfs.btrfs created chunk will stay unless relocated or
> cleanup during balance. Consider an ENOSPC case due to 8MB metadata
> full.
>=20
> I don't see any reason that mkfs.btrfs should create 8MB chunks for
> chunk type Single instead it could match it with the kernel allocation
> size of 256MB for the chunk type Single.
>=20
> For other chunk-types the create_one_raid_group() is called and creates=

> the required bigger chunks and there is no change with this patch. Also=

> for fs sizes (-b option) smaller than 256MB there is no issue as the
> chunks sizes are 10% of the requested fs-size until the maximum of
> 256MB.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> The fio in generic/299 is failing to create the files which shall be
> deleted in the later part of the test case and the failure happens
> only with the MKFS_OPTIONS=3D"-n64K -msingle" only and not with other t=
ypes
> of chunks. This is bit inconsistent. And it appears that in case of
> Single chunk type it fails to create (or touch) the necessary file
> as the metadata is full, so increasing the metadata chunk size to the
> sizes as kernel would create will add consistency.

Have you tried all existing btrfs-progs test cases?
IIRC there are some minimal device related corner cases preventing us
from using larger default chunk size.

Despite that, for generic/299 error, I believe it should be more
appropriate to address the problem in ticket space system other than
initial metadata chunk size.
As btrfs can do metadata overcommit as long as we have enough
unallocated space, thus the initial chunk size should make minimal impact=
=2E

But don't get me wrong, I'm pretty fine with the unified minimal chunk si=
ze.
Just don't believe it's the proper fix for your problem, and want to be
extra safe before we hit some strange problems.

Thanks,
Qu

>=20
>  volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/volumes.c b/volumes.c
> index b46bf5988a95..d56f2fc897e3 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1004,7 +1004,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *=
trans,
>  	struct list_head *cur;
>  	struct map_lookup *map;
>  	int min_stripe_size =3D SZ_1M;
> -	u64 calc_size =3D SZ_8M;
> +	u64 calc_size =3D SZ_256M;
>  	u64 min_free;
>  	u64 max_chunk_size =3D 4 * calc_size;
>  	u64 avail =3D 0;
>=20


--rbmaS1UZxwUrSZ7zBIPqUMGOkNOUw3Vr5--

--UlAZHgFHyJ9iXcUdFC13Gz6Qz9kPgZxFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5o4TsACgkQwj2R86El
/qhnwwf/fTHSjbDlocDpU3zD/hytR6qtEo08o1j6dbyNzSkWT/ueT0fVC6eTkgzP
27phVMDRoeH7g3Jw3EeDspw0B3GXT/cQGPzVt88/OK2zdIQGVTGjer8LT1raXrM4
lm2/11FuecWK5r6YGNcQQlREyltwbTTQvwuiNKo/i8ZQzzINYYhbtOpXUdPd5Ave
FH3K75jfcx8QHCFsT6quS8KL5bksTNGjGPRFNGlG3yTB97UHEdWwsXhqm/kcy7Oa
EeiM7UOyV072qC6m2MM9E5C/EBMSzxTwXfdycK4PTj+dF9y7/r8jmpuru6YkQHb1
XfrId5sQ5YP6RJed75G3Gvt9e+G3FQ==
=UDqp
-----END PGP SIGNATURE-----

--UlAZHgFHyJ9iXcUdFC13Gz6Qz9kPgZxFU--
