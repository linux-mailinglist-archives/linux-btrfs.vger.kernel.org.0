Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619C72764E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 02:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIXAJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 20:09:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:36987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgIXAJB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 20:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600906126;
        bh=yQZJnGwVNLeTVWmZyejBzY1PWbETv5kxb7q23MJb+a0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aFD+Ix0ZXKZngvJpB/SIXEyLiq4eODO82XNR2A57b5nG6sqtEBgsdo33SP9NAzO8I
         BuFYg/E4egVhcX3o/LIJjdpaYe/xzh+V29iJI7zr4YEhdncvdh0SZhPzdOao9jgQ2y
         qVJvFZycRSpmIKN+pnQBUmUUA9qwbnY3uMMUyEig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1jvqDB1hW0-00Rc86; Thu, 24
 Sep 2020 02:08:46 +0200
Subject: Re: [PATCH] btrfs-progs: convert: Mention which reserve_space call
 failed
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200923171405.17456-1-marcos@mpdesouza.com>
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
Message-ID: <528b370d-c594-6530-62aa-ef9067a2e275@gmx.com>
Date:   Thu, 24 Sep 2020 08:08:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923171405.17456-1-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="14QYZBiyUBVPmgMqCDZgKe6U9qC8dPoSX"
X-Provags-ID: V03:K1:JFfhiE18jiQq5uqw2O680036eMtvU6zUWEajnu3e08x1qbnY0Ug
 4nq3yNUBNjmWKygfj2Uc3jp6G+nwS+IAyfvXjjDr0jXgXduST2UHHkF11qJ/2t0hbywcnLI
 PntzoVR8QUIMEZI8r+dEmklIGCnEJiDBWMsQCLZlVYS6FFQvjOEPH5ATN/usGXipsmq0/+J
 IUc6PZ3fAiKGP/cmnjUWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x3vtjlO15R4=:amvst6daLu19OASWDO0xRr
 8OWS7xchMZVxNjKFKUBPRC3Qd7e4ItRjVYsXVjRlH/QjuIoeXsHcCT9iqIL9m/42AWB0feamD
 3ANTex7Styd03Z9qH6B5aQeNMdRmvymyN//dXJe/GXbO729Eh/ypFycgh7XNCoVzi+s84qk8t
 J6aNaXk74GrWT9P6BxpNBVfKo6adtorGLW6YNF3KK+tFfv94wfYC9gVByUibxWk3AML0eMpUM
 7ULM2xPH8hXXPg0Zy8l6WHwQkgrG4+y3YmlCj2rUlePj01TrVO7KfOiJ/hagmAwVfQkjYDbtj
 vIz32zO3CbeM7GeI1HJZC5dMqoiP3FgaJrTLTYDAP0/11u7PQNtq7EdTRlHhbo3a8SQMAcOl7
 /cE96I0194VNlewqcNQjGbRdmEbR5YeC+HBfkVy9aboscwb7WNirYBBk5ZW2oauVll0ihiuSJ
 kxVJogx4BHnloy8Pwr0Xq+FdJw+d+X3pdjCswG86ukThsCBz2iMxLkwbCxXnLB1DLex/N1KX/
 /fH5VFlaIvQQJygk3GAmVJBlypDeoIwk1tqyLxH4OS1KZHUzY03qsM443nYfOsxdNr1Chq4xm
 kF+Gnkrk4eMCtkF2pu0mFNrOioKbQAMhCnI5nqjBzhT1r0ssq/jxTkTjL/2gT3acQD46rUKIL
 HcMKCVlaVDtcDG3gVwF8pLvrlsWLgX/brbZXFn2LWkDF4adiggMi+xiI59elIuBEJFVg2WbDy
 NK/3G0nr9VaFYe+DCr5uVr4+/VvD0s+yMqHE/o8+oIrdsgW1nngiVu89UqJUZlEI/w/QvvyAG
 pSiVxXOKB8aPhtn1VHf8IchmWnUw8ixb+6ZDYEJZMgGk/hFo1CR0mHlCdgW0XdAvUCq+dazB9
 nN8YmGHbVz6uW/bbgKVy3uvEWWpLdowPDOSjBMpriNpW/gkS06G1NHgXCErbJ6TN+TOMk0c6P
 mL1yIUjeMgU7yQD+Hv2jp/UbH+Ac4ZNi6bTRHw3tBG/aKpNWpFbNlOJ4+TPIaErXh144mtoN+
 xgXc/ELb/6itNyQtabHAaBDzhfDxWU/XKXSaLaj12FSuCOFKYmIek0Ix1e3B7xEJ9gmml6UqI
 5QuhwPVPn19a7pV3YHPlRFijTgS5P88YZ3gU/55jW5xA7fcTmLi2wCp1Z3gaOEt9CQth4/94l
 D/EDs9R9HGNeGAfrl6qspSBviLpcvNyNUPXkHy8Kf2jAYthHgMcHt2XbDfDgxxk8uRNb7DUC/
 Lh7d5eQ9jDRANXL4XQc8Aio+VF+ppPEfh4AweEQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--14QYZBiyUBVPmgMqCDZgKe6U9qC8dPoSX
Content-Type: multipart/mixed; boundary="m5HTZgvpp4fap6PJf1pqwotfqRDUToU9C"

--m5HTZgvpp4fap6PJf1pqwotfqRDUToU9C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8A=E5=8D=881:14, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> btrfs-convert currently can't handle more fragmented block groups when
> converting ext4 because the minimum size of a data chunk is 32Mb.
>=20
> When converting an ext4 fs with more fragmented block group and the dis=
k
> almost full, we can end up hitting a ENOSPC problem [1] since smaller
> block groups (10Mb for example) end up being extended to 32Mb, leaving
> the free space tree smaller when converting it to btrfs.
>=20
> This patch adds error messages telling which needed bytes couldn't be
> allocated from the free space tree:
>=20
> create btrfs filesystem:
>         blocksize: 4096
>         nodesize:  16384
>         features:  extref, skinny-metadata (default)
>         checksum:  crc32c
> free space report:
>         total:     1073741824
>         free:      39124992 (3.64%)
> ERROR: failed to reserve 33554432 bytes from free space for metadata ch=
unk
> ERROR: unable to create initial ctree: No space left on device
>=20
> Link: https://github.com/kdave/btrfs-progs/issues/251
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks pretty good, but can be enhanced a little, inlined below.

Despite that, feel free to add my tag:
Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>  convert/common.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/convert/common.c b/convert/common.c
> index 048629df..6392e7f4 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -812,8 +812,10 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_c=
onfig *cfg,
>  	 */
>  	ret =3D reserve_free_space(free_space, BTRFS_STRIPE_LEN,
>  				 &cfg->super_bytenr);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		error("failed to reserve %d bytes from free space for temporary supe=
rblock", BTRFS_STRIPE_LEN);

It would be awesome if we can output the free space.

Just the largest portion is enough to show that we're hitting a real
ENOSPC situation.

Thanks,
Qu
>  		goto out;
> +	}
> =20
>  	/*
>  	 * Then reserve system chunk space
> @@ -823,12 +825,16 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_=
config *cfg,
>  	 */
>  	ret =3D reserve_free_space(free_space, BTRFS_MKFS_SYSTEM_GROUP_SIZE,
>  				 &sys_chunk_start);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		error("failed to reserve %d bytes from free space for system chunk",=
 BTRFS_MKFS_SYSTEM_GROUP_SIZE);
>  		goto out;
> +	}
>  	ret =3D reserve_free_space(free_space, BTRFS_CONVERT_META_GROUP_SIZE,=

>  				 &meta_chunk_start);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		error("failed to reserve %d bytes from free space for metadata chunk=
", BTRFS_CONVERT_META_GROUP_SIZE);
>  		goto out;
> +	}
> =20
>  	/*
>  	 * Allocated meta/sys chunks will be mapped 1:1 with device offset.
>=20


--m5HTZgvpp4fap6PJf1pqwotfqRDUToU9C--

--14QYZBiyUBVPmgMqCDZgKe6U9qC8dPoSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9r44kACgkQwj2R86El
/qjTiAf/RT50Bsl0487HiydVbBL46hqTvdOegUUvq5S4MKKwpbtDRsbg78jz5uo7
0qE9p/fwSa2nGx+sLLA6fC1BEAAZayj2MqQWPICHVBHPcM2sH78jNtnVhfaCVEHf
mPazoQG0fzCe0A8oaLpnBDs1fyBEoS5YxmWfaFNrkeTPbJTlRZl6RJeVnOe9fjRx
+shDyMnJBfzR0/yKpdg7F6iZwp8QZMcI3PAQu7F8w+y2DkoOx5XUSJCq4CjZruoP
4x60aqERG18nAgh6IgIL5AoCBmDE6mXpyvgXfpyivVzu3k/i3Gy4bPitGViyHQwK
ylW9X+XkXVUy+ZahgOvXhfOpWCHUCQ==
=7T57
-----END PGP SIGNATURE-----

--14QYZBiyUBVPmgMqCDZgKe6U9qC8dPoSX--
