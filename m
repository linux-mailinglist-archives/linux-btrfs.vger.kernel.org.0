Return-Path: <linux-btrfs+bounces-3120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499B87694C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137E31F244E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620E22333;
	Fri,  8 Mar 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CifkeWXt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC020316
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917511; cv=none; b=F8qlFXGJhFL+dfvlQlXPfubFbm1isilpBuj/R6fBcdXcs4F2itDsYhCELrRmyb014Z/MS3YrfOXrp0NygcyIGBCuUaWclR5L+9iGFTbZyJmoRqkXB2657u0z21wqhVhg4t/uOt/NbVUWhFbMq4trjvcOU18662isJ8gGiaoE0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917511; c=relaxed/simple;
	bh=a9B1XKf5v4a+2i7pOUkHcFgBwp8ihsYwhnXpzw194+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgmgZaBMdFjrelauF/yfUh0WLWS84+5RCgd3YtRX0NLXnMy6VpXZLHgGuKpZ7iREW2W9qykbLqf4m6bnoWTJOxyV3FpmwheFwvcpIf5OVSLvAh7c9epCJDU1a9eOPLUIlqedeHfQwmltiwo74OQeYf559LYTUzOVmVlrI56v2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CifkeWXt; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c876b9d070so34932839f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 09:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709917507; x=1710522307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pt9oq3K3EFlza+ec+x3ugAytq31JzWCtDXSc9tgPdyg=;
        b=CifkeWXt8MULvB0rh2Dw87gIpnVZZqyT7d2k7PkQM70LVlq09Ocbye/u5g+rAPLkgE
         h+oujU74OO3HbSvlSUUVytFD5TbM1rCBXAluJFbWwPX3HoVa3WdKQJ2z3c7kDz74p9TO
         wJAPt9W+fdrrMLzUdUFBhRk4IF9wNlxeG1jgoWlCcWv/Np3UsvP+XlrfMOzlxvyXYjRo
         y3zwKg3Hy53trImEqDc4ZI6GP01ftaZsmPzaHZc49tbVn8hHb6+F0FptA8CshLYgL2tq
         k2CUelT9GKovtIrloNGQXy1+v71K2GrBSFIIyURb5EWJj5ar3V9pyGd7s46u9qIQxu5o
         6w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709917507; x=1710522307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt9oq3K3EFlza+ec+x3ugAytq31JzWCtDXSc9tgPdyg=;
        b=ArmzLf7qpijf7it4r9ozM9dT0r05gKz8l4Q8Z2wKYRsSIFTqZQN49sc1kXaFc9qch0
         wUAVFMfQqdqhCBVWBZCsb80HO4K48xctGznS9Ex09Y/w7M24C4rHyJxQdVr6unJlpl2y
         3CnX/uv9lbRifh9kgA12cqdQIt/bcvi7c+JZJAAoBS5YiBBRoFyHVtHhFsWyRQseX23n
         8KZpwG4UNx/MlLib1uKMIsviOwI+Jd6cr8H06Sm8qsDMBlG16wVddS278kk58u+Kj/IE
         l3eIwaF3KcBrqHTDthFfw1MdTBkubaV4IBFzICNq6C0mi7GK0RT7WxcBnq/khgS3PMml
         Jo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/ptZfcjI+gjkqOi4AUUOTRE1S4TSX45oPkJEtr8gIJY9LHSzDQ1vZjCSRXs31dYQNRv4w6tTbMt58+V05G7CzNAcMRvrlZ3J+qYg=
X-Gm-Message-State: AOJu0Yxfdy3894zreAkz/xSEhdK1kUTvAZQn+kXHwn1ZRvwFuhSwC9ln
	sAKmg7RgDE+J7MuMP/zZNts56xnPmU+HjW6McnWo8gkYzQWIPWOCk0aM1vb/Yk0=
X-Google-Smtp-Source: AGHT+IF7mIwvt3cedayTCmkSThguzKrWUC+b8e/OGO4yRw2KQGJBO/bSFddqcKtpqeOPe1BOt1/DQg==
X-Received: by 2002:a05:6e02:1a43:b0:365:224b:e5f7 with SMTP id u3-20020a056e021a4300b00365224be5f7mr2793675ilv.1.1709917507163;
        Fri, 08 Mar 2024 09:05:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y8-20020a029508000000b0047477265b90sm4767944jah.24.2024.03.08.09.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 09:05:06 -0800 (PST)
Message-ID: <eef12540-84b6-4591-a797-6cfea7b28d48@kernel.dk>
Date: Fri, 8 Mar 2024 10:05:04 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] fs: Initial atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
 djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
 ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com,
 Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20240226173612.1478858-1-john.g.garry@oracle.com>
 <20240226173612.1478858-4-john.g.garry@oracle.com>
 <1f68ab8c-e8c2-4669-a59a-65a645e568a3@kernel.dk>
 <67aa0476-e449-414c-8953-a5d3d0fe6857@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67aa0476-e449-414c-8953-a5d3d0fe6857@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/24 9:52 AM, John Garry wrote:
> On 08/03/2024 16:34, Jens Axboe wrote:
>> On 2/26/24 10:36 AM, John Garry wrote:
>>> diff --git a/io_uring/rw.c b/io_uring/rw.c
>>> index d5e79d9bdc71..099dda3ff151 100644
>>> --- a/io_uring/rw.c
>>> +++ b/io_uring/rw.c
>>> @@ -719,7 +719,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>>>       struct kiocb *kiocb = &rw->kiocb;
>>>       struct io_ring_ctx *ctx = req->ctx;
>>>       struct file *file = req->file;
>>> -    int ret;
>>> +    int ret, rw_type = (mode == FMODE_WRITE) ? WRITE : READ;
>>>         if (unlikely(!file || !(file->f_mode & mode)))
>>>           return -EBADF;
>>> @@ -728,7 +728,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>>>           req->flags |= io_file_get_flags(file);
>>>         kiocb->ki_flags = file->f_iocb_flags;
>>> -    ret = kiocb_set_rw_flags(kiocb, rw->flags);
>>> +    ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
>>>       if (unlikely(ret))
>>>           return ret;
>>>       kiocb->ki_flags |= IOCB_ALLOC_CACHE;
>> Not sure why you took the lazy way out here rather than just pass it in,
>> now there's another branhc in the hot path. NAK.
> 
> Are you saying to change io_rw_init_file() to this:
> 
> io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
> 
> And the callers can hardcode rw_type?

Yep, basically making the change identical to the aio one. Not sure why
you did it differently in those two spots.

-- 
Jens Axboe


