Return-Path: <linux-btrfs+bounces-16025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208DB22B27
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C7B162F9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8F2ECEA1;
	Tue, 12 Aug 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="TtO+dg8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95F4A04
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010217; cv=none; b=MAfuBREjEkFGPp0FPgpWXoCpkEZCdo4k7YVWEi1OzpjEU4XKTqabZglY6wgyeMU6JcmcHzN4KAjnLBZP/ikK2sUce+G7b5lAGj81ij4WH2tsJz1k0wleRdLVI9OQwxCp4o6MSGsaKMC9GwK0YA69GNyn33g1i51WkBlO6tU3R94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010217; c=relaxed/simple;
	bh=gerX+1x+aG9MfIb1o25KW1T9VRwEBTGNsxKIZ28Kcg4=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRT62Qp4b/YTFtXxGAjJ3qqg8q4obYJEG03ORhki3zKBf+S9oDvVV7jJKNRoA39uhD5Zh/SSComrXgtgtKgeR6+rr18NU7fjoHbFtvmPPBh8RXic9GPfBzimUuVb0h5dTrK8yP8VL254Rqpza0RBYZjzaOCyn+obOI9OGa5gObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=TtO+dg8Y; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 014712A6D44;
	Tue, 12 Aug 2025 15:50:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755010209;
	bh=0Wu9B/NdrFRDXQTxggSqReNejKmYxBLJdbt8oiItglM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TtO+dg8YPQViPOvQzxbHjwjfglt+zy7721WqJ56yp2K8TDLjXJDUkOGQgaukazfpw
	 BPDkgbn6g5zQ/js71/K8QeVHhwwITPEp8DCepD2sunCQzk6AzoSI7jBInkhLRpKoAd
	 zDH2JggUgRcK5C2PdN64vj9wcoC9V7SPx8C/bkQQ=
Message-ID: <7dcef754-f46f-434a-98fe-c870e2b03f53@harmstone.com>
Date: Tue, 12 Aug 2025 15:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 04/12] btrfs: remove remapped block groups from the
 free-space tree
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-5-maharmstone@fb.com>
 <20250613220015.GD3621880@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250613220015.GD3621880@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 11.00 pm, Boris Burkov wrote:
> On Thu, Jun 05, 2025 at 05:23:34PM +0100, Mark Harmstone wrote:
>> No new allocations can be done from block groups that have the REMAPPED flag
>> set, so there's no value in their having entries in the free-space tree.
>>
>> Prevent a search through the free-space tree being scheduled for such a
>> block group, and prevent discard being run for a fully-remapped block
>> group.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   fs/btrfs/block-group.c | 21 ++++++++++++++++-----
>>   fs/btrfs/discard.c     |  9 +++++++++
>>   2 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 5b0cb04b2b93..9b3b5358f1ba 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -920,6 +920,13 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
>>   	if (btrfs_is_zoned(fs_info))
>>   		return 0;
>>   
>> +	/*
>> +	 * No allocations can be done from remapped block groups, so they have
>> +	 * no entries in the free-space tree.
>> +	 */
>> +	if (cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)
>> +		return 0;
>> +
>>   	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
>>   	if (!caching_ctl)
>>   		return -ENOMEM;
>> @@ -1235,9 +1242,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   	 * another task to attempt to create another block group with the same
>>   	 * item key (and failing with -EEXIST and a transaction abort).
>>   	 */
>> -	ret = remove_block_group_free_space(trans, block_group);
>> -	if (ret)
>> -		goto out;
> 
> nit: it feels nicer to hide the check inside the function.

It's not obvious here, but this is because of start_block_group_remapping(), which is
added in a later patch. remove_block_group_free_space() gets called when a block group
is remapped, or when a non-remapped block group is removed.

>> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>> +		ret = remove_block_group_free_space(trans, block_group);
>> +		if (ret)
>> +			goto out;
>> +	}
>>   
>>   	ret = remove_block_group_item(trans, path, block_group);
>>   	if (ret < 0)
>> @@ -2457,10 +2466,12 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>>   	if (btrfs_chunk_writeable(info, cache->start)) {
>>   		if (cache->used == 0) {
>>   			ASSERT(list_empty(&cache->bg_list));
>> -			if (btrfs_test_opt(info, DISCARD_ASYNC))
>> +			if (btrfs_test_opt(info, DISCARD_ASYNC) &&
> 
> I asked this on the previous patch, but I guess this means we will never
> discard these blocks? Is that desirable? Or are we discarding them at
> some other point in the life-cycle?
> 
>> +			    !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
>>   				btrfs_discard_queue_work(&info->discard_ctl, cache);
>> -			else
>> +			} else {
>>   				btrfs_mark_bg_unused(cache);
>> +			}
>>   		}
>>   	} else {
>>   		inc_block_group_ro(cache, 1);
>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
>> index 89fe85778115..1015a4d37fb2 100644
>> --- a/fs/btrfs/discard.c
>> +++ b/fs/btrfs/discard.c
>> @@ -698,6 +698,15 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
>>   	/* We enabled async discard, so punt all to the queue */
>>   	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
>>   				 bg_list) {
>> +		/* Fully remapped BGs have nothing to discard */
> 
> Same question. If we simply *don't* discard them, I feel like this
> comment is misleadingly worded.
> 
>> +		spin_lock(&block_group->lock);
>> +		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +		    !btrfs_is_block_group_used(block_group)) {
>> +			spin_unlock(&block_group->lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&block_group->lock);
>> +
>>   		list_del_init(&block_group->bg_list);
>>   		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
>>   		/*
>> -- 
>> 2.49.0
>>
> 


