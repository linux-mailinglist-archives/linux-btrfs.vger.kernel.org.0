Return-Path: <linux-btrfs+bounces-18592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8CAC2D5AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 18:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4671A1885A63
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38831B117;
	Mon,  3 Nov 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="ZN3raJg4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8D31A7F7
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189289; cv=none; b=uJtD1DSHV7lfxdpnb31jTFDt4FP1xQJh+CB3P+pzOCRmNebOUY/Ifqkf8/ojXduD7DLWgs0j1fX/Ru284toEs7X4LZXaQE7lik5GRHDvDTelXQttBzbKC+hAXaASY+j7hNjt04I1eNm3nv4Vqxvqt2uxkuqB9EiErQilIAg7UwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189289; c=relaxed/simple;
	bh=dfdrk8mSR1eAvaRIrFRDDQvTVPXfXGckGACEBnCR28k=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y07kzhr5z7HgFT4CdPkklbzOSb+buYDqKlP+8xhC7qo2YPf1G2G86LmZioGXFYuuh14fpQwRjRhLOwWomsBqWgZsHZJpINSLRJL7KaPfMMAlwfFeBJV7nZzMKu5ff0JKORnt+rTUMFYwXGI+z9YiHqHjqi0FEnDN6o7D5/LabNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=ZN3raJg4; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 17CAE2D5548;
	Mon,  3 Nov 2025 17:01:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762189283;
	bh=oz4aKvJbG0gfJ4rJ2A3JqxhZoR1Glw7MNPaSzC7X9Yc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZN3raJg4j6ipV+YVDKpt0EioD0q1R9J3bauMdwAPDeUH2Q+XNdjxdS6WSpuAjEK3J
	 WT4alMu/tmZQ46U5D/hggt0JuFzaWUZsB4ZCfBMvV/bNhYLZzSl5VYGZeWwyfjmndH
	 2vc0BZio4Ef7NYhYsWwJ8CCifu52fHShA79IxwZY=
Message-ID: <e39be7bb-c37e-4585-95bb-c0c09f7ee2c2@harmstone.com>
Date: Mon, 3 Nov 2025 17:01:22 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block
 groups
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-16-mark@harmstone.com>
 <aQU0CDKWD4LoXdCB@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 xsBNBFp/GMsBCACtFsuHZqHWpHtHuFkNZhMpiZMChyou4X8Ueur3XyF8KM2j6TKkZ5M/72qT
 EycEM0iU1TYVN/Rb39gBGtRclLFVY1bx4i+aUCzh/4naRxqHgzM2SeeLWHD0qva0gIwjvoRs
 FP333bWrFKPh5xUmmSXBtBCVqrW+LYX4404tDKUf5wUQ9bQd2ItFRM2mU/l6TUHVY2iMql6I
 s94Bz5/Zh4BVvs64CbgdyYyQuI4r2tk/Z9Z8M4IjEzQsjSOfArEmb4nj27R3GOauZTO2aKlM
 8821rvBjcsMk6iE/NV4SPsfCZ1jvL2UC3CnWYshsGGnfd8m2v0aLFSHZlNd+vedQOTgnABEB
 AAHNI01hcmsgSGFybXN0b25lIDxtYXJrQGhhcm1zdG9uZS5jb20+wsCRBBMBCAA7AhsvBQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheAFiEEG2JgKYgV0WRwIJAqbKyhHeAWK+0FAmRQOkICGQEA
 CgkQbKyhHeAWK+22wgf/dBOJ0pHdkDi5fNmWynlxteBsy3VCo0qC25DQzGItL1vEY95EV4uX
 re3+6eVRBy9gCKHBdFWk/rtLWKceWVZ86XfTMHgy+ZnIUkrD3XZa3oIV6+bzHgQ15rXXckiE
 A5N+6JeY/7hAQpSh/nOqqkNMmRkHAZ1ZA/8KzQITe1AEULOn+DphERBFD5S/EURvC8jJ5hEr
 lQj8Tt5BvA57sLNBmQCE19+IGFmq36EWRCRJuH0RU05p/MXPTZB78UN/oGT69UAIJAEzUzVe
 sN3jiXuUWBDvZz701dubdq3dEdwyrCiP+dmlvQcxVQqbGnqrVARsGCyhueRLnN7SCY1s5OHK
 ls7ATQRafxjLAQgAvkcSlqYuzsqLwPzuzoMzIiAwfvEW3AnZxmZn9bQ+ashB9WnkAy2FZCiI
 /BPwiiUjqgloaVS2dIrVFAYbynqSbjqhki+uwMliz7/jEporTDmxx7VGzdbcKSCe6rkE/72o
 6t7KG0r55cmWnkdOWQ965aRnRAFY7Zzd+WLqlzeoseYsNj36RMaqNR7aL7x+kDWnwbw+jgiX
 tgNBcnKtqmJc04z/sQTa+sUX53syht1Iv4wkATN1W+ZvQySxHNXK1r4NkcDA9ZyFA3NeeIE6
 ejiO7RyC0llKXk78t0VQPdGS6HspVhYGJJt21c5vwSzIeZaneKULaxXGwzgYFTroHD9n+QAR
 AQABwsGsBBgBCAAgFiEEG2JgKYgV0WRwIJAqbKyhHeAWK+0FAlp/GMsCGy4BQAkQbKyhHeAW
 K+3AdCAEGQEIAB0WIQR6bEAu0hwk2Q9ibSlt5UHXRQtUiwUCWn8YywAKCRBt5UHXRQtUiwdE
 B/9OpyjmrshY40kwpmPwUfode2Azufd3QRdthnNPAY8Tv9erwsMS3sMh+M9EP+iYJh+AIRO7
 fDN/u0AWIqZhHFzCndqZp8JRYULnspXSKPmVSVRIagylKew406XcAVFpEjloUtDhziBN7ykk
 srAMoLASaBHZpAfp8UAGDrr8Fx1on46rDxsWbh1K1h4LEmkkVooDELjsbN9jvxr8ym8Bkt54
 FcpypTOd8jkt/lJRvnKXoL3rZ83HFiUFtp/ZkveZKi53ANUaqy5/U5v0Q0Ppz9ujcRA9I/V3
 B66DKMg1UjiigJG6espeIPjXjw0n9BCa9jqGICyJTIZhnbEs1yEpsM87eUIH/0UFLv0b8IZe
 pL/3QfiFoYSqMEAwCVDFkCt4uUVFZczKTDXTFkwm7zflvRHdy5QyVFDWMyGnTN+Bq48Gwn1M
 uRT/Sg37LIjAUmKRJPDkVr/DQDbyL6rTvNbA3hTBu392v0CXFsvpgRNYaT8oz7DDBUUWj2Ny
 6bZCBtwr/O+CwVVqWRzKDQgVo4t1xk2ts1F0R1uHHLsX7mIgfXBYdo/y4UgFBAJH5NYUcBR+
 QQcOgUUZeF2MC9i0oUaHJOIuuN2q+m9eMpnJdxVKAUQcZxDDvNjZwZh+ejsgG4Ejd2XR/T0y
 XFoR/dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
In-Reply-To: <aQU0CDKWD4LoXdCB@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2025 10.11 pm, Boris Burkov wrote:
> On Fri, Oct 24, 2025 at 07:12:16PM +0100, Mark Harmstone wrote:
>> Discard normally works by iterating over the free-space entries of a
>> block group. This doesn't work for fully-remapped block groups, as we
>> removed their free-space entries when we started relocation.
>>
>> For sync discard, call btrfs_discard_extent() when we commit the
>> transaction in which the last identity remap was removed.
>>
>> For async discard, add a new function btrfs_trim_fully_remapped_block_group()
>> to be called by the discard worker, which iterates over the block
>> group's range using the normal async discard rules. Once we reach the
>> end, remove the chunk's stripes and device extents to get back its free
>> space.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c      |  2 ++
>>   fs/btrfs/block-group.h      |  1 +
>>   fs/btrfs/discard.c          | 57 ++++++++++++++++++++++++++----
>>   fs/btrfs/extent-tree.c      | 10 ++++++
>>   fs/btrfs/free-space-cache.c | 70 +++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/free-space-cache.h |  1 +
>>   6 files changed, 134 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 8feddb472882..0c91553b02cf 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -4833,4 +4833,6 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>>   
>>   	spin_unlock(&fs_info->unused_bgs_lock);
>>   
>> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
>> +		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
>>   }
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 4522074a45c2..b0b16efea19a 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -49,6 +49,7 @@ enum btrfs_discard_state {
>>   	BTRFS_DISCARD_EXTENTS,
>>   	BTRFS_DISCARD_BITMAPS,
>>   	BTRFS_DISCARD_RESET_CURSOR,
>> +	BTRFS_DISCARD_FULLY_REMAPPED,
>>   };
>>   
>>   /*
>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
>> index ee5f5b2788e1..f9890037395a 100644
>> --- a/fs/btrfs/discard.c
>> +++ b/fs/btrfs/discard.c
>> @@ -215,6 +215,27 @@ static struct btrfs_block_group *find_next_block_group(
>>   	return ret_block_group;
>>   }
>>   
>> +/*
>> + * Returns whether a block group is empty.
>> + *
>> + * @block_group: block_group of interest
>> + *
>> + * "Empty" here means that there are no extents physically located within the
>> + * device extents corresponding to this block group.
>> + *
>> + * For a remapped block group, this means that all of its identity remaps have
>> + * been removed. For a non-remapped block group, this means that no extents
>> + * have an address within its range, and that nothing has been remapped to be
>> + * within it.
>> + */
>> +static bool block_group_is_empty(struct btrfs_block_group *block_group)
>> +{
>> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)
>> +		return block_group->identity_remap_count == 0;
>> +	else
>> +		return block_group->used == 0 && block_group->remap_bytes == 0;
>> +}
>> +
>>   /*
>>    * Look up next block group and set it for use.
>>    *
>> @@ -241,8 +262,10 @@ static struct btrfs_block_group *peek_discard_list(
>>   	block_group = find_next_block_group(discard_ctl, now);
>>   
>>   	if (block_group && now >= block_group->discard_eligible_time) {
>> +		bool empty = block_group_is_empty(block_group);
>> +
>>   		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
>> -		    block_group->used != 0) {
>> +		    !empty) {
>>   			if (btrfs_is_block_group_data_only(block_group)) {
>>   				__add_to_discard_list(discard_ctl, block_group);
>>   				/*
>> @@ -267,7 +290,15 @@ static struct btrfs_block_group *peek_discard_list(
>>   		}
>>   		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
>>   			block_group->discard_cursor = block_group->start;
>> -			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
>> +
>> +			if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +			    empty) {
>> +				block_group->discard_state =
>> +					BTRFS_DISCARD_FULLY_REMAPPED;
>> +			} else {
>> +				block_group->discard_state =
>> +					BTRFS_DISCARD_EXTENTS;
>> +			}
>>   		}
>>   	}
>>   	if (block_group) {
>> @@ -373,7 +404,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>>   	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
>>   		return;
>>   
>> -	if (block_group->used == 0 && block_group->remap_bytes == 0)
>> +	if (block_group_is_empty(block_group))
>>   		add_to_discard_unused_list(discard_ctl, block_group);
>>   	else
>>   		add_to_discard_list(discard_ctl, block_group);
>> @@ -470,7 +501,7 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
>>   {
>>   	remove_from_discard_list(discard_ctl, block_group);
>>   
>> -	if (block_group->used == 0) {
>> +	if (block_group_is_empty(block_group)) {
>>   		if (btrfs_is_free_space_trimmed(block_group))
>>   			btrfs_mark_bg_unused(block_group);
>>   		else
>> @@ -524,7 +555,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
>>   	/* Perform discarding */
>>   	minlen = discard_minlen[discard_index];
>>   
>> -	if (discard_state == BTRFS_DISCARD_BITMAPS) {
>> +	switch (discard_state) {
>> +	case BTRFS_DISCARD_BITMAPS: {
>>   		u64 maxlen = 0;
>>   
>>   		/*
>> @@ -541,17 +573,28 @@ static void btrfs_discard_workfn(struct work_struct *work)
>>   				       btrfs_block_group_end(block_group),
>>   				       minlen, maxlen, true);
>>   		discard_ctl->discard_bitmap_bytes += trimmed;
>> -	} else {
>> +
>> +		break;
>> +	}
>> +
>> +	case BTRFS_DISCARD_FULLY_REMAPPED:
>> +		btrfs_trim_fully_remapped_block_group(block_group);
>> +		break;
>> +
>> +	default:
>>   		btrfs_trim_block_group_extents(block_group, &trimmed,
>>   				       block_group->discard_cursor,
>>   				       btrfs_block_group_end(block_group),
>>   				       minlen, true);
>>   		discard_ctl->discard_extent_bytes += trimmed;
>> +
>> +		break;
>>   	}
>>   
>>   	/* Determine next steps for a block_group */
>>   	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
>> -		if (discard_state == BTRFS_DISCARD_BITMAPS) {
>> +		if (discard_state == BTRFS_DISCARD_BITMAPS ||
>> +		    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
>>   			btrfs_finish_discard_pass(discard_ctl, block_group);
>>   		} else {
>>   			block_group->discard_cursor = block_group->start;
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 82dc88915b7e..82d102a157e9 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -2860,6 +2860,12 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
>>   	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
>>   		struct btrfs_chunk_map *map;
>>   
>> +		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
> 
> Any reason to queue this when DISCARD_ASYNC isn't set?
> i.e., put this in the if (btrfs_test_opt(..)) below?

Oops, you're right - btrfs_discard_queue_work() returns early if 
DISCARD_ASYNC isn't set, so we might as well move it into the if.

> 
>> +
>> +		/* for async discard the below gets done in discard job */
>> +		if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
>> +			continue;
>> +
>>   		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
>>   		if (IS_ERR(map))
>>   			return PTR_ERR(map);
>> @@ -2870,6 +2876,10 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
>>   			return ret;
>>   		}
>>   
>> +		if (!TRANS_ABORTED(trans))
>> +			btrfs_discard_extent(fs_info, block_group->start,
>> +					     block_group->length, NULL, false);
>> +
>>   		/*
>>   		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
>>   		 * won't run a second time.
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>> index 91670d0af179..5d5e3401e723 100644
>> --- a/fs/btrfs/free-space-cache.c
>> +++ b/fs/btrfs/free-space-cache.c
>> @@ -29,6 +29,7 @@
>>   #include "file-item.h"
>>   #include "file.h"
>>   #include "super.h"
>> +#include "relocation.h"
>>   
>>   #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
>>   #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
>> @@ -3066,6 +3067,11 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>>   	struct rb_node *node;
>>   	bool ret = true;
>>   
>> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +	    block_group->identity_remap_count == 0) {
>> +		return true;
>> +	}
>> +
>>   	spin_lock(&ctl->tree_lock);
>>   	node = rb_first(&ctl->free_space_offset);
>>   
>> @@ -3830,6 +3836,70 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
>>   	return ret;
>>   }
>>   
>> +void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>> +{
>> +	struct btrfs_fs_info *fs_info = bg->fs_info;
>> +	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
>> +	int ret = 0;
>> +	u64 bytes, trimmed;
>> +	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
>> +	u64 end = btrfs_block_group_end(bg);
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_chunk_map *map;
>> +
>> +	bytes = end - bg->discard_cursor;
>> +
>> +	if (max_discard_size &&
>> +		bytes >= (max_discard_size +
>> +			BTRFS_ASYNC_DISCARD_MIN_FILTER)) {
>> +		bytes = max_discard_size;
>> +	}
>> +
>> +	ret = btrfs_discard_extent(fs_info, bg->discard_cursor, bytes, &trimmed,
>> +				   false);
>> +	if (ret)
>> +		return;
>> +
>> +	bg->discard_cursor += trimmed;
>> +
>> +	if (bg->discard_cursor < end)
>> +		return;
>> +
>> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);
>> +	if (IS_ERR(trans))
>> +		return;
>> +
>> +	map = btrfs_get_chunk_map(fs_info, bg->start, 1);
>> +	if (IS_ERR(map)) {
>> +		ret = PTR_ERR(map);
>> +		btrfs_abort_transaction(trans, ret);
>> +		return;
>> +	}
>> +
>> +	ret = btrfs_last_identity_remap_gone(trans, map, bg);
>> +	if (ret) {
>> +		btrfs_free_chunk_map(map);
>> +		btrfs_abort_transaction(trans, ret);
>> +		return;
>> +	}
>> +
>> +	btrfs_end_transaction(trans);
>> +
>> +	/*
>> +	 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
>> +	 * won't run a second time.
>> +	 */
>> +	map->num_stripes = 0;
>> +
>> +	btrfs_free_chunk_map(map);
>> +
>> +	if (bg->used == 0) {
>> +		spin_lock(&fs_info->unused_bgs_lock);
>> +		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
>> +		spin_unlock(&fs_info->unused_bgs_lock);
>> +	}
>> +}
>> +
>>   /*
>>    * If we break out of trimming a bitmap prematurely, we should reset the
>>    * trimming bit.  In a rather contrived case, it's possible to race here so
>> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
>> index 9f1dbfdee8ca..33fc3b245648 100644
>> --- a/fs/btrfs/free-space-cache.h
>> +++ b/fs/btrfs/free-space-cache.h
>> @@ -166,6 +166,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
>>   int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
>>   				   u64 *trimmed, u64 start, u64 end, u64 minlen,
>>   				   u64 maxlen, bool async);
>> +void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg);
>>   
>>   bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
>>   int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active);
>> -- 
>> 2.49.1
>>


