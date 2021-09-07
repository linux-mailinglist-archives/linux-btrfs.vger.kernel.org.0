Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05237402250
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 04:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhIGCho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 22:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhIGChn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 22:37:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E39C061575
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 19:36:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q3so10847029iot.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 19:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VCkv9nqzJd/ooz/Fg1wQAlIy//ZQoR+0Yxx1OXSFCpM=;
        b=CIAgLsayBKyv60h0Zm77f8bhRQqxHi9hXWZFagDdMqmUdLKvEj3d4NFl27o1YJNTHW
         l4CAwm+q3Eh0U+NZlfzwYTXVn6QClD2pK3XdYWH3IINvpPH9jK33hzEmpwvHspuCEWb2
         gwwbEZR6nsP0Jn9aHiA/5Q+dCXgKGV7QbrxiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VCkv9nqzJd/ooz/Fg1wQAlIy//ZQoR+0Yxx1OXSFCpM=;
        b=QBG8RUuBmAMfMmYancTHH/d0XMZqClenhzZ/Vm37fNjtum6drEKtpPUjuYFcJoJGPD
         u1J0qTmsIKKxRvFQtjdaDHMgioSiW+VwrqtvB/dcuIqp7D8erkyJH5qiJ/qn0wTVS/QE
         xdtVWOBWpFamEXbbFgLrSZFc5YF800cqInwxw6xbk2e5OONAr5G5I3PgeZNaVR88HdAq
         i+DXDgU5pHmgL1oxcc7VyzWbDOQOTiXbq87FlrykhxoDDGX2FceDTxDArQrIvQZtgL0B
         N+48VMDWPqmcrc8Yeh7aTJlrp5YCHvi/yWCMN6Gaj84egtJqRkd6OaBLPvM1xVtS1qqc
         a3zQ==
X-Gm-Message-State: AOAM533iFG/lpfqeup5AHqZYKfFGQKu7i/Zmj74eGMuWVdf8FhTgqUdv
        04Bd5eMfHcTCzUXH8N4fgpP8jSe465wRcQ==
X-Google-Smtp-Source: ABdhPJyQ98KBvIB9setnt1HiRSJyN9pX8MyqlUwyTARU4OlyNioxdQrmE/Dj9EDTBRmob6m40oGsBg==
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr11473425iod.81.1630982196932;
        Mon, 06 Sep 2021 19:36:36 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id a14sm5891937iol.24.2021.09.06.19.36.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 19:36:36 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z1so10869154ioh.7
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 19:36:35 -0700 (PDT)
X-Received: by 2002:a02:664c:: with SMTP id l12mr7404873jaf.140.1630982195630;
 Mon, 06 Sep 2021 19:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com> <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com> <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com>
In-Reply-To: <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Mon, 6 Sep 2021 20:36:24 -0600
X-Gmail-Original-Message-ID: <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
Message-ID: <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Trying to build latest btrfs-progs.  I'm seeing errors in the configure scr=
ipt.

$ cat /etc/os-release
NAME=3D"Linux Mint"
VERSION=3D"20.2 (Uma)"
ID=3Dlinuxmint
ID_LIKE=3Dubuntu
PRETTY_NAME=3D"Linux Mint 20.2"
VERSION_ID=3D"20.2"
HOME_URL=3D"https://www.linuxmint.com/"
SUPPORT_URL=3D"https://forums.linuxmint.com/"
BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthedocs.io/en/=
latest/"
PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
VERSION_CODENAME=3Duma
UBUNTU_CODENAME=3Dfocal

$ uname -a
Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

$ ./configure
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking minix/config.h usability... no
checking minix/config.h presence... no
checking for minix/config.h... no
checking whether it is safe to define __EXTENSIONS__... yes
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking whether C compiler accepts -std=3Dgnu90... yes
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking for an ANSI C-conforming const... yes
checking for working volatile... yes
checking whether byte ordering is bigendian... no
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... no
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ar... ar
checking for rm... /bin/rm
checking for rmdir... /bin/rmdir
checking for openat... yes
checking for reallocarray... yes
checking for clock_gettime... yes
checking linux/perf_event.h usability... yes
checking linux/perf_event.h presence... yes
checking for linux/perf_event.h... yes
checking linux/hw_breakpoint.h usability... yes
checking linux/hw_breakpoint.h presence... yes
checking for linux/hw_breakpoint.h... yes
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking execinfo.h usability... yes
checking execinfo.h presence... yes
checking for execinfo.h... yes
checking for backtrace... yes
checking for backtrace_symbols_fd... yes
checking for xmlto... /usr/bin/xmlto
checking for mv... /bin/mv
checking for a sed that does not truncate output... /bin/sed
checking for asciidoc... /usr/bin/asciidoc
checking for asciidoctor... no
checking for EXT2FS... yes
checking for COM_ERR... yes
checking for REISERFS... yes
checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
checking linux/blkzoned.h usability... yes
checking linux/blkzoned.h presence... yes
checking for linux/blkzoned.h... yes
checking for struct blk_zone.capacity... no
checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
configure: error: linux/blkzoned.h does not provide blk_zone.capacity

---

Info on the file in question (linux/blkzoned.h):

$ dpkg -S /usr/include/linux/blkzoned.h
linux-libc-dev:amd64: /usr/include/linux/blkzoned.h

$ dpkg -l linux-libc-dev
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig=
-pend
|/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
||/ Name                 Version      Architecture Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
Headers for development


So it appears that linux-libc-dev is way out-dated compared to my
kernel.  I don't know how to update it, though... there doesn't appear
to be a newer version available.

-Rob

On Mon, Sep 6, 2021 at 5:26 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/6 =E4=B8=8B=E5=8D=8810:42, Robert Wyrick wrote:
> > 42+ hours of memtest86+, no errors detected.  4 passes complete.
> > Is that good enough?
>
> That's strange, such obvious bitflip should be easily detected.
>
> Is the fs only mounted on that computer?
>
> Anyway, you can continue try to repair with *latest* btrfs-progs.
>
> Thanks,
> Qu
> >
> > On Sun, Sep 5, 2021 at 4:03 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2021/9/6 =E4=B8=8A=E5=8D=8812:00, Robert Wyrick wrote:
> >>> Running memtest86+ now....  20 hours in.  No errors yet.
> >>> Thanks for the analysis.  I'll let this run for another day or so.
> >>
> >> Just to mention, since 5.11 btrfs kernel module has the ability to
> >> detect most high bitflip before writing tree blocks to disks.
> >>
> >> Thus even with less reliable RAM, it's still more reliable than nothin=
g.
> >>
> >> But still, with the existing errors, the RAM test is still an essentia=
l
> >> one before doing anything.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>>
> >>> On Fri, Sep 3, 2021 at 12:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> >>>>
> >>>>
> >>>>
> >>>> On 2021/9/3 =E4=B8=8B=E5=8D=882:48, Qu Wenruo wrote:
> >>>>>
> >>>>>
> >>>>> On 2021/9/3 =E4=B8=8A=E5=8D=8810:43, Robert Wyrick wrote:
> >>>>>> I cannot mount my btrfs filesystem.
> >>>>>> $ uname -a
> >>>>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> >>>>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>>>> $ btrfs version
> >>>>>> btrfs-progs v5.4.1
> >>>>>
> >>>>> The tool is a little too old, thus if you're going to repair, you'd
> >>>>> better to update the progs.
> >>>>>>
> >>>>>> I'm seeing the following from check:
> >>>>>> $ btrfs check -p /dev/sda
> >>>>>> Opening filesystem to check...
> >>>>>> Checking filesystem on /dev/sda
> >>>>>> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> >>>>>> [1/7] checking root items                      (0:00:59 elapsed,
> >>>>>> 2649102 items checked)
> >>>>>> ERROR: invalid generation for extent 38179182174208, have
> >>>>>> 140737491486755 expect (0, 4057084]
> >>>>>
> >>>>> This is a repairable problem.
> >>>>>
> >>>>> We have test case for exactly the same case in tests/fsck-test/044 =
for it.
> >>>>
> >>>> Oh, this invalid extent generation is already a more direct indicati=
on
> >>>> of memory bitflip.
> >>>>
> >>>> 140737491486755 =3D 0x8000002fc823
> >>>>
> >>>> Without the high 0x8 bit, the remaining part is completely valid
> >>>> generation, 0x2fc823, which is inside the expectation.
> >>>>
> >>>> So, a memtest is a must before doing any repair.
> >>>> You won't want another bitflip to ruin your perfectly repairable fs.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>>
> >>>>>> [2/7] checking extents                         (0:02:17 elapsed,
> >>>>>> 1116143 items checked)
> >>>>>> ERROR: errors found in extent allocation tree or chunk allocation
> >>>>>> cache and super generation don't match, space cache will be invali=
dated
> >>>>>> [3/7] checking free space cache                (0:00:00 elapsed)
> >>>>>> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
> >>>>>> filetype 2 errors 2, no dir index
> >>>>>
> >>>>> No dir index can also be repaired.
> >>>>>
> >>>>> The dir index will be added back.
> >>>>>
> >>>>>> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype=
 2
> >>>>>> errors 5, no dir item, no inode ref
> >>>>>
> >>>>> No dir item nor inode ref can also be repaired, but with dir item a=
nd
> >>>>> inode ref removed.
> >>>>>
> >>>>> But the problem here looks very strange.
> >>>>>
> >>>>> It's the same dir and the same index, but different name.
> >>>>> posters vs poSters.
> >>>>>
> >>>>> 'S' is 0x53 and 's' is 0x73, I'm wondering if your system had a bad
> >>>>> memory which caused a bitflip and the problem.
> >>>>>
> >>>>> Thus I prefer to do a full memtest before running btrfs check --rep=
air.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>> [4/7] checking fs roots                        (0:00:42 elapsed,
> >>>>>> 108894 items checked)
> >>>>>> ERROR: errors found in fs roots
> >>>>>> found 15729059057664 bytes used, error(s) found
> >>>>>> total csum bytes: 15313288548
> >>>>>> total tree bytes: 18286739456
> >>>>>> total fs tree bytes: 1791819776
> >>>>>> total extent tree bytes: 229130240
> >>>>>> btree space waste bytes: 1018844959
> >>>>>> file data blocks allocated: 51587230502912
> >>>>>>     referenced 15627926712320
> >>>>>>
> >>>>>> I've tried everything I've found on the internet, but haven't
> >>>>>> attempted to repair based on the warnings...
> >>>>>>
> >>>>>> What more info do you need to help me diagnose/fix this?
> >>>>>>
> >>>>>> Thanks!
> >>>>>> -Rob
> >>>>>>
> >
