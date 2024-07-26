Return-Path: <linux-btrfs+bounces-6729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04693D6CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CDB1C2137F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268117BB2B;
	Fri, 26 Jul 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TPbSh+eJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF47494
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010907; cv=none; b=NqZJfJeqXZnSxLBibRZJdgI1RUMAcFRYhTysu1CeVhfLd6XGsxI2c1je/HvN6em0ZijzcBN+24lqYCiJmaAksVRzrILlFaYOtUT/r+P/B0OQ1JPOvQxZNXYSCDQn6EtYb2yBM9wjjxqxZWwNdynK1KwGXzqTUChBABSFmrS5spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010907; c=relaxed/simple;
	bh=AwWyITbY7cNF2NoiKWEZtbL/WLsVBC2AO30Z35McBY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO07rnQvx8CyLnMXjieN8PUDYLWM4lVWUFnJd6Wa+RB0+3DtrUMZ8+JgkpfGF0bP94A2uE2CF5yLdaL57HOlZLrnEE9H/AnC9BYmpL8G8dq0Ooig5ixdeQHW68xkBsToq3eW/Nec9OTkETwL/plt6oUHJBoCT+sUP8/6iHhw9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TPbSh+eJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-661d7e68e89so17385847b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722010904; x=1722615704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGEkYJ1Ps8JCNRbj9ZB9RKJ4qG2hjb4vxmHQu4GsMh4=;
        b=TPbSh+eJWdhrqFhnBr6B8zsV4Jh9Mff5Pjk5WFkOc3g1uku1TnL/zz4hUYsanVVTxt
         s+dHkOne3HAdq0zvIYrWcOzKzloTTEO3KFev/RiPpyoKOZXFtGU8Ks+duz1v6vIHC7GS
         H7pzaDEG4qTg9xUZPIhwGjLx3GNXhN8L1TfWHOYyflSwNcVVtqWemLJDkcsHRgadHFMA
         zmA5sd0VZ+OgRztjko5/YUvZd0HgrYzJ8nPIBr6vwnx/u3LzjfzqUojXrBs3CJaBVNVn
         Pzf1+qu+pDnUBtJnwuNBFPquDPjkQLJOmP2ZTWVk/zhsqRCkKSETMqBx2zRIBvQ4SuaK
         kuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722010904; x=1722615704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGEkYJ1Ps8JCNRbj9ZB9RKJ4qG2hjb4vxmHQu4GsMh4=;
        b=jFQocqyMulc703hYLbN9bQ9UTCHQU8WegTVyf3/d2hh8efxQtzswJeVV3lqBO/2ARH
         D3p6M+rHMNDNKvQWaA680SUjpDZQdMXjyCtYUS5epcB79G7ukuWKVZsxBQh4L0adrs/R
         9KC/RpQZn8F/zmmDpla6AwJJ4lWt0Q//9pQiqXW2U1rdz1arCVr/GVO7RxmHSqFzFmpE
         SBci5MIlXM95SubUEBAINPG5lT5xL38Ub63mdF4+KJDlbmaK5cFEplov3oNrKTTFUKxW
         /aR3k+1ULUwv/i6dFIoPF7FbQiisOXP1kyqC2FEWx0lFkYsjQVRIgvA9xOjKbn8GRQy0
         fgug==
X-Gm-Message-State: AOJu0YzCWx02nJFdgoJ/YWBX5LXvzMsuoT2sXGCEOCABUpFL20iQyDj+
	evKyCDbaSObXyt3iraltqWdrjzMv1zeto0GWmDEpfCEdbKri2BfDtpQ9pgN8I1zv0c3tqHHeTE7
	a
X-Google-Smtp-Source: AGHT+IHZMfDBZuoIfN5TfSwVu64ha8E/igclmZXFrGZ1pevhuhM1eEi+To4Gcxba5hBfLH/ccpmoiA==
X-Received: by 2002:a81:7e04:0:b0:65f:ca3a:2233 with SMTP id 00721157ae682-67a29bfc24fmr1045677b3.6.1722010904403;
        Fri, 26 Jul 2024 09:21:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67568113cf9sm9400347b3.70.2024.07.26.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:21:44 -0700 (PDT)
Date: Fri, 26 Jul 2024 12:21:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix corruption after buffer fault in during
 direct IO append write
Message-ID: <20240726162143.GA3435578@perftesting>
References: <a7cdb10155e5e823ce82edfc8eed99d1b0ef4eeb.1722005943.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7cdb10155e5e823ce82edfc8eed99d1b0ef4eeb.1722005943.git.fdmanana@suse.com>

On Fri, Jul 26, 2024 at 04:55:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During an append (O_APPEND write flag) direct IO write if the input buffer
> was not previously faulted in, we can corrupt the file in a way that the
> final size is unexpected and it includes an unexpected hole.
> 
> The problem happens like this:
> 
> 1) We have an empty file, with size 0, for example;
> 
> 2) We do an O_APPEND direct IO with a length of 4096 bytes and the input
>    buffer is not currently faulted in;
> 
> 3) We enter btrfs_direct_write(), lock the inode and call
>    generic_write_checks(), which calls generic_write_checks_count(), and
>    that function sets the iocb position to 0 with the following code:
> 
> 	if (iocb->ki_flags & IOCB_APPEND)
> 		iocb->ki_pos = i_size_read(inode);
> 
> 4) We call btrfs_dio_write() and enter into iomap, which will end up
>    calling btrfs_dio_iomap_begin() and that calls
>    btrfs_get_blocks_direct_write(), where we update the i_size of the
>    inode to 4096 bytes;
> 
> 5) After btrfs_dio_iomap_begin() returns, iomap will attempt to access
>    the page of the write input buffer (at iomap_dio_bio_iter(), with a
>    call to bio_iov_iter_get_pages()) and fail with -EFAULT, which gets
>    returned to btrfs at btrfs_direct_write() via btrfs_dio_write();
> 
> 6) At btrfs_direct_write() we get the -EFAULT error, unlock the inode,
>    fault in the write buffer and then goto to the label 'relock';
> 
> 7) We lock again the inode, do all the necessary checks again and call
>    again generic_write_checks(), which calls generic_write_checks_count()
>    again, and there we set the iocb's position to 4K, which is the current
>    i_size of the inode, with the following code pointed above:
> 
>         if (iocb->ki_flags & IOCB_APPEND)
>                 iocb->ki_pos = i_size_read(inode);
> 
> 8) Then we go again to btrfs_dio_write() and enter iomap and the write
>    succeeds, but it wrote to the file range [4K, 8K[, leaving a hole in
>    the [0, 4K[ range and an i_size of 8K, which goes against the
>    expections of having the data written to the range [0, 4K[ and get an
>    i_size of 4K.
> 
> Fix this by not unlocking the inode before faulting in the input buffer,
> in case we get -EFAULT or an incomplete write, and not jumping to the
> 'relock' label after faulting in the buffer - instead jump to a location
> immediately before calling iomap, skipping all the write checks and
> relocking. This solves this problem and it's fine even in case the input
> buffer is memory mapped to the same file range, since only holding the
> range locked in the inode's io tree can cause a deadlock, it's safe to
> keep the inode lock (VFS lock), as was fixed and described in commit
> 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO
> reads and writes").
> 
> A sample reproducer provided by a reporter is the following:
> 
>    $ cat test.c
>    #ifndef _GNU_SOURCE
>    #define _GNU_SOURCE
>    #endif
> 
>    #include <fcntl.h>
>    #include <stdio.h>
>    #include <sys/mman.h>
>    #include <sys/stat.h>
>    #include <unistd.h>
> 
>    int main(int argc, char *argv[])
>    {
>        if (argc < 2) {
>            fprintf(stderr, "Usage: %s <test file>\n", argv[0]);
>            return 1;
>        }
> 
>        int fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT |
>                      O_APPEND, 0644);
>        if (fd < 0) {
>            perror("creating test file");
>            return 1;
>        }
> 
>        char *buf = mmap(NULL, 4096, PROT_READ,
>                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>        ssize_t ret = write(fd, buf, 4096);
>        if (ret < 0) {
>            perror("pwritev2");
>            return 1;
>        }
> 
>        struct stat stbuf;
>        ret = fstat(fd, &stbuf);
>        if (ret < 0) {
>            perror("stat");
>            return 1;
>        }
> 
>        printf("size: %llu\n", (unsigned long long)stbuf.st_size);
>        return stbuf.st_size == 4096 ? 0 : 1;
>    }
> 
> A test case for fstests will be sent soon.
> 
> Reported-by: Hanna Czenczek <hreitz@redhat.com>
> Link: https://lore.kernel.org/linux-btrfs/0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com/
> Fixes: 8184620ae212 ("btrfs: fix lost file sync on direct IO write with nowait and dsync iocb")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks for this Filipe, this stuff is so messy,

Josef

