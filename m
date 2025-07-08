Return-Path: <linux-btrfs+bounces-15337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEBEAFD648
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 20:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F28C585945
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1021CA1C;
	Tue,  8 Jul 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fe8WUe+5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB82AD16
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998670; cv=none; b=dnAViv6PC1nxx2Q5dod1EcXoN6c5VxR+a9ye56Z01r2PkSHGAuQHYsA9WZG8uNiEgqedMsaKKKXZiYostfrUT5OswuTSjULi6KjZT1LrX7mhc6lFzgY4cUPWIiihfbADa7Cf2wzbup41bfTbZOIjQYL+GHcFp3CDsFkanGLU+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998670; c=relaxed/simple;
	bh=LpOkjb+ecQQBtOWkcVVUBt5c7MvC87zMsmyehH6sHDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Klf3VONun20tsQO4Z8xhHOILm89QAIfLz/sbZpiHdZodBqoyenkZ2SCmXtMtIXMt4QAlXM9um5u8G2JmpTKwpj2LjIdfL4iF7IJtmhjujUk+84rowABCri17cwL37TUYLqZqsYlOyfqwhZFTuV7Si0znboPyW+w+nVhV22JDAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fe8WUe+5; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-879502274cfso28126239f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751998666; x=1752603466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7oks48muiKNQ9MQb0raKT3/XZo9cmEOj4qy77c9F8s=;
        b=Fe8WUe+5bI4LSraBHXz64gIq1Y6YQHak3Lbyk0xWGgqJewgRMwjkaAFEoiudlRA036
         eU7NMXRp2CCjCbB8HyiO1lMkXlDVFmvWXvkrvWpV3AZ1G0IGbuxNHLLWzZw+PKm/s43Y
         17sgU8aZaN7F3KELr4F3xlyHL4d8E6iH2JBjfSZxb6E7OJz9znHtOgGFeNJb3ygeKKTX
         zC7xaSSLSJcAmia3kkXONlJyPRTgdGQckLcG6JErKKETaG3Nj7QP7Td5l+4wlwMUZSRh
         59S+phlVk+5YfPwbqVrhbkEkfrzI/Q2SM+x16x0rZZzfwo7TRk7xA5lFjdIv0zoFRKG9
         unEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998666; x=1752603466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7oks48muiKNQ9MQb0raKT3/XZo9cmEOj4qy77c9F8s=;
        b=Gir+fe5tn1ba3R1XWL9du2zUSkDYH5H+FpX5uAM/URwQfhafVAIb4LFVRIdho/vCT0
         6kXYORjrn/DV5BiiqOBuJhXDNrH8IxGTNLkp0joX+4BKxLSsJt0ff+tfa+b3ENFuECdi
         oaYPIyYDrc4k5gXWpa1xnIu89qcv7hIFgpgHtZSFY9r0Laa15X9NYOYAAGc/jLBEAz0u
         qowlV7p9SJk8eMFUcJbU759s2lqHIwRlJTtIA5skLFBIK2HbF+WhkqKZFt/hiXCwmrYe
         tffnzI1F2AtTodyv+ZjzowwMkgktio1kszCW2XeGyCkhn5yS/lI52UjBzyYdb5uI7bff
         7RCw==
X-Forwarded-Encrypted: i=1; AJvYcCXj/jLKDgqO3WByn1BxHuJBdCWamK67AFDCN6phxvTPSvIFbY/Jn02qOobXms5U7ykqUzx+b8Qbf5ArpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx272y1OPKEmr+KQDjl+x6Op3SpMUUr3Hn1nCFwpHAsJooB+aIs
	mv+wQLYfGIOVAFpycf6ZN3V7dlGR4WAlgefGrJzBZZQLxiHcV0cVWYJtizZOz0OemtA=
X-Gm-Gg: ASbGnctf8duqqRQod53RiX4ybFM1vedwLbfhOYvoLiWyVdrI2bNOJ64MVIguoJ753t/
	4a7KGY0+ZP5iNV9W/5GTsNuUoIBJ3W5ykqHYaOoh5ShvoJgRCQjmemqVMYsozOMrIf1Xxgg4IP/
	MNKW9uaDLnobSnGw4IjKURotqPSC8o19Q4qn42nZGGfAOOQOqPlAGQ3lRmpKjog6JB9ANcnsZpR
	PWpIUQ7ZAThdBdky/Yye9Nk+O23j4yd6I7wLK3IjENxQdSVVVHQnQymao0CPgc8pJvoYmKLUjF6
	JO6yn0KdrVOdda53qUD7iM/hK8Smyce6nJjD2eoNnEtzHQwonJo/FMjEnQ==
X-Google-Smtp-Source: AGHT+IGQnxN9Juqo5ZTXTrtTXAYwJOZx2V2bAQvz67ZgmfrWs8KU5VcAU1pY9C/YikiytA7oWFC7vw==
X-Received: by 2002:a05:6602:2cd1:b0:875:dcde:77a9 with SMTP id ca18e2360f4ac-876e1667944mr1871390039f.14.1751998665602;
        Tue, 08 Jul 2025 11:17:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e07bc6bcsm297705939f.13.2025.07.08.11.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:17:44 -0700 (PDT)
Message-ID: <76ea020f-7f57-42d5-9f86-b21f732be603@kernel.dk>
Date: Tue, 8 Jul 2025 12:17:43 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in
 io_btrfs_cmd
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Mark Harmstone <maharmstone@fb.com>,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-4-csander@purestorage.com>
 <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
 <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 1:51 PM, Caleb Sander Mateos wrote:
> On Tue, Jul 1, 2025 at 3:06?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> @@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>>>       loff_t pos;
>>>       struct kiocb kiocb;
>>>       struct extent_state *cached_state = NULL;
>>>       u64 start, lockend;
>>>       void __user *sqe_addr;
>>> -     struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
>>> +     struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
>>> +     struct btrfs_uring_encoded_data *data = NULL;
>>> +
>>> +     if (cmd->flags & IORING_URING_CMD_REISSUE)
>>> +             data = bc->data;
>>
>> Can this be a btrfs io_btrfs_cmd specific flag? Doesn't seem like it
>> would need to be io_uring wide.
> 
> Maybe. But where are you thinking it would be stored? I don't think
> io_uring_cmd's pdu field would work because it's not initialized
> before the first call to ->uring_cmd(). That's the whole reason I
> needed to add a flag to tell whether this was the first call to
> ->uring_cmd() or a subsequent one.
> I also put the flag in the uring_cmd layer because that's where
> op_data was defined. Even though btrfs is the only current user of
> op_data, it seems like it was intended as a generic mechanism that
> other ->uring_cmd() implementations might want to use. It seems like
> the same argument would apply to this flag.
> Thoughts?

It's probably fine as-is, it was just some quick reading of it.

I'd like to stage this up so we can get it done for 6.17. Can you
respind with the other minor comments addressed? And then we can attempt
to work this out with the btrfs side.

-- 
Jens Axboe

