Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F288775
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 03:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfHJBGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 21:06:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:44301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfHJBGd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 21:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565399188;
        bh=6JFBdlV54VhWatuEqDq/YWV+qTIK8ShsYXgWZcltVUI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Yqpq9CEQRCuNoajHx7qve9H+PbIFLXSSoKLy6T/nbzpuIn6NkCyxRSObj/VMtZjp3
         /ybg4keINZwiGo4ItBk0wEZz5utu4Hst+YkNGqaTLZAHRp6BM+/es9zeICCRRNiI5r
         CmBPmaP9hG4/Go3SbtzP8s5g5DAGSAHypTb3Qh0w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MSY2q-1hmSlL0xQi-00RaKl; Sat, 10
 Aug 2019 03:06:28 +0200
Subject: Re: [PATCH] btrfs-progs: don't check nbytes on unlinked files
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190809131831.26370-1-josef@toxicpanda.com>
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
Message-ID: <dc439be8-0a2d-458d-c7c9-9558322c8c19@gmx.com>
Date:   Sat, 10 Aug 2019 09:06:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809131831.26370-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8NUUDjnuSLkm7ghKmLoGcCYIQpezVAAUl"
X-Provags-ID: V03:K1:wY73rhuPWzdtkJ3MjUuJmowkraAwSqjBHqjRfONYULMF8jxnugK
 N1A/gDPGg9+aqcEMULKjlG1uPadfsnBYA/2NDo2Ifp9RiXJ/TDAHewYO7BPyX0PmArxuUuv
 Nr/jgyvKkFkt0P3J/eMt4yMY80IO/0e3IVjFRYpssOxwnZFrNjhJ1EgaZudRzt4X2LAFS6/
 RWdK16ASxdC9OKP7opJ9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pVNQSHweZr0=:2HvVVgi7vsnr3Ewlue3wZl
 cxP+wUv/vVeFA9nGja/IHjCx6Jj2RSJf4LYvilW+d5wN+UuEvYX2M5GNy6GNPSLc/HOd6QT1g
 G+5qCRn5/x8WWZ3vSvFVc/CKtjZ/E015kJjs9jNiWiA0Du1gRr8TzfY7Xq7glMkiGGJ2ew+HW
 jrEdAVjmoQDB3SoGjDX0xmC9NY06pFLsPo8k9wGRRKref3gNR66XdVxGft2XhJnZRthpLe+dF
 BgcTeoOkrcO1OhoKYtfafYC642tUY+dv/pQK86OtV1Fn30VzqEP5agEGbOjT4sJR9UAt60SdE
 6IKAyWqQU9pRruG5f8fsgXUCI3gA/U7qiHB729+ohFJBYLKxfmgAsuJVgQHZWzCJQds8g8piY
 OQhD2JgvvOFzITzXuNsxeo1l2SnBuSx+Fng/JlPe4EFiU8IK4AfDSMIdb+d45ikMum8Xo2zWk
 FywSax7lXdoyUFHuKg9NEIT4OFRTgKzlmvpePd9+rYUmJKoO6EHyAJBtJTUFliE2zzSxj++Lv
 Qcw/D7ceNxntDLAtn+zbHnFSFHOX2AfcIXsqdhTOkaFaw+5yg0ryOyqslYL1ggZ2mZsq8qzLo
 vG89CZAGdPM23l0JrTOYNuQY4eOfA6AzcfK4pgfHnUw26iDGT2Zpc0h+cKAAUX6h2s+oHBhKI
 oc+SzXx9D+dwaKcmRHLxqje4rSYc3Fh2gjSoXvvkPovICbKindmRWR0303wUe2pww43uV1O87
 82o9vEXs//K4dMJLENlpHM2a1FoJ62cfeX0fmpvHks0v8i+bvDK/hn2iNvWzF7CeGFfr7KjTE
 MiA2IYrSlg+RVzz3h7KyqXA3EP5OA0piu01Ba2MTmVRU8fJQtTN85H2//Z1pXBcKQmLFqxLfu
 A1J1T2ZtjPlHSiSATeGZi7Xw20P9NDFl/vUjVdiJn/1kHh1ZPvoD9/lZNmtJ/CwV8p9y4IuUO
 GrPWj/3kyn4N4Ygiju0woGcHbNo3v2sIdPDh1ostLqaSMFlVBL+cPo1Z0YxTsowrnMj9HAjmN
 EG+vwGC2wb9yXSIF3n9Fr8gZnq2ZLjoYwzkcSFounrO8qShykwhNBi+8K/ZWJWU/OppnMgiw1
 zZh4O2kqhLWppbMmFjylFoMFyS8uTE2Ts4QQyN0wW13UWzCmjcEhvTUmQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8NUUDjnuSLkm7ghKmLoGcCYIQpezVAAUl
Content-Type: multipart/mixed; boundary="yUA8dTwP6hLqsMui71sjgXArL9t6DQVeQ";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Message-ID: <dc439be8-0a2d-458d-c7c9-9558322c8c19@gmx.com>
Subject: Re: [PATCH] btrfs-progs: don't check nbytes on unlinked files
References: <20190809131831.26370-1-josef@toxicpanda.com>
In-Reply-To: <20190809131831.26370-1-josef@toxicpanda.com>

--yUA8dTwP6hLqsMui71sjgXArL9t6DQVeQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/9 =E4=B8=8B=E5=8D=889:18, Josef Bacik wrote:
> We don't update the inode when evicting it, so the nbytes will be wrong=

> in between transaction commits.  This isn't a problem, stop complaining=

> about it to make generic/269 stop randomly failing.

Would you like to add the same check for lowmem mode?

Or mind me to do that?

Thanks,
Qu
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/check/main.c b/check/main.c
> index ca2ace10..45726e6e 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -807,7 +807,7 @@ static void maybe_free_inode_rec(struct cache_tree =
*inode_cache,
>  	} else if (S_ISREG(rec->imode) || S_ISLNK(rec->imode)) {
>  		if (rec->found_dir_item)
>  			rec->errors |=3D I_ERR_ODD_DIR_ITEM;
> -		if (rec->found_size !=3D rec->nbytes)
> +		if (rec->nlink > 0 && rec->found_size !=3D rec->nbytes)
>  			rec->errors |=3D I_ERR_FILE_NBYTES_WRONG;
>  		if (rec->nlink > 0 && !no_holes &&
>  		    (rec->extent_end < rec->isize ||
>=20


--yUA8dTwP6hLqsMui71sjgXArL9t6DQVeQ--

--8NUUDjnuSLkm7ghKmLoGcCYIQpezVAAUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1OGI8ACgkQwj2R86El
/qihmgf/an8x4dX6NmtNwmaingpUPiRVyMA+kStJmOohf9altNQWWRlpbNrZb8df
A645c0nSsXeOurW1W1AyennCpW1kWQvmRb8cCmKJDFGdgbqVcL+8pK1qx59IQJno
dLbY1jhcNkHFI+Thl4jzqWH7e8+nz3jIi+GUFH8MAyEIsj1rsM2TmkwB+UXCKc50
HUj2hrFcrD6w40OI8YXQYFar7IsLrzSQw1un5TbtMcIbGoz/QAVux12sfYH06u0z
yN5Z7gi45GmAl18wFX7rymWPkDZtRmvL9alk8lbrOh/e1RKKRbUeXxeV2cKV1E+h
h//cP6htc7pItJLBueOX7FHb3GHO3Q==
=zCxh
-----END PGP SIGNATURE-----

--8NUUDjnuSLkm7ghKmLoGcCYIQpezVAAUl--
