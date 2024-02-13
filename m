Return-Path: <linux-btrfs+bounces-2352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89211853475
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C60E1F24A84
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698855DF02;
	Tue, 13 Feb 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="K/gYimkJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1B55C39
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837709; cv=none; b=hfl20W4tLxADr/MyYbEXr/m+YAUkf/eL17TA7FrV+iUVThVmnBOoEvoBYahIqudlntRIVQYmMiDMyD5dEOPb1vVan9MAYZtRQ8jYnXO6yTNynddVxikaHz58ReKNMHCGC98Q9LLzJyDwAdyt8dBo9nqZoid7+ZqxgZ77hJ4KRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837709; c=relaxed/simple;
	bh=Lth7fmDr3e5suv2Jfqbng2UM6La1wdBih7qMXH23Dyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEnpVjwFoKu86slTUBtA7lIDjJynsx8t4ZVZyZAdsv//Ynlt5R3Ezzk9z0LCBpidMD+iewaMbBKfv2WNE416RW+rGC8tYZG5jGW/Lwu29LtKo8kkEAr0CH2P9Jr8NMN2z082GuMfs4oibqAfjOfbrCGF8wJv3t0PTVj6bmT3k0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=K/gYimkJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so3170938b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1707837706; x=1708442506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjMQ2p6uTYtjyBD0y9u8zXDFKYlRVPolot5juf3fw4Y=;
        b=K/gYimkJPt1IlCWmGa7/Iluppoyq66Us9bgDy+SPCFH+/+mONnaCEKOxL9HgKcZ5cq
         RPWozt3/rWhSHJX8W12kgWlBParuN8KA9ivczLcJR8l9QS8iBQM0AF4tKmFKSsOSGIRV
         7lqnUx5KYX6GChX5fJEMbz9O/oJf3J8x/imBqjomys17VS3t7bfS6pkO9xSgx08A74rJ
         9x5sHCl1xSMZrq9cScIwjIYzF37DNgNNuozPSVF0IL+zb9S5M4jT1XWRQStWZ4hJys32
         O8qMZnwOWnb+M4WbusfbL8Vq7lV7SP8tt3QvoeoPsSi//62tVe7/CkBnt16Gh1UITEpP
         ykuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837706; x=1708442506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjMQ2p6uTYtjyBD0y9u8zXDFKYlRVPolot5juf3fw4Y=;
        b=JZ8/r/U4wHr3Ib+7MBVCHIvobyHo7bllDAPR8ipkkc/PDE23JwiZMZHGjLjGedzKCh
         MW85gvZIs/hVCBRIlsmQDPVUBg/4Uy+WJL7zqE7H3DynFqVGNTLGPXRCz69ASnHVDQpf
         MEB770NZwPG9cYg4yW8rVU7g2RLjGVDmmFAYnRchV73EhZV+NIgVujMuemLcr2/xlW9M
         A3AQgWc+eg3tbPMjTwxDYoBrbnxfQIlZ5kVC/X4wMlpKN+R37gLcDiCjFTMRpkIzapou
         QvF8zKm9yYdOcsyYs/Oj9ycyjEKLx7VHtoQFkLMQDP3J0YdgGoYtdW4kCW1UbalxRGTx
         2FCQ==
X-Gm-Message-State: AOJu0YxY0RzRHAhXLrgFiynMZV3YULVItgD2yzmO5OVlkJg0YgeetHLJ
	TdpSD9oq3PGUFMnXU9twLGhivulJ441i6bYCncBHIBrfLBsY4+zAF7pn62mMHdFgvAWy23gDuAy
	0
X-Google-Smtp-Source: AGHT+IF5DayvZKJp52mP4Oi3MGylVHl/Z8DtuvlSWzuXA4MZTcR5wdXMCvaSPaFOHoiH3O6WzVcYOQ==
X-Received: by 2002:a05:6808:16ac:b0:3c0:3117:aed3 with SMTP id bb44-20020a05680816ac00b003c03117aed3mr10249525oib.18.1707837706016;
        Tue, 13 Feb 2024 07:21:46 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f22-20020a05622a105600b0042a233d21c2sm1201477qte.80.2024.02.13.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:21:45 -0800 (PST)
Date: Tue, 13 Feb 2024 10:21:44 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't refill whole delayed refs block reserve
 when starting transaction
Message-ID: <20240213152144.GA4107730@perftesting>
References: <eba624e8cef9a1e84c9e1ba0c8f32347aa487e63.1706892030.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba624e8cef9a1e84c9e1ba0c8f32347aa487e63.1706892030.git.fdmanana@suse.com>

On Fri, Feb 02, 2024 at 04:42:32PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Since commit 28270e25c69a ("btrfs: always reserve space for delayed refs
> when starting transaction") we started not only to reserve metadata space
> for the delayed refs a caller of btrfs_start_transaction() might generate
> but also to try to fully refill the delayed refs block reserve, because
> there are several case where we generate delayed refs and haven't reserved
> space for them, relying on the global block reserve. Relying too much on
> the global block reserve is not always safe, and can result in hitting
> -ENOSPC during transaction commits or worst, in rare cases, being unable
> to mount a filesystem that needs to do orphan cleanup or anything that
> requires modifying the filesystem during mount, and has no more
> unallocated space and the metadata space is nearly full. This was
> explained in detail in that commit's change log.
> 
> However the gap between the reserved amount and the size of the delayed
> refs block reserve can be huge, so attempting to reserve space for such
> a gap can result in allocating many metadata block groups that end up
> not being used. After a recent patch, with the subject:
> 
>   "btrfs: add new unused block groups to the list of unused block groups"
> 
> We started to add new block groups that are unused to the list of unused
> block groups, to avoid having them around for a very long time in case
> they are never used, because a block group is only added to the list of
> unused block groups when we deallocate the last extent or when mounting
> the filesystem and the block group has 0 bytes used. This is not a problem
> introduced by the commit mentioned earlier, it always existed as our
> metadata space reservations are, most of the time, pessimistic and end up
> not using all the space they reserved, so we can occasionally end up with
> one or two unused metadata block groups for a long period. However after
> that commit mentioned earlier, we are just more pessimistic in the
> metadata space reservations when starting a transaction and therefore the
> issue is more likely to happen.
> 
> This however is not always enough because we might create unused metadata
> block groups when reserving metadata space at a high rate if there's
> always a gap in the delayed refs block reserve and the cleaner kthread
> isn't triggered often enough or is busy with other work (running delayed
> iputs, cleaning deleted roots, etc), not to mention the block group's
> allocated space is only usable for a new block group after the transaction
> used to remove it is committed.

We should probably stop abusing the cleaner thread for this and just use work
items for the different categories of cleanup operations.  But that's just an
aside.

> 
> A user reported that he's getting a lot of allocated metadata block groups
> but the usage percentage of metadata space was very low compared to the
> total allocated space, specially after running a series of block group
> relocations.
> 
> So for now stop trying to refill the gap in the delayed refs block reserve
> and reserve space only for the delayed refs we are expected to generate
> when starting a transaction.
> 
> CC: stable@vger.kernel.org # 6.7+
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Link: https://lore.kernel.org/linux-btrfs/9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name/
> Link: https://lore.kernel.org/linux-btrfs/CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

