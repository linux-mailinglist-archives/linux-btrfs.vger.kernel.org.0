Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50B65DACA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjADQ4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjADQzi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 11:55:38 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC065BA37
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 08:51:41 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r11so29931707oie.13
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jan 2023 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WtDO8AN+81RdDyv6tboLIfWkWSVOk3WzOxfGz7S5e00=;
        b=o+D29e9bYKMkDmtwbIyFRvRJBHNS4rtUHrHNtIWjA9Uvq9Biffzu83HST10xfFX/ys
         WOuaD/sO1fMjyXTIMUlYTpwivh+yGJ4N46HtQZ1IIlmQawyw0n7kkLN0aMg0J+RpaCBe
         VE37abvd8gCB0uV2J0+OTfCCG9NGlY2BM6VNr/FWlHnEmJbpck7XmbcGgYEBGXv/qlgC
         cmKZ9znShTcxOSenEEM0wcqANJ4kbB7mK0r16HFPfOX4wxYgbs/HxAYYApv3Pvsahhtq
         t7+AukBlDY6sqQLjg+Qo8YXlV6nqJiIW0XHhxfxh1YWSpO1zinAkMxoEhYldV/NhrL4j
         r8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtDO8AN+81RdDyv6tboLIfWkWSVOk3WzOxfGz7S5e00=;
        b=GKVQd2Du5oEN69mMhZnt2y8/+IBa/1Xb8xL8x415bgL99Ztr7igoILPcU6OSaAg9/t
         +rRdD6for6gBTIvAOVqJzoCl6alako4sQTxMdrkuQ4C0IyVmqZJFsMzYYhXwY5LXQKLY
         +zZf8vSwm4x63hd9EnGOenx1JGV8z+lrQGzT9HDnZb+MZygwRdwDvAb/4NEo/hkPUWhT
         dRZtrw+WdQLEsJQPJA9Gm1Mgxx86fXIrPFsEfsbtLJ06+DC2Mfe0WhG0PNq4R4nVCU64
         3DpVUQuOetO1y7HW8F93eiJYv0/EUKN1AQ1iXCpj3j81kHLomcU7xJ+hXA9RMJZtECYE
         YGUA==
X-Gm-Message-State: AFqh2kqu7GxkI776jAZ+UDKlV65/PWvV7spzqRsLetrCnMMj36Kjgsdb
        a8y60NtkMoGjcOn6z/PFdZ6eNxjgbV9DVXsMAUcVj5iIg1e/GC9QAKw=
X-Google-Smtp-Source: AMrXdXvp74bSXZmamXpz9JHBw+2SBK7o0H2PNoycZnyHiSFdmN10E07ABLr6uhWvDuR6K9DzhHjpi+/wZeV3WL9W3U8=
X-Received: by 2002:aca:1c12:0:b0:35b:1451:d883 with SMTP id
 c18-20020aca1c12000000b0035b1451d883mr3420743oic.90.1672851100124; Wed, 04
 Jan 2023 08:51:40 -0800 (PST)
MIME-Version: 1.0
References: <CACyAFTK61Ncek=WwYwvWKvN6_fECnALTzFcwqQHZKSDP3u_D0g@mail.gmail.com>
 <57310cd8-16b8-9918-42f5-efda114a944d@gmx.com> <CACyAFTLY4_xtgJjCXKK6JTcjAhXpWYhnnALndTLehT3=NQ8+AA@mail.gmail.com>
 <e15df0f8-72da-2c73-e3af-062c05001f95@gmx.com> <CACyAFTJxWDV0NpRrMTtrB9XQqZj+kyi=jejRd63zVAWCoqSSow@mail.gmail.com>
 <29d53614-a19b-5bbf-cb54-aa8ce68a1770@gmx.com> <CACyAFTKVw85FfftvaJioX=MFfCZnvtpynb+0b-zAMcaS+rZnQA@mail.gmail.com>
In-Reply-To: <CACyAFTKVw85FfftvaJioX=MFfCZnvtpynb+0b-zAMcaS+rZnQA@mail.gmail.com>
From:   Colin Stark <stark.colin@gmail.com>
Date:   Wed, 4 Jan 2023 17:51:03 +0100
Message-ID: <CACyAFT+KeYxmHvq1u8pC8g9KF7R5-J9WKTqQnaheYc8=NhKbvg@mail.gmail.com>
Subject: Re: BTRFS volume unmountable: open_ctree failed
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is there anything further that can be tried here?

I tried running the same command for all of the backup roots listed by
the dump-super command with no luck:

./btrfs check -r 364703879659520 --chunk-root 365555539050496 -p /dev/sdb
Opening filesystem to check...
No mapping for 365555539050496-365555539066880
Couldn't map the block 365555539050496
Couldn't map the block 365555539050496
bad tree block 365555539050496, bytenr mismatch, want=365555539050496, have=0
ERROR: cannot read chunk root
ERROR: cannot open file system

 ./btrfs check -r 358515112902656 --chunk-root 365541449662464 /dev/sdb
Opening filesystem to check...
No mapping for 365541452218368-365541452234752
Couldn't map the block 365541452218368
Couldn't map the block 365541452218368
bad tree block 365541452218368, bytenr mismatch, want=365541452218368, have=0
Couldn't read chunk tree
ERROR: cannot open file system

 ./btrfs check -r 319507734593536 --chunk-root 365541449662464 /dev/sdb
Opening filesystem to check...
No mapping for 365541452218368-365541452234752
Couldn't map the block 365541452218368
Couldn't map the block 365541452218368
bad tree block 365541452218368, bytenr mismatch, want=365541452218368, have=0
Couldn't read chunk tree
ERROR: cannot open file system

On Thu, Dec 22, 2022 at 1:24 AM Colin Stark <stark.colin@gmail.com> wrote:
>
> Unfortunately, the result is very similar:
>
> root@server:~/btrfs-progs# ./btrfs check -r 316903884406784
> --chunk-root 365555539050496 /dev/sdb
> Opening filesystem to check...
> No mapping for 365555539050496-365555539066880
> Couldn't map the block 365555539050496
> Couldn't map the block 365555539050496
> bad tree block 365555539050496, bytenr mismatch, want=365555539050496, have=0
> ERROR: cannot read chunk root
> ERROR: cannot open file system
>
> Thanks for your continued help,
> Colin
>
> On Thu, Dec 22, 2022 at 12:30 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2022/12/21 20:57, Colin Stark wrote:
> > > dump-super output is attached.
> > >
> > > I also realize I never provided btrfs fi show output:
> > > Label: 'data'  uuid: 2296d823-e45e-4f54-a053-0baa1531e73c
> > >          Total devices 10 FS bytes used 54.87TiB
> > >          devid    1 size 7.28TiB used 7.28TiB path /dev/sdb
> > >          devid    2 size 7.28TiB used 7.28TiB path /dev/sdc
> > >          devid    3 size 16.37TiB used 8.00TiB path /dev/sdd
> > >          devid    5 size 7.28TiB used 7.28TiB path /dev/sdi
> > >          devid    6 size 16.37TiB used 8.00TiB path /dev/sdf
> > >          devid    7 size 16.37TiB used 8.00TiB path /dev/sde
> > >          devid    8 size 7.28TiB used 7.28TiB path /dev/sda
> > >          devid    9 size 7.28TiB used 7.28TiB path /dev/sdh
> > >          devid   10 size 5.46TiB used 5.46TiB path /dev/sdk
> > >          devid   11 size 5.46TiB used 5.46TiB path /dev/sdj
> >
> > The dump-super output looks very weird.
> >
> > Firstly, the system chunks are too small.
> >
> > Normally our max chunk size for RAID1C4 should be 32M, but in your case,
> > they are only in hundreds of KiBs.
> >
> > I'm not sure if this is correct, as we only have system chunk array, no
> > chunk tree to be sure.
> >
> > Secondly, your chunk tree is just modified in the latest commit
> > (1328013), thus you may have a chance to recover using the older tree
> > root and older chunk root.
> >
> > You can verify it by the following command:
> >
> >   # btrfs check -r 316903884406784 --chunk-root 365555539050496 <device>
> >
> > If it no longer error out very quick, then you may have the chance to
> > recover most of your data.
> >
> > Of course, please attach the full output of above command.
> >
> > Thanks,
> > Qu
> > >
> > > On Wed, Dec 21, 2022 at 1:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2022/12/21 20:36, Colin Stark wrote:
> > >>> Unfortunately no luck here.  The command crashes after running for
> > >>> about 30 minutes.
> > >>>
> > >>> I tried to get a backtrace for the issue, but I think something is
> > >>> missing from my setup.  Please advise if you'd like me to try again to
> > >>> get a full backtrace.  I also found this open issue from 2018 that
> > >>> appears to be similar, though no progress appears to have been made:
> > >>> https://github.com/kdave/btrfs-progs/issues/130
> > >>>
> > >>> That aside, do I have any options left for trying to salvage this volume?
> > >>
> > >> OK, that BUG_ON() is mostly related to RAID6 (which its number of copies
> > >> can be the number of stripes, thus exceeding the MAX_MIRRORS).
> > >>
> > >> But I doubt even if it works, chunk-recovery may not be the best
> > >> solution for your case.
> > >> (Which looks like a missing system chunk item).
> > >>
> > >> Mind to provide the following output?
> > >>
> > >>    # btrfs ins dump-super -f <device>
> > >>
> > >> You only need to run it on any of the array.
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >>>
> > >>> Thanks for your help.
> > >>>
> > >>> Output:
> > >>> root@server:~/btrfs-progs# LD_LIBRARY_PATH=. gdb ./btrfs # rescue
> > >>> chunk-recover -v /dev/sdb
> > >>> GNU gdb (Ubuntu 12.1-3ubuntu2) 12.1
> > >>> Copyright (C) 2022 Free Software Foundation, Inc.
> > >>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > >>> This is free software: you are free to change and redistribute it.
> > >>> There is NO WARRANTY, to the extent permitted by law.
> > >>> Type "show copying" and "show warranty" for details.
> > >>> This GDB was configured as "x86_64-linux-gnu".
> > >>> Type "show configuration" for configuration details.
> > >>> For bug reporting instructions, please see:
> > >>> <https://www.gnu.org/software/gdb/bugs/>.
> > >>> Find the GDB manual and other documentation resources online at:
> > >>>       <http://www.gnu.org/software/gdb/documentation/>.
> > >>>
> > >>> For help, type "help".
> > >>> Type "apropos word" to search for commands related to "word"...
> > >>> Reading symbols from ./btrfs...
> > >>> (gdb) run rescue chunk-recover -v /dev/sdb
> > >>> Starting program: /root/btrfs-progs/btrfs rescue chunk-recover -v /dev/sdb
> > >>> [Thread debugging using libthread_db enabled]
> > >>> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > >>> All Devices:
> > >>>           Device: id = 9, name = /dev/sdh
> > >>>           Device: id = 11, name = /dev/sdj
> > >>>           Device: id = 8, name = /dev/sda
> > >>>           Device: id = 2, name = /dev/sdc
> > >>>           Device: id = 7, name = /dev/sde
> > >>>           Device: id = 5, name = /dev/sdi
> > >>>           Device: id = 10, name = /dev/sdk
> > >>>           Device: id = 3, name = /dev/sdd
> > >>>           Device: id = 6, name = /dev/sdf
> > >>>           Device: id = 1, name = /dev/sdb
> > >>>
> > >>> [New Thread 0x7ffff7c516c0 (LWP 17845)]
> > >>> [New Thread 0x7ffff74506c0 (LWP 17846)]
> > >>> [New Thread 0x7ffff6c4f6c0 (LWP 17847)]
> > >>> [New Thread 0x7ffff644e6c0 (LWP 17848)]
> > >>> [New Thread 0x7ffff5c4d6c0 (LWP 17849)]
> > >>> [New Thread 0x7ffff544c6c0 (LWP 17850)]
> > >>> [New Thread 0x7ffff4c4b6c0 (LWP 17851)]
> > >>> [New Thread 0x7fffdbfff6c0 (LWP 17852)]
> > >>> [New Thread 0x7fffd3fff6c0 (LWP 17853)]
> > >>> [New Thread 0x7fffdb7fe6c0 (LWP 17854)]
> > >>> Scanning: 61882368 in dev0, 60243968 in dev1, 189743104 in dev2,
> > >>> 210714624 in dev3, 233652224 in dev4, 63459328 in dev5, 62996480 in
> > >>> dev6, 225656832 in dev7,Scanning: 120668160 in dev0, 119750656 in
> > >>> dev1, 381763584 in dev2, 424230912 in dev3, 465911808 in dev4,
> > >>> 122241024 in dev5, 122372096 in dev6, 457916416 in dScanning:
> > >>> 179650560 in dev0, 179388416 in dev1, 573784064 in dev2, 636993536 in
> > >>> dev3, 699875328 in dev4, 181223424 in dev5, 181747712 in dev6,
> > >>> 691879936 in dScanning: 239681536 in dev0, 240205824 in dev1,
> > >>> 765673472 in dev2, 850477056 in dev3, 938033152 in dev4, 241254400 in
> > >>> dev5, 242565120 in dev6, 929906688 in dScanning: 298926080 in dev0,
> > >>> 299974656 in dev1, 957693952 in dev2, 1066352640 in dev3, 1171996672
> > >>> in dev4, 300498944 in dev5, 302333952 in dev6, 1164001280 iScanning:
> > >>> 358432768 in dev0, 360136704 in dev1, 1149583360 in dev2, 1284718592
> > >>> in dev3, 1407184896 in dev4, 360005632 in dev5, 362496000 in dev6,
> > >>> 1399275520 Scanning: 417808384 in dev0, 420167680 in dev1, 1341341696
> > >>> in dev2, 1503084544 in dev3, 1642545152 in dev4, 419381248 in dev5,
> > >>> 422526976 in dev6, 1634549760 Scanning: 477052928 in dev0, 480067584
> > >>> in dev1, 1533362176 in dev2, 1721581568 in dev3, 1877164032 in dev4,
> > >>> 478625792 in dev5, 482689024 in dev6, 1869430784 Scanning: 540360704
> > >>> in dev0, 544161792 in dev1, 1720954880 in dev2, 1936539648 in dev3,
> > >>> 2127773696 in dev4, 541933568 in dev5, 546783232 in dev6, 2119962624
> > >>> Scanning: 601833472 in dev0, 606158848 in dev1, 1913077760 in dev2,
> > >>> 2152284160 in dev3, 2369732608 in dev4, 603144192 in dev5, 608649216
> > >>> in dev6, 2361999360 Scanning: 660553728 in dev0, 668942336 in dev1,
> > >>> 2103001088 in dev2, 2365538304 in dev3, 2603827200 in dev4, 658980864
> > >>> in dev5, 671039488 in dev6, 2596093952 Scanning: 720453632 in dev0,
> > >>> 729366528 in dev1, 2294759424 in dev2, 2581020672 in dev3, 2840412160
> > >>> in dev4, 718618624 in dev5, 731332608 in dev6, 2832809984 Scanning:
> > >>> 781139968 in dev0, 790839296 in dev1, 2485731328 in dev2, 2793226240
> > >>> in dev3, 3080011776 in dev4, 778911744 in dev5, 792674304 in dev6,
> > >>> 3072663552 Scanning: 841957376 in dev0, 852443136 in dev1, 2677620736
> > >>> in dev2, 2998222848 in dev3, 3321446400 in dev4, 839860224 in dev5,
> > >>> 854409216 in dev6, 3314106368 Scanning: 901111808 in dev0, 914309120
> > >>> in dev1, 2869116928 in dev2, 3212021760 in dev3, 3562618880 in dev4,
> > >>> 882102272 in dev5, 916275200 in dev6, 3555540992 Scanning: 960577536
> > >>> in dev0, 975912960 in dev1, 3061137408 in dev2, 3426304000 in dev3,
> > >>> 3800121344 in dev4, 931741696 in dev5, 978272256 in dev6, 3793174528
> > >>> Scanning: 1020739584 in dev0, 1036730368 in dev1, 3253157888 in dev2,
> > >>> 3640606720 in dev3, 4039196672 in dev4, 989675520 in dev5, 1039220736
> > >>> in dev6, 40321187Scanning: 1080246272 in dev0, 1097023488 in dev1,
> > >>> 3445178368 in dev2, 3862511616 in dev3, 4274864128 in dev4, 1049051136
> > >>> in dev5, 1099251712 in dev6, 4268048Scanning: 1142636544 in dev0,
> > >>> 1160200192 in dev1, 3636936704 in dev2, 4082581504 in dev3, 4522102784
> > >>> in dev4, 1110654976 in dev5, 1162432512 in dev6, 4515512Scanning:
> > >>> 1204371456 in dev0, 1223245824 in dev1, 3828957184 in dev2, 4304617472
> > >>> in dev3, 4767301632 in dev4, 1171210240 in dev5, 1225342976 in dev6,
> > >>> 4742135Scanning: 1270824960 in dev0, 1285111808 in dev1, 4020977664 in
> > >>> dev2, 4520361984 in dev3, 5010178048 in dev4, 1226653696 in dev5,
> > >>> 1287340032 in dev6, 4965351Scanning: 1333739520 in dev0, 1349337088 in
> > >>> dev1, 4212998144 in dev2, 4724572160 in dev3, 5260525568 in dev4,
> > >>> 1285898240 in dev5, 1351565312 in dev6, 5176901Scanning: 1394425856 in
> > >>> dev0, 1410809856 in dev1, 4404887552 in dev2, 4930093056 in dev3,
> > >>> 5501173760 in dev4, 1346715648 in dev5, 1412907008 in dev6,
> > >>> 5417811Scanning: 1454981120 in dev0, 1472806912 in dev1, 4596908032 in
> > >>> dev2, 5131419648 in dev3, 5743656960 in dev4, 1400848384 in dev5,
> > >>> 1475166208 in dev6, 5660426Scanning: 1513832448 in dev0, 1534017536 in
> > >>> dev1, 4788928512 in dev2, 5336141824 in dev3, 5982208000 in dev4,
> > >>> 1451835392 in dev5, 1536376832 in dev6, 5899108Scanning: 1573076992 in
> > >>> dev0, 1594310656 in dev1, 4980948992 in dev2, 5555306496 in dev3,
> > >>> 6215778304 in dev4, 1510948864 in dev5, 1596538880 in dev6,
> > >>> 6132809Scanning: 1632845824 in dev0, 1655259136 in dev1, 5172707328 in
> > >>> dev2, 5772787712 in dev3, 6453149696 in dev4, 1556561920 in dev5,
> > >>> 1656963072 in dev6, 6370181Scanning: 1692483584 in dev0, 1716207616 in
> > >>> dev1, 5364727808 in dev2, 5992431616 in dev3, 6691438592 in dev4,
> > >>> 1615413248 in dev5, 1717780480 in dev6, 6608470Scanning: 1754218496 in
> > >>> dev0, 1779253248 in dev1, 5556748288 in dev2, 6206078976 in dev3,
> > >>> 6937591808 in dev4, 1673478144 in dev5, 1780826112 in dev6,
> > >>> 6854885Scanning: 1816739840 in dev0, 1841905664 in dev1, 5748375552 in
> > >>> dev2, 6416449536 in dev3, 7183745024 in dev4, 1735081984 in dev5,
> > >>> 1843871744 in dev6, 7100776Scanning: 1877164032 in dev0, Scanning:
> > >>> 73366286336 in dev0, 74653970432 in dev1, 221169643520 in dev2,
> > >>> 254365478912 in dev3, 290406514688 in dev4, 69599920128 in dev5,
> > >>> 74645659648 in dev6, 287038144512 in dev7, 290337579008 in dev8,
> > >>> 250395525120 in dev9cmds/rescue-chunk-recover.c:128:
> > >>> process_extent_buffer: BUG_ON `exist->nmirrors >= BTRFS_MAX_MIRRORS`
> > >>> triggered, value 1
> > >>> Scanning: 73438507008 in dev0, 74729336832 in dev1, 221191864320 in
> > >>> dev2, 254573060096 in dev3, 290685366272 in dev4, 69651824640 in dev5,
> > >>> 74721157120 in dev6, 287322771456 in dev7, 290621480960 in dev8,
> > >>> 250598162432 in dev9/root/btrfs-progs/btrfs(+0x8d401)[0x5555555e1401]
> > >>> /root/btrfs-progs/btrfs(+0x8eb63)[0x5555555e2b63]
> > >>> /lib/x86_64-linux-gnu/libc.so.6(+0x90402)[0x7ffff7ce4402]
> > >>> /lib/x86_64-linux-gnu/libc.so.6(+0x11f590)[0x7ffff7d73590]
> > >>> Scanning: 73513611264 in dev0, 74807717888 in dev1, 221191864320 in
> > >>> dev2, 254781857792 in dev3, 290964881408 in dev4, 69718147072 in dev5,
> > >>> 74795343872 in dev6, 287621267456 in dev7, 290919407616 in dev8,
> > >>> 250810761216 in dev9             Thread 4 "btrfs" received signal
> > >>> SIGABRT, Aborted.
> > >>> [Switching to Thread 0x7ffff6c4f6c0 (LWP 17847)]
> > >>> __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized
> > >>> out>) at ./nptl/pthread_kill.c:44
> > >>> 44      ./nptl/pthread_kill.c: No such file or directory.
> > >>>
> > >>> On Wed, Dec 21, 2022 at 2:34 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 2022/12/21 01:35, Colin Stark wrote:
> > >>>>> Hi all,
> > >>>>>
> > >>>>> After upgrading my server from Ubuntu 22.04 to 22.10 (kernel 5.15 to
> > >>>>> 5.19), I am no longer able to mount my BTRFS volume.  I tried booting
> > >>>>> from an Ubuntu 22.04 live USB but the results are the same - something
> > >>>>> seems to have damaged the volume during the upgrade, although it could
> > >>>>> just be coincidental.
> > >>>>>
> > >>>>> This seems to be quite a serious error as btrfs check barely even
> > >>>>> runs.  The volume is RAID6 spread across 10 devices.  AFAIK, all of
> > >>>>> the drives are in good working condition.
> > >>>>>
> > >>>>> I'm hoping someone here is able to assist with repairing the filesystem.
> > >>>>>
> > >>>>> dmesg shows the following errors:
> > >>>>> [  279.889337] BTRFS info (device sdb): using free space tree
> > >>>>> [  279.889341] BTRFS info (device sdb): has skinny extents
> > >>>>> [  279.896776] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452218368 length 4096
> > >>>>> [  279.897009] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452201984 length 4096
> > >>>>> [  279.897037] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452185600 length 4096
> > >>>>> [  279.897072] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452251136 length 4096
> > >>>>> [  279.897097] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452316672 length 4096
> > >>>>> [  279.897113] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452349440 length 4096
> > >>>>> [  279.897128] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452300288 length 4096
> > >>>>> [  279.897144] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452267520 length 4096
> > >>>>> [  279.897159] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452283904 length 4096
> > >>>>> [  279.897175] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452365824 length 4096
> > >>>>> [  279.897190] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452333056 length 4096
> > >>>>> [  279.897207] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452431360 length 4096
> > >>>>> [  279.897224] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365555539099648 length 4096
> > >>>>> [  279.897239] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452447744 length 4096
> > >>>>> [  279.897254] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452382208 length 4096
> > >>>>> [  279.897415] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452152832 length 4096
> > >>>>> [  279.897719] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452234752 length 4096
> > >>>>> [  279.897938] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452398592 length 4096
> > >>>>> [  279.897957] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452169216 length 4096
> > >>>>> [  279.897973] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452414976 length 4096
> > >>>>> [  279.897988] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452464128 length 4096
> > >>>>> [  279.898004] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452496896 length 4096
> > >>>>> [  279.898020] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452480512 length 4096
> > >>>>> [  279.898035] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452513280 length 4096
> > >>>>> [  279.898050] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452546048 length 4096
> > >>>>> [  279.898065] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452562432 length 4096
> > >>>>> [  279.898081] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452578816 length 4096
> > >>>>> [  279.898096] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452595200 length 4096
> > >>>>> [  279.898112] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452611584 length 4096
> > >>>>> [  279.898127] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452529664 length 4096
> > >>>>> [  279.898144] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452627968 length 4096
> > >>>>> [  279.898159] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452644352 length 4096
> > >>>>> [  279.898175] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452660736 length 4096
> > >>>>> [  279.898192] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452677120 length 4096
> > >>>>> [  279.898208] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452693504 length 4096
> > >>>>> [  279.898223] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452709888 length 4096
> > >>>>> [  279.898239] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452726272 length 4096
> > >>>>> [  279.898257] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452759040 length 4096
> > >>>>> [  279.898273] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452742656 length 4096
> > >>>>> [  279.898296] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452775424 length 4096
> > >>>>> [  279.898322] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452857344 length 4096
> > >>>>> [  279.898339] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452890112 length 4096
> > >>>>> [  279.898354] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452824576 length 4096
> > >>>>> [  279.898370] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452808192 length 4096
> > >>>>> [  279.898385] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452922880 length 4096
> > >>>>> [  279.898400] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452840960 length 4096
> > >>>>> [  279.898432] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452906496 length 4096
> > >>>>> [  279.898449] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452791808 length 4096
> > >>>>> [  279.898481] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452873728 length 4096
> > >>>>> [  279.898515] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365555539132416 length 4096
> > >>>>> [  279.898532] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365555539197952 length 4096
> > >>>>> [  279.898548] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365555539181568 length 4096
> > >>>>> [  279.906703] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452218368 length 4096
> > >>>>> [  279.906722] BTRFS critical (device sdb): unable to find logical
> > >>>>> 365541452218368 length 16384
> > >>>>> [  279.906737] BTRFS error (device sdb): failed to read chunk tree: -22
> > >>>>> [  279.938495] BTRFS error (device sdb): open_ctree failed
> > >>>>>
> > >>>>> btrfs check output:
> > >>>>> root@server:~# btrfs check /dev/sdb
> > >>>>> Opening filesystem to check...
> > >>>>> No mapping for 365541452218368-365541452234752
> > >>>>> Couldn't map the block 365541452218368
> > >>>>> Couldn't map the block 365541452218368
> > >>>>> bad tree block 365541452218368, bytenr mismatch, want=365541452218368, have=0
> > >>>>> Couldn't read chunk tree
> > >>>>> ERROR: cannot open file system
> > >>>>
> > >>>> This means your system chunk array in your super block is not containing
> > >>>> the correct system chunk mapping.
> > >>>>
> > >>>> Thus btrfs is unable to read chunk tree at bootstrap.
> > >>>>
> > >>>> Since you have nothing to lose, you may want to try "btrfs rescue
> > >>>> chunk-recover".
> > >>>>
> > >>>> Thanks,
> > >>>> Qu
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>> uname -a: Linux server 5.19.0-26-generic #27-Ubuntu SMP
> > >>>>> PREEMPT_DYNAMIC Wed Nov 23 20:44:15 UTC 2022 x86_64 x86_64 x86_64
> > >>>>> GNU/Linux
> > >>>>>
> > >>>>> btrfs --version: btrfs-progs v5.19
> > >>>>>
> > >>>>> Full dmesg log is attached (gzipped).
> > >>>>>
> > >>>>> Thanks for your help!
