Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D02CCCD4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgLCCtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:49:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:44729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgLCCtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963657;
        bh=gwtwpH/z+8lptk4VtBjGWf9ZpXjctna80vWIvVV3uvg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JflDVWgs8ph9v+9oPFRl9D6Onw9GdSHD6TiAErO+G5+n5DBdwLGVoYj6xEQk0I6PT
         gaymmK+fqtr4uI8VSboHQ0lv+jmw+2mI4cNClazL6p3XRUgRFyC1mGRFK2nOafsDRf
         KeThHtzl6aJHNKleuxGkSreyEr1AncdNJW9wR4ls=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1kCyKb1jzJ-00anzj; Thu, 03
 Dec 2020 03:47:37 +0100
Subject: Re: [PATCH v3 23/54] btrfs: handle btrfs_record_root_in_trans failure
 in start_transaction
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <9d94f28749b1f526dd79f562be6c61f51bfbb8c3.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <3dd29c6c-183e-292f-1a1f-440b8a033c82@gmx.com>
Date:   Thu, 3 Dec 2020 10:47:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9d94f28749b1f526dd79f562be6c61f51bfbb8c3.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="orLxInOUCf3kdjD0vwWoy6mVrs1PN6khe"
X-Provags-ID: V03:K1:JmZOdo8iwxAJCPp6V0ekx147fpYK48dppmXWrCVZuw/nBUqnzA4
 PjEMrl0FY6xn6jZtT0Y0uOWPuye0fxhKmH3DUfMdwpt+QaAg1wJQXKQJX/0ZJ+JLwjRT+K3
 ujhB2auBtTO46kMynA0KnPxXaQxAmgTetmHI6T2V7bEjBsY8QglDDCp9SlhuESe5vTIywgt
 /pX+Z+//0y95J2v7nvNng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AamnPcfujZc=:9BPZz9UrJTxoQDyIsJzS3/
 6sHJrRSaepavCWZviBBM34isONY5K3DBoI2cRyPVl/kkvlYHEc+Mobkv4iwrZ7450jK3VngM1
 R/573q3DP3CBTDSe5hf3MAAKxLWQ5cfmG6tDmzbNl7vxL0Xt+tJ4xpYPoRo+NH3ElR1pczBGd
 hPLPO5ZN8/kp0e1i0MKuYx2dqXf08f2cSlIsf+39lNJbdJfDyLlZua2DPxgIpocp+pH3edLgN
 Pg1X6KNlLV7r5511K2w1EiJ9gpDuSpoa/XPM1Msrs/V2LCPAtdzCMlb1i8lv7xi/oeaPzfPv/
 enez3vD5JDH/AAVlB1Q/drGvxtlGujw1oGSvQLQ0UHB3rlNDMrD5w/e9/rW3eFGb5ir71EAHi
 r6NpNiS7RsFhciJ3Iq1k7vmZXvgSo8CD6/2WLEMwzyZ1tIAzC2n0JvKqbBLUTLNysM1CyDOUi
 bwCtQzV4DgXG9N8WTTkOGOGsjV/Ss7EkaNwLN7GhJZ61A53sLn6tnJrJm/fV5rYw7T6EG0YS4
 1Gyky5vjZPbOKW7cT3sAHJPAvbLqbuUu5EO4lRYYmHkNB+Hl2X4VsRw0k4iJK1+L6Yh1+RNbq
 6m1EsNfrMsWHftgXWUrm54JkuW7UYqCyBeL4Am8QIJ/mpjXdxDc9sdKR5D/0QR4FypSM1NtuE
 I5bQ8RHtEDpJ/iZQPPNud5zge7IeEwZCu3nt4xeJcWk6QQkdc/BccW3XJmGRuR4QLzWUjnzx4
 +d4sNKk5UqqLXb916CHiRVrLPbqE2ISVl6p8u4Duw8WDp4kxo2eTL07RG6gSjGmsNCer+52GT
 nWxm2t74mPROudps85o6V/4vO2r+wKhQ0TolYdpMuQRm0UIGYlkUFmgD9oKiWwCojxqN5QNAI
 LFCx+9fj3PIjdKkFnELw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--orLxInOUCf3kdjD0vwWoy6mVrs1PN6khe
Content-Type: multipart/mixed; boundary="VcS8toQfaIQIcI9RCamuyjHIVTD6UtGFl"

--VcS8toQfaIQIcI9RCamuyjHIVTD6UtGFl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_record_root_in_trans will return errors in the future, so handle
> the error properly in start_transaction.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

THanks,
Qu
> ---
>  fs/btrfs/transaction.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 28e7a7464b60..c17ab5194f5a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -734,7 +734,11 @@ start_transaction(struct btrfs_root *root, unsigne=
d int num_items,
>  	 * Thus it need to be called after current->journal_info initialized,=

>  	 * or we can deadlock.
>  	 */
> -	btrfs_record_root_in_trans(h, root);
> +	ret =3D btrfs_record_root_in_trans(h, root);
> +	if (ret) {
> +		btrfs_end_transaction(h);
> +		return ERR_PTR(ret);
> +	}
> =20
>  	return h;
> =20
>=20


--VcS8toQfaIQIcI9RCamuyjHIVTD6UtGFl--

--orLxInOUCf3kdjD0vwWoy6mVrs1PN6khe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUcQACgkQwj2R86El
/qjg8ggAn6NS6P3DnK7rKsHGtJrK+abhjoXfagqh4DDFIk493vEvJHlXhmttFi8w
LBbPeiGyr8zAEAwgb8bAhprwzTUZP5udvkAGvpXUGv2HqAT0nv+89uNl65eX0hVL
z7NcZVJ312ki2PEnE90sXVeyO2mpaF0BVKfIeujk2EWs2kndFqdVq6jy6ir0CHaZ
U3PfeqZMmW2ZwF9+T3m1KT7qF1M+aFLtFcbrVP/hS44du2BUuRZyRTtpnDbz+YZ/
uZ2CPCYJ1DU/oFztJ+TWGf805HhYbjO/O+OTyF4AQrYn+8lV9N2MrqqEiiISoAB/
WJW2cAgJ2SVLaYmd8MYN/f2l6dcBkw==
=Cua8
-----END PGP SIGNATURE-----

--orLxInOUCf3kdjD0vwWoy6mVrs1PN6khe--
