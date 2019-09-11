Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8EB060E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfIKXir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 19:38:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:44929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfIKXiq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568245099;
        bh=AdCH9BjX1bH9K1ChzM+LtFvABWT2t72uPkOLGfvi0+8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TUi3ywxygmVvnHQV/KTxFyXKnyIMBYPrIPtCEdz2UeI7T8rFYIcSxXXv3v1QOFbrC
         eubRfascN9ulBoByjQpasL9vGt3kM1tN1NHYGjfz1tBdF0rB69Ixr+Lpsq8474ij3B
         LO3MEOzZkLBItubxnjPMYT4q24DydgwKWMzQDVVs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsPy-1hzQkM27XM-008tsh; Thu, 12
 Sep 2019 01:38:19 +0200
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs child tree block verification
 system
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190911074624.27322-1-wqu@suse.com>
 <20190911160202.wtprsigurzfxwtic@MacBook-Pro-91.local>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <3993aeab-a695-3bd1-88d6-48e9743ab597@gmx.com>
Date:   Thu, 12 Sep 2019 07:38:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190911160202.wtprsigurzfxwtic@MacBook-Pro-91.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cZvbWbGDYYZOrFTpyZygrzcpBGU6AqypL"
X-Provags-ID: V03:K1:1OWGqgEgCK02YwJbugDVBRSz5nWZwQjLDA0ugACp432/Oo6T1sZ
 klCQz/60J//zxTRf21FoRw89Hfro3tSNbKWo2uOyq/kGKrY77h16hNC8HIZZixe0y8Mkefi
 vv3gYTjhmZnjGGQSpzOz5FiVMob/bBs+fSuT5elvn9zJjFo/4x0aextAxoQRV3kUPh+8zKM
 37QFCdvYDR1Db4fSGwuIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RFThwHhirGU=:PJSxQniOsosY+WS4ilTgYf
 eeR5UX2+ybPWqlvkmZv7SnSrP1jta+1ttxpxW+RD1uIDg+bCb59toAyYTN/XZbZ2LgiPdv6Il
 jWFi+o+E01TyVyd+uzJLE2x3AxVw3GPKOfL0peBocmoF4C7klKcr1TYCtIxcGNGzF+7Jsluf+
 /HdnmQEibUZpR5J5sdqqtD4KZEk+IY9GMfFxsom3QmWrqXfsY+h1XKoyYtxGL7aEQnbzU91SZ
 3t4rlaNH6L2uTv9/B5MfwQXB3NxGVSKAcXxyuDpwEcAlsXzVsGhPez6NgKXNqQSjvk3lagOwQ
 obDUWd/kr5Ld3efYUD8NcVLNozKzRMj5W4I4lXltMb4QbOyUcbiXHxbevwa5jwB9lmsoEwhQB
 Qew7ABUVU9nRD0xoO2tLbhfG9delv6m7bN6dtz+u+k4+lIX7mamXbKigXnNoWI+YAObLKhMjl
 F+mqRyNq+cspmuYjsajpEROWmED7htVdP+JqfzoE36oUH7G8pr67Bkz8bQROOPmibl6+wG/sn
 SH/+VdofA6GYUSoXqurFZw+EG/9hGJpVTNcvuhsYg3eakW1DXFvE/y/TNoNxW+g+d3oKzYeEd
 i3hEBFywfkKwOSfOaS3V8K42cRYSx+vgNYiwBrWxF8yaQ+117XQhelwi5ROSp8ELvt+pZXqQj
 n/k8a0Nx/8WpdUEzlcQ3mDhHfCOLqed23itPqbXk7mgoIQkOtPig3T/gKGMCccJVn938u08o0
 05XptHPyWj7k+UMx5cRcXguNm6R2jCmUTj6V7SCk+dVDvCHxH1E6lpMyv8Y2I1XlhBHi8adUc
 AH69fD+sBNUKN9lVjFYunaaUhmOXmBqmwfl+YKQjBOR3k2BiT9nSusMb2fJCGKlJJGL55k1fK
 Ui8ii8PdWpCtLFScmCOLujT4WRPWZcknjCmOoEcAPvaRQ70G+RqW7gPW2HnJ9niVKd5apaGCD
 D86oo40M/GWG2JrCHoyjC2cZTH8StApfcdlV0h0psH/VQewGf9MFIe+wxA/0It507LzoYcy4W
 +cnOs4xlqXHUupLXZ+RobZl88D8JAiGRm9hNkxdYuLSvzkVvv0+dfryaeJB0YOD243GyuUj7N
 Sq+RdevThXcmB2xY0+xi1clQIAzCkvFMb/remSV1YuoGHE193Zp/xbOmxH2diW0qG/X+cbz6I
 xmvM7B2LkDwhzeQScvzus9cHI9Och8u7VCcibboOV00qtoizh8v/gxhKQV8deChJBcsj3oPuL
 waEiGKTSwEL3albtQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZvbWbGDYYZOrFTpyZygrzcpBGU6AqypL
Content-Type: multipart/mixed; boundary="BxIxyUgV82eL6XO8cQyqpgDqm2q0qtmXU"

--BxIxyUgV82eL6XO8cQyqpgDqm2q0qtmXU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/12 =E4=B8=8A=E5=8D=8812:02, Josef Bacik wrote:
> On Wed, Sep 11, 2019 at 03:46:24PM +0800, Qu Wenruo wrote:
>> Although we have btrfs_verify_level_key() function to check the first
>> key and level at tree block read time, it has its limitation due to tr=
ee
>> lock context, it's not reliable handling new tree blocks.
>>
>=20
> How is it not reliable with new tree blocks?

Current btrfs_verify_level_key() skips first_key verification for any
tree blocks newer than last committed.

>=20
>> So btrfs_verify_level_key() is good as a pre-check, but it can't ensur=
e
>> new tree blocks are still sane at runtime.
>>
>=20
> I mean I guess this is good, but we have to keep the parent locked when=
 we're
> adding new blocks anyway, so I'm not entirely sure what this gains us?

For cases like tree search on current node, where all tree blocks can be
newly CoWed tree blocks.

If bit flip happens affecting those new tree blocks, we can detect them
at runtime, and that's the only time we can catch such error.

Write time tree checker doesn't go beyond single leave/node, thus has no
way to detect such parent-child mismatch case.

>  You are
> essentially duplicating the checks that we already do on reads, and the=
n adding
> the first_key check.
>=20
> I'll go along with the first_key check being relatively useful, but why=
 exactly
> do we need all this infrastructure when we can just check it as we walk=
 down the
> tree?

You can't really do the nritems and first key check at the current
timing of btrfs_verify_level_key() for new tree blocks due to lock contex=
t.

That's the only reason the new infrastructure is here, to block the only
hole of btrfs_verify_level_key().

>=20
> <snip>
>=20
>> @@ -2887,24 +2982,28 @@ int btrfs_search_slot(struct btrfs_trans_handl=
e *trans, struct btrfs_root *root,
>>  			}
>> =20
>>  			if (!p->skip_locking) {
>> -				level =3D btrfs_header_level(b);
>> -				if (level <=3D write_lock_level) {
>> +				if (level - 1 <=3D write_lock_level) {
>>  					err =3D btrfs_try_tree_write_lock(b);
>>  					if (!err) {
>>  						btrfs_set_path_blocking(p);
>>  						btrfs_tree_lock(b);
>>  					}
>> -					p->locks[level] =3D BTRFS_WRITE_LOCK;
>> +					p->locks[level - 1] =3D BTRFS_WRITE_LOCK;
>>  				} else {
>>  					err =3D btrfs_tree_read_lock_atomic(b);
>>  					if (!err) {
>>  						btrfs_set_path_blocking(p);
>>  						btrfs_tree_read_lock(b);
>>  					}
>> -					p->locks[level] =3D BTRFS_READ_LOCK;
>> +					p->locks[level - 1] =3D BTRFS_READ_LOCK;
>>  				}
>> -				p->nodes[level] =3D b;
>> +				p->nodes[level - 1] =3D b;
>>  			}
>=20
> This makes no sense to me.  Why do we need to change how we do level he=
re just
> for the btrfs_verify_child() check?

Because we can't trust the level from @b unless we have verified it.

(Although level is always checked in btrfs_verify_level_key(), but that
function is not 100% sure to be kept as is).

Thanks,
Qu

>  We've already init'ed verify further up,
> and we're not changing b here, so messing with level here just makes th=
e code
> less clear.  Thanks,
>=20
> Josef
>=20


--BxIxyUgV82eL6XO8cQyqpgDqm2q0qtmXU--

--cZvbWbGDYYZOrFTpyZygrzcpBGU6AqypL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl15hWYACgkQwj2R86El
/qjGLggAm5DwMfjZNdHwufKixsnpmalWIg3PF9518Y4Jjijq+V03liG56nHKAGxo
MsLmOldwMMTUHp0CH01/2biWpSPGyvJ2KD/lRCeBvl3xh6ZqmTZ004sF+vXkVDz4
5zUqaVCcbkC0YyciJ9gj3Lu+ymoPOWvkA8+1YA9D+OPrFYlEx9g8BhPcszGMO/RA
pME/dKenQvKNfjL4Kmi2xFkQWiHN2nKxgPkUx1Xe/6rQZYsEqIhQPT1fhnRnGKnj
CEGpDDIUgIQEVtraU58GCKg6KV7xLR9JLQgNYoxf/8nh07YrjlzgJEx/6yzqM2c5
90yfzV2KlPqk4LRpsQjmiauvmp0AhQ==
=U05N
-----END PGP SIGNATURE-----

--cZvbWbGDYYZOrFTpyZygrzcpBGU6AqypL--
