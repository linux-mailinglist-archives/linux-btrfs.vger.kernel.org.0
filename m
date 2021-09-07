Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6124022DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 06:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhIGEhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 00:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIGEhf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 00:37:35 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271CDC061575
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 21:36:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l10so8696696ilh.8
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY4Jwc/eo4C7pJAnzrDLxR4fwp6nnQ6c0RjC0tmtZuM=;
        b=GSJJl1CW+2L2YH0OMKUuj3UADmoSsCH98008w7S+btlHDSFVw9d98Lm7dJ7/q8Y146
         +ulqWcuq3eDx25nTx7ULk/TkGCO/AmSdkFDww54eCeu6sEaTRy2ulbtMRxq0LQAyWr++
         eKqsu/ldGhjfZjmW/qDcGRqNGqQN1WAXtVRJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY4Jwc/eo4C7pJAnzrDLxR4fwp6nnQ6c0RjC0tmtZuM=;
        b=i97DGhPyyIMRiMTWpkKcorRe2XQZY8VGIQMim3WCEg2rIbQImBLbjxW7wlYUh36xKN
         SVEiRdkGngWHRtTu0SQ78YnrFvW8el8dKIcgbkxN9GUhGc1Qf/c4aHy/6gwLfvE5YL2u
         joPHcSnK+hwc0aVadZX+RPT4QqZO/7npg477L/IBw1VrOW+3Muvg0YDuK4t2z68SjFwj
         AX1wtOgQEy9GXdFTs1QGNy3sZa9N8RAurfuRojG1jEOrWrKHpsBvgPqbxjVvlS7bnwl/
         rvOQToxEJT1QcUTjtnPxQFczUxc7GZkrRUisZCnWWPN0rh+g/FoCWGTbr0etn4xQ8Qhh
         qceg==
X-Gm-Message-State: AOAM5332X0L1ts55NSum/6pEpXrQAP8qDBN4yfuEJPYIDVtTRqrxha6C
        PIPqxnJOHoRTd4UUiH8fiztZFDn2jU+muw==
X-Google-Smtp-Source: ABdhPJzJl+Ni1WiHzCXl/aa/iOxh8HxVp44bJjIZq774+N8wj1S2LOes4qUDSLDGSkoIWV10KcMzaA==
X-Received: by 2002:a92:b10:: with SMTP id b16mr2990844ilf.182.1630989389221;
        Mon, 06 Sep 2021 21:36:29 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id n11sm6163954ioo.44.2021.09.06.21.36.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 21:36:28 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id a22so2972578iok.12
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 21:36:28 -0700 (PDT)
X-Received: by 2002:a5d:935a:: with SMTP id i26mr12095816ioo.79.1630989388328;
 Mon, 06 Sep 2021 21:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com> <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com> <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com> <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
 <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com>
In-Reply-To: <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Mon, 6 Sep 2021 22:36:16 -0600
X-Gmail-Original-Message-ID: <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
Message-ID: <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     Anand Jain <anand.jain@oracle.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What exactly would i be disabling?  I don't know what zoned does.

On Mon, Sep 6, 2021, 9:07 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 07/09/2021 10:36, Robert Wyrick wrote:
> > Trying to build latest btrfs-progs.  I'm seeing errors in the configure script.
> >
> > $ cat /etc/os-release
> > NAME="Linux Mint"
> > VERSION="20.2 (Uma)"
> > ID=linuxmint
> > ID_LIKE=ubuntu
> > PRETTY_NAME="Linux Mint 20.2"
> > VERSION_ID="20.2"
> > HOME_URL="https://www.linuxmint.com/"
> > SUPPORT_URL="https://forums.linuxmint.com/"
> > BUG_REPORT_URL="http://linuxmint-troubleshooting-guide.readthedocs.io/en/latest/"
> > PRIVACY_POLICY_URL="https://www.linuxmint.com/"
> > VERSION_CODENAME=uma
> > UBUNTU_CODENAME=focal
> >
> > $ uname -a
> > Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> > 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >
> > $ ./configure
> > checking for gcc... gcc
> > checking whether the C compiler works... yes
> > checking for C compiler default output file name... a.out
> > checking for suffix of executables...
> > checking whether we are cross compiling... no
> > checking for suffix of object files... o
> > checking whether we are using the GNU C compiler... yes
> > checking whether gcc accepts -g... yes
> > checking for gcc option to accept ISO C89... none needed
> > checking how to run the C preprocessor... gcc -E
> > checking for grep that handles long lines and -e... /bin/grep
> > checking for egrep... /bin/grep -E
> > checking for ANSI C header files... yes
> > checking for sys/types.h... yes
> > checking for sys/stat.h... yes
> > checking for stdlib.h... yes
> > checking for string.h... yes
> > checking for memory.h... yes
> > checking for strings.h... yes
> > checking for inttypes.h... yes
> > checking for stdint.h... yes
> > checking for unistd.h... yes
> > checking minix/config.h usability... no
> > checking minix/config.h presence... no
> > checking for minix/config.h... no
> > checking whether it is safe to define __EXTENSIONS__... yes
> > checking for gcc... (cached) gcc
> > checking whether we are using the GNU C compiler... (cached) yes
> > checking whether gcc accepts -g... (cached) yes
> > checking for gcc option to accept ISO C89... (cached) none needed
> > checking whether C compiler accepts -std=gnu90... yes
> > checking build system type... x86_64-pc-linux-gnu
> > checking host system type... x86_64-pc-linux-gnu
> > checking for an ANSI C-conforming const... yes
> > checking for working volatile... yes
> > checking whether byte ordering is bigendian... no
> > checking for special C compiler options needed for large files... no
> > checking for _FILE_OFFSET_BITS value needed for large files... no
> > checking for a BSD-compatible install... /usr/bin/install -c
> > checking whether ln -s works... yes
> > checking for ar... ar
> > checking for rm... /bin/rm
> > checking for rmdir... /bin/rmdir
> > checking for openat... yes
> > checking for reallocarray... yes
> > checking for clock_gettime... yes
> > checking linux/perf_event.h usability... yes
> > checking linux/perf_event.h presence... yes
> > checking for linux/perf_event.h... yes
> > checking linux/hw_breakpoint.h usability... yes
> > checking linux/hw_breakpoint.h presence... yes
> > checking for linux/hw_breakpoint.h... yes
> > checking for pkg-config... /usr/bin/pkg-config
> > checking pkg-config is at least version 0.9.0... yes
> > checking execinfo.h usability... yes
> > checking execinfo.h presence... yes
> > checking for execinfo.h... yes
> > checking for backtrace... yes
> > checking for backtrace_symbols_fd... yes
> > checking for xmlto... /usr/bin/xmlto
> > checking for mv... /bin/mv
> > checking for a sed that does not truncate output... /bin/sed
> > checking for asciidoc... /usr/bin/asciidoc
> > checking for asciidoctor... no
> > checking for EXT2FS... yes
> > checking for COM_ERR... yes
> > checking for REISERFS... yes
> > checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
> > checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
> > checking linux/blkzoned.h usability... yes
> > checking linux/blkzoned.h presence... yes
> > checking for linux/blkzoned.h... yes
> > checking for struct blk_zone.capacity... no
> > checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
>
> > configure: error: linux/blkzoned.h does not provide blk_zone.capacity
>
>
> >
> > ---
> >
> > Info on the file in question (linux/blkzoned.h):
> >
> > $ dpkg -S /usr/include/linux/blkzoned.h
> > linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
> >
> > $ dpkg -l linux-libc-dev
> > Desired=Unknown/Install/Remove/Purge/Hold
> > | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> > |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> > ||/ Name                 Version      Architecture Description
> > +++-====================-============-============-====================================
> > ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
> > Headers for development
> >
> >
> > So it appears that linux-libc-dev is way out-dated compared to my
> > kernel.  I don't know how to update it, though... there doesn't appear
> > to be a newer version available.
>
> You could disable the zoned.
>
>    ./configure --disable-zoned
>
>
>
>
>
