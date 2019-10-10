Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D40D1E96
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbfJJCma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 22:42:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:36889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfJJCma (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 22:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570675343;
        bh=dM+OlkJECrH8LJlMXOqHMoXjQmz1rU5CFxgQhHaHJrs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=arAihibmUIs0VTE7jZH+oRAXQynhf4ROOgaKkk5xuMCoMK1bcWrG1zKeyYdgPm7o2
         SdwRFrJB9kOgQGpNJ/19z5tV+jBns2fOWpo3czIiTaGKH3/C8Wc5aFccjqtgj829Ic
         aplMjLnH6iNaiAaMRI334MzXi3uPtAoCV9pFrND8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybGh-1htHPf3v0H-00yvy8; Thu, 10
 Oct 2019 04:42:23 +0200
Subject: Re: [PATCH] btrfs: use bool argument in free_root_pointers()
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191010023925.4844-1-anand.jain@oracle.com>
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
Message-ID: <abc83fbe-2cf1-2ca2-5816-29d87c5fff2e@gmx.com>
Date:   Thu, 10 Oct 2019 10:42:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010023925.4844-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c7piHdXfBn6VqX3izUblidaZJJxxgSvIL"
X-Provags-ID: V03:K1:pTnN501ooyi4JnxI0J08nHt8cN83pOWqDHrF/knwYeNRdup1bsw
 xjW5YhwWJAVkAQzd+neOemlL1hYgvvYxR2/4CDO/X110JyQ0Bygm7fv/jjAKGwMkPdHnD15
 Z55zC/IEjz4V0orikFIbRqQE70eATZ3PREs9OLDt/IvwbHGgia2wLia126JDjLL2LGXf0jd
 KyhKgtPBd6VHju4hmfcaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:14icuNcsSdw=:LPMD+TKDcRWz+ZU4bxE+fw
 TDIPTBJM+nzLMKb4QwifxPEhpF2RBR6f6oxR2L15/5NJ1Sah73VHppl/kKaMQNke1m21ntqHH
 up6CyR09M1cqLjZBfd73nnljJgooyTu6kztwP538uHC0JHDqvQ7WAKL8pY57z51kMoDs05AMb
 rVe/YJH4zETL2Vb7Ofi9DYcfaw25m3DboVJFacCoYzii+xWYI9WYNmfzwcFCxUIevog+y7gJS
 4snO+XPqyttqrKAjYi9qkBEMnpX48xv2tiTFXrHoPNrwO6EqKp1/IitZxuVn70dEKRISUkc0w
 eyTA1DUUrbwbqwb+DWiuCW7bUfWaOGx+Qs6Rbw3fsBvTW9wpMhPVVXZWbI3rF4QzgHs5lCHQR
 n+yDOrpYMmIHljxxHKGjzAU0jvjHdq6AjPLWBg06ONhkEhieWd7tIXAMVjrvQBdJGN8j4ag/U
 rdiualSw2gRer7JI4zZCOytlSryq2NC2WcM2M1xjmMmw2h/0tMWRyx1BH6GHBiKZQdq+ce5yq
 v4BhRqAYn5vAYTUbsbQ8QrJdXix86roFrquYoCsXw/s8mcnxz2AXvvxuXk3pvFYxI3Z+QnAn3
 6rQtgu+4M3/fG4Hv03Nhcz/SgwWF2YxkGYcfMRZfi476refVSzmhVi2Z4s00FtlJkXvIRg5mb
 NygxAbNv9JJFJKkhvesScvcMTrhbEHy66isKPVwN+NHox0Utz+vIdIimbwy8eeawYSVWJd9yz
 VlcUT0cIB0R4viwYgL19xYOFwJQArpyKKYlWjtrXHJ4Qcwy6m4z/t3QBeFFswJoOLBmAhnBfy
 ie6YDedGinKYDDS8N+srN5JqcNjOBamJVhe9TbGsGKSMqSPMBuQ8zHSCTYInP7ia4w9tNFkLl
 UDLV4JPflCPf/KY0twTY9RbH8ADMh70QNL2CgM/2X/k41NPOMa6NJAZGaXcnlfCHvBewzDNYX
 bqwqrYLOgwdNLaCzTyTX+VYWLu+3tJkmSdFmki8xowiyumUILND3+wbJvkmA7cyl1/akryflM
 bxOuxIa3cVrfA8ZxJAN7Izg6P1ZUBj+/AN2laL705jAN8dZ5mk2sL6850c1VYkuQDhWIYcwuh
 QpxdT3wWa4Uag/gjtRD1DrKeVOz4Z9c9KCz19TBQM0j6UIqz710AVvsOIeJd+sV8d3NC55vd/
 ckEJ4rDyBRz6KtWhGOfCFiZ6iCyU086UCY3qr2cjWsI1UvHJ3bux26YHh9DIewN/BiYB28Di+
 3CuJiemoxojGbZwbvWj3AdDKOFcO1JeLrSAQjnBCMdqADbWuAdFLI6AgIwC8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c7piHdXfBn6VqX3izUblidaZJJxxgSvIL
Content-Type: multipart/mixed; boundary="k3n8u6jY4HwmDbdmEs2vPwUe5FznCXUyB"

--k3n8u6jY4HwmDbdmEs2vPwUe5FznCXUyB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/10 =E4=B8=8A=E5=8D=8810:39, Anand Jain wrote:
> We don't need int argument bool shall do in free_root_pointers().
> And rename the argument as it confused two people.

Victim here. :)
Although it's mostly caused by my stupidness. :(
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/disk-io.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f314fa9fc06e..5a0033b6cf2e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2024,7 +2024,7 @@ static void free_root_extent_buffers(struct btrfs=
_root *root)
>  }
> =20
>  /* helper to cleanup tree roots */
> -static void free_root_pointers(struct btrfs_fs_info *info, int chunk_r=
oot)
> +static void free_root_pointers(struct btrfs_fs_info *info, bool free_c=
hunk_root)
>  {
>  	free_root_extent_buffers(info->tree_root);
> =20
> @@ -2033,7 +2033,7 @@ static void free_root_pointers(struct btrfs_fs_in=
fo *info, int chunk_root)
>  	free_root_extent_buffers(info->csum_root);
>  	free_root_extent_buffers(info->quota_root);
>  	free_root_extent_buffers(info->uuid_root);
> -	if (chunk_root)
> +	if (free_chunk_root)
>  		free_root_extent_buffers(info->chunk_root);
>  	free_root_extent_buffers(info->free_space_root);
>  }
> @@ -3327,7 +3327,7 @@ int __cold open_ctree(struct super_block *sb,
>  	btrfs_put_block_group_cache(fs_info);
> =20
>  fail_tree_roots:
> -	free_root_pointers(fs_info, 1);
> +	free_root_pointers(fs_info, true);
>  	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
> =20
>  fail_sb_buffer:
> @@ -3359,7 +3359,7 @@ int __cold open_ctree(struct super_block *sb,
>  	if (!btrfs_test_opt(fs_info, USEBACKUPROOT))
>  		goto fail_tree_roots;
> =20
> -	free_root_pointers(fs_info, 0);
> +	free_root_pointers(fs_info, false);
> =20
>  	/* don't use the log in recovery mode, it won't be valid */
>  	btrfs_set_super_log_root(disk_super, 0);
> @@ -4053,7 +4053,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>  	btrfs_free_block_groups(fs_info);
> =20
>  	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
> -	free_root_pointers(fs_info, 1);
> +	free_root_pointers(fs_info, true);
> =20
>  	iput(fs_info->btree_inode);
> =20
>=20


--k3n8u6jY4HwmDbdmEs2vPwUe5FznCXUyB--

--c7piHdXfBn6VqX3izUblidaZJJxxgSvIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2emosACgkQwj2R86El
/qjVRAf/dJb3kCha6p8LfwIgSVNA8ypSlXR7T5AV2CrNA2e3U6UZSsbn0D3DtF+4
x4+raYFfj2Bsx2poJnuNzypfCpNKWL4j+Gre24nhkxzl92UoAs7WtoMIWn2FjYIl
x3n5jOellSyPNJSb4xwUT1BqBeiVeJFD1eh9c/xIP8QOmcBVgUNGAfEXPS126Wn9
H+6yWVyVs53cChicJyxbuCAlUpXlSVM5STuRspBoaFtTxI7Bd9gkZfto0kU6cdcs
31b6qhfK5czRGkAJg5ARbEO1nTLHNJiX0qS6pIaXeve2B2UDy1aG9a6Hwrk1+l01
a7205j0645arz1K72pBYCfQBA7ThgA==
=w8Mv
-----END PGP SIGNATURE-----

--c7piHdXfBn6VqX3izUblidaZJJxxgSvIL--
