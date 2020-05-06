Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7851C7D9F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgEFWwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 18:52:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:47095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgEFWwb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 18:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588805542;
        bh=wLCRYOBvVYM91kcQACdjuZ3mIosw5dHsshxxUY3piyc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Nt4JK1QbeU4SmBFkr4C3l+aG06W2GfmrvZUVuXyPOPiI/pjUMZVxay6wwdrDRiwEq
         mJUAMqjamMx13XNGey5LCBCLdBcfazq4a9z8AlZwRuI5zBvn/pp7AAiOczbO8qXkoc
         2bobkzYHZFdWcO4QAGSEHPTnejeETHE8QXeS6Bd8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYLQ-1ivB9B1Dh2-00g3uA; Thu, 07
 May 2020 00:52:21 +0200
Subject: Re: [PATCH v4 02/11] btrfs-progs: block-group: Refactor how we read
 one block group item
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200505000230.4454-3-wqu@suse.com>
 <DM5PR0401MB3591BD0FCE7A13C5145BB7959BA40@DM5PR0401MB3591.namprd04.prod.outlook.com>
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
Message-ID: <20fe631b-5650-f6a5-2cf8-5603ac7dffc5@gmx.com>
Date:   Thu, 7 May 2020 06:52:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DM5PR0401MB3591BD0FCE7A13C5145BB7959BA40@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gF2Cp8iTgishRzdl9yVVxLnQQX0uBv3zT"
X-Provags-ID: V03:K1:Lod9GVunwyHuuV1xYM7QpxLRD7dGPNRijhc0cRvzlEGcif//nds
 I26v+NV/KNIgi0lrjVcRAfkfWp9sUyOn10NuY+Y9mY2dCzh0cNeKvOKHxx11mXogksjI4RB
 eyH26Ayg7dMtdYga9D1POmFQ5p0sBZq0XMcYSBMNMO7gB8IcPHElXhB413TqDnp8YxwFEfs
 Pl6dYEA+R+VLhPUmwpaAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n8AAKQyn2RI=:zqlBn/h7ds7K3opW31Apm1
 B2Pc4iz+Xu+qvA1kc4sImJ3R42HKMH5E/zFZGGVqku6axr6zDXZYvQeZ4U4u0QBQEEOaiZw7K
 03+UhUAM0chx0LCO0d0GqqeRs2GP/OXgXXLX25jZw2m2kBC5qJlvq3ZKssuyhfAvyxKsBEteo
 WUn94PYQBJ37ntVvwPa/1gOJB4B8UH/osALl/9uDf186aKAbGCmKgdbQVFz/pWs+3vrhNu1PE
 wAEyJozMa98bAzuTbq6tZjyL6uZ5pNC5qnPwSszBSU40/PDl7BWhlcwSrywnpR20mIJvHRzs1
 hFUE8uzITSupT/4zSFZ6BqGbzj+3p53YA+31WHVkaBj0s/ibFDlEWm/RqTNm2CjyQgncgYKWA
 odhrl+HccqYRTV9zjaucYq39z3Ak/0oPL1KMtfpbWX2BLd1unqO1SjHzxzuj/VinFYew87VWi
 H3RsrZb4vXASXEzKsVONlvsMixxOE+2M2btSPajZHZfVtptdFHdFrxYVuvV/XQMSFGwKwIDLt
 cRyRGDFro3RySpcnNeAT42pX8zjPJYgrtMte9wSXh0RAo2oMkbRgqasISbxw1weXFlLpJzUEn
 X3TRjvIkWbWIS2TidHJTqAAzuOddzGRo7gd2um9W3IEiLTX5Y0GvK3R7OWqBAED56Uhh2+vxv
 /If/SEYJ20EhljkQxyl89XJ4J+C/WrkqJ6FpJHOYph7NOfXlODmieNcfV7NSivdyd/lo+8cOc
 ZZ3AIHrm3pd+dTqO0tug0Ohr23DeIOD0kddwCcNVkrOcvdisR7w4dmgEARUgDBV+SKuTWFWje
 dxk3FqlaBH9GUijNRShW48nwMWuJUD2YE5DSc3+dTWoVtATrp4FuhwNo1IP70702NMn52yGfN
 w8vApgpI1u/jRqd2kzrSsjCERSD4LNEfMA5hhlrnKEX1LEFSD8c7DaQPGdB2pipcxnjFzbO3N
 N2aRgitgYyCuWiS8cSCENuFGrVhi38/QNn+yrmRGTzRgvToSDg12JG/BWzUMpNNnAfhsnTB91
 UYp6nyj8cMoSpXtK+2H+4ko+xfqyhNc8GfVLUckQx+aBytKAysNWk9j3WCDR4B67JNb7evWxO
 jZpp4o39QS2+ZDHj3rHtdrynU4r7HeT5IaN/pamEYQrbGlTNGRXhIjXgPBWOp8GWPja+66NSo
 d+TnrxWFd2ulCKqK7J6PNHR6Ptdwgqg7quaKsvM4dohb/9Sennkzaq1Br4LoeCnl7BtZGIUTs
 257da9ovEW4fMQETY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gF2Cp8iTgishRzdl9yVVxLnQQX0uBv3zT
Content-Type: multipart/mixed; boundary="QuqH1swrrcg86vXR8eKHK44SiCfqvGZu1"

--QuqH1swrrcg86vXR8eKHK44SiCfqvGZu1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/7 =E4=B8=8A=E5=8D=881:27, Johannes Thumshirn wrote:
> On 05/05/2020 02:02, Qu Wenruo wrote:
>> - Use btrfs_block_group::length  to replace key::offset
>>    Since skinny block group item would have a different meaning for it=
s
>>    key offset.
>=20
> Nope, you still use key->offset for cache->length

That's no problem for regular block group item, as in that case
key->offset is block group length.

It looks like the sentence is not clear enough, what I mean is, after
read_block_group_item(), there shouldn't be any key->offset user, but
use block_group->length instead.

Thanks,
Qu

>=20
>> +
>> +	cache->start =3D key->objectid;
>> +	cache->length =3D key->offset;
>=20


--QuqH1swrrcg86vXR8eKHK44SiCfqvGZu1--

--gF2Cp8iTgishRzdl9yVVxLnQQX0uBv3zT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6zP6EACgkQwj2R86El
/qhTawgAg50x858uJFln3sRBGeQhZnERQpDJy9IAs/h8/MVA75wxf+rb7JRz1hZA
X02a4GpxS5xYJ5C5PMqaiVOM+FTC/nBwpUSpfVA+fb/lxncaI7BC9YyiVx18PIqK
V/72BrZTQ9ECiRW5WjocdIsAct5Lb/dEvRoEEa6Px11TTSK4whdsEFBqGdlcPTWp
Ytn5mud8CWHK6/hAZg5V6RogM7eH5QkodJupmVipOHKa0Hkf3MDRZ6dTg1mrridI
iPPFxibuT1j83WLVIWBZGloiIzwa001r81PFnuu2063NnD7rFq6Bss5x0ZDl4w/t
Ro8LRREzWiA+jHilu1D5iSrJBnyD5A==
=QdaP
-----END PGP SIGNATURE-----

--gF2Cp8iTgishRzdl9yVVxLnQQX0uBv3zT--
