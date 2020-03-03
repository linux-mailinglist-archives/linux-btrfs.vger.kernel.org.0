Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBE1769D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCCBE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:04:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:48837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCCBE4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 20:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583197490;
        bh=Ty11vv0ieWW/QvG3WgmvnoMxbWPH2VvY/MBUDDkJ3Q0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=P4UwrI5Fmw3//6xoZpru97+jLESYNiiJggqFOtbDUP7OV1i2HoUv7ljtEU8Hnrx/a
         5qiB4j/O1WilPyL9NOe/d+LIlaSLvlA+8OlPINUk6HXUCNSNqCXFD0o+WuRePKp05d
         NKcqYrWg9wv9Su5NhV22dO0ffDfJmXAC5a7qp7u4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1j1Et11fZ6-007nKX; Tue, 03
 Mar 2020 02:04:50 +0100
Subject: Re: [PATCH 4/7] btrfs: run clean_dirty_subvols if we fail to start a
 trans
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-5-josef@toxicpanda.com>
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
Message-ID: <194b7844-918e-f0b0-c685-90335ddfc359@gmx.com>
Date:   Tue, 3 Mar 2020 09:04:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-5-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l04gNA8J2ipZFtZHKrvZdp5jgoIexbI3l"
X-Provags-ID: V03:K1:PRNGfLRjakAvi4sW6NTmvrH5gQDiZf1waT+G+W0N5sd5KcuGXGJ
 x0ESF9TQoS7duVjor8I1SL8d9IOVqwMmD3bIL0cDWqg8MwlSQXEow+VdKaj5DDAc7kcu29p
 rKZ8I8ldyDlA0a/HRZMzHNt5x6JHSuudLUCwwMhlsbqmQwz2QB3jmKokr6+VBJy/qQjmbFS
 ER/x4Mu+VQt6VP+XRwOFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LNtM7gI1yWA=:g0i52KWtenH/RmS1X3smlR
 x04IfVg/5+y8WDmgh17/OGu+1+TZiVhy91r2QFDIuIrNVuI36e55Y9lLNEIM1qIXfXZsjz3lw
 vTbaC2NWAi1qk3hJGoqWV6PcWsm9OL2o9LZngWZzWUdi3rVhLewiiz/Tlsc7JXc57jrXD4DJw
 X5FBmOKZm70kQycsb92WMTsnGko8paLbDvhPQbCeQh7TsUazWMJVQ7VjivTl0KqBuaBnRMpjy
 /S7SiwXblJrLmdecPkO/qpq6hl48OJL7EFxWMDC1lcNqdJXvfQAuGbjVEbtYllQXthN3nYtyx
 tZr2y+67MIdSH58a0UkVEawSeESZ3Nliq0/zj72z4vnHUdE+/r5tYrSpIbYgHsVyqeytRzHqx
 nZKp+M437ZB+/xR6xRXk1VWZiE0qMuBlcL0XmUf6uouLCt5NhMgoZgrxcvdizAsW8r1K8VNDT
 w4PgtW6CZMNsQ12S4zuySmHhZvmf8Yj3VoMZrfLh2XW5R0Cc+6N7O+7XD7wQA57eVwYca8fIY
 U9nIbHb008XdsFFMExoPyacUtP0hvknp9ppDYQfbHyXJoXnGd0lkUpFTS4BLEMIBhRkAfYLf5
 1yrIzk1H98X9WNgtunJ7FfVbrgCxqNpToj4XmarotPtDkxrQuhHhxexLSwbeWAohwq1VFV29e
 OuukQsDokk3Kc4MS41WaKhfePyXVk1RXINLIzKXJJ5TbG5BZXPQJlJIoTFodBiT8smlP46tNp
 Wgi5psA6I3e3tHkHwzqIQ177DH3H7edQGqXwff269FBuObVODwgO5R714nC8cydK7KXqEdyMc
 Vfx31HWrJhvgKHgnsb4UA58taheWHzAASu8acGfEBoyjqr2nJWhCDUFZSfeIeRNAB5XuyyN0g
 XDWnhkoA+azBgRnEZoK6LNnrjjYccTs7sRz6DXi28nSbyiZAsog/TrXLmtC3O78deqmyPcppu
 o9PTZb1C7mMb4LGVy83v7jKUl/ofbu4abMFWIF0G7mQQWa9BsCbKALHPdDifp/aavwICoKvDw
 ux/IiQQvLvZJM3AE/thDt1JftrlwyITmh5Itj0ZsepjmITCHn3b7HO7J364LHgODi78rMxxyF
 IztuWNsdGczpg0NLS73nG77AifOiu8w2wLqJTSOG+1I86fNtetvLxrfkVPrWAp0hV+L3L/XGc
 ZmCCpDTsCPFfqNAFgH/bZZ/cUxJ8pm2Xbao66ZCJ7xTg/PdfMHBKTwOyeljUx+/t+RkI09WcI
 R4Dk53ZC3elDBE/V8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l04gNA8J2ipZFtZHKrvZdp5jgoIexbI3l
Content-Type: multipart/mixed; boundary="y62wlLH1jzZsPz5A40pmQ0TZr3ggeSBHx"

--y62wlLH1jzZsPz5A40pmQ0TZr3ggeSBHx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> If we do merge_reloc_roots() we could insert a few roots onto the dirty=

> subvol roots list, where we hold a ref on them.  If we fail to start th=
e
> transaction we need to run clean_dirty_subvols() in order to cleanup th=
e
> refs.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f42589cb351c..e60450c44406 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4275,6 +4275,7 @@ static noinline_for_stack int relocate_block_grou=
p(struct reloc_control *rc)
>  	/* get rid of pinned extents */
>  	trans =3D btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> +		clean_dirty_subvols(rc);
>  		err =3D PTR_ERR(trans);
>  		goto out_free;
>  	}
> @@ -4701,6 +4702,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> =20
>  	trans =3D btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> +		clean_dirty_subvols(rc);
>  		err =3D PTR_ERR(trans);
>  		goto out_free;
>  	}
>=20


--y62wlLH1jzZsPz5A40pmQ0TZr3ggeSBHx--

--l04gNA8J2ipZFtZHKrvZdp5jgoIexbI3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5drSoACgkQwj2R86El
/qjXPgf/Z0Xtl8++cbFRsA/HDzE40m1uX+feNBsqbzv5pstRwmlJbKzU+RhuTSVs
2/gobxdwizwQShF8mxnppgQlsesFvHAHwUF2kJeb8nWE5Gf2G2I+l1cfMa7HHGml
5IXjBT+PKKQp0GsYnGa8ZvEDly2P2eyTCXOC0w4DV3Q6dhpo8qEVtNymnzz2GZ/O
JeKn5H7Uv/HK2ybtKWJrukIXvfE1Nlk4q7l+eDbuGWvqvRuXvYHd68L6XcU1DYf/
5Ho1+VLfx4CPGVq00VyaK7C4EWob0JW6JpO8GHOdtiIad7Qt2F9fi3BfqMhDANb4
QF8TZo8ZulRvUY3rBPTMW/X0x8FTNA==
=mv+e
-----END PGP SIGNATURE-----

--l04gNA8J2ipZFtZHKrvZdp5jgoIexbI3l--
