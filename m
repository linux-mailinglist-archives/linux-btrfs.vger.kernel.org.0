Return-Path: <linux-btrfs+bounces-9510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5259C593A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 14:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C31280EA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE242AA4;
	Tue, 12 Nov 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TrJAdfMO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2F70838
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418585; cv=none; b=syl5szmIRQREHmGG1BCMSv0hbl/8iJDDEuka3nIL1Fxp5br2WiXFErYztSwrpIcwvvGzFQbKZrMFx1JZr/CHO7NaYLbl30m3lymTXj9gkpRuDpYzq+beHDMOapQaib/epZr/9hclBM/YoJVZd71gMpm2cPb4HkU3P6vBR7k7fSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418585; c=relaxed/simple;
	bh=UYMynpzb2neHmOqjVl3+/I9ELWYwbSrCsGyBvOAQhe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeD+I+7pkWUMIZNCnU1ju1ctxoB8s7L+Ls6yt64hfAoay3B4o8okjd2R/FasQp/SU9k0tFD14v7d4rIOsLqbR2LkAK8h5rhQK4d3ntodKhn3dqy2JrigTCiZSMmbOlES13ue5GTudTLid6pb1h4AmINhrYZqDGxogMmDENJrBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TrJAdfMO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso4359548a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 05:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731418583; x=1732023383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Oh4OX2Jyzis83TRylUMhyFscGtnBD3LHLbc+6KIU8=;
        b=TrJAdfMOlI9mBVmk6TvKipxIGwo9pyW6N3t/wyGzr1NOh0/DQLxDE4hg2G1Cg15cqD
         yWx3T2CT12EtjUuPNvJJe6C/cyQ0U/V7RAcwLzq0x4dKfshuzyJZT8d1LK91p5cqjAVP
         vcj1vWpwFIpanq9Z3QDvcMCRkk8RZgd9W9X5RFKFJmJDkB7d8u1YaDqkSgtrD+2uSSLd
         2GSQwhjGB3WCGM3YgKsmhGRAd1apeL8robDH5UhRrojaq6SKklOrpbsMKXI+v6wtUX2V
         gvGItBmpz0WRMxOn8xK9jMXKilXi8HVjsk21eNZxYfUfZ0wwaQ1Dciy+DCoSH9NbJNum
         w4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731418583; x=1732023383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6Oh4OX2Jyzis83TRylUMhyFscGtnBD3LHLbc+6KIU8=;
        b=R7NFEKcPyKxhz49vKkfIDnQQ1fkx50KqrEfH9awDKqd2a/NPMLiFiiAAIlulSvAjwy
         0c7vnBEewqO1racV/+TUKCg3JKXC9ZomaYaH0SBhd6pTULQYS1321dq3XVbtiV+R2uWt
         KPrPz3FJxXYiTqC355FzNfLN0o/HcX+2gwP+R9B7oEyfS1FJ1tQAQ6oOl+seY3UfShhK
         otkpHTzU13VGLKGDq/U5FW0dOtwmUaX11dwcdaPHSvgUVLZo54q82Gws1HzOL0BM+D1G
         3uJvVWys7padullL/fciUDiGdxRLcu2ptKxrFoJyrhJZq2X+s0miYM0aXPLrqg3yL2u/
         BAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigdBmnMc0fNhmA3U2N4Hk4r2etj7RxBrpB2fXYeV3rC8Dr0WGVqHgyGki/IoM6PMr/ADNab6M9slMsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Sqx6LIk6n03RRdbFbm1p8yZWdhpA/OUxr/pATRZpRi++JQ9Z
	5LPqfq5nIccDwPh4IyytLK7foxQ2IeZBJWGnPbSmlHqlZ6xPLJsUn+ueE4L6QWc=
X-Google-Smtp-Source: AGHT+IFIqnnMyIxMivt2cPh+q7ifEJlIf3ezR4cfEqcYFyOgxpQyOhRuCX6EGtaMImreoqHFw37fdQ==
X-Received: by 2002:a17:90b:5484:b0:2e2:bb32:73eb with SMTP id 98e67ed59e1d1-2e9b178ea9emr22376758a91.31.1731418582953;
        Tue, 12 Nov 2024 05:36:22 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9e8148d9dsm645777a91.2.2024.11.12.05.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:36:22 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tAr46-00DelY-1w;
	Wed, 13 Nov 2024 00:36:18 +1100
Date: Wed, 13 Nov 2024 00:36:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/16] mm/filemap: make buffered writes work with
 RWF_UNCACHED
Message-ID: <ZzNZ0iqx8EMlGVf0@dread.disaster.area>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-11-axboe@kernel.dk>
 <ZzKn4OyHXq5r6eiI@dread.disaster.area>
 <0487b852-6e2b-4879-adf1-88ba75bdecc0@kernel.dk>
 <ZzMLmYNQFzw9Xywv@dread.disaster.area>
 <2sjhov4poma4o4efvwe2xk474iorxwvf4ifqa5oee74744ke2e@lipjana3f5ti>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2sjhov4poma4o4efvwe2xk474iorxwvf4ifqa5oee74744ke2e@lipjana3f5ti>

On Tue, Nov 12, 2024 at 11:50:46AM +0200, Kirill A. Shutemov wrote:
> On Tue, Nov 12, 2024 at 07:02:33PM +1100, Dave Chinner wrote:
> > I think the post-IO invalidation that these IOs do is largely
> > irrelevant to how the page cache processes the write. Indeed,
> > from userspace, the functionality in this patchset would be
> > implemented like this:
> > 
> > oneshot_data_write(fd, buf, len, off)
> > {
> > 	/* write into page cache */
> > 	pwrite(fd, buf, len, off);
> > 
> > 	/* force the write through the page cache */
> > 	sync_file_range(fd, off, len, SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER);
> > 
> > 	/* Invalidate the single use data in the cache now it is on disk */
> > 	posix_fadvise(fd, off, len, POSIX_FADV_DONTNEED);
> > }
> > 
> > Allowing the application to control writeback and invalidation
> > granularity is a much more flexible solution to the problem here;
> > when IO is sequential, delayed allocation will be allowed to ensure
> > large contiguous extents are created and that will greatly reduce
> > file fragmentation on XFS, btrfs, bcachefs and ext4. For random
> > writes, it'll submit async IOs in batches...
> > 
> > Given that io_uring already supports sync_file_range() and
> > posix_fadvise(), I'm wondering why we need an new IO API to perform
> > this specific write-through behaviour in a way that is less flexible
> > than what applications can already implement through existing
> > APIs....
> 
> Attaching the hint to the IO operation allows kernel to keep the data in
> page cache if it is there for other reason. You cannot do it with a
> separate syscall.

Sure we can. FADV_NOREUSE is attached to the struct file - that's
available to every IO that is done on that file. Hence we know
before we start every IO on that file if we only need to preserve
existing page cache or all data we access.

Having a file marked like this doesn't affect any other application
that is accessing the same inode. It just means that the specific
fd opened by a specific process will not perturb the long term
residency of the page cache on that inode.

> Consider a scenario of a nightly backup of the data. The same data is in
> cache because the actual workload needs it. You don't want backup task to
> invalidate the data from cache. Your snippet would do that.

The code I presented was essentially just a demonstration of what
"uncached IO" was doing. That it is actually cached IO, and that it
can be done from userspace right now. Yes, it's not exactly the same
cache invalidation semantics, but that's not the point.

The point was that the existing APIs are *much more flexible* than
this proposal, and we don't actually need new kernel functionality
for applications to see the same benchmark results as Jens has
presented. All they need to do is be modified to use existing APIs.

The additional point to that end is that FADV_NOREUSE should be
hooke dup to the conditional cache invalidation mechanism Jens added
to the page cache IO paths. Then we have all the functionality of
this patch set individually selectable by userspace applications
without needing a new IO API to be rolled out. i.e. the snippet
then bcomes:

	/* don't cache after IO */
	fadvise(fd, FADV_NORESUSE)
	....
	write(fd, buf, len, off);
	/* write through */
	sync_file_range(fd, off, len, SYNC_FILE_RANGE);

Note how this doesn't need to block in sync_file_range() before
doing the invalidation anymore? We've separated the cache control
behaviour from the writeback behaviour. We can now do both write
back and write through buffered writes that clean up the page cache
after IO completion has occurred - write-through is not restricted
to uncached writes, nor is the cache purge after writeback
completion.

IOWs, we can do:

	/* don't cache after IO */
	fadvise(fd, FADV_NORESUSE)
	....
	off = pos;
	count = 4096;
	while (off < pos + len) {
		ret = write(fd, buf, count, off);
		/* get more data and put it in buf */
		off += ret;
	}
	/* write through */
	sync_file_range(fd, pos, len, SYNC_FILE_RANGE);

And now we only do one set of writeback on the file range, instead
of one per IO. And we still get the page cache being released on
writeback Io completion.

This is a *much* better API for IO and page cache control. It is not
constrained to individual IOs, so applications can allow the page
cache to write-combine data from multiple syscalls into a single
physical extent allocation and writeback IO.

This is much more efficient for modern filesytsems - the "writeback
per IO" model forces filesystms like XFS and ext4 to work like ext3
did, and defeats buffered write IO optimisations like dealyed
allocation. If we are going to do small "allocation and write IO"
patterns, we may as well be using direct IO as it is optimised for
that sort of behaviour.

So let's conside the backup application example. IMO, backup
applications  really don't want to use this new uncached IO
mechanism for either reading or writing data.

Backup programs do sequential data read IO as they walk the backup set -
if they are doing buffered IO then we -really- want readahead to be
active.

However, uncached IO turns off readahead, which is the equivalent of
the backup application doing:

	fadvise(fd, FADV_RANDOM);
	while (len > 0) {
		ret = read(fd, buf, len, off);
		fadvise(fd, FADV_DONTNEED, off, len);

		/* do stuff with buf */

		off += ret;
		len -= ret;
	}

Sequential buffered read IO after setting FADV_RANDOM absolutely
*sucks* from a performance perspective.

This is when FADV_NOREUSE is useful. We can leave readahead turned
on, and when we do the first read from the page cache after
readahead completes, we can then apply the NOREUSE policy. i.e. if
the data we are reading has not been accessed, then turf it after
reading if NOREUSE is set. If the data was already resident in
cache, then leave it there as per a normal read.

IOWs, if we separate the cache control from the read IO itself,
there is no need to turn off readahead to implement "drop cache
on-read" semantics. We just need to know if the folio has been
accessed or not to determine what to do with it.

Let's also consider the backup data file - that is written
sequentially.  It's going to be large and we don't know it's size
ahead of time. If we are using buffered writes we want delayed
allocation to optimise the file layout and hence writeback IO
throughput.  We also want to drop the page cache when writeback
eventually happens, but we really don't want writeback to happen on
every write.

IOWs, backup programs can take advantage of "drop cache when clean"
semantics, but can't really take any significant advantage from
per-IO write-through semantics. IOWs, backup applications really
want per-file NOREUSE write semantics that are seperately controlled
w.r.t. cache write-through behaviour.

One of the points I tried to make was that the uncached IO proposal
smashes multiple disparate semantics into a single per-IO control
bit. The backup application example above shows exactly how that API
isn't actually very good for the applications that could benefit
from the functionality this patchset adds to the page cache to
support that single control bit...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

