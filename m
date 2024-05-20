Return-Path: <linux-btrfs+bounces-5128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B418D8CA462
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 00:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408591F22260
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 22:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9F13956D;
	Mon, 20 May 2024 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fCh3p0pY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78591CD3B
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716243229; cv=none; b=tuPqH6FJHC0M3Rdhv2g84jawiJloVrM0fXynQO7nuW94g/zhefcffyCDV64wSWB4FARPez077ucndzIZJWGzV7xXr2c015OgPZR41xvtARwxEwgrFBiULHMew3UOT+nmy0FZcBqArKZPXVNbNRjocCbQtD6sZZR3jXqB8sXLGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716243229; c=relaxed/simple;
	bh=s00nXwyqIETf/Vjjk9AeVawYtgmL0j3bDxG3gTMk+XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZFXumUBa2B8mYxBl+fz/I8byNZwdqLqlr/TC5ckzyDaTRgx8nwRPBrR8fi4DsjBwKwiS3YxPczhyVLoyoUcYfRZXgixrSCxR0BF+Rjhu+kUgXaNicl07PLSxVP9/EQEJwpRpKKk85vadhrruigrJwQWW2+Z6GOjRX5WYBOfX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fCh3p0pY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716243219; x=1716848019; i=quwenruo.btrfs@gmx.com;
	bh=tDpfY30Bz3PjgMnIPuyYLKupSI0377LdeIJ6Vq2/YSM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fCh3p0pYEiXmEP16ItGo4YcBAWDx9JLORKg0CbedRPTwFtuw4ALr6NKIKsbRFouw
	 3/mgOtTbhGhdhMJLVMFkBeE1kG7jaKsqLM7qeykm79XdoUh4HbtQDMTuAx8Pk/XJX
	 ccGpN9JbONxSkhoX+DfxOj2j26T7E4BHfJHvgONnJGvj7POoIUfITeqcS48zsq50T
	 nEWxO6+7Rt4jdOUBj5xsyBPwA66dP22PgkwoVKax/jLkqVXv5Dhn3E/HB0dFGqYnI
	 A4yzXR4n4hY1bimsF6cfBQWOl2tmL4Qzm8LX/blBw2ejNy68eacBAaa5a1BN4cgrc
	 lrhhwkCOVQPjVycRqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1roTcH0AsF-00JNgp; Tue, 21
 May 2024 00:13:39 +0200
Message-ID: <2bcd30f8-8bb5-4255-bc3a-69d347a27050@gmx.com>
Date: Tue, 21 May 2024 07:43:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] btrfs: cleanup duplicated parameters related to
 can_nocow_file_extent_args
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1714707707.git.wqu@suse.com>
 <5f31db841be606ec0bf8693377647f572ac9f4e7.1714707707.git.wqu@suse.com>
 <CAL3q7H63NVAS9Hy6mMZkU4mdBZvLrudWYkZ6eS=L8uH9rbJgfw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H63NVAS9Hy6mMZkU4mdBZvLrudWYkZ6eS=L8uH9rbJgfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SvC1dmi964MN528A2wNG1dPEWz83HJEG29hXlvg5XEFAHFhJJla
 K2J6HCQot1Zyx3++LmgGTW1TeHyTUgOHJc2CI24sVHAHFdZqUaxgYxLMUJO1HT9JIXrHzdA
 eJgYQSXYbZL3LGgC6oubfWfCJ+S/QBAROZxINsW4FYAhX9MW9E6E+h2wm7n4nJ3D1OMCozR
 1o7LzBvaNZhSTX27eQEeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wd0EDcgR6JA=;6JDMmxilVTSv8bK4q5PkRYLPytu
 4i+alu5ScKgHZ4zh4VKKtSMaQBwRxWBs66ClrrdsFxbx3+JB6hfOkQHTZfImCnFC4dDdxfQpr
 SCArXPD8gfb05JkhajdRmTUUJP27RnLF33JxeQfUrjLgNGcPp2i13sDNty56QmtPt23rBJ9PE
 TZ7B1YaHrOJ6JP5Olvwf6LPlT+M79VXw4rv3mE3YC8zkOnkNoSBHU1CUwAnJMd0NU4wvX4ftR
 VYvt/NKl2muMtdIeaYPgprU5PFy0gFKtPnbjRR7k8gcTExlazuNp655XLj4M//QOFEgr/FIhb
 8X2cD2xIoVZv7aavLddP38ULN2KGdMqsPYDaxtMosHz/TOx9e62732XdFBqUVd0mJ7pVKSgZP
 ssZ03zGAAXFlUi+sww6xAzx1nClX1JlusFO78hhLjxethYG/RWkTLN3TIjcrmvRjcPnpmDMtV
 XvU+GGxIOrGPRlHrWmSlOnA7+LVV/cL9mBdZL/kTOvb1q9ifO/4AZbAi+GZDlScEiF9PGFsaQ
 mxf42LKlT/SS7vTfwQVevXvdJYU/y4+bFt3+7LNDsWW6OUaMvfzdqZpKGbbDFgcLeisW0r2Qr
 dJGXjXQscpRm8S6lvQ4HBkmcQvyQ806Hwysk/iP5+52JU7SDAc+KpqAVZto2x0H3r8zN7SEuQ
 UEg9WqJFe4q4+isnF2xteZYixpKFQ8FHfn74m7hxr0vSS5mo0ov72SjYTKYRhLNtUfKfDQX5T
 3mhoqKs7NXVK4jhg3+RLPzep/k4/TYGYcIj1n8i6KsuOM1Pn0UubpK5uhDPMgoiYx3ZxK++pK
 f7Utz/bq7httPomczmsxCzUd91NuHt+3WekabN2b6ueGw=



=E5=9C=A8 2024/5/21 01:25, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
[...]
>> @@ -1926,7 +1916,7 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>>                  goto out;
>>
>>          /* An explicit hole, must COW. */
>> -       if (args->disk_bytenr =3D=3D 0)
>> +       if (btrfs_file_extent_disk_num_bytes(leaf, fi) =3D=3D 0)
>
> No, this is not correct.

All my bad, will fix it definitely.

> It's btrfs_file_extent_disk_bytenr() that we want, not
> btrfs_file_extent_disk_num_bytes().
> In fact a disk_num_bytes of 0 should ve invalid and never happen.

Thankfully for most cases, a explict hole has both its disk_num_bytes
and disk_bytenr as zeros, thus I didn't get any test case triggered:

	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 0 nr 0
		extent data offset 0 nr 65536 ram 65536
		extent compression 0 (none)

But still I should fix that.

Thanks,
Qu

>
>>                  goto out;
>>
>>          /* Compressed/encrypted/encoded extents must be COWed. */
>> @@ -1951,8 +1941,8 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>>          btrfs_release_path(path);
>>
>>          ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
>> -                                   key->offset - args->extent_offset,
>> -                                   args->disk_bytenr, args->strict, pa=
th);
>> +                                   key->offset - args->file_extent.off=
set,
>> +                                   args->file_extent.disk_bytenr, args=
->strict, path);
>>          WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>>          if (ret !=3D 0)
>>                  goto out;
>> @@ -1973,21 +1963,18 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>>              atomic_read(&root->snapshot_force_cow))
>>                  goto out;
>>
>> -       args->disk_bytenr +=3D args->extent_offset;
>> -       args->disk_bytenr +=3D args->start - key->offset;
>> -       args->num_bytes =3D min(args->end + 1, extent_end) - args->star=
t;
>> -
>> -       args->file_extent.num_bytes =3D args->num_bytes;
>> +       args->file_extent.num_bytes =3D min(args->end + 1, extent_end) =
- args->start;
>>          args->file_extent.offset +=3D args->start - key->offset;
>> +       io_start =3D args->file_extent.disk_bytenr + args->file_extent.=
offset;
>>
>>          /*
>>           * Force COW if csums exist in the range. This ensures that cs=
ums for a
>>           * given extent are either valid or do not exist.
>>           */
>>
>> -       csum_root =3D btrfs_csum_root(root->fs_info, args->disk_bytenr)=
;
>> -       ret =3D btrfs_lookup_csums_list(csum_root, args->disk_bytenr,
>> -                                     args->disk_bytenr + args->num_byt=
es - 1,
>> +       csum_root =3D btrfs_csum_root(root->fs_info, io_start);
>> +       ret =3D btrfs_lookup_csums_list(csum_root, io_start,
>> +                                     io_start + args->file_extent.num_=
bytes - 1,
>>                                        NULL, nowait);
>>          WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>>          if (ret !=3D 0)
>> @@ -2046,7 +2033,6 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>>                  struct extent_buffer *leaf;
>>                  struct extent_state *cached_state =3D NULL;
>>                  u64 extent_end;
>> -               u64 ram_bytes;
>>                  u64 nocow_end;
>>                  int extent_type;
>>                  bool is_prealloc;
>> @@ -2125,7 +2111,6 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>>                          ret =3D -EUCLEAN;
>>                          goto error;
>>                  }
>> -               ram_bytes =3D btrfs_file_extent_ram_bytes(leaf, fi);
>>                  extent_end =3D btrfs_file_extent_end(path);
>>
>>                  /*
>> @@ -2145,7 +2130,9 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>>                          goto must_cow;
>>
>>                  ret =3D 0;
>> -               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_arg=
s.disk_bytenr);
>> +               nocow_bg =3D btrfs_inc_nocow_writers(fs_info,
>> +                               nocow_args.file_extent.disk_bytenr +
>> +                               nocow_args.file_extent.offset);
>>                  if (!nocow_bg) {
>>   must_cow:
>>                          /*
>> @@ -2181,16 +2168,18 @@ static noinline int run_delalloc_nocow(struct b=
trfs_inode *inode,
>>                          }
>>                  }
>>
>> -               nocow_end =3D cur_offset + nocow_args.num_bytes - 1;
>> +               nocow_end =3D cur_offset + nocow_args.file_extent.num_b=
ytes - 1;
>>                  lock_extent(&inode->io_tree, cur_offset, nocow_end, &c=
ached_state);
>>
>>                  is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTENT_P=
REALLOC;
>>                  if (is_prealloc) {
>>                          struct extent_map *em;
>>
>> -                       em =3D create_io_em(inode, cur_offset, nocow_ar=
gs.num_bytes,
>> -                                         nocow_args.disk_num_bytes, /*=
 orig_block_len */
>> -                                         ram_bytes, BTRFS_COMPRESS_NON=
E,
>> +                       em =3D create_io_em(inode, cur_offset,
>> +                                         nocow_args.file_extent.num_by=
tes,
>> +                                         nocow_args.file_extent.disk_n=
um_bytes,
>> +                                         nocow_args.file_extent.ram_by=
tes,
>> +                                         BTRFS_COMPRESS_NONE,
>>                                            &nocow_args.file_extent,
>>                                            BTRFS_ORDERED_PREALLOC);
>>                          if (IS_ERR(em)) {
>> @@ -2203,9 +2192,16 @@ static noinline int run_delalloc_nocow(struct bt=
rfs_inode *inode,
>>                          free_extent_map(em);
>>                  }
>>
>> +               /*
>> +                * Check btrfs_create_dio_extent() for why we intention=
ally pass
>> +                * incorrect value for NOCOW/PREALLOC OEs.
>> +                */
>
> If in the next version you remove that similar comment/rant about OEs
> and disk_bytenr, also remove this one.
>
> Everything else in this patch looks fine, thanks.
>
>
>>                  ordered =3D btrfs_alloc_ordered_extent(inode, cur_offs=
et,
>> -                               nocow_args.num_bytes, nocow_args.num_by=
tes,
>> -                               nocow_args.disk_bytenr, nocow_args.num_=
bytes, 0,
>> +                               nocow_args.file_extent.num_bytes,
>> +                               nocow_args.file_extent.num_bytes,
>> +                               nocow_args.file_extent.disk_bytenr +
>> +                               nocow_args.file_extent.offset,
>> +                               nocow_args.file_extent.num_bytes, 0,
>>                                  is_prealloc
>>                                  ? (1 << BTRFS_ORDERED_PREALLOC)
>>                                  : (1 << BTRFS_ORDERED_NOCOW),
>> @@ -7144,8 +7140,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs=
_info *fs_info, u64 bytenr)
>>    *      any ordered extents.
>>    */
>>   noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *l=
en,
>> -                             u64 *orig_block_len,
>> -                             u64 *ram_bytes, struct btrfs_file_extent =
*file_extent,
>> +                             struct btrfs_file_extent *file_extent,
>>                                bool nowait, bool strict)
>>   {
>>          struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>> @@ -7196,8 +7191,6 @@ noinline int can_nocow_extent(struct inode *inode=
, u64 offset, u64 *len,
>>
>>          fi =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_=
extent_item);
>>          found_type =3D btrfs_file_extent_type(leaf, fi);
>> -       if (ram_bytes)
>> -               *ram_bytes =3D btrfs_file_extent_ram_bytes(leaf, fi);
>>
>>          nocow_args.start =3D offset;
>>          nocow_args.end =3D offset + *len - 1;
>> @@ -7215,14 +7208,15 @@ noinline int can_nocow_extent(struct inode *ino=
de, u64 offset, u64 *len,
>>          }
>>
>>          ret =3D 0;
>> -       if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
>> +       if (btrfs_extent_readonly(fs_info,
>> +                               nocow_args.file_extent.disk_bytenr + no=
cow_args.file_extent.offset))
>>                  goto out;
>>
>>          if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
>>              found_type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
>>                  u64 range_end;
>>
>> -               range_end =3D round_up(offset + nocow_args.num_bytes,
>> +               range_end =3D round_up(offset + nocow_args.file_extent.=
num_bytes,
>>                                       root->fs_info->sectorsize) - 1;
>>                  ret =3D test_range_bit_exists(io_tree, offset, range_e=
nd, EXTENT_DELALLOC);
>>                  if (ret) {
>> @@ -7231,13 +7225,11 @@ noinline int can_nocow_extent(struct inode *ino=
de, u64 offset, u64 *len,
>>                  }
>>          }
>>
>> -       if (orig_block_len)
>> -               *orig_block_len =3D nocow_args.disk_num_bytes;
>>          if (file_extent)
>>                  memcpy(file_extent, &nocow_args.file_extent,
>>                         sizeof(struct btrfs_file_extent));
>>
>> -       *len =3D nocow_args.num_bytes;
>> +       *len =3D nocow_args.file_extent.num_bytes;
>>          ret =3D 1;
>>   out:
>>          btrfs_free_path(path);
>> @@ -7422,7 +7414,7 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>>          struct btrfs_file_extent file_extent =3D { 0 };
>>          struct extent_map *em =3D *map;
>>          int type;
>> -       u64 block_start, orig_block_len, ram_bytes;
>> +       u64 block_start;
>>          struct btrfs_block_group *bg;
>>          bool can_nocow =3D false;
>>          bool space_reserved =3D false;
>> @@ -7450,7 +7442,6 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>>                  block_start =3D extent_map_block_start(em) + (start - =
em->start);
>>
>>                  if (can_nocow_extent(inode, start, &len,
>> -                                    &orig_block_len, &ram_bytes,
>>                                       &file_extent, false, false) =3D=
=3D 1) {
>>                          bg =3D btrfs_inc_nocow_writers(fs_info, block_=
start);
>>                          if (bg)
>> @@ -7477,8 +7468,8 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>>                  space_reserved =3D true;
>>
>>                  em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_da=
ta, start, len,
>> -                                             orig_block_len,
>> -                                             ram_bytes, type,
>> +                                             file_extent.disk_num_byte=
s,
>> +                                             file_extent.ram_bytes, ty=
pe,
>>                                                &file_extent);
>>                  btrfs_dec_nocow_writers(bg);
>>                  if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
>> @@ -10709,7 +10700,7 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
>>                  free_extent_map(em);
>>                  em =3D NULL;
>>
>> -               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL=
, NULL, false, true);
>> +               ret =3D can_nocow_extent(inode, start, &len, NULL, fals=
e, true);
>>                  if (ret < 0) {
>>                          goto out;
>>                  } else if (ret) {
>> --
>> 2.45.0
>>
>>
>

