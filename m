Return-Path: <linux-btrfs+bounces-12328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38AFA651EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 14:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9A7A5EAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90023FC49;
	Mon, 17 Mar 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="fKVBbdN3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A923F422
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219831; cv=none; b=QwAf+CYZepHJOtTVAgj/ZLFwxnhuC1uXPIQXW8vYFacMyvMlf7ONkb7kLECxxin36VXRHzE5Tp4Vda36fe6bNTTGYlS8l/29GlW9BBHeU6BJlFCC4pLSTg85Aiat5RZZPX4kGr6f8LPYqz/vXO1OOXe4elkyQu+/qhASK1qMqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219831; c=relaxed/simple;
	bh=0/JBhcmr6RbYakMo+6DE8lgQPZhpL+1uoSnywA7R3cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmqXHOMActvbuGYrx3NvugA7gvP1o6Ih/NugTaELPTNugr2ZQpneAOhXoBmqVKBXTOY5edcSfi9wx99nLTxyboVbo25Gs5Okm/KZrAf8gFmYmdyQ9+YLu9X+GoEleOIhlx9/kVM/xHxogUPp9eeAget5Vox15U1wKSUtSYOfZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=fKVBbdN3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso138662939f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219828; x=1742824628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SfYp7nbKw8yT4ZK7FK7ta60vIOnSkRlh8C+eZnMPUg=;
        b=fKVBbdN3cuvigvxP1zYXuYCTGnjRCfwERQAlbtT98ZJ5J6PyZREdmEyxSpEHH8Dax8
         X/8gP/b6PUUEwKERr4juhINSNzHD769FfL2VkgbuF7rtNRAkyUdYk+hA8uE5EXEuZFQB
         +AUz2C4EADEiv9NUAJQusO638Qbc1adxh0BHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219828; x=1742824628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SfYp7nbKw8yT4ZK7FK7ta60vIOnSkRlh8C+eZnMPUg=;
        b=DoT/IHu87AdjFt3n69s+1cBup4y7epxKgwW3r29IX3v7v55rUfGaJAT8ueqIJKJ9v7
         t9mBnoELeqmPeSfoxv6rzccETj4OIVIuPOKxEpGBU5jCeUXO7H88BKYSag2Lmx4huUzt
         WVuMAfff+ghJ53RlW7Geq7cRrKF/i64CfRMOHGESVYwWsQCX9Wt344pT8EAEKq7WUtXZ
         e6Q6klaKfRwpbh7GGAxXezQScV+Abdx722nHUd132OBki3nrAZ4w+nm4b/R+UsFEskkX
         mXAY3iv1BQSveBQ31lQhTbt0K7nYRThFIP2jMF88mRp3z738m6mMn9rqI/oZpfI42msC
         ezTA==
X-Forwarded-Encrypted: i=1; AJvYcCUm4XDGUUSJPgoCCcv/jpcGXvsm3HdWPDXKAot9ZqLqrc+pzhro99I2JOfw/7J5G1a7g0qMDvtNe0sWPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhn25Yh/Qh2Si7c/xJpbwzShUyvMQsqJ/ASEL94h2JtfBC/i47
	kDeKFkQjf4bZQjt+noQGF2Hfq6nm4wa3l1VTWlajCTsf2QLrZeBjdmyb8/9IuvI=
X-Gm-Gg: ASbGncugCyk8uJMX9d5UD8BwH+y0aW1+I3MfwhB7lfSmINtfV2SY7cF4iORbNZAq3o9
	zUGExJSzuJNQ2XiG5y09ksKfO2XCfMmbsbUQmoCHl6z4lW/X534SdnhKitBItQ5tXkpRiklweXp
	9DTk8k2j8sy6hxcIWX2IzDDHWa/fXxHdtBf5UcAB0ZJyrATj7nLHlUHvAvZ/8cqyFZq0+gPVMlM
	N9Gaj0xzteDIImLhc4vC1kGjtfQyz5NBNUQ55wt5/QwhFZcmdjIvwhG0L0fMSLvynBD25itWCGz
	tu4/MPo/++9JVqfqqLVG+GDkkGvoxd3SgXoPWlBCzq5eUH9L3nyZUDjwoqMA78bUfOCVHzFKYlO
	B
X-Google-Smtp-Source: AGHT+IHVUTBLBxTZC8HdLXhH7rWvOJoPaV2M14f1jVdqw63OUcUgLVqKDEC+//Li+SKHHS24f1zgCQ==
X-Received: by 2002:a5e:df42:0:b0:85b:3ae9:da01 with SMTP id ca18e2360f4ac-85db85a4420mr1487523439f.4.1742219828514;
        Mon, 17 Mar 2025 06:57:08 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637fb30dsm2273057173.90.2025.03.17.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:57:08 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:56:48 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/3] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9gqILpSLiHJXDGK@sidongui-MacBookPro.local>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
 <3c8fbd0d-b361-4da5-86e5-9ee3b909382b@gmail.com>
 <785d1da7-cf19-4f7b-a356-853e35992f82@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785d1da7-cf19-4f7b-a356-853e35992f82@meta.com>

On Mon, Mar 17, 2025 at 10:32:02AM +0000, Mark Harmstone wrote:
> On 16/3/25 07:22, Pavel Begunkov wrote:
> > > 
> > On 3/15/25 17:23, Sidong Yang wrote:
> >> This patche series introduce io_uring_cmd_import_vec. With this function,
> >> Multiple fixed buffer could be used in uring cmd. It's vectored version
> >> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> >> for new api for encoded read/write in btrfs by using uring cmd.
> >>
> >> There was approximately 10 percent of performance improvements through 
> >> benchmark.
> >> The benchmark code is in
> >> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
> >> ./main -l
> >> Elapsed time: 0.598997 seconds
> >> ./main -l -f
> >> Elapsed time: 0.540332 seconds
> > 
> > It's probably precise, but it's usually hard to judge about
> > performance from such short runs. Mark, do we have some benchmark
> > for the io_uring cmd?
> 
> Unfortunately not. My plan was to plug it in to btrfs-receive and to use 
> that as a benchmark, but it turned out that the limiting factor there 
> was the dentry locking.
> 
> Sidong, Pavel is right - your figures would be more useful if you ran it 
> 1,000 times or so.

Yes, it would be useful for large number of repetitions.

Thanks,
Sidong

> 
> Mark

