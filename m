Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309F22CCEC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgLCFoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:44:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:60341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgLCFoA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606974144;
        bh=qS6kXSe4oiB4tbCtIGokUGWsJLCxhKj4vaCLttYJHFk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OKsk1kixZtZ4OqnUdwlHr4q8On8yd0U9cNh2nn22BsuWV1IkVoqmjh8w2inFmO6OT
         uy6SVTPYzUoKDeWUfzd6xFxsJm3+UvxvoKukBWOJqNDnpLpdUDIkWiX1Foay8pv0wQ
         smLreAex/TF44tAl1zPeSouRskBM2v7L6jZUDPJk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1kdiyO32tb-00SN7y; Thu, 03
 Dec 2020 06:42:24 +0100
Subject: Re: [PATCH v3 49/54] btrfs: do proper error handling in
 merge_reloc_roots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <bf1e7b86cd6c3e7c2584cd785a7d4e595c1491e2.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <0defa948-9bd5-f8fd-28b8-0404b516cd3e@gmx.com>
Date:   Thu, 3 Dec 2020 13:42:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bf1e7b86cd6c3e7c2584cd785a7d4e595c1491e2.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2v0qSalp9t72a0McsfHovhZhdVqQAuH7I"
X-Provags-ID: V03:K1:61/aeO7v6CLLkaSjq6QhSdgdQOqc/vAi7HOsIzsUtugB70k4Nte
 fAex0Xyc2/M7re7DCljZdm79ysBameHXlUl8yzn3wqlc/108Fr1a4zKDkV4ulOP/z+87riw
 KvSp50FN9J4xKjRisJ9uhrqTnfvB+y09ugFZKy+Ks4c69ISivaJ9mVN+Wp6vfBXg2z6xFz/
 D7Y2Vi61kgGRf1dIHg0ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vId3YXVBLpE=:IbCFB0IJy4DwN3hjr4IfoY
 2y9ouBwZNU/7IyEampIRdlFdMV2fj9SY9kbc0Cu975Xyzn1NJozbKnwlwbW1h4qVpm2gG7ca2
 nwNSBp+FOfWi+1tzyq/tzHDLT9knneueVnE/70XHf8A48vKX55n3udWlFsbrxwbD+sdhouzDC
 qWeDzxvM8UfVxR4D4GauqtOxcg2t1mmumYcnyXmruScc+9hpV5lBZxR4npyatw6FEfyZjBRTm
 gh+UA8GgxaiaBCZicyMswvh1d5k6pELYDHMm9q3yWthbrHDA4BN4gROyj2R+iFqVNhXjVeGdk
 Mvlq0j2K68AJedxUhL6BKTOvqRIsndkNjZuPO2+iztAHeuswWfw0Q73c1aiNh0RxgTKzijG/e
 Pe4PCe/pZx/tZj5mPTeF4SfoLaTwFB/xQv41P+vueaV9e+3vs4IY9IB3Vd+yo2ha2nHxz19Pp
 qWNldaBJ6B5wfHznk1teJxLaEQ9rBzgfPP1tHEjH+/fLXndFLecg4tlTy+q64sQLn5MAcaKH4
 0S+rk2HpWLnN5lLZ77jVdOIsPdTY7xg2+yuwBX2s0bshq4dUmPwyH9k+PdDezKrSJLsg96b4R
 6G7Ax25lRkxnpWmEbxjBl0IU9PRvwPBJau8gO2rPsAXmqV12xVvNOF5ypfeI+hGthXUgcaRus
 qMg9kPR2hP6cv/J1r6SZEcyJkv1aZqFPr9psXg96wbX+dZ+vYTihBXsKVVroG6DSTfGWkB/yK
 PHbcCgHreCzvvXqRyzcnzCwzhs+GoyeuE6zKF6+kqeB8A8oT55cj+2wKjNaIGAOYI9Ieq2J0V
 1vo+mCg1HGLdLJNt4ENKbxwVUQ87WA5ADqeylhutgtDgKlAfsHmAK1O5zOC9qB/w7gVj9AU81
 ndlpyyCLGd+MvqzsVKHwJaK3/rfXqMbTggQHhpj78=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2v0qSalp9t72a0McsfHovhZhdVqQAuH7I
Content-Type: multipart/mixed; boundary="BJu0F2Pi5EzTiErrQCm96s3zBZLtlmH1w"

--BJu0F2Pi5EzTiErrQCm96s3zBZLtlmH1w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
> This honestly should never fail, as at this point we have a solid
> coordination of fs root to reloc root, and these roots will all be in
> memory.  But in the name of killing BUG_ON()'s remove this one and
> handle the error properly.  Change the remaining BUG_ON() to an
> ASSERT().
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 91479979d2a7..099a64b47020 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1949,9 +1949,18 @@ void merge_reloc_roots(struct reloc_control *rc)=

> =20
>  		root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>  					 false);
> +		if (IS_ERR(root)) {
> +			/*
> +			 * This likely won't happen, since we would have failed
> +			 * at a higher level.  However for correctness sake
> +			 * handle the error anyway.
> +			 */

Maybe another ASSERT(0)?

Despite that looks good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +
>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
> -			BUG_ON(IS_ERR(root));
> -			BUG_ON(root->reloc_root !=3D reloc_root);
> +			ASSERT(root->reloc_root =3D=3D reloc_root);
>  			ret =3D merge_reloc_root(rc, root);
>  			btrfs_put_root(root);
>  			if (ret) {
>=20


--BJu0F2Pi5EzTiErrQCm96s3zBZLtlmH1w--

--2v0qSalp9t72a0McsfHovhZhdVqQAuH7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IerwACgkQwj2R86El
/qjuDgf/X+yuOyasB6ZxAW5hM5gap9T70EEWwwY1fFn2uairSMV3lD+YppBiT8kD
wQR3B6swJa00Ltf9D1OLcbKRurY6dMg5aAZhmN6RY02z6BpIepnXOhTHLdcsIpYK
Reh9i+8EIK8k2kVFsurcv8DKAsHJ4Cmx34YTEnEO3HnOrgIYvKQrNa81aPkhgeeV
va2gcQs3WqeCJ4L3aILACNkMy8LBDgtLgChbkPHxJXr9pybl4HbGYR+/NFXPi0gO
1Xpg3qm//K2w42C1iAwO5Z3LR8dI1G1QrS2QrYZI2b16CZaFR7tBYeolB1rBqdLL
EeTOYKoT5X7qf+/4CwBmIt7oxxoZ5Q==
=Vg8k
-----END PGP SIGNATURE-----

--2v0qSalp9t72a0McsfHovhZhdVqQAuH7I--
