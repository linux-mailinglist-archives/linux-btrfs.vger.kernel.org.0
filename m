Return-Path: <linux-btrfs+bounces-7003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28988948EB3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9811B27431
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E11C462C;
	Tue,  6 Aug 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT1+6obA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DE1BF323
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946107; cv=none; b=q4x58eW+PbhK2eSrYySjiDyChO2yWrmPOwa35PKl5eBb74/yhSox9Q72wLU6Y92z/uh07zefce0Nulh0WkMZ7iiyAbHJ8hnVTuvOQaE7xfNMrL4OkWI8T1L4D7yMJrOF+LPgjRbabB9ZuBuKA4E2iEAgpzE8tNgXMHIbyn17aqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946107; c=relaxed/simple;
	bh=Z054/+6rL6YHIpasqm4v1NLzfUohn/QNlsw4y1ZojlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e+ltBPqPbLUCOdUDX9AqlEn2tXmYhWFL3Yppeuak8I1b0WDTWJlaI/1qdCxpMmcME46QXFnbDc3t6mHHmv+HnXlmggmWs5i58zhpM44cl72LGgjiXE2Ngfar859H+X12Ofwyx/xCw3b24QIsWZ/bdVNIHUsK02s3f023WT2fsDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT1+6obA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso5134251fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946103; x=1723550903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A417BtvCi4+j75YQBPeX4nJ+NytBqnc1c3nVN++XV0U=;
        b=OT1+6obApzgjGlUdTN+2YbCwTFhqEWcq/iEbS85kKjvHnKTqNycOP0uw0qEdMpQhth
         4AwHigjL935+4KTfqQMt23bMzaEr+k2gH7jkPmZEZpwcgAQMefLjf2HuivjabdLG00to
         wA8Pm7zjFiFIoXNIAkMPL1l4Gn8ijrtfLohRdRe52podZRzrvvzOGZWE3w16QRUPkR/2
         Na/8/Dyhsk4HvhRZtNodvfmU6fzqqAyah4mYiZ2I1DSo6KiY6kYUS6JEdaBIFkDS0BjD
         AHVFwi9w7ycEaDY/lB3KWaU1mkBMKFshofgGqBLwztK8RuFyM4xlhNhDR70Z4rRVjU3i
         RNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946103; x=1723550903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A417BtvCi4+j75YQBPeX4nJ+NytBqnc1c3nVN++XV0U=;
        b=EizM5//gGO3KRSaN3q63cAFFsxVfyHJ2D0p2kxLmkt/aiEqO+eWaZDCRC/Lc9bIe71
         A62Wbr6hLB7YXRx42TNITlegzOXvMtyZY5W5/UeBhMCyA3aDJ3WFbODHsEkd6meRkLwM
         U+M223Fjyz/V9Jt3aszWftLexxT320eD/NVjGecQmHgIkReXaQo9TZGzzN6qkc5qzuIr
         8M2wnkKKEM15MNTo/v1ooygbusF1SgnTg85VZPaTpFmo5gj9ITCFN5d5G/19IaJi/5sv
         e7QAuVSaGltjfaTMMJ3KMu1gSSBCnCqK0Wv9RZ6ANQROV6gCmNshdABGLRu0MYoGW0aG
         i7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXK/DvFlhTLiaH3G9+R1h5KJYpoXqhmRmiQ5TTGGDwGfhcECpq0FS7cqjhx7+IMI7bQCJni4xETqFLefQAbuAUdy3K1VTs+FhgTnG4=
X-Gm-Message-State: AOJu0YzWxXcazNnYaoaoF/bWz/BFox2F/wqYBZxZvEFUwhBVBqJwt97y
	mEaW+LPHIOU5xY6FgQSc6/K4qaEHKg0b1nsF0c9XkTJDvM4Rn669
X-Google-Smtp-Source: AGHT+IFJ8p1URKMzWR0KMQtSNpQPJHLiERIzb0TpmVkTl2DInQwrMj+OyPkkws4NokTq1q6rmoSqow==
X-Received: by 2002:a05:6512:4020:b0:52e:9905:eb98 with SMTP id 2adb3069b0e04-530bb387cd7mr11207021e87.35.1722946102819;
        Tue, 06 Aug 2024 05:08:22 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07ddesm1430944e87.4.2024.08.06.05.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:08:22 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <30687f37-32e9-4482-a453-7451ab05277a@gmail.com>
Date: Tue, 6 Aug 2024 12:08:21 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
 <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
 <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/24 11:23, Qu Wenruo wrote:

> When defrag happens, it triggers data COW, and screw up everything.

Yeah, making test files in NOCOW mode seems to prevent the issue.

> I'm not sure how high the value you set, but at least please do
> everything with default kernel config, not just crank the settings up.

Up to 50% of 32G RAM machine. More than enough for a 224M file.

Kernel defaults are meaningless anyway, as they are relative to RAM size. Even Linus admitted that: https://lwn.net/Articles/572921/

> And have you tried sync before compsize/fiemap?

Of course. I do sync on every step.

> If we try to lock the defrag range, to ensure them to land in a larger
> extent, I'm 100% sure MM guys won't be happy, it's blocking the most
> common way to reclaim memory.

Hmm, but couldn't Btrfs simply preallocate that space? I copied files much larger in size than the page cache and even entire RAM, they are totally fine as you could guess.
Is moving extents under the hood that different from copying files around?

> IIRC it's already in the document, although not that clear:
> 
>    The value is only advisory and the final size of the extents may
>    differ, depending on the state of the free space and fragmentation or
>    other internal logic.
> 
> To be honest, defrag is not recommended for modern extent based file
> systems already, thus there is no longer a common and good example to
> follow.
> 
> And for COW file systems, along with btrfs' specific bookend behavior,
> it brings a new level of complexity.
> 
> So overall, if you're not sure what the defrag internal logic is, nor
> have a clear problem you want to solve, do not defrag.

Well, I went into this hole for a reason.
I worked with some software piece which writes files sequentally, but in a very primitive POSIX-compliant way. For reference, ~17G file it produced was split into more than 1 million(!) extents. Basically shredding entire file into 16K pieces. Producing a no-joke access performance penalty even on SSD. In fact I only noticed the problem because of horrible disk performance with the file.

And I even tried to write it in NOCOW mode, but it didn't help, fragmentation level was the same. So it has nothing to do with CoW, it's Btrfs itself not really getting intentions of the software.
I'm not sure how it would behave with other filesystems, but for me it doesn't really look as a FS fault anyway.

So I ended up falling back to the old good defragmentation. Discovering the reported issue along the way, becaming a double-trouble for me.


