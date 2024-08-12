Return-Path: <linux-btrfs+bounces-7127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34994EF60
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F3FB24817
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508DE1802AB;
	Mon, 12 Aug 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bBLPxd+9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826617D375;
	Mon, 12 Aug 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472354; cv=none; b=puOnAN/Way2InahtNGKfTXyp7F6uKlTDhOQW7p7HG1U+StdLcD0gSJalwsdeFxZ+/8iEatC+721cpksGar/HQ3pXA8kN+g/0pgcqaM2n3Xm51QsutQMsNlVbL6G6hvnllLe4JiC8ENi/H4sgbC/ngBi0bKRkqS0nzPhU5ExNrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472354; c=relaxed/simple;
	bh=vzOmxKd7RttHNwXT/vN4h8f5QfdVzTA5ol/j3zSMd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V65+aqwrDrYE5bCILgWVVYpIljNt50ntCU4AlNwZkfqovwcAPttVIJCDyOJNxg+Qk3xn6lCDs9lDOoHXL8qtGIVXAhGBgVdDQ9lppJMvC9BQf7aeNMytn1Z4Jl7OPyXOWbpVs+82Mi+ZtcqO9BNNXRWsaWtW3bSkYnjLuXAj3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bBLPxd+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53F3C4AF0D;
	Mon, 12 Aug 2024 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723472354;
	bh=vzOmxKd7RttHNwXT/vN4h8f5QfdVzTA5ol/j3zSMd2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBLPxd+9f0pGIH/vAiv5A/fwo07QA9GmO2w9jbEIHZaukahuP1HZn3eWt3j56MEHp
	 JQ2Fw/aO+vkgvEdc6KujthVwZXIUroMBuSOhy8j8C/fcUYyLlim61iT9LygeXh2x6y
	 2yhRovRWFetWBFEW5w+sOynxZVvv1pxpXWzo9iKM=
Date: Mon, 12 Aug 2024 16:19:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: fdmanana@kernel.org
Cc: stable@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH for 5.15 stable] btrfs: fix corruption after buffer fault
 in during direct IO append write
Message-ID: <2024081202-sandbar-vintage-e3ec@gregkh>
References: <cover.1723046461.git.fdmanana@suse.com>
 <64af0e81f19122946855ab0f76b7e53f3231f02a.1723046461.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64af0e81f19122946855ab0f76b7e53f3231f02a.1723046461.git.fdmanana@suse.com>

On Wed, Aug 07, 2024 at 05:06:17PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 939b656bc8ab203fdbde26ccac22bcb7f0985be5 upstream.
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
>         if (iocb->ki_flags & IOCB_APPEND)
>                 iocb->ki_pos = i_size_read(inode);
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

All now queued up, thanks.

greg k-h

