Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4051A13019F
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgADJiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 04:38:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:50229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgADJiP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jan 2020 04:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578130688;
        bh=7Y3L9FBEIAmz1xfg3j4icBajHHzfgZscvOjQVqB9OHw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XUKMCuo0vBZQ6+w/RuDjxMk03PbqgsKYLtEdNNnhn65JaPVE3O4o8KiUR5BZ+RztB
         6YK4mRZRPAQlEVWkPPEqo0YV8r6LTJ8QdThY8CImw7CadJDBTJJfk+zMQymW857lZn
         8CviEuCZcw9Zuk6N+7ZEVQfJTBugeebl2w6yKGuA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGvM-1jDSaI3t78-00YfHA; Sat, 04
 Jan 2020 10:38:08 +0100
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
 <20200103155259.GA3929@twin.jikos.cz> <20200103161556.GB3929@twin.jikos.cz>
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
Message-ID: <9cc840ed-d23c-4760-9a2a-da5e3e0deced@gmx.com>
Date:   Sat, 4 Jan 2020 17:37:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103161556.GB3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nzKIyDj0c1qiPgkeCz7pGrtSxYNo51sX3"
X-Provags-ID: V03:K1:ugWytppdG41o6ycYp3sGWP+vTDSU2RbOt9tvaxqW6yjCCWO/Yoc
 hayYqKQoJRvEtVoDIzDIB/DX6JTu9NEnXR4zwmQkhbsi05xE1Hr8UEb4SqnLgZ6Dbm+3M6+
 SAxmWCHoisJoK0w26nqzBR69r4fPD5spyrPIkpe5dyerwtyFWI8PfCQGjogUFAmnnbcZiCh
 PFHYOgGvwayZpyBYavN5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJD/IxZ4cAE=:BV9yusjyJO7/LDNGKDdjMa
 GLlNpAzE25gah4Xxv+B0S9Nt46I/psZzPNG3LB9JfluJ6E3MVgqIczOxXQmdmRrozjiPKIPO4
 6uhfvdCQyioYDdXmi4YzHXS6qFGg2D4lWt8PVbC5nldMqUZoRtGtRB41OIchfqnM6lVRqpuKn
 X9KNvK4pGfPAUWiGpubscRHLegjp/Nsfn5Vyh6q+1dVb0/y+I69gfF0+XMZ1Vm+Dfqeg289D/
 BqqCz54BcismN9Z0ZDzvPCkWNjEWmySQjuD/m88eKXrxmAQ3DtHEGlyhWUlv5ypu9mBAVy4+X
 Nbs5VnJrJ5ol1TcoMB8sCm//J+tG1PiFmwsxh3C+7VK7HN3ImRe5hNk59MSnxkdI1ysHGtyof
 pXshLwgD2otlzgj2YxbFARxtfnoHUa7PlSgSAky4/9+BiBpRb0mdFUP3At45t6SO1Ux0GN7qy
 84Wrz0Z/1Dp1xreAQZ6lJeQENbDgGqiApRLfkcZeXjE/UAbYr/J8T7BHALO3x76UR+VlG/7YE
 p0RVQMSPR4BaFqlGoLO0C0MjGw8U14D75PoDSjdIamDaV+HDZq2JEx4EI032TrkCHYd2RkAVa
 0O7uBILKg7vb+OW9px9Ur+Rc+wUM5I2Pab4/EW+YDfRMB7iskSwQZWzk280dsR1QY/cMhczSb
 VEfuO68tgGP9/p0bEvsxK8gHerF6kwyeP7cN98LIg16cNDIdeG6b5ioPau1kfOKjUhh0/Qx5u
 OzB3ehdPi94f30eRgTgPRqN38t9pM1f7FMOffevusNXPyXNKPZqtavpHbYwOSdQfGHx8XNLTn
 vhDYToCAEWisx+YqNs1naeUYCyjJefAmG6ghdiQacHiXgZkV1bCVgsjwww672wZLk0XzrNGYN
 osPXhTSlgbOeKI3BMearRiClfvOkpGKVLzFQkXxjYlQkD5y5AmbC5U/yNc/s06j5YppRwcb/A
 NTfxhd3qlIxsqgkfQ62zNhNir1uiJEKRbAokTOBfh8RoGWTAFb+U8FNuBqGe164EoJGhDCMPZ
 +sH7BJpXeO0uceovVuXTeh7uEWESDnfQ6KykzIb3F1CLMjxFrHyfObA7en6Jx3hRxB/LQf0T/
 Yh+30GAT9ElIqW+zQGeRaJ0CjnaZwvTSE/L0J3pTf7eF3oo6BGKtSBoNQk6UULtv/OMteJHUD
 ewixqvpGOsZxBMHzLZU0IDN0aYd3iXSErxNDQBRxuiDcc2sWouL6DPe7WQ48caQb8HMnBdcpG
 8iIus1qeUOBOrCXjgikxJEioahfVA5WDzw5H7X7v0epSVR2NoXtgyjfXKeto=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nzKIyDj0c1qiPgkeCz7pGrtSxYNo51sX3
Content-Type: multipart/mixed; boundary="GfZGL4TlwEtfHgxmGTc6PwKkIf7FimXca"

--GfZGL4TlwEtfHgxmGTc6PwKkIf7FimXca
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/4 =E4=B8=8A=E5=8D=8812:15, David Sterba wrote:
> On Fri, Jan 03, 2020 at 04:52:59PM +0100, David Sterba wrote:
>> So it's one bit vs refcount and a lock. For the backports I'd go with
>> the bit, but this needs the barriers as mentioned in my previous reply=
=2E
>> Can you please update the patches?
>=20
> The idea is in the diff below (compile tested only). I found one more
> case that was not addressed by your patches, it's in
> btrfs_update_reloc_root.

But fix in btrfs_update_reloc_root() is already included in commit
d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after
merge_reloc_roots").

Or would you mind to share more details about the missing check?
>=20
> Given that the type of the fix is the same, I'd rather do that in one
> patch. The reported stack traces are more or less the same.

To merge them into patch set is no problem, and should make backports a
little easier.

But I still didn't understand the barrier part.
If we're relying on that bit operation before accessing reloc_root, it
should be safe enough, even without memory barrier.

Would you please explain a little more?

Thanks,
Qu
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index af4dd49a71c7..aeba3a7506e1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -517,6 +517,15 @@ static int update_backref_cache(struct btrfs_trans=
_handle *trans,
>  	return 1;
>  }
> =20
> +static bool have_reloc_root(struct btrfs_root *root)
> +{
> +	smp_mb__before_atomic();
> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> +		return false;
> +	if (!root->reloc_root)
> +		return false;
> +	return true;
> +}
> =20
>  static int should_ignore_root(struct btrfs_root *root)
>  {
> @@ -525,9 +534,9 @@ static int should_ignore_root(struct btrfs_root *ro=
ot)
>  	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>  		return 0;
> =20
> -	reloc_root =3D root->reloc_root;
> -	if (!reloc_root)
> +	if (!have_reloc_root(root))
>  		return 0;
> +	reloc_root =3D root->reloc_root;
> =20
>  	if (btrfs_root_last_snapshot(&reloc_root->root_item) =3D=3D
>  	    root->fs_info->running_transaction->transid - 1)
> @@ -1439,6 +1448,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_hand=
le *trans,
>  	 * The subvolume has reloc tree but the swap is finished, no need to
>  	 * create/update the dead reloc tree
>  	 */
> +	smp_mb__before_atomic();
>  	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>  		return 0;
> =20
> @@ -1478,8 +1488,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_ha=
ndle *trans,
>  	struct btrfs_root_item *root_item;
>  	int ret;
> =20
> -	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
> -	    !root->reloc_root)
> +	if (!have_reloc_root(root))
>  		goto out;
> =20
>  	reloc_root =3D root->reloc_root;
> @@ -1489,6 +1498,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_ha=
ndle *trans,
>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>  	    btrfs_root_refs(root_item) =3D=3D 0) {
>  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> +		smp_mb__after_atomic();
>  		__del_reloc_root(reloc_root);
>  	}
> =20
> @@ -2201,6 +2211,7 @@ static int clean_dirty_subvols(struct reloc_contr=
ol *rc)
>  				if (ret2 < 0 && !ret)
>  					ret =3D ret2;
>  			}
> +			smp_mb__before_atomic();
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>  			btrfs_put_fs_root(root);
>  		} else {
> @@ -4730,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pendin=
g_snapshot *pending,
>  	struct btrfs_root *root =3D pending->root;
>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
> =20
> -	if (!root->reloc_root || !rc)
> +	if (!rc || !have_reloc_root(root))
>  		return;
> =20
>  	if (!rc->merge_reloc_tree)
> @@ -4764,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_=
handle *trans,
>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>  	int ret;
> =20
> -	if (!root->reloc_root || !rc)
> +	if (!rc || !have_reloc_root(root))
>  		return 0;
> =20
>  	rc =3D root->fs_info->reloc_ctl;
>=20


--GfZGL4TlwEtfHgxmGTc6PwKkIf7FimXca--

--nzKIyDj0c1qiPgkeCz7pGrtSxYNo51sX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4QXPUACgkQwj2R86El
/qiOGggApC9+FtqyhPo6dcA4hn22CKUkqOSv3zTSaUevk1fJe0Azl1cNnOgA4L5L
Bu91fhsoZ9ZDlMBQYOUGdFPUMvGrfbs6l1p1zt8lEt0KXtx0hxrQnyArKYufmcs4
rQyYw1q1PjkCV6Y2FZggNAE+CMBvFGd1ZhlmgnF3jkvO6M+LcIqVabUYawn5eoBJ
gRFwE4fsIll4Ty5JlGwXdHurvfk3JR6ZWvJSzu0wtQwzVGdLEh7ic98AzgJ2uXSb
fJjkRVf64Tf2OzB7INxsqNj6l9NlnVvnn5aMhAWGIlZdwAER+4yuAEJdtFGAyuph
HM7xkaHIqqShNv1Gr6mq4qy1iQf6BA==
=E/S8
-----END PGP SIGNATURE-----

--nzKIyDj0c1qiPgkeCz7pGrtSxYNo51sX3--
