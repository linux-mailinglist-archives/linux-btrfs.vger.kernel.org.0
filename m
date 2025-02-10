Return-Path: <linux-btrfs+bounces-11365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FDA2F542
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 18:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73A8168C0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EE12500BA;
	Mon, 10 Feb 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w/PEjIK2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8B241C98
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208472; cv=none; b=kRNuWQYMRabFOceblg6WZG69wSn2B/ItdR+o+f6cY8YKGr0I2pk5SzDtEsoG0X4fq+5XDfD5Zepl+tBmeG66NKOot07Ajt0zN8+gqlOOHyMOxA4iP+8oYCbe/7yiKlfPjyyPFX/SZx8DvxQCASjP/TFrGnnQ6XeGw507F7iVg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208472; c=relaxed/simple;
	bh=h1RrNgO2JnXpEE3kf0rLXEFJs2AVhfVXUbnaTq4Di1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdEPct3hvu708rR/YYDyuVPP29xMXV6csXxzgRF4GYASJ5oxaVEkrk/84gSVhIO1aejzSZo9+rUDQzN/jG4ULuN6tchR7qk5Z/OoulVq/xxIptgBSdhMfdb41ns3qDGln4S++1qzUKN7xA7USmz9dTwbqtb8PCP9sKqfMrCyzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w/PEjIK2; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso43667775ab.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 09:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739208467; x=1739813267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1e+CCor2sSpjHDRy4pw+5jDPKgJRsslhgXDbLmYV4w=;
        b=w/PEjIK2cWg++dHFWZhrGnuJ4kHBY/Z0wH4NLAm2HCyRV9VMHVGh80n9+QrNr/ceok
         yZLcud6Fa7ePQCpZgomKp+l3HwRH8flQwQwIuMWRpVUih0bcUqGFDXxVHJDZrB8BFmv6
         qHcnisLOFh1V0rBMdqbjjHW9p9xIlkKV4oF4yOEr+3WFyn62tCDEntkGaOCDjfirNnVc
         8yZr0RGM+x3GVwKVQxdy6htoRjUajQvAiHNuTX1vRxbLEJ6GyOXFeRSelCcblk47QKEj
         KObnbBVQbhAf6sYw8A6rN+YbDPY3LMv29mwDPyJP71zglDL/8BLHKcHeHOc4L6e22OId
         s5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208467; x=1739813267;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1e+CCor2sSpjHDRy4pw+5jDPKgJRsslhgXDbLmYV4w=;
        b=DNhPByPs9sF1cDayI/JJwOgsC6bwuxIk9b1knXTaRD80E7R0Bly8ovpnwoUtCx0WSQ
         Tc5IcPMnmM7EcmRASLYuw0NY3QBvOZUD+YMzjHbqi4+l0Y7F2Mo+OUQJDaOAvrqG4fx/
         vAc5LYV3D1m21bfBJW3C6q/0wLmQ6j+XHipnlucH+I3wClDz7t9D5s59G6m2TdN0AMU3
         2I+mW2GYoszrz3BQnSRiim0YtsAi+MVEE/tsWI+WYc6D08dMjEylGhrvb7qQXM9EeGGg
         TyP3cq3IyAydagOxUr0SQBHbOlbQtr8DyXKy4Giuuoqc7Z/rQBn2kErdN4P23P3OWvv9
         nv4w==
X-Forwarded-Encrypted: i=1; AJvYcCXPNFhAllH1puPT7KriPHgOdYvsmfDp8Ze2AMv05C6pheY1kYj/7Et32d1CKGBcLm7X556z4R3mtpLSIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5VaPv+6uUS/tCd1Fsm8wIsNGV1sbBayJ158iPsvbNJSeojm6
	elX4ngBJ+UF6F4iA/YeXK0EBGcxWdJxQIWgHW/QNgPuy+gGPKcHkKJIHIT4CD3I=
X-Gm-Gg: ASbGncuqgKKZEXQiQcxw5l1VJcA5cgSorXgxpYNKLk721ub/8ljyD69/KBz4jPyMnOL
	Ck7MuRHUn5iSd9Y4lEaKWGz4r3ZLkixrs6qOUtYbTLumkgcBHbCgzYt+kng9uCe09bDvzRnfb6K
	29Crl3y29xlEhZHUzan0RM/eCEC4BrTUKGUNLVS5FqcUcEKiV/LickdJomW7nhT/BXFd0PWCHyM
	vAG8659n74ZT3PYpa6K7n3SMwOnDMeIvXYQOA8YZRfPqTQA7AE2nQNqP+qa5LW9UDUFhefsd0eh
	A6swtI9z2oro
X-Google-Smtp-Source: AGHT+IGTvlmC4o0qVnPk2xlgNwuLB7DIV8A2LmzY74InRT/UFHc2o57pp5QW/7PfHETcO/P9jVTxhg==
X-Received: by 2002:a05:6e02:1d8a:b0:3d0:1fc4:edf2 with SMTP id e9e14a558f8ab-3d13dd2a9c4mr136342905ab.7.1739208467622;
        Mon, 10 Feb 2025 09:27:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecd3f3ba4asm2105675173.124.2025.02.10.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 09:27:47 -0800 (PST)
Message-ID: <f1d7f4e8-1960-48bf-9937-e4a43b5c9cad@kernel.dk>
Date: Mon, 10 Feb 2025 10:27:46 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add support for uncached writes
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <00cb89e6-225a-491f-b7f1-8a9465a7aabb@kernel.dk>
 <20250210172633.GR5777@twin.jikos.cz>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250210172633.GR5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 10:26 AM, David Sterba wrote:
> On Mon, Feb 03, 2025 at 09:35:42AM -0700, Jens Axboe wrote:
>> The read side is already covered as btrfs uses the generic filemap
>> helpers. For writes, just pass in FGP_DONTCACHE if uncached IO is being
>> done, then the folios created should be marked appropriately.
>>
>> For IO completion, ensure that writing back folios that are uncached
>> gets punted to one of the btrfs workers, as task context is needed for
>> that. Add an 'uncached_io' member to struct btrfs_bio to manage that.
>>
>> With that, add FOP_DONTCACHE to the btrfs file_operations fop_flags
>> structure, enabling use of RWF_DONTCACHE.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index bc2555c44a12..fd51dbc16176 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -337,7 +337,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
>>  	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
>>  
>>  	/* Metadata reads are checked and repaired by the submitter. */
>> -	if (is_data_bbio(bbio))
>> +	if (bio_op(&bbio->bio) == REQ_OP_READ && is_data_bbio(bbio))
>>  		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
>>  	else
>>  		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
>> @@ -354,7 +354,7 @@ static void btrfs_simple_end_io(struct bio *bio)
>>  	if (bio->bi_status)
>>  		btrfs_log_dev_io_error(bio, dev);
>>  
>> -	if (bio_op(bio) == REQ_OP_READ) {
>> +	if (bio_op(bio) == REQ_OP_READ || bbio->dropbehind_io) {
>>  		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
>>  		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
>>  	} else {
>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>> index e2fe16074ad6..b41c5236c93d 100644
>> --- a/fs/btrfs/bio.h
>> +++ b/fs/btrfs/bio.h
>> @@ -82,6 +82,8 @@ struct btrfs_bio {
>>  	/* Save the first error status of split bio. */
>>  	blk_status_t status;
>>  
>> +	bool dropbehind_io;
> 
> Changelog says this should be 'uncached_io', which is more
> understandable than 'dropbehind_io' (as in the folio helper)
> As it's just a rename I will fix it but would like to know if this is ok
> for you.

Yep that's fine with me - and honestly I think it's a better name, but
some renaming happened with the external changes.

> Otherwise the patch looks ok, thanks.

Thanks!

-- 
Jens Axboe

