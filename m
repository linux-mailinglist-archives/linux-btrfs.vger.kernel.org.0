Return-Path: <linux-btrfs+bounces-16934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A713B84BC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134EB1BC4E0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D63081CD;
	Thu, 18 Sep 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="bZeDPfWV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF830749E
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200724; cv=none; b=DoyWA90nhnF1+e07a5wBXSY5CYdXgs3mV/Gh63hRLAw2numQN+nTLN33xBhA7buOUgBDHHaCQFPH82Zj+zZajI1wsU3GfaiixspORJIqhBotDDcozZ0A0qFx5MmA2p0rLnqCPkiL+ZZRkoZHT4ze9mKRCI+1dBLrw82ZS+RD5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200724; c=relaxed/simple;
	bh=DE+L1du/6W8JBeY8qRhWTNPocI4xV/dMgM5pSMGGdA4=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlRB/ac9oWtipjypBnNOtu9Tp6nkLrJ4XQljTn99fjuhXGvGJg2o3DACM6/OS9YhrXsXPnWn0tEhpvIpQEQkn7FDRcW14FssmLc/1jJcMLa6+BreAASebC17Zg+wMM9xBXFTDvyD+o90m5erbXlbA6uFbYhmDdb4TxBmb0amWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=bZeDPfWV; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id CED6E2B9744;
	Thu, 18 Sep 2025 14:05:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1758200713;
	bh=Emj8Hy3E0bRJpcyOU9fg3el+bfRNUXgz1IhmmZOPHqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bZeDPfWVtGSDdU7sVOKzAcMHgISjcXjTi0VH5U8SOaLQrhfsnptknCzrRjRE8SBdp
	 Au7hV7yJ5jx8CyN5zXCEQyYPu6Io45hJbRDi8Gm9QH6bejvi1wmRilzNe015cHJ92S
	 4HU9XAA3zu5xTIeo0F3HsGs1QrlCosuvXQmOjTBY=
Message-ID: <eaf33285-5d77-4b7e-851a-61e40e61d3ae@harmstone.com>
Date: Thu, 18 Sep 2025 14:05:13 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Btrfs progs release 6.16.1
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
References: <20250910175007.23176-1-dsterba@suse.com>
 <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
 <20250918003344.GH5333@suse.cz>
 <26c2e470-6277-4957-8b8b-b12a2e567daa@harmstone.com>
 <CAL3q7H4WX5XddPyQ2+0a8yQaCW757+V8VVVO6byscY9ch+LzQw@mail.gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <CAL3q7H4WX5XddPyQ2+0a8yQaCW757+V8VVVO6byscY9ch+LzQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/09/2025 1.17 pm, Filipe Manana wrote:
> On Thu, Sep 18, 2025 at 6:10 AM Mark Harmstone <mark@harmstone.com> wrote:
>>
>> On 18/09/2025 1.33 am, David Sterba wrote:
>>> On Wed, Sep 17, 2025 at 04:41:43PM +0100, Filipe Manana wrote:
>>>> With this btrfs-progs release, running 'btrfs check' fails on a
>>>> filesystem created by an older mkfs.btrfs.
>>>
>>>> A bisection points to:
>>>>
>>>> commit e2cf6a03796b73d446b086022c0dfcf6a6552928
>>>> Author: Mark Harmstone <maharmstone@fb.com>
>>>> Date:   Fri Jul 18 15:26:27 2025 +0100
>>>>
>>>>       btrfs-progs: use btrfs_lookup_block_group() in check_free_space_tree()
>>>
>>> Thanks for the report, I'll do a release with this patch reverted unless
>>> there's an updated fix.
>>
>> The patch is correct: older versions of mkfs were creating spurious
>> free-space entries. btrfs-check was supposed to diagnose this but there
>> was a bug that meant it only triggered for entries at the end of the tree.
> 
> Sure, but now we have btrfs check failing for every fs created up to
> btrfs-progs v16.0 since we have the free space tree feature.
> That makes scripts fail since btrfs check returns a non-zero status
> now for such fs.
> Do we have any code to remove those unnecessary and harmless free space entries?
> 
> This will confuse and potentially scare some users, besides breaking
> scripts that verify the result from btrfs check exit status.

To be clear, this patch does address an actual issue: it caused me problems
while developing btrfs-discard-check. Leo independently ran into it last year
too.

btrfs rescue clear-space-cache will get rid of the error, though it's
obviously a little heavy-handed. I don't know if btrfs check --repair fixes
the FST.

Maybe the thing to do is to add a compat_flag to say that the FST doesn't
contain spurious entries, and to clean these up and set the flag on mount
if it's not there - what do you think? Like we have for
BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID already, though compat rather
than compat_ro because the kernel won't create these entries itself.

