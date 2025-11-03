Return-Path: <linux-btrfs+bounces-18548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC8C2BCF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 13:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 768BD4F2242
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42C30FF06;
	Mon,  3 Nov 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="xwlpIMXO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C299283CBF
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173579; cv=none; b=dLWX3fv67cgEPcIACMeXm0ITtQ6QY3IrlBrDQOhS1TJVA6Dpi+zsEJX+vsDv6d6dY0uj7lIVq9GyGAsa32MP4UX/b31gTpNNdKa4AlJaz+AtwvumsZh+/ri5TBU2sFfo18ImdfXuZz6MbWkO1MC26v6V9XMqhWXFXTbXp8D0QDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173579; c=relaxed/simple;
	bh=a1SN9hMzuOLJoGNeIPU73Y+07Vw3ZCf3Tfr8bhyZovg=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qluMu+LeKxnA+X8mLe2g7HXtwWesI7AuUY5NrFPjMzOyZTpaf7PUIGSIVYO5z7Uo3cWnThXYjKqspRC7wO999c9qfLhFrKdnDiwyCZ2f3CIFO3h7pIne8HjCE0AEfFbC8BOrV0N+t9w78h7eK+BB8MZCd8nBd7Trzcz+vlJQfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=xwlpIMXO; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id D7C7A2D52A7;
	Mon,  3 Nov 2025 12:39:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762173571;
	bh=jGpud3yIkzbpBb7lAQ/q/lMneltiqT+H/rMetIFnPNQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=xwlpIMXOzKZJS6xKiNy1FGxPJ904Xp4aq5YfxST+bwRW7q8RmxgbTu5yEUnC1wEUa
	 iAAjw5m3WMgUENO2ujwe3B93sdGftAZBRf91A0qSQ0EvA6KdfMR7TOn9Jb79z2oMO7
	 YWVZTZV7RUzX/PN9xoVEwZ+TzQbRRNmcngm5YBbY=
Message-ID: <4556b642-9902-4156-a7d4-cf2976750577@harmstone.com>
Date: Mon, 3 Nov 2025 12:39:31 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 04/16] btrfs: remove remapped block groups from the
 free-space tree
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-5-mark@harmstone.com>
 <aQUtrBM3XIb2Ufkr@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <aQUtrBM3XIb2Ufkr@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2025 9.44 pm, Boris Burkov wrote:
> On Fri, Oct 24, 2025 at 07:12:05PM +0100, Mark Harmstone wrote:
>> No new allocations can be done from block groups that have the REMAPPED flag
>> set, so there's no value in their having entries in the free-space tree.
>>
>> Prevent a search through the free-space tree being scheduled for such a
>> block group, and prevent any additions to the in-memory free-space tree.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c      | 15 ++++++++++++---
>>   fs/btrfs/free-space-cache.c |  3 +++
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index ec1e4fc0cd51..b5f2ec8d013f 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -933,6 +933,13 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
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
>> @@ -1248,9 +1255,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   	 * another task to attempt to create another block group with the same
>>   	 * item key (and failing with -EEXIST and a transaction abort).
>>   	 */
>> -	ret = btrfs_remove_block_group_free_space(trans, block_group);
>> -	if (ret)
>> -		goto out;
>> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>> +		ret = btrfs_remove_block_group_free_space(trans, block_group);
>> +		if (ret)
>> +			goto out;
>> +	}
> 
> I feel like a comment or the commit message could explain the change to
> the btrfs_remove_block_group bit more clearly. Like "remapped has no free
> space so removing it is a no-op". If it is in fact a no-op, is there any
> problem with calling it?

Makes sense. I think in theory it's a no-op, but in practice it would ASSERT
because the free space info it's expecting isn't there.

> With that extra bit of doc/explanation, feel free to add
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
>>   
>>   	ret = remove_block_group_item(trans, path, block_group);
>>   	if (ret < 0)
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>> index ab873bd67192..ec9a97d75d10 100644
>> --- a/fs/btrfs/free-space-cache.c
>> +++ b/fs/btrfs/free-space-cache.c
>> @@ -2756,6 +2756,9 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
>>   {
>>   	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
>>   
>> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)
>> +		return 0;
>> +
>>   	if (btrfs_is_zoned(block_group->fs_info))
>>   		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
>>   						    true);
>> -- 
>> 2.49.1
>>


