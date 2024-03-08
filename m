Return-Path: <linux-btrfs+bounces-3114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2707A876896
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581901C216EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF60199AB;
	Fri,  8 Mar 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wyK1BX4n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DE291E
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915673; cv=none; b=tfesxZAj8dZNfJZ2zoFrEW1F168ZLoYz+61N/m7zO4DBB6r1DnHrvs6JkF1NQdYpk3WF0BTTIZEwIADOv4O6Ht+tGaFPvmtilyEig0E+sWPvsxSRcsMwQSG0ArBzfpwtqOnZGnU8woiTr6aHlZs4mxI2u6oNzfdAU5+gj3ejvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915673; c=relaxed/simple;
	bh=q5UNepVTPD1GH0+Tfc1vBatyguN++q7xlhg95NlQekM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooYDzkTSOwKvzliMYg71EH3KcdzU0RuCTJIoB7Ah4XUDCQma7m1aI1br8XKbfKbT3YF4+3sPXtgNMekJjEnhvTWe6dyLHV4+vGirePT0cWP4ta34xRaslDyRLpNnPPBjOSg6XzI50rYSsHm14yXTHKVkCfk0S47Vk7oRqrQcRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wyK1BX4n; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-365c0dfc769so1967275ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709915670; x=1710520470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVfdzVKpWpFj9kbUNOF1nqFeLYyQI1R525d/19YRQ4U=;
        b=wyK1BX4nmUyi/9Fyhva6JrRyUVQMbvE3UbKW1DgbiZWlqZXlGEYkSdZLLh0Yd1u0ey
         6VAUc3UBY5xn2ZhzXT+3cTHZl2f6cIEfmX2wBmsPfvL45NfClGxbHZZGeiUDIu52H5pK
         ank2g9x6x/kx5bMwD6RazB9rWEBGWIXQU7gI1GlfLNyS/4Glws4IT455R7ezy7KfXzZK
         x353FseBOHQYqiwEOJbPsSNLOdpErFCKlwUEqqlRkEUf9HaHZs5GKpAflo9dnSkZ+vlV
         9+tF+LJcFWuKK/RiVXsjDZVAJCHLbjgEOSn6It04b0MlOH9qo6woPE9eAXokn7ZSaZwq
         uWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915670; x=1710520470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVfdzVKpWpFj9kbUNOF1nqFeLYyQI1R525d/19YRQ4U=;
        b=w29tOsNpTejsZlmZKjupaqm+bVPa8XZeEeyVSj0a6/Mc8mCo2kCW3BogvLaSvTE+nT
         x/Yu7E2+RJhc5k/R68ZcdLiuBoTUyXon82uScqnfsLL+iETGkvtjkHlcGNIwSMr8uYlx
         7qdRQkuqi6G7q1j6tGmHa8zwFf0bcLWKa7ysYAYeo8ncdkt+7XKY4gTMdvD8LLvritdz
         5Nuo4JCkdiaBMdzupuI9wmXtrQ/FefQGPWu0V2HNKhRD5OdKVuBeoG5mvq/3iuhZQS84
         5iVbwsjWnMbS8Ndi+oCm1GzaqEx6XCAcyNTmy/KP85Jf6i8wgOAF6vhRpFVFCPtnuknC
         e70w==
X-Forwarded-Encrypted: i=1; AJvYcCUKhHbBRtnoB+sf6d2/QWIbOmKoiEKQFKK5Bx763bDB2HOPUZ0t9cRUTGTWb5tzG/EQYPXL2bvWTSrIi4jfUcUmA08B6MkqsfJwl/4=
X-Gm-Message-State: AOJu0YwU9PA8dEgiQKbsduBRJhkap3Kb03X6cmyznh0vX8tqMANlZ0Qv
	o75hKgYhGmWw5yrYgBFluXuO7JQhg1DtyPYWTnLUXlmQXDaONCV7k3yHa6xXgJ8=
X-Google-Smtp-Source: AGHT+IGHrfD8uH6blQDQ3mMFkxIIRnaWM2NuWN/1meHvgLTE8CRbEPUrNlq2AATapXrEb2fcNbN9CA==
X-Received: by 2002:a6b:ee16:0:b0:7c8:718b:cff5 with SMTP id i22-20020a6bee16000000b007c8718bcff5mr2506789ioh.2.1709915670463;
        Fri, 08 Mar 2024 08:34:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b5-20020a029a05000000b00474dad114a6sm3654084jal.80.2024.03.08.08.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:34:29 -0800 (PST)
Message-ID: <1f68ab8c-e8c2-4669-a59a-65a645e568a3@kernel.dk>
Date: Fri, 8 Mar 2024 09:34:28 -0700
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240226173612.1478858-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/24 10:36 AM, John Garry wrote:
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index d5e79d9bdc71..099dda3ff151 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -719,7 +719,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  	struct kiocb *kiocb = &rw->kiocb;
>  	struct io_ring_ctx *ctx = req->ctx;
>  	struct file *file = req->file;
> -	int ret;
> +	int ret, rw_type = (mode == FMODE_WRITE) ? WRITE : READ;
>  
>  	if (unlikely(!file || !(file->f_mode & mode)))
>  		return -EBADF;
> @@ -728,7 +728,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  		req->flags |= io_file_get_flags(file);
>  
>  	kiocb->ki_flags = file->f_iocb_flags;
> -	ret = kiocb_set_rw_flags(kiocb, rw->flags);
> +	ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
>  	if (unlikely(ret))
>  		return ret;
>  	kiocb->ki_flags |= IOCB_ALLOC_CACHE;

Not sure why you took the lazy way out here rather than just pass it in,
now there's another branhc in the hot path. NAK.

-- 
Jens Axboe


