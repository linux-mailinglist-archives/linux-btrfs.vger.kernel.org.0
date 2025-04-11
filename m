Return-Path: <linux-btrfs+bounces-12954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74AFA854E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD9E4C114F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 07:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010E1EFF9F;
	Fri, 11 Apr 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fdX2mtla"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AC1372
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354985; cv=none; b=ofDG3Fk1dz3wukyUarNHl2NrA6KdfivekoW6D/d9NK46+O9KnFxExtjrlZFx4sgJOHd4pkYmMOHMT2FA3/c8PnLG6yQrUyiEhmka65pk2J4HRYoq45KwPTVg7CIO7jexKmkNA3lR/xm1qB92JAZTlFtQsuQDfujsOYyzT9/1ZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354985; c=relaxed/simple;
	bh=W/AnPPjJQ2K/pVfNOKCPe0zLDMDFiMEpO5OfTL5ngN0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=N8NJ+lG6fs9iCfF0WM4DKmiEJD9nbjiw1huCH4vgoYBrmzUwcTowGQqyomUDxVCLUE6idPVHXnjhJzILfm99upkfLStzzmG/TpGRxsNYkr0CzywkSiaPQ5f0zpZvozpSZOe7osBQwdWeU7ymtsKWaNUDbK+FoJF1ZtkBxtdMHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fdX2mtla; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1efc457bso985912f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744354981; x=1744959781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPVRz7X0r+NBioVgSPMXtBD3Rna+sgT5w7axnqpiJJw=;
        b=fdX2mtla3fanwAlKmkuKwrH1DvvOLBrcpMgtR13vn0lLDesrrQmbQWt0ofde67EYlD
         jlmP+shC/5ESnQxs6fbbdhg3V8NuUmeqqTyxrUxA5LDVaLGsHqlBTCBkoJHBug/nRCeg
         9dVoRJzV4XvQ9uZHPjSidAPOGxXsAJEN9Z8WbfN3FBGmsT/t70Zy4io/vojsW4EE7uYx
         xuH0TIxdCqwAzl2W1UvIZaYYwNc6fh/8tH4rbEYHDKxTBD0iDiEV0Ws2jOnySv8x46KN
         CX8yi1nSjG1v6OYl0MyJGi1XEBxG/hgEhZW5HDcoUDYG2lYai8f+2TojPfOEn5jB6tK9
         9iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354981; x=1744959781;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPVRz7X0r+NBioVgSPMXtBD3Rna+sgT5w7axnqpiJJw=;
        b=gATTnCFbOWDYv3qvfuBzipo23dJC3lCgRrb6VDRqwC3JCZbzCG1u1EQBiKmU+hxD3h
         HeoLc+D6TE1pPhZYeJ9ZtpBYrxOtcbVd6h9PXs16ifbBH1ozPiPfqJCF4yBeTRdHIpwq
         ApQeqgq+d5rszZ6pUvmOMUQvHw7mX1TorCLv9wuwwNpy8KBvTv5WNYKOzq7fu0lsfI3o
         U2+HdWG030tkSSmH8EVIv4D6F+XiK4HBZpJXIEq1nTMTnYQITDNXuB6mxsB82PlY45yD
         gb4jZoNeoeK7B/S9Cj3MkyRXTQb1UL14TU9fhLDFDaMPg7CZGI0Cd1BepMbbh5mALSVQ
         pFvw==
X-Gm-Message-State: AOJu0YxkTesqwWqMOg8SH7kzMyTV3u/meK/KtRWtYDzlFML8pEhsoOnG
	t/uwWmoADPOuKEoXlZHkxAgTjf2ZjYU/4V7IEbGnymlWEpsX2rv3DLRlEg6nNGXAyxnNUmi6xz5
	a
X-Gm-Gg: ASbGncstXISRNz4jvDE6iQEkQTJJZ9lsqQTUCHa+oxNl1PJWncH6pPTgjybHouWKYMT
	MrHulODfihS7H90V3LbAxIBe645CtneDbmLaClzHoOjxHIFV/tU8tVF1QxzhCdz4IbEsmwNYkWY
	QYq+IePHJ88wljWafsZaAkl1XfXWOHNHUQr82IUAVk1+TbTj94u0XeDNfESjJFXU5VWbYODdZuM
	9PTBGRngaOepDVZN215Ozq85W9dy6jqc/IWT1LPUW2JA9h7NBvWHNPnGaU9xgx4Q1sO+QK+X2MC
	5DaqHg683t50v/ycA1NMB9zDKaqh3YaOwebjks7/0PI/YaeQ5i2xn+CFmdo6fzdZQniD
X-Google-Smtp-Source: AGHT+IFbFdFZ+njQADXvThAtFqPkXxdOaPKr+2zgdcPfI1KZHIkqBg0nWZg15682I4NT0RE8sov76g==
X-Received: by 2002:a5d:584f:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-39eaaecaa9dmr936624f8f.48.1744354980272;
        Fri, 11 Apr 2025 00:03:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de7e4asm4083353a12.28.2025.04.11.00.02.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 00:02:59 -0700 (PDT)
Message-ID: <c118af0d-aec0-4bac-85b1-b280cfc971b7@suse.com>
Date: Fri, 11 Apr 2025 16:32:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: make btrfs_truncate_block() to zero involved
 blocks in a folio
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1744344865.git.wqu@suse.com>
 <158513ddd60a56c01e9404919a40b8739fc80d83.1744344865.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <158513ddd60a56c01e9404919a40b8739fc80d83.1744344865.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/11 14:44, Qu Wenruo 写道:
> [BUG]
> The following fsx sequence will fail on btrfs with 64K page size and 4K
> fs block size:
> 
>   #fsx -d -e 1 -N 4 $mnt/junk -S 36386
>   READ BAD DATA: offset = 0xe9ba, size = 0x6dd5, fname = /mnt/btrfs/junk
>   OFFSET      GOOD    BAD     RANGE
>   0xe9ba      0x0000  0x03ac  0x0
>   operation# (mod 256) for the bad data may be 3
>   ...
>   LOG DUMP (4 total operations):
>   1(  1 mod 256): WRITE    0x6c62 thru 0x1147d	(0xa81c bytes) HOLE	***WWWW
>   2(  2 mod 256): TRUNCATE DOWN	from 0x1147e to 0x5448	******WWWW
>   3(  3 mod 256): ZERO     0x1c7aa thru 0x28fe2	(0xc839 bytes)
>   4(  4 mod 256): MAPREAD  0xe9ba thru 0x1578e	(0x6dd5 bytes)	***RRRR***
> 
> [CAUSE]
> Only 2 operations are really involved in this case:
> 
>   3 pollute_eof	0x5448 thru	0xffff	(0xabb8 bytes)
>   3 zero	from 0x1c7aa to 0x28fe3, (0xc839 bytes)
>   4 mapread	0xe9ba thru	0x1578e	(0x6dd5 bytes)
> 
> At operation 3, fsx pollutes beyond EOF, that is done by mmap()
> and write into that mmap() range beyondd EOF.
> 
> Such write will fill the range beyond EOF, but it will never reach disk
> as ranges beyond EOF will not be marked dirty nor uptodate.
> 
> Then we zero_range for [0x1c7aa, 0x28fe3], and since the range is beyond
> our isize (which was 0x5448), we should zero out any range beyond
> EOF (0x5448).
> 
> During btrfs_zero_range(), we call btrfs_truncate_block() to dirty the
> unaligned head block.
> But that function only really zero out the block at [0x5000, 0x5fff], it
> doesn't bother any range other that that block, since those range will
> not be marked dirty nor written back.
> 
> So the range [0x6000, 0xffff] is still polluted, and later mapread()
> will return the poisoned value.
> 
> Such behavior is only exposed when page size is larger than fs block
> btrfs, as for block size == page size case the block is exactly one
> page, and fsx only checks exactly one page at EOF.
> 
> [FIX]
> Enhance btrfs_truncate_block() by:
> 
> - Force callers to pass a @start/@end combination
>    So that there will be no 0 length passed in.
> 
> - Rename the @front parameter to an enum
>    And make it matches the @start/@end parameter better by using
>    TRUNCATE_HEAD_BLOCK and TRUNCATE_TAIL_BLOCK instead.
> 
> - Pass the original unmodified range into btrfs_truncate_block()
>    There are several call sites inside btrfs_zero_range() and
>    btrfs_punch_hole() where we pass part of the original range for
>    truncating.
> 
>    This hides the original range which can lead to under or over
>    truncating.
>    Thus we have to pass the original zero/punch range.
> 
> - Make btrfs_truncate_block() to zero any involved blocks inside the folio
>    Since we have the original range, we know exactly which range inside
>    the folio that should be zeroed.
> 
>    It may cover other blocks other than the one with data space reserved,
>    but that's fine, the zeroed range will not be written back anyway.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/btrfs_inode.h | 10 +++++--
>   fs/btrfs/file.c        | 33 ++++++++++++++-------
>   fs/btrfs/inode.c       | 65 +++++++++++++++++++++++++++---------------
>   3 files changed, 73 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 4e2952cf5766..21b005ddf42c 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -547,8 +547,14 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
>   		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
>   		   const struct fscrypt_str *name, int add_backref, u64 index);
>   int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry);
> -int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
> -			 int front);
> +
> +enum btrfs_truncate_where {
> +	BTRFS_TRUNCATE_HEAD_BLOCK,
> +	BTRFS_TRUNCATE_TAIL_BLOCK,
> +};
> +int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
> +			 u64 orig_start, u64 orig_end,
> +			 enum btrfs_truncate_where where);
>   
>   int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
>   int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e3fea1db4304..55fa91799fb6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2616,7 +2616,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>   	u64 lockend;
>   	u64 tail_start;
>   	u64 tail_len;
> -	u64 orig_start = offset;
> +	const u64 orig_start = offset;
> +	const u64 orig_end = offset + len - 1;
>   	int ret = 0;
>   	bool same_block;
>   	u64 ino_size;
> @@ -2659,7 +2660,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>   		if (offset < ino_size) {
>   			truncated_block = true;
>   			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,

This is a bug, since the 3rd parameter is the inclusive end now, it 
should be "offset + len - 1".

This leads to generic/008 failure on x86_64.> -						   0);
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_HEAD_BLOCK);
>   		} else {
>   			ret = 0;
>   		}
> @@ -2669,7 +2671,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>   	/* zero back part of the first block */
>   	if (offset < ino_size) {
>   		truncated_block = true;
> -		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
> +		ret = btrfs_truncate_block(BTRFS_I(inode), offset, -1,
> +					   orig_start, orig_end,
> +					   BTRFS_TRUNCATE_HEAD_BLOCK);
>   		if (ret) {
>   			btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
>   			return ret;
> @@ -2706,8 +2710,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>   			if (tail_start + tail_len < ino_size) {
>   				truncated_block = true;
>   				ret = btrfs_truncate_block(BTRFS_I(inode),
> -							tail_start + tail_len,
> -							0, 1);
> +						tail_start, tail_start + tail_len - 1,
> +						orig_start, orig_end,
> +						BTRFS_TRUNCATE_TAIL_BLOCK);
>   				if (ret)
>   					goto out_only_mutex;
>   			}
> @@ -2875,6 +2880,8 @@ static int btrfs_zero_range(struct inode *inode,
>   	int ret;
>   	u64 alloc_hint = 0;
>   	const u64 sectorsize = fs_info->sectorsize;
> +	const u64 orig_start = offset;
> +	const u64 orig_end = offset + len - 1;
>   	u64 alloc_start = round_down(offset, sectorsize);
>   	u64 alloc_end = round_up(offset + len, sectorsize);
>   	u64 bytes_to_reserve = 0;
> @@ -2938,7 +2945,8 @@ static int btrfs_zero_range(struct inode *inode,
>   		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
>   			free_extent_map(em);
>   			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,

The same here.

The idea of changing @len to @end seems cursed, but there seems to be no 
better solution than this.

Will get them fixed in the next update.

Thanks,
Qu

> -						   0);
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_HEAD_BLOCK);
>   			if (!ret)
>   				ret = btrfs_fallocate_update_isize(inode,
>   								   offset + len,
> @@ -2969,7 +2977,9 @@ static int btrfs_zero_range(struct inode *inode,
>   			alloc_start = round_down(offset, sectorsize);
>   			ret = 0;
>   		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
> -			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
> +			ret = btrfs_truncate_block(BTRFS_I(inode), offset, -1,
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_HEAD_BLOCK);
>   			if (ret)
>   				goto out;
>   		} else {
> @@ -2986,8 +2996,9 @@ static int btrfs_zero_range(struct inode *inode,
>   			alloc_end = round_up(offset + len, sectorsize);
>   			ret = 0;
>   		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
> -			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
> -						   0, 1);
> +			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_TAIL_BLOCK);
>   			if (ret)
>   				goto out;
>   		} else {
> @@ -3107,7 +3118,9 @@ static long btrfs_fallocate(struct file *file, int mode,
>   		 * need to zero out the end of the block if i_size lands in the
>   		 * middle of a block.
>   		 */
> -		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
> +		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, -1,
> +					   inode->i_size, -1,
> +					   BTRFS_TRUNCATE_HEAD_BLOCK);
>   		if (ret)
>   			goto out;
>   	}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e283627c087d..0700a161b80e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4782,15 +4782,16 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
>    *
>    * @inode - inode that we're zeroing
>    * @from - the offset to start zeroing
> - * @len - the length to zero, 0 to zero the entire range respective to the
> - *	offset
> - * @front - zero up to the offset instead of from the offset on
> + * @end - the inclusive end to finish zeroing, can be -1 meaning truncating
> + *	  everything beyond @from.
> + * @where - Head or tail block to truncate.
>    *
>    * This will find the block for the "from" offset and cow the block and zero the
>    * part we want to zero.  This is used with truncate and hole punching.
>    */
> -int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
> -			 int front)
> +int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
> +			 u64 orig_start, u64 orig_end,
> +			 enum btrfs_truncate_where where)
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct address_space *mapping = inode->vfs_inode.i_mapping;
> @@ -4800,20 +4801,30 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>   	struct extent_changeset *data_reserved = NULL;
>   	bool only_release_metadata = false;
>   	u32 blocksize = fs_info->sectorsize;
> -	pgoff_t index = from >> PAGE_SHIFT;
> -	unsigned offset = from & (blocksize - 1);
> +	pgoff_t index = (where == BTRFS_TRUNCATE_HEAD_BLOCK) ?
> +			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
>   	struct folio *folio;
>   	gfp_t mask = btrfs_alloc_write_mask(mapping);
>   	size_t write_bytes = blocksize;
>   	int ret = 0;
>   	u64 block_start;
>   	u64 block_end;
> +	u64 clamp_start;
> +	u64 clamp_end;
>   
> -	if (IS_ALIGNED(offset, blocksize) &&
> -	    (!len || IS_ALIGNED(len, blocksize)))
> +	ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK ||
> +	       where == BTRFS_TRUNCATE_TAIL_BLOCK);
> +
> +	if (end == (loff_t)-1)
> +		ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK);
> +
> +	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize))
>   		goto out;
>   
> -	block_start = round_down(from, blocksize);
> +	if (where == BTRFS_TRUNCATE_HEAD_BLOCK)
> +		block_start = round_down(from, blocksize);
> +	else
> +		block_start = round_down(end, blocksize);
>   	block_end = block_start + blocksize - 1;
>   
>   	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
> @@ -4893,17 +4904,22 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>   		goto out_unlock;
>   	}
>   
> -	if (offset != blocksize) {
> -		if (!len)
> -			len = blocksize - offset;
> -		if (front)
> -			folio_zero_range(folio, block_start - folio_pos(folio),
> -					 offset);
> -		else
> -			folio_zero_range(folio,
> -					 (block_start - folio_pos(folio)) + offset,
> -					 len);
> -	}
> +	/*
> +	 * Although we have only reserved space for the one block, we still should
> +	 * zero out all blocks in the original range.
> +	 * The remaining blocks normally are already holes thus no need to zero again,
> +	 * but it's possible for fs block size < page size cases to have memory mapped
> +	 * writes to pollute ranges beyond EOF.
> +	 *
> +	 * In that case although the polluted blocks beyond EOF will not reach disk,
> +	 * it still affects our page cache.
> +	 */
> +	clamp_start = max_t(u64, folio_pos(folio), orig_start);
> +	clamp_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
> +			  orig_end);
> +	folio_zero_range(folio, clamp_start - folio_pos(folio),
> +			 clamp_end - clamp_start + 1);
> +
>   	btrfs_folio_clear_checked(fs_info, folio, block_start,
>   				  block_end + 1 - block_start);
>   	btrfs_folio_set_dirty(fs_info, folio, block_start,
> @@ -5005,7 +5021,8 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
>   	 * rest of the block before we expand the i_size, otherwise we could
>   	 * expose stale data.
>   	 */
> -	ret = btrfs_truncate_block(inode, oldsize, 0, 0);
> +	ret = btrfs_truncate_block(inode, oldsize, -1, oldsize, -1,
> +				   BTRFS_TRUNCATE_HEAD_BLOCK);
>   	if (ret)
>   		return ret;
>   
> @@ -7649,7 +7666,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
>   		btrfs_end_transaction(trans);
>   		btrfs_btree_balance_dirty(fs_info);
>   
> -		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, 0, 0);
> +		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, -1,
> +					   inode->vfs_inode.i_size, -1,
> +					   BTRFS_TRUNCATE_HEAD_BLOCK);
>   		if (ret)
>   			goto out;
>   		trans = btrfs_start_transaction(root, 1);


