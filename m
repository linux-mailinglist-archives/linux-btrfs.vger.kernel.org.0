Return-Path: <linux-btrfs+bounces-9483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C59C4BE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 02:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238BD1F2408D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F94205ADB;
	Tue, 12 Nov 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e1jpk10Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909C19D8B4
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375034; cv=none; b=L9mWZwhpb6cgbHwCFoIhm1Zy4bVFQkQenpJbfljlXDIg0lcnPfl7iMEZEV3+PEMPe+csI04Ug4ks0hiIcG2rw6EDJmonhHknWNC1yTXe1G5YyI8J2WHQyp5F8FLuXHDU1q2tTxBwDutVdWGRvK/BSlk63P9o/Dq3cIOeHYnXWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375034; c=relaxed/simple;
	bh=kvQxQPZb+pbqKRZxkmUFovRb+FsayfCtG7MBQpPB75o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsINfSe29GC0TEeaNA1yjHM86ijmIy60ZWORGx80u+4TeoUH5HZmMe5QTiJ1GaavnwIGlxBB5ennTD7wdmW/DWc5pcAhAZ6UoR3nnfoBZmn3rFoqPs4nsI5eUm1HVRwwOonQoHNvSaX5jd8LhnlQ7rIWRnKisTUYrt9x10X9VdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e1jpk10Y; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2884910c846so2312873fac.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 17:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731375031; x=1731979831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PDg0tSjlFeUxAIPTtiAToLxkA/17c0lKKw7nT3lUQk=;
        b=e1jpk10YrUEhx0ojNuIbvXF4ZRUiHjzlgvUrV4nHjFaLRa+CREi3WG63JywX/DsXHH
         e7bDk23d2GKW4AmP4mkJANGSZb99sfvrNBY8+Pn8FV3fa5TSCTwlz7uX5mmkKh6cLf6X
         X274Tvl+f3mZUUXGndvCtuTQgh0to0oC+2SPprRDZBje01yLQQUEonnniGEH0prZqIt4
         T2ZM2a+RRBtg7toOsm7gqC/LICuSmRv2K686qloJLM0TdxcDvXYPMgVYiUhZ79JRb61Y
         mhw/S8Fg9OxOGbKtpS2w6fgwfZc7n3G4ya/7D/xdcoDPnBBeoLiyZ946Clrrnj5RqaMu
         doDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731375031; x=1731979831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PDg0tSjlFeUxAIPTtiAToLxkA/17c0lKKw7nT3lUQk=;
        b=aqr58/WOU7o5jtRIBd6YTcwc3cnYcmLmYH5ZNMOmMaDqqoS1Yw7PPVoH4ADXwe0Qkf
         7trIGburxaeY9B0NoQRpJ4naeGKFl5BTZQwTUJ83f0hnYpq1DxcR7ISWL4U+l34bj2ur
         Jtw2pwCmHnJXeQ7G0wp62a5IRc6nhcONRDtl1GfQUU0jnBg6id7XJtRsaMRG/q2Horqz
         B8GhpzCLwvTYgCWEbZVSDdjj6llM4TnKX0/jdoDmuw2QGU0RQn8nfkfsg88c1jfha4Hl
         XLGz9kRwOyxlN2UJ4svYGN5oET3Ommw/t/VMdHR9q75Tt7+KfZJtQQ3Y91puV2riNSYM
         vGpA==
X-Forwarded-Encrypted: i=1; AJvYcCVZZgJB+/v7fLnKtbVemFi938LcwO8Kyw+ZfUBBRtMGxEeSq2ziGIqWRiE83HeYixJ8b+wX1fYgfqqPQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWN1vt3bx40iEvQZ95F47c75UT+7XVCmyTcfOcF08VVkztQWgk
	R3/Yvt6l6dCCBtsE3bAvQcw69Ea5LvkBmdiw3PUGGCLYQXWID0R7kNcAxvavpkM=
X-Google-Smtp-Source: AGHT+IGqvUXkNxRMjm59FWmOZDWXVanWGq+s8EdfS0LHz4JsCQ8CypwipkdKBom80N4jBII4HAWS8A==
X-Received: by 2002:a05:6871:5808:b0:288:b7f0:f8fc with SMTP id 586e51a60fabf-2956032e2f1mr10688895fac.41.1731375030823;
        Mon, 11 Nov 2024 17:30:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643cddsm7841408a12.54.2024.11.11.17.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 17:30:30 -0800 (PST)
Message-ID: <bc0ea54c-90c0-48f1-a9a1-50463ffc0d97@kernel.dk>
Date: Mon, 11 Nov 2024 18:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] iomap: make buffered writes work with RWF_UNCACHED
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-14-axboe@kernel.dk>
 <20241112010157.GE9421@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241112010157.GE9421@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:01 PM, Darrick J. Wong wrote:
> On Mon, Nov 11, 2024 at 04:37:40PM -0700, Jens Axboe wrote:
>> Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
>> set for a write, mark the folios being written with drop_writeback. Then
>> writeback completion will drop the pages. The write_iter handler simply
>> kicks off writeback for the pages, and writeback completion will take
>> care of the rest.
>>
>> This still needs the user of the iomap buffered write helpers to call
>> iocb_uncached_write() upon successful issue of the writes.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/iomap/buffered-io.c | 15 +++++++++++++--
>>  include/linux/iomap.h  |  4 +++-
>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index ef0b68bccbb6..2f2a5db04a68 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -603,6 +603,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>>  
>>  	if (iter->flags & IOMAP_NOWAIT)
>>  		fgp |= FGP_NOWAIT;
>> +	if (iter->flags & IOMAP_UNCACHED)
>> +		fgp |= FGP_UNCACHED;
>>  	fgp |= fgf_set_order(len);
>>  
>>  	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
>> @@ -1023,8 +1025,9 @@ ssize_t
>>  iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>>  		const struct iomap_ops *ops, void *private)
>>  {
>> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
>>  	struct iomap_iter iter = {
>> -		.inode		= iocb->ki_filp->f_mapping->host,
>> +		.inode		= mapping->host,
>>  		.pos		= iocb->ki_pos,
>>  		.len		= iov_iter_count(i),
>>  		.flags		= IOMAP_WRITE,
>> @@ -1034,9 +1037,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>>  
>>  	if (iocb->ki_flags & IOCB_NOWAIT)
>>  		iter.flags |= IOMAP_NOWAIT;
>> +	if (iocb->ki_flags & IOCB_UNCACHED)
>> +		iter.flags |= IOMAP_UNCACHED;
>>  
>> -	while ((ret = iomap_iter(&iter, ops)) > 0)
>> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
>> +		if (iocb->ki_flags & IOCB_UNCACHED)
>> +			iter.iomap.flags |= IOMAP_F_UNCACHED;
>>  		iter.processed = iomap_write_iter(&iter, i);
>> +	}
>>  
>>  	if (unlikely(iter.pos == iocb->ki_pos))
>>  		return ret;
>> @@ -1770,6 +1778,9 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>>  	size_t poff = offset_in_folio(folio, pos);
>>  	int error;
>>  
>> +	if (folio_test_uncached(folio))
>> +		wpc->iomap.flags |= IOMAP_F_UNCACHED;
>> +
>>  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
>>  new_ioend:
>>  		error = iomap_submit_ioend(wpc, 0);
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index f61407e3b121..2efc72df19a2 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -64,6 +64,7 @@ struct vm_fault;
>>  #define IOMAP_F_BUFFER_HEAD	0
>>  #endif /* CONFIG_BUFFER_HEAD */
>>  #define IOMAP_F_XATTR		(1U << 5)
>> +#define IOMAP_F_UNCACHED	(1U << 6)
> 
> This value ^^^ is set only by the core iomap code, right?

Correct

>>  /*
>>   * Flags set by the core iomap code during operations:
> 
> ...in which case it should be set down here.  It probably ought to have
> a description of what it does, too:

Ah yes indeed, good point. I'll move it and add a description.

> "IOMAP_F_UNCACHED is set to indicate that writes to the page cache (and
> hence writeback) will result in folios being evicted as soon as the
> updated bytes are written back to the storage."

Excellent, I'll go with that.

> If the writeback fails, does that mean that the dirty data will /not/ be
> retained in the page cache?  IIRC we finally got to the point where the
> major filesystems leave pagecache alone after writeback EIO.

Good question - didn't change any of those bits. It currently relies on
writeback completion to prune the ranges. So if an EIO completion
triggers writeback completion, then it'll get pruned. But for that case,
I suspect the range is still dirty, and hence the pruning would not
succeed, for obvious reasons. So you'd need further things on top of
that, I'm afraid.

> The rest of the mechanics looks nifty to me; there's plenty of places
> where this could be useful to me personally. :)

For sure, I think there are tons of use cases for this as well. Thanks
for taking a look!

-- 
Jens Axboe

