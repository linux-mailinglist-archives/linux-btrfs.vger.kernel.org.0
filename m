Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625D2CE931
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgLDIGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 03:06:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:58793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgLDIGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 03:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607069087;
        bh=NuTkFQXu+8OtBGrs1YStnbJ8In6451ZW9xySq1+zPug=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lRvT10o+gL835tHjTpMSWscahunt9CXAWFglzMsPEwrcZmuF7X309rsCBTCbOxWSW
         TH61Aa0muCaI+MgrAdM8KPyn84W6ZmidhH87z3qVfBybinAO4AqmXssPeEwhYI1GCl
         xiHQElAY+ZsW7kZkT2zoikcKu+sBLdmdDb0xZtbs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QJJ-1klutX4BKX-001SJH; Fri, 04
 Dec 2020 09:04:47 +0100
Subject: Re: [PATCH v4 15/53] btrfs: convert BUG_ON()'s in select_reloc_root()
 to proper errors
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1607019557.git.josef@toxicpanda.com>
 <6f12922c8edd64c9df4b09068a1ac15159523d3a.1607019557.git.josef@toxicpanda.com>
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
Message-ID: <8b9ddc7e-2b75-9bc3-5bbd-b9691903b9c3@gmx.com>
Date:   Fri, 4 Dec 2020 16:04:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6f12922c8edd64c9df4b09068a1ac15159523d3a.1607019557.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sa25ZEhiL4m4bHt0vhf57KpCOz9Cp5sLh"
X-Provags-ID: V03:K1:LlhqtZ0VaHz6B/KLNn+rVutAklLaqonqUwh6WPv/edbMAuzL5mn
 2jm0iyE/7qEyGpxue1t4Pwj1qomLyjUpvpNo/zQClWvLPSZQJFnQXaDp46/7bStFltBk2CY
 vstKHlQUWbziMzV1lNLiBycphONBJCMmdq4sbUFRjZU3cwV/fwwxcfMiQVECemYpHBtUHIE
 3ifiRUiC5fSp+7OOysT8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dQbTxZABLw=:KMI+obtb31jrKZ0X00t+Kf
 m6QO1Jy29reVjiuoKvc53OVTTU2nPD60ZNPwIJZVEGOlVYFsNF7i9ehzT0XdtIbCxAylM/eTh
 HuzR8g5lbn2x4Hx4s5KGMxRf37S4Uj0daNd1zZeY3WI5Aiu6rxFDTMnhh/xXC+gLcRi2TbXVh
 GoUts895kxoIQtumHRzk/czCmXE3nGbzRhpUDvViNPxgDgTrRrIrAvdUI4DwRddLZXwgBLjbr
 +KyjjRy7AZbIRHVlMfrVBUuKybaeM8MSzD5KfyhqMVIv3K5gGWQdrBH9U/tbTrrHvfS6NHeID
 B4h4Bb9xCjZ91/8sSZksfnzrg2v28FfXbXOdbDas2l6PPLMRysx2tEZaH56UHY5gkBTDb02rT
 NuUQuz7Yp1o4b1jn0DME3Ca0Yv/NS04Dq2BKa2h7iy1CrcexeXjY+0BAx+ZUqOL009WUoRRPU
 nSwhTj9dmJ4zUBGHlMTg/zJOVjUHIkNzpU0mSRHcPpf9kpMBaOrkxMXBjSVyZbeDjsbWasBBS
 yRUMInTXUmyY4lJSli639ozXvViZhoD9HhMZeOVkImnWr3iBv1OAhqi7yNCpYnPv1J9nr/ACB
 v5KIX1XFxgdhxs+aqiSboAkH4m4SkRH9FjrNaeOaR0iFsHQkdeDa+n+m+yNg+L6IE2LxJ8Xoh
 S/OvlYz6NPHEjmXDF+g2ckebe+vcNjThjgKVzDeFLV98w2z4BniGWHnhg10czKtVimwWSOedT
 SZz+LqDOU5MY5yPLGZI8+8MSZ4BVpQz3vYc2QickxNvXQkMrDyV6/TVO597pIHAS6g7kbPfM9
 xvU8vbXvJC8AUHSIw4GCiqmWbzNdt1OV6Uw91RLVqnR3QiauCgGhwy52LUTdr4fxV4eewUdDP
 /axJgExe7HjiILsdXFog==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sa25ZEhiL4m4bHt0vhf57KpCOz9Cp5sLh
Content-Type: multipart/mixed; boundary="N7TLBTIVW7PjNLUHxpZinWuk1vRuFXkhF"

--N7TLBTIVW7PjNLUHxpZinWuk1vRuFXkhF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/4 =E4=B8=8A=E5=8D=882:22, Josef Bacik wrote:
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

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 47 +++++++++++++++++++++++++++++++++++++++----=

>  1 file changed, 43 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 66515ccc04fe..05b80b9ab1e1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1996,8 +1996,33 @@ struct btrfs_root *select_reloc_root(struct btrf=
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
> +		 * in the backref walking code.
> +		 */
> +		if (!root) {
> +			ASSERT(0);
> +			btrfs_err(trans->fs_info,
> +		"bytenr %llu doesn't have a backref path ending in a root",
> +				  node->bytenr);
> +			return ERR_PTR(-EUCLEAN);
> +		}
> +		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
> +			ASSERT(0);
> +			btrfs_err(trans->fs_info,
> +"bytenr %llu has multiple refs with one ending in a non shareable root=
",
> +				  node->bytenr);
> +			return ERR_PTR(-EUCLEAN);
> +		}
> =20
>  		if (root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
>  			record_reloc_root_in_trans(trans, root);
> @@ -2008,8 +2033,22 @@ struct btrfs_root *select_reloc_root(struct btrf=
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
> +			 *  at the same bytenr which indicates corruption, or
> +			 *  we've made a mistake in the backref walking code.
> +			 */
> +			ASSERT(next->new_bytenr =3D=3D 0);
> +			ASSERT(list_empty(&next->list));
> +			if (next->new_bytenr || !list_empty(&next->list)) {
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


--N7TLBTIVW7PjNLUHxpZinWuk1vRuFXkhF--

--Sa25ZEhiL4m4bHt0vhf57KpCOz9Cp5sLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/J7ZwACgkQwj2R86El
/qiXlQf7B7tSEN9/QcllKCPVByv4aRAy/pxa745ai025p1YXkovgG+ebzLJ7UdwA
j5ncTfGfXobm7IPp0gJ7s2rCDOQwXpL95SZiF+d0tL1FzPkrVbY2AGti6G7rU0aI
4npkgUoqLvYcvsLq0I3jeDNC1ANAZLikwo3zW8A+gHPruVijZjrYQIhE5tZ+IEJE
fnJD3h7B1DFaciB5n5DPr/eDtL4ZrgmfEu43JFbeN1cDtMCG1s/cAagMYQH7l1t3
bXn9Mw8iWNbRuwA0BGBGNmRshZ4xPvkgDJxXDi4tyihBmKsJ2pPgUkI+WTY4db9l
bkrB2N9A7awazdE+nSnAta3vPHu4Jg==
=WTaq
-----END PGP SIGNATURE-----

--Sa25ZEhiL4m4bHt0vhf57KpCOz9Cp5sLh--
