Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A782434C95
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJTNtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhJTNtx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 09:49:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B11CC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:47:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bl14so3126392qkb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1NwzpAYCVOs45xuuH96e38AGTC7H1oUdTtPjeaaWVeI=;
        b=nN4VrUuVhSF2QSHU3s6Ezrhtf1Ys66cxPu/GPayqp3TOoBK0Om2t/VhA6PGNsbatxi
         efyMuLn/TTNM8OX61dZKzmv7jumSZDpmKFdtd4je8oEj9KDQn2Axl/tvqV/ggHfUTZYZ
         ciXuH5W9M941atfcQfByxDuFsedildPEk0yKmrPpa7k9ejka/I4cSynRsE+XO3tfmpVR
         tyPDgqhz4gs2dM1FNGNoig63UD3r1UUPsG3Wu3jL3QPKPS0ZUcxilYkrOR6XHq4RD3zJ
         xXdFlIovExhaCP3khvpGk4cSbzvTdDjQcblSc3ITC8zbOBpQVoH7/IGSlBzgDpDixsoD
         vCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1NwzpAYCVOs45xuuH96e38AGTC7H1oUdTtPjeaaWVeI=;
        b=69fBy5h9P1umuwWsKojgpJdCgjL9hy05An/NhynRdvwVteLGByCJBQZcyKVTwTzn1K
         GZGM7ZKys5nTHsU8pVBIcb7gY9tU9Ja/RUxrJ8hasU0gC6pKB3geBhg45UlNec0RS/dP
         onA+ju/ehUhmjyZKSP8xzLlesdbN/IYySwSEFFo93sILXaD4iRqYFuaj+LaWPZYvMUro
         Yj4LXZKyBp2g0CauG+HhOSuaZBFIupfE3O7mP8y7+jO61Ns9SzWhZoU5DrAIqruvDFJX
         oCxsemcl8wdejIak194qtVpj+owOQclQu8yzjQ+4aiZ9x0eSMZk50rF2ZwUa1vdGgX+F
         G3ag==
X-Gm-Message-State: AOAM531ggFAfpLbx0ejyGvB6uQpTA61kkvhDULWC4RXHJ1j9uhWnHG6s
        8VU2pAMd4P97y6ezinoaVt2i7Vf4zBSF8A==
X-Google-Smtp-Source: ABdhPJw1vx5uVS6JjRB/d3eOuF0HNT3K9Xet/KwLKL63mUnSptiqCyHB7y3xTEkiKefOJ6x0ZGlioA==
X-Received: by 2002:a37:9404:: with SMTP id w4mr50529qkd.469.1634737658352;
        Wed, 20 Oct 2021 06:47:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm963418qtt.22.2021.10.20.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:47:37 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:47:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: fix deadlock when defragging transparent huge
 pages
Message-ID: <YXAd+Y6Tp32RV2im@localhost.localdomain>
References: <321ffae6065e36a6c698912a86f8019ea00f43b4.1634700835.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321ffae6065e36a6c698912a86f8019ea00f43b4.1634700835.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:35:01PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Attempting to defragment a Btrfs file containing a transparent huge page
> immediately deadlocks with the following stack trace:
> 
>   #0  context_switch (kernel/sched/core.c:4940:2)
>   #1  __schedule (kernel/sched/core.c:6287:8)
>   #2  schedule (kernel/sched/core.c:6366:3)
>   #3  io_schedule (kernel/sched/core.c:8389:2)
>   #4  wait_on_page_bit_common (mm/filemap.c:1356:4)
>   #5  __lock_page (mm/filemap.c:1648:2)
>   #6  lock_page (./include/linux/pagemap.h:625:3)
>   #7  pagecache_get_page (mm/filemap.c:1910:4)
>   #8  find_or_create_page (./include/linux/pagemap.h:420:9)
>   #9  defrag_prepare_one_page (fs/btrfs/ioctl.c:1068:9)
>   #10 defrag_one_range (fs/btrfs/ioctl.c:1326:14)
>   #11 defrag_one_cluster (fs/btrfs/ioctl.c:1421:9)
>   #12 btrfs_defrag_file (fs/btrfs/ioctl.c:1523:9)
>   #13 btrfs_ioctl_defrag (fs/btrfs/ioctl.c:3117:9)
>   #14 btrfs_ioctl (fs/btrfs/ioctl.c:4872:10)
>   #15 vfs_ioctl (fs/ioctl.c:51:10)
>   #16 __do_sys_ioctl (fs/ioctl.c:874:11)
>   #17 __se_sys_ioctl (fs/ioctl.c:860:1)
>   #18 __x64_sys_ioctl (fs/ioctl.c:860:1)
>   #19 do_syscall_x64 (arch/x86/entry/common.c:50:14)
>   #20 do_syscall_64 (arch/x86/entry/common.c:80:7)
>   #21 entry_SYSCALL_64+0x7c/0x15b (arch/x86/entry/entry_64.S:113)
> 
> A huge page is represented by a compound page, which consists of a
> struct page for each PAGE_SIZE page within the huge page. The first
> struct page is the "head page", and the remaining are "tail pages".
> 
> Defragmentation attempts to lock each page in the range. However,
> lock_page() on a tail page actually locks the corresponding head page.
> So, if defragmentation tries to lock more than one struct page in a
> compound page, it tries to lock the same head page twice and deadlocks
> with itself.
> 
> Ideally, we should be able to defragment transparent huge pages.
> However, THP for filesystems is currently read-only, so a lot of code is
> not ready to use huge pages for I/O. For now, let's just return
> ETXTBUSY.
> 
> This can be reproduced with the following on a kernel with
> CONFIG_READ_ONLY_THP_FOR_FS=y:
> 
>   $ cat create_thp_file.c
>   #include <fcntl.h>
>   #include <stdbool.h>
>   #include <stdio.h>
>   #include <stdint.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <sys/mman.h>
> 
>   static const char zeroes[1024 * 1024];
>   static const size_t FILE_SIZE = 2 * 1024 * 1024;
> 
>   int main(int argc, char **argv)
>   {
>           if (argc != 2) {
>                   fprintf(stderr, "usage: %s PATH\n", argv[0]);
>                   return EXIT_FAILURE;
>           }
>           int fd = creat(argv[1], 0777);
>           if (fd == -1) {
>                   perror("creat");
>                   return EXIT_FAILURE;
>           }
>           size_t written = 0;
>           while (written < FILE_SIZE) {
>                   ssize_t ret = write(fd, zeroes,
>                                       sizeof(zeroes) < FILE_SIZE - written ?
>                                       sizeof(zeroes) : FILE_SIZE - written);
>                   if (ret < 0) {
>                           perror("write");
>                           return EXIT_FAILURE;
>                   }
>                   written += ret;
>           }
>           close(fd);
>           fd = open(argv[1], O_RDONLY);
>           if (fd == -1) {
>                   perror("open");
>                   return EXIT_FAILURE;
>           }
> 
>           /*
>            * Reserve some address space so that we can align the file mapping to
>            * the huge page size.
>            */
>           void *placeholder_map = mmap(NULL, FILE_SIZE * 2, PROT_NONE,
>                                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>           if (placeholder_map == MAP_FAILED) {
>                   perror("mmap (placeholder)");
>                   return EXIT_FAILURE;
>           }
> 
>           void *aligned_address =
>                   (void *)(((uintptr_t)placeholder_map + FILE_SIZE - 1) & ~(FILE_SIZE - 1));
> 
>           void *map = mmap(aligned_address, FILE_SIZE, PROT_READ | PROT_EXEC,
>                            MAP_SHARED | MAP_FIXED, fd, 0);
>           if (map == MAP_FAILED) {
>                   perror("mmap");
>                   return EXIT_FAILURE;
>           }
>           if (madvise(map, FILE_SIZE, MADV_HUGEPAGE) < 0) {
>                   perror("madvise");
>                   return EXIT_FAILURE;
>           }
> 
>           char *line = NULL;
>           size_t line_capacity = 0;
>           FILE *smaps_file = fopen("/proc/self/smaps", "r");
>           if (!smaps_file) {
>                   perror("fopen");
>                   return EXIT_FAILURE;
>           }
>           for (;;) {
>                   for (size_t off = 0; off < FILE_SIZE; off += 4096)
>                           ((volatile char *)map)[off];
> 
>                   ssize_t ret;
>                   bool this_mapping = false;
>                   while ((ret = getline(&line, &line_capacity, smaps_file)) > 0) {
>                           unsigned long start, end, huge;
>                           if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
>                                   this_mapping = (start <= (uintptr_t)map &&
>                                                   (uintptr_t)map < end);
>                           } else if (this_mapping &&
>                                      sscanf(line, "FilePmdMapped: %ld", &huge) == 1 &&
>                                      huge > 0) {
>                                   return EXIT_SUCCESS;
>                           }
>                   }
> 
>                   sleep(6);
>                   rewind(smaps_file);
>                   fflush(smaps_file);
>           }
>   }
>   $ ./create_thp_file huge
>   $ btrfs fi defrag -czstd ./huge
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
