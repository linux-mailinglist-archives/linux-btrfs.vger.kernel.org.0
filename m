Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF8402D90
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345625AbhIGRSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhIGRSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 13:18:51 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B17C061575
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 10:17:44 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a1so10860691ilj.6
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q2T0aTeovzTdvV37bY1quDGpmN6FzOxD0lCzj1kB1po=;
        b=WpfzAKJurUfbPXUdce/EZabPfqpP5VAZ/XCTeziSpycXe5BtHPt/fuRrmQ5C63xdgl
         YVMPmOsdgsq8cYHM427iSZQSM+Ey4AeV+sZzqv1yXdYvB02BgMVUTNKOVnGkzN0v9xDL
         LPqZtjQip1iNnfierXPKdGX84A0d6Og1xkyoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q2T0aTeovzTdvV37bY1quDGpmN6FzOxD0lCzj1kB1po=;
        b=bBQKS3SHH3cfMmuuHkkYNg0Mh/liI2t1G6q+yKuBKuUqmh0pNK7xtAyQo7D/j0NlEN
         OtFNHfeRGPuBAWuQd8Vkp8zXBqq98itf9xtOS0AOihPuFRibs28Q/nQracPNfvStlNNB
         ZSrXsRzdb6jXtya6wrTxTPGgg38hogcJ6d7XYxdoPoj80+sRqJw/C++Tac82g66whHn3
         TSP/oem3qYCnGytQny0Aa5Hx6/6T28wssOTUU5DH3L8moJKFDT1n1otilJL9mrtnOG/V
         hNgGu46SRUYdd4XuB7PpCniFR2XU0u4ubDMWIsNJoO7m2+Vb7hM3ASlX7NFo3HwNTnEM
         HD0g==
X-Gm-Message-State: AOAM532yFQGhtxLpyKvUTs94Q/qgEzmX08owq96wzOC/e/uMrZPPjLh7
        GDvycJsE24RuU7W2h7XhZdwlmjF9rRlmWQ==
X-Google-Smtp-Source: ABdhPJxP2ZWRlJ01Ik9K/N0KluiBr55R9lEmPdnxm+MkxKIaAgEEOuE2KOAeKPYx+8R9jvuz048OZA==
X-Received: by 2002:a92:cb0f:: with SMTP id s15mr12999795ilo.59.1631035063820;
        Tue, 07 Sep 2021 10:17:43 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id r13sm6947893ilh.80.2021.09.07.10.17.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:17:43 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id b10so13868610ioq.9
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 10:17:43 -0700 (PDT)
X-Received: by 2002:a6b:f114:: with SMTP id e20mr14868716iog.41.1631035062954;
 Tue, 07 Sep 2021 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com> <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com> <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com> <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
 <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com> <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
 <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com> <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
In-Reply-To: <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Tue, 7 Sep 2021 11:17:31 -0600
X-Gmail-Original-Message-ID: <CAA_aC9_oZiJkxpXcDGRQK=TtXgE4tNBGHxgZWtY8LZB3qfLw7Q@mail.gmail.com>
Message-ID: <CAA_aC9_oZiJkxpXcDGRQK=TtXgE4tNBGHxgZWtY8LZB3qfLw7Q@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks like I spoke too soon.

I can now mount the FS readonly.

I see this error in dmesg:
[58995.896369] CPU: 10 PID: 83845 Comm: btrfs-transacti Tainted: P
      OE     5.11.0-27-generic #29~20.04.1-Ubuntu
[58995.896373] Hardware name: System manufacturer System Product
Name/PRIME X370-PRO, BIOS 0515 03/30/2017
[58995.896376] RIP: 0010:btrfs_run_delayed_refs+0x1af/0x200 [btrfs]
[58995.896422] Code: 8b 55 50 f0 48 0f ba aa 48 0a 00 00 03 72 20 83
f8 fb 74 3c 83 f8 e2 74 37 89 c6 48 c7 c7 50 7e 77 c0 89 45 d0 e8 96
d4 4d d3 <0f> 0b 8b 45 d0 89 c1 ba 4c 08 00 00 4c 89 ef 89 45 d0 48 c7
c6 c0
[58995.896425] RSP: 0018:ffffb89a4a0dfdf8 EFLAGS: 00010282
[58995.896428] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 00000000000=
00027
[58995.896430] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff960fdf0=
98ac8
[58995.896432] RBP: ffffb89a4a0dfe40 R08: ffff960fdf098ac0 R09: ffffb89a4a0=
dfbb8
[58995.896434] R10: 0000000000000001 R11: 0000000000000001 R12: ffff96036a7=
d5378
[58995.896435] R13: ffff960115028888 R14: ffff96036a7d5200 R15: 00000000000=
00000
[58995.896437] FS:  0000000000000000(0000) GS:ffff960fdf080000(0000)
knlGS:0000000000000000
[58995.896439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[58995.896441] CR2: 00005616936891e8 CR3: 000000010fe46000 CR4: 00000000003=
506e0
[58995.896444] Call Trace:
[58995.896450]  btrfs_commit_transaction+0x2c3/0xa80 [btrfs]
[58995.896500]  ? start_transaction+0xd5/0x590 [btrfs]
[58995.896549]  transaction_kthread+0x138/0x1b0 [btrfs]
[58995.896596]  kthread+0x114/0x150
[58995.896604]  ? btrfs_cleanup_transaction+0x570/0x570 [btrfs]
[58995.896649]  ? kthread_park+0x90/0x90
[58995.896653]  ret_from_fork+0x22/0x30
[58995.896661] ---[ end trace c8ba04bdf2113cae ]---
[58995.896664] BTRFS: error (device sdf) in
btrfs_run_delayed_refs:2124: errno=3D-17 Object already exists
[58995.896669] BTRFS info (device sdf): forced readonly
[58995.896672] BTRFS warning (device sdf): Skipping commit of aborted
transaction.
[58995.896674] BTRFS: error (device sdf) in cleanup_transaction:1939:
errno=3D-17 Object already exists

Read-only is better than nothing, but what would be my next steps?

On Tue, Sep 7, 2021 at 11:02 AM Robert Wyrick <rob@wyrick.org> wrote:
>
> Ran a repair:
>
> $ sudo ./btrfs check --repair -p /dev/sda  # I did NOT make install,
> just ran from the compiled directory
> enabling repair mode
> WARNING:
>
> Do not use --repair unless you are advised to do so by a developer
> or an experienced user, and then only after having accepted that no
> fsck can successfully repair all types of filesystem corruption. Eg.
> some software or hardware bugs can fatally damage a volume.
> The operation will start in 10 seconds.
> Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> [1/7] checking root items                      (0:00:59 elapsed,
> 2649102 items checked)
> Fixed 0 roots.
> Reset extent item (38179182174208) generation to 4057084elapsed,
> 1116143 items checked)
> No device size related problem found           (0:02:22 elapsed,
> 1116143 items checked)
> [2/7] checking extents                         (0:02:23 elapsed,
> 1116143 items checked)
> cache and super generation don't match, space cache will be invalidated
> [3/7] checking free space cache                (0:00:00 elapsed)
> Deleting bad dir index [8348950,96,3] root 259 (0:00:25 elapsed,
> 106695 items checked)
> repairing missing dir index item for inode 834922400:26 elapsed,
> 108893 items checked)
> [4/7] checking fs roots                        (0:01:04 elapsed,
> 217787 items checked)
> [5/7] checking csums (without verifying data)  (0:00:04 elapsed,
> 12350321 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 4
> items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 15729059057664 bytes used, no error found
> total csum bytes: 15313288548
> total tree bytes: 18286739456
> total fs tree bytes: 1791819776
> total extent tree bytes: 229130240
> btree space waste bytes: 1018844959
> file data blocks allocated: 51587230502912
>  referenced 15627926712320
>
> I can now mount the filesystem successfully!  Thank you for your help.
>
> I do have some additional questions if you don't mind...
> I am already using RAID 1 to handle single disk outages.  I assume
> things could have gone much worse and I could have lost the whole
> filesystem.  Aside from backups (I know, I know), is there anything
> else I can do to prevent such issues or make them easier to recover
> from?  Could this problem have been avoided/detected earlier?  This
> wasn't a disk failure and according to memtest86+, it wasn't due to
> bad memory either....  I don't run scrubs very often.  Should I?  I
> guess the more general question is:  What are the best practices for
> maintaining a healthy btrfs file system?
>
> Thanks again!
>
> On Mon, Sep 6, 2021 at 10:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2021/9/7 =E4=B8=8B=E5=8D=8812:36, Robert Wyrick wrote:
> > > What exactly would i be disabling?  I don't know what zoned does.
> >
> > The zoned device support.
> >
> > If you don't have any host-managed zoned device, there is no reason you
> > would like to enable it.
> >
> > https://zonedstorage.io/introduction/
> >
> > Thanks,
> > Qu
> >
> > >
> > > On Mon, Sep 6, 2021, 9:07 PM Anand Jain <anand.jain@oracle.com> wrote=
:
> > >>
> > >> On 07/09/2021 10:36, Robert Wyrick wrote:
> > >>> Trying to build latest btrfs-progs.  I'm seeing errors in the confi=
gure script.
> > >>>
> > >>> $ cat /etc/os-release
> > >>> NAME=3D"Linux Mint"
> > >>> VERSION=3D"20.2 (Uma)"
> > >>> ID=3Dlinuxmint
> > >>> ID_LIKE=3Dubuntu
> > >>> PRETTY_NAME=3D"Linux Mint 20.2"
> > >>> VERSION_ID=3D"20.2"
> > >>> HOME_URL=3D"https://www.linuxmint.com/"
> > >>> SUPPORT_URL=3D"https://forums.linuxmint.com/"
> > >>> BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthedoc=
s.io/en/latest/"
> > >>> PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
> > >>> VERSION_CODENAME=3Duma
> > >>> UBUNTU_CODENAME=3Dfocal
> > >>>
> > >>> $ uname -a
> > >>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> > >>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > >>>
> > >>> $ ./configure
> > >>> checking for gcc... gcc
> > >>> checking whether the C compiler works... yes
> > >>> checking for C compiler default output file name... a.out
> > >>> checking for suffix of executables...
> > >>> checking whether we are cross compiling... no
> > >>> checking for suffix of object files... o
> > >>> checking whether we are using the GNU C compiler... yes
> > >>> checking whether gcc accepts -g... yes
> > >>> checking for gcc option to accept ISO C89... none needed
> > >>> checking how to run the C preprocessor... gcc -E
> > >>> checking for grep that handles long lines and -e... /bin/grep
> > >>> checking for egrep... /bin/grep -E
> > >>> checking for ANSI C header files... yes
> > >>> checking for sys/types.h... yes
> > >>> checking for sys/stat.h... yes
> > >>> checking for stdlib.h... yes
> > >>> checking for string.h... yes
> > >>> checking for memory.h... yes
> > >>> checking for strings.h... yes
> > >>> checking for inttypes.h... yes
> > >>> checking for stdint.h... yes
> > >>> checking for unistd.h... yes
> > >>> checking minix/config.h usability... no
> > >>> checking minix/config.h presence... no
> > >>> checking for minix/config.h... no
> > >>> checking whether it is safe to define __EXTENSIONS__... yes
> > >>> checking for gcc... (cached) gcc
> > >>> checking whether we are using the GNU C compiler... (cached) yes
> > >>> checking whether gcc accepts -g... (cached) yes
> > >>> checking for gcc option to accept ISO C89... (cached) none needed
> > >>> checking whether C compiler accepts -std=3Dgnu90... yes
> > >>> checking build system type... x86_64-pc-linux-gnu
> > >>> checking host system type... x86_64-pc-linux-gnu
> > >>> checking for an ANSI C-conforming const... yes
> > >>> checking for working volatile... yes
> > >>> checking whether byte ordering is bigendian... no
> > >>> checking for special C compiler options needed for large files... n=
o
> > >>> checking for _FILE_OFFSET_BITS value needed for large files... no
> > >>> checking for a BSD-compatible install... /usr/bin/install -c
> > >>> checking whether ln -s works... yes
> > >>> checking for ar... ar
> > >>> checking for rm... /bin/rm
> > >>> checking for rmdir... /bin/rmdir
> > >>> checking for openat... yes
> > >>> checking for reallocarray... yes
> > >>> checking for clock_gettime... yes
> > >>> checking linux/perf_event.h usability... yes
> > >>> checking linux/perf_event.h presence... yes
> > >>> checking for linux/perf_event.h... yes
> > >>> checking linux/hw_breakpoint.h usability... yes
> > >>> checking linux/hw_breakpoint.h presence... yes
> > >>> checking for linux/hw_breakpoint.h... yes
> > >>> checking for pkg-config... /usr/bin/pkg-config
> > >>> checking pkg-config is at least version 0.9.0... yes
> > >>> checking execinfo.h usability... yes
> > >>> checking execinfo.h presence... yes
> > >>> checking for execinfo.h... yes
> > >>> checking for backtrace... yes
> > >>> checking for backtrace_symbols_fd... yes
> > >>> checking for xmlto... /usr/bin/xmlto
> > >>> checking for mv... /bin/mv
> > >>> checking for a sed that does not truncate output... /bin/sed
> > >>> checking for asciidoc... /usr/bin/asciidoc
> > >>> checking for asciidoctor... no
> > >>> checking for EXT2FS... yes
> > >>> checking for COM_ERR... yes
> > >>> checking for REISERFS... yes
> > >>> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
> > >>> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
> > >>> checking linux/blkzoned.h usability... yes
> > >>> checking linux/blkzoned.h presence... yes
> > >>> checking for linux/blkzoned.h... yes
> > >>> checking for struct blk_zone.capacity... no
> > >>> checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
> > >>
> > >>> configure: error: linux/blkzoned.h does not provide blk_zone.capaci=
ty
> > >>
> > >>
> > >>>
> > >>> ---
> > >>>
> > >>> Info on the file in question (linux/blkzoned.h):
> > >>>
> > >>> $ dpkg -S /usr/include/linux/blkzoned.h
> > >>> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
> > >>>
> > >>> $ dpkg -l linux-libc-dev
> > >>> Desired=3DUnknown/Install/Remove/Purge/Hold
> > >>> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aW=
ait/Trig-pend
> > >>> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
> > >>> ||/ Name                 Version      Architecture Description
> > >>> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
> > >>> Headers for development
> > >>>
> > >>>
> > >>> So it appears that linux-libc-dev is way out-dated compared to my
> > >>> kernel.  I don't know how to update it, though... there doesn't app=
ear
> > >>> to be a newer version available.
> > >>
> > >> You could disable the zoned.
> > >>
> > >>     ./configure --disable-zoned
> > >>
> > >>
> > >>
> > >>
> > >>
