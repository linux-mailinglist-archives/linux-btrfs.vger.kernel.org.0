Return-Path: <linux-btrfs+bounces-4892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCA8C26C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ED71C21F80
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FA016E898;
	Fri, 10 May 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FGm6OJkn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862683FB87
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351130; cv=none; b=mj41yCRCuidi1jtspemUnjUO35y1KEvM5UdFp+knYPjixYkeEPctpCUWEFrGHI2p98Ds8WmXqhDlKXY6IlNkD5Cn4q0FJJYGWNt2CSoiQP0Uz490HWtx7Q8Kewd7kmb0ACSq+G3OBsLcLU5DyQkzRaL1KRYKJtpaQx5zHJUXQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351130; c=relaxed/simple;
	bh=//EM+BhFoOPlMkXyBeQjsAEjiOeQytutYei5cWpmqr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkloD+mSedygIJQdq3IQn3uegU1S+VJIB6zzz5BDO13ksg88y4JQ3awHxeCLH/dANM75UJtV6qP0BNGL72Ry9Q82xBCNX0B9n8+/QdgTY6yIdulqggb/wDmxRsOPhk3UL8lXe4w1bzd3AODAdz+nPLl6J/3jyK7ZX0jpRVvMgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FGm6OJkn; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b4cbb8834so20028367b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715351127; x=1715955927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUZfLmLipWuW0cgG/AUEeIay95qRcvy4L1VJvQgFQg=;
        b=FGm6OJknSvJDRGZ1NQpUYKMKIrVpKjx3ItYC3eKOOUn1WxpZQhIEvzSNpYj8wAcXCv
         jH9NH7YxdTkCIr4FoVoe9KFu8Gs/+Sx3PdNMeuhjr0XtIM+AftTiEKQ6tOFSwv2oI/am
         SYhY6pSwtD2bHN4MriYz+UdxyIVIj0LWaz5AbeJ5fBRAAYZePYDHPuQro8l8jhcXeKyW
         MeoazsC4ccQ7C01bWoegtfUaH5y3Aq6T7bN6F2Ruo4sGPvswrAOSLsi3/6qEwxfy0PUP
         yh7oQsMhgqYr3cBTr2uraWM0xGhDf+MUBYnfMNmd11NehOGn4PNpHWXgQjfcGo38E+xx
         lmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351127; x=1715955927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjUZfLmLipWuW0cgG/AUEeIay95qRcvy4L1VJvQgFQg=;
        b=hc2bXCbT6YawYdgsaA3UIT+ES938bBwNE3ms8kapkR9dVoU222TWPJcrzyf8iP+fet
         AeW1L72YtlSKXBGpsXlGuUfuYd21TSrFOFUFQBd9/EsL9fsouJKPvzi1keFiG3BE0w9P
         3XY0H5iwx8BWfxH6L7wijeLhyOx3Xdn2uth3Cc/oBt8KA1lgzb4Uof5AbjwcxzFqJOgS
         NaDzAfaV1AQU6RdAW+BJMhdlfXXvEDkvArGGfLINXxikj0uwI9w3gAQYsagrEb/sg5eF
         CfMxkDivLsgO2Y0VumH8GngHDvObubut6jacpHXotjHIv+ycNjNCa0VFuqxXKIlAlS+B
         W2JQ==
X-Gm-Message-State: AOJu0YwKU/zl+6blPFjXIadXbH12OEV3wvbX3vFJhMpxATdwGMOeAYP7
	E0v9eCUZ8GCaR3knUBSOPBXoPesb9gkHNGhURvyPcfzT5Bc3XZkMlOUmgLTHqjzA2GBECemb1hc
	D
X-Google-Smtp-Source: AGHT+IEmH1wF3UaJ++j27vEhLJ/5t/HXcw8JCvneTChSZhrsB31CpIsaEYcIpcZW8FX45Ul5XNnEyw==
X-Received: by 2002:a05:690c:388:b0:61a:fefd:ee26 with SMTP id 00721157ae682-622aff903c8mr30335387b3.1.1715351127391;
        Fri, 10 May 2024 07:25:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e3472acsm7559367b3.76.2024.05.10.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:25:27 -0700 (PDT)
Date: Fri, 10 May 2024 10:25:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: do not clear page dirty inside
 extent_write_locked_range()
Message-ID: <20240510142525.GA90506@perftesting>
References: <cover.1709677986.git.wqu@suse.com>
 <ebf001731e2ebafd5c2a435a7e0848634a421ed7.1709677986.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf001731e2ebafd5c2a435a7e0848634a421ed7.1709677986.git.wqu@suse.com>

On Wed, Mar 06, 2024 at 09:05:33AM +1030, Qu Wenruo wrote:
> [BUG]
> For subpage + zoned case, btrfs can easily hang with the following
> workload, even with previous subpage delalloc rework:
> 
>  # mkfs.btrfs -s 4k -f $dev
>  # mount $dev $mnt
>  # xfs_io -f -c "pwrite 32k 128k" $mnt/foobar
>  # umount $mnt
> 
> The system would hang at unmount due to unfinished ordered extents.
> 
> Above $dev is a tcmu-runner emulated zoned HDD, which has a max zone
> append size of 64K, and the system has 64K page size.
> 

This whole explanation confuses me, because in the normal case we clear the
whole page dirty before we enter into __extent_writepage_io(), so what we're
doing here is no different than the regular case, so I don't get how this is a
problem?

> [CAUSE]
> There is a bug involved in extent_write_locked_range() (well, I'm
> already surprised by how many subpage incompatible code are inside that
> function):
> 
> - If @pages_dirty is true, we will clear the page dirty flag for the
>   whole page
> 
>   This means, for above case, since the max zone append size is 64K,
>   we got an ordered extent sized 64K, resulting the following writeback
>   range:
> 
>   0               64K                 128K            192K
>   |       |///////|///////////////////|/////////|
>           32K               96K
>            \       OE      /
> 
>   |///| = subpage dirty range
> 
>   And when we go into the __extent_writepage_io() call to submit [32K,
>   64K), extent_write_locked_range() would find it's the locked page, and
>   not clear its page dirty flag, so the submission go without any
>   problem.
> 
>   But when we go into the [64K, 96K) range for the second half of the
>   ordered extent, extent_write_locked_range() would clear the page dirty
>   flag for the whole page range [64K, 128K), resulting the following
>   layout:
> 
>   0               64K                 128K            192K
>   |       |///////|         |         |/////////|
>           32K               96K
>            \       OE      /

Huh?  We come into extent_write_locked_range(), the first page is the locked
page so we don't clear dirty, because it's already been cleared dirty by the
original start from extent_write_cache_pages() right?  So we would have

Actual page
[0, 64k) !PageDirty()
[64k, 128k) PageDirty()

Subpage
[0, 64k) not dirty
[64k, 160k) dirty

> 
>   Then inside __extent_writepage_io(), since the page is no longer
>   dirty, we skip the submission, causing only half of the ordered extent
>   can be finished, thus hanging the whole system.

Huh? We _always_ call __extent_writepage_io() with the actual page not dirty, so
how are we skipping the submission?  We only clear the subpage range for the
part we actually submitted.

This needs a better explanation, because I'm super confused about how the page
state matters here when the main path does exactly this.  Thanks,

Josef

