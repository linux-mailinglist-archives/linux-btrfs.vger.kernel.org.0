Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F44B16B60E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 00:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBXXyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 18:54:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:60031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXXyu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 18:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582588480;
        bh=Isee1c1CKR/y8+Sb4AJMzg8GtWOqzryHMUNgCXpURsc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U1FBNw4+R8N6tvZpgeVRRsrLc/Bs2TGQfEIWbF7c9AjzgO/22LKEu4fnvJNvMwqhh
         pZ0zsJHM3WipavjIO5IWOAOWI7wEnnvjpYdCVwNyr5rAW2Sih/3AEwGpFzf2wDsVd0
         rmpraB1DttGSGCOH9Z5zhP5Npg9ndkq5Q/iU+FPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1jfRWp0MXn-00bLIr; Tue, 25
 Feb 2020 00:54:40 +0100
Subject: Re: [PATCH misc-next] btrfs: fix compilation error in
 btree_write_cache_pages()
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
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
Message-ID: <4dd7cba8-9a94-069e-7f80-c2fdb8fff631@gmx.com>
Date:   Tue, 25 Feb 2020 07:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0j5AQ5DuD8eUdmSbs9BkNnFE30xlyisVe"
X-Provags-ID: V03:K1:Ij9dbAMEcKQMQOtupdbQAQJmhc+83O2XRoAh9mUL5YD6gK+42jX
 24wg4FUqS6fomVQZalhTxp09exEN02SQ/PAkCWIMO3zNZLo6JrBGcKL2Oh2wg68KaGkLBww
 WGVqrRwdPv5z7xHCgnu/tnENPkt9ouBizyuVtHh/Uo6YKI+O8kW9HYO/98yB3puZ9f5PqrQ
 lr0W/K7KyO6b0Y4fSh5/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z3war5VRnsI=:69KJdTHwkgBwydkIFCQQEk
 zYTVm4Ny95szlmGgmkz0SrLcBzUIJsGfzuGGBFq0CvAmyZInFBA+g92MXDtlq47ZBNA5/WM7e
 Eo+/zo96mpenVxS6UCOHdLpiJ1ISYH/KNr9J3B56f1E7voV0IGo1F4QWmAKesyKyTNFdq5sL1
 6F8r61eBtTzLIFXM8H13tqEgQMK6ahdjyrzMULhMUKCoHi6rRfyuigcBLPQxrItor7HdyutZ1
 6W+2sPcGJSoFi884wLOsKtd1qsJDgaMmno7LjPHvHztIK9rP6QGJTxlZ1DP2vQazT61Fmg7/A
 13UHFZ50Q/M+jJ6ImzoudZAc7a07jjFw5qC5o+5Mn7hIWpFKptpWavnSPnaIMwbnvZxaTtOLi
 85jUPGCRNYyd2/NKfzwa5Wq06npTovAAAITfwB+CPd3Jwtd2BuSXNvXYSNlZ4ezU/HF3bU8pq
 gzdmjJdq3N4oWfvuoqn3mKeAoyhWeEK2FHhRSjr8qDqyTaY8JCYktB1KuZkLxYqZTE4kshZMT
 lPGMSoyiZqyW5PG3kARivKQaN9woxeymb1qeHbu8qPyYStDfmGV1iQo07DBMV0t/SEeTmkmYB
 EbeaW5zKhRjQ1f2jgSE1DGLIpbBBXC3p1ySybVP4WJWwit/Fcxqge75X93cWjVRHWilNqjoHd
 EFw2/TV2fJgqqYQWZHoUvzDNCXPBommT5N7fKctSHBwftB50AqvbbsLVCQU2Sj5R+KeK+wg3u
 iPwEzFuhzOeXnPY1HG79NfczzIdp579cGI6w1mresvgNEDZXl7NdTxWA4GPXcIwKeezbStA2J
 5t+AcGpr/KDEycaIoAiIgjcpEIpdLFAI6S80SLqJkHtJpNjkxJTqT5GkuGysLwfwmdPVNlLun
 Iw4Ko/Z0EaQEVIvmURjeSA+fQITsUTRt6N/RLN8djWSELn4h1RnEXp/Lh8beZ+wC+1HqnIe0T
 68fJmfiIzuPSH5b4uDuGkWqwtevBSN1jDmQzJQOkCpN4P0zw9qLcjRtjDA2+BoyZU4pmKbzet
 VrBXHIlOj947m048bLJ4k6ZnYC+IpmV/L7JJdE40B1hYZD3vCqCd1HpTPzl7BqtFMNl2OekrR
 ps6JF8ZVEz9ZU8lwLTYkNkv8FDOJnw+OpA9PlG2iByoMJ7D7nw08ssMf2LwQ5+4sgH9rA8vYe
 NcaysXS8vVwZ750DNP8g78SQopmUwJu4ZKM/GSWlW5gOCPw7fvxAURZ2dCzIw/BKmvlOG2MrU
 QYvbYF2O/EGkRxL/g
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0j5AQ5DuD8eUdmSbs9BkNnFE30xlyisVe
Content-Type: multipart/mixed; boundary="A45oIHWwtNPktTX2uEvvCOgq79RXGb84M"

--A45oIHWwtNPktTX2uEvvCOgq79RXGb84M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/25 =E4=B8=8A=E5=8D=884:22, Johannes Thumshirn wrote:
> CC [M]  fs/btrfs/extent_io.o
> fs/btrfs/extent_io.c: In function =E2=80=98btree_write_cache_pages=E2=80=
=99:
> fs/btrfs/extent_io.c:3959:34: error: =E2=80=98tree=E2=80=99 undeclared =
(first use in this function); did you mean =E2=80=98true=E2=80=99?
>  3959 |  struct btrfs_fs_info *fs_info =3D tree->fs_info;
>       |                                  ^~~~
>       |                                  true
> fs/btrfs/extent_io.c:3959:34: note: each undeclared identifier is repor=
ted only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:268: fs/btrfs/extent_io.o] Error 1=

> make[1]: *** [scripts/Makefile.build:505: fs/btrfs] Error 2
> make: *** [Makefile:1681: fs] Error 2
>=20
> Fixes: 75c39607eb0a ("btrfs: Don't submit any btree write bio if the fs=
 has errors")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Just for reference, that @tree is removed in commit 0bad2c5142ee
("btrfs: remove extent_page_data::tree").

Thanks for the fix,
Qu
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 903a85d8fbe3..837262d54e28 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3956,7 +3956,7 @@ int btree_write_cache_pages(struct address_space =
*mapping,
>  		.extent_locked =3D 0,
>  		.sync_io =3D wbc->sync_mode =3D=3D WB_SYNC_ALL,
>  	};
> -	struct btrfs_fs_info *fs_info =3D tree->fs_info;
> +	struct btrfs_fs_info *fs_info =3D BTRFS_I(mapping->host)->root->fs_in=
fo;
>  	int ret =3D 0;
>  	int done =3D 0;
>  	int nr_to_write_done =3D 0;
>=20


--A45oIHWwtNPktTX2uEvvCOgq79RXGb84M--

--0j5AQ5DuD8eUdmSbs9BkNnFE30xlyisVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5UYjwACgkQwj2R86El
/qjzkQf9Eclaqe5R8pRl3sS6jw427Zwiyu6NzEZ7kXKHFrFTHST6xIR0eUPJpX6n
A6QDcdyPsVV9zq0iaLSdhzR2UHFQHOBjm+fOutrv5WrO60aR+3I+sY6V/F4KI+Wd
GbKxjKXW/RcIKW66F/yPGDaLuCQySCVAIhBP/mqlsiir4MsoppWMa+IcCAPnuz/z
NsfzhZU2jS8b//tCT5YSTGiGGYQznrQ7Kn0+k+CqQdgiZAstO35YqbnxQRapR2Ve
zUjUPCt8xtRIxjCvBeQoaWN/pnOhwPURyRn3UKOJuE0ZQ6Zg08w8FEpOrrgoyKaj
VDQ+fmbhEaVsGc/h/36fVSyTwwzzfw==
=/YV1
-----END PGP SIGNATURE-----

--0j5AQ5DuD8eUdmSbs9BkNnFE30xlyisVe--
