Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C240617331C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgB1ImO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 03:42:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:46129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1ImN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 03:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582879327;
        bh=FgOBgVgTqNdJ+lnG5p2Od+gGclIkS+4eZAkmQNr9sRQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S7ytYertjylLX4Rfy/o7toyk0WtIbnLyvaZDmHBvkappZ4ee0tHL9KGSkjk1+6y+1
         cqKRAT2ra14I8wMy76bIjT8e1/qEpIZkLO8awwfzIWm9cTzXfVe+6+iKko124G9ydx
         XP5521FCzWrzvw+mncG9j5Akih0yYuLoFMQhMAmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3bWr-1jYeMe0IVP-010ZMZ; Fri, 28
 Feb 2020 09:42:07 +0100
Subject: Re: [PATCH 3/4] btrfs: return void from csum_tree_block
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582832619.git.dsterba@suse.com>
 <c6518711b16ccd373084b8df681db41c198cb1ec.1582832619.git.dsterba@suse.com>
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
Message-ID: <744be167-b3c1-99ac-e9c6-694a92a6f63b@gmx.com>
Date:   Fri, 28 Feb 2020 16:41:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c6518711b16ccd373084b8df681db41c198cb1ec.1582832619.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1CV0npFssdq0x9wIysPAfIdTujuee7uk5"
X-Provags-ID: V03:K1:VMHFE1BoGlyxRB33q1TnKrG1dC4C37AHYH1WbQFWlgUEyS4SrhT
 6coHBAP4SP1cg+rqBVuXQK4XDi6Mbn+7NU3irerLCUeuV7lwt2XsVwbXR0CR7UfdaDZXBC7
 FSZV2H7RP6+STPouEh3zp6KDr16Swqyln1T4XN31uqrWCgRP9YL1gFacVib3v1iNqflAh6Z
 9NJWUTVJBkwdZBWPigECw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yWFgB8SK8Po=:4iWlMg3RsTwcfg3lFixVtc
 pLA3GbHwR7BxHsRJ3h2dxugnGNIapbm5VZoS1rh85UnBuQSqOHjycKoZVDTYOxfbNVb+KNVN/
 A2abBZN5YzVhHYKcVxr28Al9pbOC3QWEfMlmrfa0z71+ZFdiLF9uBKVN4V6P0xXBhyxwSamEl
 4cZ86NjlUVoZwmOQzDvpKZdeOwLwgiPXvM9ia2zjAHLYwkfHD6CP/ci3cBzPQccky5/qf/9/+
 PXL6Oi7mu1lcG4XaNqhTDdBCBYSbKXqQg0+9PkjxcHiciQCVmsFyl5MQ944JjQYsa04/2kCay
 53ZckHbXFtCY5M2i8/dD3GxWmhWlbYGpr40Fxt8yjyd4BhubnsZ5UkaRZCWbT8903bQ+4MHWq
 Xb15YoqWXfX3uehzHYP1UbgsYtHqlPqKfsn33ZUm3FVbwDocchaAQvoAcoyfjWzwL/j6R5786
 HD7i0Pz3iplgLSAi2TNdRergpvnK4jjolWWdyWUs92+WMb1eMUpabncuk4MtMj2PQbFa3+Es1
 Puh6xxK1FtEWoT+T3KTYYQIGPMlopSm5XSzqRZB5ruWD6+fRXcSQfbIFkhcSsmqHx1pzEMx9E
 voE3bGI5A4SBYz+E0PLrczsZfw8VE3rf2uZNQUhRidrFwuf2RQMmB2B5MF5/UN8pC96VFsW5c
 MhWG0AKIxFXbFkkrPotVrgtyf1KAuYNVTi6w8Su9Cr65ux/WSFbLOGJY45Lz4RvYS1rheMhnt
 KhlId7Wu0PnfGQpcptYAsep57aHG0FWDT/EF3xtgJJkLSguuX1bt2QIO3jePiPJFSEOSCUGAg
 K8fysu7rlAsiBeulzwWrGCOWlXSXgBtddGyI1WzJahiNzyAWt/LN/wn2imWAn80AkgnsCzENc
 3pS/OdD6vdJqQK+vBEzrVEO2ciYrenBd1Yn/LsMfp1XmNDuXa3ILS//4Yzxsa2DYlqNK8Qd7a
 09cv1xbyy0sFZpcd+x5mmdPEjDYO77MDWyZu0HKP2EUr837oeE6YESuef8LXzgBiTIrFOs37P
 NSejSRbb+5koh1r+3XdTWcUx4zH/P5N/YsyfglSTR4gwKBgEdfGKSc5z0yhrevdJslfcB+bSE
 OTmxY1OsM+IlwVXF2bQEf7L3Uur4HsVfixmgytZOD1LrDJrZWVLxYM2gJ/BX0ugp+UABJ9zhK
 L1ovVBCs5CtnrL2Y2h+VSlqJ4qsBtlbVarG6RijBoEcLsf/QVXoglirKtF4mlJdhD8iubXldm
 sTNyJd2XPKj4as0cZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CV0npFssdq0x9wIysPAfIdTujuee7uk5
Content-Type: multipart/mixed; boundary="N7JyszjJnq2rZFiPqanXfFcaRm2ABEfWK"

--N7JyszjJnq2rZFiPqanXfFcaRm2ABEfWK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=884:00, David Sterba wrote:
> Now that csum_tree_block is not returning any errors, we can make
> csum_tree_block return void and simplify callers.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/disk-io.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5f74eb69f2fe..8401852cf9c0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -253,10 +253,8 @@ struct extent_map *btree_get_extent(struct btrfs_i=
node *inode,
> =20
>  /*
>   * Compute the csum of a btree block and store the result to provided =
buffer.
> - *
> - * Returns error if the extent buffer cannot be mapped.
>   */
> -static int csum_tree_block(struct extent_buffer *buf, u8 *result)
> +static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  {
>  	struct btrfs_fs_info *fs_info =3D buf->fs_info;
>  	const int num_pages =3D fs_info->nodesize >> PAGE_SHIFT;
> @@ -276,8 +274,6 @@ static int csum_tree_block(struct extent_buffer *bu=
f, u8 *result)
>  	}
>  	memset(result, 0, BTRFS_CSUM_SIZE);
>  	crypto_shash_final(shash, result);
> -
> -	return 0;
>  }
> =20
>  /*
> @@ -528,8 +524,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *=
fs_info, struct page *page)
>  				    offsetof(struct btrfs_header, fsid),
>  				    BTRFS_FSID_SIZE) =3D=3D 0);
> =20
> -	if (csum_tree_block(eb, result))
> -		return -EINVAL;
> +	csum_tree_block(eb, result);
> =20
>  	if (btrfs_header_level(eb))
>  		ret =3D btrfs_check_node(eb);
> @@ -640,9 +635,7 @@ static int btree_readpage_end_io_hook(struct btrfs_=
io_bio *io_bio,
>  	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb),
>  				       eb, found_level);
> =20
> -	ret =3D csum_tree_block(eb, result);
> -	if (ret)
> -		goto err;
> +	csum_tree_block(eb, result);
> =20
>  	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
>  		u32 val;
>=20


--N7JyszjJnq2rZFiPqanXfFcaRm2ABEfWK--

--1CV0npFssdq0x9wIysPAfIdTujuee7uk5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Y0lYACgkQwj2R86El
/qi9LwgAk0dAxNruUGLkVe/nQT5XVBXq1+JjDxRxnuBvipueFp54Wkk+CsidzJXa
1Y7+bngIHwptgWccimdULOUDZ1OzSRek7UoOKC7ab7ONRtHNXw8kfI0nsLVqgnBh
H7x1ubwzn81XfEPSrIYm3w2VIAs14rj6b6gnJ2ehc6MkcGc07AHK2UAsupfyJ+7p
oPTVeF+8nUoRf3KCWgc+eRRUM1TmJplP2ytgAzHpUEeJLx4w+9CChCzklCGFxRuK
V/2TURh66+1DWIXfYGZu7gdGYQYqaILjx3uUoac+lq2nofvnwtJAkfj/Jaas5jwD
PFegcZtg32FvqwdVL8vUqiZXP+Iqbg==
=n5mZ
-----END PGP SIGNATURE-----

--1CV0npFssdq0x9wIysPAfIdTujuee7uk5--
