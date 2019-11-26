Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E381097E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 03:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKZCkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 21:40:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:48979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfKZCkR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 21:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574735736;
        bh=QUp7/wnFFDPMZr7SBNSmahCyBmeM65OLdAWJdRp5f4k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aoXKJqXiDZD/yzBq21yJp1ZsI3D6sWfV1bGlgCimWDDv0vtYj19JK78xoWNFqe2gC
         UiGTa6qj14B4Bwz8GwDTZu65wDPK37NPYbeDo2F/gfDqVpWWxZ9ViJI+eOKqCKPE4u
         qxzbVHubuaYIZFBXBMdRu39y84FhvI1QJNeyW8Mg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1hdcqP42OU-00x5W8; Tue, 26
 Nov 2019 03:35:36 +0100
Subject: Re: [PATCH 2/4] btrfs: kill min_allocable_bytes in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-3-josef@toxicpanda.com>
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
Message-ID: <2d3f9e7b-c432-0eb5-e496-ecc66fda831d@gmx.com>
Date:   Tue, 26 Nov 2019 10:35:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125144011.146722-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0cSTZ1mqT6ACGmbuETsLIRsxi8pXFbWt5"
X-Provags-ID: V03:K1:APz9rkZdOaVpwrVRhVCzsnygSvrNmgqLmgeVzpY85qhO3rQyTP5
 E9AxUsbJC+ywERi6BU9eA/Vv7j7CUt7PtKWUcrwW/6OpqdbJWuac+Dqj1GmyMKd/xMYo1mw
 mamk7QGlgMZI0tbnanZWxCeX3z20lM72EHGjH26LXhfkGnqCkPmc/HoWheV4B1jL4wHKqRo
 5nNQG45ZSLivHqVKHRIhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JJ1t9kwjaXI=:0R3PRLnpxG9JpDOc75pOd2
 K2FONhCm1H0sa/gBbh00urp+wkFH0ukqLoQLYxoWDCA4mLUrm+v02UGfBHpE6X6Lv1cNkQHgn
 rEzY+7WBH967l+ag4LoPER7Vw9J/bOmO5TTD8eSA6Spn68IY/KGnfhRZO+edcxk70htKFl2lB
 TmsxokbjwmoRV6CzVrWjxpa9XV+WFYoGZU+GmE4lIlkva219M1HR5E5u1gzjH2FjPgHWE5Dsf
 AR5zjXavIPwVwWP3QeKRqCf0U8QxObrKB8dhBPqDupwDPXwslKiBA0PaVRiDeHem80hWc5sM2
 Jv1kxMcztERBC9ThN6B52a1CaCEGxW4yJqr1L2vo+zY0q2QnJU3TESJDNntE8COpO6kZVjmlw
 +DXiSUzS4FlIn8MXyy1YsLddhJcy2PP1/CVP8U4Xk6BQQzxYhalpg//T7ZG8+Eybu24I04bXp
 BOpZVvpBN9aoFzrREXKUn5UHasIvAmABRf14OV+zDsPGjx1GefPJbtMnDJ0G+ZDJ2NbdmutAT
 MtCSJB/tJnIl5XT9huebqx9A0ZN1Q2TT7IXCU9d81IsdLkICSOxSEqfuap+nfHapXqGPgQwxm
 ddp3+wqwqrg/mrDA33ZLv0Qf0Fsz+MfrX4tUmgeZ7Wkbd83qNOPTJZmzQWkAP+4QEgGWD6o3H
 SwZRjavPIpMW7OFiV5XX/p2Rb2h7pApkFwM0HIo62+b6NmBpEfCWb5/pDKzCv04tPm9aNaQH9
 bSExQZJb5I6w+FDFyy4hcjPXRh7IYbzVKtf6mMAuoN0P7fnUk3beql7m42qPFHYNjDcCG0x12
 3b/LtCpA0JGAzuFSRiMzt1E9kZOVWsJtBJCRhUyVb6IDmkC4DSbA1WJ07zsQ4qcPxtKQeT0Si
 mYgI+pAS2h0MVfmi9rj5kqfQAg7c2c4OpT6qpKD1bpRyG7ndCVMhSgbM/IqNChkTENafoJoUK
 lkt+Mzg01iiesUR2kuyP6S3olsluHxAPrh6ITvQIqYArwShoTpS57NXFUqfA/qJ0cs5eFD1Dx
 3Vb5h//Ia8AySCAv82bT5MR1oYcS+v84qi14hkv/tdK0kHqr/RD6Qjo1pKlLYOjtoVn6R+3OM
 VuTGlKcbhs1PH0TjZtnoE6cd0QbRBIQaxD/CwRsyBD1rzgfLMjePl9rcvQPho7L7ePPoZEFbv
 W3XYmH6A1uFdd9G/ra/c1Aaosj3Mtho6jg9/oI5JDsP0p6NDNI4XKhrcrkKMA7qu+zmucX1C4
 dn/OCSI/tJ2UiXhPrpDCPOQ/cDNFIQ+rGLKwieuQ9mO/bTvavuUZBH1FfFsY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0cSTZ1mqT6ACGmbuETsLIRsxi8pXFbWt5
Content-Type: multipart/mixed; boundary="ycd40WKJKvAv2etKTfNXBjBcMj0ZyljCw"

--ycd40WKJKvAv2etKTfNXBjBcMj0ZyljCw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/25 =E4=B8=8B=E5=8D=8810:40, Josef Bacik wrote:
> This is a relic from a time before we had a proper reservation mechanis=
m
> and you could end up with really full chunks at chunk allocation time.
> This doesn't make sense anymore, so just kill it.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6934a5b8708f..db539bfc5a52 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1185,21 +1185,8 @@ static int inc_block_group_ro(struct btrfs_block=
_group *cache, int force)
>  	struct btrfs_space_info *sinfo =3D cache->space_info;
>  	u64 num_bytes;
>  	u64 sinfo_used;
> -	u64 min_allocable_bytes;
>  	int ret =3D -ENOSPC;
> =20
> -	/*
> -	 * We need some metadata space and system metadata space for
> -	 * allocating chunks in some corner cases until we force to set
> -	 * it to be readonly.
> -	 */
> -	if ((sinfo->flags &
> -	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
> -	    !force)
> -		min_allocable_bytes =3D SZ_1M;
> -	else
> -		min_allocable_bytes =3D 0;
> -
>  	spin_lock(&sinfo->lock);
>  	spin_lock(&cache->lock);
> =20
> @@ -1217,10 +1204,9 @@ static int inc_block_group_ro(struct btrfs_block=
_group *cache, int force)
>  	 * sinfo_used + num_bytes should always <=3D sinfo->total_bytes.
>  	 *
>  	 * Here we make sure if we mark this bg RO, we still have enough
> -	 * free space as buffer (if min_allocable_bytes is not 0).
> +	 * free space as buffer.
>  	 */
> -	if (sinfo_used + num_bytes + min_allocable_bytes <=3D
> -	    sinfo->total_bytes) {
> +	if (sinfo_used + num_bytes + sinfo->total_bytes) {

I guess it's a typo.

It should be "if (sinfo_used + num_bytes <=3D sinfo->total_bytes) {"

Although the last patch will remove the check, it's still better to keep
each patch works fine to make bisect easier.

Thanks,
Qu

>  		sinfo->bytes_readonly +=3D num_bytes;
>  		cache->ro++;
>  		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
> @@ -1233,8 +1219,8 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
>  		btrfs_info(cache->fs_info,
>  			"unable to make block group %llu ro", cache->start);
>  		btrfs_info(cache->fs_info,
> -			"sinfo_used=3D%llu bg_num_bytes=3D%llu min_allocable=3D%llu",
> -			sinfo_used, num_bytes, min_allocable_bytes);
> +			"sinfo_used=3D%llu bg_num_bytes=3D%llu",
> +			sinfo_used, num_bytes);
>  		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
>  	}
>  	return ret;
>=20


--ycd40WKJKvAv2etKTfNXBjBcMj0ZyljCw--

--0cSTZ1mqT6ACGmbuETsLIRsxi8pXFbWt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3cj3MACgkQwj2R86El
/qi7cAf/bbhnMdkuqjszyRB92yT36AFDIOp9t8UIOHOTybCEAhL109KCNpA+vAU/
7pgA60UQYpvYy8HVBQBgGFVE2AXieEq0RHTpZ2ONha5wEloWnFt6HFCkOkKEvE4f
PVX1S4dnN89Dk41W+YhQsksuI2j1WDfxYMbcu6rzzEd8uJK4AN4A2J5hKF7n9XEJ
Q3SVL7i80wHneOR2z9Hb3RWuxw13K+sJ/A42s5Q/2fHsk1sA1WdcBxnJNQHE34PG
RHwTQIQKS0fpdHe6tvmXkWuRedS1vuh2Qhk4JKceZEEv7RxVRYG8gvs/FiqdvHnu
vqgPYKIHF5uU5yeA6SnTfdHb/pERBw==
=m4lO
-----END PGP SIGNATURE-----

--0cSTZ1mqT6ACGmbuETsLIRsxi8pXFbWt5--
