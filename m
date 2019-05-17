Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0688621983
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfEQOFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 10:05:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:50511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfEQOFS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 10:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558101911;
        bh=I9D7Bo0QK2bKRcAiva0nZ9i6Pbqe8jbq3g431o5mkas=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fL6KjAojFJIvvswrvoqboQlbhfJc8SrZMq/qChbjjkmxlMXz90lSWtLQcjTGnyetc
         2otD5tBfqQkxVnaMQnm+7lAeOCitTcuq2VIigIJwlo1B6fkl8AcP+mXg1npiOu4Tn8
         QdZUmKF6gxtEz2qpnvTaYPtVMdcnNgp+KW+l2OP8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1hBh4J2re6-00Xbd6; Fri, 17
 May 2019 16:05:11 +0200
Subject: Re: [PATCH 01/15] btrfs: fix minimum number of chunk errors for DUP
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
 <f238d8b46f4645dd8d402007774a8748499e59f8.1558085801.git.dsterba@suse.com>
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
Message-ID: <cfbc6c78-6475-5da7-6186-07591f4a19a1@gmx.com>
Date:   Fri, 17 May 2019 22:05:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f238d8b46f4645dd8d402007774a8748499e59f8.1558085801.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vOFoZG2eyv77xE67vwdwra2gyITnulMin"
X-Provags-ID: V03:K1:rvLzbe1+4RVV6SGV5AOrscrMGu2lm3yIY873yC3DoJ5W4VvVXMT
 mfCicSRnnKtGULCJz4XHrP7KGl6UelNupJ4BLlEmO/7Fp0YThv9CWzq6L6Bo0aHHjpk5UR4
 qVR0e2eU7XKJMlv/NG1dOTu9A6NHX7wb8rJkx/r9FQY+lRoHXdBRzOhfq4sCxGIgtwDa5es
 t0qnhdTfQFk4tX038iyKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7MxJ4quHmDg=:y8mzt9zINfVp9lj3bwX8+q
 Of3SV/qHMmOSb0yQZWNbKI+i7u+VvtKowWwsqoWdYpmaIZykgl1ylJ4IN30grb/+k3ByOV5m1
 X+mcaFP14oh/zW5EviAObYweCfxjuNC1I/OWZklnt3zKGIhV1UajcEIQRApvk7Et3rlP35/iY
 /1IGMRzMILuXRf+sA1aOZ6Hm4wCodmtXVmUqtg65hw9K/F52J0F0stq7LZQhkk55fclnzvOoc
 99bfpE00tr3SjXi5nMOuFreFPPqKqfkCZwHoFDUqfmgRys0N5cqL21xXOnhKKprBboCC6HlJy
 pLkbKf1T/CC0HV2oDuFrG1bb5z/iSSbE0fXgwuC6KQ8rbxm4zRhuGR+IPvonOHWTVmeqsZFrZ
 oo7TMQOy4pbeTqpkY6YC/tbxJa3ESH9Jy2yfacmX9z83w9hhBfKeSEQoPFH586Uz2C3n9mzsl
 F1sn/6fzxz+OlAfOpMME0d/ZbaUOwkYILJAxLFhfabL03Aqvs2QbLbeUYcPySYN4upkAY1x8U
 S25nflQe45CHpF7BaGkbska/1ZPFmMkw3kJxsRThI2oJEO7i8ee8z4Cxd1pVyBNYJ51sx7VNB
 3qMkfWbjgIbHQ3Cox7zLd9CxruLJsjS+ZNu89A8WWX1y4wupVjehP/86az9xKcaSatwNyWf6b
 d4xM6CI5gS2LeArGo+7TAKRVSlvzNMJwRr3Qnb8gO8HsoJh2NLiCg4bhKcTothvc1gGpOYurE
 kuNj/0Ze7ufEBn6FgdaS8Qp8naNSoOrmdMS5YjN3Ec0JKk6+DGugrvd1O/DT6UDpW+Dq71yiQ
 WYFEhTApud/5+U2tW44FEdfbBTVECrZE2iYjoWUfCZggmR/h9V5Uw3YXVvlgM6wkKiCieY86k
 mCqmo9RsdcqyWDHRp40z/fKcwgbL9WKIYaXjLQF9XsPqO3+VYDnFLBRI+ZMIew/fifp4MHPIX
 2hmw+zthv8eSdzXIvzcTLy6ibiN2E540=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOFoZG2eyv77xE67vwdwra2gyITnulMin
Content-Type: multipart/mixed; boundary="ccELuoave8Iat6GzMRLcn0WL33eGh0ioK";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>
Message-ID: <cfbc6c78-6475-5da7-6186-07591f4a19a1@gmx.com>
Subject: Re: [PATCH 01/15] btrfs: fix minimum number of chunk errors for DUP
References: <cover.1558085801.git.dsterba@suse.com>
 <f238d8b46f4645dd8d402007774a8748499e59f8.1558085801.git.dsterba@suse.com>
In-Reply-To: <f238d8b46f4645dd8d402007774a8748499e59f8.1558085801.git.dsterba@suse.com>

--ccELuoave8Iat6GzMRLcn0WL33eGh0ioK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/17 =E4=B8=8B=E5=8D=885:43, David Sterba wrote:
> The list of profiles in btrfs_chunk_max_errors lists DUP as a profile
> DUP able to tolerate 1 device missing. Though this profile is special
> with 2 copies, it still needs the device, unlike the others.
>=20
> Looking at the history of changes, thre's no clear reason why DUP is
> there, functions were refactored and blocks of code merged to one
> helper.
>=20
> d20983b40e828 Btrfs: fix writing data into the seed filesystem
>   - factor code to a helper
>=20
> de11cc12df173 Btrfs: don't pre-allocate btrfs bio
>   - unrelated change, DUP still in the list with max errors 1
>=20
> a236aed14ccb0 Btrfs: Deal with failed writes in mirrored configurations=

>   - introduced the max errors, leaves DUP and RAID1 in the same group
>=20
> CC: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just some extra hint for the tolerance of DUP profile.

In case of DUP, either all stripes are missing, or all stripes exist.

So no matter whether the tolerance is 0 or 1, it will always work.
But indeed, setting it to 0 is more accurate.

Thanks,
Qu
> ---
>  fs/btrfs/volumes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1c2a6e4b39da..8508f6028c8d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5328,8 +5328,7 @@ static inline int btrfs_chunk_max_errors(struct m=
ap_lookup *map)
> =20
>  	if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
>  			 BTRFS_BLOCK_GROUP_RAID10 |
> -			 BTRFS_BLOCK_GROUP_RAID5 |
> -			 BTRFS_BLOCK_GROUP_DUP)) {
> +			 BTRFS_BLOCK_GROUP_RAID5)) {
>  		max_errors =3D 1;
>  	} else if (map->type & BTRFS_BLOCK_GROUP_RAID6) {
>  		max_errors =3D 2;
>=20


--ccELuoave8Iat6GzMRLcn0WL33eGh0ioK--

--vOFoZG2eyv77xE67vwdwra2gyITnulMin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzev5AACgkQwj2R86El
/qgLIAf/ee2JG+XlDzz1qh1C29SOhJdneRswSS2Ci0Fk86/0REq/wwaGaZDEPp67
3pKhZtGdNJWvLFEDdPw8Ob1DsU2osc+avgEQdtQm5v9d4IB88Ic2im7qdzGIJzxq
ztjJx9MDUaF49lXV2TcUhxVy9UhYbR7MX7WqjxsnxzvDSJgf2JofJfRKnzW0Rff0
3JZO8b9Lle1gIDDiEBVaYJoto2OsknZl68ETWy3V7+CjZ+Wn6/0MIsUFEmj33gzX
b05dAI94a6W2fWHSymncZIGBezTGeUTXFFaDcjgCkF5RtZf+TMOHKsWWgOC15Y97
ESSJypha/g4HqCqyJzqiynHo/CTFmg==
=w9ZF
-----END PGP SIGNATURE-----

--vOFoZG2eyv77xE67vwdwra2gyITnulMin--
