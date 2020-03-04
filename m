Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6D178735
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 01:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgCDAuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 19:50:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:56637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbgCDAuj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 19:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583283027;
        bh=AkAy0PR5jK57YiuxmlAP4v3qas8gTpLtDvxaTHC0D2U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=d7VVBpsmDvWuGHKqqV9pyh0ddRZW9i5Am1DBD5IKEzrhHNoGIrGYXrUFeYUdipnfE
         a6/QrGSPPl6oA5SxKqNS1yQXDi0gGWVwPSA3bxqKWub7IcZC690UuJGEyuHPzfp5jB
         Dss3ChVR0aLYnqZr6gwbu8TMxFxEtTgVep6tmn44=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnps0-1jjwRk3Tcg-00pQ26; Wed, 04
 Mar 2020 01:50:27 +0100
Subject: Re: [PATCH v2 01/10] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-2-wqu@suse.com> <20200303171902.GI2902@twin.jikos.cz>
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
Message-ID: <d04ef1a4-025a-ef13-b3e8-99a0c7e858b4@gmx.com>
Date:   Wed, 4 Mar 2020 08:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303171902.GI2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E9BdQ0SKXpl357Iuknn9Wx5lWEaXhsrB8"
X-Provags-ID: V03:K1:hioPI3YpgFq8cJO0o6cjlGuYQ93IT8ZUG2uwKtJ2cxi7K4hHKc2
 ECZIQRguDYzWK42CcBacyZxJ/JuVmMZksAMQpDXvOGHBJnYDJWm1OmPgSaeuFR8xJ8kEy3S
 5mBg1aD7ztyNY6ovo0wlu5zzc+qz4dAekkJO1NEoOrr7fP3Qs24AHu3rLF1yjV1+Tb0W7kA
 ElAJQFPCYqZYA3scPAatA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9B0ZVu8/2M=:da0ck/+aP/j/eLb8oNFIX4
 E3sVyXDwUj7m3y0bzXR1ulmBlCgzFsb1okMiYut+Ywg5TytG3VA/SEEKfRuTjz4Zoc0WdC7Rm
 W6WzVAILDb8JXunQByBNJycLr1m3+4L/Z30W1h2V4Zme0onae38Jxf3jes2Q0mIGLL5fZeGFQ
 0eornu/+66cqHRXAGuA4+wuY4rjQco441HF/f0ZDlGQfLZ53GbzWub1ITZ3K5841/nBh8hAA8
 +CogjAqwQGzrK0k+q4+I/KQw8iCd6wsB3xx48g+2439RCI0srvQjDi9OEzUHOLH6eurRLVMCa
 GRziRXz1wa7KcN9U8S9evdbv4LJns4PLcDMKu7TxEw5P2nNpKZ88B/uWhm+KTNQD8ILXMEnlh
 jBCZ5NQ1nMVOly5SzWSIR3hHlrw/Tb4X1W9q/4tXVFKYd27lOqZW6aoiYvozxvI4rtv/64mBu
 DhbEQvGNcIBtUlDsVvetSOmG/TEtGk+jt+JSeRZVmWv0d2Pmw8ebQDof28EWXyZpx75UGzeDW
 GxTiyYi6PVv63VLHkI9cpMwL3N0xhLzySejhDE9klHlGAawqVT3ceJm5ULEfwXMKrO4kY3hfP
 TfiakFmFTylU7IiKQW3s29+3D8VX3tMFJwnSkam5l0GD98dFKBKdOpjB9jImKY788I9ifPbvO
 0q9bXGyot1tAEy+q799l/riLMpobb+IAGcqZsn1u/+JrI5LPLZdzYNLlSRoFEJRs/2MAYw7gn
 r2KzSsEdIoTA5+b14RWYYDodmd2R+qC2Y6MPYlRXIpb2I6PO90v89++9Q8oxGswFTzGK/2aDw
 UdI96ZUTmcp+unjGrUSbXybHYV7h7d4qrYqy7exenbpOdrNg9hRfhe+Xs5P3AwVn6+Srv5GcK
 UCTgkUKXyTFBvuTDD7Y8zwk7qUKT+UA7N5Tts9EtpCgg5uEo/hpUQZwDPnwD5ePx/a1vk/NOv
 OfYgJf7hUyB2O7VkUQH+DvGB8LZZ/9W5S1fLcx1ay/Dmf3F+0fwfdVzuwEhlitoX9VqAmSmZj
 /jMXm0gQNZL/ockb9xGJXDHAsxpR3hV0HpH2WtPnksfnjBE43/8qcllFSYsQqvqycuYYCFD5S
 ggiAF4ETvBe2h9rVfLT9AZ7ZAfzEVneTf0uVSoZY/3ejOwGRDjEJ+JIXZffSwfTbcq8h/NL9d
 9R5DLBRMFSbj7ka80Jqbq5awZPv6Vpq6qnx8Mvl4zP41HlFVvGyagrmPK2A5XiEPdVdSvj6RA
 vmSuJh/kQzlOM88Al
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E9BdQ0SKXpl357Iuknn9Wx5lWEaXhsrB8
Content-Type: multipart/mixed; boundary="awPi71kg0UpztwqJEnxJvG6NwiTtTRJ1X"

--awPi71kg0UpztwqJEnxJvG6NwiTtTRJ1X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8A=E5=8D=881:19, David Sterba wrote:
> On Mon, Mar 02, 2020 at 05:45:44PM +0800, Qu Wenruo wrote:
>> Due to the complex nature of btrfs extent tree, when we want to iterat=
e
>> all backrefs of one extent, it involves quite a lot of work, like
>> searching the EXTENT_ITEM/METADATA_ITEM, iteration through inline and =
keyed
>> backrefs.
>>
>> Normally this would result pretty complex code, something like:
>>   btrfs_search_slot()
>>   /* Ensure we are at EXTENT_ITEM/METADATA_ITEM */
>>   while (1) {	/* Loop for extent tree items */
>> 	while (ptr < end) { /* Loop for inlined items */
>> 		/* REAL WORK HERE */
>> 	}
>>   next:
>>   	ret =3D btrfs_next_item()
>> 	/* Ensure we're still at keyed item for specified bytenr */
>>   }
>>
>> The idea of btrfs_backref_iter is to avoid such complex and hard to
>> read code structure, but something like the following:
>>
>>   iter =3D btrfs_backref_iter_alloc();
>>   ret =3D btrfs_backref_iter_start(iter, bytenr);
>>   if (ret < 0)
>> 	goto out;
>>   for (; ; ret =3D btrfs_backref_iter_next(iter)) {
>> 	/* REAL WORK HERE */
>>   }
>>   out:
>>   btrfs_backref_iter_free(iter);
>>
>> This patch is just the skeleton + btrfs_backref_iter_start() code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>  fs/btrfs/backref.c | 87 +++++++++++++++++++++++++++++++++++++++++++++=
+
>>  fs/btrfs/backref.h | 60 ++++++++++++++++++++++++++++++++
>>  2 files changed, 147 insertions(+)
>>
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index 327e4480957b..444cd5d31d87 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -2299,3 +2299,90 @@ void free_ipath(struct inode_fs_paths *ipath)
>>  	kvfree(ipath->fspath);
>>  	kfree(ipath);
>>  }
>> +
>> +int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 byt=
enr)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D iter->fs_info;
>> +	struct btrfs_path *path =3D iter->path;
>> +	struct btrfs_extent_item *ei;
>> +	struct btrfs_key key;
>> +	int ret;
>> +
>> +	key.objectid =3D bytenr;
>> +	key.type =3D BTRFS_METADATA_ITEM_KEY;
>> +	key.offset =3D (u64)-1;
>> +	iter->bytenr =3D bytenr;
>> +
>> +	ret =3D btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0,=
 0);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret =3D=3D 0) {
>> +		ret =3D -EUCLEAN;
>> +		goto release;
>> +	}
>> +	if (path->slots[0] =3D=3D 0) {
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +		ret =3D -EUCLEAN;
>> +		goto release;
>> +	}
>> +	path->slots[0]--;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	if (!(key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
>> +	      key.type =3D=3D BTRFS_METADATA_ITEM_KEY) || key.objectid !=3D =
bytenr) {
>> +		ret =3D -ENOENT;
>> +		goto release;
>> +	}
>> +	memcpy(&iter->cur_key, &key, sizeof(key));
>> +	iter->item_ptr =3D btrfs_item_ptr_offset(path->nodes[0],
>> +					       path->slots[0]);
>> +	iter->end_ptr =3D iter->item_ptr + btrfs_item_size_nr(path->nodes[0]=
,
>> +							    path->slots[0]);
>> +	ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +			    struct btrfs_extent_item);
>> +
>> +	/*
>> +	 * Only support iteration on tree backref yet.
>> +	 *
>> +	 * This is extra precaustion for non skinny-metadata, where
>> +	 * EXTENT_ITEM is also used for tree blocks, that we can only use
>> +	 * extent flags to determine if it's a tree block.
>> +	 */
>> +	if (btrfs_extent_flags(path->nodes[0], ei) & BTRFS_EXTENT_FLAG_DATA)=
 {
>> +		ret =3D -ENOTTY;
>=20
> What's the reason for ENOTTY?

Because it's not supported yet.

>=20
>> +		goto release;
>> +	}
>> +	iter->cur_ptr =3D iter->item_ptr + sizeof(*ei);
>> +
>> +	/* If there is no inline backref, go search for keyed backref */
>> +	if (iter->cur_ptr >=3D iter->end_ptr) {
>> +		ret =3D btrfs_next_item(fs_info->extent_root, path);
>> +
>> +		/* No inline nor keyed ref */
>> +		if (ret > 0) {
>> +			ret =3D -ENOENT;
>> +			goto release;
>> +		}
>> +		if (ret < 0)
>> +			goto release;
>> +
>> +		btrfs_item_key_to_cpu(path->nodes[0], &iter->cur_key,
>> +				path->slots[0]);
>> +		if (iter->cur_key.objectid !=3D bytenr ||
>> +		    (iter->cur_key.type !=3D BTRFS_SHARED_BLOCK_REF_KEY &&
>> +		     iter->cur_key.type !=3D BTRFS_TREE_BLOCK_REF_KEY)) {
>> +			ret =3D -ENOENT;
>> +			goto release;
>> +		}
>> +		iter->cur_ptr =3D btrfs_item_ptr_offset(path->nodes[0],
>> +						      path->slots[0]);
>> +		iter->item_ptr =3D iter->cur_ptr;
>> +		iter->end_ptr =3D iter->item_ptr + btrfs_item_size_nr(
>> +				path->nodes[0], path->slots[0]);
>> +	}
>> +
>> +	return 0;
>> +release:
>> +	btrfs_backref_iter_release(iter);
>> +	return ret;
>> +}
>> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
>> index 777f61dc081e..8b1ec11d4b28 100644
>> --- a/fs/btrfs/backref.h
>> +++ b/fs/btrfs/backref.h
>> @@ -74,4 +74,64 @@ struct prelim_ref {
>>  	u64 wanted_disk_byte;
>>  };
>> =20
>> +/*
>> + * Helper structure to help iterate backrefs of one extent.
>> + *
>> + * Now it only supports iteration for tree block in commit root.
>> + */
>> +struct btrfs_backref_iter {
>> +	u64 bytenr;
>> +	struct btrfs_path *path;
>> +	struct btrfs_fs_info *fs_info;
>> +	struct btrfs_key cur_key;
>> +	unsigned long item_ptr;
>> +	unsigned long cur_ptr;
>> +	unsigned long end_ptr;
>> +};
>> +
>> +static inline struct btrfs_backref_iter *
>> +btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info, gfp_t gfp_fla=
g)
>=20
> This does not need to be static inline, and please keep the type and
> function name on the same line.

OK, that makes sense.

Thanks,
Qu
>=20
>> +{
>> +	struct btrfs_backref_iter *ret;
>> +
>> +	ret =3D kzalloc(sizeof(*ret), gfp_flag);
>> +	if (!ret)
>> +		return NULL;
>> +
>> +	ret->path =3D btrfs_alloc_path();
>> +	if (!ret) {
>> +		kfree(ret);
>> +		return NULL;
>> +	}
>> +
>> +	/* Current backref iterator only supports iteration in commit root *=
/
>> +	ret->path->search_commit_root =3D 1;
>> +	ret->path->skip_locking =3D 1;
>> +	ret->path->reada =3D READA_FORWARD;
>> +	ret->fs_info =3D fs_info;
>> +
>> +	return ret;
>> +}


--awPi71kg0UpztwqJEnxJvG6NwiTtTRJ1X--

--E9BdQ0SKXpl357Iuknn9Wx5lWEaXhsrB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5e+04ACgkQwj2R86El
/qiosAf9Gcq3pHQtDok5HvaWxvo+cjTDf3xmZ5qEYoWC9pOc98/PxruD6JTUNw67
O1/4c+HU4Fy+lFXJIX14FstooY5yxlTOxmENiSgIEn/meR8n06WslRkFaeu+1o+8
cfN46xgtX8IhbGDAVuKEvg1tQLM77cYbJOWFMztfk5LGG/l/BeyS3PLXoDh4bxuz
0ie2NxMQBoHAlDoFdn293y2JVxaxotv/J9XouX0MilGx5l5LoLRn6BC4XannLffe
A+BK0sukLyD+8hqCSH+mcbWy0VfonE1EyfmMReMWnnOPl6+kbJIF0C87XMueR38q
S/vVrZLZyP7fHn8QLDicjQ10UnJTBg==
=VgGy
-----END PGP SIGNATURE-----

--E9BdQ0SKXpl357Iuknn9Wx5lWEaXhsrB8--
