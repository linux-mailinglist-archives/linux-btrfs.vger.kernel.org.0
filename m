Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FC2CCC52
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgLCCOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:14:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:42249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbgLCCOq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606961589;
        bh=8IsrJt/uKbm9NwqozCpkrt9x2/6eNKK9HPmRiDIz6W4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Z6gXxOjEvJx5Q/uQ6+KAUfVQZ/TEh9gjepWXkJYOzmFgpI6aIwS0d2zXBdl3KZZlE
         tnOctQHf4sd5zwliZsyrXXP2QSkjfiD+i54W2QEYd3Yt1URFo5uENoTf79VfDnOmKo
         ykQnNZf5Vhi+RimgxOCI1P5+Zm2Krwx9N1J7alRE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6dy-1kFRxi1FQU-00hefB; Thu, 03
 Dec 2020 03:13:08 +0100
Subject: Re: [PATCH v3 09/54] btrfs: don't clear ret in
 btrfs_start_dirty_block_groups
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <89d8fc9f58723113f0f6685d67480541044839d3.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <d05b6636-3624-b9b9-2eff-8d60bfe8603d@gmx.com>
Date:   Thu, 3 Dec 2020 10:13:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <89d8fc9f58723113f0f6685d67480541044839d3.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RU2HkgKqSm5S54kHXxVCL6U02zmSkhvh9"
X-Provags-ID: V03:K1:eOvIqSc0juRdFdmYv7FoVBr64/hbOAC4G4ZDqBpSYlSwQ08XYdh
 jiI3t6N2XjRX5eQNGjg5MMTf0sd5v/iF0ZngXbiMLZNR06u/WC3Ls/JzFQDRA2KW2VUfIeI
 aPgMLT9lWX7l0eGmnmAh2F9fezQiqY6q+u0I28V/srXlUjeZe3WvZyoyAwPb3VEmIIPHMmP
 xZuHTPGTvwHYH8JmRHd2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JCZSdfaEHu8=:fZxW81CikAgOhL2UC33AZ+
 6CZjNtfg/Q8lN88xJ6xgre5VULMG159aoSXLZIPXkTsLYGy2ECqzEAM4Y2X9rDJRZBFfbBjq/
 9+zUe8w7sDgsV0rKLFjKbJFxIIymApYeI+L+vwpG7/Z7oA9tNilizeMmFEwJVJEJCV3p3txYX
 +4bUR2YeiA1konwmYN6jmw6TjforoKzwvBA4A+PWP14ZtoUBbZ3NXPM0ttYt1xwmzUK80QdSZ
 Sgg3S2gGypZzg1G88kH1nr4ORGwWnFN6dF2Hq3FctIBb/J8s9HFAkFS08aNz5pQboCXtIihZT
 frcCew53FmnmXoHuttAmWfS1lr334eRX952sMCl+b+Fe0GqTloqFnAbcTYR07VGdZagg+oV6S
 vU1KnhZL4EvbsbMAqpbpDmb/5oRYGHCJ3qquqCZFcQpNKfzuewqSOrGtDNGKBIlRTGAtbYCkB
 nKGknUC5wF4A3zmhviDQiiQNs1yFurJarQ7507lbU8rU4tpELnBgWkQvh+YMJlhbuHO08QDJr
 Qjq0JKrIyL5LE8x0qLjCYE5hTYmIF3C5ecnpIfkPHLNQQ/WVLaFB8cmkD2Xu6wwPmaR5wlMrN
 QS0sexn8zO2HuW66OifIT82uU+KP13Qr3rZSDUS1kzgw0Jx7TBPSIl2Ia3nd5LLKQe1G/1mkz
 oBAP16f5qOx3ja06iHsVfa/qFIKGrC16XvWcodh17xXac3KraZIK6sGkt7I2PhORV0IgGRw8E
 VRgR8uVCS6dEe7lRpqWw1QVhoJgqwxkp4T6bUOiZuwq4kSd4VIkuKLjQdOGFpHYYOh8EPBrqh
 5RCCeIGh3n8j9Ewaq9Ahzw0IRoF6qjJet6hYaQtEIieH//GfphTBddRu5u4UgMA6vKmP0jJ0z
 5PXnoxRKVGtdvGmWN4Mg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RU2HkgKqSm5S54kHXxVCL6U02zmSkhvh9
Content-Type: multipart/mixed; boundary="UWIlJpwAH3si2n1q4afdcoACgVXQlfr2C"

--UWIlJpwAH3si2n1q4afdcoACgVXQlfr2C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> If we fail to update a block group item in the loop we'll break, howeve=
r
> we'll do btrfs_run_delayed_refs and lose our error value in ret, and
> thus not clean up properly.  Fix this by only running the delayed refs
> if there was no failure.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/block-group.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 52f2198d44c9..0886e81e5540 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2669,7 +2669,8 @@ int btrfs_start_dirty_block_groups(struct btrfs_t=
rans_handle *trans)
>  	 * Go through delayed refs for all the stuff we've just kicked off
>  	 * and then loop back (just once)
>  	 */
> -	ret =3D btrfs_run_delayed_refs(trans, 0);
> +	if (!ret)
> +		ret =3D btrfs_run_delayed_refs(trans, 0);
>  	if (!ret && loops =3D=3D 0) {
>  		loops++;
>  		spin_lock(&cur_trans->dirty_bgs_lock);
>=20


--UWIlJpwAH3si2n1q4afdcoACgVXQlfr2C--

--RU2HkgKqSm5S54kHXxVCL6U02zmSkhvh9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ISbEACgkQwj2R86El
/qiZtQf/UjgdJmQ/SIs9oW7ICq405f1mCLNW4nElFjlvH9q2WxeSRFB4HALLnFDa
DGB4Moi+G18MRRsbX0tCfccYciIFAQmvZBoWUh8s8+xJEw+DzivEkOr43eqI3HQ3
j+wzqYd7oqWWINXhaAhz/kJwZi6HUOoFeS11MJO3U//XfyEMN60CmUMjvD092FTx
5YLwahHVo2zEw69/HYJtEQ+ITN7gUehbo0Y+feSUeTSj1nldjogR2I3uGkKdAksM
S/4XjxcT7etQjCyu5HcpfKIWHOHdG9HhEIlipiYCl82zbkiK1an3Vb/WfyfonWkP
nuPFOFteWb7wzJpLOmniqsCD7ZE+OQ==
=s/Fv
-----END PGP SIGNATURE-----

--RU2HkgKqSm5S54kHXxVCL6U02zmSkhvh9--
