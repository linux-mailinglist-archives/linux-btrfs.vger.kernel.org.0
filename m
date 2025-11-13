Return-Path: <linux-btrfs+bounces-18942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59977C571B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7413B4E2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B7335BC1;
	Thu, 13 Nov 2025 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="r6PfVu5V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EF2D97A5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032171; cv=none; b=GXAgXx2IemuApSibGQRNQxJCd2N2/CwndLOVHAUPtspEr9h7OQJsECHWxuNI0oM1yMLJguSCaB11RNDzT7ak4tXkqIYjQoumNYDLTT0iJLTKmPS1RpP1FChUhqeJ/BsLg+xLAiTxlfiNJO+AOgkkISyAhBdQD1aMvBj4qrVAheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032171; c=relaxed/simple;
	bh=0BvfkWnmj68LZMELf50kpj4X9cXJWVXHBAKkLeD8Z9g=;
	h=Message-ID:Date:Mime-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JdznIYa5TTwCE/sBA3ayYgcu0LxO207R29xHaYhZVDvBIIsSNd4LHRY/mUBMnSYGCvfbwtzSwTfNYb4XJyTWvnlcqrM/0/4mZLoYG6lYiVC6jtOWksEWm8zebukCYp45MW0YrZ8h66f2p7kXEKPrM7VkGxVezOiqgQA9XFASSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=r6PfVu5V; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id B644B2DA0D9;
	Thu, 13 Nov 2025 11:09:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1763032158;
	bh=SLrpPfj42h0R5KhynO8i1plJ5WVlYGbumMhJhXe55dw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=r6PfVu5VYPVhvvr3O+9ySZvNyYNuMVsD2PFHWBilBuzrVycyBBs8iqO/3RARcTV/t
	 JAk9M6CdgHr6sl2EndTxh578FfOJcSdzja9+5ROn1Z+f8Dbeald6SbuIlDBe+HSOSD
	 AcOEVNOk9AUcCnS0+RPu2NJk3h+sY8vjknjqG/D0=
Message-ID: <cda4868d-91c3-491c-b22c-3f41562cb150@harmstone.com>
Date: Thu, 13 Nov 2025 11:09:18 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v5 09/16] btrfs: handle deletions from remapped block
 group
From: Mark Harmstone <mark@harmstone.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251110171511.20900-1-mark@harmstone.com>
 <20251110171511.20900-10-mark@harmstone.com>
 <aRQXxL7i/mc32zF6@devvm12410.ftw0.facebook.com>
 <c2db973e-a5ff-4268-adc9-df36aa0e59a9@harmstone.com>
Content-Language: en-US
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <c2db973e-a5ff-4268-adc9-df36aa0e59a9@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 6.51 pm, Mark Harmstone wrote:
... snip ...
>> As far as I can tell, this code is called from contexts which might not
>> be holding the reclaim mutex (extent freeing delayed ref logic) which
>> means it could run concurrently with btrfs_delete_unused_bgs(). Or is
>> the fact that we are not yet fully remapped mean that the remap logic is
>> still running while holding that mutex, so delete_unused_bgs can't run?
>>
>> With that in mind, I am somewhat concerned about the possibility that we
>> might be *on* the unused bgs list at this time, unless you know the
>> delete can't run concurrently, or that the remapped handling all assumes
>> it's possible we have concurrently run delete?
> 
> btrfs_mark_bg_fully_remapped() is called when the last identity remap of 
> a BG is removed: either from the relocation thread, or from deleting an 
> inode. So if balance is interrupted, it's possible for it to be run 
> without the reclaim mutex being held.
> 
> I think I need to investigate exactly why this can be called for a BG 
> that's on the unused_bgs list, it's not obvious why that can happen.

The answer is that btrfs_create_pending_block_groups(), which can create 
a new block group to satisfy a reservation, then immediately puts it on 
the unused list.

It remains on that list when allocations are made to it, but 
btrfs_delete_unused_bgs() will remove it from the list but bail when it 
sees it's actually used. (If you're looking to tighten up the BG list 
system this might be of interest.)

So I need to change it so that the bool bg->fully_remapped gets set 
holding the same bg->lock at the same time as identity_remap_count falls 
to 0, rather than later in btrfs_mark_bg_fully_remapped().

This is the fixed version of the potential race:

CPU0					CPU1
----					----

btrfs_create_pending_block_groups()
creates BG and adds to unused list

extent created in BG

balance started

balance cancelled before identity
remap processed (so reclaim mutex
doesn't prevent BG deletion job)

last identity map removed by rm,
bg->fully_remapped set

					btrfs_delete_unused_bgs()
					called, bails because of
					bg->fully_remapped

BG added to fully remapped list


