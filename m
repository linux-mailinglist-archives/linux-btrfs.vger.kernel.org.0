Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5987D5AA3B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiIAX1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 19:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiIAX1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 19:27:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B397CB62
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 16:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662074852;
        bh=oWZv4S+rtADqWlNXGFPAo/G2pXsazmKFeLWiY5sZi2Y=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ajwkrHSbzrGZ1kilavUL/9Yq5ZiJ5KGlIsXRszYn/K7q90U8UkmvsptxGYlbPyl6I
         bvsG90WcCEXRX7Zv3HpFXA6PtVA/ojYFvObTXgtLv2t1kGiLef45nW8Y8yvEhz3QKi
         Rtp51h9FbZOkEJbNo9poWZClRRgbSUdzm9CjQE2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVHe-1onkpX1PKK-00JtWp; Fri, 02
 Sep 2022 01:27:32 +0200
Message-ID: <5ccad791-2978-d300-2f82-9cccea4f4c3a@gmx.com>
Date:   Fri, 2 Sep 2022 07:27:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <afad772c28ed5fc236785df6f3c43282d5c12534.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 10/10] btrfs: make fiemap more efficient and accurate
 reporting extent sharedness
In-Reply-To: <afad772c28ed5fc236785df6f3c43282d5c12534.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SdyqqUVlxKh4SJbQYngtTpA6kjS+tA+rTs6l+j8RidMGSN1HlSA
 y19iXD+ZtclXxJVUnhwANqlD+GKYwkgmJ31ssxIC7reS4Kq5BBHJzHnT/Zretpu/hFxVADk
 JZaGbwQz2s7sp3sJDmXLxZTfY7qUbN6wNGiwSgxveFurJ9wIr8q/Ck8CFujJWOXI7kP/Ben
 109VNe0jqqbRvdcIdNLyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgSi7PVBSIY=:e3jzplk6fkd6b3rCgBUPOP
 WiTsMlswELYiJOqK+CmrGFuUxAIko72HNsN2rXMZBcCBP9R41owv56embYPNROyw0pcwwjS2C
 GXlyWyFqDOUSwStnD0jZItk4o+ouSbT4eBbyaiuUnOftkDmPHPRIq3Yg4C5QNXRQSwOK2tdFP
 i7bY51fk/c5qDQHqkLt0h4BkOvCPaL2DbgzZTEGBT5Sgg2SWrG2f+bm43gWr+240OxEywtVGH
 Nob1gunhfDZh3tLAumBKED7pblXSfAuEVjcwRUIUbyNTKai3JWUvh1C7c5IafpF6JxIDPmXOb
 HydEqnC8OhJ7mibdBQTBbGpteidk8Ar4IwvlOWA/ftB5UBgXtepik32wD4j+5x97Wb5fj8bFl
 zMfo39V6ElEpF8tVzm7QbOMRo8gaTUeViJvDMbdNiEFmk/f36AWtPSdkINeJ03/LWF03jbjhb
 Ov0n0HswlvgcSYJD8wGVQXXB0zCryVB5Q7qr2vWgnEK0DZ9cZbYRdPMfCMQYsHw5xEzcaKpzu
 PSV29+0W9/VWlaAcpqFpCJjvUEtjl5UZi0YKvB7rjdoPLilDr7bWYXBIUC1g3KS7MPd/q4onG
 Y8tOxJvvd8eo86MDJP0qGmK1ivqZBeS8v2+YZw62cB1oDzdzuIFKwzdfWdPCKNSNrtTjN5dHc
 uHKrJciqaYP8gBKbFR0L6Sj8ItmNn0igP7rK5KXcUPrBmPfRBgNf4mgykgGJIjXNez4QCxGrp
 GNsfbv/MxvCw39jXHkPExdmUUBFb9OtMVt9sd1tdy5Zd8G7RNM2/kMJSjqI66TjxjHTNAWFYq
 YK/9cCmDSYLw6ICs2xGSoFf7zoPHSFJ7C5QAq3DNmCFWqChrXLsfH3A2sVGK2p5yu/ybavm2P
 Ac+Ilp/0r3o/PjzFw3eQzEZmVfvXjFlqvIllEhwsHD2TQUKe18pyW0Ss8VGkkONxZtY7X3gBe
 spyAlsgAC9VJRMYljo7RUWYZPvEsoM2Yqn8yVWt9d40l0z1DMdiWgm6XJ2YoDLeVK4Plg4/Vm
 nlyTohsYKpbDYlJuNrPwmhYegmcGFPmqmSo50j9SNdL+O+jQAJnX/VYCF1KffsX1j8i1GaMUI
 dN13w1pGxcA9gZmgAPHSdak3uhQr4JUbmIiutxfy+wBouUpjcfPlNLnNXqeSTuf8nk3qx8uop
 0EMozJ6Rei5xyBGTORP/Pz4o1V
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The current fiemap implementation does not scale very well with the numb=
er
> of extents a file has. This is both because the main algorithm to find o=
ut
> the extents has a high algorithmic complexity and because for each exten=
t
> we have to check if it's shared. This second part, checking if an extent
> is shared, is significantly improved by the two previous patches in this
> patchset, while the first part is improved by this specific patch. Every
> now and then we get reports from users mentioning fiemap is too slow or
> even unusable for files with a very large number of extents, such as the
> two recent reports referred to by the Link tags at the bottom of this
> change log.
>
> To understand why the part of finding which extents a file has is very
> inneficient, consider the example of doing a full ranged fiemap against
> a file that has over 100K extents (normal for example for a file with
> more than 10G of data and using compression, which limits the extent siz=
e
> to 128K). When we enter fiemap at extent_fiemap(), the following happens=
:
>
> 1) Before entering the main loop, we call get_extent_skip_holes() to get
>     the first extent map. This leads us to btrfs_get_extent_fiemap(), wh=
ich
>     in turn calls btrfs_get_extent(), to find the first extent map that
>     covers the file range [0, LLONG_MAX).
>
>     btrfs_get_extent() will first search the inode's extent map tree, to
>     see if we have an extent map there that covers the range. If it does
>     not find one, then it will search the inode's subvolume b+tree for a
>     fitting file extent item. After finding the file extent item, it wil=
l
>     allocate an extent map, fill it in with information extracted from t=
he
>     file extent item, and add it to the inode's extent map tree (which
>     requires a search for insertion in the tree).
>
> 2) Then we enter the main loop at extent_fiemap(), emit the details of
>     the extent, and call again get_extent_skip_holes(), with a start
>     offset matching the end of the extent map we previously processed.
>
>     We end up at btrfs_get_extent() again, will search the extent map tr=
ee
>     and then search the subvolume b+tree for a file extent item if we co=
uld
>     not find an extent map in the extent tree. We allocate an extent map=
,
>     fill it in with the details in the file extent item, and then insert
>     it into the extent map tree (yet another search in this tree).
>
> 3) The second step is repeated over and over, until we have processed th=
e
>     whole file range. Each iteration ends at btrfs_get_extent(), which
>     does a red black tree search on the extent map tree, then searches t=
he
>     subvolume b+tree, allocates an extent map and then does another sear=
ch
>     in the extent map tree in order to insert the extent map.
>
>     In the best scenario we have all the extent maps already in the exte=
nt
>     tree, and so for each extent we do a single search on a red black tr=
ee,
>     so we have a complexity of O(n log n).
>
>     In the worst scenario we don't have any extent map already loaded in
>     the extent map tree, or have very few already there. In this case th=
e
>     complexity is much higher since we do:
>
>     - A red black tree search on the extent map tree, which has O(log n)
>       complexity, initially very fast since the tree is empty or very
>       small, but as we end up allocating extent maps and adding them to
>       the tree when we don't find them there, each subsequent search on
>       the tree gets slower, since it's getting bigger and bigger after
>       each iteration.
>
>     - A search on the subvolume b+tree, also O(log n) complexity, but it
>       has items for all inodes in the subvolume, not just items for our
>       inode. Plus on a filesystem with concurrent operations on other
>       inodes, we can block doing the search due to lock contention on
>       b+tree nodes/leaves.
>
>     - Allocate an extent map - this can block, and can also fail if we
>       are under serious memory pressure.
>
>     - Do another search on the extent maps red black tree, with the goal
>       of inserting the extent map we just allocated. Again, after every
>       iteration this tree is getting bigger by 1 element, so after many
>       iterations the searches are slower and slower.
>
>     - We will not need the allocated extent map anymore, so it's pointle=
ss
>       to add it to the extent map tree. It's just wasting time and memor=
y.
>
>     In short we end up searching the extent map tree multiple times, on =
a
>     tree that is growing bigger and bigger after each iteration. And
>     besides that we visit the same leaf of the subvolume b+tree many tim=
es,
>     since a leaf with the default size of 16K can easily have more than =
200
>     file extent items.
>
> This is very inneficient overall. This patch changes the algorithm to
> instead iterate over the subvolume b+tree, visiting each leaf only once,
> and only searching in the extent map tree for file ranges that have hole=
s
> or prealloc extents, in order to figure out if we have delalloc there.
> It will never allocate an extent map and add it to the extent map tree.
> This is very similar to what was previously done for the lseek's hole an=
d
> data seeking features.
>
> Also, the current implementation relying on extent maps for figuring out
> which extents we have is not correct. This is because extent maps can be
> merged even if they represent different extents - we do this to minimize
> memory utilization and keep extent map trees smaller. For example if we
> have two extents that are contiguous on disk, once we load the two exten=
t
> maps, they get merged into a single one - however if only one of the
> extents is shared, we end up reporting both as shared or both as not
> shared, which is incorrect.

Is there any other major usage for extent map now?

I can only think of read, which uses extent map to grab the logical
bytenr of the real extent.

In that case, the SHARED flag doesn't make much sense anyway, can we do
a cleanup for those flags? Since fiemap/lseek no longer relies on extent
map anymore.

>
> This reproducer triggers that bug:
>
>      $ cat fiemap-bug.sh
>      #!/bin/bash
>
>      DEV=3D/dev/sdj
>      MNT=3D/mnt/sdj
>
>      mkfs.btrfs -f $DEV
>      mount $DEV $MNT
>
>      # Create a file with two 256K extents.
>      # Since there is no other write activity, they will be contiguous,
>      # and their extent maps merged, despite having two distinct extents=
.
>      xfs_io -f -c "pwrite -S 0xab 0 256K" \
>                -c "fsync" \
>                -c "pwrite -S 0xcd 256K 256K" \
>                -c "fsync" \
>                $MNT/foo
>
>      # Now clone only the second extent into another file.
>      xfs_io -f -c "reflink $MNT/foo 256K 0 256K" $MNT/bar
>
>      # Filefrag will report a single 512K extent, and say it's not share=
d.
>      echo
>      filefrag -v $MNT/foo
>
>      umount $MNT
>
> Running the reproducer:
>
>      $ ./fiemap-bug.sh
>      wrote 262144/262144 bytes at offset 0
>      256 KiB, 64 ops; 0.0038 sec (65.479 MiB/sec and 16762.7030 ops/sec)
>      wrote 262144/262144 bytes at offset 262144
>      256 KiB, 64 ops; 0.0040 sec (61.125 MiB/sec and 15647.9218 ops/sec)
>      linked 262144/262144 bytes at offset 0
>      256 KiB, 1 ops; 0.0002 sec (1.034 GiB/sec and 4237.2881 ops/sec)
>
>      Filesystem type is: 9123683e
>      File size of /mnt/sdj/foo is 524288 (128 blocks of 4096 bytes)
>       ext:     logical_offset:        physical_offset: length:   expecte=
d: flags:
>         0:        0..     127:       3328..      3455:    128:          =
   last,eof
>      /mnt/sdj/foo: 1 extent found
>
> We end up reporting that we have a single 512K that is not shared, howev=
er
> we have two 256K extents, and the second one is shared. Changing the
> reproducer to clone instead the first extent into file 'bar', makes us
> report a single 512K extent that is shared, which is algo incorrect sinc=
e
> we have two 256K extents and only the first one is shared.
>
> This patch is part of a larger patchset that is comprised of the followi=
ng
> patches:
>
>      btrfs: allow hole and data seeking to be interruptible
>      btrfs: make hole and data seeking a lot more efficient
>      btrfs: remove check for impossible block start for an extent map at=
 fiemap
>      btrfs: remove zero length check when entering fiemap
>      btrfs: properly flush delalloc when entering fiemap
>      btrfs: allow fiemap to be interruptible
>      btrfs: rename btrfs_check_shared() to a more descriptive name
>      btrfs: speedup checking for extent sharedness during fiemap
>      btrfs: skip unnecessary extent buffer sharedness checks during fiem=
ap
>      btrfs: make fiemap more efficient and accurate reporting extent sha=
redness
>
> The patchset was tested on a machine running a non-debug kernel (Debian'=
s
> default config) and compared the tests below on a branch without the
> patchset versus the same branch with the whole patchset applied.
>
> The following test for a large compressed file without holes:
>
>      $ cat fiemap-perf-test.sh
>      #!/bin/bash
>
>      DEV=3D/dev/sdi
>      MNT=3D/mnt/sdi
>
>      mkfs.btrfs -f $DEV
>      mount -o compress=3Dlzo $DEV $MNT
>
>      # 40G gives 327680 128K file extents (due to compression).
>      xfs_io -f -c "pwrite -S 0xab -b 1M 0 20G" $MNT/foobar
>
>      umount $MNT
>      mount -o compress=3Dlzo $DEV $MNT
>
>      start=3D$(date +%s%N)
>      filefrag $MNT/foobar
>      end=3D$(date +%s%N)
>      dur=3D$(( (end - start) / 1000000 ))
>      echo "fiemap took $dur milliseconds (metadata not cached)"
>
>      start=3D$(date +%s%N)
>      filefrag $MNT/foobar
>      end=3D$(date +%s%N)
>      dur=3D$(( (end - start) / 1000000 ))
>      echo "fiemap took $dur milliseconds (metadata cached)"
>
>      umount $MNT
>
> Before patchset:
>
>      $ ./fiemap-perf-test.sh
>      (...)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 3597 milliseconds (metadata not cached)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 2107 milliseconds (metadata cached)
>
> After patchset:
>
>      $ ./fiemap-perf-test.sh
>      (...)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 1214 milliseconds (metadata not cached)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 684 milliseconds (metadata cached)
>
> That's a speedup of about 3x for both cases (no metadata cached and all
> metadata cached).
>
> The test provided by Pavel (first Link tag at the bottom), which uses
> files with a large number of holes, was also used to measure the gains,
> and it consists on a small C program and a shell script to invoke it.
> The C program is the following:
>
>      $ cat pavels-test.c
>      #include <stdio.h>
>      #include <unistd.h>
>      #include <stdlib.h>
>      #include <fcntl.h>
>
>      #include <sys/stat.h>
>      #include <sys/time.h>
>      #include <sys/ioctl.h>
>
>      #include <linux/fs.h>
>      #include <linux/fiemap.h>
>
>      #define FILE_INTERVAL (1<<13) /* 8Kb */
>
>      long long interval(struct timeval t1, struct timeval t2)
>      {
>          long long val =3D 0;
>          val +=3D (t2.tv_usec - t1.tv_usec);
>          val +=3D (t2.tv_sec - t1.tv_sec) * 1000 * 1000;
>          return val;
>      }
>
>      int main(int argc, char **argv)
>      {
>          struct fiemap fiemap =3D {};
>          struct timeval t1, t2;
>          char data =3D 'a';
>          struct stat st;
>          int fd, off, file_size =3D FILE_INTERVAL;
>
>          if (argc !=3D 3 && argc !=3D 2) {
>                  printf("usage: %s <path> [size]\n", argv[0]);
>                  return 1;
>          }
>
>          if (argc =3D=3D 3)
>                  file_size =3D atoi(argv[2]);
>          if (file_size < FILE_INTERVAL)
>                  file_size =3D FILE_INTERVAL;
>          file_size -=3D file_size % FILE_INTERVAL;
>
>          fd =3D open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0644);
>          if (fd < 0) {
>              perror("open");
>              return 1;
>          }
>
>          for (off =3D 0; off < file_size; off +=3D FILE_INTERVAL) {
>              if (pwrite(fd, &data, 1, off) !=3D 1) {
>                  perror("pwrite");
>                  close(fd);
>                  return 1;
>              }
>          }
>
>          if (ftruncate(fd, file_size)) {
>              perror("ftruncate");
>              close(fd);
>              return 1;
>          }
>
>          if (fstat(fd, &st) < 0) {
>              perror("fstat");
>              close(fd);
>              return 1;
>          }
>
>          printf("size: %ld\n", st.st_size);
>          printf("actual size: %ld\n", st.st_blocks * 512);
>
>          fiemap.fm_length =3D FIEMAP_MAX_OFFSET;
>          gettimeofday(&t1, NULL);
>          if (ioctl(fd, FS_IOC_FIEMAP, &fiemap) < 0) {
>              perror("fiemap");
>              close(fd);
>              return 1;
>          }
>          gettimeofday(&t2, NULL);
>
>          printf("fiemap: fm_mapped_extents =3D %d\n",
>                 fiemap.fm_mapped_extents);
>          printf("time =3D %lld us\n", interval(t1, t2));
>
>          close(fd);
>          return 0;
>      }
>
>      $ gcc -o pavels_test pavels_test.c
>
> And the wrapper shell script:
>
>      $ cat fiemap-pavels-test.sh
>
>      #!/bin/bash
>
>      DEV=3D/dev/sdi
>      MNT=3D/mnt/sdi
>
>      mkfs.btrfs -f -O no-holes $DEV
>      mount $DEV $MNT
>
>      echo
>      echo "*********** 256M ***********"
>      echo
>
>      ./pavels-test $MNT/testfile $((1 << 28))
>      echo
>      ./pavels-test $MNT/testfile $((1 << 28))
>
>      echo
>      echo "*********** 512M ***********"
>      echo
>
>      ./pavels-test $MNT/testfile $((1 << 29))
>      echo
>      ./pavels-test $MNT/testfile $((1 << 29))
>
>      echo
>      echo "*********** 1G ***********"
>      echo
>
>      ./pavels-test $MNT/testfile $((1 << 30))
>      echo
>      ./pavels-test $MNT/testfile $((1 << 30))
>
>      umount $MNT
>
> Running his reproducer before applying the patchset:
>
>      *********** 256M ***********
>
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents =3D 32768
>      time =3D 4003133 us
>
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents =3D 32768
>      time =3D 4895330 us
>
>      *********** 512M ***********
>
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents =3D 65536
>      time =3D 30123675 us
>
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents =3D 65536
>      time =3D 33450934 us
>
>      *********** 1G ***********
>
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents =3D 131072
>      time =3D 224924074 us
>
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents =3D 131072
>      time =3D 217239242 us
>
> Running it after applying the patchset:
>
>      *********** 256M ***********
>
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents =3D 32768
>      time =3D 29475 us
>
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents =3D 32768
>      time =3D 29307 us
>
>      *********** 512M ***********
>
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents =3D 65536
>      time =3D 58996 us
>
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents =3D 65536
>      time =3D 59115 us
>
>      *********** 1G ***********
>
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents =3D 116251
>      time =3D 124141 us
>
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents =3D 131072
>      time =3D 119387 us
>
> The speedup is massive, both on the first fiemap call and on the second
> one as well, as his test creates files with many holes and small extents
> (every extent follows a hole and precedes another hole).
>
> For the 256M file we go from 4 seconds down to 29 milliseconds in the
> first run, and then from 4.9 seconds down to 29 milliseconds again in th=
e
> second run, a speedup of 138x and 169x, respectively.
>
> For the 512M file we go from 30.1 seconds down to 59 milliseconds in the
> first run, and then from 33.5 seconds down to 59 milliseconds again in t=
he
> second run, a speedup of 510x and 568x, respectively.
>
> For the 1G file, we go from 225 seconds down to 124 milliseconds in the
> first run, and then from 217 seconds down to 119 milliseconds in the
> second run, a speedup of 1815x and 1824x, respectively.
>
> Reported-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc=
6788a7@virtuozzo.com/
> Reported-by: Dominique MARTINET <dominique.martinet@atmark-techno.com>
> Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno=
.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.h     |   4 +-
>   fs/btrfs/extent_io.c | 714 +++++++++++++++++++++++++++++--------------
>   fs/btrfs/file.c      |  16 +-
>   fs/btrfs/inode.c     | 140 +--------
>   4 files changed, 506 insertions(+), 368 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f7fe7f633eb5..7b266f9dc8b4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3402,8 +3402,6 @@ unsigned int btrfs_verify_data_csum(struct btrfs_b=
io *bbio,
>   				    u64 start, u64 end);
>   int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
>   			  u32 bio_offset, struct page *page, u32 pgoff);
> -struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> -					   u64 start, u64 len);
>   noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *le=
n,
>   			      u64 *orig_start, u64 *orig_block_len,
>   			      u64 *ram_bytes, bool strict);
> @@ -3583,6 +3581,8 @@ int btrfs_fdatawrite_range(struct inode *inode, lo=
ff_t start, loff_t end);
>   int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>   			   size_t *write_bytes);
>   void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
> +bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start,=
 u64 end,
> +				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
>
>   /* tree-defrag.c */
>   int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0e3fa9b08aaf..50bb2182e795 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5353,42 +5353,6 @@ int try_release_extent_mapping(struct page *page,=
 gfp_t mask)
>   	return try_release_extent_state(tree, page, mask);
>   }
>
> -/*
> - * helper function for fiemap, which doesn't want to see any holes.
> - * This maps until we find something past 'last'
> - */
> -static struct extent_map *get_extent_skip_holes(struct btrfs_inode *ino=
de,
> -						u64 offset, u64 last)
> -{
> -	u64 sectorsize =3D btrfs_inode_sectorsize(inode);
> -	struct extent_map *em;
> -	u64 len;
> -
> -	if (offset >=3D last)
> -		return NULL;
> -
> -	while (1) {
> -		len =3D last - offset;
> -		if (len =3D=3D 0)
> -			break;
> -		len =3D ALIGN(len, sectorsize);
> -		em =3D btrfs_get_extent_fiemap(inode, offset, len);
> -		if (IS_ERR(em))
> -			return em;
> -
> -		/* if this isn't a hole return it */
> -		if (em->block_start !=3D EXTENT_MAP_HOLE)
> -			return em;
> -
> -		/* this is a hole, advance to the next extent */
> -		offset =3D extent_map_end(em);
> -		free_extent_map(em);
> -		if (offset >=3D last)
> -			break;
> -	}
> -	return NULL;
> -}
> -
>   /*
>    * To cache previous fiemap extent
>    *
> @@ -5418,6 +5382,9 @@ static int emit_fiemap_extent(struct fiemap_extent=
_info *fieinfo,
>   {
>   	int ret =3D 0;
>
> +	/* Set at the end of extent_fiemap(). */
> +	ASSERT((flags & FIEMAP_EXTENT_LAST) =3D=3D 0);
> +
>   	if (!cache->cached)
>   		goto assign;
>
> @@ -5446,11 +5413,10 @@ static int emit_fiemap_extent(struct fiemap_exte=
nt_info *fieinfo,
>   	 */
>   	if (cache->offset + cache->len  =3D=3D offset &&
>   	    cache->phys + cache->len =3D=3D phys  &&
> -	    (cache->flags & ~FIEMAP_EXTENT_LAST) =3D=3D
> -			(flags & ~FIEMAP_EXTENT_LAST)) {
> +	    cache->flags =3D=3D flags) {
>   		cache->len +=3D len;
>   		cache->flags |=3D flags;
> -		goto try_submit_last;
> +		return 0;
>   	}
>
>   	/* Not mergeable, need to submit cached one */
> @@ -5465,13 +5431,8 @@ static int emit_fiemap_extent(struct fiemap_exten=
t_info *fieinfo,
>   	cache->phys =3D phys;
>   	cache->len =3D len;
>   	cache->flags =3D flags;
> -try_submit_last:
> -	if (cache->flags & FIEMAP_EXTENT_LAST) {
> -		ret =3D fiemap_fill_next_extent(fieinfo, cache->offset,
> -				cache->phys, cache->len, cache->flags);
> -		cache->cached =3D false;
> -	}
> -	return ret;
> +
> +	return 0;
>   }
>
>   /*
> @@ -5501,229 +5462,534 @@ static int emit_last_fiemap_cache(struct fiema=
p_extent_info *fieinfo,
>   	return ret;
>   }
>
> -int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info =
*fieinfo,
> -		  u64 start, u64 len)
> +static int fiemap_next_leaf_item(struct btrfs_inode *inode,
> +				 struct btrfs_path *path)
>   {
> -	int ret =3D 0;
> -	u64 off;
> -	u64 max =3D start + len;
> -	u32 flags =3D 0;
> -	u32 found_type;
> -	u64 last;
> -	u64 last_for_get_extent =3D 0;
> -	u64 disko =3D 0;
> -	u64 isize =3D i_size_read(&inode->vfs_inode);
> -	struct btrfs_key found_key;
> -	struct extent_map *em =3D NULL;
> -	struct extent_state *cached_state =3D NULL;
> -	struct btrfs_path *path;
> +	struct extent_buffer *clone;
> +	struct btrfs_key key;
> +	int slot;
> +	int ret;
> +
> +	path->slots[0]++;
> +	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
> +		return 0;
> +
> +	ret =3D btrfs_next_leaf(inode->root, path);
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	/*
> +	 * Don't bother with cloning if there are no more file extent items fo=
r
> +	 * our inode.
> +	 */
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +	if (key.objectid !=3D btrfs_ino(inode) || key.type !=3D BTRFS_EXTENT_D=
ATA_KEY)
> +		return 1;
> +
> +	/* See the comment at fiemap_search_slot() about why we clone. */
> +	clone =3D btrfs_clone_extent_buffer(path->nodes[0]);
> +	if (!clone)
> +		return -ENOMEM;
> +
> +	slot =3D path->slots[0];
> +	btrfs_release_path(path);
> +	path->nodes[0] =3D clone;
> +	path->slots[0] =3D slot;
> +
> +	return 0;
> +}
> +
> +/*
> + * Search for the first file extent item that starts at a given file of=
fset or
> + * the one that starts immediately before that offset.
> + * Returns: 0 on success, < 0 on error, 1 if not found.
> + */
> +static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_p=
ath *path,
> +			      u64 file_offset)
> +{
> +	const u64 ino =3D btrfs_ino(inode);
>   	struct btrfs_root *root =3D inode->root;
> -	struct fiemap_cache cache =3D { 0 };
> -	struct btrfs_backref_shared_cache *backref_cache;
> -	struct ulist *roots;
> -	struct ulist *tmp_ulist;
> -	int end =3D 0;
> -	u64 em_start =3D 0;
> -	u64 em_len =3D 0;
> -	u64 em_end =3D 0;
> +	struct extent_buffer *clone;
> +	struct btrfs_key key;
> +	int slot;
> +	int ret;
>
> -	backref_cache =3D kzalloc(sizeof(*backref_cache), GFP_KERNEL);
> -	path =3D btrfs_alloc_path();
> -	roots =3D ulist_alloc(GFP_KERNEL);
> -	tmp_ulist =3D ulist_alloc(GFP_KERNEL);
> -	if (!backref_cache || !path || !roots || !tmp_ulist) {
> -		ret =3D -ENOMEM;
> -		goto out_free_ulist;
> +	key.objectid =3D ino;
> +	key.type =3D BTRFS_EXTENT_DATA_KEY;
> +	key.offset =3D file_offset;
> +
> +	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > 0 && path->slots[0] > 0) {
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
> +		if (key.objectid =3D=3D ino && key.type =3D=3D BTRFS_EXTENT_DATA_KEY)
> +			path->slots[0]--;
> +	}
> +
> +	if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0])) {
> +		ret =3D btrfs_next_leaf(root, path);
> +		if (ret !=3D 0)
> +			return ret;
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +		if (key.objectid !=3D ino || key.type !=3D BTRFS_EXTENT_DATA_KEY)
> +			return 1;
>   	}
>
>   	/*
> -	 * We can't initialize that to 'start' as this could miss extents due
> -	 * to extent item merging
> +	 * We clone the leaf and use it during fiemap. This is because while
> +	 * using the leaf we do expensive things like checking if an extent is
> +	 * shared, which can take a long time. In order to prevent blocking
> +	 * other tasks for too long, we use a clone of the leaf. We have locke=
d
> +	 * the file range in the inode's io tree, so we know none of our file
> +	 * extent items can change. This way we avoid blocking other tasks tha=
t
> +	 * want to insert items for other inodes in the same leaf or b+tree
> +	 * rebalance operations (triggered for example when someone is trying
> +	 * to push items into this leaf when trying to insert an item in a
> +	 * neighbour leaf).
> +	 * We also need the private clone because holding a read lock on an
> +	 * extent buffer of the subvolume's b+tree will make lockdep unhappy
> +	 * when we call fiemap_fill_next_extent(), because that may cause a pa=
ge
> +	 * fault when filling the user space buffer with fiemap data.
>   	 */
> -	off =3D 0;
> -	start =3D round_down(start, btrfs_inode_sectorsize(inode));
> -	len =3D round_up(max, btrfs_inode_sectorsize(inode)) - start;
> +	clone =3D btrfs_clone_extent_buffer(path->nodes[0]);
> +	if (!clone)
> +		return -ENOMEM;
> +
> +	slot =3D path->slots[0];
> +	btrfs_release_path(path);
> +	path->nodes[0] =3D clone;
> +	path->slots[0] =3D slot;

Although this is correct, it still looks a little tricky.

We rely on btrfs_release_path() to release all tree blocks in the
subvolume tree, including unlocking the tree blocks, thus path->locks[0]
is also 0, meaning next time we call btrfs_release_path() we won't try
to unlock the cloned eb.

But I'd say it's still pretty tricky, and unfortunately I don't have any
better alternative.

> +
> +	return 0;
> +}
> +
> +/*
> + * Process a range which is a hole or a prealloc extent in the inode's =
subvolume
> + * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a=
 prealloc
> + * extent. The end offset (@end) is inclusive.
> + */
> +static int fiemap_process_hole(struct btrfs_inode *inode,

Does the name still make sense as we're handling both hole and prealloc
range?


And I always find the delalloc search a big pain during lseek/fiemap.

I guess except using certain flags, there is some hard requirement for
delalloc range reporting?

> +			       struct fiemap_extent_info *fieinfo,
> +			       struct fiemap_cache *cache,
> +			       struct btrfs_backref_shared_cache *backref_cache,
> +			       u64 disk_bytenr, u64 extent_offset,
> +			       u64 extent_gen,
> +			       struct ulist *roots, struct ulist *tmp_ulist,
> +			       u64 start, u64 end)
> +{
> +	const u64 i_size =3D i_size_read(&inode->vfs_inode);
> +	const u64 ino =3D btrfs_ino(inode);
> +	u64 cur_offset =3D start;
> +	u64 last_delalloc_end =3D 0;
> +	u32 prealloc_flags =3D FIEMAP_EXTENT_UNWRITTEN;
> +	bool checked_extent_shared =3D false;
> +	int ret;
>
>   	/*
> -	 * lookup the last file extent.  We're not using i_size here
> -	 * because there might be preallocation past i_size
> +	 * There can be no delalloc past i_size, so don't waste time looking f=
or
> +	 * it beyond i_size.
>   	 */
> -	ret =3D btrfs_lookup_file_extent(NULL, root, path, btrfs_ino(inode), -=
1,
> -				       0);
> -	if (ret < 0) {
> -		goto out_free_ulist;
> -	} else {
> -		WARN_ON(!ret);
> -		if (ret =3D=3D 1)
> -			ret =3D 0;
> -	}
> +	while (cur_offset < end && cur_offset < i_size) {
> +		u64 delalloc_start;
> +		u64 delalloc_end;
> +		u64 prealloc_start;
> +		u64 prealloc_len =3D 0;
> +		bool delalloc;
> +
> +		delalloc =3D btrfs_find_delalloc_in_range(inode, cur_offset, end,
> +							&delalloc_start,
> +							&delalloc_end);
> +		if (!delalloc)
> +			break;
>
> -	path->slots[0]--;
> -	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
> -	found_type =3D found_key.type;
> -
> -	/* No extents, but there might be delalloc bits */
> -	if (found_key.objectid !=3D btrfs_ino(inode) ||
> -	    found_type !=3D BTRFS_EXTENT_DATA_KEY) {
> -		/* have to trust i_size as the end */
> -		last =3D (u64)-1;
> -		last_for_get_extent =3D isize;
> -	} else {
>   		/*
> -		 * remember the start of the last extent.  There are a
> -		 * bunch of different factors that go into the length of the
> -		 * extent, so its much less complex to remember where it started
> +		 * If this is a prealloc extent we have to report every section
> +		 * of it that has no delalloc.
>   		 */
> -		last =3D found_key.offset;
> -		last_for_get_extent =3D last + 1;
> +		if (disk_bytenr !=3D 0) {
> +			if (last_delalloc_end =3D=3D 0) {
> +				prealloc_start =3D start;
> +				prealloc_len =3D delalloc_start - start;
> +			} else {
> +				prealloc_start =3D last_delalloc_end + 1;
> +				prealloc_len =3D delalloc_start - prealloc_start;
> +			}
> +		}
> +
> +		if (prealloc_len > 0) {
> +			if (!checked_extent_shared && fieinfo->fi_extents_max) {
> +				ret =3D btrfs_is_data_extent_shared(inode->root,
> +							  ino, disk_bytenr,
> +							  extent_gen, roots,
> +							  tmp_ulist,
> +							  backref_cache);
> +				if (ret < 0)
> +					return ret;
> +				else if (ret > 0)
> +					prealloc_flags |=3D FIEMAP_EXTENT_SHARED;
> +
> +				checked_extent_shared =3D true;
> +			}
> +			ret =3D emit_fiemap_extent(fieinfo, cache, prealloc_start,
> +						 disk_bytenr + extent_offset,
> +						 prealloc_len, prealloc_flags);
> +			if (ret)
> +				return ret;
> +			extent_offset +=3D prealloc_len;
> +		}
> +
> +		ret =3D emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
> +					 delalloc_end + 1 - delalloc_start,
> +					 FIEMAP_EXTENT_DELALLOC |
> +					 FIEMAP_EXTENT_UNKNOWN);
> +		if (ret)
> +			return ret;
> +
> +		last_delalloc_end =3D delalloc_end;
> +		cur_offset =3D delalloc_end + 1;
> +		extent_offset +=3D cur_offset - delalloc_start;
> +		cond_resched();
> +	}
> +
> +	/*
> +	 * Either we found no delalloc for the whole prealloc extent or we hav=
e
> +	 * a prealloc extent that spans i_size or starts at or after i_size.
> +	 */
> +	if (disk_bytenr !=3D 0 && last_delalloc_end < end) {
> +		u64 prealloc_start;
> +		u64 prealloc_len;
> +
> +		if (last_delalloc_end =3D=3D 0) {
> +			prealloc_start =3D start;
> +			prealloc_len =3D end + 1 - start;
> +		} else {
> +			prealloc_start =3D last_delalloc_end + 1;
> +			prealloc_len =3D end + 1 - prealloc_start;
> +		}
> +
> +		if (!checked_extent_shared && fieinfo->fi_extents_max) {
> +			ret =3D btrfs_is_data_extent_shared(inode->root,
> +							  ino, disk_bytenr,
> +							  extent_gen, roots,
> +							  tmp_ulist,
> +							  backref_cache);
> +			if (ret < 0)
> +				return ret;
> +			else if (ret > 0)
> +				prealloc_flags |=3D FIEMAP_EXTENT_SHARED;
> +		}
> +		ret =3D emit_fiemap_extent(fieinfo, cache, prealloc_start,
> +					 disk_bytenr + extent_offset,
> +					 prealloc_len, prealloc_flags);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
> +					  struct btrfs_path *path,
> +					  u64 *last_extent_end_ret)
> +{
> +	const u64 ino =3D btrfs_ino(inode);
> +	struct btrfs_root *root =3D inode->root;
> +	struct extent_buffer *leaf;
> +	struct btrfs_file_extent_item *ei;
> +	struct btrfs_key key;
> +	u64 disk_bytenr;
> +	int ret;
> +
> +	/*
> +	 * Lookup the last file extent. We're not using i_size here because
> +	 * there might be preallocation past i_size.
> +	 */

I'm wondering how could this happen?

Normally if we're truncating an inode, the extents starting after
round_up(i_size, sectorsize) should be dropped.

Or if we later enlarge the inode, we may hit old extents and read out
some stale data other than expected zeros.

Thus searching using round_up(i_size, sectorsize) should still let us to
reach the slot after the last file extent.

Or did I miss something?

Thanks,
Qu

> +	ret =3D btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
> +	/* There can't be a file extent item at offset (u64)-1 */
> +	ASSERT(ret !=3D 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * For a non-existing key, btrfs_search_slot() always leaves us at a
> +	 * slot > 0, except if the btree is empty, which is impossible because
> +	 * at least it has the inode item for this inode and all the items for
> +	 * the root inode 256.
> +	 */
> +	ASSERT(path->slots[0] > 0);
> +	path->slots[0]--;
> +	leaf =3D path->nodes[0];
> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +	if (key.objectid !=3D ino || key.type !=3D BTRFS_EXTENT_DATA_KEY) {
> +		/* No file extent items in the subvolume tree. */
> +		*last_extent_end_ret =3D 0;
> +		return 0;
>   	}
> -	btrfs_release_path(path);
>
>   	/*
> -	 * we might have some extents allocated but more delalloc past those
> -	 * extents.  so, we trust isize unless the start of the last extent is
> -	 * beyond isize
> +	 * For an inline extent, the disk_bytenr is where inline data starts a=
t,
> +	 * so first check if we have an inline extent item before checking if =
we
> +	 * have an implicit hole (disk_bytenr =3D=3D 0).
>   	 */
> -	if (last < isize) {
> -		last =3D (u64)-1;
> -		last_for_get_extent =3D isize;
> +	ei =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_i=
tem);
> +	if (btrfs_file_extent_type(leaf, ei) =3D=3D BTRFS_FILE_EXTENT_INLINE) =
{
> +		*last_extent_end_ret =3D btrfs_file_extent_end(path);
> +		return 0;
>   	}
>
> -	lock_extent_bits(&inode->io_tree, start, start + len - 1,
> -			 &cached_state);
> +	/*
> +	 * Find the last file extent item that is not a hole (when NO_HOLES is
> +	 * not enabled). This should take at most 2 iterations in the worst
> +	 * case: we have one hole file extent item at slot 0 of a leaf and
> +	 * another hole file extent item as the last item in the previous leaf=
.
> +	 * This is because we merge file extent items that represent holes.
> +	 */
> +	disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, ei);
> +	while (disk_bytenr =3D=3D 0) {
> +		ret =3D btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
> +		if (ret < 0) {
> +			return ret;
> +		} else if (ret > 0) {
> +			/* No file extent items that are not holes. */
> +			*last_extent_end_ret =3D 0;
> +			return 0;
> +		}
> +		leaf =3D path->nodes[0];
> +		ei =3D btrfs_item_ptr(leaf, path->slots[0],
> +				    struct btrfs_file_extent_item);
> +		disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, ei);
> +	}
>
> -	em =3D get_extent_skip_holes(inode, start, last_for_get_extent);
> -	if (!em)
> -		goto out;
> -	if (IS_ERR(em)) {
> -		ret =3D PTR_ERR(em);
> +	*last_extent_end_ret =3D btrfs_file_extent_end(path);
> +	return 0;
> +}
> +
> +int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info =
*fieinfo,
> +		  u64 start, u64 len)
> +{
> +	const u64 ino =3D btrfs_ino(inode);
> +	struct extent_state *cached_state =3D NULL;
> +	struct btrfs_path *path;
> +	struct btrfs_root *root =3D inode->root;
> +	struct fiemap_cache cache =3D { 0 };
> +	struct btrfs_backref_shared_cache *backref_cache;
> +	struct ulist *roots;
> +	struct ulist *tmp_ulist;
> +	u64 last_extent_end;
> +	u64 prev_extent_end;
> +	u64 lockstart;
> +	u64 lockend;
> +	bool stopped =3D false;
> +	int ret;
> +
> +	backref_cache =3D kzalloc(sizeof(*backref_cache), GFP_KERNEL);
> +	path =3D btrfs_alloc_path();
> +	roots =3D ulist_alloc(GFP_KERNEL);
> +	tmp_ulist =3D ulist_alloc(GFP_KERNEL);
> +	if (!backref_cache || !path || !roots || !tmp_ulist) {
> +		ret =3D -ENOMEM;
>   		goto out;
>   	}
>
> -	while (!end) {
> -		u64 offset_in_extent =3D 0;
> +	lockstart =3D round_down(start, btrfs_inode_sectorsize(inode));
> +	lockend =3D round_up(start + len, btrfs_inode_sectorsize(inode));
> +	prev_extent_end =3D lockstart;
>
> -		/* break if the extent we found is outside the range */
> -		if (em->start >=3D max || extent_map_end(em) < off)
> -			break;
> +	lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
>
> -		/*
> -		 * get_extent may return an extent that starts before our
> -		 * requested range.  We have to make sure the ranges
> -		 * we return to fiemap always move forward and don't
> -		 * overlap, so adjust the offsets here
> -		 */
> -		em_start =3D max(em->start, off);
> +	ret =3D fiemap_find_last_extent_offset(inode, path, &last_extent_end);
> +	if (ret < 0)
> +		goto out_unlock;
> +	btrfs_release_path(path);
>
> +	path->reada =3D READA_FORWARD;
> +	ret =3D fiemap_search_slot(inode, path, lockstart);
> +	if (ret < 0) {
> +		goto out_unlock;
> +	} else if (ret > 0) {
>   		/*
> -		 * record the offset from the start of the extent
> -		 * for adjusting the disk offset below.  Only do this if the
> -		 * extent isn't compressed since our in ram offset may be past
> -		 * what we have actually allocated on disk.
> +		 * No file extent item found, but we may have delalloc between
> +		 * the current offset and i_size. So check for that.
>   		 */
> -		if (!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
> -			offset_in_extent =3D em_start - em->start;
> -		em_end =3D extent_map_end(em);
> -		em_len =3D em_end - em_start;
> -		flags =3D 0;
> -		if (em->block_start < EXTENT_MAP_LAST_BYTE)
> -			disko =3D em->block_start + offset_in_extent;
> -		else
> -			disko =3D 0;
> +		ret =3D 0;
> +		goto check_eof_delalloc;
> +	}
> +
> +	while (prev_extent_end < lockend) {
> +		struct extent_buffer *leaf =3D path->nodes[0];
> +		struct btrfs_file_extent_item *ei;
> +		struct btrfs_key key;
> +		u64 extent_end;
> +		u64 extent_len;
> +		u64 extent_offset =3D 0;
> +		u64 extent_gen;
> +		u64 disk_bytenr =3D 0;
> +		u64 flags =3D 0;
> +		int extent_type;
> +		u8 compression;
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +		if (key.objectid !=3D ino || key.type !=3D BTRFS_EXTENT_DATA_KEY)
> +			break;
> +
> +		extent_end =3D btrfs_file_extent_end(path);
>
>   		/*
> -		 * bump off for our next call to get_extent
> +		 * The first iteration can leave us at an extent item that ends
> +		 * before our range's start. Move to the next item.
>   		 */
> -		off =3D extent_map_end(em);
> -		if (off >=3D max)
> -			end =3D 1;
> -
> -		if (em->block_start =3D=3D EXTENT_MAP_INLINE) {
> -			flags |=3D (FIEMAP_EXTENT_DATA_INLINE |
> -				  FIEMAP_EXTENT_NOT_ALIGNED);
> -		} else if (em->block_start =3D=3D EXTENT_MAP_DELALLOC) {
> -			flags |=3D (FIEMAP_EXTENT_DELALLOC |
> -				  FIEMAP_EXTENT_UNKNOWN);
> -		} else if (fieinfo->fi_extents_max) {
> -			u64 extent_gen;
> -			u64 bytenr =3D em->block_start -
> -				(em->start - em->orig_start);
> +		if (extent_end <=3D lockstart)
> +			goto next_item;
>
> -			/*
> -			 * If two extent maps are merged, then their generation
> -			 * is set to the maximum between their generations.
> -			 * Otherwise its generation matches the one we have in
> -			 * corresponding file extent item. If we have a merged
> -			 * extent map, don't use its generation to speedup the
> -			 * sharedness check below.
> -			 */
> -			if (test_bit(EXTENT_FLAG_MERGED, &em->flags))
> -				extent_gen =3D 0;
> -			else
> -				extent_gen =3D em->generation;
> +		/* We have in implicit hole (NO_HOLES feature enabled). */
> +		if (prev_extent_end < key.offset) {
> +			const u64 range_end =3D min(key.offset, lockend) - 1;
>
> -			/*
> -			 * As btrfs supports shared space, this information
> -			 * can be exported to userspace tools via
> -			 * flag FIEMAP_EXTENT_SHARED.  If fi_extents_max =3D=3D 0
> -			 * then we're just getting a count and we can skip the
> -			 * lookup stuff.
> -			 */
> -			ret =3D btrfs_is_data_extent_shared(root, btrfs_ino(inode),
> -							  bytenr, extent_gen,
> -							  roots, tmp_ulist,
> -							  backref_cache);
> -			if (ret < 0)
> -				goto out_free;
> -			if (ret)
> -				flags |=3D FIEMAP_EXTENT_SHARED;
> -			ret =3D 0;
> -		}
> -		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
> -			flags |=3D FIEMAP_EXTENT_ENCODED;
> -		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -			flags |=3D FIEMAP_EXTENT_UNWRITTEN;
> +			ret =3D fiemap_process_hole(inode, fieinfo, &cache,
> +						  backref_cache, 0, 0, 0,
> +						  roots, tmp_ulist,
> +						  prev_extent_end, range_end);
> +			if (ret < 0) {
> +				goto out_unlock;
> +			} else if (ret > 0) {
> +				/* fiemap_fill_next_extent() told us to stop. */
> +				stopped =3D true;
> +				break;
> +			}
>
> -		free_extent_map(em);
> -		em =3D NULL;
> -		if ((em_start >=3D last) || em_len =3D=3D (u64)-1 ||
> -		   (last =3D=3D (u64)-1 && isize <=3D em_end)) {
> -			flags |=3D FIEMAP_EXTENT_LAST;
> -			end =3D 1;
> +			/* We've reached the end of the fiemap range, stop. */
> +			if (key.offset >=3D lockend) {
> +				stopped =3D true;
> +				break;
> +			}
>   		}
>
> -		/* now scan forward to see if this is really the last extent. */
> -		em =3D get_extent_skip_holes(inode, off, last_for_get_extent);
> -		if (IS_ERR(em)) {
> -			ret =3D PTR_ERR(em);
> -			goto out;
> +		extent_len =3D extent_end - key.offset;
> +		ei =3D btrfs_item_ptr(leaf, path->slots[0],
> +				    struct btrfs_file_extent_item);
> +		compression =3D btrfs_file_extent_compression(leaf, ei);
> +		extent_type =3D btrfs_file_extent_type(leaf, ei);
> +		extent_gen =3D btrfs_file_extent_generation(leaf, ei);
> +
> +		if (extent_type !=3D BTRFS_FILE_EXTENT_INLINE) {
> +			disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, ei);
> +			if (compression =3D=3D BTRFS_COMPRESS_NONE)
> +				extent_offset =3D btrfs_file_extent_offset(leaf, ei);
>   		}
> -		if (!em) {
> -			flags |=3D FIEMAP_EXTENT_LAST;
> -			end =3D 1;
> +
> +		if (compression !=3D BTRFS_COMPRESS_NONE)
> +			flags |=3D FIEMAP_EXTENT_ENCODED;
> +
> +		if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> +			flags |=3D FIEMAP_EXTENT_DATA_INLINE;
> +			flags |=3D FIEMAP_EXTENT_NOT_ALIGNED;
> +			ret =3D emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
> +						 extent_len, flags);
> +		} else if (extent_type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
> +			ret =3D fiemap_process_hole(inode, fieinfo, &cache,
> +						  backref_cache,
> +						  disk_bytenr, extent_offset,
> +						  extent_gen, roots, tmp_ulist,
> +						  key.offset, extent_end - 1);
> +		} else if (disk_bytenr =3D=3D 0) {
> +			/* We have an explicit hole. */
> +			ret =3D fiemap_process_hole(inode, fieinfo, &cache,
> +						  backref_cache, 0, 0, 0,
> +						  roots, tmp_ulist,
> +						  key.offset, extent_end - 1);
> +		} else {
> +			/* We have a regular extent. */
> +			if (fieinfo->fi_extents_max) {
> +				ret =3D btrfs_is_data_extent_shared(root, ino,
> +								  disk_bytenr,
> +								  extent_gen,
> +								  roots,
> +								  tmp_ulist,
> +								  backref_cache);
> +				if (ret < 0)
> +					goto out_unlock;
> +				else if (ret > 0)
> +					flags |=3D FIEMAP_EXTENT_SHARED;
> +			}
> +
> +			ret =3D emit_fiemap_extent(fieinfo, &cache, key.offset,
> +						 disk_bytenr + extent_offset,
> +						 extent_len, flags);
>   		}
> -		ret =3D emit_fiemap_extent(fieinfo, &cache, em_start, disko,
> -					   em_len, flags);
> -		if (ret) {
> -			if (ret =3D=3D 1)
> -				ret =3D 0;
> -			goto out_free;
> +
> +		if (ret < 0) {
> +			goto out_unlock;
> +		} else if (ret > 0) {
> +			/* fiemap_fill_next_extent() told us to stop. */
> +			stopped =3D true;
> +			break;
>   		}
>
> +		prev_extent_end =3D extent_end;
> +next_item:
>   		if (fatal_signal_pending(current)) {
>   			ret =3D -EINTR;
> -			goto out_free;
> +			goto out_unlock;
>   		}
> +
> +		ret =3D fiemap_next_leaf_item(inode, path);
> +		if (ret < 0) {
> +			goto out_unlock;
> +		} else if (ret > 0) {
> +			/* No more file extent items for this inode. */
> +			break;
> +		}
> +		cond_resched();
>   	}
> -out_free:
> -	if (!ret)
> -		ret =3D emit_last_fiemap_cache(fieinfo, &cache);
> -	free_extent_map(em);
> -out:
> -	unlock_extent_cached(&inode->io_tree, start, start + len - 1,
> -			     &cached_state);
>
> -out_free_ulist:
> +check_eof_delalloc:
> +	/*
> +	 * Release (and free) the path before emitting any final entries to
> +	 * fiemap_fill_next_extent() to keep lockdep happy. This is because
> +	 * once we find no more file extent items exist, we may have a
> +	 * non-cloned leaf, and fiemap_fill_next_extent() can trigger page
> +	 * faults when copying data to the user space buffer.
> +	 */
> +	btrfs_free_path(path);
> +	path =3D NULL;
> +
> +	if (!stopped && prev_extent_end < lockend) {
> +		ret =3D fiemap_process_hole(inode, fieinfo, &cache, backref_cache,
> +					  0, 0, 0, roots, tmp_ulist,
> +					  prev_extent_end, lockend - 1);
> +		if (ret < 0)
> +			goto out_unlock;
> +		prev_extent_end =3D lockend;
> +	}
> +
> +	if (cache.cached && cache.offset + cache.len >=3D last_extent_end) {
> +		const u64 i_size =3D i_size_read(&inode->vfs_inode);
> +
> +		if (prev_extent_end < i_size) {
> +			u64 delalloc_start;
> +			u64 delalloc_end;
> +			bool delalloc;
> +
> +			delalloc =3D btrfs_find_delalloc_in_range(inode,
> +								prev_extent_end,
> +								i_size - 1,
> +								&delalloc_start,
> +								&delalloc_end);
> +			if (!delalloc)
> +				cache.flags |=3D FIEMAP_EXTENT_LAST;
> +		} else {
> +			cache.flags |=3D FIEMAP_EXTENT_LAST;
> +		}
> +	}
> +
> +	ret =3D emit_last_fiemap_cache(fieinfo, &cache);
> +
> +out_unlock:
> +	unlock_extent_cached(&inode->io_tree, lockstart, lockend, &cached_stat=
e);
> +out:
>   	kfree(backref_cache);
>   	btrfs_free_path(path);
>   	ulist_free(roots);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index b292a8ada3a4..636b3ec46184 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3602,10 +3602,10 @@ static long btrfs_fallocate(struct file *file, i=
nt mode,
>   }
>
>   /*
> - * Helper for have_delalloc_in_range(). Find a subrange in a given rang=
e that
> - * has unflushed and/or flushing delalloc. There might be other adjacen=
t
> - * subranges after the one it found, so have_delalloc_in_range() keeps =
looping
> - * while it gets adjacent subranges, and merging them together.
> + * Helper for btrfs_find_delalloc_in_range(). Find a subrange in a give=
n range
> + * that has unflushed and/or flushing delalloc. There might be other ad=
jacent
> + * subranges after the one it found, so btrfs_find_delalloc_in_range() =
keeps
> + * looping while it gets adjacent subranges, and merging them together.
>    */
>   static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 star=
t, u64 end,
>   				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> @@ -3740,8 +3740,8 @@ static bool find_delalloc_subrange(struct btrfs_in=
ode *inode, u64 start, u64 end
>    * if so it sets @delalloc_start_ret and @delalloc_end_ret with the st=
art and
>    * end offsets of the subrange.
>    */
> -static bool have_delalloc_in_range(struct btrfs_inode *inode, u64 start=
, u64 end,
> -				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> +bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start,=
 u64 end,
> +				  u64 *delalloc_start_ret, u64 *delalloc_end_ret)
>   {
>   	u64 cur_offset =3D round_down(start, inode->root->fs_info->sectorsize=
);
>   	u64 prev_delalloc_end =3D 0;
> @@ -3804,8 +3804,8 @@ static bool find_desired_extent_in_hole(struct btr=
fs_inode *inode, int whence,
>   	u64 delalloc_end;
>   	bool delalloc;
>
> -	delalloc =3D have_delalloc_in_range(inode, start, end, &delalloc_start=
,
> -					  &delalloc_end);
> +	delalloc =3D btrfs_find_delalloc_in_range(inode, start, end,
> +						&delalloc_start, &delalloc_end);
>   	if (delalloc && whence =3D=3D SEEK_DATA) {
>   		*start_ret =3D delalloc_start;
>   		return true;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2c7d31990777..8be1e021513a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7064,133 +7064,6 @@ struct extent_map *btrfs_get_extent(struct btrfs=
_inode *inode,
>   	return em;
>   }
>
> -struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> -					   u64 start, u64 len)
> -{
> -	struct extent_map *em;
> -	struct extent_map *hole_em =3D NULL;
> -	u64 delalloc_start =3D start;
> -	u64 end;
> -	u64 delalloc_len;
> -	u64 delalloc_end;
> -	int err =3D 0;
> -
> -	em =3D btrfs_get_extent(inode, NULL, 0, start, len);
> -	if (IS_ERR(em))
> -		return em;
> -	/*
> -	 * If our em maps to:
> -	 * - a hole or
> -	 * - a pre-alloc extent,
> -	 * there might actually be delalloc bytes behind it.
> -	 */
> -	if (em->block_start !=3D EXTENT_MAP_HOLE &&
> -	    !test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -		return em;
> -	else
> -		hole_em =3D em;
> -
> -	/* check to see if we've wrapped (len =3D=3D -1 or similar) */
> -	end =3D start + len;
> -	if (end < start)
> -		end =3D (u64)-1;
> -	else
> -		end -=3D 1;
> -
> -	em =3D NULL;
> -
> -	/* ok, we didn't find anything, lets look for delalloc */
> -	delalloc_len =3D count_range_bits(&inode->io_tree, &delalloc_start,
> -				 end, len, EXTENT_DELALLOC, 1);
> -	delalloc_end =3D delalloc_start + delalloc_len;
> -	if (delalloc_end < delalloc_start)
> -		delalloc_end =3D (u64)-1;
> -
> -	/*
> -	 * We didn't find anything useful, return the original results from
> -	 * get_extent()
> -	 */
> -	if (delalloc_start > end || delalloc_end <=3D start) {
> -		em =3D hole_em;
> -		hole_em =3D NULL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Adjust the delalloc_start to make sure it doesn't go backwards from
> -	 * the start they passed in
> -	 */
> -	delalloc_start =3D max(start, delalloc_start);
> -	delalloc_len =3D delalloc_end - delalloc_start;
> -
> -	if (delalloc_len > 0) {
> -		u64 hole_start;
> -		u64 hole_len;
> -		const u64 hole_end =3D extent_map_end(hole_em);
> -
> -		em =3D alloc_extent_map();
> -		if (!em) {
> -			err =3D -ENOMEM;
> -			goto out;
> -		}
> -
> -		ASSERT(hole_em);
> -		/*
> -		 * When btrfs_get_extent can't find anything it returns one
> -		 * huge hole
> -		 *
> -		 * Make sure what it found really fits our range, and adjust to
> -		 * make sure it is based on the start from the caller
> -		 */
> -		if (hole_end <=3D start || hole_em->start > end) {
> -		       free_extent_map(hole_em);
> -		       hole_em =3D NULL;
> -		} else {
> -		       hole_start =3D max(hole_em->start, start);
> -		       hole_len =3D hole_end - hole_start;
> -		}
> -
> -		if (hole_em && delalloc_start > hole_start) {
> -			/*
> -			 * Our hole starts before our delalloc, so we have to
> -			 * return just the parts of the hole that go until the
> -			 * delalloc starts
> -			 */
> -			em->len =3D min(hole_len, delalloc_start - hole_start);
> -			em->start =3D hole_start;
> -			em->orig_start =3D hole_start;
> -			/*
> -			 * Don't adjust block start at all, it is fixed at
> -			 * EXTENT_MAP_HOLE
> -			 */
> -			em->block_start =3D hole_em->block_start;
> -			em->block_len =3D hole_len;
> -			if (test_bit(EXTENT_FLAG_PREALLOC, &hole_em->flags))
> -				set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
> -		} else {
> -			/*
> -			 * Hole is out of passed range or it starts after
> -			 * delalloc range
> -			 */
> -			em->start =3D delalloc_start;
> -			em->len =3D delalloc_len;
> -			em->orig_start =3D delalloc_start;
> -			em->block_start =3D EXTENT_MAP_DELALLOC;
> -			em->block_len =3D delalloc_len;
> -		}
> -	} else {
> -		return hole_em;
> -	}
> -out:
> -
> -	free_extent_map(hole_em);
> -	if (err) {
> -		free_extent_map(em);
> -		return ERR_PTR(err);
> -	}
> -	return em;
> -}
> -
>   static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *=
inode,
>   						  const u64 start,
>   						  const u64 len,
> @@ -8265,15 +8138,14 @@ static int btrfs_fiemap(struct inode *inode, str=
uct fiemap_extent_info *fieinfo,
>   	 * in the compression of data (in an async thread) and will return
>   	 * before the compression is done and writeback is started. A second
>   	 * filemap_fdatawrite_range() is needed to wait for the compression t=
o
> -	 * complete and writeback to start. Without this, our user is very
> -	 * likely to get stale results, because the extents and extent maps fo=
r
> -	 * delalloc regions are only allocated when writeback starts.
> +	 * complete and writeback to start. We also need to wait for ordered
> +	 * extents to complete, because our fiemap implementation uses mainly
> +	 * file extent items to list the extents, searching for extent maps
> +	 * only for file ranges with holes or prealloc extents to figure out
> +	 * if we have delalloc in those ranges.
>   	 */
>   	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
> -		ret =3D btrfs_fdatawrite_range(inode, 0, LLONG_MAX);
> -		if (ret)
> -			return ret;
> -		ret =3D filemap_fdatawait_range(inode->i_mapping, 0, LLONG_MAX);
> +		ret =3D btrfs_wait_ordered_range(inode, 0, LLONG_MAX);
>   		if (ret)
>   			return ret;
>   	}
