Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7025B1097E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 03:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfKZCsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 21:48:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:50607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKZCsW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 21:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574736225;
        bh=zIb+0xzEv6fcBOmNeU/MXGrFLzK0wMowgix+ybsqEMk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MZdpp5kEUtu5SqYn74WpEjOLIczFKm099++OCAbAmm8u69wRvKh3RA9RN2I2OXNE+
         Kd21QyH0nmW+yClJyY4lkBGobhxLNTy4cCNxH0Sd3MCGDGiucmGs8LOmYz7wDx8ukz
         G+I6eYzw0OSixjvUs8QpgCBqF3gYoQJaYbqVjmoo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLzBj-1iIAvR3O89-00HtKn; Tue, 26
 Nov 2019 03:43:45 +0100
Subject: Re: [PATCH 3/4] btrfs: fix force usage in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-4-josef@toxicpanda.com>
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
Message-ID: <64dec4e1-a602-454c-e9d5-af8f39aaf97a@gmx.com>
Date:   Tue, 26 Nov 2019 10:43:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125144011.146722-4-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wm8xqUBqU6DbwMQmIxj248VlQgTb1UxBB"
X-Provags-ID: V03:K1:cq3GxrOt7To2SDrjd8FagG5P92vWeV0geR06cIIavgax4jjq8Iz
 Mce0bQCIbDKCAsmlXWFG3UVtSqdbl/fCzYO7QubpbloeubVVGcQVGkSoR43MftKJj9U5F6N
 DRcPZQD+AQBmqXpKBHxFreMOCbbuFbiOhuGeLNgyqz02nOURuHxKMaA8c598RE6dUm6DvsY
 wRzIlLqzoUijSrsMtj9OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xWf/vcQxCk=:2TTjW3dTq19i1M9SPzw9hi
 ExFfGtBLRgK438RnuBO2ZWUG3kGWbbwd+LBxiFoLFTY7WnyhBe0qIG5ZifsJIIu857rpTPWES
 IEzaV206zcD4KERf6y+dqe+VvJLisWYeuhwjYebGqk2JVt5T+FP9+5mXVtRT1Qc2nIsbzZL8s
 D2PiB9CT7dLNxr5zWnNM0KYIkudLgSTh9azyOGPNB8M9E1E8KQtmiBHsE0BcGg+4BiDzB4LnD
 CFE1dPScuR1EoXdzz7v8kpFP8sehePMP8s2QgTODxsKPcaJYA/vcBCOx9Uuw6tWdRG94GpUGP
 2JWekTFlHhkICNeSxxxRgYme6UV15vt4a6LFS4OOEIS6P3W4vH4tyJArmgwMooxuDFtJD0OwL
 EVHOjfUrERyWm3rMR7D8QvpC9baIWscwpmSqeELH38iE2mOYhCnr7WKcIqbzvde6FDjCuVD5w
 WPsDLtBjs+qkHK/SiC7ngOcxNeJEMbMNy51gymIGX29Bu5RB4Zp2+UpM5Z14qpSuIPbZgAe79
 cgXe64rf8VP3rzCQNf5j6dyCSeCSHexIo6TIyTWwy4AL77/n648eyHJjaXb7hcyZEy6E3nS/f
 q7ICHoa+XyTgH8HKoW+dQ0c7cVLwm48C8GE9Z8pHaWZex6k8Plcx2hCqcbJiXjfrGyTa5b+pL
 +OMSdXZ0oa/Ig5V7pgc1ALpTptnLttAYE53PWfMWzrJC1xXb6/jTe5VXH9z3Bv2F4lwOcXpyP
 9oDREB/31eAbsIRcKblDYURbdjrozLjC275BsBEG2ce9cFVgwJQ33MhHFZRqTRMELqpwudpWd
 Q46/doeBvrDLBEf6gZkXJ7tU8pSr1U54t4nsfvooExZMc9eYL68TzdNblSWOheXs96jpVTyNj
 PDLhlRVY+qxt5wuX6+K7W2M7gzGGhJLZIFddd3WgIeVyPf8lIj0kEHSRYrFyssjMbVg3wvOAz
 oJPtfvyyoNaN/BmMzq0l9mXqE/Eh1qEvJawVCN/zxnvtKWjX7bCD+FqqINwpnqoIRmJj0BolW
 Gh5g6NMh90gNRqgZbITpLJJge9GPUFbRTC8+Z3ZfL72eSTPLqdTTrfNkex3cqAcpfwCyv37C0
 2KL7WoopBWWmgl00Y5f48tCz+TjnmnYhu01nbM48CPqwJb4/N5FXz2AzxqBTc++HR4ExXHZsz
 NusxQef2RkH/74VbtoAlqC37CWbw78nk+n0izEzBUUNgpVPaPHIgITzjqH6jg1j556RsDL1Nl
 YwVwHi4LD6YGSjdBQ9aoj3pht8KClxugd8oVqjznrWIlO2IjR18Po6VubgHw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wm8xqUBqU6DbwMQmIxj248VlQgTb1UxBB
Content-Type: multipart/mixed; boundary="UDqJbk4VcMZ3nGFKOqo7FD0vAP0w0d5Jh"

--UDqJbk4VcMZ3nGFKOqo7FD0vAP0w0d5Jh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/25 =E4=B8=8B=E5=8D=8810:40, Josef Bacik wrote:
> For some reason we've translated the do_chunk_alloc that goes into
> btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are
> two different things.
>=20
> force for inc_block_group_ro is used when we are forcing the block grou=
p
> read only no matter what, for example when the underlying chunk is
> marked read only.  We need to not do the space check here as this block=

> group needs to be read only.
>=20
> btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates tha=
t
> we need to pre-allocate a chunk before marking the block group read
> only.  This has nothing to do with forcing, and in fact we _always_ wan=
t
> to do the space check in this case, so unconditionally pass false for
> force in this case.

I think the patch order makes thing a little hard to grasp here.
Without the last patch, the idea itself is not correct.

The reason to force ro is because we want to avoid empty chunk to be
allocated, especially for scrub case.


If you put the last patch before this one, it's more clear, as then we
can accept over-commit, we won't return false ENOSPC and no empty chunk
created.

BTW, with the last patch applied, we can remove that @force parameter
for inc_block_group_ro().

Thanks,
Qu
>=20
> Then fixup inc_block_group_ro to honor force as it's expected and
> documented to do.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index db539bfc5a52..3ffbc2e0af21 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1190,8 +1190,10 @@ static int inc_block_group_ro(struct btrfs_block=
_group *cache, int force)
>  	spin_lock(&sinfo->lock);
>  	spin_lock(&cache->lock);
> =20
> -	if (cache->ro) {
> +	if (cache->ro || force) {
>  		cache->ro++;
> +		if (list_empty(&cache->ro_list))
> +			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
>  		ret =3D 0;
>  		goto out;
>  	}
> @@ -2063,7 +2065,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_g=
roup *cache,
>  		}
>  	}
> =20
> -	ret =3D inc_block_group_ro(cache, !do_chunk_alloc);
> +	ret =3D inc_block_group_ro(cache, false);
>  	if (!do_chunk_alloc)
>  		goto unlock_out;
>  	if (!ret)
>=20


--UDqJbk4VcMZ3nGFKOqo7FD0vAP0w0d5Jh--

--Wm8xqUBqU6DbwMQmIxj248VlQgTb1UxBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3ckVsACgkQwj2R86El
/qg3bAf/SQAx4C/azI36oGlw7n4C+YXXAJl8RtU7WFNwUZq5c/1zi4tmnwHb7STG
L3yDu0ZlYAC+4UFDoY2v65C57ULZDKJ5FwjsWI8tTLNwhlFySYAiHLZcXrbrdMej
/k/rVE8MGAkDx0X/33ghWp/+4fheqlibg3tGfymIuBiL0B5dvjw1XKpBumFEilpP
3k2hUiUb2v31FnjkFflM6aouiugVE+oA19cUKRQq0CFYSR4fF0BBNbW7xYllZyri
hiOxMz8F4igP8+JwF5sXx4MqaEPoWzGsKZl3khiARtvcSFjYHt3OS2xfFyZ/cEJ3
5DXNGD7ki8MvcxJd6/aWm1kyQMPwtQ==
=AYdx
-----END PGP SIGNATURE-----

--Wm8xqUBqU6DbwMQmIxj248VlQgTb1UxBB--
