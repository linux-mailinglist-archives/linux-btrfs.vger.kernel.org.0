Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0A403488
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbhIHGvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 02:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbhIHGv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 02:51:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246DC061575
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 23:50:19 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a22so1791199iok.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 23:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qGHKj+4L0a8xj6sSlJHz2SEC2e1W2YAKA5sQ1BQRlJQ=;
        b=d/a8h5o6Ns3pHIFe7yb4/UUNj0P2OH8R6Oo1DSwJvfaNY70vrhuEBtQbuXWLEMU4rW
         N0+/FRIa3kAzYzs/qt/6ERy2b34nZknAPuAyNEh4SfzIKxXyQRAl8N2tYVic33S70Zv1
         W9mdDigub8FEAyuW6FyTkS1Jq6mHiOfcYYoAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qGHKj+4L0a8xj6sSlJHz2SEC2e1W2YAKA5sQ1BQRlJQ=;
        b=B91fXMqoN4ncG6jibDHDb0eo+rWT5vJ3gf9UJ8aZLrDs7lfm8kPnw2gC1L86uVBXBN
         CRI8iwT13/Tp8c6UGiEPkvtJaDPFC1rBDoqeO7e36ddnFqJQ+6WbJXC881HmrUr/aWXT
         6Tax0TGPhleM1ng7ccBYLzFbtceioV0CXAlKna71K9o1/TbWAw15LPuFxvM0Pc2fXARV
         wOjdrOX5yyIBH+OAwAEL7SvZUEjQl9kVt4ZS7FeulwgpCtpEf2FE4++IWfRXsKyYvt/B
         VeSOjNMC/JM6+Fth7R+wxea+2H9bB1E7E186FrXQnobpUc2N/e6FENXO3ZDY4mV8WtxE
         Mp8w==
X-Gm-Message-State: AOAM531MhUFzDWu7wvLAj1go4IeKwRCJDBsWBpGz0KaS60DPz3HuCA3c
        YFiExgndBcjlY4q+cz619yotPEBiBR8mWw==
X-Google-Smtp-Source: ABdhPJxLLJUdNadFMBGkHzLtpP9j1AOXe3r/WvTNWmzSnETk2h+Vfrmua6CepJhDBzLrg6Fd5ZU7AA==
X-Received: by 2002:a05:6602:20ce:: with SMTP id 14mr1957911ioz.204.1631083818048;
        Tue, 07 Sep 2021 23:50:18 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id l25sm666785iob.41.2021.09.07.23.50.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 23:50:17 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id g9so1789651ioq.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 23:50:17 -0700 (PDT)
X-Received: by 2002:a05:6638:399:: with SMTP id y25mr2259562jap.23.1631083817202;
 Tue, 07 Sep 2021 23:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com> <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com> <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com> <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
 <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com> <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
 <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com> <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
 <ddb57c10-3581-0089-d84a-4935644bef5a@gmx.com> <lf47byws.fsf@damenly.su>
In-Reply-To: <lf47byws.fsf@damenly.su>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Wed, 8 Sep 2021 00:50:06 -0600
X-Gmail-Original-Message-ID: <CAA_aC9-w3hFhtvnqJ3ORDYKA6j4EXqjKOnRST6EGf2r5tXYv+g@mail.gmail.com>
Message-ID: <CAA_aC9-w3hFhtvnqJ3ORDYKA6j4EXqjKOnRST6EGf2r5tXYv+g@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     Su Yue <l@damenly.su>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I ran memtester for 2 complete passes.  No failures.  I only tested
51G of my 64G, though. :/  That's how much was "free".

On Tue, Sep 7, 2021 at 8:10 PM Su Yue <l@damenly.su> wrote:
>
>
> On Wed 08 Sep 2021 at 07:15, Qu Wenruo <quwenruo.btrfs@gmx.com>
> wrote:
>
> > On 2021/9/8 =E4=B8=8A=E5=8D=881:02, Robert Wyrick wrote:
> >> Ran a repair:
> >>
> >> $ sudo ./btrfs check --repair -p /dev/sda  # I did NOT make
> >> install,
> >> just ran from the compiled directory
> >> enabling repair mode
> >> WARNING:
> >>
> >> Do not use --repair unless you are advised to do so by a
> >> developer
> >> or an experienced user, and then only after having accepted
> >> that no
> >> fsck can successfully repair all types of filesystem
> >> corruption. Eg.
> >> some software or hardware bugs can fatally damage a volume.
> >> The operation will start in 10 seconds.
> >> Use Ctrl-C to stop it.
> >> 10 9 8 7 6 5 4 3 2 1
> >> Starting repair.
> >> Opening filesystem to check...
> >> Checking filesystem on /dev/sda
> >> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> >> [1/7] checking root items                      (0:00:59
> >> elapsed,
> >> 2649102 items checked)
> >> Fixed 0 roots.
> >> Reset extent item (38179182174208) generation to
> >> 4057084elapsed,
> >> 1116143 items checked)
> >> No device size related problem found           (0:02:22
> >> elapsed,
> >> 1116143 items checked)
> >> [2/7] checking extents                         (0:02:23
> >> elapsed,
> >> 1116143 items checked)
> >> cache and super generation don't match, space cache will be
> >> invalidated
> >> [3/7] checking free space cache                (0:00:00
> >> elapsed)
> >> Deleting bad dir index [8348950,96,3] root 259 (0:00:25
> >> elapsed,
> >> 106695 items checked)
> >> repairing missing dir index item for inode 834922400:26
> >> elapsed,
> >> 108893 items checked)
> >> [4/7] checking fs roots                        (0:01:04
> >> elapsed,
> >> 217787 items checked)
> >> [5/7] checking csums (without verifying data)  (0:00:04
> >> elapsed,
> >> 12350321 items checked)
> >> [6/7] checking root refs                       (0:00:00
> >> elapsed, 4
> >> items checked)
> >> [7/7] checking quota groups skipped (not enabled on this FS)
> >> found 15729059057664 bytes used, no error found
> >> total csum bytes: 15313288548
> >> total tree bytes: 18286739456
> >> total fs tree bytes: 1791819776
> >> total extent tree bytes: 229130240
> >> btree space waste bytes: 1018844959
> >> file data blocks allocated: 51587230502912
> >>   referenced 15627926712320
> >>
> >> I can now mount the filesystem successfully!  Thank you for
> >> your help.
> >>
> >> I do have some additional questions if you don't mind...
> >> I am already using RAID 1 to handle single disk outages.
> >
> > One thing to note is, RAID is not perfect, not even close to
> > proper backup.
> >
> > RAID is really only suitable to handle disk failures, nothing
> > more than
> > that.
> >
> > In a spectrum of backup, RAID is really just better than
> > nothing.
> >
> > In this particular case, all the corruption is from bitflips,
> > thus all
> > copies are corrupted, no profile can save the day.
> >
> >>  I assume
> >> things could have gone much worse and I could have lost the
> >> whole
> >> filesystem.
> >
> > If you're using newer kernels all time, the kernel can detect
> > the extent
> > generation problem before writing the corrupted data back to
> > disk, thus
> > save the day.
> >
> >>  Aside from backups (I know, I know), is there anything
> >> else I can do to prevent such issues or make them easier to
> >> recover
> >> from?
> >
> > Newer kernel (v5.11 and newer) can prevent it.
> > Although when such rejection happens, it will not feel that
> > comfort
> > though, as it would mostly result the fs to go RO.
> > But still way better than writing bad data onto disks.
> >
> >>  Could this problem have been avoided/detected earlier?
> >
> > Yes, newer kernel.
> >
> >>  This
> >> wasn't a disk failure and according to memtest86+, it wasn't
> >> due to
> >> bad memory either....
> >
> > I still don't believe, maybe you can try to run memtester (which
> > is ran
> > in user space, and since we have kernel doing the page mapping,
> > it may
> > expose a different workload on the memory controller than
> > memtest86+)
> >
> And testmem5 using config anta777 may help. It's widely used to
> test
> memory stability after overclocking but runs on evil Windows
> though.
> It won't take too much time. Two cicles test of 64G memory
> consumes
> about 4~6 hours.
>
> --
> Su
>
> Subject
> > Since the extent generation corruption is a super obvious
> > bitflip.
> >
> >>  I don't run scrubs very often.  Should I?
> >
> > For newer kernels, the corruption can be rejected in first
> > place, thus
> > the scrub is only going to detect problems already in the fs.
> >
> > For older kernels, scrub won't detect the problem anyw.
> >
> > So I guess you don't need that frequent scrub, but it's still
> > recommended.
> > Maybe monthly?
> >
> >>  I
> >> guess the more general question is:  What are the best
> >> practices for
> >> maintaining a healthy btrfs file system?
> >
> > Well, healthy hardware, balanced kernel version between cutting
> > edge and
> > stable.
> > Personally I'm more towards cutting edge thought.
> >
> > Thanks,
> > Qu
> >
> >>
> >> Thanks again!
> >>
> >> On Mon, Sep 6, 2021 at 10:53 PM Qu Wenruo
> >> <quwenruo.btrfs@gmx.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2021/9/7 =E4=B8=8B=E5=8D=8812:36, Robert Wyrick wrote:
> >>>> What exactly would i be disabling?  I don't know what zoned
> >>>> does.
> >>>
> >>> The zoned device support.
> >>>
> >>> If you don't have any host-managed zoned device, there is no
> >>> reason you
> >>> would like to enable it.
> >>>
> >>> https://zonedstorage.io/introduction/
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>
> >>>> On Mon, Sep 6, 2021, 9:07 PM Anand Jain
> >>>> <anand.jain@oracle.com> wrote:
> >>>>>
> >>>>> On 07/09/2021 10:36, Robert Wyrick wrote:
> >>>>>> Trying to build latest btrfs-progs.  I'm seeing errors in
> >>>>>> the configure script.
> >>>>>>
> >>>>>> $ cat /etc/os-release
> >>>>>> NAME=3D"Linux Mint"
> >>>>>> VERSION=3D"20.2 (Uma)"
> >>>>>> ID=3Dlinuxmint
> >>>>>> ID_LIKE=3Dubuntu
> >>>>>> PRETTY_NAME=3D"Linux Mint 20.2"
> >>>>>> VERSION_ID=3D"20.2"
> >>>>>> HOME_URL=3D"https://www.linuxmint.com/"
> >>>>>> SUPPORT_URL=3D"https://forums.linuxmint.com/"
> >>>>>> BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthedo=
cs.io/en/latest/"
> >>>>>> PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
> >>>>>> VERSION_CODENAME=3Duma
> >>>>>> UBUNTU_CODENAME=3Dfocal
> >>>>>>
> >>>>>> $ uname -a
> >>>>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed
> >>>>>> Aug 11
> >>>>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>>>>
> >>>>>> $ ./configure
> >>>>>> checking for gcc... gcc
> >>>>>> checking whether the C compiler works... yes
> >>>>>> checking for C compiler default output file name... a.out
> >>>>>> checking for suffix of executables...
> >>>>>> checking whether we are cross compiling... no
> >>>>>> checking for suffix of object files... o
> >>>>>> checking whether we are using the GNU C compiler... yes
> >>>>>> checking whether gcc accepts -g... yes
> >>>>>> checking for gcc option to accept ISO C89... none needed
> >>>>>> checking how to run the C preprocessor... gcc -E
> >>>>>> checking for grep that handles long lines and -e...
> >>>>>> /bin/grep
> >>>>>> checking for egrep... /bin/grep -E
> >>>>>> checking for ANSI C header files... yes
> >>>>>> checking for sys/types.h... yes
> >>>>>> checking for sys/stat.h... yes
> >>>>>> checking for stdlib.h... yes
> >>>>>> checking for string.h... yes
> >>>>>> checking for memory.h... yes
> >>>>>> checking for strings.h... yes
> >>>>>> checking for inttypes.h... yes
> >>>>>> checking for stdint.h... yes
> >>>>>> checking for unistd.h... yes
> >>>>>> checking minix/config.h usability... no
> >>>>>> checking minix/config.h presence... no
> >>>>>> checking for minix/config.h... no
> >>>>>> checking whether it is safe to define __EXTENSIONS__... yes
> >>>>>> checking for gcc... (cached) gcc
> >>>>>> checking whether we are using the GNU C compiler...
> >>>>>> (cached) yes
> >>>>>> checking whether gcc accepts -g... (cached) yes
> >>>>>> checking for gcc option to accept ISO C89... (cached) none
> >>>>>> needed
> >>>>>> checking whether C compiler accepts -std=3Dgnu90... yes
> >>>>>> checking build system type... x86_64-pc-linux-gnu
> >>>>>> checking host system type... x86_64-pc-linux-gnu
> >>>>>> checking for an ANSI C-conforming const... yes
> >>>>>> checking for working volatile... yes
> >>>>>> checking whether byte ordering is bigendian... no
> >>>>>> checking for special C compiler options needed for large
> >>>>>> files... no
> >>>>>> checking for _FILE_OFFSET_BITS value needed for large
> >>>>>> files... no
> >>>>>> checking for a BSD-compatible install... /usr/bin/install
> >>>>>> -c
> >>>>>> checking whether ln -s works... yes
> >>>>>> checking for ar... ar
> >>>>>> checking for rm... /bin/rm
> >>>>>> checking for rmdir... /bin/rmdir
> >>>>>> checking for openat... yes
> >>>>>> checking for reallocarray... yes
> >>>>>> checking for clock_gettime... yes
> >>>>>> checking linux/perf_event.h usability... yes
> >>>>>> checking linux/perf_event.h presence... yes
> >>>>>> checking for linux/perf_event.h... yes
> >>>>>> checking linux/hw_breakpoint.h usability... yes
> >>>>>> checking linux/hw_breakpoint.h presence... yes
> >>>>>> checking for linux/hw_breakpoint.h... yes
> >>>>>> checking for pkg-config... /usr/bin/pkg-config
> >>>>>> checking pkg-config is at least version 0.9.0... yes
> >>>>>> checking execinfo.h usability... yes
> >>>>>> checking execinfo.h presence... yes
> >>>>>> checking for execinfo.h... yes
> >>>>>> checking for backtrace... yes
> >>>>>> checking for backtrace_symbols_fd... yes
> >>>>>> checking for xmlto... /usr/bin/xmlto
> >>>>>> checking for mv... /bin/mv
> >>>>>> checking for a sed that does not truncate output...
> >>>>>> /bin/sed
> >>>>>> checking for asciidoc... /usr/bin/asciidoc
> >>>>>> checking for asciidoctor... no
> >>>>>> checking for EXT2FS... yes
> >>>>>> checking for COM_ERR... yes
> >>>>>> checking for REISERFS... yes
> >>>>>> checking for FIEMAP_EXTENT_SHARED defined in
> >>>>>> linux/fiemap.h... yes
> >>>>>> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h...
> >>>>>> yes
> >>>>>> checking linux/blkzoned.h usability... yes
> >>>>>> checking linux/blkzoned.h presence... yes
> >>>>>> checking for linux/blkzoned.h... yes
> >>>>>> checking for struct blk_zone.capacity... no
> >>>>>> checking for BLKGETZONESZ defined in linux/blkzoned.h...
> >>>>>> yes
> >>>>>
> >>>>>> configure: error: linux/blkzoned.h does not provide
> >>>>>> blk_zone.capacity
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> ---
> >>>>>>
> >>>>>> Info on the file in question (linux/blkzoned.h):
> >>>>>>
> >>>>>> $ dpkg -S /usr/include/linux/blkzoned.h
> >>>>>> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
> >>>>>>
> >>>>>> $ dpkg -l linux-libc-dev
> >>>>>> Desired=3DUnknown/Install/Remove/Purge/Hold
> >>>>>> |
> >>>>>> Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWa=
it/Trig-pend
> >>>>>> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
> >>>>>> ||/ Name                 Version      Architecture
> >>>>>> Description
> >>>>>> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux
> >>>>>> Kernel
> >>>>>> Headers for development
> >>>>>>
> >>>>>>
> >>>>>> So it appears that linux-libc-dev is way out-dated compared
> >>>>>> to my
> >>>>>> kernel.  I don't know how to update it, though... there
> >>>>>> doesn't appear
> >>>>>> to be a newer version available.
> >>>>>
> >>>>> You could disable the zoned.
> >>>>>
> >>>>>      ./configure --disable-zoned
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
