Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCE7BC37F
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 03:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjJGBEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 21:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjJGBEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 21:04:46 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 18:04:45 PDT
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E85BB6
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 18:04:45 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 68D36A7C556; Fri,  6 Oct 2023 20:56:15 -0400 (EDT)
Date:   Fri, 6 Oct 2023 20:56:14 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Arno Renevier <arno@switchboard.app>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: SIGBUS with mapped file on full device
Message-ID: <ZSCsrkAF22Z1+c+9@hungrycats.org>
References: <CAFmLMRMYzSfmJvp0gccr0siT6jX8Nv5Xt9jVKfiUeXhpy3WRqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmLMRMYzSfmJvp0gccr0siT6jX8Nv5Xt9jVKfiUeXhpy3WRqw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 25, 2023 at 10:19:44AM -0700, Arno Renevier wrote:
> Hi,
> 
> I noticed that when storing user data on btrfs, chromium is systematically
> crashing with a SIGBUS signal when the disk is full. It does not happen
> with ext4.
> 
> This seems to happen because after failing to write to a file
> (unsuccessfully), chromium tries to write into a mapped file. That mapped
> file has been previously opened, and fallocated, and some data has been
> written into it to make sure the extent of the file is realized.
> 
> I will attach the reproduce the crash. It creates a file, fills it with
> data, and opens memory maps that file. Then, it creates another file, and
> tries to write into it until the disk runs  out of space. And then, it
> tries to write into the mapped file. It always results in a SIBGUS crash
> for me. There is no such crash with ext4.
> 
> Is it a bug in btrfs, or is the testcase (and chromium) doing
> something improper? (and if so, what should be done instead?)

fallocate on btrfs does not guarantee that all future writes to the
allocated blocks will succeed.  It preallocates space for _one_ write to
each data block, and makes a best effort to use the preallocated space
when that write occurs.

If any of the following conditions is not met when the write to a
preallocated block occurs, the write operation must allocate new space
for its data blocks, and may fail with ENOSPC:

1.  There must be enough metadata space for the write.  fallocate does
not attempt to reserve any metadata space.

2.  There must be only one write to the data block during its lifetime.
Once data has been written, the block reverts back to an ordinary,
non-preallocated data block.  fallocate cannot reserve space for another
write while data still exists in the block.

2b.  A corollary of #2 is that non-page-aligned writes will usually
trigger an allocation, as a page that is modified in two separate write
calls will be written twice.  This is especially common with shared mmap,
where writeback occurs at arbitrary times, and individual pages may be
written multiple times.

3.  The filesystem must have no snapshots or reflink copies sharing
references to the preallocated blocks.  If there are multiple references,
then a write to each reference will require a new data block allocation.
Once only a single reference remains, the preallocated data block reverts
back to prealloc behavior.

3b.  A common case of #3 is a user's scheduled backups, which will often
make a snapshot of the subvol to be backed up.  Incremental btrfs backups
with send+receive typically keep shared references to all data blocks
until at least the following backup cycle.  This effectively neutralizes
most of the benefit of prealloc:  the reserved space is wasted because
overlapping snapshot lifetimes will ensure no data can be written there.

fallocate's no-ENOSPC guarantee is more or less unimplementable on btrfs
datacow files.  The underlying problem is that in btrfs, the _file_
is datacow, not the _extent_.  Whenever there is a write to a prealloc
block in a file, that block of the file keeps reverting back to datacow.
Fixing that requires some small but significant changes in btrfs on-disk
format (i.e. move the prealloc/nodatacow/nodatasum bits down to the
individual extent items instead of the inode items where they are now).

Apart from the above btrfs-specific issues, mmap with MAP_SHARED on any
filesystem backed by a physical device always comes with a risk of SIGBUS.
Read and write IO errors from the backing storage will be translated
into a SIGBUS when the shared memory is paged in or out.

If a program chooses to write to an external device using mmap, it must
be prepared to handle SIGBUS like any other IO error.  Two popular
handling methods are to trap the signal and stop the writing thread,
or allow the process to be killed and have the parent process or a
dedicated monitoring process deal with the issue.  A third popular way
to handle IO errors is to not use mmap at all, and use ordinary write()
or io_uring instead.

> https://bugs.chromium.org/p/chromium/issues/detail?id=1484662
> chromium code executed before a file in mmaped:
> https://source.chromium.org/chromium/chromium/src/+/main:base/files/file_util_posix.cc;l=967?q=file_util%20posix&ss=chromium
> 
> instructions how to run the testcase:
> 
> $ truncate block.img -s 200M
> $ mkfs.btrfs -f block.img
> $ mkdir -p mount_point
> $ sudo mount -o loop block.img mount_point
> $ sudo chown $USER:$USER -R mount_point
> $ clang++ crash.cpp -o crash && rm -f mount_point/map.data
> mount_point/file.data && ./crash mount_point
> 
> ...
> 
> 
> $ uname -a
> Linux archlinux 6.5.3-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 13 Sep 2023
> 08:37:40 +0000 x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v6.5.1
> $ btrfs fi show
> 
> $ btrfs fi df mount_point
> Data, single: total=8.00MiB, used=0.00B
> System, DUP: total=8.00MiB, used=16.00KiB
> Metadata, DUP: total=32.00MiB, used=128.00KiB
> GlobalReserve, single: total=5.50MiB, used=0.00B

> #include <string>
> #include <cstring>
> 
> #include <sys/stat.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <fcntl.h>
> 
> bool is_directory(const char *path) {
>   struct stat st;
>   if (stat(path, &st) == -1) {
>     printf("Error: %s\n", strerror(errno));
>     return false;
>   }
>   return S_ISDIR(st.st_mode);
> }
> 
> bool append(int fd, size_t size) {
>   void* buffer = malloc(size);
>   memset(buffer, 0, size);
>   if (write(fd, buffer, size) <= 0) {
>       printf("Error in append: %s\n", strerror(errno));
>       free(buffer);
>       return 0;
>   }
>   free(buffer);
>   return 1;
> }
> 
> int fd_open_file_for_create(const char *path) {
>   int fd = open(path, O_RDWR | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR);
>   if (fd < 0) {
>       printf("Error in file opening: %s\n", strerror(errno));
>       return 1;
>   }
>   return fd;
> }
> 
> int main(int argc, char **argv) {
>   if (argc < 2) {
>     printf("Usage: %s <directory>\n", argv[0]);
>     return 1;
>   }
>   const char *directory = argv[1];
>   if (!is_directory(directory)) {
>     printf("Error: %s is not a directory\n", directory);
>     return 1;
>   }
> 
>   const std::string mapped_file_path = std::string(directory) + "/map.data";
> 
>   size_t mmap_size = 1024 * 1024 * 100;
>   // create a large file filled with 0
>   {
>     int fd = fd_open_file_for_create(mapped_file_path.c_str());
>     for (int i = 0; i < (mmap_size / 1024); i++) {
>       if (!append(fd, 1024)) {
>         break;
>       }
>     }
>     close(fd);
>   }
> 
>   // mmap that file
>   int mapped_fd = open(mapped_file_path.c_str(), O_RDWR | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR);
>   if (mapped_fd < 0) {
>     printf("Error in file opening: %s\n", strerror(errno));
>     return 1;
>   }
> 
>   // we get the same behavior if we fallocate the mapped file, instead of filling it with zeros.
> //  if (fallocate(mapped_fd, 0, 0, mmap_size) < 0) {
> //    printf("Error in file allocation: %s\n", strerror(errno));
>  //   return 1;
>   //}
> 
>   char* ptr = (char*)mmap(nullptr, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, mapped_fd, 0);
> 
>   // open another file, and write into it until the disk is full
>   const std::string data_file_path = std::string(directory) + "/file.data";
>   // create a large file filled with 0
>   {
>     int fd = fd_open_file_for_create(data_file_path.c_str());
>     for (int i = 0; i < (mmap_size / 1024); i++) {
>       if (!append(fd, 1024)) {
>         break;
>       }
>     }
>     close(fd);
>   }
> 
>   // now, try to write into the mapped file. With btrfs, it crashes. With ext4, it does not
>   ptr[0] = 0;
> 
>   close(mapped_fd);
> }

