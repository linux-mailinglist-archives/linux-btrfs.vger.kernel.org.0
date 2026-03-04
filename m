Return-Path: <linux-btrfs+bounces-22211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HkGI6Gyp2kfjQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22211-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 05:18:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C81FAA6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 05:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC021304855A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 04:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F337F733;
	Wed,  4 Mar 2026 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FYLuOcxr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4B37702A
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597906; cv=none; b=q30WupMeMHQ8itxcJJio7rHmQ+F072daWJ1Q/U/u3ttzIHI1Zc2MYVguc00PlfBsiDLMRyEwnWpT8KRST2fFRQI5b1Ekwa4bVVRgao7KxK+bFXJlZTixfUlle8v/UCttaG3ER8c9yMqckNuiqWGvicPsyyTQvUIG2E9TtKnmbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597906; c=relaxed/simple;
	bh=ydOyDBH40g8vnMo0npp68dnqdhHK6dhzBCG5XqAuBcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csALwJnFhU59e5lzDUfTsBoMJ68LzFJLYabThOKQm8GD2SyQfCw1qsjkk6mUhTfZTjGyXHR6OFdM6iQItTLbWRx457IobcTULjWPYKYc+AO4BS2s6gUNZD6RpYvVCi+31E3fh+1ldPNg2zuJ60x3sMHwaTnl6KY/t8tx6nXbELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FYLuOcxr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso57643045e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 20:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772597903; x=1773202703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jo1BVqybpeZxfCp8v8NDbqpIjXCtqkZhjWZJL/nIDso=;
        b=FYLuOcxrJf2JiC917OJxMKAzNY349KIlxrMoyOF3t18Zw5F1Dxs8j1FOR/QGHtiF5O
         EApkZ+wye6l7HmchEsmMPGdvVEXTmGexmzPl1AA8amtDg1uwrrIBGt+TEmagA5LZsNWM
         VLxepw5s8J1Erj+oZ3w38iLTb7gAs8xzkTKpc3XKbLCM5psCFs1cG4g73ISFlL6vnDiJ
         q6N742akNZNNKgyXzaNFckYWLBKmqCW4kWIVSm8hRANWb/9GR5rA6hTngMc5tXkSevYI
         TnKEXwBmpLMJ0GP4aNAtN0zYGmUp9pITZ2wKsy/yMT5t7mhFXpzY7ILd7TjXCVx/rH0a
         xuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597903; x=1773202703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo1BVqybpeZxfCp8v8NDbqpIjXCtqkZhjWZJL/nIDso=;
        b=C/y6vXQQ0PFO24hTl0yZaUQOlPVfE2iGZmW2IbBCqlSBIrB6y+uiEzodlfmVPbapEz
         RRPgA/bKZmCLRM2CtXgmzgnkJ1LuZ4e55ki7hqpDjMn8ePyBQa5i4/ibmT1+rFU2IvPm
         4haYyBXem3YRVAgLMS7AzTOlTRTEVgbuI420qkszaLDx4H5bxLAEuakFvKx1xQDfeYC9
         99w2/UiKGDhzdnWALxz4VfyJZtAbD/se7qTQ8QW4rDcGc30E8R4shxTfWm/sS6dT5lJI
         QVOGT0LYIZJb53LHJEaas3ZMyHIyoo/yaQO2K8Mpaf7xFfiAWpbCGNSBvCr7ZMTSDFpK
         WeNA==
X-Gm-Message-State: AOJu0YzYoGq3ZrA0fau1wFcLRe3ToTsDH0CBQT2XOOBDx8v0PxpjMAq6
	PANPErXZkCYrJEiv55G7+nTFUZzF5DuFa7emy+DAovINQAisSto0HCH2WpLJjLzn260=
X-Gm-Gg: ATEYQzykFggZLrmQcMgHm0CXujZO6RYkkEAiULqlUeTmvAHe1jTcaMLeL/gLwTrToFA
	J1f3fNrgikZc/TxvQjXacm/0t6kBWF205qCwqcRxRxzDLcLj1eKBLwL/5t8dp+1rIfolv8mAgN1
	RALp8f9eVd1iKlSrakldxmkLI5pnyyfBw7uUp0jpCkapF2RzK7Ljj7w66v3Tklvs6XElOI2fBWC
	KklEF6F6+367zv1znjAS6nCPoHJEMZt3hsN2jawGObCh7LaEcRpqtrtWpr9q0nvAQWuOaRidscB
	8OovD8CPkjQ0qO8zujrxAF/+SJp24R1IPhZb6pjN1VnamckQL3oc6yvT44lrnjyIBxLR365Uf3n
	D9yMI0Ugb355vWUm2BTmFF4zMHkbE60TeH2IAsQI+hkuU5OJGUUuT0AZek14iS9rKOhJSYPr5eQ
	X+mMnHBYVOQsk9KpZD3KkJ33RSU7ibr7BrRNq8YgTrdPEAK86jGR8ty2hqpq3T0Q==
X-Received: by 2002:a05:600c:4e8b:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-4851984886emr8836555e9.9.1772597902532;
        Tue, 03 Mar 2026 20:18:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34e6sm116050065ad.30.2026.03.03.20.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 20:18:21 -0800 (PST)
Message-ID: <983e8887-9176-4cfe-97f1-8f2106420659@suse.com>
Date: Wed, 4 Mar 2026 14:48:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btrfs: extract inlined creation into a dedicated
 delalloc helper
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <83385ea5fbacd4a044928147b4505c4980e306de.1772058054.git.wqu@suse.com>
 <20260304040133.GA899178@zen.localdomain>
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
In-Reply-To: <20260304040133.GA899178@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B6C81FAA6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22211-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action



在 2026/3/4 14:32, Boris Burkov 写道:
> On Thu, Feb 26, 2026 at 09:23:18AM +1030, Qu Wenruo wrote:
[...]
>> -	btrfs_lock_extent(&inode->io_tree, offset, end, &cached);
>> -	ret = __cow_file_range_inline(inode, size, compressed_size,
>> -				      compress_type, compressed_folio,
>> -				      update_i_size);
>> -	if (ret > 0) {
> 
> Possible bug described below, but note the old code did not call
> extent_clear_unlock_delalloc when __cow_file_range_inline() returned > 0

You're right, and __cow_file_range_inline() has a somewhat weird 
returning value.

It turns 0 if we have inserted the inline extent, <0 for critical error 
which also aborts the transaction (except -ENOSPC).
It only return >0 if we failed with ENOSPC.

But to be honest, the ENOSPC can happen from two locations (insert and 
update inodes), and if the insert succeeded but inode update failed, I'm 
not sure if we should still continue without reverting the inserted extent.

Thus the ret > 0 branch in the new code should be falling back to 
regular ones.

> 
>> -		btrfs_unlock_extent(&inode->io_tree, offset, end, &cached);
>> -		return ret;
>> -	}
>> -
>> -	/*
>> -	 * In the successful case (ret == 0 here), cow_file_range will return 1.
>> -	 *
>> -	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
>> -	 * is treated as a short circuited success and does not unlock the folio,
>> -	 * so we must do it here.
>> -	 *
>> -	 * In the failure case, the locked_folio does get unlocked by
>> -	 * btrfs_folio_end_all_writers, which asserts that it is still locked
>> -	 * at that point, so we must *not* unlock it here.
>> -	 *
>> -	 * The other two callsites in compress_file_range do not have a
>> -	 * locked_folio, so they are not relevant to this logic.
>> -	 */
>> -	if (ret == 0)
>> -		locked_folio = NULL;
>> -
>> -	extent_clear_unlock_delalloc(inode, offset, end, locked_folio, &cached,
>> -				     clear_flags, PAGE_UNLOCK |
>> -				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
>> -	return ret;
>> -}
>> -
>>   struct async_extent {
>>   	u64 start;
>>   	u64 ram_size;
>> @@ -797,7 +747,7 @@ static int add_async_extent(struct async_chunk *cow, u64 start, u64 ram_size,
>>    * options, defragmentation, properties or heuristics.
>>    */
>>   static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>> -				      u64 end)
>> +				      u64 end, bool check_inline)
>>   {
>>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>   
>> @@ -812,8 +762,9 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>>   	 * and will always fallback to regular write later.
>>   	 */
>>   	if (end + 1 - start <= fs_info->sectorsize &&
>> -	    (start > 0 || end + 1 < inode->disk_i_size))
>> +	    (!check_inline || (start > 0 || end + 1 < inode->disk_i_size)))
>>   		return 0;
>> +
>>   	/* Defrag ioctl takes precedence over mount options and properties. */
>>   	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
>>   		return 0;
>> @@ -928,7 +879,6 @@ static void compress_file_range(struct btrfs_work *work)
>>   		container_of(work, struct async_chunk, work);
>>   	struct btrfs_inode *inode = async_chunk->inode;
>>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>> -	struct address_space *mapping = inode->vfs_inode.i_mapping;
>>   	struct compressed_bio *cb = NULL;
>>   	u64 blocksize = fs_info->sectorsize;
>>   	u64 start = async_chunk->start;
>> @@ -1000,7 +950,7 @@ static void compress_file_range(struct btrfs_work *work)
>>   	 * been flagged as NOCOMPRESS.  This flag can change at any time if we
>>   	 * discover bad compression ratios.
>>   	 */
>> -	if (!inode_need_compress(inode, start, end))
>> +	if (!inode_need_compress(inode, start, end, false))
>>   		goto cleanup_and_bail_uncompressed;
>>   
>>   	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
>> @@ -1021,35 +971,6 @@ static void compress_file_range(struct btrfs_work *work)
>>   	total_compressed = cb->bbio.bio.bi_iter.bi_size;
>>   	total_in = cur_len;
>>   
>> -	/*
>> -	 * Try to create an inline extent.
>> -	 *
>> -	 * If we didn't compress the entire range, try to create an uncompressed
>> -	 * inline extent, else a compressed one.
>> -	 *
>> -	 * Check cow_file_range() for why we don't even try to create inline
>> -	 * extent for the subpage case.
>> -	 */
>> -	if (total_in < actual_end)
>> -		ret = cow_file_range_inline(inode, NULL, start, end, 0,
>> -					    BTRFS_COMPRESS_NONE, NULL, false);
>> -	else
>> -		ret = cow_file_range_inline(inode, NULL, start, end, total_compressed,
>> -					    compress_type,
>> -					    bio_first_folio_all(&cb->bbio.bio), false);
>> -	if (ret <= 0) {
>> -		cleanup_compressed_bio(cb);
>> -		if (ret < 0)
>> -			mapping_set_error(mapping, -EIO);
>> -		return;
>> -	}
>> -	/*
>> -	 * If a single block at file offset 0 cannot be inlined, fall back to
>> -	 * regular writes without marking the file incompressible.
>> -	 */
>> -	if (start == 0 && end <= blocksize)
>> -		goto cleanup_and_bail_uncompressed;
>> -
>>   	/*
>>   	 * We aren't doing an inline extent. Round the compressed size up to a
>>   	 * block size boundary so the allocator does sane things.
>> @@ -1427,11 +1348,6 @@ static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
>>    *
>>    * When this function fails, it unlocks all folios except @locked_folio.
>>    *
>> - * When this function successfully creates an inline extent, it returns 1 and
>> - * unlocks all folios including locked_folio and starts I/O on them.
>> - * (In reality inline extents are limited to a single block, so locked_folio is
>> - * the only folio handled anyway).
>> - *
>>    * When this function succeed and creates a normal extent, the folio locking
>>    * status depends on the passed in flags:
>>    *
>> @@ -1475,25 +1391,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   	ASSERT(num_bytes <= btrfs_super_total_bytes(fs_info->super_copy));
>>   
>>   	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>> -
>> -	if (!(flags & COW_FILE_RANGE_NO_INLINE)) {
>> -		/* lets try to make an inline extent */
>> -		ret = cow_file_range_inline(inode, locked_folio, start, end, 0,
>> -					    BTRFS_COMPRESS_NONE, NULL, false);
>> -		if (ret <= 0) {
>> -			/*
>> -			 * We succeeded, return 1 so the caller knows we're done
>> -			 * with this page and already handled the IO.
>> -			 *
>> -			 * If there was an error then cow_file_range_inline() has
>> -			 * already done the cleanup.
>> -			 */
>> -			if (ret == 0)
>> -				ret = 1;
>> -			goto done;
>> -		}
>> -	}
>> -
>>   	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
>>   
>>   	/*
>> @@ -1571,7 +1468,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   	}
>>   	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
>>   				     EXTENT_LOCKED | EXTENT_DELALLOC, page_ops);
>> -done:
>>   	if (done_offset)
>>   		*done_offset = end;
>>   	return ret;
>> @@ -1874,7 +1770,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
>>   	 * a locked folio, which can race with writeback.
>>   	 */
>>   	ret = cow_file_range(inode, locked_folio, start, end, NULL,
>> -			     COW_FILE_RANGE_NO_INLINE | COW_FILE_RANGE_KEEP_LOCKED);
>> +			     COW_FILE_RANGE_KEEP_LOCKED);
>>   	ASSERT(ret != 1);
>>   	return ret;
>>   }
>> @@ -2425,6 +2321,80 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
>>   	return false;
>>   }
>>   
>> +/*
>> + * Return 0 if an inlined extent is created successfully.
>> + * Return <0 if critical error happened.
>> + * Return >0 if an inline extent can not be created.
>> + */
>> +static int run_delalloc_inline(struct btrfs_inode *inode, struct folio *locked_folio)
>> +{
>> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>> +	struct compressed_bio *cb = NULL;
>> +	struct extent_state *cached = NULL;
>> +	const u64 i_size = i_size_read(&inode->vfs_inode);
>> +	const u32 blocksize = fs_info->sectorsize;
>> +	int compress_type = fs_info->compress_type;
>> +	int compress_level = fs_info->compress_level;
>> +	u32 compressed_size = 0;
>> +	int ret;
>> +
>> +	ASSERT(folio_pos(locked_folio) == 0);
>> +
>> +	if (btrfs_inode_can_compress(inode) &&
>> +	    inode_need_compress(inode, 0, blocksize, true)) {
>> +		if (inode->defrag_compress > 0 &&
>> +		    inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
>> +			compress_type = inode->defrag_compress;
>> +			compress_level = inode->defrag_compress_level;
>> +		} else if (inode->prop_compress) {
>> +			compress_type = inode->prop_compress;
>> +		}
>> +		cb = btrfs_compress_bio(inode, 0, blocksize, compress_type, compress_level, 0);
>> +		if (IS_ERR(cb)) {
>> +			cb = NULL;
>> +			/* Just fall back to non-compressed case. */
>> +		} else {
>> +			compressed_size = cb->bbio.bio.bi_iter.bi_size;
>> +		}
>> +	}
>> +	if (!can_cow_file_range_inline(inode, 0, i_size, compressed_size)) {
>> +		if (cb)
>> +			cleanup_compressed_bio(cb);
>> +		return 1;
>> +	}
>> +
>> +	btrfs_lock_extent(&inode->io_tree, 0, blocksize - 1, &cached);
>> +	if (cb)
>> +		ret = __cow_file_range_inline(inode, i_size, compressed_size, compress_type,
>> +					      bio_first_folio_all(&cb->bbio.bio), false);
>> +	else
>> +		ret = __cow_file_range_inline(inode, i_size, 0, BTRFS_COMPRESS_NONE,
>> +					      NULL, false);
>> +	/*
>> +	 * In the successful case (ret == 0 here), run_delalloc_inline() will return 1.
> 
> As far as I can tell, this is inside run_delalloc_inline() and we do not
> further manipulate ret to become 1, so this comment seems to have an
> error.
> 
> Was it meant to say that the caller, btrfs_run_delalloc_range(), will
> return 1?

Right, the comment is not properly updated for the new situation.

> 
>> +	 *
>> +	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
>> +	 * is treated as a short circuited success and does not unlock the folio,
>> +	 * so we must do it here.
>> +	 *
>> +	 * For failure case, the @locked_folio does get unlocked by
>> +	 * btrfs_folio_end_lock_bitmap(), so we must *not* unlock it here.
>> +	 *
>> +	 * So if ret == 0, we let extent_clear_unlock_delalloc() to unlock the
>> +	 * folio by passing NULL as @locked_folio.
>> +	 * Otherwise pass @locked_folio as usual.
>> +	 */
>> +	if (ret == 0)
>> +		locked_folio = NULL;
> 
> I think this might be a bug.
> 
> when ret == 1, we do fallback but have cleared delalloc, so the caller
> will call cow_file_range without the delalloc bits set, and double call
> extent_clear_unlock_delalloc()

Correct, I'll update the comment of that __cow_file_range_inline() and 
for ret > 0 case to directly exit without extent_clear_unlock_delalloc().

Thanks a lot for reviewing and catching this critical bug,
Qu

> 
>> +	extent_clear_unlock_delalloc(inode, 0, blocksize - 1, locked_folio, &cached,
>> +				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
>> +				     EXTENT_DO_ACCOUNTING | EXTENT_LOCKED,
>> +				     PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
>> +	if (cb)
>> +		cleanup_compressed_bio(cb);
>> +	return ret;
>> +}
>> +
>>   /*
>>    * Function to process delayed allocation (create CoW) for ranges which are
>>    * being touched for the first time.
>> @@ -2441,11 +2411,26 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>>   	ASSERT(!(end <= folio_pos(locked_folio) ||
>>   		 start >= folio_next_pos(locked_folio)));
>>   
>> +	if (start == 0 && end + 1 <= inode->root->fs_info->sectorsize &&
>> +	    end + 1 >= inode->disk_i_size) {
>> +		int ret;
>> +
>> +		ret = run_delalloc_inline(inode, locked_folio);
>> +		if (ret < 0)
>> +			return ret;
>> +		if (ret == 0)
>> +			return 1;
>> +		/*
>> +		 * Continue regular handling if we can not create an
>> +		 * inlined extent.
>> +		 */
>> +	}
>> +
>>   	if (should_nocow(inode, start, end))
>>   		return run_delalloc_nocow(inode, locked_folio, start, end);
>>   
>>   	if (btrfs_inode_can_compress(inode) &&
>> -	    inode_need_compress(inode, start, end) &&
>> +	    inode_need_compress(inode, start, end, false) &&
>>   	    run_delalloc_compressed(inode, locked_folio, start, end, wbc))
>>   		return 1;
>>   
>> -- 
>> 2.53.0
>>


