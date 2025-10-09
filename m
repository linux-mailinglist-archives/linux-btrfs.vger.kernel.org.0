Return-Path: <linux-btrfs+bounces-17594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC7BC9A94
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 16:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5681A6136D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9582EBB81;
	Thu,  9 Oct 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="pVZS1RtZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D132EA17D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021936; cv=none; b=Qf1G4aSNrwyssOi5PIUR6AvnoWFsIf6aImjtmWu4FK7OZb+3EsaIdXo5c5Bw0adkcTbpHF7RNu6oC2mtezzOtoi7cw6C11iaGLVaFXwpn/2OsVMYBS8e8ynDwneM7YNF+1H5mcNoir5Ybm5gykc8ejg78oezHK4zjKxARL/Cm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021936; c=relaxed/simple;
	bh=pIKMttcFFA6Wtwv33XoPXadepI8gkFvlPNKTkLGzdYA=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCOVsjlIR7cBTSmK+DTAbgE4UwaL23O7xbPggit/zJwtjWWnhbnSi0o7WY82p8IrseHQ7fL0IwGSvx1imwIDk2WQmGT99xuwUp44NUtJQO64YQER/oME5b4CKFpODjcz8u2W6Oga6jWf/ZqbpHOXsUjsPKZk+bdRdBZ77ObNTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=pVZS1RtZ; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 27CA82C5885;
	Thu,  9 Oct 2025 15:58:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760021924;
	bh=xYThC8cj/xCCOy6wVjLm9mf3iVTO58ekPonFxrGiFsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pVZS1RtZ03b65q4kEz5UWfQPRzK9cUzTQEHYNznbaoq14fcWRYj9C8sJonSXgBC2C
	 TdNnVtldKUtKOqcyCkaoAa2jGM1DOt2d+fGfNr7Hief94mhBwVJSbzAzcSsNp8aPqU
	 C+guJxS1wOWp2u72AUWl1B8E2QJskd0i9j+PvieI=
Message-ID: <9e72962e-3d4b-4e1a-b206-512904d701ff@harmstone.com>
Date: Thu, 9 Oct 2025 15:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 09/17] btrfs: release BG lock before calling
 btrfs_link_bg_list()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-10-mark@harmstone.com>
 <CAL3q7H6k9Uxy_aAN5VV8q9OQFUSiGtX_NhuV8C0TCgUQjAgu8A@mail.gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <CAL3q7H6k9Uxy_aAN5VV8q9OQFUSiGtX_NhuV8C0TCgUQjAgu8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/10/2025 12.56 pm, Filipe Manana wrote:
> On Thu, Oct 9, 2025 at 12:29 PM Mark Harmstone <mark@harmstone.com> wrote:
>>
>> Release block_group->lock before calling btrfs_link_bg_list() in
>> btrfs_delete_unused_bgs(), as this was causing lockdep issues.
> 
> I believe this was asked before:
> 
> What issues?
> Do we have for example any other place where we have a different
> locking order and can cause a deadlock?
> 
> Can you please paste the lockdep splat?

I didn't take a copy the first time, and I've not been able to replicate it
since.

But you can see the issue in patch 4, "btrfs: remove remapped block groups
from the free-space tree". In btrfs_discard_punt_unused_bgs_list() we acquire
unused_bgs_lock to loop through the unused_bgs list, then take the individual
BG lock so we can check its flags.

In btrfs_delete_unused_bgs() we're acquiring the unused_bgs lock through
btrfs_link_bg_list(), while still unnecessarily holding the BG lock.

The reason it's in this patchset is that a minor existing bug (holding a
spinlock longer than we strictly need to) becomes a potential deadlock because
of patch 4.

> 
>>
>> This lock isn't held in any other place that we call btrfs_link_bg_list(), as
>> the block group lists are manipulated while holding fs_info->unused_bgs_lock.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> Fixes: 0497dfba98c0 ("btrfs: codify pattern for adding block_group to bg_list")
> 
> Also as told before, this doesn't seem related to the rest of the
> patchset (the new remap tree feature).
> So instead of dragging this along in every new version of the
> patchset, can you please make it a standalone patch and remove it from
> future versions of the patchset?
> 
> Thanks.
> 
>> ---
>>   fs/btrfs/block-group.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index d3433a5b169f..a3c984f905fc 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>                  if ((space_info->total_bytes - block_group->length < used &&
>>                       block_group->zone_unusable < block_group->length) ||
>>                      has_unwritten_metadata(block_group)) {
>> +                       spin_unlock(&block_group->lock);
>> +
>>                          /*
>>                           * Add a reference for the list, compensate for the ref
>>                           * drop under the "next" label for the
>> @@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>                          btrfs_link_bg_list(block_group, &retry_list);
>>
>>                          trace_btrfs_skip_unused_block_group(block_group);
>> -                       spin_unlock(&block_group->lock);
>>                          spin_unlock(&space_info->lock);
>>                          up_write(&space_info->groups_sem);
>>                          goto next;
>> --
>> 2.49.1
>>
>>


