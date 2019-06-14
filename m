Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1045F98
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfFNNxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 09:53:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:44645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfFNNxG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 09:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560520373;
        bh=4mBLyhnIGd7AU2+GEbyx/oyLXcvhu9SJn94shPDgtNc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ipLvIYFMsRs5X9OAWIoFZAceqiwCfhcD7ag/xkJxg4OJbDVP9COHe3BQxdiwSiR1r
         LA9thv9DmcqMb2AaEDu3W1cjXGqJIs0YbTmX+yjA34KcGAtOnmLhQ6pt8XGcyseg8O
         dUp3LSXZaogjtGnxRu0Pv8LiIHglgySWugFnAf/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1htzk23fFO-00JFmT; Fri, 14
 Jun 2019 15:52:53 +0200
Subject: Re: [PATCH] btrfs: fix out of bounds array access while reading
 extent buffer
To:     Young Xiao <92siuyang@gmail.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1560513109-2568-1-git-send-email-92siuyang@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <55b4adb7-59dc-5465-a99a-8ff0a9d7c450@gmx.com>
Date:   Fri, 14 Jun 2019 21:52:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1560513109-2568-1-git-send-email-92siuyang@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K5NURJGCPWYDOuqNZNznORPLgu2cJ3I7t"
X-Provags-ID: V03:K1:oJ6dvCo7bNWDVwWzwKi5xtQLkf+7xWY353Tb0VCQpkqU2gAmeSR
 yme1rg2KDSKzh5fYMakfNasi1KlPgENk17qpdgVgE6thXn0vyy2giW1jzbeY9GtnUYTc42N
 EykXeQZCqSuSOKvoqniT3ynWtyU+cvKrjUjFOB43J652PzQDdz4vAM/KqmbBF3Q4D/2OXet
 LbbNfq1BRx7EzK27HAyKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Y1CF1LO6fY=:20BngY6REnxq98ty1RtJ7R
 vb5XQHxSIsYnc5d4rlkD1R+fKm42zpRNQ6VGNZkW7ouocX+YECxwVs4wJo+q68mp0Mp2J3wuy
 od7Y5Te6+yWIL+SZ2DSp0yhd3G5oHyWOHLD7t3vFQ4jgyCRZkW2eMZb02TjddPyQ+WMlto9+w
 aFxtLGKkcrbpI+JtQq+BxZx/iWo4FIN54Ay/rCLqUM5j8lxlXTbdiE2UekJgRKvHPb70UoBFm
 eSvu71qfCp0QMktd0nb8Q3shvpEo1+F76eoH8eZwO2Viq0BvdsjKiFvjOF4qHj1SL+d2UzlAM
 AHSIGZhYfdANQw2SQw3DONaL6bhCwU7m2mPgj5mh5O9zV44zZa4I35DMhg2CpdvmMM44eUC83
 uAv8aoaykDrQJeuYff2F6jRodvRh5sZ6dldbj7eBDYbQL+F3TeKYomBilp2Iw7OS9NIMXYHNF
 bWovrpilDdNJ6mxnPB5AtcAC18Hc1nv9sTlgXG9B64sUUOePN6Dwo/Y6m+Lwuv336Q45udGhu
 d5jUx75c0CaT9MH4lNAwQQIC75Rue8F+e0AcPxHbMmpngGKBqAl+pYUmXTj6ug9Q+lim7RWBz
 tDq6H1vcjoVTznlcBc44zpBZ+YysYe7ClzXvX21KGCfi9ml+XCMtLkbmi80VTQ9a5g6u3JVU9
 ZKBX1+2NHGdboqRL6JmyGQnE0Pvg1NQa4Mj7dsZf1fDnUtDa1Kh1X6FUQGOcgexduTRkrF/YV
 VFl8MXTnkwAaGeJyvJT4SrBQljv4zvPn07MLjVy4MAWoYqJm6DRtW+B/CqCqZ4ECQpcdPPLOB
 SY4US8yQi58BESdC/rdy/urNhP0uFw5pt1ppgULVUie1yvtT0QrI23c3FAW5c4QWbALrSLNEY
 /F/oZWTK8YEWFb23ETplmpqbD5H9N2AsE27FJeiwDzDbVSL9Duwigsci4lt0JQKsyImuatvqO
 55VjWEpZXoKuy2MDZrNAnWkQKl5XWVv8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K5NURJGCPWYDOuqNZNznORPLgu2cJ3I7t
Content-Type: multipart/mixed; boundary="VDFZrkSaPxMYsYwGc31EJUL2AAyjMBpEG";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Young Xiao <92siuyang@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <55b4adb7-59dc-5465-a99a-8ff0a9d7c450@gmx.com>
Subject: Re: [PATCH] btrfs: fix out of bounds array access while reading
 extent buffer
References: <1560513109-2568-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1560513109-2568-1-git-send-email-92siuyang@gmail.com>

--VDFZrkSaPxMYsYwGc31EJUL2AAyjMBpEG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/14 =E4=B8=8B=E5=8D=887:51, Young Xiao wrote:
> There is a corner case that slips through the checkers in functions
> reading extent buffer, ie.
>=20
> if (start < eb->len) and (start + len > eb->len), then:
> the checkers in read_extent_buffer_to_user(), and memcmp_extent_buffer(=
)
> WARN_ON(start > eb->len) and WARN_ON(start + len > eb->start + eb->len)=
,
> both are OK in this corner case, but it'd actually try to access the eb=
->pages
> out of bounds because of (start + len > eb->len).
>=20
> This is adding proper checks in order to avoid invalid memory access,
> ie. 'general protection fault', before it's too late.
>=20
> See commit f716abd55d1e ("Btrfs: fix out of bounds array access while
> reading extent buffer") for details.
>=20
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  fs/btrfs/extent_io.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index db337e5..dcf3b2e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5476,8 +5476,12 @@ int read_extent_buffer_to_user(const struct exte=
nt_buffer *eb,
>  	unsigned long i =3D (start_offset + start) >> PAGE_SHIFT;
>  	int ret =3D 0;
> =20
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	if (start + len > eb->len) {
The original (start + len > eb->start + eb->len) check is so wrong from
the very beginning. eb->start makes no sense in the context.
So your patch makes sense.

But it's not 100% fixed.

If @start and @len overflow u64, e.g @start =3D 1 << 63 + 8k, @len =3D 1<=
<
63 + 8K. it can still skip the check.

So, we still need to check @start against eb->len, then @start + @len
against eb->len.

Also, shouldn't we include the equal case for @start? (although start +
len =3D=3D eb->len should be OK)

> +		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %l=
u %lu\n",
> +		     eb->start, eb->len, start, len);
> +		memset(dst, 0, len);

I'd prefer not to do the memset, as @start and @len is already wrong, I
doubt the @dst could be completely some wild pointer, and set them could
easily screw up the whole kernel.

Thanks,
Qu

> +		return;
> +	}
> =20
>  	offset =3D offset_in_page(start_offset + start);
> =20
> @@ -5554,8 +5558,12 @@ int memcmp_extent_buffer(const struct extent_buf=
fer *eb, const void *ptrv,
>  	unsigned long i =3D (start_offset + start) >> PAGE_SHIFT;
>  	int ret =3D 0;
> =20
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	if (start + len > eb->len) {
> +		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %l=
u %lu\n",
> +		     eb->start, eb->len, start, len);
> +		memset(ptr, 0, len);
> +		return;
> +	}
> =20
>  	offset =3D offset_in_page(start_offset + start);
> =20
>=20


--VDFZrkSaPxMYsYwGc31EJUL2AAyjMBpEG--

--K5NURJGCPWYDOuqNZNznORPLgu2cJ3I7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0Dpq8ACgkQwj2R86El
/qiyngf9F7bfqhx1MaCTeY5/higGPaFnrNTWv5w2MHEuPoj9wJbLVFF5084cmGvl
TpDhowllrbe6/L8bn9cW1GfiFMcCJiHXeLAeIZJLoF2mahqvB00NjRenGpHb2jry
gAcbg9rrRDfb4yLF1eEsW6PUgxolE4it1jD23kpsqunQt2JSaPl6QMjM5xGdbL6P
lV2iXsPbgR0RdCopJP/A5v7CcMDxIoyko2tKqp1k6xx4IV04A1nXsfwwPDUgp/WS
uEcuuH2bn6q41LJ7qhLwTJqOIhLajl0nXkxEfPzopKnCUORdJOO9ynqqpHvUTh1e
/wL981rfvP2owCC9O64jmGk8zTa3qg==
=WiCv
-----END PGP SIGNATURE-----

--K5NURJGCPWYDOuqNZNznORPLgu2cJ3I7t--
