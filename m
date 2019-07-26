Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA10774F3
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2019 01:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGZX0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 19:26:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:36429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfGZX0l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 19:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564183593;
        bh=FtEFAvb9YGEPhout8TbA4gFQvpP2WOo1B2so2pjEYkA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=d4tyXf30b1Nhr8JoVtJwCuKFxa5/NNd3FSoMMmKEsYeDgoapI0DW20Z5BlTz49hjv
         M1dNK1Jx4RxaCryjrgFsPj9cSsXNRf3VE+OrTkSsp9qHLOhj3czrnlhA0Ryyy7ntM0
         ImhZJ5O2NNBXSMlS7bDn+dbZ6eM+gCAqAj7nbNcE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lj1Cw-1iOYPm28Qo-00dCrp; Sat, 27
 Jul 2019 01:26:33 +0200
Subject: Re: [PATCH 3/3] btrfs: tree-checker: Add ROOT_ITEM check
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190716090034.11641-1-wqu@suse.com>
 <20190716090034.11641-4-wqu@suse.com> <20190726152925.GG2868@twin.jikos.cz>
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
Message-ID: <98f0c716-b7ce-df16-a86e-634f03b68b31@gmx.com>
Date:   Sat, 27 Jul 2019 07:26:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726152925.GG2868@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WaQowfgNAvePmszwZe1UP0D5zKjs2cgBV"
X-Provags-ID: V03:K1:e1rUIT8TaiJBzIPJA/x+ne3DE7F2HR7D9PQOSQgW1DQCvmHosJt
 oLqmR9nsWwVKHcPyfJHE2wYYtjdTPrERvRyNZya61DsaYF7fpteQ1UsFFTB8vyCmjmnFE5X
 WkbAM6/6P3ojFgQLlGT40vJxeIBLHJ1uVfkqM/omlCBU2oNeloe82nKzsSb3dy0DpPZePh5
 fVXqVRB6kbYpguU44/aEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fMP1uPWT6k4=:WpLaJ9nwaiwONcil4PgHyk
 GAJRetBWlzq9Dlw8+ylJUkWjl3SIrUEd3bXmp6GYvY0AxVZAB0Waqcc/5rJygnIVBfIfYcq1/
 95C8abbWmu5QXoOTsu/dVCfxg/VwOcFtO6E8WO/4PYtNTtRK3S0auHAvGtkv44Av4L4UysoEF
 3Srd6sPts4M3hLtDO5Zmf2ZJ7ynWAvYZccmP4c5yZpmPooFwfrdxG0OENWZ0bBOOHk7c78TYP
 3z6Yl0QNV8iBtzSSO2pg4EF1m13SzDAIZKWMzw0VAQYp2Xb5a6/Pw8mltzlfbk5W+oUAsUm8p
 pzNrGmF8YBTKorFrtCNsVfk7DUcOhPQ1+PToo4IHCFu5JAXI1tYOC6Cm33ly6+lMxLcrqWcPf
 j8oAL/n+jMOifYbkKZ9qd4/eWuwwHkDknugEjUy4Y1hz4OCjnMOCuc66GOeJ/gQ5Y6lTCeH+R
 lJAoygDKr6nWalPV9zpg1LwlQRAUYLSLLaFPyaqmy4iUMteD42/FzUlAxQsxqAC14hbtNxccY
 A53p7mLwFtv03rhG+tiLt7AYa6iaUnKWCuzP8XwGRQC/JyhGUGr2U6uZglXj9B1OjRhpsCLyX
 6j//Z5Nvy6zB6K7+kXLB/Jw9g8RZIrYF2z+JO+YWz9uBOKuS4Rj7GNfNdDXQ8rkEfXYRs8/+P
 UkhqsdSwIKNV6Eyc2KxNEeQFA3FR7X4PfpBCx4wtI2pEvpruXmIWJJQhivxlBlKtoAlqTxjka
 hXysDLKE8lomieO9JWClSLXAm+bKxprM+lvk0NCdyNf8lFf+DVt80rXzYuL0VtzEBKcfime0W
 +ff20H8ySjmin0wNIwvmPf3q1oh6aHsm4o2oQvF9c9VdPFkj7wef11VqC78Ur/o977XTFu48w
 WduAGQRyQIauX/Y/95rfHfHU0u0Zj62bdFb5vi3LIMqO8Zj41bWvpaRaqS+AKkFh2NjRR00LU
 fuuvym2q+i2K4ntF0opUKkweypaN/hL2ZAv5ogxWd5ahBiJzXCe23mqBRJVrxHE8nMTFAZEAm
 gt6L+fxBgdvVfeRtP57qqqI89JXl+hafAC/JE/7Sbpk2HTSt8cKrRRM4CtwLY85EtyXi+Wl0x
 e0upQ88WfugfnM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WaQowfgNAvePmszwZe1UP0D5zKjs2cgBV
Content-Type: multipart/mixed; boundary="Ny2ZtLcjeiRAvtnpDghLjYmZ8L6hoQBUt";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <98f0c716-b7ce-df16-a86e-634f03b68b31@gmx.com>
Subject: Re: [PATCH 3/3] btrfs: tree-checker: Add ROOT_ITEM check
References: <20190716090034.11641-1-wqu@suse.com>
 <20190716090034.11641-4-wqu@suse.com> <20190726152925.GG2868@twin.jikos.cz>
In-Reply-To: <20190726152925.GG2868@twin.jikos.cz>

--Ny2ZtLcjeiRAvtnpDghLjYmZ8L6hoQBUt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[snip]
>=20
>> +	}
>> +
>> +	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
>> +			   sizeof(ri));
>> +
>> +	/* Generateion related */
>=20
> typo here and a few more times below
>=20
>> +	if (btrfs_root_generation(&ri) >
>> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
>> +		generic_err(leaf, slot,
>> +			"invalid root generaetion, have %llu expect (0, %llu]",
>> +			    btrfs_root_generation(&ri),
>> +			    btrfs_super_generation(fs_info->super_copy) + 1);
>> +		return -EUCLEAN;
>> +	}
>> +	if (btrfs_root_generation_v2(&ri) >
>> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
>> +		generic_err(leaf, slot,
>> +		"invalid root v2 generaetion, have %llu expect (0, %llu]",
>=20
> So (0, %llu] here means that it must be greater than zero, right? I'm
> not sure that everyone uses the same notation for open/closed notation.=


AFAIK in tree checker it's all the same notation.

Or any better solution for that?

Thanks,
Qu

>=20
>> +			    btrfs_root_generation_v2(&ri),
>> +			    btrfs_super_generation(fs_info->super_copy) + 1);
>> +		return -EUCLEAN;
>> +	}
>> +	if (btrfs_root_last_snapshot(&ri) >
>> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
>> +		generic_err(leaf, slot,
>> +		"invalid root last_snapshot, have %llu expect (0, %llu]",
>> +			    btrfs_root_last_snapshot(&ri),
>> +			    btrfs_super_generation(fs_info->super_copy) + 1);
>> +		return -EUCLEAN;
>> +	}
>> +
>> +	/* Alignment and level check */
>> +	if (!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize)) {
>> +		generic_err(leaf, slot,
>> +			"invalid root bytenr, have %llu expect to be aligned to %u",
>> +			    btrfs_root_bytenr(&ri), fs_info->sectorsize);
>> +		return -EUCLEAN;
>> +	}
>> +	if (btrfs_root_level(&ri) >=3D BTRFS_MAX_LEVEL) {
>> +		generic_err(leaf, slot,
>> +			"invalid root level, have %u expect [0, %u]",
>> +			    btrfs_root_level(&ri), BTRFS_MAX_LEVEL - 1);
>> +		return -EUCLEAN;
>> +	}
>> +	if (ri.drop_level >=3D BTRFS_MAX_LEVEL) {
>> +		generic_err(leaf, slot,
>> +			"invalid root level, have %u expect [0, %u]",
>> +			    ri.drop_level, BTRFS_MAX_LEVEL - 1);
>> +		return -EUCLEAN;
>> +	}
>> +
>> +	/* Flags check */
>> +	if (btrfs_root_flags(&ri) & ~valid_root_flags) {
>> +		generic_err(leaf, slot,
>> +			"invalid root flags, have 0x%llx expect mask 0x%llu",
>=20
>                                                                      0x=
%llx
>=20
>> +			    btrfs_root_flags(&ri), valid_root_flags);
>> +		return -EUCLEAN;
>> +	}
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Common point to switch the item-specific validation.
>>   */
>> @@ -845,6 +934,9 @@ static int check_leaf_item(struct extent_buffer *l=
eaf,
>>  	case BTRFS_INODE_ITEM_KEY:
>>  		ret =3D check_inode_item(leaf, key, slot);
>>  		break;
>> +	case BTRFS_ROOT_ITEM_KEY:
>> +		ret =3D check_root_item(leaf, key, slot);
>> +		break;
>>  	}
>>  	return ret;
>>  }
>> --=20
>> 2.22.0


--Ny2ZtLcjeiRAvtnpDghLjYmZ8L6hoQBUt--

--WaQowfgNAvePmszwZe1UP0D5zKjs2cgBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl07jCQACgkQwj2R86El
/qjlXgf/egCaWejrpzZhxDjjc3wzf3F2vsx6681ux+0KN89RkdB87hRKzyCA9hJE
4K6uFeui683uDCxqlsCEOQJfLyLKUH3/Xt8NKbwtS+nu7LMWTIqrHeiDH11Ko50H
o4FF2nbQMU78RW9VfMIo1xeELhupCtSoz+LTv8u6UuaLJLFF54WBCkgaqgPukWII
3uCmr7Yp1g056f5DwDo6tpljM3Y+fgezp1VQ8IjnDiluRdT5gIbrKtOeA5fewcZ5
wl2WSCREmkVI0Z/r+sQhldj6nlub/Cad39FtCeZZLA0VgbfQkKjh//Ab1SRB0kxO
OrSF7Lto5zhD95hPpmies92n7GIbjg==
=4xHZ
-----END PGP SIGNATURE-----

--WaQowfgNAvePmszwZe1UP0D5zKjs2cgBV--
