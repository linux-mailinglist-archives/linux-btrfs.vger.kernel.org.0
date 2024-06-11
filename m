Return-Path: <linux-btrfs+bounces-5660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C78904192
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD16A1F2499A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787AD51016;
	Tue, 11 Jun 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="y3SMqKoQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7D43AD2
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124598; cv=none; b=KDxRXa2iHFwH/JHc2vTB7p6oGsDnq/7rllU5BykeQjCAwc5TBwpVL+jtV910FvBYDdecUPugVsbLyYO5IIFOgcEPX8tLNJI2yJpFD8UnA4QIGuePmVAWlD4zXDR6IaNf2+aX9+FbpoLhnpt665l3jFCtqiMx0zA2jlwYz3TM5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124598; c=relaxed/simple;
	bh=MreIlMooNRf639ruyk8R4KbSz88+aCksPZ1DbVVAbvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3WZ8RauPu0ryOkxymbAAZ+ZbCb0zWUbbA9dcdGbj0wyqZaxnuvreLeoFraOJHqgh+elm+Hl42zBBgslRkRL0O8Jcz/EzD5G1Ltg2nRS04axObaWVAWcdbJQDxcWY+zM7Osa7FtTC9984HqUOXWkS3cwEAnGec9g/kx5vqPowWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=y3SMqKoQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-628c1f09f5cso16708967b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718124596; x=1718729396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JnGMgyfSYYWtEjlzPfN4hmoXT439HFNz0d94uVz2J4=;
        b=y3SMqKoQgWwszJShEg4lM1emGCZL8Rm/0WYtO5K38Jm2MRszr7rWq3D0eAVUUMXZ/6
         ksK7ms/M3wagkL2167CtQ5tB/hrKz4XSRBOAmGQjg9KpQwymGGR0BLBLX0aLF49Vkghv
         k3RfQgoF/ho0RMT0sT6ZGAJVJsTMzqeZYHBFDuDhgE6DxquzjFLcyT0GNZnXaLs0fFx2
         MmECccXLMaEjzPNyEgW9FhdtR9PPtWtjYiYDf0g9R1y5ncQljfLQk+otWRr2Gi44P+JK
         HiNafNxTpT4LO16567hhGBFOHyyRT9Ui0mHUZt+pGrMYlIqraG8Ds4gxD5S7dnA1md7w
         AQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124596; x=1718729396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JnGMgyfSYYWtEjlzPfN4hmoXT439HFNz0d94uVz2J4=;
        b=Dmi90uuucb2YFioyRC2AMJBkG37XXAss501imC+SceyngeEnmXXl2ooTcGbc7cGv+t
         Vfr2aP4qBX4uFroEmYR3g2hpSqAcaMeps6L8B1MMKkwGQP1WwGI2COkp7QyzGJtweAGU
         2L+M7tjBeOZA+HIlSA5/caBLuwAXkObWAf00yprvcPQ+AI03nY7SGs82T1SQ/SwSC3U9
         xMwj5pIbPtDwnmU4Q10c2jgBLdXhSjpx+nr+xk0Aad1wgYBrNU0rdLHpgYLPs2wND1PC
         qp3QLI0SR7t5BXxj6ACZ75ju90vE+UaHFikNWxiyMFUcw88ZAU1JQy4sG6oC5pUs4UtQ
         ol+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQSLFo6OhMm+xwhVAZSnyx42aVpCvzFyNB6kjHogjd6H/nSW+/QKOhxkuu1n3MLn5yS99m3oKmte8DFP6JGYbxWGumtH9n1mzVLww=
X-Gm-Message-State: AOJu0YwHMr6QoYWYit6KKgRA1QIyGeJvqejE9eu294qsG2OBcZGZ+Oyn
	CSAoUUo5IFsWQhEG1JpyRjRTKRK1+taW88/LZ/1LpjTYSvr7TA937qfX06ZWYMs=
X-Google-Smtp-Source: AGHT+IEgSQHZ9Ca/meY6ChiB+OY2zTSlD3WY3Cf/xA7fFzm7DHmZml5zF09haqocKRev36lx9709fA==
X-Received: by 2002:a81:5215:0:b0:627:972f:baba with SMTP id 00721157ae682-62cd55f7322mr129115757b3.31.1718124595699;
        Tue, 11 Jun 2024 09:49:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62cfb6e4638sm11635327b3.75.2024.06.11.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:49:55 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:49:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v3 0/2] rcu-based inode lookup for iget*
Message-ID: <20240611164953.GC247672@perftesting>
References: <20240611101633.507101-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611101633.507101-1-mjguzik@gmail.com>

On Tue, Jun 11, 2024 at 12:16:30PM +0200, Mateusz Guzik wrote:
> I think the appropriate blurb which needs to land here also needs to be
> in the commit message for the first patch, so here it is copy pasted
> with some modifications at the end:
> 
> [quote]
> Instantiating a new inode normally takes the global inode hash lock
> twice:
> 1. once to check if it happens to already be present
> 2. once to add it to the hash
> 
> The back-to-back lock/unlock pattern is known to degrade performance
> significantly, which is further exacerbated if the hash is heavily
> populated (long chains to walk, extending hold time). Arguably hash
> sizing and hashing algo need to be revisited, but that's beyond the
> scope of this patch.
> 
> A long term fix would introduce finer-grained locking. An attempt was
> made several times, most recently in [1], but the effort appears
> stalled.
> 
> A simpler idea which solves majority of the problem and which may be
> good enough for the time being is to use RCU for the initial lookup.
> Basic RCU support is already present in the hash. This being a temporary
> measure I tried to keep the change as small as possible.
> 
> iget_locked consumers (notably ext4) get away without any changes
> because inode comparison method is built-in.
> 
> iget5_locked and ilookup5_nowait consumers pass a custom callback. Since
> removal of locking adds more problems (inode can be changing) it's not
> safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu,
> ilookup5_rcu and ilookup5_nowait_rcu get added, requiring manual
> conversion.
> 
> In order to reduce code duplication find_inode and find_inode_fast grow
> an argument indicating whether inode hash lock is held, which is passed
> down should sleeping be necessary. They always rcu_read_lock, which is
> redundant but harmless. Doing it conditionally reduces readability for
> no real gain that I can see. RCU-alike restrictions were already put on
> callbacks due to the hash spinlock being held.
> 
> There is a real cache-busting workload scanning millions of files in
> parallel (it's a backup server thing), where the initial lookup is
> guaranteed to fail resulting in the 2 lock acquires.
> 
> Implemented below is a synthehic benchmark which provides the same
> behavior. [I shall note the workload is not running on Linux, instead it
> was causing trouble elsewhere. Benchmark below was used while addressing
> said problems and was found to adequately represent the real workload.]
> 
> Total real time fluctuates by 1-2s.
> 
> With 20 threads each walking a dedicated 1000 dirs * 1000 files
> directory tree to stat(2) on a 32 core + 24GB RAM vm:
> [/quote]
> 
> Specific results:
> 
> ext4 (needed mkfs.ext4 -N 24000000):
> before:	3.77s user 890.90s system 1939% cpu 46.118 total
> after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)
> 
> btrfs (s/iget5_locked/iget5_locked_rcu in fs/btrfs/inode.c):
> before: 3.54s user 892.30s system 1966% cpu 45.549 total
> after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)
> 
> btrfs bottlenecks itself on its own locks here.
> 
> Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz
> 
> fs rundown is as follows:
> - ext4 patched implicitly
> - xfs does not use the inode hash
> - bcachefs is out of the picture as Kent decided to implement his own
>   inode hashing based on rhashtable, for now private to his fs.
> 
> I have not looked at others.
> 
> [1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

