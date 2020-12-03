Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC492CCE20
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 05:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLCE5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 23:57:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:39299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgLCE5S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 23:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606971342;
        bh=zDmc+Ze66U31QH9jx7kC8f2QM6R5CH4te5gnuao5Vcw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Z5bpo4lNlbHGQYKcvI7YDVMCxuqyXfVzsSEaLH6bJbmNeJPrvMPsVX0Mh447gytab
         jsIYvfSq7uyC2B6EAOoAHvxyCusmUJd7yQC49ECNfjrONu+cVZ65UCJJmgnTDxhwsm
         xUaT0xYYVgYEk6q/57jCJ/Arz6R67rFBUK9Hx8Hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhuU-1kyPuh3tpK-00DscP; Thu, 03
 Dec 2020 05:55:42 +0100
Subject: Re: [PATCH v3 36/54] btrfs: convert logic BUG_ON()'s in replace_path
 to ASSERT()'s
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <118c78ea8991141e12c404753fa851e055de61ef.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <086f125c-a118-d761-4497-b4af20c4d409@gmx.com>
Date:   Thu, 3 Dec 2020 12:55:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <118c78ea8991141e12c404753fa851e055de61ef.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3ZcPMQh6r5iwqBpzOkWpVIwYjjuxpj1Rb"
X-Provags-ID: V03:K1:Q664XzSuFri7XOo0P0wwWiXsKhjfQF5NN6eHVneCJuNwMEVuOUp
 mTPiFE9Bi/lKBmWFsox32KSUJRbpfdXz61a20KrHxvdXdR2n0qm8c20ekxYIkDovCAsI6uX
 qcJSWfLDZ2sHj1n8kHcIyll76qbn44N9r40aaMcCicT/eF+auIjvbAfOfwIZk+mjtbm8KFZ
 MLtt+D/SmkBsb21mmUmyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZKB3Pu8RjxE=:Sxpchglj5GXmuyb8c1FO4n
 zHbZ2Nm/8u01qPeYxyBdYmr/+zmEc2LdPEQHTmB5vHSfG2hM6eTvVDt5W9xF5cSDTzFjmKQ9T
 wvjtVMzHeJMUof57s40ok43B/BDQiB8+mBPCIGcbs0B3o288sbQ48lw0ziSTJVb+RSnLaAwCe
 3Xuz6npCcma2oMRI0HKiqTAvL01Rn9LqWBKUj4EvAXlQL1ZI47qOZlG2NtG5CjjMkTSubF35t
 FgkDYSfkl04KS3ezGKAhO5URjKNVg36fsJgu/+9iLrkM5kuEMF+mwMhFZ5mZb9RfjGf/0AltJ
 RArhb0RgsrcbA2FPwHZ676i3Am5IQ7Xb3Cgvd8BPjrLNgqbK7iWnXjaCw4rrpzrPQUUE6mAAZ
 rJl+uCrGhCaSX/pRR1TxutLMgb48ilek6pXfGgOoWiPiGpm3gPgaoO6p6CIZC+ZfNG3ftMHzc
 1Tg9Pw/ABSiSR8uta+I0DSZfXOxxtqftsjDO4JwCZh2Ppyu6zIR4aao0/5g5tL+b22UWceSDd
 IZ6LL/S+WOSWeowj9Y7Y8whhgMeavFqebCRTTukR5+z7cLnzYxNPmNmWAPYNjpWRiCGPnlbR2
 rm6VaqohUjPTdIIL7d8FDxlhy0217v4NTWjvvbUD43bjRV9iI+B4GYzX/8YLC1rHpuKgObxZm
 qGVYL29K/Jp/BOPplJjVHWKK+J0nFGnNt2DKZFI3kPyyfyCB4wwjoYqNYwk3nm79VciM+07sJ
 owzAXsU5ayW80Oqr06LTEC0GU7nmKIhEUxLy2Ta++l86nssC+0dAnbvxkvwLOGDWZHo4uux3F
 G3KrI1pOJzTqqHYj/d4+DFFfM5z90GeqlvrPS6xyxiAwtv3YIf5PVXTw1g/nIpdwtjAjLY7bG
 QQpEe+k25FwFnrVpzZ0Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ZcPMQh6r5iwqBpzOkWpVIwYjjuxpj1Rb
Content-Type: multipart/mixed; boundary="LDFowbL8uLxRZocMHRLGoejL4Vy9X1v7P"

--LDFowbL8uLxRZocMHRLGoejL4Vy9X1v7P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> A few BUG_ON()'s in replace_path are purely to keep us from making
> logical mistakes, so replace them with ASSERT()'s.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Indeed, these are really just to prevent developers passing wrong
parameters.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 2fcb07bc8450..b872a64de8bb 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1202,8 +1202,8 @@ int replace_path(struct btrfs_trans_handle *trans=
, struct reloc_control *rc,
>  	int ret;
>  	int slot;
> =20
> -	BUG_ON(src->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID);
> -	BUG_ON(dest->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID);
> +	ASSERT(src->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID);
> +	ASSERT(dest->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID);
> =20
>  	last_snapshot =3D btrfs_root_last_snapshot(&src->root_item);
>  again:
> @@ -1234,7 +1234,7 @@ int replace_path(struct btrfs_trans_handle *trans=
, struct reloc_control *rc,
>  	parent =3D eb;
>  	while (1) {
>  		level =3D btrfs_header_level(parent);
> -		BUG_ON(level < lowest_level);
> +		ASSERT(level >=3D lowest_level);
> =20
>  		ret =3D btrfs_bin_search(parent, &key, &slot);
>  		if (ret < 0)
>=20


--LDFowbL8uLxRZocMHRLGoejL4Vy9X1v7P--

--3ZcPMQh6r5iwqBpzOkWpVIwYjjuxpj1Rb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Ib8sACgkQwj2R86El
/qjFoQf8CZS0AwQZWk3ClnjQKdmKIArRKm89Vg7EZL/cLPpjN25SAzlvMxlXZBit
KKiAQ3uJ+LKNfJopcpU5KZu/AloGZy7ET9MEnr3JmTG15sXRgMnD5810Zl+PCa/Y
rcPxDVz7rIwvxmZ/rBl2oD9HMoPi9v3a1ps3Z2xItddfG3T3/iIbvhWXXJ+EbHd2
xMqZhuXTMKKuwYuE80NYnihTeMsYG3YCoAfZP78fziJ1nO08fBuhLee037s3d7/n
kyp5Q1xH17+nC/ySvhxDSmMRDW4yX/GxsKtJN6Rhei5SregDi88+5qD7g5PEvL+C
3tUALZg+YBHe3I9uv7H4QLa2DEVH0A==
=kPy+
-----END PGP SIGNATURE-----

--3ZcPMQh6r5iwqBpzOkWpVIwYjjuxpj1Rb--
