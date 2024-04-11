Return-Path: <linux-btrfs+bounces-4164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0408A2123
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A91283F37
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEDF3AC08;
	Thu, 11 Apr 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DAgjX/x6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4753717B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872344; cv=none; b=okTtbEg3MP5f9RZMrDA+7uKPGaRlIsod4VjXFcPLH0UmRqCoBs0CEMHd1mpir87sAEfckwarO91J/O4D3uULwylKS3ybbkwWjrXJBdgg1WRDDt61iNk6tWXetM2Wxwfy3Ke82HWXNz0oZWZU4KuWOpR4s9HRoVF/rXJddUyrUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872344; c=relaxed/simple;
	bh=lLyQ0AEvvjVfgFOr/hnqrIw1TPGdjoO3Zg43sODoT9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQCTo46n9Go1zIz3m5469ip72rLF6aiq0eAitwvOkxZGZc2npiVXdMsoIMCkcWI8Jzd+GOZskzY6B4Pvh7hScHNkUcYwUmqgSs/YxE5LxnWF34fSgLqrebP+GpbEjUtjOFqrKSDXf0mDRvvkdWF8SgE0S88oF7jjTuKU+BoYFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DAgjX/x6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712872331; x=1713477131; i=quwenruo.btrfs@gmx.com;
	bh=W2/DI8qOLPcLC6sUpzQOS17H2wjBOhRkAe51sZ594OY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DAgjX/x6nbSaznSDXP5v/fzD/zKH0htVUeH3dj2YnqsUDBNejwHm9O9DVh6jrdOj
	 TKDVbV/iSFPIuPBImue17Jf4J7PP2q8aWEq1Ek7U8yIiXZ//eMxIyqd01f90PLjpk
	 oFVmcLsI5eGhNRjVn19BuYjOyPIxMtoo9gWvMWvvCuj3E3JrJvXJKtlcCH6xdcOfi
	 bzHVw+zX5qlzCu0ZDNfIoAv9hWM+U882JWo2+Z6eV4mVZAMrfjO1nZeIWuJOP9rJ/
	 1ulFSV5Xy/kHVmDQNtx40IxAefw+vBfJVzFUqEmwFJUUgBBa89Z44UXu9xMdAJrz9
	 duAuOQwrt7QKNMz+Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5vc-1s89Na3Rb6-00M7FC; Thu, 11
 Apr 2024 23:52:11 +0200
Message-ID: <5c61734e-eb70-46bd-b81e-9d96c3ddace0@gmx.com>
Date: Fri, 12 Apr 2024 07:22:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] btrfs: introduce new members for extent_map
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712614770.git.wqu@suse.com>
 <33ad6697db3e0e869e4553d95c3a3dc98883c278.1712614770.git.wqu@suse.com>
 <CAL3q7H7MdJdv4L83ECpE1081OEv01gRX5VfxKL8MyWMdzAET5Q@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H7MdJdv4L83ECpE1081OEv01gRX5VfxKL8MyWMdzAET5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gw9GXStGJ191OSrB6FeWYUeC1Y9pTplcSc2euaxA3y+8kHKHhFm
 jxsaOerFCKtRA+8Ien2zR2d4trA5K+TEnLyd5qx8VmbV8K0qACgRIY04kd+SZREd934aLht
 XylEHx1qDYA95I/twp1m5eBRaMRAEvCM3ZQ41MzwAPKp8s8vr4S84hGHQkJhgxU7EbfFXpd
 iwNyvzsyeoorvPtyrmEJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6xFCkLpoiy4=;fUWxH5AfC1bSzYN89SCz2VrhHmK
 SZMgszQRJs2n/9lA9dxqdO23vQhRzxZbMpTh2QgepDMZiIKrkmwWqKXtFCeSzVjgenUTGD23O
 djlEHH1uF3OxCXdkqvm0miWr57+bRLSJfPZKhEnG/uwmEAYlOombjuWVvTK52PmRHkmmmTiJG
 Uup8FCgBDjc17pouY8wqGABdw/Dt45B6njkNbeO2AJopxT+AFvGol33WpbbvXxrqyGGZqAUtB
 lp210N26iYhUu2l0dlD7+dE1xecHAHBMD0vkJrjy2e2lEe5xB/YdT1v0xo6vdp5s1EUTslgp1
 bmgse2xwoUOBtKgFfGH9QLH+mEOEZ0GqujyQ7r4MlHjEbY7FBv1BSko3TIB0iugDJH4Jd6QBl
 Q90Ai2xFze+uzstljyUL3KbV7aUVQCjpgSdXR9HrYm7+dM010CRacmXU0vZocenadQLkmWOKi
 hTKQjYzkJ0FgobidX00/EaoFgWfbl5qWTOkp6prn60Dh4aMWe1LXH27XaFBR/yiBmOCAWHS8C
 t+eONf2mPgRoPBhJM0JSaqlJpAZZnW70JtnEZl7/rMS7Ldy0tCvGBbO/azgHxbb3I9ZMilIzv
 NYE5u8d1O/OD4awhwv8SHzwrEdtHysr0cxdEHBSwl/w5XHdV2hWW/ZUCumt5WsqqoRgAwYgho
 19UTdBJ3TuyEyND5lMu7DNYBdMbacBlIf06v5rJn/pue6ExCwSbcgBwFfki2DYrABAyWOw+9X
 hriUff01htsvXQ6uvVEi0zWhhuIklXIpKaYGFrDrzMnvQsOpDQ+KYCBHKHuiTC+R8jm8UM6OQ
 tKIJNMv0gKSete44851F80I+wzNM0z6VBct6o3QGTvJhQ=



=E5=9C=A8 2024/4/12 00:26, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Apr 8, 2024 at 11:34=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Introduce two new members for extent_map:
>>
>> - disk_bytenr
>> - offset
>>
>> Both are matching the members with the same name inside
>> btrfs_file_extent_items.
>>
>> For now this patch only touches those members when:
>>
>> - Reading btrfs_file_extent_items from disk
>> - Inserting new holes
>> - Merging two extent maps
>>    With the new disk_bytenr and disk_num_bytes, doing merging would be =
a
>>    little complex, as we have 3 different cases:
>>
>>    * Both extent maps are referring to the same data extent
>>    * Both extent maps are referring to different data extents, but
>>      those data extents are adjacent, and extent maps are at head/tail
>>      of each data extents
>>    * One of the extent map is referring to an merged and larger data
>>      extent that covers both extent maps
>>
>>    The 3rd case seems only valid in selftest (test_case_3()), but
>>    a new helper merge_ondisk_extents() should be able to handle all of
>>    them.
>>
>> - Add a new member for can_nocow_file_extent_args
>>    The new member is called "orig_disk_bytenr", for easier fetching the
>>    old disk_bytenr.
>>
>> - Update the new members when doing extent map split
>>    This is in fact a little simpler, as we only need to update
>>    offset/len.
>>
>> - Update the new members when inserting new io extent map
>>    This involves quite some NOCOW related functions, and adding two
>>    parameters to a already long parameter list.
>>
>>    To avoid unexpected parameter change, the two new parameters,
>>    @disk_bytenr and @offset are all added to the end of the list.
>>
>>    And they would be relocated when dropping the old
>>    @block_start/@block_len/@orig_start members.
>>
>> For now, both the old members (block_start/block_len/orig_start) are
>> co-existing with the new members (disk_bytenr/offset), meanwhile all th=
e
>> critical code is still using the old members only.
>>
>> The switch to new members would happen gradually to be bisect
>> friendly.
>
> I don't see why it is more bisect friendly.
>
> If there's a bug the bisection will point to the patch that does the
> switch, while the bug is very likely in the patch (this one) which is
> adding the field and doing all its computations.

You're right.

Especially with the next sanity check patch, all crash would happen at
that patch.

I'll just remove the mention of bisection friendly.

Thanks,
Qu
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/btrfs_inode.h |  3 +-
>>   fs/btrfs/defrag.c      |  4 +++
>>   fs/btrfs/extent_map.c  | 75 ++++++++++++++++++++++++++++++++++++++++-=
-
>>   fs/btrfs/extent_map.h  | 17 ++++++++++
>>   fs/btrfs/file-item.c   |  9 ++++-
>>   fs/btrfs/file.c        |  3 +-
>>   fs/btrfs/inode.c       | 56 +++++++++++++++++++++++--------
>>   7 files changed, 147 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
>> index 100020ca4658..ded36e065089 100644
>> --- a/fs/btrfs/btrfs_inode.h
>> +++ b/fs/btrfs/btrfs_inode.h
>> @@ -444,7 +444,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, str=
uct btrfs_device *dev,
>>                          u32 bio_offset, struct bio_vec *bv);
>>   noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *l=
en,
>>                                u64 *orig_start, u64 *orig_block_len,
>> -                             u64 *ram_bytes, bool nowait, bool strict)=
;
>> +                             u64 *ram_bytes, bool nowait, bool strict,
>> +                             u64 *disk_bytenr_ret, u64 *extent_offset_=
ret);
>>
>>   void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
>>   struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *d=
entry);
>> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
>> index f015fa1b6301..5259fd556487 100644
>> --- a/fs/btrfs/defrag.c
>> +++ b/fs/btrfs/defrag.c
>> @@ -709,6 +709,10 @@ static struct extent_map *defrag_get_extent(struct=
 btrfs_inode *inode,
>>                          em->start =3D start;
>>                          em->orig_start =3D start;
>>                          em->block_start =3D EXTENT_MAP_HOLE;
>> +                       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>> +                       em->disk_num_bytes =3D 0;
>> +                       em->ram_bytes =3D 0;
>> +                       em->offset =3D 0;
>>                          em->len =3D key.offset - start;
>>                          break;
>>                  }
>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>> index dd51a21b6a76..f59423897501 100644
>> --- a/fs/btrfs/extent_map.c
>> +++ b/fs/btrfs/extent_map.c
>> @@ -223,6 +223,58 @@ static bool mergeable_maps(const struct extent_map=
 *prev, const struct extent_ma
>>          return next->block_start =3D=3D prev->block_start;
>>   }
>>
>> +/*
>> + * Handle the ondisk data extents merge for @prev and @next.
>> + *
>> + * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
>> + * For now only uncompressed regular extent can be merged.
>> + *
>> + * @prev and @next will be both updated to point to the new merged ran=
ge.
>> + * Thus one of them should be removed by the caller.
>> + */
>> +static void merge_ondisk_extents(struct extent_map *prev, struct exten=
t_map *next)
>> +{
>> +       u64 new_disk_bytenr;
>> +       u64 new_disk_num_bytes;
>> +       u64 new_offset;
>> +
>> +       /* @prev and @next should not be compressed. */
>> +       ASSERT(!extent_map_is_compressed(prev));
>> +       ASSERT(!extent_map_is_compressed(next));
>> +
>> +       /*
>> +        * There are several different cases that @prev and @next can b=
e merged.
>
> that -> where
>
>> +        *
>> +        * 1) They are referring to the same data extent
>> +        * 2) Their ondisk data extents are adjacent and @prev is the t=
ail
>> +        *    and @next is the head of their data extents
>> +        * 3) One of @prev/@next is referrring to a larger merged data =
extent.
>
>   referrring ->  referring
>
>> +        *    (test_case_3 of extent maps tests).
>> +        *
>> +        * The calculation here always merge the data extents first, th=
en update
>> +        * @offset using the new data extents.
>> +        *
>> +        * For case 1), the merged data extent would be the same.
>> +        * For case 2), we just merge the two data extents into one.
>> +        * For case 3), we just got the larger data extent.
>> +        */
>> +       new_disk_bytenr =3D min(prev->disk_bytenr, next->disk_bytenr);
>> +       new_disk_num_bytes =3D max(prev->disk_bytenr + prev->disk_num_b=
ytes,
>> +                                next->disk_bytenr + next->disk_num_byt=
es) -
>> +                            new_disk_bytenr;
>> +       new_offset =3D prev->disk_bytenr + prev->offset - new_disk_byte=
nr;
>> +
>> +       prev->disk_bytenr =3D new_disk_bytenr;
>> +       prev->disk_num_bytes =3D new_disk_num_bytes;
>> +       prev->ram_bytes =3D new_disk_num_bytes;
>> +       prev->offset =3D new_offset;
>> +
>> +       next->disk_bytenr =3D new_disk_bytenr;
>> +       next->disk_num_bytes =3D new_disk_num_bytes;
>> +       next->ram_bytes =3D new_disk_num_bytes;
>> +       next->offset =3D new_offset;
>> +}
>> +
>>   static void try_merge_map(struct extent_map_tree *tree, struct extent=
_map *em)
>>   {
>>          struct extent_map *merge =3D NULL;
>> @@ -253,6 +305,9 @@ static void try_merge_map(struct extent_map_tree *t=
ree, struct extent_map *em)
>>                          em->block_len +=3D merge->block_len;
>>                          em->block_start =3D merge->block_start;
>>                          em->generation =3D max(em->generation, merge->=
generation);
>> +
>> +                       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>> +                               merge_ondisk_extents(merge, em);
>>                          em->flags |=3D EXTENT_FLAG_MERGED;
>>
>>                          rb_erase_cached(&merge->rb_node, &tree->map);
>> @@ -267,6 +322,8 @@ static void try_merge_map(struct extent_map_tree *t=
ree, struct extent_map *em)
>>          if (rb && can_merge_extent_map(merge) && mergeable_maps(em, me=
rge)) {
>>                  em->len +=3D merge->len;
>>                  em->block_len +=3D merge->block_len;
>> +               if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>> +                       merge_ondisk_extents(em, merge);
>>                  rb_erase_cached(&merge->rb_node, &tree->map);
>>                  RB_CLEAR_NODE(&merge->rb_node);
>>                  em->generation =3D max(em->generation, merge->generati=
on);
>> @@ -541,6 +598,7 @@ static noinline int merge_extent_mapping(struct ext=
ent_map_tree *em_tree,
>>              !extent_map_is_compressed(em)) {
>>                  em->block_start +=3D start_diff;
>>                  em->block_len =3D em->len;
>> +               em->offset +=3D start_diff;
>>          }
>>          return add_extent_mapping(em_tree, em, 0);
>>   }
>> @@ -759,14 +817,18 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
>>                                          split->block_len =3D em->block=
_len;
>>                                  else
>>                                          split->block_len =3D split->le=
n;
>> +                               split->disk_bytenr =3D em->disk_bytenr;
>>                                  split->disk_num_bytes =3D max(split->b=
lock_len,
>>                                                              em->disk_n=
um_bytes);
>> +                               split->offset =3D em->offset;
>>                                  split->ram_bytes =3D em->ram_bytes;
>>                          } else {
>>                                  split->orig_start =3D split->start;
>>                                  split->block_len =3D 0;
>>                                  split->block_start =3D em->block_start=
;
>> +                               split->disk_bytenr =3D em->disk_bytenr;
>>                                  split->disk_num_bytes =3D 0;
>> +                               split->offset =3D 0;
>>                                  split->ram_bytes =3D split->len;
>>                          }
>>
>> @@ -787,13 +849,14 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
>>                          split->start =3D end;
>>                          split->len =3D em_end - end;
>>                          split->block_start =3D em->block_start;
>> +                       split->disk_bytenr =3D em->disk_bytenr;
>>                          split->flags =3D flags;
>>                          split->generation =3D gen;
>>
>>                          if (em->block_start < EXTENT_MAP_LAST_BYTE) {
>>                                  split->disk_num_bytes =3D max(em->bloc=
k_len,
>>                                                              em->disk_n=
um_bytes);
>> -
>> +                               split->offset =3D em->offset + end - em=
->start;
>>                                  split->ram_bytes =3D em->ram_bytes;
>>                                  if (compressed) {
>>                                          split->block_len =3D em->block=
_len;
>> @@ -806,10 +869,11 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
>>                                          split->orig_start =3D em->orig=
_start;
>>                                  }
>>                          } else {
>> +                               split->disk_num_bytes =3D 0;
>> +                               split->offset =3D 0;
>>                                  split->ram_bytes =3D split->len;
>>                                  split->orig_start =3D split->start;
>>                                  split->block_len =3D 0;
>> -                               split->disk_num_bytes =3D 0;
>>                          }
>>
>>                          if (extent_map_in_tree(em)) {
>> @@ -965,6 +1029,9 @@ int split_extent_map(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 pre,
>>          /* First, replace the em with a new extent_map starting from *=
 em->start */
>>          split_pre->start =3D em->start;
>>          split_pre->len =3D pre;
>> +       split_pre->disk_bytenr =3D new_logical;
>> +       split_pre->disk_num_bytes =3D split_pre->len;
>> +       split_pre->offset =3D 0;
>>          split_pre->orig_start =3D split_pre->start;
>>          split_pre->block_start =3D new_logical;
>>          split_pre->block_len =3D split_pre->len;
>> @@ -983,10 +1050,12 @@ int split_extent_map(struct btrfs_inode *inode, =
u64 start, u64 len, u64 pre,
>>          /* Insert the middle extent_map. */
>>          split_mid->start =3D em->start + pre;
>>          split_mid->len =3D em->len - pre;
>> +       split_mid->disk_bytenr =3D em->block_start + pre;
>> +       split_mid->disk_num_bytes =3D split_mid->len;
>> +       split_mid->offset =3D 0;
>>          split_mid->orig_start =3D split_mid->start;
>>          split_mid->block_start =3D em->block_start + pre;
>>          split_mid->block_len =3D split_mid->len;
>> -       split_mid->disk_num_bytes =3D split_mid->block_len;
>>          split_mid->ram_bytes =3D split_mid->len;
>>          split_mid->flags =3D flags;
>>          split_mid->generation =3D em->generation;
>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>> index 242a0c2e7a5e..848b4a4ecd6a 100644
>> --- a/fs/btrfs/extent_map.h
>> +++ b/fs/btrfs/extent_map.h
>> @@ -67,12 +67,29 @@ struct extent_map {
>>           */
>>          u64 orig_start;
>>
>> +       /*
>> +        * The bytenr for of the full on-disk extent.
>
> "for of" should be just "of".
>
> I've only skimmed through the patch, but it seems ok.
>
> Thanks.
>
>> +        *
>> +        * For regular extents it's btrfs_file_extent_item::disk_bytenr=
.
>> +        * For holes it's EXTENT_MAP_HOLE and for inline extents it's
>> +        * EXTENT_MAP_INLINE.
>> +        */
>> +       u64 disk_bytenr;
>> +
>>          /*
>>           * The full on-disk extent length, matching
>>           * btrfs_file_extent_item::disk_num_bytes.
>>           */
>>          u64 disk_num_bytes;
>>
>> +       /*
>> +        * Offset inside the decompressed extent.
>> +        *
>> +        * For regular extents it's btrfs_file_extent_item::offset.
>> +        * For holes and inline extents it's 0.
>> +        */
>> +       u64 offset;
>> +
>>          /*
>>           * The decompressed size of the whole on-disk extent, matching
>>           * btrfs_file_extent_item::ram_bytes.
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index b552646a0ce6..96486f82ab5d 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -1280,12 +1280,17 @@ void btrfs_extent_item_to_extent_map(struct btr=
fs_inode *inode,
>>                  em->len =3D btrfs_file_extent_end(path) - extent_start=
;
>>                  em->orig_start =3D extent_start -
>>                          btrfs_file_extent_offset(leaf, fi);
>> -               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes=
(leaf, fi);
>>                  bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>>                  if (bytenr =3D=3D 0) {
>>                          em->block_start =3D EXTENT_MAP_HOLE;
>> +                       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>> +                       em->disk_num_bytes =3D 0;
>> +                       em->offset =3D 0;
>>                          return;
>>                  }
>> +               em->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf,=
 fi);
>> +               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes=
(leaf, fi);
>> +               em->offset =3D btrfs_file_extent_offset(leaf, fi);
>>                  if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>>                          extent_map_set_compression(em, compress_type);
>>                          em->block_start =3D bytenr;
>> @@ -1302,8 +1307,10 @@ void btrfs_extent_item_to_extent_map(struct btrf=
s_inode *inode,
>>                  ASSERT(extent_start =3D=3D 0);
>>
>>                  em->block_start =3D EXTENT_MAP_INLINE;
>> +               em->disk_bytenr =3D EXTENT_MAP_INLINE;
>>                  em->start =3D 0;
>>                  em->len =3D fs_info->sectorsize;
>> +               em->offset =3D 0;
>>                  /*
>>                   * Initialize orig_start and block_len with the same v=
alues
>>                   * as in inode.c:btrfs_get_extent().
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index cdcd7e0785c1..af6de3549901 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1094,7 +1094,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *in=
ode, loff_t pos,
>>                                                     &cached_state);
>>          }
>>          ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_by=
tes,
>> -                       NULL, NULL, NULL, nowait, false);
>> +                       NULL, NULL, NULL, nowait, false, NULL, NULL);
>>          if (ret <=3D 0)
>>                  btrfs_drew_write_unlock(&root->snapshot_lock);
>>          else
>> @@ -2161,6 +2161,7 @@ static int fill_holes(struct btrfs_trans_handle *=
trans,
>>                  hole_em->orig_start =3D offset;
>>
>>                  hole_em->block_start =3D EXTENT_MAP_HOLE;
>> +               hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>>                  hole_em->block_len =3D 0;
>>                  hole_em->disk_num_bytes =3D 0;
>>                  hole_em->generation =3D trans->transid;
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 4d207c3b38d9..69a7cdeef81e 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -139,9 +139,9 @@ static noinline int run_delalloc_cow(struct btrfs_i=
node *inode,
>>                                       bool pages_dirty);
>>   static struct extent_map *create_io_em(struct btrfs_inode *inode, u64=
 start,
>>                                         u64 len, u64 orig_start, u64 bl=
ock_start,
>> -                                      u64 block_len, u64 orig_block_le=
n,
>> +                                      u64 block_len, u64 disk_num_byte=
s,
>>                                         u64 ram_bytes, int compress_typ=
e,
>> -                                      int type);
>> +                                      int type, u64 disk_bytenr, u64 o=
ffset);
>>
>>   static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 n=
um_bytes,
>>                                            u64 root, void *warn_ctx)
>> @@ -1166,7 +1166,8 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
>>                            ins.offset,                   /* orig_block_=
len */
>>                            async_extent->ram_size,       /* ram_bytes *=
/
>>                            async_extent->compress_type,
>> -                         BTRFS_ORDERED_COMPRESSED);
>> +                         BTRFS_ORDERED_COMPRESSED,
>> +                         ins.objectid, 0);
>>          if (IS_ERR(em)) {
>>                  ret =3D PTR_ERR(em);
>>                  goto out_free_reserve;
>> @@ -1429,7 +1430,8 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>>                                    ins.offset, /* orig_block_len */
>>                                    ram_size, /* ram_bytes */
>>                                    BTRFS_COMPRESS_NONE, /* compress_typ=
e */
>> -                                 BTRFS_ORDERED_REGULAR /* type */);
>> +                                 BTRFS_ORDERED_REGULAR /* type */,
>> +                                 ins.objectid, 0);
>>                  if (IS_ERR(em)) {
>>                          ret =3D PTR_ERR(em);
>>                          goto out_reserve;
>> @@ -1859,6 +1861,7 @@ struct can_nocow_file_extent_args {
>>           */
>>
>>          u64 block_start;
>> +       u64 orig_disk_bytenr;
>>          u64 orig_disk_num_bytes;
>>          u64 orig_offset;
>>          /* Number of bytes that can be written to in NOCOW mode. */
>> @@ -1897,6 +1900,7 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>>
>>          /* Can't access these fields unless we know it's not an inline=
 extent. */
>>          args->block_start =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>> +       args->orig_disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, =
fi);
>>          args->orig_disk_num_bytes =3D btrfs_file_extent_disk_num_bytes=
(leaf, fi);
>>          args->orig_offset =3D btrfs_file_extent_offset(leaf, fi);
>>
>> @@ -2169,7 +2173,10 @@ static noinline int run_delalloc_nocow(struct bt=
rfs_inode *inode,
>>                                            nocow_args.num_bytes, /* blo=
ck_len */
>>                                            nocow_args.orig_disk_num_byt=
es, /* orig_block_len */
>>                                            ram_bytes, BTRFS_COMPRESS_NO=
NE,
>> -                                         BTRFS_ORDERED_PREALLOC);
>> +                                         BTRFS_ORDERED_PREALLOC,
>> +                                         nocow_args.orig_disk_bytenr,
>> +                                         cur_offset - found_key.offset=
 +
>> +                                         nocow_args.orig_offset);
>>                          if (IS_ERR(em)) {
>>                                  btrfs_dec_nocow_writers(nocow_bg);
>>                                  ret =3D PTR_ERR(em);
>> @@ -4999,6 +5006,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, =
loff_t oldsize, loff_t size)
>>                          hole_em->orig_start =3D cur_offset;
>>
>>                          hole_em->block_start =3D EXTENT_MAP_HOLE;
>> +                       hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>>                          hole_em->block_len =3D 0;
>>                          hole_em->disk_num_bytes =3D 0;
>>                          hole_em->ram_bytes =3D hole_size;
>> @@ -6860,6 +6868,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_=
inode *inode,
>>          }
>>          em->start =3D EXTENT_MAP_HOLE;
>>          em->orig_start =3D EXTENT_MAP_HOLE;
>> +       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>>          em->len =3D (u64)-1;
>>          em->block_len =3D (u64)-1;
>>
>> @@ -7025,7 +7034,9 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
>>                                                    const u64 block_len,
>>                                                    const u64 orig_block=
_len,
>>                                                    const u64 ram_bytes,
>> -                                                 const int type)
>> +                                                 const int type,
>> +                                                 const u64 disk_bytenr=
,
>> +                                                 const u64 offset)
>>   {
>>          struct extent_map *em =3D NULL;
>>          struct btrfs_ordered_extent *ordered;
>> @@ -7034,7 +7045,7 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
>>                  em =3D create_io_em(inode, start, len, orig_start, blo=
ck_start,
>>                                    block_len, orig_block_len, ram_bytes=
,
>>                                    BTRFS_COMPRESS_NONE, /* compress_typ=
e */
>> -                                 type);
>> +                                 type, disk_bytenr, offset);
>>                  if (IS_ERR(em))
>>                          goto out;
>>          }
>> @@ -7085,7 +7096,8 @@ static struct extent_map *btrfs_new_extent_direct=
(struct btrfs_inode *inode,
>>
>>          em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.off=
set, start,
>>                                       ins.objectid, ins.offset, ins.off=
set,
>> -                                    ins.offset, BTRFS_ORDERED_REGULAR)=
;
>> +                                    ins.offset, BTRFS_ORDERED_REGULAR,
>> +                                    ins.objectid, 0);
>>          btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>>          if (IS_ERR(em))
>>                  btrfs_free_reserved_extent(fs_info, ins.objectid, ins.=
offset,
>> @@ -7129,7 +7141,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs=
_info *fs_info, u64 bytenr)
>>    */
>>   noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *l=
en,
>>                                u64 *orig_start, u64 *orig_block_len,
>> -                             u64 *ram_bytes, bool nowait, bool strict)
>> +                             u64 *ram_bytes, bool nowait, bool strict,
>> +                             u64 *disk_bytenr_ret, u64 *new_offset_ret=
)
>>   {
>>          struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>>          struct can_nocow_file_extent_args nocow_args =3D { 0 };
>> @@ -7218,6 +7231,11 @@ noinline int can_nocow_extent(struct inode *inod=
e, u64 offset, u64 *len,
>>                  *orig_start =3D key.offset - nocow_args.orig_offset;
>>          if (orig_block_len)
>>                  *orig_block_len =3D nocow_args.orig_disk_num_bytes;
>> +       if (disk_bytenr_ret)
>> +               *disk_bytenr_ret =3D nocow_args.orig_disk_bytenr;
>> +       if (new_offset_ret)
>> +               *new_offset_ret =3D offset - key.offset +
>> +                                 nocow_args.orig_offset;
>>
>>          *len =3D nocow_args.num_bytes;
>>          ret =3D 1;
>> @@ -7324,7 +7342,7 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
>>                                         u64 len, u64 orig_start, u64 bl=
ock_start,
>>                                         u64 block_len, u64 disk_num_byt=
es,
>>                                         u64 ram_bytes, int compress_typ=
e,
>> -                                      int type)
>> +                                      int type, u64 disk_bytenr, u64 o=
ffset)
>>   {
>>          struct extent_map *em;
>>          int ret;
>> @@ -7381,9 +7399,11 @@ static struct extent_map *create_io_em(struct bt=
rfs_inode *inode, u64 start,
>>          em->len =3D len;
>>          em->block_len =3D block_len;
>>          em->block_start =3D block_start;
>> +       em->disk_bytenr =3D disk_bytenr;
>>          em->disk_num_bytes =3D disk_num_bytes;
>>          em->ram_bytes =3D ram_bytes;
>>          em->generation =3D -1;
>> +       em->offset =3D offset;
>>          em->flags |=3D EXTENT_FLAG_PINNED;
>>          if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>>                  extent_map_set_compression(em, compress_type);
>> @@ -7410,6 +7430,8 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>>          struct extent_map *em =3D *map;
>>          int type;
>>          u64 block_start, orig_start, orig_block_len, ram_bytes;
>> +       u64 disk_bytenr;
>> +       u64 new_offset;
>>          struct btrfs_block_group *bg;
>>          bool can_nocow =3D false;
>>          bool space_reserved =3D false;
>> @@ -7437,7 +7459,8 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>>                  block_start =3D em->block_start + (start - em->start);
>>
>>                  if (can_nocow_extent(inode, start, &len, &orig_start,
>> -                                    &orig_block_len, &ram_bytes, false=
, false) =3D=3D 1) {
>> +                                    &orig_block_len, &ram_bytes, false=
, false,
>> +                                    &disk_bytenr, &new_offset) =3D=3D =
1) {
>>                          bg =3D btrfs_inc_nocow_writers(fs_info, block_=
start);
>>                          if (bg)
>>                                  can_nocow =3D true;
>> @@ -7465,7 +7488,8 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>>                  em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_da=
ta, start, len,
>>                                                orig_start, block_start,
>>                                                len, orig_block_len,
>> -                                             ram_bytes, type);
>> +                                             ram_bytes, type,
>> +                                             disk_bytenr, new_offset);
>>                  btrfs_dec_nocow_writers(bg);
>>                  if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
>>                          free_extent_map(em);
>> @@ -9784,6 +9808,8 @@ static int __btrfs_prealloc_file_range(struct ino=
de *inode, int mode,
>>                  em->orig_start =3D cur_offset;
>>                  em->len =3D ins.offset;
>>                  em->block_start =3D ins.objectid;
>> +               em->disk_bytenr =3D ins.objectid;
>> +               em->offset =3D 0;
>>                  em->block_len =3D ins.offset;
>>                  em->disk_num_bytes =3D ins.offset;
>>                  em->ram_bytes =3D ins.offset;
>> @@ -10526,7 +10552,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *io=
cb, struct iov_iter *from,
>>          em =3D create_io_em(inode, start, num_bytes,
>>                            start - encoded->unencoded_offset, ins.objec=
tid,
>>                            ins.offset, ins.offset, ram_bytes, compressi=
on,
>> -                         BTRFS_ORDERED_COMPRESSED);
>> +                         BTRFS_ORDERED_COMPRESSED, ins.objectid,
>> +                         encoded->unencoded_offset);
>>          if (IS_ERR(em)) {
>>                  ret =3D PTR_ERR(em);
>>                  goto out_free_reserved;
>> @@ -10856,7 +10883,8 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
>>                  free_extent_map(em);
>>                  em =3D NULL;
>>
>> -               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL=
, NULL, false, true);
>> +               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL=
, NULL,
>> +                                      false, true, NULL, NULL);
>>                  if (ret < 0) {
>>                          goto out;
>>                  } else if (ret) {
>> --
>> 2.44.0
>>
>>
>

