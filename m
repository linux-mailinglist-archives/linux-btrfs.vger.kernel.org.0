Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB562CCC67
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgLCCV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:21:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:45379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLCCV5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606962020;
        bh=a+EUdLengNTux9pHYTDtGkFulv/IS6XpfK0gIN3PrrI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ChajK+766SMFald7BrPy3XYw36M/SM5kDj3c5kQjbmx0UdqgSTke2FFXA7QPY2FeE
         4DyXhvIGijILkOVcII5DPu7a352teadS0iic79RYSeGnbPul4BkyySsuE285Q7EYbJ
         azJ0xKENHDLYAm3QfJVOBSDb/pvoYL1i0t0dj3HI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1kxLH31ly2-00HB2m; Thu, 03
 Dec 2020 03:20:20 +0100
Subject: Re: [PATCH v3 12/54] btrfs: return an error from
 btrfs_record_root_in_trans
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <a11d1c323a74b1c452da3e4544019754b95bfaf4.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <ce693d23-6bfc-d8a1-e6c1-090284d9168f@gmx.com>
Date:   Thu, 3 Dec 2020 10:20:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a11d1c323a74b1c452da3e4544019754b95bfaf4.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lDXSY0YsBLRvnXhxJXZ5C2iTwF98D2pQ7"
X-Provags-ID: V03:K1:TxUQM+sBfcYNwedjWfFwYWu8VW7ZZXqTQMCAhHOk1ZlJzfXPtNI
 tygw+MJYMdrfzNhJ+kQElGrfAosWVqd2WseYnQZSZyBGTDV0jqEOT8pApRQjKYAQD7Y49Lj
 B4bgznaoWHU3hpQxfZy+92nGdWoLlL/K3Khkln2pXAdkQvQbvM58bBivHZq0M7To1apNza1
 xtWX2UtycmX5pDGM0MvxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X2r7CEpPGYE=:ekLByOtxHnnIPl/E6YKFK2
 mQcbs2BNw1htvOvWk4UVAuzBos/SbJ+KysZOtyF/YIrSpnLm4Fk+Xe73Ue+fN1QHRntlT5RQa
 fzfgMRHlOLCpeceAWSW2hCOWh/N3Gas7xviWrxSWecAhHQfT9leXrtGsF7vtCHsEAzVCJHgIv
 Ue/g608fKDJeqgKPm7Rcgx7wQtFTyXKxIqvqzjY6tdG59pFyuE142iiARkrXtH3sLffsxls1N
 98ZSh5t7Zhc+7IWdMM25/czZVzDmsK+Hed787osJ6MXcleeMzgivNP1e0Wf5dorcCkmUL1guF
 sVtUtH83pS9MQgWT0LXqec+6UAur7CdGxyodk3wfRACTVV05owCcA/U++6XVyRDutkXlEBtcl
 gog7qGxfnCE/Qw+PLjTxIRiSIONdBot+fs90BA17/b7Y+kE1zkrl45l/Ai/pEKVL+Uui2N1Ry
 eqcEbTVfvxo1w3nVMePgE/J3RZcazyh/AuGv7iXjeFLjrk7vaKd8bY/IuA9timEKLyfSc2KEV
 HVTnAqBomwO3ppVZZhmJu9QXKGvsJNmqPu43TO8e/8CIxMOxQHuCrPZeil62ejz1Sr0ZwMYUj
 Wb5zUFf05hC3yhGpNW0+6Zsd4MzUvXhOUTlrcCY308EfcKItU1t5cJIW2oSOWyg8MEx9SlHDX
 0GUbR3wTbAq5zQXsft1YthuvnculZoFhMms3boB6APW7hVH812YOPES7iMEqtncyWpgjO6OBA
 uJzUsM2kMZElYkFQayiBlh3mS9fvC36ZdDIMm9panv8u94TnSDO4ccbU++DHXyDkbbDay0YLW
 OKJeSqsLZJLk3MROyk1EGEIoUUFhJOScvZ8YKP/e0cUI1yCd32jjnmyAeR2+IzjSikrNA1vje
 36giVcwTfhsgk7ZJ5yPw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lDXSY0YsBLRvnXhxJXZ5C2iTwF98D2pQ7
Content-Type: multipart/mixed; boundary="Y8W4yteOaiFQSZntqTElzmI4lWztCCppj"

--Y8W4yteOaiFQSZntqTElzmI4lWztCCppj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We can create a reloc root when we record the root in the trans, which
> can fail for all sorts of different reasons.  Propagate this error up
> the chain of callers.  Future patches will fix the callers of
> btrfs_record_root_in_trans() to handle the error.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But an unrelated thing inlined below.
> ---
>  fs/btrfs/transaction.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index a614f7699ce4..28e7a7464b60 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -400,6 +400,7 @@ static int record_root_in_trans(struct btrfs_trans_=
handle *trans,
>  			       int force)
>  {
>  	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	int ret =3D 0;
> =20
>  	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
>  	    root->last_trans < trans->transid) || force) {
> @@ -448,11 +449,11 @@ static int record_root_in_trans(struct btrfs_tran=
s_handle *trans,
>  		 * lock.  smp_wmb() makes sure that all the writes above are
>  		 * done before we pop in the zero below
>  		 */

The large block of comment is not really for btrfs_init_reloc_root(),
but more for ROOT_IN_TRANS_SETUP and root->last_trans.

This is a little confusing, and may be it's a good idea to move them a
little in another patch.

Thanks,
Qu

> -		btrfs_init_reloc_root(trans, root);
> +		ret =3D btrfs_init_reloc_root(trans, root);
>  		smp_mb__before_atomic();
>  		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
>  	}
> -	return 0;
> +	return ret;
>  }
> =20
> =20
>=20


--Y8W4yteOaiFQSZntqTElzmI4lWztCCppj--

--lDXSY0YsBLRvnXhxJXZ5C2iTwF98D2pQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IS2AACgkQwj2R86El
/qifIwf9Hl9V6iTLSuACjegUc8JceS5TZj51BMhzuaSwdB4uZSksv1VBKi/ykY0i
e5z7HvR/LTSAeBiA7Xr+HgNjnw5crwtEORvwoKEUUvDN+IsasK2haALOkccht/Kz
ToRE6xFsYi11OVPCsEiauHSbZ7MvVfFVtNZ+l1TT0kBR5Cqa+pG96q1ZAqXpVmH8
uDh82nedlKmpxC7wG7/liZtw03NT0kE4cEccXrInW+Qg1CHNxFJ4qQbRwfzeuMWM
kujsGWRnR3q4M1bmYnA3D6HhTns1qAx3D1dMe1IifShv54tIGDchtPHiW803ZR+C
JgkT48Bhqd+/8BWTGG+LTKYzF8+owA==
=SwsU
-----END PGP SIGNATURE-----

--lDXSY0YsBLRvnXhxJXZ5C2iTwF98D2pQ7--
