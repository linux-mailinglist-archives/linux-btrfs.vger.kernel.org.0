Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18992FB64
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfE3MEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 08:04:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:34995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfE3MEF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 08:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559217836;
        bh=E3EgCuaCCb6uaa3ETOhejwqYnONt3Qr7W1aSkkARzrQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EQ5tbwgCWlnYy0fKUjOsKH4WyZBSPvQUWMYdtMlTA9FbIwP8TF9HGG2FuxJ3zbIyt
         LpJD+kiPu8fpjCR8QMPrt3Ny+FG5HWgwCtxPdAg3j7qNfCWn1RPUkGT27EXTsJLHXR
         tZRv2/SI7pNMRmpLt5irqEY3eyFTpvKwjDWhh/Wo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N95iH-1gZ2KK1MAx-01693l; Thu, 30
 May 2019 14:03:56 +0200
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190503003054.9346-1-wqu@suse.com>
 <20190530120253.GC15290@twin.jikos.cz>
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
Message-ID: <10c517e9-7a70-4c98-6c7c-290bc5540170@gmx.com>
Date:   Thu, 30 May 2019 20:03:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530120253.GC15290@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BYQltvJEEejEf5EZASrihyasslTS5Ydkt"
X-Provags-ID: V03:K1:g+cpiLgiqZP4zfY2ZOPlsF8HZ+DlfVHA9QL/oX1e1BbwDHbcTMB
 yaNT449/7TQRJ9tGYsn6XPfOnVNzptAalSsyeL9oLPyRP4nUTFSKf5XX2JPPjO4+vEuveSK
 Qqx9vA51D6z1gCOgnfPhsTO2mwgG/68E6mMydElr/2FA2vo192ctzJk65YLCjx7qK+mrXWi
 dkns7LTQkwfAJkjW6+enw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UyTg7JaRFCk=:y8uP+S1oFRXm2WmOI945nv
 doo3LY6uZ0YEGTTsNt6TU6VCColqdstdSmTZB6uCEK8h4k1ZFLVhHECBbtMLZaRM64JUHDTea
 MhJEA9XYSkxdhEk8O4fmGkrGMOcWzbo+zTWg224d2s/tc9W209F/lFm5laUTTfwusW3/V5x+t
 4YpQCvxsUvaLntZ2nT1SenAiAy53CUutiInXVtP55OH6vF8BCT042b2Elg7Hh1v9MhbEJocQl
 cqxlQo7IblIH9l0uuWnVTEcjBbLVkLz1394lghuhd+O0PpvLIY9a6klohwfAXjRleU4dj5jx0
 qz6y9UTUf6tDT/FisUfisDZ+qj6yjQ2T5eBWjcQXQEy082RRuNRNDG5QccQwziZSbpJVrOByo
 4DwNUaMfi3Z+rPXzoUeUNIC0C5+Ph8wwFLVznuib7va9t0CdoFXqOYqUCJMXY7QXbsbSh/tgJ
 B15vxG0/3Z7bzQcKJScRWcAgYZiaQ3d+1HTlMc+GU9rGpTiS0/9TbRxsd5M90R0+svikmUJUz
 35vC3s76+2rhIkLBJPchfglOI8w6Z3qui00h3+3JkyirtSodtapP+ZmO7kT65qMGRTzd2OUAw
 q862JBLu7StafDldwCQkgWVNMLVF9OJijDhucYIk90eD87SkYiv/cA39k/0oLb369Ve//NC39
 fnteY6+o53QHTil+1Guw2tR5NGkWNasqj0ZKUbH6QP2MBQ8JC2xlybH64r2CxMgLY+Tx6JuLi
 aKBwY2wR99sK+0Q8+vaeQOGtgeGDG5riOKwTU74QITn5r9A7twyVX5E2qZ2wYnw7E6eIhvZdG
 2TRIIi8yjuU3coLcPsQ18whcpLep12Mvh4BxeKUULkJoESUOsUj3nv0FvRxLdKwXtrgl1Ca6x
 utCfI0eInaOOwamOVetahv8i9Gl6wXo/gq+/3jSSXfIlyWvabppzjiwGadqlVwEHHxHTdEdYj
 F7cjUxDatSqfFFegxuyvJ2KeP89g+efw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BYQltvJEEejEf5EZASrihyasslTS5Ydkt
Content-Type: multipart/mixed; boundary="8JXfUixftLnf9ItTL69qTfLN7L5L1e7Rt";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <10c517e9-7a70-4c98-6c7c-290bc5540170@gmx.com>
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
References: <20190503003054.9346-1-wqu@suse.com>
 <20190530120253.GC15290@twin.jikos.cz>
In-Reply-To: <20190530120253.GC15290@twin.jikos.cz>

--8JXfUixftLnf9ItTL69qTfLN7L5L1e7Rt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/30 =E4=B8=8B=E5=8D=888:02, David Sterba wrote:
> On Fri, May 03, 2019 at 08:30:54AM +0800, Qu Wenruo wrote:
>> Under certain condition, we could have strange file extent item in log=

>> tree like:
>>
>>   item 18 key (69599 108 397312) itemoff 15208 itemsize 53
>> 	extent data disk bytenr 0 nr 0
>> 	extent data offset 0 nr 18446744073709547520 ram 18446744073709547520=

>>
>> The num_bytes and ram_bytes part overflow.
>>
>> For num_bytes part, we can detect such overflow along with file offset=

>> (key->offset), as file_offset + num_bytes should never go beyond u64
>> max.
>>
>> For ram_bytes part, it's about the decompressed size of the extent, no=
t
>> directly related to the size.
>> In theory is OK to have super large value, and put extra
>> limitation on ram bytes may cause unexpected false alert.
>>
>> So in tree-checker, we only check if the file offset and num bytes
>> overflow.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/tree-checker.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 4f4f5af6345a..795eb6c18456 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -112,6 +112,7 @@ static int check_extent_data_item(struct extent_bu=
ffer *leaf,
>>  	struct btrfs_file_extent_item *fi;
>>  	u32 sectorsize =3D fs_info->sectorsize;
>>  	u32 item_size =3D btrfs_item_size_nr(leaf, slot);
>> +	u64 extent_end;
>> =20
>>  	if (!IS_ALIGNED(key->offset, sectorsize)) {
>>  		file_extent_err(leaf, slot,
>> @@ -186,6 +187,14 @@ static int check_extent_data_item(struct extent_b=
uffer *leaf,
>>  	    CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
>>  	    CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize))
>>  		return -EUCLEAN;
>> +	/* Catch extent end overflow case */
>> +	if (check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
>> +			       key->offset, &extent_end)) {
>> +		file_extent_err(leaf, slot,
>> +	"extent end overflow, have file offset %llu extent num bytes %llu",
>> +				key->offset,
>> +				btrfs_file_extent_num_bytes(leaf, fi));
>=20
> Isn't this missing
>=20
> 		return -EUCLEAN;

Oh, my bad.

Would you mind to fold that return line?

Thanks,
Qu

>=20
> ?
>=20
>> +	}
>>  	return 0;
>>  }
>> =20
>> --=20
>> 2.21.0


--8JXfUixftLnf9ItTL69qTfLN7L5L1e7Rt--

--BYQltvJEEejEf5EZASrihyasslTS5Ydkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzvxqQACgkQwj2R86El
/qizgAf/cR6lQlnIAoRBhOhUqi+V2Shnch/krwy7ZP8nHDM4wvvHZt3y2+CAaAl/
7ICDz9FawEkGjG8MF8BhA2D1xwy9kIVtQ9l4dJ0H4WwiDqX8IeDyds7vIkcJksxI
/zjp9Mo5scK5k2FSBCJNhH3ppZwGTxYpDbJbGqQd0oReDinHK+WR6pgf2Idc+G3y
D+cXRgguuPI2YL8hdWzB1kuQIZ9gkHMAGtaRNkicQx4NJ/cSBtfmnTR8RBdfPfV1
7BxsKPLpv5bkAbzV3JvdrwHVrICippyDhU86ZPa2M5icCWf/QDGjJpHzOOlzbFIM
UEwG1Z2lyIq/yAQvxToaoj4wVV3kuw==
=7FkE
-----END PGP SIGNATURE-----

--BYQltvJEEejEf5EZASrihyasslTS5Ydkt--
