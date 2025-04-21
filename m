Return-Path: <linux-btrfs+bounces-13194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58814A951AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC40189171D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF2265CDA;
	Mon, 21 Apr 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2wdKWh2Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06D26561A
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242151; cv=none; b=U1uRLpVgWDrBO8hmbapEtcTZHbvrh63m9c5hEtAPi7qg8ygAiIuuoEcKnX7pfwWgQ6ddip7swBPQBxYYGRszLgdPuTMWWV+1uTHQ9iMM76DfHvRggIJxsfUDO0AUEZSVXnrcbj/1Oz1IW8+MXypNHdQ9EVYnhAy25IqLyS8iFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242151; c=relaxed/simple;
	bh=UWUJ2SK8CIIbWWwD7CLFIC6pUMBqbKNHCfE0uGMrGM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GedSOVcJ3LWd3xa82EN07YcHJ0oW/ZoDLp4iX6an57kBJySJbuksgZt8EQe5yDKj7fNLoc2W3Po5FhW/22hPERrg8yOO5qdbRJTQNYcF4cB2lLkd8QxdBmmj7G3lTRob5+tstROq+ljlfUQtSulq7jfabtjLauTyJ1ly+e7OnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2wdKWh2Y; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7053f85f059so29257167b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745242149; x=1745846949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnrv6M3qGNWmiyy4mcQNYGOX8aPRJC6tFYttvLfN+DM=;
        b=2wdKWh2YFv2uRtGBBAuAx/mMdR/kjTa4n8qtlXRXjEVOlON7y5xCbjAMUg5NkwJ/cq
         1S8PxsaaoNxiFNkzIg4Z4bkSW7uaOwTOplJn2sNzQlMNTPEwtca+sM0q8/bam9Tfhu/E
         oISCGXsujA97vOFeuQrsmu+6VoJjImTyZOpnH3+hgqhglkf7bf/adnBhG5fo9Tt6lad7
         LETKKdKvCStwfWNYuwGPdJzP/bmwrx9oU2jNL8/G5QqogPRVhat1FurXn2GDzDqUtw/M
         QBpulW7XlOLEo+BQdCIKz3C/hOADUdzFFsDuaJsxi8jug4opLUG1FcK851ljDBFTWlri
         hDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242149; x=1745846949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnrv6M3qGNWmiyy4mcQNYGOX8aPRJC6tFYttvLfN+DM=;
        b=pe2/s4IW3Tv9zqKv92rX5exNoINRZMqwaHbEHoz07+wnzrw2cWWTvAVdtF8TGTxvry
         5z+YpeTMxgvLkSCiZEXS7YkK+eI0V+E5XIWFaBSlyentmXo8x4fQ8ZWWjPD5cYFgmUMD
         velfgdoQ/WiDOYIwTymjM7dVauv99PMbM0xqd5MeX90O1GUEu3el6pCI4aU/0AhC+bGn
         vV6HKSemK3OJn3JSJdyqdMWnk2TqeRDfNxE7ZG1AG1CfqjYZ/bgE+6vOqxhUhk3F9MYF
         pl9Y1y+4PFl/HOLoqe2EcEt8gst/wlBDmZWyw0IX5Ji0Ey6cYoZDyf88N8qtc+zGCErO
         LYww==
X-Gm-Message-State: AOJu0YysrC2IQwrJ2rqRrJ9WvCQyChNTcQSBDPuKxSrsBwivjLM8e9zb
	mUwjKsHxJOm2Pwmhnj3Qp5uDZ3yu9a/35BrLmcEdy3GcxVVq89Zwd06hTsrSjHw=
X-Gm-Gg: ASbGnctBNXYI8wtK+lnCz0Y0x++tmwzBmjWcHn4Ke69hADbH45pzPzVadDSv0f2j1y6
	SHABhsYMolLf2VILBHK0dG/l4zBaH11dLdt9BcvXpkTLkt/2N7/u5LDmLsbccH/nYH0QD9GfCIn
	n0m8F0Woe0GImSzitA26DbtV/daEDT+JzQ/DwLJuvos4OCAc3DRKHUmFJHgUzak8aXj3L9wkc/0
	xr0AzE1M5ZRQMl6DTeF/wxDUaRLCINFZ4QS4pgV2JVB2fYl7bypR9IXRa4IA3bA07xjyq77LuQ+
	DRlBhtbsNS2WoHf7PrA011Vi9BgavUBWjN7nN7iFLSZf/N+4RVpWWpvd+QfZmiFUsj48ofWK1JG
	fsQ==
X-Google-Smtp-Source: AGHT+IHUPLRzsMvTGG6DjTpC5SK1gq3/jW3qEfZHb6t7huW6ypf+zkmaSK9c4867GNEx6JiRvdQQ+Q==
X-Received: by 2002:a05:690c:9a0a:b0:705:5ab0:ea07 with SMTP id 00721157ae682-706ccc8e67dmr166681727b3.2.1745242148958;
        Mon, 21 Apr 2025 06:29:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca46b09dsm18942657b3.42.2025.04.21.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:29:08 -0700 (PDT)
Date: Mon, 21 Apr 2025 09:29:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/8] btrfs: do not poking into the implementation
 details of bio_vec
Message-ID: <20250421132906.GA4175772@perftesting>
References: <cover.1745024799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745024799.git.wqu@suse.com>

On Sat, Apr 19, 2025 at 04:47:07PM +0930, Qu Wenruo wrote:
> - Fix a crash caused by incorrectly index sector_ptrs
>   The 5th patch, caused by missing increasement of the @offset variable.
> 
> - Use physical addresses instead of virtual addresses to handle HIGHMEM
>   The 6th patch, as we can still get sector_ptr from bio_sectors[] which
>   is using pages from the bio, and that can be highmem.
> 
>   However I can not do a proper test on this, as the latest kernel has
>   already rejected HIGHMEM64G option, thus even if my VM has extra 3GB
>   for HIGHMEM (total 6GB), I'm not sure if the kernel can really utilize
>   those high memories.
> 
>   Furthermore there seems to be other bugs in mm layer related to
>   HIGHMEM + PAGE, resulting zswap crash when try compressing a page to
>   be swapped out.
>   But at least several scrub/balance related test cases passed on x86
>   32bit with HIGHMEM and PAGE.
> 
>   I have tested with x86_64 (64 bit, no HIGHMEM), aarch64 (64bit, 64K
>   page size, no HIGHMEM) with no regression.
> 
> - Fix a incorrect __bio_add_page() usage in scrub_bio_add_sector()
>   The 6th patch, as bio_add_page() do extra bvec merging before
>   allocating a new bvec, but __bio_add_page() does not.
> 
>   This triggers WARN_ON_ONCE() in __bio_add_page() checking if the bio
>   is full.
> 
>   Fixing it by do the old bio_add_page() and ASSERT(), with extra
>   comment on we can not use __bio_add_page().
> 
> - Various minor commit message update
>   And full proper test runs.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

