Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60952CCE62
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLCFOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:14:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:38741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgLCFOn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606972388;
        bh=OKrLXIhLsa8wcZvBYJXSxOfqQ8MBdEfIEDOn9ba5F04=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IcAprtt93H+8RZ3CXDWKKs3zS/r//wDZ8EybdtjdHvXIxw6OxiP3gTYf1lbhYF9ar
         I8X1TLq3gJf4ZkYHEPZ9gUDjBJBCewkEeJAc8aV9Miw7YUCuj4fui1hs+S22LiGDoQ
         f9feVkwJMNCny5KvVm7ir2x1iCrJ+5BwJiUtL88k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1kGHrO3WHB-00e6SV; Thu, 03
 Dec 2020 06:13:08 +0100
Subject: Re: [PATCH v3 39/54] btrfs: handle btrfs_search_slot failure in
 replace_path
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <3ad95395a035d5364f77170c6d734b96f7ecc345.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <86d16b6d-3f06-1abe-2997-b098e66b852a@gmx.com>
Date:   Thu, 3 Dec 2020 13:13:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3ad95395a035d5364f77170c6d734b96f7ecc345.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0OHkOzckvd2PInG4giXtmiwxoYpndsgfO"
X-Provags-ID: V03:K1:jCB/7Yl2YSV4bREvlLSMgXGmZoJPbQpg0vWRV8qpbUGWhPhKJ+y
 Z9vDqBTm2qh3zWk+w551g8k0JtgnuVcQVC/84brtY9phAvXqfRrCvls76T3IaQe99Mw+F/s
 /0geJ1J8G0lp7IKItfTiR7lUicOiLPCW5pcvtJPrmCpojrxUBE0w82+kN5e1QUVGCks9wmw
 j8Z9/uVHoP9VK5jiVbihQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OHoSgkgaBhs=:zzLgm2Tm0gjpZRnpirvph7
 kB3ARH+HgnbF7+07djYu3QG6DLps+4tHXiC86GQqCLSkeDk7Ii52cP18wLG9NTPJtYd/ZhCVo
 rSNar1919bAFiQRdg5k17F7eQ965aHesibw5MEseuafL4N7rozuqNW6CxXJ/xhRs5Ft2BPvkT
 3j2UegOvPN+E2+UQy3R4R784TGrDqgpfsBU2N6Cb+iPocj8NYYj0GLWXKZxTK/KRG/jCtxCfi
 V45l+AokIPjlJo2oRKEDsmdRWdLVSvkltOI2a9vk74GS2COTIvgN7F0hxL2TMt21RopnEf0wr
 DHuhNHBh0QFKYxqmPUqPD9B6BiUWtPAbUJ0p12RJ4xcnU9tP4TsfDyYnACT9Qa6ozPvW584ov
 xt1YZfFZJw+LKFWaMWIBUf65eSW4NVUhf8AhG9/osa7OcVI7YdYyI0s1OxQNBpVF7Zxf21ij/
 dM80NwTs5rkH5zwuveUSksLVlmLRt1sO5GN1tCUMAfmerNcwghX8TeLZlPxND89iyXxK58rUD
 MZfSVVKpfw8xOCLHwr2p7oqLOj3T7gSWiAruYSz3ksw4rcYtswZ9tTTC6f8WVomFzCk9A9wBS
 DSTR/97NBlAjaEKeMPj/ijFLAK4xUHcLgFqLwhUTAhuEQ4ozVUoJVPMAUg638Maxy+y6qsrko
 bDeWdkeo0PdWHDE80a7+4W/17Czckhus190wwlGo1MFJ2/wm0UazE6EMNDR4rAdSDH1hh29cq
 hqmcPc+OHYlu7VvWhtBsYPS5VBnBP/JK8iuoNkQ1PuyJES9gF96UssHwBkBvDZRpX0hg47GFg
 YhRgoo/8NOE3bQlsk82hq1SjD5cihv97XuyXxKOWI+l6vEH81GBtYMDSO0msHWEBjL6x5n8gO
 S+f4oNN0+HPuKBCsL6Ug==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0OHkOzckvd2PInG4giXtmiwxoYpndsgfO
Content-Type: multipart/mixed; boundary="qqAlKxiFKlvPXDY1ZHqL43O5jKPFQsVz9"

--qqAlKxiFKlvPXDY1ZHqL43O5jKPFQsVz9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> This can fail for any number of reasons, why bring the whole box down
> with it?
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

THanks,
Qu
> ---
>  fs/btrfs/relocation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 781908f3a3af..8c407ebc5500 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1314,7 +1314,8 @@ int replace_path(struct btrfs_trans_handle *trans=
, struct reloc_control *rc,
>  		path->lowest_level =3D level;
>  		ret =3D btrfs_search_slot(trans, src, &key, path, 0, 1);
>  		path->lowest_level =3D 0;
> -		BUG_ON(ret);
> +		if (ret)
> +			break;
> =20
>  		/*
>  		 * Info qgroup to trace both subtrees.
>=20


--qqAlKxiFKlvPXDY1ZHqL43O5jKPFQsVz9--

--0OHkOzckvd2PInG4giXtmiwxoYpndsgfO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Ic+AACgkQwj2R86El
/qjkoQf/TSxhK/9vZnbXY2xUagPCFgF4jUc6X+y8p3Q4KERUhVaH5K9Hpw+wscKK
qM+g/D7DI7J3fBHR4dInrG/FV0NfP/CbE9AB5Gm+ogUCqztLeEUhAJNUQPEhXZyG
AOMRviuYtuWJGIV8ZDM7WYWzeiSnDyXzZ4PzxgMNztke0dqluJNp8PYg69sglbyW
CZyOU/NuHFGhlOxmVWevuOTrD9JAuLlhI4p/QLkg3RMI0rccJIACC3xOFcn/6TI9
6SvMEmduOj+wF29KgOs5vvzKqNmBcVXwg3EuhPCAhSJgtoacSOPmT6YaZoDyb0XA
kDfI/mshlwWOit7leiAiL5CVzt4YUA==
=MA6G
-----END PGP SIGNATURE-----

--0OHkOzckvd2PInG4giXtmiwxoYpndsgfO--
