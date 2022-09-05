Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54F5AD553
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 16:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiIEOmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiIEOmY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 10:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189D5EDF1
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 07:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EABB7B811E1
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 14:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F854C433D6
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662388797;
        bh=p/wLdnq4V6v+rNvihpXYARFnx1RqyOaodpsxDqUFF6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KXK1OzQZs0lq4yRlZQVRVrTyVbSDepwCuHqGEpF3HGqaxqU/Dl7ZK67vLYfGPbjdj
         NQX+tQ945iYldvPE69X6dhRMKEnRaFPZ483o3cz4s9LpP8j8QaH4xkbwiOwdc87+h1
         v9lzdrtXa2K8WrDdZ7NGddN8oUFzcTn3Y11SKiraSwIfBJDVpFXYWEgUX941h4sQK0
         Vlw2Y1iWjjG3HRVHYyOYpXp5lkVmLdpEVcGcLpZ8PJkqhI0zTlOVJrp4rBlK8Nma9c
         qmw4xykZDhxfd3ynPt6iuvde+HUTUYWIHKXz2CzwPaZQjo034Gqpe11hDjcQXMXYai
         lySF568b8UKcQ==
Received: by mail-ot1-f52.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so6253606otd.12
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Sep 2022 07:39:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo3q3MAregH2ttp6MOlHI1OUXS5an/wtSpfTEn0mjXbI0m/JeKQ/
        e5Vv+XwWB8lxFtCYqUUZbg9Tr1vmY5Gc3cndggw=
X-Google-Smtp-Source: AA6agR6XrjtYJACKkeow44OVfPcJEvBxjmuOT+bMMbhrs18UdM91mIeGsGex5K2UfYFJg5SgW7rm6ikLAQ5G0EIWQPE=
X-Received: by 2002:a05:6830:120f:b0:639:1a06:d09d with SMTP id
 r15-20020a056830120f00b006391a06d09dmr19083502otp.345.1662388796453; Mon, 05
 Sep 2022 07:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662022922.git.fdmanana@suse.com> <20220902085320.642A.409509F4@e16-tech.com>
 <CAL3q7H79BWAJVk2ecWqa4mbW0+WFJrEX-=a+Zg9FOc_UcAKjLg@mail.gmail.com> <CAL3q7H4+udOfLT+U=eiGUNw0kL9mv7iZ4Fmm+MFQ8416zDPeig@mail.gmail.com>
In-Reply-To: <CAL3q7H4+udOfLT+U=eiGUNw0kL9mv7iZ4Fmm+MFQ8416zDPeig@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 5 Sep 2022 15:39:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com>
Message-ID: <CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 2, 2022 at 12:45 PM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Fri, Sep 2, 2022 at 9:24 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Fri, Sep 2, 2022 at 2:09 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi,
> > >
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > We often get reports of fiemap and hole/data seeking (lseek) being too slow
> > > > on btrfs, or even unusable in some cases due to being extremely slow.
> > > >
> > > > Some recent reports for fiemap:
> > > >
> > > >     https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> > > >     https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> > > >
> > > > For lseek (LSF/MM from 2017):
> > > >
> > > >    https://lwn.net/Articles/718805/
> > > >
> > > > Basically both are slow due to very high algorithmic complexity which
> > > > scales badly with the number of extents in a file and the heigth of
> > > > subvolume and extent b+trees.
> > > >
> > > > Using Pavel's test case (first Link tag for fiemap), which uses files with
> > > > many 4K extents and holes before and after each extent (kind of a worst
> > > > case scenario), the speedup is of several orders of magnitude (for the 1G
> > > > file, from ~225 seconds down to ~0.1 seconds).
> > > >
> > > > Finally the new algorithm for fiemap also ends up solving a bug with the
> > > > current algorithm. This happens because we are currently relying on extent
> > > > maps to report extents, which can be merged, and this may cause us to
> > > > report 2 different extents as a single one that is not shared but one of
> > > > them is shared (or the other way around). More details on this on patches
> > > > 9/10 and 10/10.
> > > >
> > > > Patches 1/10 and 2/10 are for lseek, introducing some code that will later
> > > > be used by fiemap too (patch 10/10). More details in the changelogs.
> > > >
> > > > There are a few more things that can be done to speedup fiemap and lseek,
> > > > but I'll leave those other optimizations I have in mind for some other time.
> > > >
> > > > Filipe Manana (10):
> > > >   btrfs: allow hole and data seeking to be interruptible
> > > >   btrfs: make hole and data seeking a lot more efficient
> > > >   btrfs: remove check for impossible block start for an extent map at fiemap
> > > >   btrfs: remove zero length check when entering fiemap
> > > >   btrfs: properly flush delalloc when entering fiemap
> > > >   btrfs: allow fiemap to be interruptible
> > > >   btrfs: rename btrfs_check_shared() to a more descriptive name
> > > >   btrfs: speedup checking for extent sharedness during fiemap
> > > >   btrfs: skip unnecessary extent buffer sharedness checks during fiemap
> > > >   btrfs: make fiemap more efficient and accurate reporting extent sharedness
> > > >
> > > >  fs/btrfs/backref.c     | 153 ++++++++-
> > > >  fs/btrfs/backref.h     |  20 +-
> > > >  fs/btrfs/ctree.h       |  22 +-
> > > >  fs/btrfs/extent-tree.c |  10 +-
> > > >  fs/btrfs/extent_io.c   | 703 ++++++++++++++++++++++++++++-------------
> > > >  fs/btrfs/file.c        | 439 +++++++++++++++++++++++--
> > > >  fs/btrfs/inode.c       | 146 ++-------
> > > >  7 files changed, 1111 insertions(+), 382 deletions(-)
> > >
> > >
> > > An infinite loop happen when the 10 pathes applied to 6.0-rc3.
> >
> > Nop, it's not an infinite loop, and it happens as well before the patchset.
> > The reason is that the files created by the test are very sparse and
> > with small extents.
> > It's full of 4K extents surrounded by 8K holes.
> >
> > So any one doing hole seeking, advances 8K on every lseek call.
> > If you strace the cp process, with
> >
> > strace -p <cp pid>
> >
> > You'll see something like this filling your terminal:
> >
> > (...)
> > lseek(3, 18808832, SEEK_SET)            = 18808832
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > lseek(3, 18817024, SEEK_SET)            = 18817024
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > lseek(3, 18825216, SEEK_SET)            = 18825216
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > lseek(3, 18833408, SEEK_SET)            = 18833408
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > lseek(3, 18841600, SEEK_SET)            = 18841600
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > lseek(3, 18849792, SEEK_SET)            = 18849792
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> > 4096) = 4096
> > lseek(3, 18857984, SEEK_SET)            = 18857984
> > (...)
> >
> > It takes a long time, but it finishes. If you notice the difference
> > between each return
> > value is exactly 8K.
> >
> > That happens both before and after the patchset.
>
> Btw, on a release (non-debug) kernel this is what I get before and
> after the patchset.
>
> Before patchset:
>
> root 12:05:51 /home/fdmanana/scripts/other_perf/fiemap > umount
> /dev/sdi ; mkfs.btrfs -f /dev/sdi ; mount /dev/sdi /mnt/sdi
> root 12:06:47 /home/fdmanana/scripts/other_perf/fiemap > ./pavels-test
> /mnt/sdi/foobar $((1 << 30)) && time cp /mnt/sdi/foobar /dev/null
> size: 1073741824
> actual size: 536870912
> fiemap: fm_mapped_extents = 131072
> time = 256243106 us
>
> real 5m50.026s
> user 0m0.232s
> sys 5m48.698s
>
>
> After patchset:
>
> root 12:32:44 /home/fdmanana/scripts/other_perf/fiemap > umount
> /dev/sdi ; mkfs.btrfs -f /dev/sdi ; mount /dev/sdi /mnt/sdi
> root 12:33:01 /home/fdmanana/scripts/other_perf/fiemap > ./pavels-test
> /mnt/sdi/foobar $((1 << 30)) && time cp /mnt/sdi/foobar /dev/null
> size: 1073741824
> actual size: 536870912
> fiemap: fm_mapped_extents = 129941
> time = 134062 us
>
> real 0m57.606s
> user 0m0.185s
> sys 0m57.375s
>
>
> Not as fast as ext4 yet, which takes ~1.5 seconds, but it's getting much better.
> What's causing cp to be slow are the multiple ranged fiemap calls it does.
> cp also does a lot of lseek calls to detect and skip holes, but the
> total time spent on it is almost insignificant when compared to
> fiemap.

For the cp case, part of the slowness could be mitigated by having cp
calling fiemap with a larger buffer,
as its buffer is always for 72 extents only:

(....)
ioctl(3, FS_IOC_FIEMAP, {fm_start=1055780864,
fm_length=18446744072653770751, fm_flags=FIEMAP_FLAG_SYNC,
fm_extent_count=72} => {fm_flags=FIEMAP_FLAG_SYNC,
fm_mapped_extents=72, ...}) = 0 <0.013190>
ioctl(3, FS_IOC_FIEMAP, {fm_start=1056370688,
fm_length=18446744072653180927, fm_flags=FIEMAP_FLAG_SYNC,
fm_extent_count=72} => {fm_flags=FIEMAP_FLAG_SYNC,
fm_mapped_extents=72, ...}) = 0 <0.012889>
ioctl(3, FS_IOC_FIEMAP, {fm_start=1056960512,
fm_length=18446744072652591103, fm_flags=FIEMAP_FLAG_SYNC,
fm_extent_count=72} => {fm_flags=FIEMAP_FLAG_SYNC,
fm_mapped_extents=72, ...}) = 0 <0.012541>
(....)

The filefrag utility uses a buffer for 292 extents for example.

But that doesn't matter much anymore, because last year the cp code
that uses fiemap was removed:

https://github.com/coreutils/coreutils/commit/26eccf6c98696c50f4416ba2967edc8676870716

So now it uses lseek's SEEK_HOLE to detect holes.

The lseek calls from the traces pasted before corresponded to lseek
SEEK_SET, used to set
the current offset on the source file to the offset of each extent
returned by fiemap, therefore skipping holes.

That's a lot more efficient than using fiemap to detect and skip holes.

>
> I'll work on making fiemap more efficient, but that will come in some
> other separate patch or patches that will build upon this patchset.
> I like to make things more incremental and avoid having too many
> changes in a single kernel release for fiemap.
>
> >
> > Thanks.
> >
> >
> > >
> > > a file is created by 'pavels-test.c' of [PATCH 10/10].
> > > and then '/bin/cp /mnt/test/file1 /dev/null' will trigger an infinite
> > > loop.
> > >
> > > 'sysrq -l' output:
> > >
> > > [ 1437.765228] Call Trace:
> > > [ 1437.765228]  <TASK>
> > > [ 1437.765228]  set_extent_bit+0x33d/0x6e0 [btrfs]
> > > [ 1437.765228]  lock_extent_bits+0x64/0xa0 [btrfs]
> > > [ 1437.765228]  btrfs_file_llseek+0x192/0x5b0 [btrfs]
> > > [ 1437.765228]  ksys_lseek+0x64/0xb0
> > > [ 1437.765228]  do_syscall_64+0x58/0x80
> > > [ 1437.765228]  ? syscall_exit_to_user_mode+0x12/0x30
> > > [ 1437.765228]  ? do_syscall_64+0x67/0x80
> > > [ 1437.765228]  ? do_syscall_64+0x67/0x80
> > > [ 1437.765228]  ? exc_page_fault+0x64/0x140
> > > [ 1437.765228]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > [ 1437.765228] RIP: 0033:0x7f5a263441bb
> > >
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2022/09/02
> > >
> > >
