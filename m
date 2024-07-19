Return-Path: <linux-btrfs+bounces-6612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B54937C8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5644A281843
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59A14830C;
	Fri, 19 Jul 2024 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aQCtLvDX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584161474D9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414201; cv=none; b=e2jUT6P2IpQ2mbf0NJG6bZcLQGv2V2Psb03zy/xg/p4X/V83OGUPsnM4/Gl2thk8Q99RQWsvuNUIP0UvXDmF1tQst8YMjyTcPtQjwDE75q75Ylu65wZ2gHB5I/Y7QQWNjw5p3dqrYQ/gVsbHFNIF8gN2dF09hny5T5mv5CukyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414201; c=relaxed/simple;
	bh=QnBQUlX45ocD3jq8zF5iSrDFgN2TUKW8+EAVGhK8EcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaQ7IW72lqjasw5R/k3/D6Z6D5KRyakpfDoxhUb4temdPdzUCwZrVeNNrub8F18D53yFJWpSMSHkYupUZlQ8C57ytpBc1gAiUIH+xGWnQSPLI+heYN7dIWu9hBfgpfBxN3I3NUjExre+3FfQTJM4CxCM0m3NNfKwi7i4jMJ27cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aQCtLvDX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so302738a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721414199; x=1722018999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgIIPiy59LqH51i7mlHEje4QzpR5GMIWcabgwztNVyk=;
        b=aQCtLvDXQ1cF/j+d7IUFeZGhKRkc784w+YugNz+OJIXK3bUpXOprIDcTZIBl5KC1nc
         J16nXJnjAQgLe4/CJbkQfaT8LymuK1+KO0VecLrTLBpg6DOTHeLuOycisSNXH9Y6R5LE
         eCGE520OnlT0xc88gHFW7soyeNlCwvkkVraM6vrT3SPt0a+USUAre4BR8GpMOMm+aXw+
         YvxBxLqixvTojmeU+ALqa732GuTC11PczOxha4YKV2xqWmGa3nLh3/YN9TZfFeNV5am4
         i7eovmuAqjx7zR76fFnr1FwVSQZvecVNH/kTT8pl2mCEO9IhIqdnMEFa2f08taoks9oY
         pDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414199; x=1722018999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgIIPiy59LqH51i7mlHEje4QzpR5GMIWcabgwztNVyk=;
        b=KIAT0X4MU012OPy0QJKcHylpcA3WJXVefBEf+RBtqWHtmBM61wQ+GJDLFUZekbXfOT
         ofUkMjYTCfXq2R/hXgD1zYweujaXJEcixdyufo0m6aZXzCKekyfRIMTF8tIOSqTejImh
         Xxh6ryglDdcNMqj4X5q4YSJIxjnSE9f4Q5cir9wW5jygOit71Uoxae2eLG2VPi9yIpPH
         RTJ4L0mPs1PaO/8oFb97BPVv7MyFEwENLg4IDxQdZqkHvJddfEVaGmlQYg0oJ4E7mFc5
         Bk9Sjuw1TvCKRn7tm3uU8Eh4eZ8zqxpLQL7uqKAdufISg3gL2tloESMomw4F1ayI0zez
         bjDw==
X-Forwarded-Encrypted: i=1; AJvYcCWxg7CNYMqvGLyHAtjnxYNAEQ2BPJigYCNCNjBzrh+D7mnkDh2wrQzqKSTg78vp+VJSW9j47H80JViO8sKq2HFIPsPmGTO0V34l34A=
X-Gm-Message-State: AOJu0YzZGNrkTcJbSL22pofuNyF11Jwm6NPu+trSVvwWGNfd5aPxscfb
	r0GjxypAP7b43CXXDrZOjdumimbwkEjxrzYkX71dsrDPq/BMHr0VYDqN4j0l8mo=
X-Google-Smtp-Source: AGHT+IElkL/zBCFHHaWiQ9kI38/vtt00gS40YnBc/B370nhydxYj7oNbKI27NQ4SuuKDpOrOGcNOuA==
X-Received: by 2002:a17:90b:20b:b0:2cb:4382:99f1 with SMTP id 98e67ed59e1d1-2cd16191fcdmr555838a91.6.1721414198645;
        Fri, 19 Jul 2024 11:36:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2f300sm2025155a91.10.2024.07.19.11.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 11:36:38 -0700 (PDT)
Message-ID: <a59b75dd-8e82-4508-a34e-230827557dcb@kernel.dk>
Date: Fri, 19 Jul 2024 12:36:35 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
 David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>, Avinesh Kumar <akumar@suse.de>
References: <20240719174325.GA775414@pevik>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240719174325.GA775414@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/24 11:43 AM, Petr Vorel wrote:
> Hi all,
> 
> LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
> down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
> tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
> 16 other processes reads the buffer and check only zero is there.
> 
> Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> (Non default parameter creates much smaller file, thus the change is not that
> obvious).
> 
> Because the slowdown has been here for few kernel releases I suppose nobody
> complained and the test is somehow artificial (nobody uses this in a real world).
> But still it'd be good to double check the problem. I can bisect a particular
> commit.
> 
> Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
> performance" [4] block layer change somehow related?

No, because that got disabled before release for unrelated reasons. Why
don't you just bisect it, since you have a simple test case?

-- 
Jens Axboe


