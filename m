Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088C52CCE6B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgLCFVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:21:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:40437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgLCFVA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606972765;
        bh=S7z4fAudXeOEmdYz5HdeB99Aw9hfB8hHuy+eXnnFuLg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RG0R4ePBYdee//tExREcEowlGlBIN+4+FGLMQl3rkYtvOhw98RCe90x6R404rym3A
         NtNhpA1KcgLU6xJCZ5M3o/qDuDRKZJBcix/d4AMkYhQ5Z5B6ohwW4vX37tTBrtBMl7
         mCGUPh8SmV6crSlDDcjY7eOhSQXHndVDefJsitJo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtfNl-1jthC71ARb-00vAol; Thu, 03
 Dec 2020 06:19:24 +0100
Subject: Re: [PATCH v3 42/54] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF
 being set improperly
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <cf522824a3a16e2186b43c5336b4d99cd0cd4d19.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <cc10a7dc-ee6a-0e6f-0ff8-bde0c6d10a73@gmx.com>
Date:   Thu, 3 Dec 2020 13:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cf522824a3a16e2186b43c5336b4d99cd0cd4d19.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="47VbkUOu8VYnt1N1AADNXLOgLCROX8ZCf"
X-Provags-ID: V03:K1:5GQDOfT5xR443gggIE7rXPicoifDFxQ6Nl/StUhGlaQOyufmFwL
 1Pgv175vuInQ3p7X5yaDgFZMVRCDlnVp1In6OCYcwhD0HU4u5DC0x1aj6JRnmgRhLrUMnVb
 8BoGB2mfT+kC3QXSvRjmFlwX4Cqsuu8Zy25nINO6QIixeeygDkH5jMc0ImrGmLsvMHoo+RC
 +FIN9EJqNbo9SqlsIUhAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ccw3gJmbs1Q=:P91RTBo2wUqdE5M7zMGBWw
 RfzxDqeTK8mIcxTlSY+Ech78yfBRsKvpULEOvcwNE1uJWpNXS7eL3KacVMn4ImU48mxksPKWp
 fw5ajRXxGIUlIdfSE90eL6pI0owx54Qp3MHfob75XbhPRmpJHd+o8cAlXgE30DbTCVuuOgLKn
 0YjyhEUfWIhrDYHQxxcP75AoL5p9ds5oFL6ya6kAaFHTrrZmf3OheWqXer7gHxIJ7fLB3hsa9
 vEUvqSoHMPmG/O3/QfjlHxmQ820/ffJMQ/BYOeXaCGfaHHxaL8FCFy/TAwBFThGKQKHVf12Xn
 QXGsNWFPZFrUgeMt/Xlu7VLDlgfrR1dFi9uGUAxH1bGxBD03uSCQlSrScW03xPimuCfUVpApr
 WU4axksvPeTjoNlzG1rC8w3kSC5F91GZeO1Zw8kHUnUUmgVwNqDPYNr7UZvGqlB6HWmxt/Iiq
 zVHsbZ6B9LAYarGIvlWATpfgWAYM0MfFRNT3LqHVQrRh8NUYxVYnJGW5n5AnYKaEe4tv6BcDo
 fCXliWZhODZNCWbXVX7gbLl/OpNCi/JmwbqDVgvPvCw5SUTr1EEQjMkPwRAg4KDb8JDZMQnQM
 iJyQGhaNDXk27GYX8ManFV5zrylmW3HXoGU1U8MIsiES3SJddiHVt0HQMI8nQa41ojRtON+GF
 O97G5PENg041astLqDhBa4gz/Mq6/rkYoUIXjDg01QNUPuCruATdE+HYafynoNivjpjljCfIs
 vnOWZv5/OW+xldoXRo5ovCEJ/KzSck+2xuZ+PI7jfxnf3ZHeDGy2lPa8zJGWG1d4zQ+WY8inj
 kymrNJFlEo1kpwrQIZkBnhxlShgoye1ItJdtvXgBPCKGa9DzYsTkaGz5rqrqxXZ2/AwztzgC8
 fXXegT8oeAnjcrdTuudlDhuZoI1kYMlL3x6DsbxEs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47VbkUOu8VYnt1N1AADNXLOgLCROX8ZCf
Content-Type: multipart/mixed; boundary="lmtceuvnviyO4Pn16Q8sTLkxsINQfKlrr"

--lmtceuvnviyO4Pn16Q8sTLkxsINQfKlrr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> We need to validate that a data extent item does not have the
> FULL_BACKREF flag set on it's flags.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But an idea for new patch inlined below.
> ---
>  fs/btrfs/tree-checker.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 028e733e42f3..39714aeb9b36 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1283,6 +1283,11 @@ static int check_extent_item(struct extent_buffe=
r *leaf,
>  				   key->offset, fs_info->sectorsize);
>  			return -EUCLEAN;
>  		}
> +		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
> +			extent_err(leaf, slot,
> +			"invalid extent flag, data has full backref set");
> +			return -EUCLEAN;
> +		}

Since we're already in tree-checker, another possible check is, to
ensure COW tree only have one inline ref, and no keyed ref.

Thanks,
Qu
>  	}
>  	ptr =3D (unsigned long)(struct btrfs_extent_item *)(ei + 1);
> =20
>=20


--lmtceuvnviyO4Pn16Q8sTLkxsINQfKlrr--

--47VbkUOu8VYnt1N1AADNXLOgLCROX8ZCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IdVkACgkQwj2R86El
/qhknAf/fvDXQHJm4MVav8jcRITem4jM0bWgGHhrjIF+hH/99XJ/6ZBNT72WhFGy
yBwpsUVfUSgqwnuqlaoCmSKrrflnHKyYJw4m0tDLfP2GpeiPJEQb+Q8taTDkfoNX
mW561v6kroVqytjCZqJEZQerjlGqNL2d6oH/BwT7id9pin2Te8w/vWJNKRgJ+Myw
UWNtrB2o/0tgQ9mSXw7g/BPls1HzocnuIE9xLnXP5tDyYEeM/FWNn7I4VyXEwRoz
LoKjhm3asnE7YjSYjp1nZoUFA21Lz5P5U/ieR5hKH/6lJJ9GKf71BO4w5wtQkgCt
N76+0xrBqd+mJCQ7mkZQbas7lG6y4Q==
=n9Cb
-----END PGP SIGNATURE-----

--47VbkUOu8VYnt1N1AADNXLOgLCROX8ZCf--
