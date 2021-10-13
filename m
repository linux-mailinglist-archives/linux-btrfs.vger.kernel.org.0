Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00142B3C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 05:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhJMDnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 23:43:10 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:44764 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhJMDnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 23:43:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.302049-0.000781275-0.697169;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.LYBMTtr_1634096464;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LYBMTtr_1634096464)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 13 Oct 2021 11:41:04 +0800
Date:   Wed, 13 Oct 2021 11:41:06 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Omar Sandoval <osandov@osandov.com>
Subject: Re: [RFC PATCH] btrfs: fix deadlock when defragging transparent huge pages
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
References: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
Message-Id: <20211013114106.74EC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I failed to use this reproducer to reproduce this problem.

kernel: 5.15.0-0.rc5
kernel config: CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
mount option: rw,relatime,ssd,space_cache=v2,subvolid=5,subvol=/
btrfs souce: 5.15.0-0.rc5, misc-next

create_thp_file is a loop, could we add
            char cmd[256] = {};
            sprintf(cmd, "btrfs fi defrag -czstd %s", argv[1]);
            (void)!system(cmd);
into it to make it more easy to reproduce ?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/13


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
> There are a few options for dealing with this:
> 
> 1. Return an error if defrag is called for a transparent huge page.
> 2. Silently skip over defragging transparent huge pages.
> 3. Implement real support for defragging transparent huge pages.
> 
> This patch implements option 1. The error code (ETXTBUSY) is up for
> bikeshedding. Option 2 seems reasonable as well. Option 3, however,
> would require more effort. THP for filesystems is currently read-only,
> so I suspect that a lot of code is not ready for using these pages for
> I/O.
> 
> This can be reproduced with:
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


