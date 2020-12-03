Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C596A2CCCEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLCDBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 22:01:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:46977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgLCDBw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 22:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606964418;
        bh=NXAb7/hoBU3OtCC+Z00h7jM0a7gohFTMetZ5ZoSOu5k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XSeCxbPqKgVSY5BSIAsQAWR24od7qfFJx1cDDDe/TqaaUdm9Z83D7hBhEAD54bvgC
         0X2QCUAfnBgwV/ucV0pZadRqeE8AT3o1oSm0JKDuBth2EfJKTjZCbOpwGst56FMNWD
         yxhk5m8ITZBfmHaBmmgGcV+St+MaJJjxYyI/pWv0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bjy-1k6bPD1TyA-0181Ax; Thu, 03
 Dec 2020 04:00:17 +0100
Subject: Re: [PATCH v3 27/54] btrfs: do not panic in __add_reloc_root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <2bef28c4b030b238ebfd8a143f4ba08524b9312d.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <eb9b6354-3f3c-fba4-5692-83053a898f7e@gmx.com>
Date:   Thu, 3 Dec 2020 11:00:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2bef28c4b030b238ebfd8a143f4ba08524b9312d.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wexW0zkuepx4IeP13DT4i2w4M7pSrJr5h"
X-Provags-ID: V03:K1:EMG0byiB4uT3QUmXw9daRVXqEQ1Ah3358sjrQ1aGysT631xnLWl
 EEtsTw+HuQP52rzglwl4vXkRJRL03+tWOJd7pNT9/Z5Xen5uAdP841cn4xt8nf6nZZBqQmU
 tto3QmyRqje9HJZBtnBWP09k0NamcrdpwUwLYDNDgUCz1BIY+uTDUtHFJVVytOELuCVkGqI
 Gx3Z5qMhbJJST9T60cLqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9QyMGmRWj4=:IQ7tUIw/h9r+0aAaEYkbks
 cPKeVU02JGWSFz2giwXgBLFj9qy5rBrAgKwXjOnj70r1kb7WzBtFeJC2NboOPUYlPDFxf3Ff7
 kWGhtxlb/78h06pEkE9tnm2D87VeegHFAvCQ2wP0qOfsSZXzQkBaSFdBmgKSDJguIUM7Kbez/
 OKEcmklS5QoYDeljJsEItY3Me4V/4ggOsYYy3SnvkUo1J2N5jP+OZ/K3eD2wm1feoex5v/lh0
 BfB8pMM5lHgFjAr6dvNtvAfng6t5y0JEtyIs2kG6mZ7tVCFW3NZxpoFLqnWTeWpgBqmplhI1h
 iwQlctyqSitCZ9pyAnHt6FdF3UijbtlXzANF3zxyle8pDkEK/lz3VI47XSgGaKvqZL2XafnSx
 2NvgD98nmrrqF/svJU5actY3cnpusiHGexGTO4wsyi4QzEIbM+LDphSWV3iDIGSVmq3kmabXM
 3lDb8XhxXrfnEAW5V0Uf7O+xVCzV7XoKBDupgWv9/vLcAM35la/ErXBQyUFhD7nidPJutRv7R
 ofFZ0MZkJZev0ayZniletXy4djyv/pdTve3e+RVUWwNYUS+7PCw5HKzw+lxWDglOU9F0Pcrm7
 VPk2Mb8DgMv4MClJji4FxkB0F/PI9X6n7xwgg5itlXl5UdrR4zaCMXfTQDlRoC43HHkqeYnaQ
 AGa4hdwletpB4lBLnawIvJ6ez513lHSlxnNsxZQf1KnmuLoaFVwgtYbZiDFvzZHjyFwlIulIy
 +HjPhlwpNNeauwT4Wjj7lrJo16PQg6zvXjVo8TKzNHzlAGK3gEt7WT+JMu1CQSKWuLBAAYR8G
 7r2jzqDxhQ18na7KToFbjYgdDkjXXNpgjsiI6HvUc6CXLBA5m5d2mYL5owbIj3/szUEtT9DZc
 6iUy9b4E/rVUgWiF1L+Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wexW0zkuepx4IeP13DT4i2w4M7pSrJr5h
Content-Type: multipart/mixed; boundary="PKo8gU0qa9efOWi7vj0OVvmhfIKJh5vSy"

--PKo8gU0qa9efOWi7vj0OVvmhfIKJh5vSy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> If we have a duplicate entry for a reloc root then we could have fs
> corruption that resulted in a double allocation.  This shouldn't happen=

> generally so leave an ASSERT() for this case, but return an error
> instead of panicing in the normal user case.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Despite the same comment on using ASSERT(0) inside the error branch, it
looks fine.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index e9d445899818..7993a34a46ca 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -637,10 +637,12 @@ static int __must_check __add_reloc_root(struct b=
trfs_root *root)
>  	rb_node =3D rb_simple_insert(&rc->reloc_root_tree.rb_root,
>  				   node->bytenr, &node->rb_node);
>  	spin_unlock(&rc->reloc_root_tree.lock);
> +	ASSERT(rb_node =3D=3D NULL);
>  	if (rb_node) {
> -		btrfs_panic(fs_info, -EEXIST,
> +		btrfs_err(fs_info,
>  			    "Duplicate root found for start=3D%llu while inserting into rel=
ocation tree",
>  			    node->bytenr);
> +		return -EEXIST;
>  	}
> =20
>  	list_add_tail(&root->root_list, &rc->reloc_roots);
>=20


--PKo8gU0qa9efOWi7vj0OVvmhfIKJh5vSy--

--wexW0zkuepx4IeP13DT4i2w4M7pSrJr5h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IVL4ACgkQwj2R86El
/qgvwAgAsJH2Ktbo8PX0BNrZmcbAunsnHOka4gmtghaly8BKEICwYU2c2JlbfhUm
BNseeI3/Vek+bLqj8Q/QFUoIbUU94OVhH4dL/3fFDx1oI0OwcWEGcxsUBMdeniIz
ViGMmPLJagqvN/B87p1zwtj2rGGpMXeG60XKDffqluHXA0nl+H4UWyEGSXFJ5vRx
Si7IyfQIfK7BJFpw/Bf4M55SMxt5hpqVjneL2d7rbXFqs1DaMD61Jm8QRc6NvPCn
+k0og1XTtYVX3TvlXezFngEjIDKkBNfJRhSi6d6+qCcCCADQe+24y7TgbmtbuLqR
0ztmAickka3ZEIMHVrbDSTkUI2rGSg==
=KBO3
-----END PGP SIGNATURE-----

--wexW0zkuepx4IeP13DT4i2w4M7pSrJr5h--
