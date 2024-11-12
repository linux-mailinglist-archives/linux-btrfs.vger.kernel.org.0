Return-Path: <linux-btrfs+bounces-9484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C59C4BEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 02:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1852DB2AA00
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F320968A;
	Tue, 12 Nov 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fk0xFeY6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D720495B
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375106; cv=none; b=VoupmvJc5ba7C10PVvQcIplGE4plXwyXIn5Mwp1oNQnXqFhiNHMjymSFoCj7bQeH5l+NeViO5g8d4kv3BhjCqbi2KN4/qByPWkRQYcAwzaxIx3hI/ePDVJfmGYEvgUAdwLwrWH8Qbo4y4I1U95x0aBa0ntIvsyQbjYWlHzsh5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375106; c=relaxed/simple;
	bh=IpmcEo62gy/fO5HtpCeApmyIz2PfIn6pOC2cdQ4GHCw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tG0PMILgMFcr7TRa40rFcZy8mph70NRmKWBMrPJVJRQgkK/vNf+16Qn9JH6bIDp2Ug+jEGJqX5J3SZSXeiMkbnoHydcRVK/QcI5RtoNxu7el1z+yEjM2XYh5PLMNj1PwrNraUJbTHqVdWdk78sJl2gr+G4eRyl70ioMi94/ndY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fk0xFeY6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so4099837a91.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 17:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731375105; x=1731979905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSfHWTqMzn0W64gOgi4COTx84X58NA2lJ4II/9gIMKs=;
        b=fk0xFeY6gtktU2cKAq0ApNA2Om+VG6icM8HW/NSp4HJFYfokmi1i6hDb4aiItvta1n
         7mcJFCXcJPADONGRaYrPW+jWrxeK+noSdnuKeEB50sbgKWo1sTi3umfD++jNuRrLL+GJ
         KtdktOSMUcMUpIVWkpDB3fVAWcU9RNvupqUK1M86Z8S0SGGIieqD7aveURpch2nnu8+Y
         tIIbLiONsjxrnhAIleWnTED3AcC+WuO3GCaB1lji8efZ2zC7832Y+etv7s9nWGsa4YcY
         nAV+Lrdo6vlH7hExClQhpCrOt50KS91yqjOwhoM96b1iHbGB+fwTmZhf9KMXz9EOtJcd
         fR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731375105; x=1731979905;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSfHWTqMzn0W64gOgi4COTx84X58NA2lJ4II/9gIMKs=;
        b=fgenpUzwOMUTnHl1rIN+SrNkjbeg3fADQvrtlKQ9dwyQA5ciqdmM0JrW+JFRyOCiqp
         GoOt5dK8fR7hQhWblp6yJhJ7kzuewvKE/dFnrJ1zmt7k/ArLH64GA2ZlAA3Wdm8bx1r/
         3wqqVRxoH6sGzzt9PIiLNxEDfCE9r+MeNwsNUm1ieTJLt3Xan+PYOoRVo05I0KZ76R5W
         sUF9PIlEXezckMVo1pQXRbeWohnY4/qjW0juADnKkNZlv2d+iV9Lz01lrB/QNqxlAgdT
         XNMCZckgN492/KdX9vScHejKPepj/QBE/0ba7p5w48P84Nl2bjRSZlEkWbHKIFoMugkD
         6sDg==
X-Forwarded-Encrypted: i=1; AJvYcCXgGFDhXxHi4lA9d4L84OgzC5lTbQox8rbKoKucO5VIE6ljX26/hJc0DK9AN1xgmNq/4f8mEpuTPcZM6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhP6gBJbCvw8t+KN54JGPtKnrZ9/Dg2/cBHj3/Ydqv+dymU57W
	3xb/OQvSOKImT3t5yoCj/qtG/Q9nINd0O1iAwiLOOmRLBCBMsd/dSrwJ7EcWw9E=
X-Google-Smtp-Source: AGHT+IGrJ7GoBrb8g7tX8vxgASw/4ctrZN1Qqxd0Yyhht39fAFMWQ6UdTE6G8NXshyU/lP4mJ98ijw==
X-Received: by 2002:a17:90b:5105:b0:2e2:d9f5:9cf7 with SMTP id 98e67ed59e1d1-2e9b17748f2mr18818948a91.26.1731375104857;
        Mon, 11 Nov 2024 17:31:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd31esm11349139a91.40.2024.11.11.17.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 17:31:44 -0800 (PST)
Message-ID: <33396695-7668-404f-8908-17c5badd5920@kernel.dk>
Date: Mon, 11 Nov 2024 18:31:42 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v3 0/16] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 4:37 PM, Jens Axboe wrote:
> I ran this through xfstests, and it found some of the issue listed as
> fixed below. This posted version passes the whole generic suite of
> xfstests. The xfstests patch is here:

FWIW, the xfs grouping also ran to completion after that, some hours
later... At least from the "is it semi sane, at least?" perspective, the
answer should be yes.

-- 
Jens Axboe

