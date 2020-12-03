Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6B2CCE14
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 05:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLCEvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 23:51:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:59325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLCEva (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 23:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606970965;
        bh=vtY3Qi8NpGKMNFi0hzBZF35FXjvnB7XQst/wBtXkN3k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hOY33hRyU8JkPQaA4wjNNv3WjxV11tKIxBW2jcIZX30pXUYQVSs7FtVEiv/mMZcPv
         M9MBqXQ/Pa2I5yjSxdIHms6ezfP6P74t95FnQO9AI0doGsgbsI9AcTS5vhZ9GJPDud
         CzhmgRYGp/QA5VbZf57arMVBwHfQcwxzs+asHPIs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1js1da3c1B-00tPSM; Thu, 03
 Dec 2020 05:49:25 +0100
Subject: Re: [PATCH v3 30/54] btrfs: validate ->reloc_root after recording
 root in trans
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <60d12b7256e6877061eaa9df99ce2ed1f0f3d012.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <81983f16-ce45-dfbd-4b91-ac6970209fc6@gmx.com>
Date:   Thu, 3 Dec 2020 12:49:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <60d12b7256e6877061eaa9df99ce2ed1f0f3d012.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oFuIeoPQhMAFRLNHblivhMTJEosNjHZGG"
X-Provags-ID: V03:K1:30aa/x4zpERzLfkwiBT1JFv7SSbFjWsL8yEOaKM1oCrzBsceG9L
 kafqHOYAMqEeVDXXVZy7LmM6Q1RQzPLb+Q/CctbGeJxGtD8Zq1jtk8Zsgx1i1F1zJM6loL9
 6tiKPUIYWu9byFTPgMWEBt0ljl+EznrwK1R9cJhglqbPMRBWLMu2xmQzVy56E2WaB4Dsqto
 /+Im4Set0A8qpY2TKHRhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ovotnegNQvE=:M1qRp2WOSZO9UzUBncgi4C
 fnYKe3vyQMM3l4dfvJEfbsiq+lDqyYwAOnSe8MKmMX9ggn7ZlqbPJ5lQYW7r4yMTrx6sgvFQg
 F1uzlg3+obPwI3WTCm7kELJis5HX9vbSItnAliHx5OoPPwPu4s3+yJuX32s2utnbN2MNhndIM
 GpwEj9WYnwPIewQYlpTte47vqcvHSH5sXXPaftH6KaK4xI7dhbZJ8SF68TbrGefmIeOOBa/RV
 hzd2dXFgKyehogCLuvWLxNdIUXOrLUd9PTBSXQdHhnZUqp6iVdZQBX6T/qyfLJAxfBbUpBFu2
 /vcyXofoQBEWzl+9znR0mPKoycGU4u7XETnvURuPlgzcHoLl5xoolDyKKSAp44I5wip1I5X1P
 m/MXqFqYQdHA3rZFdWDm5Au+hvAkb0uwMGfL/w/GySwZ1xv/mZyVzcjOq6RbQ0X8ikIBWkO/F
 CTEaleQZVc8aDDZzR/pycEwlX+/tkUgvT6Qhg/Fu/3WMeUp3BK0NN918lh7mjKtlfVpblqogz
 EF2Ak+gNgs+HaU2pbie6IjJPdI+tTVk5ez14ERG8AitQze2mRgciai3rtSido4FXFdn/QyDpk
 +WUA3UPUZOy3jAsr/a/l9o5Qd17BysrDmL3klmM8xoMwp1rCsr1fsm+qSbdJ4m9LjbBNyJdo1
 IfJoNl8rU8U/Qe34yGqJq2O/PPJ735ClpecKCVrL7sI01n8b6Os6tAXWMPYvqnWK1U6PL5dqU
 QMFx643AY28swKNYzQL94XOkMXQr/xMRS5JGts9eLHzLwxUbIp6UCzxhqos5M3UHa0vuXIRlh
 lAw4HtORJV1Q6OWyBCf7v2s06/JjBKRGrVkf1r1DrMl52QDokHcLsebfusYgCzfO6IDC7KpHS
 9WG3RnPbv+PopxDcw3RA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oFuIeoPQhMAFRLNHblivhMTJEosNjHZGG
Content-Type: multipart/mixed; boundary="PBj9hK8aw1EcnkP1jymTI8ZX0P6g5CROx"

--PBj9hK8aw1EcnkP1jymTI8ZX0P6g5CROx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> If we fail to setup a ->reloc_root in a different thread that path will=

> error out, however it still leaves root->reloc_root NULL but would stil=
l
> appear set up in the transaction.  Subsequent calls to
> btrfs_record_root_in_transaction would succeed without attempting to
> create the reloc root, as the transid has already been update.  Handle
> this case by making sure we have a root->reloc_root set after a
> btrfs_record_root_in_transaction call so we don't end up deref'ing a
> NULL pointer.
>=20
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The fix here is mostly based on the fact that pointer assignment is atomi=
c.

But I'm wondering if we can do it better by using something like
spinlock to make it more explicit.
Or is such root->reloc_lock too overkilled?

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index cebf8e9d7d96..c9df05f02649 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2078,6 +2078,13 @@ struct btrfs_root *select_reloc_root(struct btrf=
s_trans_handle *trans,
>  			return ERR_PTR(ret);
>  		root =3D root->reloc_root;
> =20
> +		/*
> +		 * We could have raced with another thread which failed, so
> +		 * ->reloc_root may not be set, return -ENOENT in this case.
> +		 */
> +		if (!root)
> +			return ERR_PTR(-ENOENT);
> +
>  		if (next->new_bytenr !=3D root->node->start) {
>  			/*
>  			 * We just created the reloc root, so we shouldn't have
> @@ -2579,6 +2586,14 @@ static int relocate_tree_block(struct btrfs_tran=
s_handle *trans,
>  			ret =3D btrfs_record_root_in_trans(trans, root);
>  			if (ret)
>  				goto out;
> +			/*
> +			 * Another thread could have failed, need to check if we
> +			 * have ->reloc_root actually set.
> +			 */
> +			if (!root->reloc_root) {
> +				ret =3D -ENOENT;
> +				goto out;
> +			}
>  			root =3D root->reloc_root;
>  			node->new_bytenr =3D root->node->start;
>  			btrfs_put_root(node->root);
>=20


--PBj9hK8aw1EcnkP1jymTI8ZX0P6g5CROx--

--oFuIeoPQhMAFRLNHblivhMTJEosNjHZGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Ibk8ACgkQwj2R86El
/qjwlwf/U9UjYet/EswetNxfMgNxwIM8RDXpOCCrhcKeZ3w2pFrd2csKjMmnYceD
EqsgzWFfNYRYub7uypCE5/b5WfOc7qXpTmbfWdsCXWtLrF/I61iZ141ByUg9cgO4
PYukNlUkXj6Wvyq9kh8W1upcMN88mFellx3b/NxdkrzeKi4zt3IDYnK+eq2mxaI2
4/R32M/Lvoim5ArGJVtm5/GbbwOlwcB3UJTaE8l1UQ9kK1fpzEwrMb8lOneZ35El
8kSc81WgfgX8rmTZSCwMIwnu1G+yR9fCFqPOgmjmpJuJdRggO7qEJvPigai37cUA
TWIEwaomFUEm4pPfQu4oMfu+85zRcg==
=g9FJ
-----END PGP SIGNATURE-----

--oFuIeoPQhMAFRLNHblivhMTJEosNjHZGG--
