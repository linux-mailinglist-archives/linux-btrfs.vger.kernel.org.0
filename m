Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231E817A466
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCELjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:39:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:40965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgCELjs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583408383;
        bh=KZD1ecu7rHVy1iHfgpq3EB67YCf414v3yuMYyD042RY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Jy5t8FHx6G2rStRvZu74EU2VgSQneYtdJ8TDl8uexJwsPPqymGRCUuT1nhrRVRGgT
         ZBM3N0PsdrK7wOgNG9KSfLsUcF27CpfqtF+p+vr07c6+4Z6ZTKUy536NEvtUZ7DTQQ
         Wr4bsO8FVMGNuLYKVAVmib1IqzY3zHdEYLzaYtZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeMj-1ioYvd2I0x-00ViWF; Thu, 05
 Mar 2020 12:39:43 +0100
Subject: Re: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-5-josef@toxicpanda.com>
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
Message-ID: <f77683bc-c644-25a8-6d97-fbe339bd5f98@gmx.com>
Date:   Thu, 5 Mar 2020 19:39:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161830.2360-5-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4h7EpSC6wxETB6m7Tv3reExkgbXAuvkiC"
X-Provags-ID: V03:K1:YfX49xQldkcEZnO8lfRmL+8DGaVssi2x6rTpE+qQqBmq8KUaUDF
 K96uKiVDpWN3SNj2LlidOyWhrr55iGxzh2zTJalWTI+fRKqdxJozCSxP37a4YNFGyPGeZxD
 ci+mx6jXsudkjXVmnp5kcFt2/ZQ5aYVxJPwocaykIyOCqIeMvvXqw/Kb9gTXL5vWzAVezkA
 eR/GT8IsuINZ1zfEiYb5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tWwFXO3QepY=:uYGsM2GPqtowZrqwuxfTii
 EzFAkYI/5YIE58PSddQUHOnHYI4sbRWu8BjF9LlwQyEtFpLDUaGPUbP6nw1fwueRCMOB4v6H2
 sfJ8SZKE8QcE3U3xnymrxsxc6leecRyKcAKrJGOcvsYPCSjuSX4EZeyLVoFBKrJt/14BQHtO+
 wekxsm7CNuaceWDKEXm/1J8mc15I8i0tLbQuiFk75sQuTB7nW11Z3f5MtpFgMzFmdVItYn5C8
 VK4E76s976pXIIaDY0HkuG8UdYc8dY4NwcvoUeFijf+9cZHrZK+43XJtERIu/1STLXkyd9VTH
 nOytZIaFeUrisyi3n3NKOL2193b/6IcI9IKiHBKt17GabMA61w23Cc+gMPYjsYJ0JzJtXJEUo
 kIhTrDJ9zWokMUuDBr3anaOS30XhwhQqnOLtaFfWG7ObpL/QbtGldjEknvNcsHEMy5GsA6cPZ
 VutjJuSvOWsNFg1s05EstLCtWxzHJ1z3JY2fOTeBBYRieGtd7pHpSOOt0CU7ICFf5jI4O7Axo
 EGQudi4YGMLrViOpyTimdk7436Na5o8rrBdVabmkgE0122EPdMr92SFMYSUP5j6UEDk0LV8TK
 yHDkjm1GK3eWQ3xIDDKhzazHZ3S/cF3ecDk8b64JWeI9il0NaYiXDp8suQaSDBchFmell/bGp
 A1VHtAAQqfQce4P85p6cJyx7xCdkb6TQ91K9xGRxMggwSD0WnlXPxG2twN0xc2ITv7OsRZHWG
 /iAhrxaiC6ZYM+wiHza27drWH+/uMSCFGt/I+3qwPcR6hFQdGp+adq5CM6OgZKR89IjNtaj6i
 6WU/OT8lG5+3FHGKXMg7/bcHtO63+yA+keBkL6hAapQgTZroUVL8GuOw2rvIVrps1BqJAV00o
 UJudQDuZ2OE0FBxKLc6OAQEOpvSgRi6Ff24bj0YW/TOpab+JG25nCungS6GxQ7xv3iGh0FPRd
 lv5gkCSQhYj6VFEsEnTT6XH7UnZDEAweZTYDzIM4Am3/5lo4AbeiQNIE7YcO/IN4kY9r3CAXS
 ROQ9rom2S9u2RYMpmOIqZJgN2dYsGRxv/vIpogKhoKEw5C2lsYD/pafoKieKarHjPuq07Yp4r
 xrJBnsx7Kxk5Jjo3eAL052kgm1LzLF9pLIooFD8vmcLus9LAOOA1+anfcNW3JsdqFdI8YDcQ8
 tWANQOlSHXvnU8ewzs8w69ncwVUacgjiuai5zeUKStO7s4bPDevNiiZHPsVWdxC+7nITU4g9l
 VcDiZ8mPtcY4lZ9g0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4h7EpSC6wxETB6m7Tv3reExkgbXAuvkiC
Content-Type: multipart/mixed; boundary="hVOK2qeHKujfnbiHrChevusvE1bkuvdBH"

--hVOK2qeHKujfnbiHrChevusvE1bkuvdBH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
> If we have an error while processing the reloc roots we could leak root=
s
> that were added to rc->reloc_roots before we hit the error.  We could
> have also not removed the reloct tree mapping from our rb_tree, so clea=
n
> up any remaining nodes in the reloc root rb_tree.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index c496f8ed8c7e..f6237d885fe0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control=
(struct btrfs_fs_info *fs_info)
>  	return rc;
>  }
> =20
> +static void free_reloc_control(struct reloc_control *rc)
> +{
> +	struct rb_node *rb_node;
> +	struct mapping_node *node;
> +
> +	free_reloc_roots(&rc->reloc_roots);
> +	while ((rb_node =3D rb_first(&rc->reloc_root_tree.rb_root))) {

rbtree_postorder_for_each_entry_safe().

So that we don't need to bother the re-balance of rbtree.

Thanks,
Qu

> +		node =3D rb_entry(rb_node, struct mapping_node, rb_node);
> +		rb_erase(rb_node, &rc->reloc_root_tree.rb_root);
> +		kfree(node);
> +	}
> +	kfree(rc);
> +}
> +
>  /*
>   * Print the block group being relocated
>   */
> @@ -4531,7 +4545,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_in=
fo *fs_info, u64 group_start)
>  		btrfs_dec_block_group_ro(rc->block_group);
>  	iput(rc->data_inode);
>  	btrfs_put_block_group(rc->block_group);
> -	kfree(rc);
> +	free_reloc_control(rc);
>  	return err;
>  }
> =20
> @@ -4708,7 +4722,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
>  out_unset:
>  	unset_reloc_control(rc);
>  out_free:
> -	kfree(rc);
> +	free_reloc_control(rc);
>  out:
>  	if (!list_empty(&reloc_roots))
>  		free_reloc_roots(&reloc_roots);
>=20


--hVOK2qeHKujfnbiHrChevusvE1bkuvdBH--

--4h7EpSC6wxETB6m7Tv3reExkgbXAuvkiC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5g5PUACgkQwj2R86El
/qgTDwf+PooKLrG4YPPmAc7hD8A0sXbLN+RjI2pBsvDSbLPNendxd45m1OK/sy8+
/aDBf2QkXtkGTX1iCVj6B+M2ytYROlYkBmmEes0WJRBgMPMvx50vgTle9TXSzk93
B3KevGVsOImt248EcOAPH9s9Mifgs30vo3OaK8CZQ+qkw6DpZHSIllmx9s7Gcci+
DOlg96I/jd76BvQXjIw0YvzRMQgyq96bjhsOLXFvja5qrQK/TtAP2VTZK2SK7IAQ
Y2whJT72qchRJ0EAa8a2yfPM4G1jvtOWFHrTpu4PyT8oUbUEUnWnQiWZoSrlQe5K
OS7gUwxgQudppOS3zjtQkCO3porA+g==
=SgMH
-----END PGP SIGNATURE-----

--4h7EpSC6wxETB6m7Tv3reExkgbXAuvkiC--
