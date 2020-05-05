Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F71C5168
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEEIz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 04:55:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:39411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEIzz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 04:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588668946;
        bh=4Uoxk4OxOAyppIn4Ph8M+HaeWmEBs0uQp7RWueyq15c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fMMEGeIcafI26az/xAYTamAkm7pYb60EVdeetVgD24PgInY0d7pfWzgo2Ltvz0bq3
         V8pGDO654Myq1CbrPqP6wIePxGFjgDWlglB95qPR5up5Jis4pO5IVJYdYAIsjtuvi5
         /SQ/YD9AZrcQ/eO6N33o7bYJ+C20VTyzUtJlNhpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79yG-1j4ZzB3jQK-017T0d; Tue, 05
 May 2020 10:55:46 +0200
Subject: Re: [PATCH v4 3/7] btrfs: block-group: Refactor how we delete one
 block group item
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-4-wqu@suse.com>
 <SN4PR0401MB35980F5B55AB37C71E789C1D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <bd019a91-406b-f913-1324-d4803f9b2223@gmx.com>
Date:   Tue, 5 May 2020 16:55:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35980F5B55AB37C71E789C1D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UnIkOi0Y0R0L56UbHiv0Txvoj8Tb4CSCW"
X-Provags-ID: V03:K1:ui3CJFJUxZp71zzQbT018ynmMhFHHH8ELhdWdMkvjt0QpgbJA10
 HwqVKJxlpgKWlVX316XyKV1Ox9YUJtQvktvWE5zC4iqR01qZjg5fiQ7fUygdns8F9rkF6q7
 fxOzysP3UFynejSDFM2SDKRj+zjIrdWrBhguDiC4WRQCRbc8Y27uu7JLAy1YIucyXxUtnP3
 V1eFmCJjRzh2MSzRv/tsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HvKQo4mrD7k=:gsYC3tvd2294Mlv5U8G0P+
 for4oRQU6h/qGj4uVDZJR4XxyMy1S7wCgxBTTxHF81TOXVTv6b1wEPT6xjDWqdnt7dDexSicA
 jhw8s0BzNgiBFX1S6XxKCqoGSo+s35uHIwb7UC8tK4FMxE++M34oXqp2S/G22IVtiDpf3j1OT
 89oT0X3qKxY4fJg1iNX/AkVwdR4L3HNOnWITTf1ShWzsBGPJPEXBGMHGMYjBaoaVpN0+49Lb0
 nw85GeK00S1ahqw3MhYWmxD2KRA84q7LVB2hO85tm2lWQwEEMBy2W6Dz+9whvRGKDWoZ40+wU
 TweVQXUYnyEi42nRoBiNfibx0bEIGA+iHIRNcNzwx/8GhrrePAsJxdchu7uWVYYCnpEh/+R8C
 +CVURKIy8/ZVJNkhuSURWV/u41KcPtQBen8Zcqm/dH5RTdPCgKMplJSxu2r0s/rDLTQ/7ir10
 5qkbaJW61KP61WmiWqIFCuQu2YWiXg5tKfdxeHyV251WWHBVZcMvzohnPWa5H+1yMeu1d2kzE
 7HIo4Q266HZXyQ/ycftG9KV+No7eRb8sVNkQ6JeBzANFaDZ4IdXZ7h6Cv1r69NZamyI8m4Q5S
 AKa3RmqO4E/CKi/OFcKC4fXFWrlM/9te/ZJjx2XlJTOfYquqgT2D+xrEUtnDZQUxb5OYWjpov
 qkvJjweOp5VnIz1Rj3dIK0kj0ufjJE0foLuobjgbTVkR7+wi94IYuCQCm0aU5jmWV+HNLRj0b
 t3u8JHvnm9jm6/bcACjlGM0TbR7jwPd0Rz/+ZsqzRT0IJgNa5F8k3AxB0PBaYBvCqecRcamGM
 GzaiXcxRX2mfjepiOR1qE7PysyXA8cuNliW9fqvhwgjE1sS9RqoS3A70ekUvfF+DjZroIK79a
 aIaIs7W6P++Ouu35cZvBYj5c1gSHeKlhGgGQZa+6IUeZ4H4DN/xuLY8zO/68PmSUsSao3aya7
 NBaUh4p98H57TG11uBVthjv4RANMN5sjEYskbtmDgIsBI7WrpD1VfOZCtnP0UzDva8b+K0Njk
 rxmsg4LbNKoV251vV8yH7BeL6nfun+Ob8JUd8nwmI3Go5T3T90pZ37QwIhoXYBBrs5cF1w1HS
 wZV4rW87Tt8uVUNXtpVHzfCm7kDUY//K7EFkf0bvN+vcP8uf04X+XnFtRnE7MnIsym3S7PnPa
 2IEZ7//CLE+PFEASo8KEZFrvCzEzr6yK2CJHtdkfqvqjOosMzTiGY68aaryxcgrlV7IV1peB1
 ntflz3EXyAiUC8yet
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UnIkOi0Y0R0L56UbHiv0Txvoj8Tb4CSCW
Content-Type: multipart/mixed; boundary="CwqZSZ1c8otnCSYCFYaLPS8LAWtMrK2Te"

--CwqZSZ1c8otnCSYCFYaLPS8LAWtMrK2Te
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8B=E5=8D=884:47, Johannes Thumshirn wrote:
> On 05/05/2020 01:58, Qu Wenruo wrote:
>> When deleting a block group item, it's pretty straight forward, just
>> delete the item pointed by the key.
>>
>> However it will not be that straight-forward for incoming skinny block=

>> group item.
>>
>> So refactor the block group item deletion into a new function,
>> remove_block_group_item(), also to make the already lengthy
>> btrfs_remove_block_group() a little shorter.
>=20
> I think this patch is useful even without the skinny_bg feature.
>=20
>> +static int remove_block_group_item(struct btrfs_trans_handle *trans,
>> +				   struct btrfs_path *path,
>> +				   struct btrfs_block_group *block_group)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>> +	struct btrfs_root *root;
>=20
> Tiny nitpick, why not:
>=20
> 	struct btrfs_root *root =3D fs_info->extent_root;
>=20
> Like it was in brtfs_remove_block_group()?

That's mostly for the skinny_bg_tree (6th) patch, as in that patch,
skinny_bg_tree feature goes to pick bg_root other than extent root.

So I didn't initialize root here, but leaves it assigned the same timing
as key.

Thanks,
Qu

>=20
> Anyways looks good to me,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20


--CwqZSZ1c8otnCSYCFYaLPS8LAWtMrK2Te--

--UnIkOi0Y0R0L56UbHiv0Txvoj8Tb4CSCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6xKg4ACgkQwj2R86El
/qgGsQf/dZxgXz87wXraB8UnpSZkpU5kHjw5Npl55r/SpGF5B+Fv7gaIZCo/R6oZ
iN+B8Us/Ef9TY0icXO3D9148paGuwrp3xtIGdPxy+Sp670pPbLp95GMAHJXZHzi2
La9jkjektEOLYcGajOA4JRjtNcR6wEl1sK5Sjzvto9qXYh7zxWm3Fsirssvk8bcV
1JdqOBa85uOCHFoDgMnVCJX8mtiov4pjAWmcx+48w1mDM1CiakUN0V9E/0/7PDt4
JLeczzbElX3q633h1lJTPZHBNyOkym59nSZQnByyNILqpJ/iwbnxYP9U7dqtI41D
9wVuu8f5+iFEM7fMW+oJFHMvczt53Q==
=l9AR
-----END PGP SIGNATURE-----

--UnIkOi0Y0R0L56UbHiv0Txvoj8Tb4CSCW--
