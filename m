Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0105D2CCCA6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgLCCbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:31:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:57701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgLCCbU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606962584;
        bh=YVQWQkq1r5PaAsaUllyzGQJiIM4E79RZ+d8xloDkMS8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=X0Q5zi/qY3bhRG+D2oYZB4vwqtmFDPNoXwo6U9tFoFhLdBIYlhUjQrWAGO+2n463T
         Rb9J5hjZuff9U93Y6nOJuz4A1RLJXWORtuUDYrSmNIwAn7kZZ1RWCO/yOUMg0lIA3q
         1vsQfAZhePsE+EVPZD/T6Fnlz5v+SAscGWNyUcAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1kn8HO1ZyD-006wz9; Thu, 03
 Dec 2020 03:29:44 +0100
Subject: Re: [PATCH v3 14/54] btrfs: convert BUG_ON()'s in select_reloc_root()
 to proper errors
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <a9346ccd6f5de1a6cac12918ccace014b7f3bd6c.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <d06dad66-d597-b650-62b9-0e04d531f2e3@gmx.com>
Date:   Thu, 3 Dec 2020 10:29:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a9346ccd6f5de1a6cac12918ccace014b7f3bd6c.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HyB7afA7dWSYd4spo0jz8IEkCYb6BqSBS"
X-Provags-ID: V03:K1:g82KsCbI86cBcJ1AI3/+xq59Kff1bkOTEQyMTzbhBNpC48gnGDU
 AFBqq2PdElOFGPxWCynDx/d9+1T6w8xsSe2Dl3y/xwuCaV/foAW8Vo43SV666x7lDtWhi/7
 fWFqAJQNvaP1/e0fg6+tDiCgIdqcN/wp7kEr5JY8hZA9UV5Q8ehHZ1GX8/3eFpe30A0IRDU
 nxJuioELma0aN+vEg/lNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9h/wkVDFA+8=:KZxn3JXju4o5UgwUkaYRZ1
 qdTdxPGuhT1ainMG7b80CUEcGCDGnsAGyXo7dgf8Zwa2V3GAk8KSv4GaUHUqqlScHYFEgJJeh
 7smWQTX4LL7vdut/WoFSAGiecqjGH4q7VUbC5POBxvZd/WI/bb9wc5wJTSxCKJpowJ7/HETjf
 COTlSW8OApz/d7CXha7yIv9MBDUrWj0+ul6I+67aeY0Qs6T+6imM0DlN1vcwFhHMQ9EpwRa1A
 7C8IluuDlll+W+m7GoIQTS4NjbTUddv46vhNUaaE9tlE9Gm0I0Bk3ecrRS5xo4YnGFc+PN3Kw
 39lpiPLGLZNshmjFRl5Ujnly1jjfAtCBEK9lukh5b6a771AyztY/yxcGRmefo8ePqLybKpnNn
 ShuI37nD6t/oR6rNfqCeiJ3ryyhP0lvyIOUul5fn2dlauvrMgAiyopOuKkhHme//B1Wyuo8JM
 i7xhXKz32+pSshSlRA7s23w0LrfBsljOtzbLEiURVNGcZJgczjUZ9dMoKn4NLFVeut8yGRqd8
 D2v9n9caWPuCPfOnAooO6wzLXhe4kk3v4KCsCatq2dEmMOOEafzdEOQBwakzt0a96qAWB6Wgk
 /K8Z7yLnUWR+39PYxqH/GgVt3M3FkYu0lutiIkgSLnYCnFLPkEpr6o0HXceOtSQm1XPRd9lvl
 tlSQFl5yIyPVIWZkMROKsHuqgybCU77/cIv6J1BpgDBWbwQPkB/XOHDTTDwUvnf8wRSCzafDU
 lRIVwhe1G9eYqMI427RIyqyU78BBWeeVaLCNtT0ByaL73KgFi35ztJziVm5fsUOA9kguS3D5s
 XyWGXsONlMTEPH25Yh1zVSJOWwqOjbUsA1Bl5UPfp4oXslqYs7skekfDgTiVALDZVjD4biDjz
 2J2GMuW2nR883rZ0Gfqg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HyB7afA7dWSYd4spo0jz8IEkCYb6BqSBS
Content-Type: multipart/mixed; boundary="DBEQNrX62FgUnoGI2qegwyrmqtngXbWpD"

--DBEQNrX62FgUnoGI2qegwyrmqtngXbWpD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We have several BUG_ON()'s in select_reloc_root() that can be tripped i=
f
> you have extent tree corruption.  Convert these to ASSERT()'s, because
> if we hit it during testing it really is bad, or could indicate a
> problem with the backref walking code.
>=20
> However if users hit these problems it generally indicates corruption,
> I've hit a few machines in the fleet that trip over these with clearly
> corrupted extent trees, so be nice and spit out an error message and
> return an error instead of bringing the whole box down.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 51 +++++++++++++++++++++++++++++++++++++++----=

>  1 file changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 66515ccc04fe..bf4e1018356a 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1996,8 +1996,35 @@ struct btrfs_root *select_reloc_root(struct btrf=
s_trans_handle *trans,
>  		cond_resched();
>  		next =3D walk_up_backref(next, edges, &index);
>  		root =3D next->root;
> -		BUG_ON(!root);
> -		BUG_ON(!test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
> +
> +		/*
> +		 * If there is no root, then our references for this block are
> +		 * incomplete, as we should be able to walk all the way up to a
> +		 * block that is owned by a root.
> +		 *
> +		 * This path is only for SHAREABLE roots, so if we come upon a
> +		 * non-SHAREABLE root then we have backrefs that resolve
> +		 * improperly.
> +		 *
> +		 * Both of these cases indicate file system corruption, or a bug
> +		 * in the backref walking code.  The ASSERT() is to make sure
> +		 * developers get bitten as soon as possible, proper error
> +		 * handling is for users who may have corrupt file systems.
> +		 */
> +		if (!root) {
> +			ASSERT(root);

ASSERT(0); maybe a little less confusing.

> +			btrfs_err(trans->fs_info,
> +		"bytenr %llu doesn't have a backref path ending in a root",
> +				  node->bytenr);
> +			return ERR_PTR(-EUCLEAN);
> +		}
> +		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
> +			ASSERT(test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
Same here.

> +			btrfs_err(trans->fs_info,
> +"bytenr %llu has multiple refs with one ending in a non shareable root=
",
> +				  node->bytenr);
> +			return ERR_PTR(-EUCLEAN);
> +		}
> =20
>  		if (root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
>  			record_reloc_root_in_trans(trans, root);
> @@ -2008,8 +2035,24 @@ struct btrfs_root *select_reloc_root(struct btrf=
s_trans_handle *trans,
>  		root =3D root->reloc_root;
> =20
>  		if (next->new_bytenr !=3D root->node->start) {
> -			BUG_ON(next->new_bytenr);
> -			BUG_ON(!list_empty(&next->list));
> +			/*
> +			 * We just created the reloc root, so we shouldn't have
> +			 * ->new_bytenr set and this shouldn't be in the changed
> +			 *  list.  If it is then we have multiple roots pointing
> +			 *  at the same bytenr, or we've made a mistake in the
> +			 *  backref walking code.  ASSERT() for developers,
> +			 *  error out for users, as it indicates corruption or a
> +			 *  bad bug.

The ASSERT() comment mentioned everywhere seems a little overkilled.

> +			 */
> +			ASSERT(next->new_bytenr =3D=3D 0);
> +			ASSERT(list_empty(&next->list));
> +			if (next->new_bytenr || !list_empty(&next->list)) {

Just ASSERT(0); here would be good enough.

Despite that, the new ASSERT() for developer and do error handling
properly is really awesome behavior.

Thanks,
Qu

> +				btrfs_err(trans->fs_info,
> +"bytenr %llu possibly has multiple roots pointing at the same bytenr %=
llu",
> +					  node->bytenr, next->bytenr);
> +				return ERR_PTR(-EUCLEAN);
> +			}
> +
>  			next->new_bytenr =3D root->node->start;
>  			btrfs_put_root(next->root);
>  			next->root =3D btrfs_grab_root(root);
>=20


--DBEQNrX62FgUnoGI2qegwyrmqtngXbWpD--

--HyB7afA7dWSYd4spo0jz8IEkCYb6BqSBS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ITZQACgkQwj2R86El
/qivPgf/edC3xiRb/qao9RouQT8CwjJopRAHUSD1biMl4NWEleDH9vvQrpFXLo1h
M9gKhsxtVHQ+IFD8Jqj7Oz0y8WkE/xbjnZBH9wqu2JRFoGnARnRS0wFhT7XeI1vL
BFnjEZUuLmrlbodE1yjP29HVATZY4zcPXl02ZS4qR+sE6JDojH/m59B9sYGs4k2R
VFSUJUyzVLIMzjHnkASL4ct30Q4grASwn3q5P956RWoeyImZU3AZmUwT4Dh6Kcst
J7je8uMUnI4ZEImxuwqzQO2kNYslKbZTBqVnKg5MhWnJ0nH0YxKdp3dvh9jFMlaJ
YTH1OBmHmTTGRGoaenSQ2tdroI8y5Q==
=bGmU
-----END PGP SIGNATURE-----

--HyB7afA7dWSYd4spo0jz8IEkCYb6BqSBS--
