Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AD2CE932
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgLDIHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 03:07:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:34191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgLDIHS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 03:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607069143;
        bh=csmq7krbCuJHCZTuxbA+mM5lwyXDlZAkaLWeu4w6ico=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WEa5fnVvVGdqi9w1S0280BQI0hOVsAxLHWQw5bZmv/Fvs9zWVv0NkUauARJTuINqq
         267Z5sr4QfPqoBh5SD4ppsVn0sxYZrv8A4AcJlOfjpGSlKEA82bGWsnApElzkvtEnq
         gtCR00GJzq2oAJdnLDtNg2eYeMauDkVZrpLLiqo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1kvVhI2IC6-00AZFO; Fri, 04
 Dec 2020 09:05:43 +0100
Subject: Re: [PATCH v4 17/53] btrfs: do proper error handling in
 record_reloc_root_in_trans
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1607019557.git.josef@toxicpanda.com>
 <02ccc686cbc2210d1ce995e2066085bfdee68fde.1607019557.git.josef@toxicpanda.com>
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
Message-ID: <6bd4baf4-486b-141c-491a-6db8b389ce2e@gmx.com>
Date:   Fri, 4 Dec 2020 16:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <02ccc686cbc2210d1ce995e2066085bfdee68fde.1607019557.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4qkkGb8W1TAbgZkwzhrOtxnMWbMOZJmwz"
X-Provags-ID: V03:K1:Cvd75p83lAutciEriwixyP5wQUe9fHvulU6LaYmmXGr4Ji5UfMW
 AYI1el1iKPnkLumF5HVaVJo+J2LXlxNG8xcYwK6Wjk3+Rb8AtndBaJGsIE0keJGtkBNq4Ub
 nLBbjyZdguG5EITkbtg78bp7ZySxJc5Y+GAR4TTlBzWV2lCvsM/iWCKc4Ogtfl04aF8GwDb
 B8bxVcmf/Cpa87zzgmD/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8SogHiDHNo=:6p2pLNmTqlvjgcEX9kMAAr
 xyltjL/6f+rrseFmcaSM6g7SMZiwqIkK2saoXr4bFkwDprAyRs21m79lBwfMC1slaGSZzqu3k
 owDC/fMSEuvmnCk+SndnfbQpvOLLpcCs/u5Bhdig9kqwUrblV4OmIUcDdD40i0sgOlwLbAr+L
 kqT1LihJ2K3aEzEQ5dHUUOtInuGLDdZnbL1YZgk+ORGPQruKwTbxcwFeGXELIAf+vdIlGwplp
 lP4EtcLK9aDlepUDSWCVlislNgzfVLiSt/NM0hZr2CSvHnyI5ZNP/iT29EvBjVUJN7IjKQ5y+
 /f4Oq3LdDEfbBRIFl6BQxXJNtVSWV3h4xAkANC3nyVrEW/WS0QYMuHn0s+FSM3x2znwauSOUQ
 7rASloZtMygGkVTN1TzuqZAyiUAAQXMWCyOh78y5+H3pcU+6AE/qkM9BtCQE32NI7GeoWhw3g
 mR95FNVopekq/GrpBa0aCINCQaUz/g5t2+3hRVfJPbdazaUE3PpICHETXvSVGOahVF3SO4AP+
 U525IS2XhlSSnxG+bFemlybit2YJJIr8/RCIbwJTAl3uyQaGvTfxcZi8GEV2RYTZFzINK+84f
 Cb3jOGHc/mWMMC3kp0i0qau/M+uPhO/Olf0QspA915wmpoPpZKwLyXA9sQgli16/0FAim86b4
 m0JMLaimvqfpQuo6ftl2pllr7PQt+s4Tqx4GFR+BK77S/AN+eR587Xi08anxmTXy0kdyJ1bEQ
 7sJStfgqcqs+urvvIXjt6ekQ8df+5TnmrADlWWM/EOzApXQBVKmXkzRZ/DBpLjSCRZS85z6ja
 3FWCfr+shBUFVQgM2nG+rsaMk7bTDxX7I52FUf8Pbj1ilOXV5iX9yBhxbc1v4DHjn+LG9LE01
 76T8Nia6x3N9gfuzqWeg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4qkkGb8W1TAbgZkwzhrOtxnMWbMOZJmwz
Content-Type: multipart/mixed; boundary="L5Haz6tapMe6UITSGzmrp6fgpuJ0v6eC2"

--L5Haz6tapMe6UITSGzmrp6fgpuJ0v6eC2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/4 =E4=B8=8A=E5=8D=882:22, Josef Bacik wrote:
> Generally speaking this shouldn't ever fail, the corresponding fs root
> for the reloc root will already be in memory, so we won't get -ENOMEM
> here.
>=20
> However if there is no corresponding root for the reloc root then we
> could get -ENOMEM when we try to allocate it or we could get -ENOENT
> when we look it up and see that it doesn't exist.
>=20
> Convert these BUG_ON()'s into ASSERT()'s + proper error handling for th=
e
> case of corruption.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

THanks,
Qu
> ---
>  fs/btrfs/relocation.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index a3ad44605695..90a0a8500a83 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1973,8 +1973,27 @@ static int record_reloc_root_in_trans(struct btr=
fs_trans_handle *trans,
>  		return 0;
> =20
>  	root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, fals=
e);
> -	BUG_ON(IS_ERR(root));
> -	BUG_ON(root->reloc_root !=3D reloc_root);
> +
> +	/*
> +	 * This should succeed, since we can't have a reloc root without havi=
ng
> +	 * already looked up the actual root and created the reloc root for t=
his
> +	 * root.
> +	 *
> +	 * However if there's some sort of corruption where we have a ref to =
a
> +	 * reloc root without a corresponding root this could return -ENOENT.=

> +	 */
> +	if (IS_ERR(root)) {
> +		ASSERT(0);
> +		return PTR_ERR(root);
> +	}
> +	if (root->reloc_root !=3D reloc_root) {
> +		ASSERT(0);
> +		btrfs_err(fs_info,
> +			  "root %llu has two reloc roots associated with it",
> +			  reloc_root->root_key.offset);
> +		btrfs_put_root(root);
> +		return -EUCLEAN;
> +	}
>  	ret =3D btrfs_record_root_in_trans(trans, root);
>  	btrfs_put_root(root);
> =20
>=20


--L5Haz6tapMe6UITSGzmrp6fgpuJ0v6eC2--

--4qkkGb8W1TAbgZkwzhrOtxnMWbMOZJmwz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/J7dMACgkQwj2R86El
/qjJVgf+IR53PKdAFhXGWuIU7VULplVMtZZQasB7q3jq9Bb6FALlHc1NqoKef29J
6hJuRkNGrG3HKK0FK6K638PuZjKLRbMi+3OX+4TO1Dz2qApOp/3PpWB2MmxHToBc
3xidtRxGV/DRovvJ0VzwUvDJORYoLygmMNA6+Csu2zkyAsLHzRSENjpbqXWblnvY
rJk4s9/bEWtAD9rOzudoAgJsGbDnzeukKNSKNmJhUwXQJDd5sHRCjqryaHh6QIhB
m5l7IOwAXRl6Wu25k6/ga89lPIyqA/LDnIlZiofgGk3Gir38g8+YYyDx9U8fTcZS
eT/AefKTfxP9jP40Tplb1p8bt4W4yw==
=O5kf
-----END PGP SIGNATURE-----

--4qkkGb8W1TAbgZkwzhrOtxnMWbMOZJmwz--
