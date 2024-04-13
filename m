Return-Path: <linux-btrfs+bounces-4206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE28A3C30
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829FDB20B1F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504BC3A8D8;
	Sat, 13 Apr 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LuaSkTrX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2B2C9D
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003348; cv=none; b=gKTrWaA+w6dIA11hu2pIuWctRNPzCVLcrL8UUxVIkYgT38CJVBrABNUsL4Xd3xSRSIG3JjmWtkK6RVI5yRBGbFIBHoDxjajcuL1l5hyzvgy14ZdU9kxxGJU1CtkZRwo6vTncLUbzQcKBVIosHCo96GMwmvgxkCVF/SKr8p6uduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003348; c=relaxed/simple;
	bh=7kC23WCw54X8c0QdgQuRG7v3Wpa09jmvrry3j2VLmCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lgYjm1JMIyR5EIIqGtgJfvM+EJUpBPKVaq05lFHV2boEt3nW5yn8458qxPzl0yic6BdB0vTLXrf21J0TAUoX4Gu1jv98Rc2kKQ1QZgJ1QApvkvm1VsSBFMo2dnSI+hlSTJT552ncJ1lUJQxDlFK3pzQYivcnIc40npZTY47RKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LuaSkTrX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713003340; x=1713608140; i=quwenruo.btrfs@gmx.com;
	bh=dRVnlJ8Te1mQwoPKnQHsJ6dm1AvrjPt9MLYDEJfx7NU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LuaSkTrX18Kb0Mx59sF0s2Q5S0Msbssxyd0b/FoRm2o5d8CnAA3CcYrXlht7ztjO
	 iSTkQwTkrgrpsZNULB1248R6wiYtTEuHk9CHN3htW9wvI1kTgAlLU+3PG6HetgLRm
	 aes1gWOScWdiBKIXsyUPkWxF6/STzibJolkDb79aQE6V2EfpKfjqUx4QQmcF6Ke98
	 bd/tRQz/8xdgQgLvRRLmQWASyksoMdk6XWaQ4JjUUO3pNvgGN1xalKJeuzLibU2W6
	 b4m+im+js846CeBgqTdKJ5C6jM/wf/5P0JMzOzK5sNiXBHWetdW0uJY2qzWw2tIfY
	 UuT1JhCaK9kyvJlfZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQe5u-1s9Fev2BoU-00Netw; Sat, 13
 Apr 2024 12:15:40 +0200
Message-ID: <635d44e0-6c38-41e1-9b3e-3ac457b918ea@gmx.com>
Date: Sat, 13 Apr 2024 19:45:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] btrfs: make NOCOW checks for existence of checksums
 in a range more efficient
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712933003.git.fdmanana@suse.com>
 <72cd9b16a1c670d4139bb10f6f13eb76f92c3fed.1712933006.git.fdmanana@suse.com>
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
In-Reply-To: <72cd9b16a1c670d4139bb10f6f13eb76f92c3fed.1712933006.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGmfovbtiQygQ79bKKhIY3+83b1GW1M9PyRuQWMMz6S+OW3MVsN
 AayC+m+sbxWaykuJI9iAJJ7dgs+WdRh2DRJoJqAz/FEjt6bhfFPD8XyYE8wvJ7jMR1vES66
 8lcdZYwvdiv5FZ5oZDWZrx1Gsukdn+RarZmxF0n2PPAfwyGt8vEbn5EwU3+5cL0IfLlGTmX
 PMc4ACzV2I3wCe7tCj5Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IRFqMz9WzN0=;FpOp0W6Yqb/kn0SsQ4GDrIqVjD0
 pNHHQzwJvvol2akFKrNUlT+CPZI786LHQgLpnRnJc4yvxNCilWffvHEMksk9kJmcjcwdBe0G2
 2rTW8ecj5J645O6mdQGTH3pClbD/wz01GyF47WVWnkFfxbgv/KjgUImLXtpxdRR8oVr8SOCuW
 92+0Ne89mYFYK6TnyLmEoxMMNTRxNAcSRVbRnVxVO0SBAURMUI6/Rt/tWfVEw7FtOyDAC+hP9
 QVdPsG58OV4Qq1V5YetDlCVN9xnXILIMVHkJI8jc00zBB0UM9oP9ufr66wP/0lrvzkKHlYqva
 nZimQFNp4xpsCyx/9Dvv0ndgTa59brzYd26zpcrAnxiS5qYkUJSLpQgd8WtLnZuwGFchYm7o+
 RfsWbh9smdiMdNtstOS6+2jJNAfS1mdjNX/9hNivEgDCrGnaRu0fSSa2BU9Bu/shQmlajc+DR
 TkSihR52tqnhhcGMuDsiCVgNnZIZWivxBtObEnpTo1RkvXraTl81cFgW1KQg0PtWY0gHLv0r3
 3GDqkoO1CN0Zt3Ig9JNfquNgPGoITRnTfS+Fa3OExy2tpl1gZ/gA1KNh7CfFuM1uUyP9r0J2d
 eOQrxGMhiGdkLP3zhN2y1h4mi1t05Zqk9YBNlplx371RN3G2dMezxRhgUJXz5rD1jRKNp/q6m
 Fo7fHzVaAl54uM4cZEjlZ2PCoz0zbrNy4ZzsCz83rqRYkcSeqejKiPnlagk6/kmLvDUmH59Ce
 iD0h8HsbmM0jwnZpqxrYx7gaG/njGjbo6Vj5F+ST5+7I1E8RY3lR3qTH71wjpreiDrFKxYCwn
 hP0wrYiyF/KDyCOETRjqANGf2GKR3rwzML+5dS/iDqxrs=



=E5=9C=A8 2024/4/13 00:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Before deciding if we can do a NOCOW write into a range, one of the thin=
gs
> we have to do is check if there are checksum items for that range. We do
> that through the btrfs_lookup_csums_list() function, which searches for
> checksums and adds them to a list supplied by the caller.
>
> But all we need is to check if there is any checksum, we don't need to
> look for all of them and collect them into a list, which requires more
> search time in the checksums tree, allocating memory for checksums items
> to add to the list, copy checksums from a leaf into those list items,
> then free that memory, etc. This is all unnecessary overhead, wasting
> mostly CPU time, and perhaps some occasional IO if we need to read from
> disk any extent buffers.
>
> So change btrfs_lookup_csums_list() to allow to return immediately in
> case it finds any checksum, without the need to add it to a list and rea=
d
> it from a leaf. This is accomplised by allowing a NULL list parameter an=
d
> making the function return 1 if it found any checksum, 0 if it didn't
> found any, and a negative value in case of an error.
>
> The following test with fio was used to measure performance:
>
>    $ cat test.sh
>    #!/bin/bash
>
>    DEV=3D/dev/nullb0
>    MNT=3D/mnt/nullb0
>
>    cat <<EOF > /tmp/fio-job.ini
>    [global]
>    name=3Dfio-rand-write
>    filename=3D$MNT/fio-rand-write
>    rw=3Drandwrite
>    bssplit=3D4k/20:8k/20:16k/20:32k/20:64k/20
>    direct=3D1
>    numjobs=3D16
>    fallocate=3Dposix
>    time_based
>    runtime=3D300
>
>    [file1]
>    size=3D8G
>    ioengine=3Dio_uring
>    iodepth=3D16
>    EOF
>
>    umount $MNT &> /dev/null
>    mkfs.btrfs -f $DEV
>    mount -o ssd $DEV $MNT
>
>    fio /tmp/fio-job.ini
>    umount $MNT
>
> The test was run on a release kernel (Debian's default kernel config).
>
> The results before this patch:
>
>    WRITE: bw=3D139MiB/s (146MB/s), 8204KiB/s-9504KiB/s (8401kB/s-9732kB/=
s), io=3D17.0GiB (18.3GB), run=3D125317-125344msec
>
> The results after this patch:
>
>    WRITE: bw=3D153MiB/s (160MB/s), 9241KiB/s-10.0MiB/s (9463kB/s-10.5MB/=
s), io=3D17.0GiB (18.3GB), run=3D114054-114071msec
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/file-item.c  | 25 ++++++++++++++++++-------
>   fs/btrfs/inode.c      | 18 ++----------------
>   fs/btrfs/relocation.c |  2 +-
>   fs/btrfs/tree-log.c   |  9 ++++++---
>   4 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 231abcc87f63..1ea1ed44fe42 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -457,9 +457,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio=
 *bbio)
>    * @start:		Logical address of target checksum range.
>    * @end:		End offset (inclusive) of the target checksum range.
>    * @list:		List for adding each checksum that was found.
> + *			Can be NULL in case the caller only wants to check if
> + *			there any checksums for the range.
>    * @nowait:		Indicate if the search must be non-blocking or not.
>    *
> - * Return < 0 on error and 0 on success.
> + * Return < 0 on error, 0 if no checksums were found, or 1 if checksums=
 were
> + * found.
>    */
>   int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 en=
d,
>   			    struct list_head *list, bool nowait)
> @@ -471,6 +474,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root,=
 u64 start, u64 end,
>   	struct btrfs_ordered_sum *sums;
>   	struct btrfs_csum_item *item;
>   	int ret;
> +	bool found_csums =3D false;
>
>   	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>   	       IS_ALIGNED(end + 1, fs_info->sectorsize));
> @@ -544,6 +548,10 @@ int btrfs_lookup_csums_list(struct btrfs_root *root=
, u64 start, u64 end,
>   			continue;
>   		}
>
> +		found_csums =3D true;
> +		if (!list)
> +			goto out;
> +
>   		csum_end =3D min(csum_end, end + 1);
>   		item =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>   				      struct btrfs_csum_item);
> @@ -575,17 +583,20 @@ int btrfs_lookup_csums_list(struct btrfs_root *roo=
t, u64 start, u64 end,
>   		}
>   		path->slots[0]++;
>   	}
> -	ret =3D 0;
>   out:
> +	btrfs_free_path(path);
>   	if (ret < 0) {
> -		struct btrfs_ordered_sum *tmp_sums;
> +		if (list) {
> +			struct btrfs_ordered_sum *tmp_sums;
>
> -		list_for_each_entry_safe(sums, tmp_sums, list, list)
> -			kfree(sums);
> +			list_for_each_entry_safe(sums, tmp_sums, list, list)
> +				kfree(sums);
> +		}
> +
> +		return ret;
>   	}
>
> -	btrfs_free_path(path);
> -	return ret;
> +	return found_csums ? 1 : 0;
>   }
>
>   /*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4e67470d847a..1d78e07d082b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1741,23 +1741,9 @@ static noinline int csum_exist_in_range(struct bt=
rfs_fs_info *fs_info,
>   					u64 bytenr, u64 num_bytes, bool nowait)
>   {
>   	struct btrfs_root *csum_root =3D btrfs_csum_root(fs_info, bytenr);
> -	struct btrfs_ordered_sum *sums;
> -	int ret;
> -	LIST_HEAD(list);
> -
> -	ret =3D btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes =
- 1,
> -				      &list, nowait);
> -	if (ret =3D=3D 0 && list_empty(&list))
> -		return 0;
>
> -	while (!list_empty(&list)) {
> -		sums =3D list_entry(list.next, struct btrfs_ordered_sum, list);
> -		list_del(&sums->list);
> -		kfree(sums);
> -	}
> -	if (ret < 0)
> -		return ret;
> -	return 1;
> +	return btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes -=
 1,
> +				       NULL, nowait);
>   }
>
>   static int fallback_to_cow(struct btrfs_inode *inode, struct page *loc=
ked_page,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4e60364b5289..5a01aaa164de 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4392,7 +4392,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_e=
xtent *ordered)
>   	ret =3D btrfs_lookup_csums_list(csum_root, disk_bytenr,
>   				      disk_bytenr + ordered->num_bytes - 1,
>   				      &list, false);
> -	if (ret)
> +	if (ret < 0)
>   		return ret;
>
>   	while (!list_empty(&list)) {
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index e9ad2971fc7c..3c86fcebafc6 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -798,8 +798,9 @@ static noinline int replay_one_extent(struct btrfs_t=
rans_handle *trans,
>   			ret =3D btrfs_lookup_csums_list(root->log_root,
>   						csum_start, csum_end - 1,
>   						&ordered_sums, false);
> -			if (ret)
> +			if (ret < 0)
>   				goto out;
> +			ret =3D 0;
>   			/*
>   			 * Now delete all existing cums in the csum root that
>   			 * cover our range. We do this because we can have an
> @@ -4461,8 +4462,9 @@ static noinline int copy_items(struct btrfs_trans_=
handle *trans,
>   		ret =3D btrfs_lookup_csums_list(csum_root, disk_bytenr,
>   					      disk_bytenr + extent_num_bytes - 1,
>   					      &ordered_sums, false);
> -		if (ret)
> +		if (ret < 0)
>   			goto out;
> +		ret =3D 0;
>
>   		list_for_each_entry_safe(sums, sums_next, &ordered_sums, list) {
>   			if (!ret)
> @@ -4656,8 +4658,9 @@ static int log_extent_csums(struct btrfs_trans_han=
dle *trans,
>   	ret =3D btrfs_lookup_csums_list(csum_root, em->block_start + csum_off=
set,
>   				      em->block_start + csum_offset +
>   				      csum_len - 1, &ordered_sums, false);
> -	if (ret)
> +	if (ret < 0)
>   		return ret;
> +	ret =3D 0;
>
>   	while (!list_empty(&ordered_sums)) {
>   		struct btrfs_ordered_sum *sums =3D list_entry(ordered_sums.next,

