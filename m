Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD142CCEB1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgLCFfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:35:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:36859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgLCFfq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606973650;
        bh=MYeVCWdaJVdiYXshS0gNu/FcLfKKORiEiS0RP9/3VRQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Sg/V5WMEOuAXDvnL1zzlBxtFId5OHTVrM8YBKuKo+UJA+/13qXiP8rFRRwMWw2zhl
         beYf1ZH8ie5bpXSdYS7ay8mTwoPPwSPVXPU2CVrOfQyyq3+cyAvT/UlesxRdoTEguB
         f4/nFtyt+bPH1DkVRQwNkYH1QnKg1PVslYZjNc8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrhQ6-1kPt6T3KhI-00neQ9; Thu, 03
 Dec 2020 06:34:10 +0100
Subject: Re: [PATCH v3 46/54] btrfs: handle __add_reloc_root failure in
 btrfs_reloc_post_snapshot
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <b6828b73e6b324c40908877fcf4b9930986a3766.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <e8883695-9e9c-9e15-fd55-69fa1127d289@gmx.com>
Date:   Thu, 3 Dec 2020 13:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b6828b73e6b324c40908877fcf4b9930986a3766.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="56BTsRd83vRddsbqhGxmdbnhxFn8EqVWU"
X-Provags-ID: V03:K1:bm4mxBUA/shVayKaduBnsBLJ6GOB0bxcqN/tQ2b7z9MtpPHpi0W
 TnqyRmQHgEuiWXnPoMeooLBVL4aa3PCxlgn6egk0MOOIR9T1Kf2Y2iKhRACEB8ZXBDdXH7Z
 721S8JA3R4pwKRWS/SsN53TotjxuiO/afZnW6M9yDcjJNJw+WCYFYmk78l/P0winNOGW1BQ
 lyBFvUW2QxEw7qlIKc8yg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:60WPNsQeJvY=:XDtuZd1RqPaaKbE/W/cAZI
 WtSgxJI16a1nRR4T5j2Z4feUDzkFuKcLPh6Zywb+ks4see7cl5H7ksnW514dPvV2Q/yhKkM5I
 LCt/EYaHqvQsWPIGU1maoVCXI1waTdDL/EFnacz7poeqhGXqn5waJlu4IYZ0QUTBOf4Pv3fsx
 lMQlgSq+wcq9KlmSSZ5Gqg9btadKoJxpkKuhU/UGN8ypPezt8htU1WbGMx5Ze6ZtyhRGKEx8L
 +iQDCJOZ9b1/ve/1eOfm3J5Ols+FBEoIBYGT+J8JOzfUMIf9RNxWUq132kVjJx/rgZnxV6hqH
 vdNk4BEiIW+RfnDw5kbldhIDj1xwTeL54A83dZ52ey5LfNsgGiQJ9hUxS2FVcK1gcqYe+8fcR
 bQtAfI2NvzYP+njBCDoeHzfeG6LGEcOK3x6Y12mhuL4qxTg5gpab8wYvclHrO14DUhLpuPW3a
 G7vo+wRQ8SJ3BhTNDTLLE1vVBcsD7FN5csM0wS3JewGh5Fof4HXzLDY3qrCyDBsksct5vVoxf
 sMKZMH96cE7aXD3ZDRrenqaYqqLhKVnDSRMOPR/zB2GNKS2Z9JybNJQrC12UK9ZM2dBtwdZUd
 ge0nwAUxuixllXnwmZm1YOo7bZe6Okpy1YiB7UVuXciWwDj8tN7ilgy+o4+n2wjjB86paeDJm
 qmD8vL3319KJYnGnaxvjaUQ7NzUmwO7t2rQXkIC5CCruNgki78UPLShbnEMNDG5GMUSn803ug
 7SQrzyHYdzyQym1traFOkBJZ0Mff8kevfKiA9xiUNTqKuchOok3sCo67AkIrSwqFKGqy/Lamt
 5vMLs9iSaAPldA/EiOH2RnJutBTHisKj2K4Iv8iylBC5tJjhHIIMm3OElOBMK9OTrY0EohpZT
 MkDFLl/zu0FRLykyGy9zFo7PUn2FpmFXUpRYFbJHo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--56BTsRd83vRddsbqhGxmdbnhxFn8EqVWU
Content-Type: multipart/mixed; boundary="csf74gSjujNSmsUI0TxKsqrQUwAcrSoET"

--csf74gSjujNSmsUI0TxKsqrQUwAcrSoET
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> If we fail to add the reloc root, drop it and return the error.  All
> callers of this function already handle errors appropriately.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Better to fold into previous patch.

Despite that,

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 6315e74c1da0..695a52cd07b0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4204,7 +4204,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans=
_handle *trans,
>  		return PTR_ERR(reloc_root);
> =20
>  	ret =3D __add_reloc_root(reloc_root);
> -	BUG_ON(ret < 0);
> +	if (ret) {
> +		btrfs_put_root(reloc_root);
> +		return ret;
> +	}
>  	new_root->reloc_root =3D btrfs_grab_root(reloc_root);
> =20
>  	if (rc->create_reloc_tree)
>=20


--csf74gSjujNSmsUI0TxKsqrQUwAcrSoET--

--56BTsRd83vRddsbqhGxmdbnhxFn8EqVWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IeM4ACgkQwj2R86El
/qg0SAf/QsT1K+uZFI3MDysBbwdeD1Rt3KrwHRQZr6jP3KzwIKxyfSLojNCEeCDD
USANyIGqk2I9fAWCymLN9+IOcl2k1qJ27lAx0omPHtQR++c1y08J1SfM/pXkoDaw
2Bw2xaT4cYWA7BAM9ic81oz33PfyfUo67o5qFRxvy/kHqkVhDkUa4xFAcjJjddr0
gr4AatrWb0QbdCt0v+Pp42wYXy6sZrAmtH6ElkLvMyL/EoS68Q/C+qlYuamOHA1e
GfKbnfiplmiHmAbkLPAx+a2/f7Ql3neLCyWeT/h3znDDJeLjL0Faq6KZvf1HlL3x
HxiQkeluivvslc4RDkWxzjU1Kb9K6A==
=oEif
-----END PGP SIGNATURE-----

--56BTsRd83vRddsbqhGxmdbnhxFn8EqVWU--
