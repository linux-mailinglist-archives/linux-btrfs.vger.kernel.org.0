Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A42A5AA5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 00:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgKCXma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 18:42:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:56901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgKCXm3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 18:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604446944;
        bh=lKM19RLs/eqa7E6zUYDWboex56BC8DzbSguvDLB9ACQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DsS8cIormlihlyifI0dWRpyue8BIeR0DHHQasJJYxO2OSY2PmxnVeNT4Qd3GXkrd2
         LpPBWD3CY4HVBrS2mzq/80NvTVIhRkM3Cdf8QW/FEcTgPGOzPyMhNCL4yXGha/VkuP
         cbCmTFTPW+iyEkyUuThQNRfIOk7znEaBJYynobNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1kdOGB3NS0-003Kkb; Wed, 04
 Nov 2020 00:42:24 +0100
Subject: Re: [PATCH 3/3] btrfs: file-item: refactor btrfs_lookup_bio_sums() to
 handle out-of-order bvecs
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201028072432.86907-1-wqu@suse.com>
 <20201028072432.86907-4-wqu@suse.com> <20201103194650.GD6756@twin.jikos.cz>
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
Message-ID: <2e0deb82-c2cf-088b-5abf-92003823613b@gmx.com>
Date:   Wed, 4 Nov 2020 07:42:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103194650.GD6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XOgZG6Kx2mxr3RJNiGJr3wghicbWQiZVp"
X-Provags-ID: V03:K1:83PmEJ8rffHRI3vwJNPJuzlseElsNz52JI9bjeJG0NGCFMZ0cVb
 dOq5FuqNk/UVQKSYcif/DdpKz5kZ5LoDrhnaWkQSccRolyLThhZ552DmA/lfpqPkNRjzocG
 lG99XzAkwUwoV7P9RgT4H2rsbaXtwbW5B62nJ8wRSKnf/nq4qU3jjcAUklGl2fhfzkV5EHj
 BWI5HaEtEQOE5k+zlruNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+29THPvnCHo=:xhNozGR1fgMDCRGkYzo6Wn
 zRFHfihXNrZh3zO+ET5fOUeAskVgo22yMK5jmqA1lWihUvU4er4cUs1D6hw6G1CflN9GKwkml
 V34BtiOcBBOho/GvD992w7pT2b4py6JCeltq9mIz9ZNfFebyV/S/zQ9BuJArLUJS8dcynY8/j
 HyBpXsmOIv7JfqnbV8tcRICmaOLLphZdq+eP+Ztxyirt8VUvolXUNA0DoVVVbKr9dYWlR956W
 c7iOpx8D5wXyxt/90jueKX2Hq7oEuBBoiUqs+u8LpBwpSN1BvW1qPYO9yf73/Tb0iSJm0KBP7
 uSJYmu+yHX3v2+Hc0i/yShcZks0HkeNOsp0DTIU3ztx86p74gVlNIbkNIcU9fz4e6L3ONZX7Q
 uoIBk2nxIIZMfENlxeLLJB8hzUqGdIAHCwI7bNAHSfkQT9kKH1KC+RmHK38rRX7afTmKlsjfQ
 YOuzKc8gO8XnyMKHxpO+f6GVBS0DodDmiWFShT0cbNFt97nOyqLDkDuOpihLcnTHMQA1CKd+q
 3IxCHlnO5IQMc8PlsN5zSkdO5E6hUiPfctH6vIMKaMP9AZvATpS5mkZRpkTSao9YCuH5aG2AX
 mN+W488JNZv+7DIpjX6aQdOA3KdNTU0wyNJn7zq9AgPVBChLTP+z7da0FtNjNQ8u6Ynf7W3Ro
 4pckf3PnaET/VxVwT54Kjd3zi+2AI1QRDoxQGCXzhheSuvYzXDQdbi5SaqrcjL0bBsxoPvz78
 b308MObc/AU+sCa+xcAJ7fInzJpg3GG9uVEEX0NSOTvLnGxY+zSzAJiVOAIbdpQAmXMGalK2q
 kKV2tJTaHHlYAS9TiJ1KcGLzg3osxX0P+gapTjfEmTlucbB4UBnaI4Noa4LhalOOgBvGclLus
 8yL/t9NdwLYd7id0EMlg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XOgZG6Kx2mxr3RJNiGJr3wghicbWQiZVp
Content-Type: multipart/mixed; boundary="VmxZGyRpvfL0o8amzN3qANKLgYIwhGSFS"

--VmxZGyRpvfL0o8amzN3qANKLgYIwhGSFS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/4 =E4=B8=8A=E5=8D=883:46, David Sterba wrote:
> On Wed, Oct 28, 2020 at 03:24:32PM +0800, Qu Wenruo wrote:
>> =20
>> +/*
>> + * Helper to find csums for logical bytenr range
>=20
>     * Find checksums for logical bytenr range
>=20
> 'Helper' or 'This function' are redundant
>=20
>> + * [disk_bytenr, disk_bytenr + len) and restore the result to @dst.
>                                            ^^^^^^^
> 					   store
>=20
> So this replaces the individual parameter description and is better
> readable, ok.
>=20
>> + *
>> + * Return >0 for the number of sectors we found.
>> + * Return 0 for the range [disk_bytenr, disk_bytenr + sectorsize) has=
 no csum
>> + * for it. Caller may want to try next sector until one range is hit.=

>> + * Return <0 for fatal error.
>> + */
>> +static int find_csum_tree_sums(struct btrfs_fs_info *fs_info,
>> +			       struct btrfs_path *path, u64 disk_bytenr,
>> +			       u64 len, u8 *dst)
>> +{
>> +	struct btrfs_csum_item *item =3D NULL;
>> +	struct btrfs_key key;
>> +	u32 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>=20
> This could use the fs_info->csum_size now that we have it
>=20
>> +	u32 sectorsize =3D fs_info->sectorsize;
>> +	int ret;
>> +	u64 csum_start;
>> +	u64 csum_len;
>> +
>> +	ASSERT(IS_ALIGNED(disk_bytenr, sectorsize) &&
>> +	       IS_ALIGNED(len, sectorsize));
>> +
>> +	/* Check if the current csum item covers disk_bytenr */
>> +	if (path->nodes[0]) {
>> +		item =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +				      struct btrfs_csum_item);
>> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +		csum_start =3D key.offset;
>> +		csum_len =3D btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
>> +			   csum_size * sectorsize;
>=20
> 			path->slots[0]) / csum_size * sectorsize
>=20
> This expresission would be better on one line

But it's already over 80 charactors.

Or maybe I could use a small helper to do the csum_len calcuation like
calc_csum_lenght(path)?


>=20
>> +		if (csum_start <=3D disk_bytenr &&
>> +		    csum_start + csum_len > disk_bytenr)
>> +			goto found;
>> +	}
>> +
>> +	/* Current item doesn't contain the desired range, re-search */
>                                                            ^^^^^^^^^
> 							   search again
>=20
>> +	btrfs_release_path(path);
>> +	item =3D btrfs_lookup_csum(NULL, fs_info->csum_root, path,
>> +				 disk_bytenr, 0);
>> +	if (IS_ERR(item)) {
>> +		ret =3D PTR_ERR(item);
>> +		goto out;
>> +	}
>> +found:
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	csum_start =3D key.offset;
>> +	csum_len =3D btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
>> +		   csum_size * sectorsize;
>=20
> same, on one line
>=20
>> +	ASSERT(csum_start <=3D disk_bytenr &&
>> +	       csum_start + csum_len > disk_bytenr);
>> +
>> +	ret =3D div_u64(min(csum_start + csum_len, disk_bytenr + len) -
>> +		      disk_bytenr, sectorsize);
>=20
> This can use the sectorsize_bits

Already done in the latest version. "[PATCH 24/32] btrfs: file-item:
refactor btrfs_lookup_bio_sums() to handle out-of-order bvecs".

=2E..
>> +	/*
>> +	 * In fact, for csum lookup we don't really need bio at all.
>> +	 *
>> +	 * We know the on-disk bytenr, the file_offset, and length.
>> +	 * That's enough to search csum. The bio is in fact just a distracti=
on
>> +	 * and following bio bvec would make thing much hard to go.
>> +	 * As we could have subpage bvec (with different bv_len) and non-lin=
ear
>> +	 * bvec.
>> +	 *
>> +	 * So here we don't bother bio at all, just use @cur_offset to do th=
e
>> +	 * iteration.
>=20
> This comment style is maybe more suitable for changelog but in the code=

> it comes in the context of the code so I'd expect something like:
>=20
> 	We don't need to use bio because we already know the on-disk
> 	bytenr, file_offset and length. For subpage bvec we can even
> 	have different bv_len than PAGE_SIZE or non-linear bvec.

Indeed looks better.

>=20
> Though, if there's redundant information in the bio it can be
> cross-checked by asserts.

The assert() can be done, but since we no longer do bvec iteration at
all, I doubt if it's really needed.

Thanks,
Qu

>=20
>> +	 */
>> +	for (cur_offset =3D orig_file_offset; cur_offset < orig_file_offset =
+ orig_len;
>> +	     cur_offset +=3D count * sectorsize) {
>> +		u64 cur_disk_bytenr;
>> +		int search_len =3D orig_file_offset + orig_len - cur_offset;
>> +		int diff_sectors;
>=20
> Int types mixed with u64
>=20
>> +		u8 *csum_dst;
>> +
>> +		diff_sectors =3D div_u64(cur_offset - orig_file_offset,
>> +				       sectorsize);
>> +		cur_disk_bytenr =3D orig_disk_bytenr +
>> +				  diff_sectors * sectorsize;
>> +		csum_dst =3D csum + diff_sectors * csum_size;
>> +
>> +		count =3D btrfs_find_ordered_sum(inode, cur_offset,
>> +					       cur_disk_bytenr, csum_dst,
>> +					       search_len / sectorsize);
>>  		if (count)
>> -			goto found;
>> -
>> -		if (!item || disk_bytenr < item_start_offset ||
>> -		    disk_bytenr >=3D item_last_offset) {
>> -			struct btrfs_key found_key;
>> -			u32 item_size;
>> -
>> -			if (item)
>> -				btrfs_release_path(path);
>> -			item =3D btrfs_lookup_csum(NULL, fs_info->csum_root,
>> -						 path, disk_bytenr, 0);
>> -			if (IS_ERR(item)) {
>> -				count =3D 1;
>> -				memset(csum, 0, csum_size);
>> -				if (BTRFS_I(inode)->root->root_key.objectid =3D=3D
>> -				    BTRFS_DATA_RELOC_TREE_OBJECTID) {
>> -					set_extent_bits(io_tree, offset,
>> -						offset + fs_info->sectorsize - 1,
>> -						EXTENT_NODATASUM);
>> -				} else {
>> -					btrfs_info_rl(fs_info,
>> -						   "no csum found for inode %llu start %llu",
>> -					       btrfs_ino(BTRFS_I(inode)), offset);
>> -				}
>> -				item =3D NULL;
>> -				btrfs_release_path(path);
>> -				goto found;
>> +			continue;
>> +		count =3D find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
>> +					    search_len, csum_dst);
>> +		if (!count) {
>> +			/*
>> +			 * For not found case, the csum has been zeroed
>> +			 * in find_csum_tree_sums() already, just skip
>> +			 * to next sector.
>> +			 */
>> +			count =3D 1;
>> +			if (BTRFS_I(inode)->root->root_key.objectid =3D=3D
>> +			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
>> +				set_extent_bits(io_tree, cur_offset,
>> +					cur_offset + sectorsize - 1,
>> +					EXTENT_NODATASUM);
>> +			} else {
>> +				btrfs_warn_rl(fs_info,
>> +		"csum hole found for root %lld inode %llu range [%llu, %llu)",
>> +				BTRFS_I(inode)->root->root_key.objectid,
>> +				btrfs_ino(BTRFS_I(inode)),
>> +				cur_offset, cur_offset + sectorsize);
>>  			}
>> -			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
>> -					      path->slots[0]);
>> -
>> -			item_start_offset =3D found_key.offset;
>> -			item_size =3D btrfs_item_size_nr(path->nodes[0],
>> -						       path->slots[0]);
>> -			item_last_offset =3D item_start_offset +
>> -				(item_size / csum_size) *
>> -				fs_info->sectorsize;
>> -			item =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> -					      struct btrfs_csum_item);
>> -		}
>> -		/*
>> -		 * this byte range must be able to fit inside
>> -		 * a single leaf so it will also fit inside a u32
>> -		 */
>> -		diff =3D disk_bytenr - item_start_offset;
>> -		diff =3D diff / fs_info->sectorsize;
>> -		diff =3D diff * csum_size;
>> -		count =3D min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
>> -					    inode->i_sb->s_blocksize_bits);
>> -		read_extent_buffer(path->nodes[0], csum,
>> -				   ((unsigned long)item) + diff,
>> -				   csum_size * count);
>> -found:
>> -		csum +=3D count * csum_size;
>> -		nblocks -=3D count;
>> -next:
>> -		while (count > 0) {
>> -			count--;
>> -			disk_bytenr +=3D fs_info->sectorsize;
>> -			offset +=3D fs_info->sectorsize;
>> -			page_bytes_left -=3D fs_info->sectorsize;
>> -			if (!page_bytes_left)
>> -				break; /* move to next bio */
>>  		}
>>  	}
>> =20
>> -	WARN_ON_ONCE(count);
>>  	btrfs_free_path(path);
>>  	return BLK_STS_OK;
>>  }
>> --=20
>> 2.29.1


--VmxZGyRpvfL0o8amzN3qANKLgYIwhGSFS--

--XOgZG6Kx2mxr3RJNiGJr3wghicbWQiZVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+h6t0ACgkQwj2R86El
/qgSuAgAo4e86eg2rsIWnwZOg7errzCBlf0vjm9NtSAdRf4iyandaCYDnJXKX+H5
x2Ye8+aX8FjSfNXe/kyYzTuDbxXYaZSsCarhvUYIaa6GwHlB//ZH6pSKY+e7B3cN
e1S3vJ1cgYrQp7LPyWepjFzujFjUS15q4eg0Y0Z84HU/jCM5gFWm+IVFza1rLK7A
izU2K8MC2Y15FyWgJIKQi9wKd2s8CH2YAVODvG13x7aflWrCKugyOhSXzl865l7O
L3AFDwdc7nPH3sYTYj+ZbB0uMw/fUobFk4Gl2kC9lVCLRTQ/LMSVDUoXrB+7cESi
0fSWuH9aG9JWwJX3Nh6/muRc3Zh8RQ==
=5Xr2
-----END PGP SIGNATURE-----

--XOgZG6Kx2mxr3RJNiGJr3wghicbWQiZVp--
