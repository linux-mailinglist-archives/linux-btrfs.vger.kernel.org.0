Return-Path: <linux-btrfs+bounces-7741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23575968EC7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4815A1C218A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C901A4E9D;
	Mon,  2 Sep 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd/qlJ8P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F351A4E66;
	Mon,  2 Sep 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308264; cv=none; b=WoWeHrpzGG+JEgvyPCNtgvXO7Q5DlOPmqaQ9GN6f6ITrK7jPiOof6VtrXDxrKNn8eFPWg2o6300LzA7lu1Ss6xNjVd27OSL3EE2glK88rWmS7CeOitRFhWFdj1U7S1o2prCgEICM8Nx6b5mE86mRui19bTLuPUjZh4wysqVbSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308264; c=relaxed/simple;
	bh=EB/x75EAibkANYQIaP3MTaEX9zr/3ffhy9x4AZEIMHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaWsTKjg5gIp6pLwMSkTBtDp8NdDlHoLVkubbjqBH9w7i/JTMyfnPJfc4f57D4i0h+FYoRwasJMfGlsUaP4AF4MM2Rg0dCQLhZp5YLhPECa1TnDoVSqj9AXF3yRd7M1hBYzqw1lGJThPxaFVQ3AdhcvruIHv1T9bgyoUGy4GvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd/qlJ8P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so28670305e9.0;
        Mon, 02 Sep 2024 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725308260; x=1725913060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMqAXZ/qtCvfEyB7syUW1Ky2cH4kdnpVfwZL+bkVgZU=;
        b=Zd/qlJ8PkNn5DXtx//EqIGi7MRITB/P19vAeqzrP7QUmlgDnS9rKiD+ZHnVg5tivSt
         FvQjZ6b+mCYW1L/EGJBg32PxJF9SgUd6dUuICKoxzaC4kLvuV1jehvLidbnQezHykUM4
         PYkgzYItCkygPSjTe5XibRxDO5u5olWrrmm+/DkFlfLVkBXXYfBFlvlBXuVV1Lr4h3t1
         lw67x/s19kZu8C+8/RgaeIUqlCWkSaREGtRCr4sJRf7H8ytb/Zm9BS5JR+s0aVSVODU+
         caD9zC/3H9GPyTj759oOU0ViB/rWzGgZfqcS9jAKzrQ3LdnIBAq0fQRYZRHDn4YPThxL
         pzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725308260; x=1725913060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMqAXZ/qtCvfEyB7syUW1Ky2cH4kdnpVfwZL+bkVgZU=;
        b=t3ZdGxEAxy/Rk6IiGrJtjs7+hYsXvnUjjUpfQGQndSh0YMhCcHW8J79UfBZjhCa4eZ
         BDz2CcZs2jVoQJMufRuJhhPaVa1X2DKim00ftZH9wQLQ/fpSNys57kJ4ySWaYp8hYwPs
         Uky+zk9PZ9CD9bFX0ZmcCstPduLOvMjZxgIAHibpu4tteGfTan8O3yoxiQsMYgyaFJD2
         PAlo/6j+/54VhNN3bMxe90n852YDxN5IicQSBJwIuP7F/ly3N5C7o9S3CpCU6qf3Cn+h
         3Kl9vARPUWyCr619WsIpoIrJJP7CSa2thKBrl7Hiq1qTNO3Yl5q1NlteFHdKuaVo0PwL
         NAhw==
X-Forwarded-Encrypted: i=1; AJvYcCVwLX8+INucc41wVowxNBguBEs5wp+epLQwTc2GRWWqsexFv/Wj5yzgSgHFSeJEprQyrrm7egH9cDiHZdv5@vger.kernel.org, AJvYcCW4wglTaU4RjIWxJLNWeqetCGwg6NxgozrNCTMnbV90xqJfAXG1BGU5Qq5/G4Jn08QPaoBwm9dy1SVwzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUUpi1P9OY1AhKqKcyJB9E0sIE9CoAy/AAGf1Y6LKCAG2WYaO
	QWSX/blZD6rYwWn37fYc4oPUG3zMryNT0V86QfyqphA83YJYPQ9C
X-Google-Smtp-Source: AGHT+IE2bNPNSqzBvVQl30H9s9ivT0ttIo+fYHOJROFk/QaEKdiHp1tBfI8jfFzEjoLPBVQ1RLOv6A==
X-Received: by 2002:a05:600c:4594:b0:426:6d1a:d497 with SMTP id 5b1f17b1804b1-42bb01b993amr109429415e9.12.1725308259724;
        Mon, 02 Sep 2024 13:17:39 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9c48csm12298552f8f.51.2024.09.02.13.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 13:17:39 -0700 (PDT)
Message-ID: <4bef0c7b-df8b-41dc-9fe1-022cc4937def@gmail.com>
Date: Mon, 2 Sep 2024 22:17:37 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Split remaining space to discard in chunks
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240902114303.922472-1-luca.stefani.ge1@gmail.com>
 <20240902201150.GB26776@twin.jikos.cz>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20240902201150.GB26776@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/09/24 22:11, David Sterba wrote:
> On Mon, Sep 02, 2024 at 01:43:00PM +0200, Luca Stefani wrote:
>> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
>> mostly empty although we will do the split according to our super block
>> locations, the last super block ends at 256G, we can submit a huge
>> discard for the range [256G, 8T), causing a super large delay.
> 
> I'm not sure that this will be different than what we already do, or
> have the large delays been observed in practice? The range passed to
> blkdev_issue_discard() might be large but internally it's still split to
> smaller sizes depending on the queue limits, IOW the device.
> 
> Bio is allocated and limited by bio_discard_limit(bdev, *sector);
> https://elixir.bootlin.com/linux/v6.10.7/source/block/blk-lib.c#L38
> 
>    struct bio *blk_alloc_discard_bio(struct block_device *bdev,
> 		  sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
>    {
> 	  sector_t bio_sects = min(*nr_sects, bio_discard_limit(bdev, *sector));
> 	  struct bio *bio;
> 
> 	  if (!bio_sects)
> 		  return NULL;
> 
> 	  bio = bio_alloc(bdev, 0, REQ_OP_DISCARD, gfp_mask);
>    ...
> 
> 
> Then used in __blkdev_issue_discard()
> https://elixir.bootlin.com/linux/v6.10.7/source/block/blk-lib.c#L63
> 
>    int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> 		  sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
>    {
> 	  struct bio *bio;
> 
> 	  while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
> 			  gfp_mask)))
> 		  *biop = bio_chain_and_submit(*biop, bio);
> 	  return 0;
>    }
> 
> This is basically just a loop, chopping the input range as needed. The
> btrfs code does effectively the same, there's only the superblock,
> progress accounting and error handling done.
> 
> As the maximum size of a single discard request depends on a device we
> don't need to artificially limit it because this would require more IO
> requests and can be slower.

Thanks for taking a look, this change was prompted after I've been 
seeing issues due to the discard kthread blocking an userspace process 
causing device not to suspend.
https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/ 
is the proposed solution, but Qu mentioned that there is another place 
where it could happen that I didn't cover, and I think what I change 
here (unless it's the wrong place) allows me to add the similar 
`btrfs_trim_interrupted` checks to stop.

Please let me know if that makes sense to you, if that's the case I 
guess it would make sense to send the 2 patches together?

Luca.

