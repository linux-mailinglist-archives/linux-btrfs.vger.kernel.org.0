Return-Path: <linux-btrfs+bounces-9702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69D9CE737
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D931F21F97
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AC1D47A2;
	Fri, 15 Nov 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D3B7npL7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAB1D4613
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682900; cv=none; b=ehCDyIUIkc4Dc+qmgtusj0aD/htzaAsVcZogixfmc21DbjEopkGdcrtAE8LCxiMTdPZF/ge4xECsbRRBc0ozs5yUV0pNcHeglkSt2lnWxnlap4azOzd7RLv6sVpI8nRlNXNym3VywYC+UxMGZV6cIEugXA22aiPpXF/dnT1HiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682900; c=relaxed/simple;
	bh=FkN51oQ+95A1kaKWWqtWb69R2pZOBZA2x/xx+3M5Dhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYpmgZFLOzzKEjFYl8TDxnjMcjPN2sXGjJXiFyp+BayEDCW5IZ9m9gbl4Sosgm9jiQQ+D08rwbF8B/7SRGhgEfIzj0Xgc8NIM9KhK9aEkuocom9tSFhKJO0Hv0E+3XjfZYf/hqXibz/ecyeFb9/JeisAGMjSeVj8L/B4SBHxTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D3B7npL7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f968230bso912801b6e.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731682896; x=1732287696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daa6RCRSBOXDojMt+CYYvatICfCaMKTsm2GIsGdsz1o=;
        b=D3B7npL77Lxvhtbv94JNVbUPQgmEtmmFeS+vqopJ+840bJmpIWvIP2vHpXCaaJvqCm
         qk1W1AgJd+/CnqOwjI5pbr22jbUYgtnH80KGAVlo2+Kgl+q6kL24ovKYGA7/HIvD+pgu
         rOIn89UBDKmMqwvUOhq3Mgr2n2fUPc1JcUU293RIxTsPfX1ETl7s00UiV/q/dTolDgRd
         xEOI0uRv0AFT2AZmNo70/kcl6HAAQFlRN1RlVMjqd9pIC+usu3TBJcLBpuKTuaG5cO8l
         +/tt68kz4Z6xuJvF5aiEZRnp02IlT3Z9CGItG4BRQLXjIewaEq99rK+T6+yhfon3junW
         rUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682896; x=1732287696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daa6RCRSBOXDojMt+CYYvatICfCaMKTsm2GIsGdsz1o=;
        b=QXMPI8+OKEMAByYCJR1KdaXlI0N57QvbzhuXaNty5ggKcX7ppmYKaNKgCaHnZfoRwP
         /Cp51r+nnXO6DJGGFOH+CteYJDm/HWiEWlF4WIGxRvbQzltOe4jlDXn5KZF6uVYU05Cp
         CKwSeZ7rPqTPbf/QtScMAuH6HwzFP5gkpiMw6Ggx7M0ayygc1I8SS3Io/vtXADqBeMwa
         i0I2LwT9DmIFexdR34PVtGqaYHzjHZg21PO3Fvg9DFLH2pKJ0jCPKHUuxMbkLRIIfpmS
         CRDpT1/pdxn9PWZkerjDGIZJlUxy6HCcFPsHjjN8HYnVfncym6BYzDa22mceHpMup855
         Flcg==
X-Forwarded-Encrypted: i=1; AJvYcCWS2F7so/jjkMJK8+Plvw5TPrrdpA6mjIfnOl1yGU7d9RK173uAlJ5cvx9UytaxcMpGvbRc1+VSE5clsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaS2O+asRAEaZb3YesTUV5jB/Yb14OW0om+jxZX1uKP0Q1duI
	WODD69o0TbEszSxNAwB9w7QWFTh5MMLL1EDbz654VRZ3MrTM6yPSSeOqST3ZHEg=
X-Google-Smtp-Source: AGHT+IHUMI9fHXDh2gLJRoCs0tTa351RP+bVjNh9KTwP1t19tdcKal4tMfqXouiaHQoPBiHfxg/DmA==
X-Received: by 2002:a05:6808:2123:b0:3e6:3777:76a7 with SMTP id 5614622812f47-3e7bc7d4a70mr3117960b6e.23.1731682896434;
        Fri, 15 Nov 2024 07:01:36 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd10914sm529838b6e.12.2024.11.15.07.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:01:35 -0800 (PST)
Message-ID: <5c6b9c45-25fd-4a6a-bfcd-781431f5c6e0@kernel.dk>
Date: Fri, 15 Nov 2024 08:01:34 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] mm/filemap: add read support for RWF_UNCACHED
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, bfoster@redhat.com
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-10-axboe@kernel.dk>
 <66q2ojkbzy2l7ozzc4ilputbgvdtwav4r4qdvnl7x32tuutums@zachqbvl7y3w>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <66q2ojkbzy2l7ozzc4ilputbgvdtwav4r4qdvnl7x32tuutums@zachqbvl7y3w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 1:49 AM, Kirill A. Shutemov wrote:
> On Thu, Nov 14, 2024 at 08:25:12AM -0700, Jens Axboe wrote:
>> @@ -2595,6 +2601,20 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
>>  	return (pos1 >> shift == pos2 >> shift);
>>  }
>>  
>> +static void filemap_uncached_read(struct address_space *mapping,
>> +				  struct folio *folio)
>> +{
>> +	if (!folio_test_uncached(folio))
>> +		return;
>> +	if (folio_test_writeback(folio))
>> +		return;
> 
> Do we want to drop out here if the folio is dirty, but not yet under
> writeback?
> 
> It is checked inside folio_unmap_invalidate(), but we will lose
> PG_uncached if we get there.

True, seems prudent to skip if it's dirty as well, if only to avoid
losing uncached for that particular case. I'll add the tweak, thanks.

-- 
Jens Axboe

