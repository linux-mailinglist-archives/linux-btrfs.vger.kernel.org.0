Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46C42B0DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 02:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhJMAP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhJMAP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 20:15:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C8C061570
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 17:13:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id g5so634183plg.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 17:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kG/EJKM69ehygwK2Ial4bnqR2REhAvbj6YsEmh2+Qh8=;
        b=PzKJZyP0t8TW3clJdILZ5isI0boU1jjHhmpc2aDYszXibB9kH4Bfdwz9E8P/O7/plf
         ETlbSxz1sPQrT3GIJSv1j8z0zJFnWUtEh2I5VvCTk0LX2RZwrmnKxAmcZks8G0F4jeAE
         IHdJAO3ofGLU60VRrEOiIpojMaiYhPyQ9txjLoFSwMHpst7pOLhcS6kHySK0zhDbD+wR
         bZR/CLmYPLCUDJBEIcr4pgC1X1w5ZnqvCHM2Cfyi9xAvtM63WowV/61x8yHahon+Pkj6
         gWSmBA5zgBk3SyY4ViFRVlbf3PH6v5gfkZBVf+34cSL4LzJySJE20WhZF/1T4VyP7hs2
         hRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kG/EJKM69ehygwK2Ial4bnqR2REhAvbj6YsEmh2+Qh8=;
        b=BeMk44s3p04k5qUz11uCmF5hei0oIyKH3YzOHsGpN/nVIJ0oPaFwcJiMQdQ4emcsZ7
         lCOO2tBQtaQRj3EGV1TkngHc6Kukxex/KzNIbnczXMp1yvQDiEUtCwThfP7lRs1Xo/wF
         8dO++38bGOyY1TZSOcXdzt5OGmaZvH+nupG9KmTQkgsGmSSkQr9NnrYnAKQh+4PfnoQo
         3/XXAHU91Bq/X1wVVWmGJSaXHLi3QEGBx+iLst/D1gWSQxxISGwwAseyDO9J0ACINSbd
         bZ/YwRKZ/WONgIVGataH27874UlJGVNoTmbT+1XnS4n/pp7ZJ+STVBdrAomhgOcOJ+TB
         V5Bg==
X-Gm-Message-State: AOAM5320DMXLeBPyGBsZ6JvLgpkzAvpq2lb+pzMLM3uVNLKCNeNzn9+d
        7DET2G0QOE8TYHwdOxnABsOXWJdyrVNE/w==
X-Google-Smtp-Source: ABdhPJytbV+QjsEIjYWDpwE/4cGZ+fP0LNoqr3yY+pUe249x7xfxtpEcnI/dObGNiPhKG6YKdzZQJA==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr9867457pjb.0.1634084032830;
        Tue, 12 Oct 2021 17:13:52 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:3b17])
        by smtp.gmail.com with ESMTPSA id n24sm12614073pfv.144.2021.10.12.17.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:13:52 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [RFC PATCH] btrfs: fix deadlock when defragging transparent huge pages
Date:   Tue, 12 Oct 2021 17:13:45 -0700
Message-Id: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Attempting to defragment a Btrfs file containing a transparent huge page
immediately deadlocks with the following stack trace:

  #0  context_switch (kernel/sched/core.c:4940:2)
  #1  __schedule (kernel/sched/core.c:6287:8)
  #2  schedule (kernel/sched/core.c:6366:3)
  #3  io_schedule (kernel/sched/core.c:8389:2)
  #4  wait_on_page_bit_common (mm/filemap.c:1356:4)
  #5  __lock_page (mm/filemap.c:1648:2)
  #6  lock_page (./include/linux/pagemap.h:625:3)
  #7  pagecache_get_page (mm/filemap.c:1910:4)
  #8  find_or_create_page (./include/linux/pagemap.h:420:9)
  #9  defrag_prepare_one_page (fs/btrfs/ioctl.c:1068:9)
  #10 defrag_one_range (fs/btrfs/ioctl.c:1326:14)
  #11 defrag_one_cluster (fs/btrfs/ioctl.c:1421:9)
  #12 btrfs_defrag_file (fs/btrfs/ioctl.c:1523:9)
  #13 btrfs_ioctl_defrag (fs/btrfs/ioctl.c:3117:9)
  #14 btrfs_ioctl (fs/btrfs/ioctl.c:4872:10)
  #15 vfs_ioctl (fs/ioctl.c:51:10)
  #16 __do_sys_ioctl (fs/ioctl.c:874:11)
  #17 __se_sys_ioctl (fs/ioctl.c:860:1)
  #18 __x64_sys_ioctl (fs/ioctl.c:860:1)
  #19 do_syscall_x64 (arch/x86/entry/common.c:50:14)
  #20 do_syscall_64 (arch/x86/entry/common.c:80:7)
  #21 entry_SYSCALL_64+0x7c/0x15b (arch/x86/entry/entry_64.S:113)

A huge page is represented by a compound page, which consists of a
struct page for each PAGE_SIZE page within the huge page. The first
struct page is the "head page", and the remaining are "tail pages".

Defragmentation attempts to lock each page in the range. However,
lock_page() on a tail page actually locks the corresponding head page.
So, if defragmentation tries to lock more than one struct page in a
compound page, it tries to lock the same head page twice and deadlocks
with itself.

There are a few options for dealing with this:

1. Return an error if defrag is called for a transparent huge page.
2. Silently skip over defragging transparent huge pages.
3. Implement real support for defragging transparent huge pages.

This patch implements option 1. The error code (ETXTBUSY) is up for
bikeshedding. Option 2 seems reasonable as well. Option 3, however,
would require more effort. THP for filesystems is currently read-only,
so I suspect that a lot of code is not ready for using these pages for
I/O.

This can be reproduced with:

  $ cat create_thp_file.c
  #include <fcntl.h>
  #include <stdbool.h>
  #include <stdio.h>
  #include <stdint.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <sys/mman.h>

  static const char zeroes[1024 * 1024];
  static const size_t FILE_SIZE = 2 * 1024 * 1024;

  int main(int argc, char **argv)
  {
          if (argc != 2) {
                  fprintf(stderr, "usage: %s PATH\n", argv[0]);
                  return EXIT_FAILURE;
          }
          int fd = creat(argv[1], 0777);
          if (fd == -1) {
                  perror("creat");
                  return EXIT_FAILURE;
          }
          size_t written = 0;
          while (written < FILE_SIZE) {
                  ssize_t ret = write(fd, zeroes,
                                      sizeof(zeroes) < FILE_SIZE - written ?
                                      sizeof(zeroes) : FILE_SIZE - written);
                  if (ret < 0) {
                          perror("write");
                          return EXIT_FAILURE;
                  }
                  written += ret;
          }
          close(fd);
          fd = open(argv[1], O_RDONLY);
          if (fd == -1) {
                  perror("open");
                  return EXIT_FAILURE;
          }

          /*
           * Reserve some address space so that we can align the file mapping to
           * the huge page size.
           */
          void *placeholder_map = mmap(NULL, FILE_SIZE * 2, PROT_NONE,
                                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
          if (placeholder_map == MAP_FAILED) {
                  perror("mmap (placeholder)");
                  return EXIT_FAILURE;
          }

          void *aligned_address =
                  (void *)(((uintptr_t)placeholder_map + FILE_SIZE - 1) & ~(FILE_SIZE - 1));

          void *map = mmap(aligned_address, FILE_SIZE, PROT_READ | PROT_EXEC,
                           MAP_SHARED | MAP_FIXED, fd, 0);
          if (map == MAP_FAILED) {
                  perror("mmap");
                  return EXIT_FAILURE;
          }
          if (madvise(map, FILE_SIZE, MADV_HUGEPAGE) < 0) {
                  perror("madvise");
                  return EXIT_FAILURE;
          }

          char *line = NULL;
          size_t line_capacity = 0;
          FILE *smaps_file = fopen("/proc/self/smaps", "r");
          if (!smaps_file) {
                  perror("fopen");
                  return EXIT_FAILURE;
          }
          for (;;) {
                  for (size_t off = 0; off < FILE_SIZE; off += 4096)
                          ((volatile char *)map)[off];

                  ssize_t ret;
                  bool this_mapping = false;
                  while ((ret = getline(&line, &line_capacity, smaps_file)) > 0) {
                          unsigned long start, end, huge;
                          if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
                                  this_mapping = (start <= (uintptr_t)map &&
                                                  (uintptr_t)map < end);
                          } else if (this_mapping &&
                                     sscanf(line, "FilePmdMapped: %ld", &huge) == 1 &&
                                     huge > 0) {
                                  return EXIT_SUCCESS;
                          }
                  }

                  sleep(6);
                  rewind(smaps_file);
                  fflush(smaps_file);
          }
  }
  $ ./create_thp_file huge
  $ btrfs fi defrag -czstd ./huge

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9eb0c1eb568e..47c1a72241da 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1069,7 +1069,10 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	ret = set_page_extent_mapped(page);
+	if (PageCompound(page))
+		ret = -ETXTBSY;
+	else
+		ret = set_page_extent_mapped(page);
 	if (ret < 0) {
 		unlock_page(page);
 		put_page(page);
-- 
2.33.0

