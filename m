Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C54CA908
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiCBP0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiCBP0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 10:26:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D86B0EAF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 07:25:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59FA4218E6;
        Wed,  2 Mar 2022 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646234751;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+mr0nFFVaVjuFnh3940mrW49H7Qv5qE2ZGXCIkThA4=;
        b=YksNVpRdj5Al4JYE5awGxBYNJ9yon6Teo1FeIxbuzQ/xPHM8epnt4dKKGUfS+PIAi5BXA3
        qxZEy70iosTY79B+vQHYYAnMQJWcO4RomvrafNaFN6tvQZyAckcPHe2tbEiO13KGtSx1FT
        wX08u9fzqZQ007p5uyHo1geLSyPIQcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646234751;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+mr0nFFVaVjuFnh3940mrW49H7Qv5qE2ZGXCIkThA4=;
        b=ixZP9FWm9pIc0d7XiuoR8LFbfhERd5DR17qoNFW7TaGIvdIhj5XjSCNCPD1pRpbhxV6mWF
        XbI9hUp0BaDUwFCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 52CFBA3B85;
        Wed,  2 Mar 2022 15:25:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F761DA80E; Wed,  2 Mar 2022 16:21:59 +0100 (CET)
Date:   Wed, 2 Mar 2022 16:21:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fallback to blocking mode when doing async dio
 over multiple extents
Message-ID: <20220302152158.GT12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <39c96b5608ed99b7d666d4d159f8d135e86b9606.1646219178.git.fdmanana@suse.com>
 <7b0dc4db2bc0feed18d341191c815c3a31dee63b.1646221649.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0dc4db2bc0feed18d341191c815c3a31dee63b.1646221649.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 11:48:39AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some users recently reported that MariaDB was getting a read corruption
> when using io_uring on top of btrfs. This started to happen in 5.16,
> after commit 51bd9563b6783d ("btrfs: fix deadlock due to page faults
> during direct IO reads and writes"). That changed btrfs to use the new
> iomap flag IOMAP_DIO_PARTIAL and to disable page faults before calling
> iomap_dio_rw(). This was necessary to fix deadlocks when the iovector
> corresponds to a memory mapped file region. That type of scenario is
> exercised by test case generic/647 from fstests.
> 
> For this MariaDB scenario, we attempt to read 16K from file offset X
> using IOCB_NOWAIT and io_uring. In that range we have 4 extents, each
> with a size of 4K, and what happens is the following:
> 
> 1) btrfs_direct_read() disables page faults and calls iomap_dio_rw();
> 
> 2) iomap creates a struct iomap_dio object, its reference count is
>    initialized to 1 and its ->size field is initialized to 0;
> 
> 3) iomap calls btrfs_dio_iomap_begin() with file offset X, which finds
>    the first 4K extent, and setups an iomap for this extent consisting
>    of a single page;
> 
> 4) At iomap_dio_bio_iter(), we are able to access the first page of the
>    buffer (struct iov_iter) with bio_iov_iter_get_pages() without
>    triggering a page fault;
> 
> 5) iomap submits a bio for this 4K extent
>    (iomap_dio_submit_bio() -> btrfs_submit_direct()) and increments
>    the refcount on the struct iomap_dio object to 2; The ->size field
>    of the struct iomap_dio object is incremented to 4K;
> 
> 6) iomap calls btrfs_iomap_begin() again, this time with a file
>    offset of X + 4K. There we setup an iomap for the next extent
>    that also has a size of 4K;
> 
> 7) Then at iomap_dio_bio_iter() we call bio_iov_iter_get_pages(),
>    which tries to access the next page (2nd page) of the buffer.
>    This triggers a page fault and returns -EFAULT;
> 
> 8) At __iomap_dio_rw() we see the -EFAULT, but we reset the error
>    to 0 because we passed the flag IOMAP_DIO_PARTIAL to iomap and
>    the struct iomap_dio object has a ->size value of 4K (we submitted
>    a bio for an extent already). The 'wait_for_completion' variable
>    is not set to true, because our iocb has IOCB_NOWAIT set;
> 
> 9) At the bottom of __iomap_dio_rw(), we decrement the reference count
>    of the struct iomap_dio object from 2 to 1. Because we were not
>    the only ones holding a reference on it and 'wait_for_completion' is
>    set to false, -EIOCBQUEUED is returned to btrfs_direct_read(), which
>    just returns it up the callchain, up to io_uring;
> 
> 10) The bio submitted for the first extent (step 5) completes and its
>     bio endio function, iomap_dio_bio_end_io(), decrements the last
>     reference on the struct iomap_dio object, resulting in calling
>     iomap_dio_complete_work() -> iomap_dio_complete().
> 
> 11) At iomap_dio_complete() we adjust the iocb->ki_pos from X to X + 4K
>     and return 4K (the amount of io done) to iomap_dio_complete_work();
> 
> 12) iomap_dio_complete_work() calls the iocb completion callback,
>     iocb->ki_complete() with a second argument value of 4K (total io
>     done) and the iocb with the adjust ki_pos of X + 4K. This results
>     in completing the read request for io_uring, leaving it with a
>     result of 4K bytes read, and only the first page of the buffer
>     filled in, while the remaining 3 pages, corresponding to the other
>     3 extents, were not filled;
> 
> 13) For the application, the result is unexpected because if we ask
>     to read N bytes, it expects to get N bytes read as long as those
>     N bytes don't cross the EOF (i_size).
> 
> MariaDB reports this as an error, as it's not expecting a short read,
> since it knows it's asking for read operations fully within the i_size
> boundary. This is typical in many applications, but it may also be
> questionable if they should react to such short reads by issuing more
> read calls to get the remaining data. Nevertheless, the short read
> happened due to a change in btrfs regarding how it deals with page
> faults while in the middle of a read operation, and there's no reason
> why btrfs can't have the previous behaviour of returning the whole data
> that was requested by the application.
> 
> The problem can also be triggered with the following simple program:
> 
>   /* Get O_DIRECT */
>   #ifndef _GNU_SOURCE
>   #define _GNU_SOURCE
>   #endif
> 
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <fcntl.h>
>   #include <errno.h>
>   #include <string.h>
>   #include <liburing.h>
> 
>   int main(int argc, char *argv[])
>   {
>       char *foo_path;
>       struct io_uring ring;
>       struct io_uring_sqe *sqe;
>       struct io_uring_cqe *cqe;
>       struct iovec iovec;
>       int fd;
>       long pagesize;
>       void *write_buf;
>       void *read_buf;
>       ssize_t ret;
>       int i;
> 
>       if (argc != 2) {
>           fprintf(stderr, "Use: %s <directory>\n", argv[0]);
>           return 1;
>       }
> 
>       foo_path = malloc(strlen(argv[1]) + 5);
>       if (!foo_path) {
>           fprintf(stderr, "Failed to allocate memory for file path\n");
>           return 1;
>       }
>       strcpy(foo_path, argv[1]);
>       strcat(foo_path, "/foo");
> 
>       /*
>        * Create file foo with 2 extents, each with a size matching
>        * the page size. Then allocate a buffer to read both extents
>        * with io_uring, using O_DIRECT and IOCB_NOWAIT. Before doing
>        * the read with io_uring, access the first page of the buffer
>        * to fault it in, so that during the read we only trigger a
>        * page fault when accessing the second page of the buffer.
>        */
>        fd = open(foo_path, O_CREAT | O_TRUNC | O_WRONLY |
>                 O_DIRECT, 0666);
>        if (fd == -1) {
>            fprintf(stderr,
>                    "Failed to create file 'foo': %s (errno %d)",
>                    strerror(errno), errno);
>            return 1;
>        }
> 
>        pagesize = sysconf(_SC_PAGE_SIZE);
>        ret = posix_memalign(&write_buf, pagesize, 2 * pagesize);
>        if (ret) {
>            fprintf(stderr, "Failed to allocate write buffer\n");
>            return 1;
>        }
> 
>        memset(write_buf, 0xab, pagesize);
>        memset(write_buf + pagesize, 0xcd, pagesize);
> 
>        /* Create 2 extents, each with a size matching page size. */
>        for (i = 0; i < 2; i++) {
>            ret = pwrite(fd, write_buf + i * pagesize, pagesize,
>                         i * pagesize);
>            if (ret != pagesize) {
>                fprintf(stderr,
>                      "Failed to write to file, ret = %ld errno %d (%s)\n",
>                       ret, errno, strerror(errno));
>                return 1;
>            }
>            ret = fsync(fd);
>            if (ret != 0) {
>                fprintf(stderr, "Failed to fsync file\n");
>                return 1;
>            }
>        }
> 
>        close(fd);
>        fd = open(foo_path, O_RDONLY | O_DIRECT);
>        if (fd == -1) {
>            fprintf(stderr,
>                    "Failed to open file 'foo': %s (errno %d)",
>                    strerror(errno), errno);
>            return 1;
>        }
> 
>        ret = posix_memalign(&read_buf, pagesize, 2 * pagesize);
>        if (ret) {
>            fprintf(stderr, "Failed to allocate read buffer\n");
>            return 1;
>        }
> 
>        /*
>         * Fault in only the first page of the read buffer.
>         * We want to trigger a page fault for the 2nd page of the
>         * read buffer during the read operation with io_uring
>         * (O_DIRECT and IOCB_NOWAIT).
>         */
>        memset(read_buf, 0, 1);
> 
>        ret = io_uring_queue_init(1, &ring, 0);
>        if (ret != 0) {
>            fprintf(stderr, "Failed to create io_uring queue\n");
>            return 1;
>        }
> 
>        sqe = io_uring_get_sqe(&ring);
>        if (!sqe) {
>            fprintf(stderr, "Failed to get io_uring sqe\n");
>            return 1;
>        }
> 
>        iovec.iov_base = read_buf;
>        iovec.iov_len = 2 * pagesize;
>        io_uring_prep_readv(sqe, fd, &iovec, 1, 0);
> 
>        ret = io_uring_submit_and_wait(&ring, 1);
>        if (ret != 1) {
>            fprintf(stderr,
>                    "Failed at io_uring_submit_and_wait()\n");
>            return 1;
>        }
> 
>        ret = io_uring_wait_cqe(&ring, &cqe);
>        if (ret < 0) {
>            fprintf(stderr, "Failed at io_uring_wait_cqe()\n");
>            return 1;
>        }
> 
>        printf("io_uring read result for file foo:\n\n");
>        printf("  cqe->res == %d (expected %d)\n", cqe->res, 2 * pagesize);
>        printf("  memcmp(read_buf, write_buf) == %d (expected 0)\n",
>               memcmp(read_buf, write_buf, 2 * pagesize));
> 
>        io_uring_cqe_seen(&ring, cqe);
>        io_uring_queue_exit(&ring);
> 
>        return 0;
>   }
> 
> When running it on an unpatched kernel:
> 
>   $ gcc io_uring_test.c -luring
>   $ mkfs.btrfs -f /dev/sda
>   $ mount /dev/sda /mnt/sda
>   $ ./a.out /mnt/sda
>   io_uring read result for file foo:
> 
>     cqe->res == 4096 (expected 8192)
>     memcmp(read_buf, write_buf) == -205 (expected 0)
> 
> After this patch, the read always returns 8192 bytes, with the buffer
> filled with the correct data. Although that reproducer always triggers
> the bug in my test vms, it's possible that it will not be so reliable
> on other environments, as that can happen if the bio for the first
> extent completes and decrements the reference on the struct iomap_dio
> object before we do the atomic_dec_and_test() on the reference at
> __iomap_dio_rw().
> 
> Fix this in btrfs by having btrfs_dio_iomap_begin() return -EAGAIN
> whenever we try to satisfy a non blocking IO request (IOMAP_NOWAIT flag
> set) over a range that spans multiple extents (or a mix of extents and
> holes). This avoids returning success to the caller when we only did
> partial IO, which is not optimal for writes and for reads it's actually
> incorrect, as the caller doesn't expect to get less bytes read than it has
> requested (unless EOF is crossed), as previously mentioned. This is also
> the type of behaviour that xfs follows (xfs_direct_write_iomap_begin()),
> even though it doesn't use IOMAP_DIO_PARTIAL.
> 
> A test case for fstests will follow soon.
> 
> Link: https://lore.kernel.org/linux-btrfs/CABVffEM0eEWho+206m470rtM0d9J8ue85TtR-A_oVTuGLWFicA@mail.gmail.com/
> Link: https://lore.kernel.org/linux-btrfs/CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com/
> CC: stable@vger.kernel.org # 5.16+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thank you very much for tracking it down, added to misc-next.
