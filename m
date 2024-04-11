Return-Path: <linux-btrfs+bounces-4165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C08A218F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E1288353
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC43D544;
	Thu, 11 Apr 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oH8NSeA7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9463D38F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873030; cv=none; b=E0T0N8dtlrh2MQltpxmPGVAfXZq3m3m3fKtjNBVIrXoe03Aa9x0qQfSxHfT0z5Qqm7pE4zBb+/NdoH/4XSajD20Iwh/RNl6WesMeCSbrD5Nsuen9WkP7hUTvlPvaXxTug8I1RCYACNxLN7m0DAMpJuQJUvkRfchqAT4Xj1gEMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873030; c=relaxed/simple;
	bh=LcLeBDdVYSPCTG9aNCNG3pYOy5bbLrHDHdnJEt7GEpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2BoTi8P7IWcaOMH9TJLRuwjvOWkquMC/OzOH+tXrMOubGngYrdHri9RWe1QSN2K3/wllv70xgTfEQVPVf9VPqP9Cbesb77QwEqjGHr1ihtJCnx6uf8urb01Yw1XvZakGK9JEl3snJqLbjen7HJm1L7/CNtkVVpFIiXUetfEhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oH8NSeA7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712873016; x=1713477816; i=quwenruo.btrfs@gmx.com;
	bh=R/J1HXwbeg/5sB2U10Pu2hEtoKdyNcS9HJffDThAOSY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=oH8NSeA7DMq0oBMqYvC3WHItmsyUbDMErQWPFUBT0jOJaOLrOK/w/sh2x5hZN+gH
	 083kCspD7yAsBLZcl7x9crKPikqJvQPITfx1qYkGAeJuATRWDojxUjBfC3EAE7O2t
	 98uNCZG5GIuGoBkBbx1MIR9lH5kLhWhbPdH7VrsetJqcL//fefZOd6pHxLssgv4BE
	 xFBg9O+MVoCdpUgn07vAncWpGNuMUKS84fXq3LVDMCb3QuCxhR8D+92jYsraUVgHM
	 9FWki5M8ElyIYWLc3z7rWcEJIoNCUHGegDt7vZhLhfW44dHpqGRsLXWlyD2J6HknA
	 R97Z71zvYy81KPuluw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGvG-1sGQCv46Qw-00Yi9q; Fri, 12
 Apr 2024 00:03:36 +0200
Message-ID: <65a7c2b6-9700-4d52-bd5e-9bfc2e32327d@gmx.com>
Date: Fri, 12 Apr 2024 07:33:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] btrfs: rename members of
 can_nocow_file_extent_args
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712614770.git.wqu@suse.com>
 <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
 <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com>
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
In-Reply-To: <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r1cDbp4ymGcu4+UQs4CIT8jzMdIs6gF2fXWs32pWOwLlxKdA6ha
 Ly2rrjN/QkMLpUrf/E3EtB7NFL/glZCXW14XtibmKIPdyNlgQbh5a7km+56MSvbUqYYcSZt
 3KG2EaedHJWah2zS4XPyJnyq5qu4oWPghdIgGtmHW77paRI5kf6Q3ucyO2AwcrwdCpbx1Bp
 ZUUyEIQdAVg/okvYGtTMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vi9zI+oXgBw=;Fc/V5o8s1QEhG5iDq3tpp5q4tyz
 faqP+kyvIJzuNiCr1lY050q7f13EedM1WR5BLugJGiTYgxZXZ9KNs1yXn9MUxaIPt7Uqpc6nq
 MScrFkKCRcO5dvx9h5Enq17L3YHqLWwVajAljrJ/UqkIqtVXNGCZeO2dtBgVCi9O+xKmbpsoe
 4jI5Gh+fBxsIl23KK36aRb+hbqPVR7wuIEuQlkCvT+RXglriVsOf5A2w+amL4NylQKYfasQRB
 uv7ZFoEX9yskglzDDbA0UxEjv6A/tzWzejFPq8b15wZK7HCGAmaCLsX4bUkdYhMFflUaKuQxd
 Hv6Sg1Fb+ayrQm8wue9ZhnSyx+zrYWYjWp4eukqBfPOXMzhr+op40K+bLO27+oGrAZbU7TR5l
 WrtrnsAbqYIK341CP1cSJxDMOhJPyMCLxYl7xIQh/rJ5exWuJmqWqYV5fgUyZz/CwIIGq+lbH
 RCeTcoPcyD+mGxjaCesr7+z9nB/QhEcek6bdcZ76alsjFysnWWv75lgVAKm/IspWHde+eFm3H
 Ef8qoGv1cp+tY9ExYsVilz2Qt9Q7h1cVj28jGrvuUVR+IrCWcxK6BJoLcX9yj2i7lmMfnEXST
 XUiOx4pIlfvup8f8+qRK/qu66mW3HKiO9XITpw3T6c+SvkDOeDJK2WAfKfY+sGdRqUUA0CBS/
 mJlwO12Fcu9ThUzOqXF7yT5/faoFm9fer1Nsim5k15zrtv6P3SEp1P8iM5c7M87vsdEjyX+F6
 WmGjnGya96BcLMpaMxbbhym/GtX/lgyQZsGF2Y7SyhcCxiXc4/v34ilPv0Rxi/Hhsm0VNL/Wo
 QsAN991FB0PjXkEqI5xFJyq9OBFUk//f3M3EJPoL5fmOU=



=E5=9C=A8 2024/4/12 00:16, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Apr 8, 2024 at 11:34=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The structure can_nocow_file_extent_args is utilized to provide the
>> needed info for a NOCOW writes.
>>
>> However some of its members are pretty confusing.
>> For example, @disk_bytenr is not btrfs_file_extent_item::disk_bytenr,
>> but with extra offset, thus it works more like extent_map::block_start.
>>
>> This patch would:
>>
>> - Rename members directly fetched from btrfs_file_extent_item
>>    The new name would have "orig_" prefix, with the same member name fr=
om
>>    btrfs_file_extent_item.
>>
>> - For the old @disk_bytenr, rename it to @block_start
>>    As it's directly passed into create_io_em() as @block_start.
>
> So I find these new names more confusing actually.
>
> So the existing names reflect fields from struct
> btrfs_file_extent_item, because NOCOW checks are always done against
> the range of a file extent item, therefore the existing naming.

It's true for @extent_offset, but @disk_bytenr is not the case.

It's calculated by file_extent_item::disk_bytenr + file_extent_item::offse=
t.

That's why I find the old @disk_bytenr very confusing (and caused
several crashes in my sanity checks).

>
> Sometimes it may be against the whole range of the extent item,
> sometimes only a part of it, in which case disk_bytenr is incremented
> by offsets.
>
> This is the same logic with struct btrfs_ordered_extent: for a NOCOW
> write disk_bytenr may either match the disk_bytenr of an existing file
> extent item or it's adjusted by some offset in case it covers only
> part of the extent item.

The NOCOW ordered extent would skip the file extent map updates, that's
why it doesn't really need an super accurate disk_bytenr/disk_num_bytes
to match data extents.

>
> So currently we are both consistent with btrfs_ordered_extent besides
> the fact the NOCOW checks are done against a file extent item.
>
> I particularly find block_start not intuitive - block? Is it a block
> number? What's the size of the block? Etc.
> disk_bytenr is a lot more clear - it's a disk address in bytes.

Well, the new @block_start matches the old extent_map::block_start.

I have to say, we do not have a solid definition on "disk_bytenr" in the
first place.

Should it always match ondisk file_extent_item::disk_bytenr, or should
it act like "block_start" of the old extent_map?

And if we have separate definitions, one to always match file extent
item disk_bytenr, and one to match the real IO start bytenr, what should
be their names?

I hope we can get a good naming to solve the confusion, any good idea?

Thanks,
Qu
>
>>
>> - Add extra comments explaining those members
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 51 ++++++++++++++++++++++++++++-------------------=
-
>>   1 file changed, 30 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 2e0156943c7c..4d207c3b38d9 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -1847,11 +1847,20 @@ struct can_nocow_file_extent_args {
>>           */
>>          bool free_path;
>>
>> -       /* Output fields. Only set when can_nocow_file_extent() returns=
 1. */
>> +       /*
>> +        * Output fields. Only set when can_nocow_file_extent() returns=
 1.
>> +        *
>> +        * @block_start:        The bytenr of the new nocow write shoul=
d be at.
>> +        * @orig_disk_bytenr:   The original data extent's disk_bytenr.
>
> This orig_disk_bytenr field is not defined anywhere in this patch.
>
> Thanks.
>
>> +        * @orig_disk_num_bytes:The original data extent's disk_num_byt=
es.
>> +        * @orig_offset:        The original offset inside the old data=
 extent.
>> +        *                      Caller should calculate their own
>> +        *                      btrfs_file_extent_item::offset base on =
this.
>> +        */
>>
>> -       u64 disk_bytenr;
>> -       u64 disk_num_bytes;
>> -       u64 extent_offset;
>> +       u64 block_start;
>> +       u64 orig_disk_num_bytes;
>> +       u64 orig_offset;
>>          /* Number of bytes that can be written to in NOCOW mode. */
>>          u64 num_bytes;
>>   };
>> @@ -1887,9 +1896,9 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>>                  goto out;
>>
>>          /* Can't access these fields unless we know it's not an inline=
 extent. */
>> -       args->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>> -       args->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(leaf,=
 fi);
>> -       args->extent_offset =3D btrfs_file_extent_offset(leaf, fi);
>> +       args->block_start =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>> +       args->orig_disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(=
leaf, fi);
>> +       args->orig_offset =3D btrfs_file_extent_offset(leaf, fi);
>>
>>          if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
>>              extent_type =3D=3D BTRFS_FILE_EXTENT_REG)
>> @@ -1906,7 +1915,7 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>>                  goto out;
>>
>>          /* An explicit hole, must COW. */
>> -       if (args->disk_bytenr =3D=3D 0)
>> +       if (args->block_start =3D=3D 0)
>>                  goto out;
>>
>>          /* Compressed/encrypted/encoded extents must be COWed. */
>> @@ -1925,8 +1934,8 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>>          btrfs_release_path(path);
>>
>>          ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
>> -                                   key->offset - args->extent_offset,
>> -                                   args->disk_bytenr, args->strict, pa=
th);
>> +                                   key->offset - args->orig_offset,
>> +                                   args->block_start, args->strict, pa=
th);
>>          WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>>          if (ret !=3D 0)
>>                  goto out;
>> @@ -1947,15 +1956,15 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>>              atomic_read(&root->snapshot_force_cow))
>>                  goto out;
>>
>> -       args->disk_bytenr +=3D args->extent_offset;
>> -       args->disk_bytenr +=3D args->start - key->offset;
>> +       args->block_start +=3D args->orig_offset;
>> +       args->block_start +=3D args->start - key->offset;
>>          args->num_bytes =3D min(args->end + 1, extent_end) - args->sta=
rt;
>>
>>          /*
>>           * Force COW if csums exist in the range. This ensures that cs=
ums for a
>>           * given extent are either valid or do not exist.
>>           */
>> -       ret =3D csum_exist_in_range(root->fs_info, args->disk_bytenr, a=
rgs->num_bytes,
>> +       ret =3D csum_exist_in_range(root->fs_info, args->block_start, a=
rgs->num_bytes,
>>                                    nowait);
>>          WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>>          if (ret !=3D 0)
>> @@ -2112,7 +2121,7 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>>                          goto must_cow;
>>
>>                  ret =3D 0;
>> -               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_arg=
s.disk_bytenr);
>> +               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_arg=
s.block_start);
>>                  if (!nocow_bg) {
>>   must_cow:
>>                          /*
>> @@ -2151,14 +2160,14 @@ static noinline int run_delalloc_nocow(struct b=
trfs_inode *inode,
>>                  nocow_end =3D cur_offset + nocow_args.num_bytes - 1;
>>                  is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTENT_P=
REALLOC;
>>                  if (is_prealloc) {
>> -                       u64 orig_start =3D found_key.offset - nocow_arg=
s.extent_offset;
>> +                       u64 orig_start =3D found_key.offset - nocow_arg=
s.orig_offset;
>>                          struct extent_map *em;
>>
>>                          em =3D create_io_em(inode, cur_offset, nocow_a=
rgs.num_bytes,
>>                                            orig_start,
>> -                                         nocow_args.disk_bytenr, /* bl=
ock_start */
>> +                                         nocow_args.block_start, /* bl=
ock_start */
>>                                            nocow_args.num_bytes, /* blo=
ck_len */
>> -                                         nocow_args.disk_num_bytes, /*=
 orig_block_len */
>> +                                         nocow_args.orig_disk_num_byte=
s, /* orig_block_len */
>>                                            ram_bytes, BTRFS_COMPRESS_NO=
NE,
>>                                            BTRFS_ORDERED_PREALLOC);
>>                          if (IS_ERR(em)) {
>> @@ -2171,7 +2180,7 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>>
>>                  ordered =3D btrfs_alloc_ordered_extent(inode, cur_offs=
et,
>>                                  nocow_args.num_bytes, nocow_args.num_b=
ytes,
>> -                               nocow_args.disk_bytenr, nocow_args.num_=
bytes, 0,
>> +                               nocow_args.block_start, nocow_args.num_=
bytes, 0,
>>                                  is_prealloc
>>                                  ? (1 << BTRFS_ORDERED_PREALLOC)
>>                                  : (1 << BTRFS_ORDERED_NOCOW),
>> @@ -7189,7 +7198,7 @@ noinline int can_nocow_extent(struct inode *inode=
, u64 offset, u64 *len,
>>          }
>>
>>          ret =3D 0;
>> -       if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
>> +       if (btrfs_extent_readonly(fs_info, nocow_args.block_start))
>>                  goto out;
>>
>>          if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
>> @@ -7206,9 +7215,9 @@ noinline int can_nocow_extent(struct inode *inode=
, u64 offset, u64 *len,
>>          }
>>
>>          if (orig_start)
>> -               *orig_start =3D key.offset - nocow_args.extent_offset;
>> +               *orig_start =3D key.offset - nocow_args.orig_offset;
>>          if (orig_block_len)
>> -               *orig_block_len =3D nocow_args.disk_num_bytes;
>> +               *orig_block_len =3D nocow_args.orig_disk_num_bytes;
>>
>>          *len =3D nocow_args.num_bytes;
>>          ret =3D 1;
>> --
>> 2.44.0
>>
>>
>

