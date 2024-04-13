Return-Path: <linux-btrfs+bounces-4203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B898A3C1E
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2571F22139
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B086239FD5;
	Sat, 13 Apr 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bZBhhwCv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D32137F
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003056; cv=none; b=oSjI7B1d5Zoh7XF1nUBRU4hjJzwlP/JOS3zaUe5uDsjfyeCRnXxc8f7GXspfb0ULa3pCWqsf0Ond1z6UrzdMS2SOAfLHbkm65hY9qKIyYU0jUrmPzRDRmhMOBPNk8VqiF3OyKNgQJOBjV1vZyiAzqdaJ8qzefDfXiEv+EnBhhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003056; c=relaxed/simple;
	bh=CZxJGy+YRa3kWGHzFQ2c98fPqiJDUazGP6HhIyBC3LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G8xIzp2DzPmB4r1laXKvRjlXbbunmEu8GLmrL8x5OGpSHz41q7zirV5alPwCustRYUuPOIvVBwPjYGsIPvzjWKxwvmu/2elQMYSGsFo2dziIY043N6tPcIR3QohmwSaY8TmPxaXfH+IKHhAg2gkSeqCd/nZo5Spw00JSgOzJujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bZBhhwCv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713003048; x=1713607848; i=quwenruo.btrfs@gmx.com;
	bh=+hrzcLDc5R5DTcOENeAdy6H5vL/ofGwIgSBmwcwM7Wc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bZBhhwCv5LVH2c2iVZZrhauS47iWWa8JX/Imsu1+2wX9bjMjPYh1138Ju+Xd7XaD
	 J5514Qembb02ddOOD8QrtfDbIE9H1jY4EmhFUlyCyJQs334dLOZbNud5PVPuM5Bc9
	 NpHD7cKeEM1MRTLjIsLkybeWuV3F4O6LoYOqcVxlYx71ith49dfr6zjgIhzXLIWEh
	 MeD8dPDTTIqfUwlZFi+6bgpnfHF7VrVLd5QZGzt5s9wq/T+ca/P9LT7hk8OeAk0BR
	 x3/TFYp60nMo829DFIHC8QUnwFA+uJGucUBUTfzUpTEXktMZ1jlKLisc/ZiJMfs8/
	 Cf0+SkFWWrxkUGDJjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1s2D6e01H6-00B7uw; Sat, 13
 Apr 2024 12:10:48 +0200
Message-ID: <29f7eeb7-b5db-4a98-983c-800898735354@gmx.com>
Date: Sat, 13 Apr 2024 19:40:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] btrfs: remove search_commit parameter from
 btrfs_lookup_csums_list()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712933003.git.fdmanana@suse.com>
 <8f31c8dcf6d09d42079b9bb4164a87450d2f0adf.1712933005.git.fdmanana@suse.com>
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
In-Reply-To: <8f31c8dcf6d09d42079b9bb4164a87450d2f0adf.1712933005.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HtzKvfFba1PIV/n+x6HVEw0qbQAavdVdAzNCy1l0QfkV2vuABTw
 FYa6Cf0E2LVndzAZz38XVihZvjtd0UfYcACgELZxG/VIsydPCzT7+6Cx/Zo3yradCNSfupE
 HkilUG1EafXQW7hshx3UPpmOvJKjYm7dQnIzle8yrgZKd2g772MAZF5yCAaDAUtF7wS34s3
 iNxR8KwyjF4nvDCLG0oxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OozBUkUF+hk=;4AHJo2VKO34d+yASwOubFGPz3gl
 OnewoGi9WbXya0LLYjS2KPhM1ZFXLHxF4REdBZ7a4blXDerV/NQv4JplL7cVrwn3Gjj0dmhIs
 gg4FyTJqw7m212dnYxRSIi+H9+e4kA/fKesow9q6yg/M53zPKkRqQ295saoCSsXZnyBhUdU/t
 bSVqBa/L0Q3QnWZiUSDK4ZjLCKsYiR8jb3KcOFAtCG48oVolAHRgmKitdJPUkfHNaHhi3mWe3
 z4uMyuL51NlTVVuCPi0IdOqTjEAolfPCMXwhGyIB/XvB3r9VRaifLSrNqVZRcRRB08jP5gzbU
 qSsSW0jA/Mwm6aZjTncDxY32tuCS4ccbluTDZC51xaH29H3Aq+wRzEY+ab9P5pSq9TdL1J3BS
 RN4vaOg9jq8Vi/+1uNQtCbiHVRpIOuvDK+dX4OMqzO1Swl7ZH1BwwRApQMdbd5OHC0CLop9S1
 NCyxTzZM9jVhiyp8TbHcaJ5AIPpwb1XUKs/tmDURifAhho0+NUmS4dXCBxbGt9aroYIR+eByg
 HZiw//he4GzaiMi08RwpdkSuiPvnNdFgPmVOUfTkjwODrgWTdRn2SS+OIgaGFarPxd8RzchhV
 btBC7XdcTCL+4rySeDzsGJb6HPjhd5icQqTT6qBdrSPsrXZ0a7SXbmCZnHrJ6EGV+jZ1ebR1C
 yAdevyKG6aXRBgKXLi3gbGgaBOzjHFSRve5dxZimb9bw8k2ciFMuYIULGJEHIv6t5E4fWoGU5
 0c8SHc9Pam4l6CginUx4J2capr2feYb9scCMKW6B1zty7lEXkX4k57omsLSInlHrxOnKNo5ht
 zI4bnex7ELO61oDDoh/f7alXuyly9NMbjqhw/qQtzejpA=



=E5=9C=A8 2024/4/13 00:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> All the callers of btrfs_lookup_csums_list() pass a value of 0 as the
> "search_commit" parameter. So remove it and make the function behave as
> to always search from the regular root.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

The last user of search_commit was removed in commit 5dc96f8d5de9
("btrfs: scrub: remove scrub_parity structure"), as we migrate to a
bitmap based solution.

Thanks,
Qu
> ---
>   fs/btrfs/file-item.c  | 10 +---------
>   fs/btrfs/file-item.h  |  3 +--
>   fs/btrfs/inode.c      |  2 +-
>   fs/btrfs/relocation.c |  2 +-
>   fs/btrfs/tree-log.c   |  6 +++---
>   5 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 909438540119..0712a0aa2dd0 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -457,15 +457,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bi=
o *bbio)
>    * @start:		Logical address of target checksum range.
>    * @end:		End offset (inclusive) of the target checksum range.
>    * @list:		List for adding each checksum that was found.
> - * @search_commit:	Indicate if the commit root of the @root should be u=
sed
> - *			for the search.
>    * @nowait:		Indicate if the search must be non-blocking or not.
>    *
>    * Return < 0 on error and 0 on success.
>    */
>   int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 en=
d,
> -			    struct list_head *list, int search_commit,
> -			    bool nowait)
> +			    struct list_head *list, bool nowait)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_key key;
> @@ -484,11 +481,6 @@ int btrfs_lookup_csums_list(struct btrfs_root *root=
, u64 start, u64 end,
>   		return -ENOMEM;
>
>   	path->nowait =3D nowait;
> -	if (search_commit) {
> -		path->skip_locking =3D 1;
> -		path->reada =3D READA_FORWARD;
> -		path->search_commit_root =3D 1;
> -	}
>
>   	key.objectid =3D BTRFS_EXTENT_CSUM_OBJECTID;
>   	key.offset =3D start;
> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> index 15c05cc0fce6..557dc43d7142 100644
> --- a/fs/btrfs/file-item.h
> +++ b/fs/btrfs/file-item.h
> @@ -68,8 +68,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, =
u64 start, u64 end,
>   			     struct list_head *list, int search_commit,
>   			     bool nowait);
>   int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 en=
d,
> -			    struct list_head *list, int search_commit,
> -			    bool nowait);
> +			    struct list_head *list, bool nowait);
>   int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_pa=
th *path,
>   			      u64 start, u64 end, u8 *csum_buf,
>   			      unsigned long *csum_bitmap);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2dae4e975e80..4e67470d847a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1746,7 +1746,7 @@ static noinline int csum_exist_in_range(struct btr=
fs_fs_info *fs_info,
>   	LIST_HEAD(list);
>
>   	ret =3D btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes=
 - 1,
> -				      &list, 0, nowait);
> +				      &list, nowait);
>   	if (ret =3D=3D 0 && list_empty(&list))
>   		return 0;
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5b19b41f64a2..4e60364b5289 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4391,7 +4391,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_e=
xtent *ordered)
>
>   	ret =3D btrfs_lookup_csums_list(csum_root, disk_bytenr,
>   				      disk_bytenr + ordered->num_bytes - 1,
> -				      &list, 0, false);
> +				      &list, false);
>   	if (ret)
>   		return ret;
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 4a4fca841510..e9ad2971fc7c 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -797,7 +797,7 @@ static noinline int replay_one_extent(struct btrfs_t=
rans_handle *trans,
>
>   			ret =3D btrfs_lookup_csums_list(root->log_root,
>   						csum_start, csum_end - 1,
> -						&ordered_sums, 0, false);
> +						&ordered_sums, false);
>   			if (ret)
>   				goto out;
>   			/*
> @@ -4460,7 +4460,7 @@ static noinline int copy_items(struct btrfs_trans_=
handle *trans,
>   		disk_bytenr +=3D extent_offset;
>   		ret =3D btrfs_lookup_csums_list(csum_root, disk_bytenr,
>   					      disk_bytenr + extent_num_bytes - 1,
> -					      &ordered_sums, 0, false);
> +					      &ordered_sums, false);
>   		if (ret)
>   			goto out;
>
> @@ -4655,7 +4655,7 @@ static int log_extent_csums(struct btrfs_trans_han=
dle *trans,
>   	csum_root =3D btrfs_csum_root(trans->fs_info, em->block_start);
>   	ret =3D btrfs_lookup_csums_list(csum_root, em->block_start + csum_off=
set,
>   				      em->block_start + csum_offset +
> -				      csum_len - 1, &ordered_sums, 0, false);
> +				      csum_len - 1, &ordered_sums, false);
>   	if (ret)
>   		return ret;
>

