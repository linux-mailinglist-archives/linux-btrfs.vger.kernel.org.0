Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621F542BCAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 12:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbhJMKX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhJMKXY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 06:23:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD75C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 03:21:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o12so1999721qtq.7
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vjqwsnTzdp84wJsp9Zrv6ECI1Og5/rAVtNfMg6+z7ck=;
        b=f9AS5fbpSCDRMhKu6+MG0k+0Of+1s26Md9IE+Fg+vu0AkVcrvQ+T5izgx35E8M3tes
         M0GEWZRC+wf5+QnLECMst2IGT8h66L8rn8zMsBrpHDSP8HlMAflAl9FXT/qDs+cEVAXj
         Uwwy4vnr0N7BYPXye20uNWp3Yc8jkBvtI4LM0JtvT8HVSN39VlofUW1P0zMBGcXLHRAk
         9ZnkS8x4Jr3pU4wFojbOW2/v4qsxMHdtABEA3fQvJU+VQCmqfDGh/oaUzLKkbc0S4qVh
         WO6cRQKFmY2LoqowwL+56K0w+k0cNz4e/fwr4NfNsIxv7WL5l5MhcPnYUplzzTKChMBQ
         sAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vjqwsnTzdp84wJsp9Zrv6ECI1Og5/rAVtNfMg6+z7ck=;
        b=gc0Tfp1epLKQCSs5nxAwcqrO37I09iJu+R+sL2buU31znaZ5Xq92zA0w+04FN+ew56
         sr6QQMMxaT4PZnyR0T9NJ8XWVPc3O0NO4nli+8KDMfF6B7NrywwhpE5Hz+o6XhOFg2ex
         rQtixHWD0baTBGJwXS/SEtJPPgUg90HnrDSujU08gB16WH2lq1HPUV1QaV3xpYkwuyvo
         0WSK3sPsXCN4DP6+26tLV7N6JEfT8vINh2qtLqOO08DH3a3p2IaSjXK4cMzOxQzD+5HT
         Gj9YuLA6NhYgfpkCGxybPo8tTLWEAdsTA9cBY1V4gxWF4K9kRQ7D1A9URRW9BmrLEqEG
         RC7w==
X-Gm-Message-State: AOAM5303Hlvuxj04aluNObIoubSuwfFnQ3RUpC1zXVdFqZsRWb0QlYgh
        UERqPPlbZQ+JEXBcn5UzkKBhonLTC2pBRN5Sd8e0lvx8
X-Google-Smtp-Source: ABdhPJzlKnAmFq60yV4mAhKR9HNCfPu8uNWV3xEtAH9WamysUsvljsxqeXCBzmPyp0nwTVTQxI2HZxYVOBQnj4KXwt8=
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr15800162qta.29.1634120480964;
 Wed, 13 Oct 2021 03:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
In-Reply-To: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 13 Oct 2021 11:20:44 +0100
Message-ID: <CAL3q7H6rjid4VgD7F61SU-3vHgdM=qcmoc6oNr9Se=3tVgDzuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] btrfs: fix deadlock when defragging transparent huge pages
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 1:15 AM Omar Sandoval <osandov@osandov.com> wrote:
>
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

Doing option 1 for now looks reasonable to me.
In the long term, having option 3 would be nice.

Looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

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
>   static const size_t FILE_SIZE =3D 2 * 1024 * 1024;
>
>   int main(int argc, char **argv)
>   {
>           if (argc !=3D 2) {
>                   fprintf(stderr, "usage: %s PATH\n", argv[0]);
>                   return EXIT_FAILURE;
>           }
>           int fd =3D creat(argv[1], 0777);
>           if (fd =3D=3D -1) {
>                   perror("creat");
>                   return EXIT_FAILURE;
>           }
>           size_t written =3D 0;
>           while (written < FILE_SIZE) {
>                   ssize_t ret =3D write(fd, zeroes,
>                                       sizeof(zeroes) < FILE_SIZE - writte=
n ?
>                                       sizeof(zeroes) : FILE_SIZE - writte=
n);
>                   if (ret < 0) {
>                           perror("write");
>                           return EXIT_FAILURE;
>                   }
>                   written +=3D ret;
>           }
>           close(fd);
>           fd =3D open(argv[1], O_RDONLY);
>           if (fd =3D=3D -1) {
>                   perror("open");
>                   return EXIT_FAILURE;
>           }
>
>           /*
>            * Reserve some address space so that we can align the file map=
ping to
>            * the huge page size.
>            */
>           void *placeholder_map =3D mmap(NULL, FILE_SIZE * 2, PROT_NONE,
>                                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0=
);
>           if (placeholder_map =3D=3D MAP_FAILED) {
>                   perror("mmap (placeholder)");
>                   return EXIT_FAILURE;
>           }
>
>           void *aligned_address =3D
>                   (void *)(((uintptr_t)placeholder_map + FILE_SIZE - 1) &=
 ~(FILE_SIZE - 1));
>
>           void *map =3D mmap(aligned_address, FILE_SIZE, PROT_READ | PROT=
_EXEC,
>                            MAP_SHARED | MAP_FIXED, fd, 0);
>           if (map =3D=3D MAP_FAILED) {
>                   perror("mmap");
>                   return EXIT_FAILURE;
>           }
>           if (madvise(map, FILE_SIZE, MADV_HUGEPAGE) < 0) {
>                   perror("madvise");
>                   return EXIT_FAILURE;
>           }
>
>           char *line =3D NULL;
>           size_t line_capacity =3D 0;
>           FILE *smaps_file =3D fopen("/proc/self/smaps", "r");
>           if (!smaps_file) {
>                   perror("fopen");
>                   return EXIT_FAILURE;
>           }
>           for (;;) {
>                   for (size_t off =3D 0; off < FILE_SIZE; off +=3D 4096)
>                           ((volatile char *)map)[off];
>
>                   ssize_t ret;
>                   bool this_mapping =3D false;
>                   while ((ret =3D getline(&line, &line_capacity, smaps_fi=
le)) > 0) {
>                           unsigned long start, end, huge;
>                           if (sscanf(line, "%lx-%lx", &start, &end) =3D=
=3D 2) {
>                                   this_mapping =3D (start <=3D (uintptr_t=
)map &&
>                                                   (uintptr_t)map < end);
>                           } else if (this_mapping &&
>                                      sscanf(line, "FilePmdMapped: %ld", &=
huge) =3D=3D 1 &&
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
> @@ -1069,7 +1069,10 @@ static struct page *defrag_prepare_one_page(struct=
 btrfs_inode *inode,
>         if (!page)
>                 return ERR_PTR(-ENOMEM);
>
> -       ret =3D set_page_extent_mapped(page);
> +       if (PageCompound(page))
> +               ret =3D -ETXTBSY;
> +       else
> +               ret =3D set_page_extent_mapped(page);
>         if (ret < 0) {
>                 unlock_page(page);
>                 put_page(page);
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
