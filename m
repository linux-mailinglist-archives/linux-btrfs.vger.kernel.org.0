Return-Path: <linux-btrfs+bounces-4766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF098BC713
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 07:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126CBB20C05
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE747F4A;
	Mon,  6 May 2024 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pZbe1Poc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22722B9C4
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974102; cv=none; b=TPt/DnR2Daqe/3Yszl1oUbW+MBqgbn7q5z1Y/4REdT33vUx6mm//mbYwBsM5s0bCWDXfhKEFFP6Avm5+j2D9UtAQWzcEfzxemVxg4GplJ2Amwb+O6fnYwrOyN2SD75/iawfNn0YXCnsxcu1Vu2kwDVYft9pQBjFi/5zZsIwQ+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974102; c=relaxed/simple;
	bh=E3x5IZnUPqmiHpXZzfhKjdWDD4n3BYBrZoHlayqZ9Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX7TGC2jvCOWXzT/mSBJoPR2qbt6DBs+k878tt4ZrQy9mu+WjGTzCqYImUbbcjP2Gn3NEArAe04Sv4R/YbqfI5gfJCdKbvrJsdSb7vf2XbBSgN9koweEph+slQPSyr84VsLjPgKL2J4ai3ktqK/fXfqM93ug5/1rW8Y3DGD6kn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pZbe1Poc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714974092; x=1715578892; i=quwenruo.btrfs@gmx.com;
	bh=JULG+Qd3RVavNroaANFSQU39J7pxcL2tNRpLUm5vaXk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pZbe1Poc6f7tTMEP3FLJAWOAcI6P3sK/HNEd7pve+opVlPWRfPBOF4TSmPyexkxt
	 xvasUkuNsWn5fy/xScGFbjDmlNWxShmMVJVpGP+8tGkPS3MR6DyZ2W562OB8XKpHW
	 qVM6g9xw+gPKAlfxyx4YaqOSOXxS6MDMJCAUiGwddXzh5qByczChp6WagxSpGVPyf
	 K19Ejqc9cE7CoxJ8ZmfEEFnj9ZBPh7omW5I8RseanMfwTwBd3e8AcNfepx45sIigv
	 fS9wWMAK2VylY/rCkQOsvTjnDVHzfrLPaV+S3LXnXNhxGuetJ1TzCg0U3ZeffQDrY
	 hw6ZCAEsOLElKjjQKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQjH-1rpngk3Co9-00GoHP; Mon, 06
 May 2024 07:41:32 +0200
Message-ID: <4c6ce351-e1fe-483a-8a9b-a1abb2324ea1@gmx.com>
Date: Mon, 6 May 2024 15:11:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
References: <cover.1714963428.git.anand.jain@oracle.com>
 <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
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
In-Reply-To: <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sL/OMb6jAfDcprT/ELaAPC+EEhorolHn0kIwjg0rrwp9BYVSJ7v
 AvJ82q2caLtwM5sVEJNmH8HHX4QLeur9ttPm4pCGkzZURE8bqB4ce73w8SUkXhgAw2ptrZq
 YF3kPF87Ggeq7GIBDKw+SSNLttPBPvpyu06YTPeK0Dw+0VA9HZoiPZQuolWr26QyPEUEn1J
 WAnpy1FjLnUnQP9H0HFQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3mvJ0Ioey2s=;plqEbegcEEwfwwyr62FLYh4ER6g
 MO/+ArjhwxdjplObdY07UTFyjUn5fw4KV3uMNnTOKXlzoJP1IXxEnpXfwFccIYfQEAY2GM0Fp
 YqVXWTKGWeQtTnAsD1aKmNFAvPjuUMilnqY8arl0mHD9b+eDo5vptdlhntx+WXbtRPIr14VMk
 T3gN4nnJ/WO22raPBqeLvUHWVfCWx7c3VfFmz6GMzM6ydiWU/piJh1xU+c88T217bMlZZUYN7
 mvwsnnbdGWI3j5t+J+4uhELt0UPQqFshdyaWw840yLGXuOMEObVGTYAigDoPy6esmCm2qSvyK
 LBrrEdtub9t6adP/+cYzflGVrMqbFu+gjsEULiY8bZEEgeKHGB6QXq1qCBAXqxREuFR6TRG02
 X4GTUQ2Yjh75k/lrOukSHerinYi6vpYWscTU4vHLZhHA9d6BhsMceyz/ckio9lxCEd5Kb3J50
 Q4TgPVGNQZ9WzFrlKFTh9+i2LRrJoeksEbctP0DIa5HMH9itVduWFlzO5qy2SMf0NeFCrTzh9
 j1rjXkeq7DaYq6UAPUD238Z4eyoHcGQXsMe5VA85/Yawemjyz8qVKC4QrkDGge4pS8779Q+Xj
 ifvAW7anCZCddIOz7NvnGdo9r5z14fojT8rVg8doGf2u4XRmq+SHxm3sV+v5gLQNDNpAhYAjS
 HHMdb31mEZmLWzLND/92u5Q23UcG9sRpp7MMp8p79BspL73JiKzEK/ErI1rs/2F/qBliL4/Bf
 PUoCgs06vQ7brde6AflBJPI4YkJS8XocIXN4ZnWndcLd8OfGfW7Xl5IJWlOCzV+NIzFv7m6PL
 h/msq6YBtPokE/y5kBwkLcTYcZwffW+aPvty8rEh98n/0=



=E5=9C=A8 2024/5/6 12:34, Anand Jain =E5=86=99=E9=81=93:
> This patch, along with the dependent patches below, adds support for
> ext4 unmerged  unwritten file extents as preallocated file extent in btr=
fs.
>
>   btrfs-progs: convert: refactor ext2_create_file_extents add argument e=
xt2_inode
>   btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file =
inode pointers
>   btrfs-progs: convert: refactor __btrfs_record_file_extent to add a pre=
alloc flag
>
> The patch is developed with POV of portability with the current
> e2fsprogs library.
>
> This patch will handle independent unwritten extents by marking them wit=
h prealloc
> flag and will identify merged unwritten extents, triggering a fail.
>
> Testcase:
>
>       $ dd if=3D/dev/urandom of=3D/mnt/test/foo bs=3D4K count=3D1 conv=
=3Dfsync status=3Dnone
>       $ dd if=3D/dev/urandom of=3D/mnt/test/foo bs=3D4K count=3D2 conv=
=3Dfsync seek=3D1 status=3Dnone
>       $ xfs_io -f -c 'falloc -k 12K 12K' /mnt/test/foo
>       $ dd if=3D/dev/zero of=3D/mnt/test/foo bs=3D4K count=3D1 conv=3Dfs=
ync seek=3D6 status=3Dnone
>
>       $ filefrag -v /mnt/test/foo
>       Filesystem type is: ef53
>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
> 	 ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
> 	   0:        0..       0:      33280..     33280:      1:
> 	   1:        1..       2:      33792..     33793:      2:      33281:
> 	   2:        3..       5:      33281..     33283:      3:      33794: u=
nwritten
> 	   3:        6..       6:      33794..     33794:      1:      33284: l=
ast,eof
>
>       $ sha256sum /mnt/test/foo
>       18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  =
/mnt/test/foo
>
>     Convert and compare the checksum
>
>     Before:
>
>       $ filefrag -v /mnt/test/foo
>       Filesystem type is: 9123683e
>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>        ext:     logical_offset:        physical_offset: length:   expect=
ed: flags:
>        0:        0..       0:      33280..     33280:      1:           =
  shared
>        1:        1..       2:      33792..     33793:      2:      33281=
: shared
>        2:        3..       6:      33281..     33284:      4:      33794=
: last,shared,eof
>       /mnt/test/foo: 3 extents found
>
>       $ sha256sum /mnt/test/foo
>       6874a1733e5785682210d69c07f256f684cf5433c7235ed29848b4a4d52030e0  =
/mnt/test/foo
>
>     After:
>
>       $ filefrag -v /mnt/test/foo
>       Filesystem type is: 9123683e
>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
> 	 ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
> 	   0:        0..       0:      33280..     33280:      1:             s=
hared
> 	   1:        1..       2:      33792..     33793:      2:      33281: s=
hared
> 	   2:        3..       5:      33281..     33283:      3:      33794: u=
nwritten,shared
> 	   3:        6..       6:      33794..     33794:      1:      33284: l=
ast,shared,eof
>       /mnt/test/foo: 4 extents found
>
>       $ sha256sum /mnt/test/foo
>       18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  =
/mnt/test/foo
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>
> . Remove RFC
> . Identify the block with a merged preallocated extent and call fail-saf=
e
> . Qu has an idea that it could be marked as a hole, which may be based o=
n
>    top of this patch.

Well, my idea of going holes other than preallocated extents is mostly
to avoid the extra @prealloc flag parameter.

But that's not a big deal for now, as I found the following way to
easily crack your v2 patchset:

  # fallocate -l 1G test.img
  # mkfs.ext4 -F test.img
  # mount test.img $mnt
  # xfs_io -f -c "falloc 0 16K" $mnt/file
  # sync
  # xfs_io -f -c "pwrite 0 4k" -c "pwrite 12k 4k" $mnt/file
  # umount $mnt
  # ./btrfs-convert test.img
btrfs-convert from btrfs-progs v6.8

Source filesystem:
   Type:           ext2
   Label:
   Blocksize:      4096
   UUID:           0f98aa2a-b1ee-4e91-8815-9b9a7b4af00a
Target filesystem:
   Label:
   Blocksize:      4096
   Nodesize:       16384
   UUID:           3b8db399-8e25-495b-a41c-47afcb672020
   Checksum:       crc32c
   Features:       extref, skinny-metadata, no-holes, free-space-tree
(default)
     Data csum:    yes
     Inline data:  yes
     Copy xattr:   yes
Reported stats:
   Total space:      1073741824
   Free space:        872349696 (81.24%)
   Inode count:           65536
   Free inodes:           65523
   Block count:          262144
Create initial btrfs filesystem
Create ext2 image file
Create btrfs metadata
ERROR: inode 13 index 0: identified unsupported merged block length 1
wanted 4
ERROR: failed to copy ext2 inode 13: -22
ERROR: error during copy_inodes -22
WARNING: error during conversion, the original filesystem is not modified

[...]
> +
> +	memset(&extent, 0, sizeof(struct ext2fs_extent));
> +	if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
> +		error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
> +		       src->ext2_ino);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	if (extent.e_pblk !=3D data->disk_block) {
> +	error("inode %d index %d found wrong extent e_pblk %llu wanted disk_bl=
ock %llu",
> +		       src->ext2_ino, index, extent.e_pblk, data->disk_block);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	if (extent.e_len !=3D data->num_blocks) {
> +	error("inode %d index %d: identified unsupported merged block length %=
u wanted %llu",
> +			src->ext2_ino, index, extent.e_len, data->num_blocks);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}

You have to split the extent in this case. As the example I gave, part
of the extent can have been written.
(And I'm not sure if the e_pblk check is also correct)

I believe the example I gave could be a pretty good test case.
(Or you can go one step further to interleave every 4K)

Thanks,
Qu

> +
> +	if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
> +		*has_unwritten =3D true;
> +
> +	return 0;
> +}
> +
>   static int ext2_dir_iterate_proc(ext2_ino_t dir, int entry,
>   			    struct ext2_dir_entry *dirent,
>   			    int offset, int blocksize,
> diff --git a/convert/source-ext2.h b/convert/source-ext2.h
> index 026a7cad8ac8..19014d3c25e6 100644
> --- a/convert/source-ext2.h
> +++ b/convert/source-ext2.h
> @@ -82,6 +82,9 @@ struct ext2_source_fs {
>   	ext2_ino_t ext2_ino;
>   };
>
> +int ext2_find_unwritten(struct blk_iterate_data *data, int index,
> +			bool *has_unwritten);
> +
>   #define EXT2_ACL_VERSION	0x0001
>
>   #endif	/* BTRFSCONVERT_EXT2 */
> diff --git a/convert/source-fs.c b/convert/source-fs.c
> index df5ce66caf7f..88a6ceaf41f6 100644
> --- a/convert/source-fs.c
> +++ b/convert/source-fs.c
> @@ -31,6 +31,7 @@
>   #include "common/extent-tree-utils.h"
>   #include "convert/common.h"
>   #include "convert/source-fs.h"
> +#include "convert/source-ext2.h"
>
>   const struct simple_range btrfs_reserved_ranges[3] =3D {
>   	{ 0,			     SZ_1M },
> @@ -239,6 +240,15 @@ fail:
>   	return ret;
>   }
>
> +int find_prealloc(struct blk_iterate_data *data, int index,
> +		  bool *has_prealloc)
> +{
> +	if (data->source_fs)
> +		return ext2_find_unwritten(data, index, has_prealloc);
> +
> +	return -EINVAL;
> +}
> +
>   /*
>    * Record a file extent in original filesystem into btrfs one.
>    * The special point is, old disk_block can point to a reserved range.
> @@ -257,6 +267,7 @@ int record_file_blocks(struct blk_iterate_data *data=
,
>   	u64 old_disk_bytenr =3D disk_block * sectorsize;
>   	u64 num_bytes =3D num_blocks * sectorsize;
>   	u64 cur_off =3D old_disk_bytenr;
> +	int index =3D data->first_block;
>
>   	/* Hole, pass it to record_file_extent directly */
>   	if (old_disk_bytenr =3D=3D 0)
> @@ -276,6 +287,16 @@ int record_file_blocks(struct blk_iterate_data *dat=
a,
>   		u64 extent_num_bytes;
>   		u64 real_disk_bytenr;
>   		u64 cur_len;
> +		u64 flags =3D BTRFS_FILE_EXTENT_REG;
> +		bool has_prealloc =3D false;
> +
> +		if (find_prealloc(data, index, &has_prealloc)) {
> +			data->errcode =3D -1;
> +			return -EINVAL;
> +		}
> +
> +		if (has_prealloc)
> +			flags =3D BTRFS_FILE_EXTENT_PREALLOC;
>
>   		key.objectid =3D data->convert_ino;
>   		key.type =3D BTRFS_EXTENT_DATA_KEY;
> @@ -316,12 +337,12 @@ int record_file_blocks(struct blk_iterate_data *da=
ta,
>   			      old_disk_bytenr + num_bytes) - cur_off;
>   		ret =3D btrfs_record_file_extent(data->trans, data->root,
>   					data->objectid, data->inode, file_pos,
> -					real_disk_bytenr, cur_len,
> -					BTRFS_FILE_EXTENT_REG);
> +					real_disk_bytenr, cur_len, flags);
>   		if (ret < 0)
>   			break;
>   		cur_off +=3D cur_len;
>   		file_pos +=3D cur_len;
> +		index++;
>
>   		/*
>   		 * No need to care about csum
> diff --git a/convert/source-fs.h b/convert/source-fs.h
> index 25916c65681b..db7ead422585 100644
> --- a/convert/source-fs.h
> +++ b/convert/source-fs.h
> @@ -153,5 +153,6 @@ int read_disk_extent(struct btrfs_root *root, u64 by=
tenr,
>   		            u32 num_bytes, char *buffer);
>   int record_file_blocks(struct blk_iterate_data *data,
>   			      u64 file_block, u64 disk_block, u64 num_blocks);
> +int find_prealloc(struct blk_iterate_data *data, int index, bool *has_p=
realloc);
>
>   #endif

