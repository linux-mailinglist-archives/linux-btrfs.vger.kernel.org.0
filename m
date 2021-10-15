Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5997642EEF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhJOKnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 06:43:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33076 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhJOKnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 06:43:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A2EA2196E;
        Fri, 15 Oct 2021 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634294471;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDQ3FEAuwVkikvT7iOvBBv5BYHR3h0cxKnCICvIStx8=;
        b=mx+1Y2dWhQQxCJWlaeuqN4q2EUgMRH2t8mZeKl43l3hT4ba1XWPccU4tU56OD9fMRwVB/u
        mp/vop/klJ7G/GBD7IJfJsKzly/VZQlaMyVx3ZfCvlePiYOpsmcfpCd0S3n2f81FAUAbzy
        8rxMvOYcaXU8kdxZq9IphqHLSCidAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634294471;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDQ3FEAuwVkikvT7iOvBBv5BYHR3h0cxKnCICvIStx8=;
        b=4ULo1nWmrynu3fsMT1x6L3fS1mzsgDhdJ011XeW8t3QXpKFTOYcETUOaI5dOIQarUA68Dn
        IAXPUsD/SUKlwuDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8DB5DA3B89;
        Fri, 15 Oct 2021 10:41:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67FD3DA7A3; Fri, 15 Oct 2021 12:40:46 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:40:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH] btrfs: fix deadlock when defragging transparent huge
 pages
Message-ID: <20211015104046.GB30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 05:13:45PM -0700, Omar Sandoval wrote:
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
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9eb0c1eb568e..47c1a72241da 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1069,7 +1069,10 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
>  	if (!page)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = set_page_extent_mapped(page);
> +	if (PageCompound(page))
> +		ret = -ETXTBSY;

Returning here looks as an acceptable option, the error code is could be
misleading but I think we can reuse it. Defragmenting running binaries
also returns (or returned) ETXTBUSY so the meaning is "something's
happening with the pages, we can't defrag but it's temporary".
The defrag command skips errors by default so it's up to the user to
decide what to do, but it's not a hard error and failing defragmentation
is also not a hard error.

What I do not like is the bare call to PageCompound. At minimum it must
be documented because it's not obvious at all why it's here. I'd rather
see it wrapped in a helper (like set_page_extent_mapped_careful) with a
comment when to use it.

The defragmentation accesses the pages in a way that may expose the
compound pages and related problems but it may not be the only place
(now or in the future) so fixing any potential problems would be to use
the helper, not to add more PageCompound checks.
