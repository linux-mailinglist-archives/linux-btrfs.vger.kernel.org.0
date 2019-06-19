Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56104AF86
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 03:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFSBhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 21:37:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfFSBhq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 21:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DECFBAE5E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 01:37:44 +0000 (UTC)
Subject: Re: [PATCH] btrfs: reorder struct btrfs_key for better alignment
To:     David Sterba <DSterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190618141514.17322-1-dsterba@suse.com>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
Date:   Wed, 19 Jun 2019 09:37:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618141514.17322-1-dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UpoUF278qvtweujrPbwlMEuJ5DqdXYBJc"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UpoUF278qvtweujrPbwlMEuJ5DqdXYBJc
Content-Type: multipart/mixed; boundary="ckeaVbkv8Lz0X7P9WVKuEbMrgLnbMmPap";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: David Sterba <DSterba@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
Subject: Re: [PATCH] btrfs: reorder struct btrfs_key for better alignment
References: <20190618141514.17322-1-dsterba@suse.com>
In-Reply-To: <20190618141514.17322-1-dsterba@suse.com>

--ckeaVbkv8Lz0X7P9WVKuEbMrgLnbMmPap
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/18 =E4=B8=8B=E5=8D=8810:15, David Sterba wrote:
> We don't use the plain key for any on-disk operations so there's no
> requirement for the member order. As the offset is a u64 that should be=

> on an 8byte aligned address, this can generate ineffective code on
> strict alignment architectures and can potentially hurt even on others
> (cross-cacheline access).
>=20
> The resulting asm code on x86_64 only differes in the offset, no signif=
icant
> change in size of the object size.
>=20
> The alignment of the structure is unchanged.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  include/uapi/linux/btrfs_tree.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs=
_tree.h
> index aff1356c2bb8..9ca7adcf3b7f 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -342,10 +342,17 @@ struct btrfs_disk_key {
>  	__le64 offset;
>  } __attribute__ ((__packed__));
> =20
> +/*
> + * NOTE: this structure does not match the on-disk format of key and m=
ust be
> + * converted with the right helpers. The btrfs_key is for in-memory us=
e and the
> + * members are reordered for better alignment. It's still packed as it=
's never
> + * used in arrays and the extra alignment would consume stack space in=

> + * functions.
> + */
>  struct btrfs_key {
>  	__u64 objectid;
> -	__u8 type;
>  	__u64 offset;
> +	__u8 type;
>  } __attribute__ ((__packed__));

And why not remove the packed attribute?

Thanks,
Qu
> =20
>  struct btrfs_dev_item {
>=20


--ckeaVbkv8Lz0X7P9WVKuEbMrgLnbMmPap--

--UpoUF278qvtweujrPbwlMEuJ5DqdXYBJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0JkeMACgkQwj2R86El
/qipBggAjHdmZ3Mg6dMJa8o9fdKvmIcP1xe6vKUkhflzBYx92LHIhN1f8R94f13Q
gHGYswG9yJtVf13HUcVb6X3QvUk9SeUdyFJp60wPfTmLeTqUSKGmkgjAQphgF7fb
71CcEPbhj/YGk8aOYjtMTjk59veneSjrXsj6pQPaIFQv7cwDWjH1GoQnOM6vRAz/
KO7N9H30Ot1d8vIfb9qZERmaAfu4PM4c0ZzI2P5gNvYxvpllTn2P2ARIVEoK4FtP
W6pQZKoUl7tlgCoWsTVRLs4HYPxF8fmy6JeXSYDpzslUVq6ACEhExOksO3hpDsOZ
BYIKKyAwA70Q6wHalBQzB+3jN6DH/A==
=Pasn
-----END PGP SIGNATURE-----

--UpoUF278qvtweujrPbwlMEuJ5DqdXYBJc--
