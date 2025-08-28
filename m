Return-Path: <linux-btrfs+bounces-16480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14794B39794
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE41888A1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF692EA163;
	Thu, 28 Aug 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="AVf5fT0Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD91C01
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371464; cv=none; b=a1XXpOLepBwjXRRyMuqcGxFAqY6t8ewHM5LP5K3W4yuF2ID89LaWtwJAzMeV6/ZtFarCKELmX8mxVvZPkw51JpwXpo/uGBdBUMJ2FI8263IsyF3/LaeIGVehoyEW6VvJaz5twl6gCRXnRZQlFLVNiiRSunCwvgHath5AIznYhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371464; c=relaxed/simple;
	bh=i0jDLyB+HBzyH8Wv+zfzBSUY43j4rVum9WRs+wLqujs=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cQ7CRdemHI/dlaKyL7qVXCAUkgpfKxHscR9xPColTUdlfLFNry8PrV6sZkb+Kb4b3Y2rh7mzmpw5XRU3RPo4o6cqulU9GMZoA3pIleSvRdwQxvSV5e6uy0aB09sqKSfqdcW8b6EOKzIb9gm3x+60Ld9gUjZpowBatTT7G5yHnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=AVf5fT0Z; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id A07912AE7AD;
	Thu, 28 Aug 2025 09:57:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756371456;
	bh=7asSvmrb3g+JruDUJK4h2PdPJ92OT8sNIgMbCizXH2w=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=AVf5fT0ZOXxfX6lM9sE89quuphx+JR+Se3Bwze/e5qTqWPq8N2t9TmNpFmSu2LADR
	 jEq3OLvL44qwrQFMOiMvqON9kvoiFWwxeEWz08PHjIUtuTgu7oEX+4cAn97KVXA7go
	 JGlrkYG9SBAd1kFESEcgJ7Wh+5JMvRPGvDD05Iyo=
Message-ID: <f39f365f-39dc-44fb-b0aa-f8cf87c9b71d@harmstone.com>
Date: Thu, 28 Aug 2025 09:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] btrfs: don't allow adding block device with 0 bytes
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <20250827103725.19637-1-mark@harmstone.com>
 <e37b9714-b079-4304-8067-9120d0f16637@gmx.com>
 <29f97f46-acdf-412e-8f05-6a131dcf6d3d@suse.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <29f97f46-acdf-412e-8f05-6a131dcf6d3d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/08/2025 11.05 pm, Qu Wenruo wrote:
> 
> 
> 在 2025/8/27 20:14, Qu Wenruo 写道:
>>
>>
>> 在 2025/8/27 20:07, Mark Harmstone 写道:
>>> Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the
>>> BLKGETSIZE64 ioctl on a block device returned a size of 0, this was no
>>> longer seen as an error condition.
>>
>> My bad, that commit changed the handling of zero sized device, previously the caller who checks the returned size now only checks if the ioctl/stat works.
>>
>> Feel free to send out a progs fix.
>>>
>>> Unfortunately this is how disconnected NBD devices behave, meaning that
>>> with btrfs-progs 6.16 it's now possible to add a device you can't
>>> remove:
>>>
>>> ~ # btrfs device add /dev/nbd0 /root/temp
>>> ~ # btrfs device remove /dev/nbd0 /root/temp
>>> ERROR: error removing device '/dev/nbd0': Invalid argument
>>>
>>> This check should always have been done kernel-side anyway, so add a
>>> check in btrfs_init_new_device() that the new device doesn't have a size
>>> of 0.
>>>
>>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>>
>> The extra kernel checks looks good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> In fact this reminds me to try other extreme situations.
> 
> Like adding a 64K sized device.
> 
> The result is, the fs will never be able to be mounted again, as we saved the cursed device which can not have the primary super block written.
> 
> Since we're here, can we enlarge the bdev size to <= BTRFS_DEVICE_RANGE_RESERVED?

Makes sense to me. I'll send another patch.

> 
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>   fs/btrfs/volumes.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 63b65f70a2b3..0757a546ff5c 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2726,6 +2726,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>           goto error;
>>>       }
>>> +    if (bdev_nr_bytes(file_bdev(bdev_file)) == 0) {
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>>       if (fs_devices->seeding) {
>>>           seeding_dev = true;
>>>           down_write(&sb->s_umount);
>>
> 


