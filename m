Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C534343EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 05:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJTDh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 23:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTDhZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 23:37:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3733C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 20:35:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 21so15131462plo.13
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 20:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCl9OPRZn+OjggINmZ9cmwQ0mmAsdy+ZI1eFWww/nXM=;
        b=tNKp+0I3yIAJxE6fLIVhj7j554UERPDvv/lItRDn/ay4BorF775asvNErJDIDxVKEp
         ATQCtwPPG9OXPFVPPGI3gTHSDPa4NjHNxpMvxKlOfhrk6t/04WW2r7dtwGtHUmebQL0p
         MDZKhe1z1wybKhEAOXyFvxjRKbUIkRoTUnsmqK+TJ967p4jHFh+zWid+bLAVUVXxWuOb
         WLPs5ZzFDz0XcDNV0EHF5V23w0ehkSF9M18/NJ7gOu7wVJDzew42QI3INU9r3jebgCWf
         iUdMhRoCsdl43BkKKf9oZZ9MDJYwpV2wtvj0iPkbEC4xmge8F/38u7cFw9R0l/Q0XIvb
         KzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCl9OPRZn+OjggINmZ9cmwQ0mmAsdy+ZI1eFWww/nXM=;
        b=ATBLi1knRlc//oeL6GPUNqY9Jg466i7FpgRVfOy2/352DSKRwLeMFcViZ/yZzsvcJ2
         iL6Qd2WOqMyK4MkDSPiTEBb44aKU7b+evAPX4gWlKEf6wXBkwm0Difdp2kgja1cThAzf
         2f6P5PruxqNrUQdiUmsZ1R7zDP/eJVKNjKDw3usWJm7Fgz+aNQdOICVFiiTrA4Jo1boj
         NgO8+AXVLljASYGUWOezrn7o4EGAWxWbhwTA1o+T0+PFbLkh5Mobi2sO+S9imZKIvqBv
         dZO/EEP2uOT5aexWUaqP0fgcCHn1Mm7RLCt+t2AQbHvZkGmj903wM/SBl8V86C2UbDJR
         gH0A==
X-Gm-Message-State: AOAM5317eXV+0VWd0BcjVodo8F/a/7Mieg1gqY24/59VJENYheC3yQPm
        ZXx828+NiLy+bIH8MdXaMo2hBUuBOs6kLQ==
X-Google-Smtp-Source: ABdhPJwwcOyAteDERJUSt81gcbB+1BfF/+NOvJh3LdQEdsDhrEMsPBM13itw2/qzfL6O+lWwthpjNA==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr4254918pjb.127.1634700910633;
        Tue, 19 Oct 2021 20:35:10 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:88a9])
        by smtp.gmail.com with ESMTPSA id c8sm541367pjr.38.2021.10.19.20.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 20:35:10 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix deadlock when defragging transparent huge pages
Date:   Tue, 19 Oct 2021 20:35:01 -0700
Message-Id: <321ffae6065e36a6c698912a86f8019ea00f43b4.1634700835.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.1
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

Ideally, we should be able to defragment transparent huge pages.
However, THP for filesystems is currently read-only, so a lot of code is
not ready to use huge pages for I/O. For now, let's just return
ETXTBUSY.

This can be reproduced with the following on a kernel with
CONFIG_READ_ONLY_THP_FOR_FS=y:

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
Changes from v1:

- Fixed missing ERR_PTR cast.

Changes from RFC [1]:

- Separate PageCompound() check from set_page_extent_mapped() call to
  make it clearer that they are not related.
- Add comment to PageCompound() check. I didn't create a helper for it
  because it's not clear what function to wrap. It could be
  find_or_create_page(), find_lock_page(), or any other way we could get
  a page cache page. So, if we end up needing it anywhere else, we can
  create a common helper. For now, I think it's better to have an
  explicit check rather than obscure it behind a one-off helper.

 fs/btrfs/ioctl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c9d3f375df83..c474f7e24163 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1069,6 +1069,20 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * Since we can defragment files opened read-only, we can encounter
+	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS). We
+	 * can't do I/O using huge pages yet, so return an error for now.
+	 * Filesystem transparent huge pages are typically only used for
+	 * executables that explicitly enable them, so this isn't very
+	 * restrictive.
+	 */
+	if (PageCompound(page)) {
+		unlock_page(page);
+		put_page(page);
+		return ERR_PTR(-ETXTBSY);
+	}
+
 	ret = set_page_extent_mapped(page);
 	if (ret < 0) {
 		unlock_page(page);
-- 
2.33.1

