Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B969E402D63
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbhIGRDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345365AbhIGRDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 13:03:32 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29573C061575
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 10:02:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id x10so2274878ilm.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yh9Bjhud8hpy2dywfiBfXMfKlvzpfMGMQpFa54WsJnI=;
        b=L/tTJs6M05xRy4qflAgPj+xjAW+5nMc8vmhCe2Af2mPpmRtH9+5hqC8rvZQye7zsxA
         cvM+3n0c2RJ3sK5jF3iwH1a+JpTsYm+eD3yGMk5vJp/FCGfm+qnCWvU6y42M0kiS0Uh6
         P/MVUX2cW4VpXDmn6ogIA3H8sttE7C7sn4uv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yh9Bjhud8hpy2dywfiBfXMfKlvzpfMGMQpFa54WsJnI=;
        b=jqa1fngw+Qwutrj8tn38vgVx06XQDp7ZE6Kio652AHx7g6uDkEHSvavEjIIUSpuYgC
         JBG1ySv8q1/1nfwRw8m3iiNYptbJ+ELlkkeaff6SRtXfLuKYBWIv1VCTX7PKRUjTPGmT
         9ehgi9+yI9dGBSDkT/EAdMAudJWamUTcN3KiVD441p9+CMCJy4qioi14X3Sv0T230zpo
         zu4PyxvmHoRv0Ru6YDBuLT/nCwUHXDyhuPiAlAyfxUaUHrGWwv8Xl/hHgdZKZ1K6QHzj
         EQP/zNvyEXpSta+r5f+MUqwRUBOJDadocA4in07gHBFWbPz1KEiE6UPNQfZwtZVBPqWq
         oyYA==
X-Gm-Message-State: AOAM532mEW7Yb3w+EIl/g1030gkQ4489fNiAReBiX3nSnVMoWtZXy+Oo
        45F0qugSXf7qeJG4KHBVxuZaNyqMRmMMwA==
X-Google-Smtp-Source: ABdhPJww9xzmCFpiijBPdGO2jFJiSWRRCBvHHDxVjn7fcghnSFDBKLnCDy30WzUNgLsMOph+CA2xdg==
X-Received: by 2002:a05:6e02:4c3:: with SMTP id f3mr13002481ils.248.1631034144212;
        Tue, 07 Sep 2021 10:02:24 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id h25sm6198563ila.78.2021.09.07.10.02.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:02:23 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id a22so5686394iok.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 10:02:23 -0700 (PDT)
X-Received: by 2002:a02:cc59:: with SMTP id i25mr16130628jaq.125.1631034143457;
 Tue, 07 Sep 2021 10:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com> <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com> <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com> <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
 <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com> <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
 <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com>
In-Reply-To: <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Tue, 7 Sep 2021 11:02:12 -0600
X-Gmail-Original-Message-ID: <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
Message-ID: <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ran a repair:

$ sudo ./btrfs check --repair -p /dev/sda  # I did NOT make install,
just ran from the compiled directory
enabling repair mode
WARNING:

Do not use --repair unless you are advised to do so by a developer
or an experienced user, and then only after having accepted that no
fsck can successfully repair all types of filesystem corruption. Eg.
some software or hardware bugs can fatally damage a volume.
The operation will start in 10 seconds.
Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
[1/7] checking root items                      (0:00:59 elapsed,
2649102 items checked)
Fixed 0 roots.
Reset extent item (38179182174208) generation to 4057084elapsed,
1116143 items checked)
No device size related problem found           (0:02:22 elapsed,
1116143 items checked)
[2/7] checking extents                         (0:02:23 elapsed,
1116143 items checked)
cache and super generation don't match, space cache will be invalidated
[3/7] checking free space cache                (0:00:00 elapsed)
Deleting bad dir index [8348950,96,3] root 259 (0:00:25 elapsed,
106695 items checked)
repairing missing dir index item for inode 834922400:26 elapsed,
108893 items checked)
[4/7] checking fs roots                        (0:01:04 elapsed,
217787 items checked)
[5/7] checking csums (without verifying data)  (0:00:04 elapsed,
12350321 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 4
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 15729059057664 bytes used, no error found
total csum bytes: 15313288548
total tree bytes: 18286739456
total fs tree bytes: 1791819776
total extent tree bytes: 229130240
btree space waste bytes: 1018844959
file data blocks allocated: 51587230502912
 referenced 15627926712320

I can now mount the filesystem successfully!  Thank you for your help.

I do have some additional questions if you don't mind...
I am already using RAID 1 to handle single disk outages.  I assume
things could have gone much worse and I could have lost the whole
filesystem.  Aside from backups (I know, I know), is there anything
else I can do to prevent such issues or make them easier to recover
from?  Could this problem have been avoided/detected earlier?  This
wasn't a disk failure and according to memtest86+, it wasn't due to
bad memory either....  I don't run scrubs very often.  Should I?  I
guess the more general question is:  What are the best practices for
maintaining a healthy btrfs file system?

Thanks again!

On Mon, Sep 6, 2021 at 10:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/7 =E4=B8=8B=E5=8D=8812:36, Robert Wyrick wrote:
> > What exactly would i be disabling?  I don't know what zoned does.
>
> The zoned device support.
>
> If you don't have any host-managed zoned device, there is no reason you
> would like to enable it.
>
> https://zonedstorage.io/introduction/
>
> Thanks,
> Qu
>
> >
> > On Mon, Sep 6, 2021, 9:07 PM Anand Jain <anand.jain@oracle.com> wrote:
> >>
> >> On 07/09/2021 10:36, Robert Wyrick wrote:
> >>> Trying to build latest btrfs-progs.  I'm seeing errors in the configu=
re script.
> >>>
> >>> $ cat /etc/os-release
> >>> NAME=3D"Linux Mint"
> >>> VERSION=3D"20.2 (Uma)"
> >>> ID=3Dlinuxmint
> >>> ID_LIKE=3Dubuntu
> >>> PRETTY_NAME=3D"Linux Mint 20.2"
> >>> VERSION_ID=3D"20.2"
> >>> HOME_URL=3D"https://www.linuxmint.com/"
> >>> SUPPORT_URL=3D"https://forums.linuxmint.com/"
> >>> BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthedocs.=
io/en/latest/"
> >>> PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
> >>> VERSION_CODENAME=3Duma
> >>> UBUNTU_CODENAME=3Dfocal
> >>>
> >>> $ uname -a
> >>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> >>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>
> >>> $ ./configure
> >>> checking for gcc... gcc
> >>> checking whether the C compiler works... yes
> >>> checking for C compiler default output file name... a.out
> >>> checking for suffix of executables...
> >>> checking whether we are cross compiling... no
> >>> checking for suffix of object files... o
> >>> checking whether we are using the GNU C compiler... yes
> >>> checking whether gcc accepts -g... yes
> >>> checking for gcc option to accept ISO C89... none needed
> >>> checking how to run the C preprocessor... gcc -E
> >>> checking for grep that handles long lines and -e... /bin/grep
> >>> checking for egrep... /bin/grep -E
> >>> checking for ANSI C header files... yes
> >>> checking for sys/types.h... yes
> >>> checking for sys/stat.h... yes
> >>> checking for stdlib.h... yes
> >>> checking for string.h... yes
> >>> checking for memory.h... yes
> >>> checking for strings.h... yes
> >>> checking for inttypes.h... yes
> >>> checking for stdint.h... yes
> >>> checking for unistd.h... yes
> >>> checking minix/config.h usability... no
> >>> checking minix/config.h presence... no
> >>> checking for minix/config.h... no
> >>> checking whether it is safe to define __EXTENSIONS__... yes
> >>> checking for gcc... (cached) gcc
> >>> checking whether we are using the GNU C compiler... (cached) yes
> >>> checking whether gcc accepts -g... (cached) yes
> >>> checking for gcc option to accept ISO C89... (cached) none needed
> >>> checking whether C compiler accepts -std=3Dgnu90... yes
> >>> checking build system type... x86_64-pc-linux-gnu
> >>> checking host system type... x86_64-pc-linux-gnu
> >>> checking for an ANSI C-conforming const... yes
> >>> checking for working volatile... yes
> >>> checking whether byte ordering is bigendian... no
> >>> checking for special C compiler options needed for large files... no
> >>> checking for _FILE_OFFSET_BITS value needed for large files... no
> >>> checking for a BSD-compatible install... /usr/bin/install -c
> >>> checking whether ln -s works... yes
> >>> checking for ar... ar
> >>> checking for rm... /bin/rm
> >>> checking for rmdir... /bin/rmdir
> >>> checking for openat... yes
> >>> checking for reallocarray... yes
> >>> checking for clock_gettime... yes
> >>> checking linux/perf_event.h usability... yes
> >>> checking linux/perf_event.h presence... yes
> >>> checking for linux/perf_event.h... yes
> >>> checking linux/hw_breakpoint.h usability... yes
> >>> checking linux/hw_breakpoint.h presence... yes
> >>> checking for linux/hw_breakpoint.h... yes
> >>> checking for pkg-config... /usr/bin/pkg-config
> >>> checking pkg-config is at least version 0.9.0... yes
> >>> checking execinfo.h usability... yes
> >>> checking execinfo.h presence... yes
> >>> checking for execinfo.h... yes
> >>> checking for backtrace... yes
> >>> checking for backtrace_symbols_fd... yes
> >>> checking for xmlto... /usr/bin/xmlto
> >>> checking for mv... /bin/mv
> >>> checking for a sed that does not truncate output... /bin/sed
> >>> checking for asciidoc... /usr/bin/asciidoc
> >>> checking for asciidoctor... no
> >>> checking for EXT2FS... yes
> >>> checking for COM_ERR... yes
> >>> checking for REISERFS... yes
> >>> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
> >>> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
> >>> checking linux/blkzoned.h usability... yes
> >>> checking linux/blkzoned.h presence... yes
> >>> checking for linux/blkzoned.h... yes
> >>> checking for struct blk_zone.capacity... no
> >>> checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
> >>
> >>> configure: error: linux/blkzoned.h does not provide blk_zone.capacity
> >>
> >>
> >>>
> >>> ---
> >>>
> >>> Info on the file in question (linux/blkzoned.h):
> >>>
> >>> $ dpkg -S /usr/include/linux/blkzoned.h
> >>> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
> >>>
> >>> $ dpkg -l linux-libc-dev
> >>> Desired=3DUnknown/Install/Remove/Purge/Hold
> >>> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWai=
t/Trig-pend
> >>> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
> >>> ||/ Name                 Version      Architecture Description
> >>> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
> >>> Headers for development
> >>>
> >>>
> >>> So it appears that linux-libc-dev is way out-dated compared to my
> >>> kernel.  I don't know how to update it, though... there doesn't appea=
r
> >>> to be a newer version available.
> >>
> >> You could disable the zoned.
> >>
> >>     ./configure --disable-zoned
> >>
> >>
> >>
> >>
> >>
