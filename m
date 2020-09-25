Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA7277D2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 02:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgIYAuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 20:50:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:54749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgIYAuy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 20:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600995048;
        bh=Jth8YaVCb/yNKclq0pFTxA2qcvWvjYlplqe+jKRMwxw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gId/3Te0J3Zo+1duFuiLGhbZaUB3iQeuXbwNz4gWAe9aohcO7Bjt4LWSW7kNhuGmU
         qifBvVNwCg5UJuluO/ESmWwPvNkfUUgTDi4y/LjoUIO5G8my5/tWoiMj9bY2N+YUSR
         bZM3W/N6lt7mna7BU6Lw+pmHzOaHiIA4K0L5QhZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQjH-1kDZb03fJN-00Go3g; Fri, 25
 Sep 2020 02:50:48 +0200
Subject: Re: [PATCH 4/5] btrfs: introduce rescue=ignoredatacsums
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <c3cc0815c5756d07201c57063f3759250f662c77.1600961206.git.josef@toxicpanda.com>
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
Message-ID: <b880c67e-b6e2-1044-334d-1d82ac3e03be@gmx.com>
Date:   Fri, 25 Sep 2020 08:50:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c3cc0815c5756d07201c57063f3759250f662c77.1600961206.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9NUWjrK0CGuzCZ9N0pOsdLoSulufcJFGu"
X-Provags-ID: V03:K1:Kn0lEiNLK9QA/ZkXO9tyu9CldtCwrb4znYVBulEDoJtyjtwoiNt
 OWv55NDyr/RRdB+G6t9Hbj1zEYpWz9SH2KmLiT2I7PIhMXbHTMKcQwlt63cAYFSXWxCLwnK
 PQXF+GaWQS5HJJk/z02ofQiBtFo+lbo0Dols1b5gah1ZpXDbsghXqfX6jUP1RSnJswfyJRb
 S2EG8+lM2U6PdjQxlCTrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jig8l3+LsxM=:nZYMxXQ2F0YXJpl/yHItuu
 zCbdq4ZZPqekKOXTPzeYog+0ObFCsnli6L0wxOdba6dbDJOjB8PnEgj1U297smQSgwsS62yTm
 XRrDNAuIVV6xYlYJH8/L9z5gOLrEtNXQ7nTUD+669jijKc1hum5oEJOksJntL3BrodVWLH0FQ
 OFdoLGpg5AlvW1pFg1Qiz6QnaQcSzqMuzI9xPS3n6p97bo/FCnSdHdRBYQCSSXa+TkYH7/3DO
 73YojDNMvJ9hqcY4q3IK7UeuGX8Rg8K+ftRL6uIPFt+g0HQkD0utsI05nDXv0a8PgSoMgVk2+
 +wolrKx4cLcnvZIAAmG4dGPXadtv06iP5gWStrxxdiiMAIb6eQZC2hsFQX6EceeBFyXaGp6QF
 isMvCek9IR8kV8i+RugpAsgLmd06QDbfQB5a9ngRlOq3KQwYimMBUep0iOoveDQuNDgK9Z9WR
 n+ltNVySSdKpX+dvg1ynAU9K7rUaHXLOXfyg7nfd/NpE6m6VcII2Gr6GmpD3Y+CqAiCzsh/H/
 IsFMm9EqyGJl5fMgtfeKQpMPGfFVUo7ixOfYvkbX/QwT6yOeQ8zwYgt42Uvb6YyIXg26WC8Jf
 I8pWRuG96hYgrFx6wNl9sUhPwxwh7+Jg6SqD+16RnWAWj55wy6jLM0yPEp0+zEuDPVxxP9b7I
 2Y1oZDD31M5eXP/2zLl6AhRk0lQM1+lrbf6v7XVOBkdEp5+lh8KrfdjnC3RcYCjChs0sa6dBZ
 H6oHAkSyxqsXkvCr3gLY15kRLPPq5Ymrwz+FXnDeIN8mJtn+Cmdk326ScyAcrCx/YQ1qTS+RJ
 yi/qcvWvc0baqJ3docyN9s7e8DMMSmauzb2mnJcW8XoQKoDFFXDDT4zOyN5yPQe1V//dwNueL
 Nt2eYU06BXA0cWCoVCNpDICQV7yKCcEn1JueZxraBhvNpjd9eKHmX9ppyJKZ2OubsIisnGr6l
 eUmwm0HTOfHd9upmzKmSk3eCrtXfQP2CyATVIaW028msrO9Qy8kN+RfLIiaSiYVwaw9k/NVY3
 cMH5Ycgz2+RQVGfWH1Th+SzrbJQN03RMCSkXrvD5YsoY4O+lM+qIWLXLylLe7CLMN7SCBTJLL
 Vh6tySfl2YhFwNxbQFGSvYTfQ+zjHJfPmL5Knl+keEbwzp2Pb6npD6B3sy/o2qv7R/98q8wh1
 XsMtY48AXNoI6nRVV15Qk1NVhAXmdrZ8suzfPuGn4jEARHwreJpcqauJazfm9DkW0wzVF3/PD
 LdDGnMaAqOTY0X++q+3xkgIBBpe0m3TVBqGcFJA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9NUWjrK0CGuzCZ9N0pOsdLoSulufcJFGu
Content-Type: multipart/mixed; boundary="FWrO0XO5b3sy5uKVFSYQshl1pkSlswp3q"

--FWrO0XO5b3sy5uKVFSYQshl1pkSlswp3q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> There are cases where you can end up with bad data csums because of
> misbehaving applications.  This happens when an application modifies a
> buffer in-flight when doing an O_DIRECT write.  In order to recover the=

> file we need a way to turn off data checksums so you can copy the file
> off, and then you can delete the file and restore it properly later.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/disk-io.c | 21 ++++++++++++---------
>  fs/btrfs/super.c   | 11 ++++++++++-
>  3 files changed, 23 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index fb3cfd0aaf1e..397f5f6b88a4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1296,6 +1296,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
>  #define BTRFS_MOUNT_IGNOREBADROOTS	(1 << 30)
> +#define BTRFS_MOUNT_IGNOREDATACSUMS	(1 << 31)
> =20
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5deedfb0e5c7..6f9d37567a10 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2269,16 +2269,19 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  		btrfs_init_devices_late(fs_info);
>  	}
> =20
> -	location.objectid =3D BTRFS_CSUM_TREE_OBJECTID;
> -	root =3D btrfs_read_tree_root(tree_root, &location);
> -	if (IS_ERR(root)) {
> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> -			ret =3D PTR_ERR(root);
> -			goto out;
> +	/* If IGNOREDATASCUMS is set don't bother reading the csum root. */
> +	if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {

This indeed matches the name, ignoredatacsums, no matter if the data
csum matches or not.

I guess if the user is using this option, they really don't bother the
datacsum and just want to grab whatever they can get.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +		location.objectid =3D BTRFS_CSUM_TREE_OBJECTID;
> +		root =3D btrfs_read_tree_root(tree_root, &location);
> +		if (IS_ERR(root)) {
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +				ret =3D PTR_ERR(root);
> +				goto out;
> +			}
> +		} else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->csum_root =3D root;
>  		}
> -	} else {
> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->csum_root =3D root;
>  	}
> =20
>  	/*
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7cc7a9233f5e..2282f0240c1d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -361,6 +361,7 @@ enum {
>  	Opt_usebackuproot,
>  	Opt_nologreplay,
>  	Opt_ignorebadroots,
> +	Opt_ignoredatacsums,
> =20
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -457,6 +458,7 @@ static const match_table_t rescue_tokens =3D {
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_nologreplay, "nologreplay"},
>  	{Opt_ignorebadroots, "ignorebadroots"},
> +	{Opt_ignoredatacsums, "ignoredatacsums"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -504,6 +506,10 @@ static int parse_rescue_options(struct btrfs_fs_in=
fo *info, const char *options)
>  			btrfs_set_and_info(info, IGNOREBADROOTS,
>  					   "ignoring bad roots");
>  			break;
> +		case Opt_ignoredatacsums:
> +			btrfs_set_and_info(info, IGNOREDATACSUMS,
> +					   "ignoring data csums");
> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized rescue option '%s'", p);
>  			ret =3D -EINVAL;
> @@ -990,7 +996,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info=
, char *options,
>  		goto out;
> =20
>  	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> -	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots=
"))
> +	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS,
> +			    "ignorebadroots") ||
> +	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS,
> +			    "ignoredatacsums"))
>  		ret =3D -EINVAL;
>  out:
>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
>=20


--FWrO0XO5b3sy5uKVFSYQshl1pkSlswp3q--

--9NUWjrK0CGuzCZ9N0pOsdLoSulufcJFGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tPuUACgkQwj2R86El
/qittgf9HKVCKadREsjOh4mfgXDpb23FZgTrEIaWFWp6SA1UZ/R9nKNgfnpwuoiH
YY1JZ+J91JzimGQwtzXJ1kMixRH74rTfvWU7csuHT1QdhgvTpDPkpd7MrvRfInJD
ZJAo21Jx79TyYMJxR7bDzbD0ekYxcBVsrq18U/ZP1aW2vvJ5XPHzfOmsH7y0QfnA
itNH4oPzvQUm2cDEcNQJc6mNL3DLUacPfD3WDXnc3HSvdRuFma7udcPZFXOHKdip
s1aH72RJI3YZGpu+6zd0p9lBu1CwAfvCAZkU74FSeVNr9g1RRxFf53LBcjUaQNSA
urWnipsGt1JkOtxVxO6eN18Q5qyojA==
=oZQ0
-----END PGP SIGNATURE-----

--9NUWjrK0CGuzCZ9N0pOsdLoSulufcJFGu--
