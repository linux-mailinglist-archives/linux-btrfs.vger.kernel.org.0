Return-Path: <linux-btrfs+bounces-16447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C6B386BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32882365B8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D722D0606;
	Wed, 27 Aug 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="jB1zSPVh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EE14E2F2
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308964; cv=none; b=U2jCCqtqVd2vOZFnjovwVdhCjx94erCSWIVVfCPrmvDJBxbQqx1Op3p7MN8rTPuoGM4dfCizjkQxb1QdBOd7v0rVWqFLOsA5O+WiIUIZfM1X1DRtWqLpDnzslxzacPJ/p3L42uwIqWRBNxBpG3bsf3I1JngpTljv6pYuEQCIe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308964; c=relaxed/simple;
	bh=GUiTPugs/9ym8ko92OB3DdPpoIblFIPYG4gMQB8MW7c=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cub9QlYMWnRoONBGu/dB0NLNErmBTFwSFpfoEV5+pKw/WHa2k6brCCyJFs3yzBykUH9pBW1lmrbDW1fPprMk6luFg4oqEb8Oh4B4bI1VqFkrn2RGoCWlhqma3YteI4gZOGQdDGaDeLuJie15yD5qw3sng56n6n1GDFfqpawjyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=jB1zSPVh; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 8E6572AE287;
	Wed, 27 Aug 2025 16:35:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756308956;
	bh=DaEgoipmK3t0lfyGiGHvch7WYqM3DiVYXdh1XFZaVAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jB1zSPVhfBJbvdXOhX2nhop6Fr3/vMAlrnlAHBOjxGKhBvRV8ybwBxxUHvuHsac5/
	 RMkbT06mxCq5/bvelHTIzsqPFhIWUjTQ/uv6sL4Lzdw0uUh/r8T05Mp15VtIERyY2V
	 qJlaAEj9vTNgKNImwnmFX23fsDrmKblKwCGp12SI=
Message-ID: <b6df2e8e-121c-482f-92ec-b8abf74b8e03@harmstone.com>
Date: Wed, 27 Aug 2025 16:35:56 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 09/16] btrfs: release BG lock before calling
 btrfs_link_bg_list()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-10-mark@harmstone.com>
 <20250816003233.GF3042054@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250816003233.GF3042054@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2025 1.32 am, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 03:34:51PM +0100, Mark Harmstone wrote:
>> Release block_group->lock before calling btrfs_link_bg_list() in
>> btrfs_delete_unused_bgs(), as this was causing lockdep issues.
>>
>> This lock isn't held in any other place that we call btrfs_link_bg_list(), as
>> the block group lists are manipulated while holding fs_info->unused_bgs_lock.
>>
> 
> Please include the offending lockdep output you are fixing.

I didn't include it as lockdep was triggering on the second (correct) instance,
while the problem was on the first (incorrect) instance, and thought it would
confuse matters. And I stupidly didn't take a copy, and now I can't reproduce
it.

The issue is that in btrfs_discard_punt_unused_bgs_list() in "btrfs: remove
remapped block groups from the free-space tree", we're holding unused_bgs_lock
then looping through the list grabbing the individual block group list. In
btrfs_delete_unused_bgs() we're grabbing unused_bgs_lock while unnecessarily
holding the block group lock.


> Is this a generic fix unrelated to your other changes? I think a
> separate patch from the series is clearer in that case. And it would
> need a Fixes: tag (probably my patch that added btrfs_link_bg_list, haha)

It looks like it's actually f4a9f219411f318ae60d6ff7f129082a75686c6c,
"btrfs: do not delete unused block group if it may be used soon".

> 
> Thanks.
> 
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index bed9c58b6cbc..8c28f829547e 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		if ((space_info->total_bytes - block_group->length < used &&
>>   		     block_group->zone_unusable < block_group->length) ||
>>   		    has_unwritten_metadata(block_group)) {
>> +			spin_unlock(&block_group->lock);
>> +
>>   			/*
>>   			 * Add a reference for the list, compensate for the ref
>>   			 * drop under the "next" label for the
>> @@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   			btrfs_link_bg_list(block_group, &retry_list);
>>   
>>   			trace_btrfs_skip_unused_block_group(block_group);
>> -			spin_unlock(&block_group->lock);
>>   			spin_unlock(&space_info->lock);
>>   			up_write(&space_info->groups_sem);
>>   			goto next;
>> -- 
>> 2.49.1
>>


