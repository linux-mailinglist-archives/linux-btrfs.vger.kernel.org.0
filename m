Return-Path: <linux-btrfs+bounces-21512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l7dyO3kfiWk62wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21512-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 00:42:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DE10A9DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 00:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 333993005E8A
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E63859D2;
	Sun,  8 Feb 2026 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E4CKU/q3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DDB344031
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594163; cv=none; b=DPeuCf1xqoowg2+8SbC9HlXw9siDektj4W12krU9EInp/iUTMRwFI7CzjWjUpnOaEn4oCdIiM6lI4iRy1ZWzR76tnwGLKq1Pi+9KIphOhJkUr4/o1iTh0CecDoYneimaC2MwPCJ5C19zfiuK1jWlyLNO0DfPi5hcAeKzE0dvZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594163; c=relaxed/simple;
	bh=/lf1jyo+T1paBJtbiDdf83gXmxsw4+g38agrgH7feEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV/Eg5Z8BRwR6YQ+AeNUXQtz+pdrM478iDRxD6SsaQH4JAG5Nk8b/pC33F5Xla45im7fsJyj+vIhhV7tnVA+DjBZTZErQz/fo95ByRAaYF2D3W31oSKIR+69ejhcMsklkL8AcYlCKWyD06+5vUA7F0qG3cIT3k5zGzJ2IKHpo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E4CKU/q3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so36913975e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770594161; x=1771198961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fTBHr8mR/aifKSqswlHl7IgpvOTb5myBreAkh6gkxGA=;
        b=E4CKU/q3BA1G50nRUHlOjmSsNfTTcv8NoFcqhMH3ogQM/ATVhz2K1sJg6l7ka/B1wJ
         jVI3fDC0xEz6/0bK2d2nfx8O+a3d8xm14AsYPByOwNV1ZKqMGi907Y/qXOiZt4lC7lKe
         jRCUIp+mZ3RDJuTcwk60+aSTC3B97zE0ueoaGNiK79mLor8o4/F5M9I72ztzFHhFHUuD
         NmPH86Kw+eypxyXJtOKwDbJq2S6SRMAFzmWHCpd2CZ3ruQxPL6I0t6DkVGBWftVzGBBH
         l7K97o10EEA8Q7+QAGhtRPjb6cxwTv2naOKgoI8QwyTHTypunC2tPk5x/z731tp9+56r
         afXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770594161; x=1771198961;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTBHr8mR/aifKSqswlHl7IgpvOTb5myBreAkh6gkxGA=;
        b=jlBlb7ZcIAshEKNEmmHqXQXBSguTJV5abtmEOa+yzA5Qo94V1es3JjeLGIkuRa+B2S
         waRtuzCbMmr1Lpbk64C5q+VUcQ/BzR2bDsRwf4k15Ls4xdJYCC4Lu7MqyJz1Adkdyy5p
         ZWFaGxKiTDBoj2u35w1hORFEcDvAAQqH+NsWASWo3PLtcFmo/3G2iwCkE2yNRTcKJB0i
         KpeKJOtCQUHGyvf8yd1XP/e4ChVw2daaf0Aawp0X84HtUc7tq2bwrUw13bG2xEeeKwmT
         UZeKlvR9kAcs9p7wNRnpefLR+7M4uT9XLf6AzEqIrtQd/qsRDT+4U+ych78DFBizc1Gq
         +O2w==
X-Gm-Message-State: AOJu0YxXClogD4+BCXpRZFndFdX4IcllbkeZEx01ajXriAw6ve4ieWXH
	/g328rtEg4rJtQVkylwjw90GqHIkr3Y+D6oMRDB19n8r7HW2ZVnsXE/sSdKSAB8HObBCLrrF86U
	rlDHQpE4=
X-Gm-Gg: AZuq6aJBSzmTA44kI+whBR1CbZxtQnlUvdjVNhvbn0oKYB2dwqW51UHoE9udLO1o8EL
	1SjKIqlDs9jfQdA/u4gboWgUgAA17Y6gWJqVRcHu26JTIX5cWTXsTAv7LuzIIfBIqmMyohVpfu4
	kOSPcTV5zd58Mu72mcFQ+5f81zn4iocoiyLe8egHgMR1bmCfHeaItJ8CxH/29wgSOx1ltK7L0Xt
	/mbqUQyYk9hQCEU0+YvDuOc3/Q36kt/UIZA2MC9N/BcAJBY5bHf+nMcuCpmoiOXzTTaco919rFD
	FrVHgesUWjddq3hv3h+6ARtqUdU7bBmLYxyNIgRqk5SqSqb1FiH1jjayGuFBum/oXYbC3omVCli
	ezd8zXKB2Sz0hlokHZPF9TteUZecW7I7GVFjmrLxHBg+4x7E0BbDjO5jg7jl/TPBQq/QD6KQHR8
	cZbdX4QZc96SWoRxwXhUVhFHzSegbEze0Q/MqGyn8Jr0f3cqZGdA==
X-Received: by 2002:a05:600c:6217:b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-483202310a5mr132460575e9.19.1770594161160;
        Sun, 08 Feb 2026 15:42:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a638a1sm82453585ad.17.2026.02.08.15.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 15:42:40 -0800 (PST)
Message-ID: <73eeeb01-b569-4710-9763-022081beb9be@suse.com>
Date: Mon, 9 Feb 2026 10:12:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: refactor the main loop of cow_file_range()
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org
References: <5ff61d63a33409de2b821562613ebb3ac0da9bae.1765788497.git.wqu@suse.com>
 <20260208184920.1102719-1-clm@meta.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20260208184920.1102719-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21512-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: AA9DE10A9DF
X-Rspamd-Action: no action



在 2026/2/9 05:18, Chris Mason 写道:
> Qu Wenruo <wqu@suse.com> wrote:
>> Currently inside the main loop of cow_file_range(), we do the following
>> sequence:
>>
>> - Reserve an extent
>> - Lock the IO tree range
>> - Create an IO extent map
>> - Create an ordered extent
> 
> Hi everyone,
> 
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
> 
> https://github.com/masoncl/review-prompts
> 
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
> 
> commit c28214bde6da6e05554a0e5b6375b7b65f98cdbf
> Author: Qu Wenruo <wqu@suse.com>
> 
> btrfs: refactor the main loop of cow_file_range()
> 
> This commit refactors error handling in cow_file_range() by introducing
> a dedicated cow_one_range() helper that consolidates the
> reserve/lock/allocation sequence and moves error handling into the
> helper itself.
> 
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index e83a881fe202e..b95dab8ac8a11 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
> 
> [ ... ]
> 
>> @@ -1274,6 +1274,133 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>>   	return alloc_hint;
>>   }
>>
>> +/*
>> + * Handle COW for one range.
>> + *
>> + * @ins:		The key representing the allocated range.
>> + * @file_offset:	The file offset of the COW range
>> + * @num_bytes:		The expected length of the COW range
>> + *			The actually allocated length can be smaller than it.
>> + * @min_alloc_size:	The minimal extent size.
>> + * @alloc_hint:		The hint for the extent allocator.
>> + * @ret_alloc_size:	The COW range handles by this function.
>> + *
>> + * Return 0 if everything is fine and update @ret_alloc_size updated.  The
>> + * range is still locked, and caller should unlock the range after everything
>> + * is done or for error handling.
>> + *
>> + * Return <0 for error and @is updated for where the extra cleanup should
>> + * happen. The range [file_offset, file_offset + ret_alloc_size) will be
>> + * cleaned up by this function.
>> + */
>> +static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
>> +			 struct btrfs_key *ins, struct extent_state **cached,
>> +			 u64 file_offset, u32 num_bytes, u32 min_alloc_size,
>> +			 u64 alloc_hint, u32 *ret_alloc_size)
>> +{
>> +	struct btrfs_root *root = inode->root;
>> +	struct btrfs_fs_info *fs_info = root->fs_info;
>> +	struct btrfs_ordered_extent *ordered;
>> +	struct btrfs_file_extent file_extent;
>> +	struct extent_map *em;
>> +	u32 cur_len = 0;
>> +	u64 cur_end;
>> +	int ret;
>> +
>> +	ret = btrfs_reserve_extent(root, num_bytes, num_bytes, min_alloc_size,
>> +				   0, alloc_hint, ins, true, true);
>> +	if (ret < 0) {
>> +		*ret_alloc_size = cur_len;
>> +		return ret;
>> +	}
>> +
>> +	cur_len = ins->offset;
>> +	cur_end = file_offset + cur_len - 1;
>> +
>> +	file_extent.disk_bytenr = ins->objectid;
>> +	file_extent.disk_num_bytes = ins->offset;
>> +	file_extent.num_bytes = ins->offset;
>> +	file_extent.ram_bytes = ins->offset;
>> +	file_extent.offset = 0;
>> +	file_extent.compression = BTRFS_COMPRESS_NONE;
>> +
>> +	/*
>> +	 * Locked range will be released either during error clean up (inside
>> +	 * this function or by the caller for previously successful ranges) or
>> +	 * after the whole range is finished.
>> +	 */
>> +	btrfs_lock_extent(&inode->io_tree, file_offset, cur_end, cached);
>> +	em = btrfs_create_io_em(inode, file_offset, &file_extent, BTRFS_ORDERED_REGULAR);
>> +	if (IS_ERR(em)) {
>> +		ret = PTR_ERR(em);
>> +		goto free_reserved;
>> +	}
>> +	btrfs_free_extent_map(em);
>> +
>> +	ordered = btrfs_alloc_ordered_extent(inode, file_offset, &file_extent,
>> +					     1U << BTRFS_ORDERED_REGULAR);
>> +	if (IS_ERR(ordered)) {
>> +		btrfs_drop_extent_map_range(inode, file_offset, cur_end, false);
>> +		ret = PTR_ERR(ordered);
>> +		goto free_reserved;
>> +	}
> 
> [ ... ]
> 
>> +free_reserved:
>> +	extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_folio, cached,
>> +				     EXTENT_LOCKED | EXTENT_DELALLOC |
>> +				     EXTENT_DELALLOC_NEW |
>> +				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
>> +				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
>> +				     PAGE_END_WRITEBACK);
> 
> Can this cause a double decrement of the bytes_may_use space accounting
> counter?
> 
> Looking at the error paths in cow_one_range(), when
> btrfs_reserve_extent() succeeds, it calls btrfs_add_reserved_bytes() at
> line 3829 in block-group.c, which already decrements bytes_may_use.
> Then if we hit the free_reserved error path, EXTENT_DO_ACCOUNTING
> includes EXTENT_CLEAR_DATA_RESV, which causes
> btrfs_free_reserved_data_space_noquota() to be called via
> btrfs_clear_delalloc_extent(), decrementing bytes_may_use a second time.
> 
> The old code at the out_unlock label explicitly avoided this with the
> comment:
> 
>      /*
>       * For the range (2). If we reserved an extent for our delalloc range
>       * (or a subrange) and failed to create the respective ordered extent,
>       * then it means that when we reserved the extent we decremented the
>       * extent's size from the data space_info's bytes_may_use counter and
>       * incremented the space_info's bytes_reserved counter by the same
>       * amount. We must make sure extent_clear_unlock_delalloc() does not try
>       * to decrement again the data space_info's bytes_may_use counter,
>       * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
>       */
> 
> The old code used only EXTENT_CLEAR_META_RESV (not
> EXTENT_CLEAR_DATA_RESV) for this error path. Should the free_reserved
> path use EXTENT_CLEAR_META_RESV instead of EXTENT_DO_ACCOUNTING to avoid
> this double-decrement?

Totally correct, and I'm very impressed by the ability to detect such 
minor changes and aware of the context.
(E.g. the old flags are not even visible inside the patch).

Will send out a fix soon.

Thanks,
Qu

> 
>> +	btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
>> +	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
>> +	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
>> +	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
>> +	*ret_alloc_size = cur_len;
>> +	/*
>> +	 * We should not return -EAGAIN where it's a special return code for
>> +	 * zoned to catch btrfs_reserved_extent().
>> +	 */
>> +	ASSERT(ret != -EAGAIN);
>> +	return ret;
>> +}
> 
> [ ... ]
> 


