Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163C2653129
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 13:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiLUM6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 07:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLUM6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 07:58:02 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676322BEF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:58:00 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id d9-20020a4aa589000000b004af737509f4so1555245oom.11
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Lm/hzOlYcO4oml2aoMojogc2I71pJz8j7H69IkANPA=;
        b=UFrbNJRvZhOjMzrl60t9eqH1AuDid7nnLuVY4XuHefSxTv7HYlsAKCx0P7yVxa0z2n
         RwrsL4tt6NkJagKj+btAUrdAGfp5VaqPzO9uFlQBbZt14Hwm914NbJ6ubP9EPzkDplia
         7Q6PX6GHVpBFop/iseNsmH4JBWMwxegjcD/q2aJjCI5bN9LHyv/la4npgHtV8KyGcYv9
         tEVSt2V9e3ikZXi1SjnSpJ1rzpHRKyiMNYbbyScyXo1vp9Wf0G1vSWkAkdxWOSOM34VW
         +kw0FYTLlRLUzGx+BA1TLr90b3pVVqfL8higddL9euHegUiTnUgCk8S61veFSi8Fh32f
         yAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Lm/hzOlYcO4oml2aoMojogc2I71pJz8j7H69IkANPA=;
        b=FGus93ETGUYl5EDUHozsRzwrd66m2hj5YN2VDdequ/2BcbsqjBty7DInEQ3/RYuEEh
         XBjFmIHuxEydlRCEjOdSaC7rlhxfRNOnYOG4t1QJTZ1X4DbR4sb0rFMi1jsF7l44HkcX
         E/LK10XiZsSxYLUQx2emFIdD2UAf8WecBp6MGqf6FIAV2450vkCp7XIfo5mMH+HQZDe1
         LJAv7o86VtWxU/uo8HvMFgvXWbQ2+7D+sWoHj+78BoF+7YXYUk7ytcAYC2xNAMFbW+eO
         H76Dyk3wDJcRkYUBvb+/kYf1O7JAUyxAwbwYh3mMhclIA2/DLvukGX9unY4yfxC28Eo2
         Ngtg==
X-Gm-Message-State: AFqh2kqjVrV3xu3yW5JSsC3QtGcA0MR99zb4+61HOgdyGioqhnG8svV8
        nRp7EmWlxjlsdMGCY+uCNXVnDYed1EfZfZ6X5/9dSVPWTRBCo6ENF3c=
X-Google-Smtp-Source: AMrXdXtgU2T1RPu2nttrzeGzMiLgQU6bIOiw9s0a654ULjewXVERxk/8IxU6H6LLpw2by4B5J//bYLzoaZtTcScMYSY=
X-Received: by 2002:a4a:9705:0:b0:4a3:e8f6:9df1 with SMTP id
 u5-20020a4a9705000000b004a3e8f69df1mr81377ooi.89.1671627479431; Wed, 21 Dec
 2022 04:57:59 -0800 (PST)
MIME-Version: 1.0
References: <CACyAFTK61Ncek=WwYwvWKvN6_fECnALTzFcwqQHZKSDP3u_D0g@mail.gmail.com>
 <57310cd8-16b8-9918-42f5-efda114a944d@gmx.com> <CACyAFTLY4_xtgJjCXKK6JTcjAhXpWYhnnALndTLehT3=NQ8+AA@mail.gmail.com>
 <e15df0f8-72da-2c73-e3af-062c05001f95@gmx.com>
In-Reply-To: <e15df0f8-72da-2c73-e3af-062c05001f95@gmx.com>
From:   Colin Stark <stark.colin@gmail.com>
Date:   Wed, 21 Dec 2022 13:57:22 +0100
Message-ID: <CACyAFTJxWDV0NpRrMTtrB9XQqZj+kyi=jejRd63zVAWCoqSSow@mail.gmail.com>
Subject: Re: BTRFS volume unmountable: open_ctree failed
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001c641205f0561a37"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0000000000001c641205f0561a37
Content-Type: text/plain; charset="UTF-8"

dump-super output is attached.

I also realize I never provided btrfs fi show output:
Label: 'data'  uuid: 2296d823-e45e-4f54-a053-0baa1531e73c
        Total devices 10 FS bytes used 54.87TiB
        devid    1 size 7.28TiB used 7.28TiB path /dev/sdb
        devid    2 size 7.28TiB used 7.28TiB path /dev/sdc
        devid    3 size 16.37TiB used 8.00TiB path /dev/sdd
        devid    5 size 7.28TiB used 7.28TiB path /dev/sdi
        devid    6 size 16.37TiB used 8.00TiB path /dev/sdf
        devid    7 size 16.37TiB used 8.00TiB path /dev/sde
        devid    8 size 7.28TiB used 7.28TiB path /dev/sda
        devid    9 size 7.28TiB used 7.28TiB path /dev/sdh
        devid   10 size 5.46TiB used 5.46TiB path /dev/sdk
        devid   11 size 5.46TiB used 5.46TiB path /dev/sdj

On Wed, Dec 21, 2022 at 1:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/12/21 20:36, Colin Stark wrote:
> > Unfortunately no luck here.  The command crashes after running for
> > about 30 minutes.
> >
> > I tried to get a backtrace for the issue, but I think something is
> > missing from my setup.  Please advise if you'd like me to try again to
> > get a full backtrace.  I also found this open issue from 2018 that
> > appears to be similar, though no progress appears to have been made:
> > https://github.com/kdave/btrfs-progs/issues/130
> >
> > That aside, do I have any options left for trying to salvage this volume?
>
> OK, that BUG_ON() is mostly related to RAID6 (which its number of copies
> can be the number of stripes, thus exceeding the MAX_MIRRORS).
>
> But I doubt even if it works, chunk-recovery may not be the best
> solution for your case.
> (Which looks like a missing system chunk item).
>
> Mind to provide the following output?
>
>   # btrfs ins dump-super -f <device>
>
> You only need to run it on any of the array.
>
> Thanks,
> Qu
>
> >
> > Thanks for your help.
> >
> > Output:
> > root@server:~/btrfs-progs# LD_LIBRARY_PATH=. gdb ./btrfs # rescue
> > chunk-recover -v /dev/sdb
> > GNU gdb (Ubuntu 12.1-3ubuntu2) 12.1
> > Copyright (C) 2022 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> > Type "show copying" and "show warranty" for details.
> > This GDB was configured as "x86_64-linux-gnu".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <https://www.gnu.org/software/gdb/bugs/>.
> > Find the GDB manual and other documentation resources online at:
> >      <http://www.gnu.org/software/gdb/documentation/>.
> >
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from ./btrfs...
> > (gdb) run rescue chunk-recover -v /dev/sdb
> > Starting program: /root/btrfs-progs/btrfs rescue chunk-recover -v /dev/sdb
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > All Devices:
> >          Device: id = 9, name = /dev/sdh
> >          Device: id = 11, name = /dev/sdj
> >          Device: id = 8, name = /dev/sda
> >          Device: id = 2, name = /dev/sdc
> >          Device: id = 7, name = /dev/sde
> >          Device: id = 5, name = /dev/sdi
> >          Device: id = 10, name = /dev/sdk
> >          Device: id = 3, name = /dev/sdd
> >          Device: id = 6, name = /dev/sdf
> >          Device: id = 1, name = /dev/sdb
> >
> > [New Thread 0x7ffff7c516c0 (LWP 17845)]
> > [New Thread 0x7ffff74506c0 (LWP 17846)]
> > [New Thread 0x7ffff6c4f6c0 (LWP 17847)]
> > [New Thread 0x7ffff644e6c0 (LWP 17848)]
> > [New Thread 0x7ffff5c4d6c0 (LWP 17849)]
> > [New Thread 0x7ffff544c6c0 (LWP 17850)]
> > [New Thread 0x7ffff4c4b6c0 (LWP 17851)]
> > [New Thread 0x7fffdbfff6c0 (LWP 17852)]
> > [New Thread 0x7fffd3fff6c0 (LWP 17853)]
> > [New Thread 0x7fffdb7fe6c0 (LWP 17854)]
> > Scanning: 61882368 in dev0, 60243968 in dev1, 189743104 in dev2,
> > 210714624 in dev3, 233652224 in dev4, 63459328 in dev5, 62996480 in
> > dev6, 225656832 in dev7,Scanning: 120668160 in dev0, 119750656 in
> > dev1, 381763584 in dev2, 424230912 in dev3, 465911808 in dev4,
> > 122241024 in dev5, 122372096 in dev6, 457916416 in dScanning:
> > 179650560 in dev0, 179388416 in dev1, 573784064 in dev2, 636993536 in
> > dev3, 699875328 in dev4, 181223424 in dev5, 181747712 in dev6,
> > 691879936 in dScanning: 239681536 in dev0, 240205824 in dev1,
> > 765673472 in dev2, 850477056 in dev3, 938033152 in dev4, 241254400 in
> > dev5, 242565120 in dev6, 929906688 in dScanning: 298926080 in dev0,
> > 299974656 in dev1, 957693952 in dev2, 1066352640 in dev3, 1171996672
> > in dev4, 300498944 in dev5, 302333952 in dev6, 1164001280 iScanning:
> > 358432768 in dev0, 360136704 in dev1, 1149583360 in dev2, 1284718592
> > in dev3, 1407184896 in dev4, 360005632 in dev5, 362496000 in dev6,
> > 1399275520 Scanning: 417808384 in dev0, 420167680 in dev1, 1341341696
> > in dev2, 1503084544 in dev3, 1642545152 in dev4, 419381248 in dev5,
> > 422526976 in dev6, 1634549760 Scanning: 477052928 in dev0, 480067584
> > in dev1, 1533362176 in dev2, 1721581568 in dev3, 1877164032 in dev4,
> > 478625792 in dev5, 482689024 in dev6, 1869430784 Scanning: 540360704
> > in dev0, 544161792 in dev1, 1720954880 in dev2, 1936539648 in dev3,
> > 2127773696 in dev4, 541933568 in dev5, 546783232 in dev6, 2119962624
> > Scanning: 601833472 in dev0, 606158848 in dev1, 1913077760 in dev2,
> > 2152284160 in dev3, 2369732608 in dev4, 603144192 in dev5, 608649216
> > in dev6, 2361999360 Scanning: 660553728 in dev0, 668942336 in dev1,
> > 2103001088 in dev2, 2365538304 in dev3, 2603827200 in dev4, 658980864
> > in dev5, 671039488 in dev6, 2596093952 Scanning: 720453632 in dev0,
> > 729366528 in dev1, 2294759424 in dev2, 2581020672 in dev3, 2840412160
> > in dev4, 718618624 in dev5, 731332608 in dev6, 2832809984 Scanning:
> > 781139968 in dev0, 790839296 in dev1, 2485731328 in dev2, 2793226240
> > in dev3, 3080011776 in dev4, 778911744 in dev5, 792674304 in dev6,
> > 3072663552 Scanning: 841957376 in dev0, 852443136 in dev1, 2677620736
> > in dev2, 2998222848 in dev3, 3321446400 in dev4, 839860224 in dev5,
> > 854409216 in dev6, 3314106368 Scanning: 901111808 in dev0, 914309120
> > in dev1, 2869116928 in dev2, 3212021760 in dev3, 3562618880 in dev4,
> > 882102272 in dev5, 916275200 in dev6, 3555540992 Scanning: 960577536
> > in dev0, 975912960 in dev1, 3061137408 in dev2, 3426304000 in dev3,
> > 3800121344 in dev4, 931741696 in dev5, 978272256 in dev6, 3793174528
> > Scanning: 1020739584 in dev0, 1036730368 in dev1, 3253157888 in dev2,
> > 3640606720 in dev3, 4039196672 in dev4, 989675520 in dev5, 1039220736
> > in dev6, 40321187Scanning: 1080246272 in dev0, 1097023488 in dev1,
> > 3445178368 in dev2, 3862511616 in dev3, 4274864128 in dev4, 1049051136
> > in dev5, 1099251712 in dev6, 4268048Scanning: 1142636544 in dev0,
> > 1160200192 in dev1, 3636936704 in dev2, 4082581504 in dev3, 4522102784
> > in dev4, 1110654976 in dev5, 1162432512 in dev6, 4515512Scanning:
> > 1204371456 in dev0, 1223245824 in dev1, 3828957184 in dev2, 4304617472
> > in dev3, 4767301632 in dev4, 1171210240 in dev5, 1225342976 in dev6,
> > 4742135Scanning: 1270824960 in dev0, 1285111808 in dev1, 4020977664 in
> > dev2, 4520361984 in dev3, 5010178048 in dev4, 1226653696 in dev5,
> > 1287340032 in dev6, 4965351Scanning: 1333739520 in dev0, 1349337088 in
> > dev1, 4212998144 in dev2, 4724572160 in dev3, 5260525568 in dev4,
> > 1285898240 in dev5, 1351565312 in dev6, 5176901Scanning: 1394425856 in
> > dev0, 1410809856 in dev1, 4404887552 in dev2, 4930093056 in dev3,
> > 5501173760 in dev4, 1346715648 in dev5, 1412907008 in dev6,
> > 5417811Scanning: 1454981120 in dev0, 1472806912 in dev1, 4596908032 in
> > dev2, 5131419648 in dev3, 5743656960 in dev4, 1400848384 in dev5,
> > 1475166208 in dev6, 5660426Scanning: 1513832448 in dev0, 1534017536 in
> > dev1, 4788928512 in dev2, 5336141824 in dev3, 5982208000 in dev4,
> > 1451835392 in dev5, 1536376832 in dev6, 5899108Scanning: 1573076992 in
> > dev0, 1594310656 in dev1, 4980948992 in dev2, 5555306496 in dev3,
> > 6215778304 in dev4, 1510948864 in dev5, 1596538880 in dev6,
> > 6132809Scanning: 1632845824 in dev0, 1655259136 in dev1, 5172707328 in
> > dev2, 5772787712 in dev3, 6453149696 in dev4, 1556561920 in dev5,
> > 1656963072 in dev6, 6370181Scanning: 1692483584 in dev0, 1716207616 in
> > dev1, 5364727808 in dev2, 5992431616 in dev3, 6691438592 in dev4,
> > 1615413248 in dev5, 1717780480 in dev6, 6608470Scanning: 1754218496 in
> > dev0, 1779253248 in dev1, 5556748288 in dev2, 6206078976 in dev3,
> > 6937591808 in dev4, 1673478144 in dev5, 1780826112 in dev6,
> > 6854885Scanning: 1816739840 in dev0, 1841905664 in dev1, 5748375552 in
> > dev2, 6416449536 in dev3, 7183745024 in dev4, 1735081984 in dev5,
> > 1843871744 in dev6, 7100776Scanning: 1877164032 in dev0, Scanning:
> > 73366286336 in dev0, 74653970432 in dev1, 221169643520 in dev2,
> > 254365478912 in dev3, 290406514688 in dev4, 69599920128 in dev5,
> > 74645659648 in dev6, 287038144512 in dev7, 290337579008 in dev8,
> > 250395525120 in dev9cmds/rescue-chunk-recover.c:128:
> > process_extent_buffer: BUG_ON `exist->nmirrors >= BTRFS_MAX_MIRRORS`
> > triggered, value 1
> > Scanning: 73438507008 in dev0, 74729336832 in dev1, 221191864320 in
> > dev2, 254573060096 in dev3, 290685366272 in dev4, 69651824640 in dev5,
> > 74721157120 in dev6, 287322771456 in dev7, 290621480960 in dev8,
> > 250598162432 in dev9/root/btrfs-progs/btrfs(+0x8d401)[0x5555555e1401]
> > /root/btrfs-progs/btrfs(+0x8eb63)[0x5555555e2b63]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x90402)[0x7ffff7ce4402]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x11f590)[0x7ffff7d73590]
> > Scanning: 73513611264 in dev0, 74807717888 in dev1, 221191864320 in
> > dev2, 254781857792 in dev3, 290964881408 in dev4, 69718147072 in dev5,
> > 74795343872 in dev6, 287621267456 in dev7, 290919407616 in dev8,
> > 250810761216 in dev9             Thread 4 "btrfs" received signal
> > SIGABRT, Aborted.
> > [Switching to Thread 0x7ffff6c4f6c0 (LWP 17847)]
> > __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized
> > out>) at ./nptl/pthread_kill.c:44
> > 44      ./nptl/pthread_kill.c: No such file or directory.
> >
> > On Wed, Dec 21, 2022 at 2:34 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/12/21 01:35, Colin Stark wrote:
> >>> Hi all,
> >>>
> >>> After upgrading my server from Ubuntu 22.04 to 22.10 (kernel 5.15 to
> >>> 5.19), I am no longer able to mount my BTRFS volume.  I tried booting
> >>> from an Ubuntu 22.04 live USB but the results are the same - something
> >>> seems to have damaged the volume during the upgrade, although it could
> >>> just be coincidental.
> >>>
> >>> This seems to be quite a serious error as btrfs check barely even
> >>> runs.  The volume is RAID6 spread across 10 devices.  AFAIK, all of
> >>> the drives are in good working condition.
> >>>
> >>> I'm hoping someone here is able to assist with repairing the filesystem.
> >>>
> >>> dmesg shows the following errors:
> >>> [  279.889337] BTRFS info (device sdb): using free space tree
> >>> [  279.889341] BTRFS info (device sdb): has skinny extents
> >>> [  279.896776] BTRFS critical (device sdb): unable to find logical
> >>> 365541452218368 length 4096
> >>> [  279.897009] BTRFS critical (device sdb): unable to find logical
> >>> 365541452201984 length 4096
> >>> [  279.897037] BTRFS critical (device sdb): unable to find logical
> >>> 365541452185600 length 4096
> >>> [  279.897072] BTRFS critical (device sdb): unable to find logical
> >>> 365541452251136 length 4096
> >>> [  279.897097] BTRFS critical (device sdb): unable to find logical
> >>> 365541452316672 length 4096
> >>> [  279.897113] BTRFS critical (device sdb): unable to find logical
> >>> 365541452349440 length 4096
> >>> [  279.897128] BTRFS critical (device sdb): unable to find logical
> >>> 365541452300288 length 4096
> >>> [  279.897144] BTRFS critical (device sdb): unable to find logical
> >>> 365541452267520 length 4096
> >>> [  279.897159] BTRFS critical (device sdb): unable to find logical
> >>> 365541452283904 length 4096
> >>> [  279.897175] BTRFS critical (device sdb): unable to find logical
> >>> 365541452365824 length 4096
> >>> [  279.897190] BTRFS critical (device sdb): unable to find logical
> >>> 365541452333056 length 4096
> >>> [  279.897207] BTRFS critical (device sdb): unable to find logical
> >>> 365541452431360 length 4096
> >>> [  279.897224] BTRFS critical (device sdb): unable to find logical
> >>> 365555539099648 length 4096
> >>> [  279.897239] BTRFS critical (device sdb): unable to find logical
> >>> 365541452447744 length 4096
> >>> [  279.897254] BTRFS critical (device sdb): unable to find logical
> >>> 365541452382208 length 4096
> >>> [  279.897415] BTRFS critical (device sdb): unable to find logical
> >>> 365541452152832 length 4096
> >>> [  279.897719] BTRFS critical (device sdb): unable to find logical
> >>> 365541452234752 length 4096
> >>> [  279.897938] BTRFS critical (device sdb): unable to find logical
> >>> 365541452398592 length 4096
> >>> [  279.897957] BTRFS critical (device sdb): unable to find logical
> >>> 365541452169216 length 4096
> >>> [  279.897973] BTRFS critical (device sdb): unable to find logical
> >>> 365541452414976 length 4096
> >>> [  279.897988] BTRFS critical (device sdb): unable to find logical
> >>> 365541452464128 length 4096
> >>> [  279.898004] BTRFS critical (device sdb): unable to find logical
> >>> 365541452496896 length 4096
> >>> [  279.898020] BTRFS critical (device sdb): unable to find logical
> >>> 365541452480512 length 4096
> >>> [  279.898035] BTRFS critical (device sdb): unable to find logical
> >>> 365541452513280 length 4096
> >>> [  279.898050] BTRFS critical (device sdb): unable to find logical
> >>> 365541452546048 length 4096
> >>> [  279.898065] BTRFS critical (device sdb): unable to find logical
> >>> 365541452562432 length 4096
> >>> [  279.898081] BTRFS critical (device sdb): unable to find logical
> >>> 365541452578816 length 4096
> >>> [  279.898096] BTRFS critical (device sdb): unable to find logical
> >>> 365541452595200 length 4096
> >>> [  279.898112] BTRFS critical (device sdb): unable to find logical
> >>> 365541452611584 length 4096
> >>> [  279.898127] BTRFS critical (device sdb): unable to find logical
> >>> 365541452529664 length 4096
> >>> [  279.898144] BTRFS critical (device sdb): unable to find logical
> >>> 365541452627968 length 4096
> >>> [  279.898159] BTRFS critical (device sdb): unable to find logical
> >>> 365541452644352 length 4096
> >>> [  279.898175] BTRFS critical (device sdb): unable to find logical
> >>> 365541452660736 length 4096
> >>> [  279.898192] BTRFS critical (device sdb): unable to find logical
> >>> 365541452677120 length 4096
> >>> [  279.898208] BTRFS critical (device sdb): unable to find logical
> >>> 365541452693504 length 4096
> >>> [  279.898223] BTRFS critical (device sdb): unable to find logical
> >>> 365541452709888 length 4096
> >>> [  279.898239] BTRFS critical (device sdb): unable to find logical
> >>> 365541452726272 length 4096
> >>> [  279.898257] BTRFS critical (device sdb): unable to find logical
> >>> 365541452759040 length 4096
> >>> [  279.898273] BTRFS critical (device sdb): unable to find logical
> >>> 365541452742656 length 4096
> >>> [  279.898296] BTRFS critical (device sdb): unable to find logical
> >>> 365541452775424 length 4096
> >>> [  279.898322] BTRFS critical (device sdb): unable to find logical
> >>> 365541452857344 length 4096
> >>> [  279.898339] BTRFS critical (device sdb): unable to find logical
> >>> 365541452890112 length 4096
> >>> [  279.898354] BTRFS critical (device sdb): unable to find logical
> >>> 365541452824576 length 4096
> >>> [  279.898370] BTRFS critical (device sdb): unable to find logical
> >>> 365541452808192 length 4096
> >>> [  279.898385] BTRFS critical (device sdb): unable to find logical
> >>> 365541452922880 length 4096
> >>> [  279.898400] BTRFS critical (device sdb): unable to find logical
> >>> 365541452840960 length 4096
> >>> [  279.898432] BTRFS critical (device sdb): unable to find logical
> >>> 365541452906496 length 4096
> >>> [  279.898449] BTRFS critical (device sdb): unable to find logical
> >>> 365541452791808 length 4096
> >>> [  279.898481] BTRFS critical (device sdb): unable to find logical
> >>> 365541452873728 length 4096
> >>> [  279.898515] BTRFS critical (device sdb): unable to find logical
> >>> 365555539132416 length 4096
> >>> [  279.898532] BTRFS critical (device sdb): unable to find logical
> >>> 365555539197952 length 4096
> >>> [  279.898548] BTRFS critical (device sdb): unable to find logical
> >>> 365555539181568 length 4096
> >>> [  279.906703] BTRFS critical (device sdb): unable to find logical
> >>> 365541452218368 length 4096
> >>> [  279.906722] BTRFS critical (device sdb): unable to find logical
> >>> 365541452218368 length 16384
> >>> [  279.906737] BTRFS error (device sdb): failed to read chunk tree: -22
> >>> [  279.938495] BTRFS error (device sdb): open_ctree failed
> >>>
> >>> btrfs check output:
> >>> root@server:~# btrfs check /dev/sdb
> >>> Opening filesystem to check...
> >>> No mapping for 365541452218368-365541452234752
> >>> Couldn't map the block 365541452218368
> >>> Couldn't map the block 365541452218368
> >>> bad tree block 365541452218368, bytenr mismatch, want=365541452218368, have=0
> >>> Couldn't read chunk tree
> >>> ERROR: cannot open file system
> >>
> >> This means your system chunk array in your super block is not containing
> >> the correct system chunk mapping.
> >>
> >> Thus btrfs is unable to read chunk tree at bootstrap.
> >>
> >> Since you have nothing to lose, you may want to try "btrfs rescue
> >> chunk-recover".
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>
> >>>
> >>> uname -a: Linux server 5.19.0-26-generic #27-Ubuntu SMP
> >>> PREEMPT_DYNAMIC Wed Nov 23 20:44:15 UTC 2022 x86_64 x86_64 x86_64
> >>> GNU/Linux
> >>>
> >>> btrfs --version: btrfs-progs v5.19
> >>>
> >>> Full dmesg log is attached (gzipped).
> >>>
> >>> Thanks for your help!

--0000000000001c641205f0561a37
Content-Type: application/octet-stream; name="dump-super.log"
Content-Disposition: attachment; filename="dump-super.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lbxnsdum0>
X-Attachment-Id: f_lbxnsdum0

c3VwZXJibG9jazogYnl0ZW5yPTY1NTM2LCBkZXZpY2U9L2Rldi9zZGIKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmNzdW1fdHlwZQkJMCAo
Y3JjMzJjKQpjc3VtX3NpemUJCTQKY3N1bQkJCTB4ZGUxODc4MDMgW21hdGNoXQpieXRlbnIJCQk2
NTUzNgpmbGFncwkJCTB4MQoJCQkoIFdSSVRURU4gKQptYWdpYwkJCV9CSFJmU19NIFttYXRjaF0K
ZnNpZAkJCTIyOTZkODIzLWU0NWUtNGY1NC1hMDUzLTBiYWExNTMxZTczYwptZXRhZGF0YV91dWlk
CQkyMjk2ZDgyMy1lNDVlLTRmNTQtYTA1My0wYmFhMTUzMWU3M2MKbGFiZWwJCQlkYXRhCmdlbmVy
YXRpb24JCTEzMjgwMTMKcm9vdAkJCTMxOTUwNzczNDU5MzUzNgpzeXNfYXJyYXlfc2l6ZQkJMTcz
NwpjaHVua19yb290X2dlbmVyYXRpb24JMTMyODAxMwpyb290X2xldmVsCQkwCmNodW5rX3Jvb3QJ
CTM2NTU0MTQ0OTY2MjQ2NApjaHVua19yb290X2xldmVsCTEKbG9nX3Jvb3QJCTAKbG9nX3Jvb3Rf
dHJhbnNpZCAoZGVwcmVjYXRlZCkJMApsb2dfcm9vdF9sZXZlbAkJMAp0b3RhbF9ieXRlcwkJMTA2
MDEwNzkwMTc0NzIwCmJ5dGVzX3VzZWQJCTYwMzI2MTEyMDEwMjQwCnNlY3RvcnNpemUJCTQwOTYK
bm9kZXNpemUJCTE2Mzg0CmxlYWZzaXplIChkZXByZWNhdGVkKQkxNjM4NApzdHJpcGVzaXplCQk0
MDk2CnJvb3RfZGlyCQk2Cm51bV9kZXZpY2VzCQkxMApjb21wYXRfZmxhZ3MJCTB4MApjb21wYXRf
cm9fZmxhZ3MJCTB4MwoJCQkoIEZSRUVfU1BBQ0VfVFJFRSB8CgkJCSAgRlJFRV9TUEFDRV9UUkVF
X1ZBTElEICkKaW5jb21wYXRfZmxhZ3MJCTB4OWUxCgkJCSggTUlYRURfQkFDS1JFRiB8CgkJCSAg
QklHX01FVEFEQVRBIHwKCQkJICBFWFRFTkRFRF9JUkVGIHwKCQkJICBSQUlENTYgfAoJCQkgIFNL
SU5OWV9NRVRBREFUQSB8CgkJCSAgUkFJRDFDMzQgKQpjYWNoZV9nZW5lcmF0aW9uCTAKdXVpZF90
cmVlX2dlbmVyYXRpb24JMTMyODAxMwpibG9ja19ncm91cF9yb290CTAKYmxvY2tfZ3JvdXBfcm9v
dF9nZW5lcmF0aW9uCTAKYmxvY2tfZ3JvdXBfcm9vdF9sZXZlbAkwCmRldl9pdGVtLnV1aWQJCWY2
MjQ4OWU0LTU5OTMtNDI0Mi1iNTY3LTIzY2ZhN2JiOTY3NwpkZXZfaXRlbS5mc2lkCQkyMjk2ZDgy
My1lNDVlLTRmNTQtYTA1My0wYmFhMTUzMWU3M2MgW21hdGNoXQpkZXZfaXRlbS50eXBlCQkwCmRl
dl9pdGVtLnRvdGFsX2J5dGVzCTgwMDE1NjMyMjIwMTYKZGV2X2l0ZW0uYnl0ZXNfdXNlZAk4MDAx
NTYyMTQ4ODY0CmRldl9pdGVtLmlvX2FsaWduCTQwOTYKZGV2X2l0ZW0uaW9fd2lkdGgJNDA5Ngpk
ZXZfaXRlbS5zZWN0b3Jfc2l6ZQk0MDk2CmRldl9pdGVtLmRldmlkCQkxCmRldl9pdGVtLmRldl9n
cm91cAkwCmRldl9pdGVtLnNlZWtfc3BlZWQJMApkZXZfaXRlbS5iYW5kd2lkdGgJMApkZXZfaXRl
bS5nZW5lcmF0aW9uCTAKc3lzX2NodW5rX2FycmF5WzIwNDhdOgoJaXRlbSAwIGtleSAoRklSU1Rf
Q0hVTktfVFJFRSBDSFVOS19JVEVNIDM2NTU0MTQ0OTY2MjQ2NCkKCQlsZW5ndGggMTMxMDcyIG93
bmVyIDIgc3RyaXBlX2xlbiA2NTUzNiB0eXBlIFNZU1RFTXxSQUlEMUM0CgkJaW9fYWxpZ24gNjU1
MzYgaW9fd2lkdGggNjU1MzYgc2VjdG9yX3NpemUgNDA5NgoJCW51bV9zdHJpcGVzIDQgc3ViX3N0
cmlwZXMgMQoJCQlzdHJpcGUgMCBkZXZpZCAzIG9mZnNldCAxMDc0NzkwNDAwCgkJCWRldl91dWlk
IDUyMTlmZmZiLTg0N2EtNDMyMy1hMzE2LTdlZWU0YjY0NmY2NwoJCQlzdHJpcGUgMSBkZXZpZCA3
IG9mZnNldCA1MTU0MDY1NjEyOAoJCQlkZXZfdXVpZCA3ODQyMmJhZi1mOTg2LTQyZmMtOTgzYi1k
YzI4ZjgyODc0YWMKCQkJc3RyaXBlIDIgZGV2aWQgNiBvZmZzZXQgMTA3NDc5MDQwMAoJCQlkZXZf
dXVpZCAzOWZmNjAzYi04NWY4LTRjZWEtYTMxOC02MDBlNDU5ZDFhY2EKCQkJc3RyaXBlIDMgZGV2
aWQgNSBvZmZzZXQgNTQ1MDE1OTc1MTE2OAoJCQlkZXZfdXVpZCAxYzI0Nzc5Yy1jMjMzLTRkNTIt
OGU2MS05OTY2MWFiMzFjY2UKCWl0ZW0gMSBrZXkgKEZJUlNUX0NIVU5LX1RSRUUgQ0hVTktfSVRF
TSAzNjU1NDE0NDk3OTM1MzYpCgkJbGVuZ3RoIDEzMTA3MiBvd25lciAyIHN0cmlwZV9sZW4gNjU1
MzYgdHlwZSBTWVNURU18UkFJRDFDNAoJCWlvX2FsaWduIDY1NTM2IGlvX3dpZHRoIDY1NTM2IHNl
Y3Rvcl9zaXplIDQwOTYKCQludW1fc3RyaXBlcyA0IHN1Yl9zdHJpcGVzIDEKCQkJc3RyaXBlIDAg
ZGV2aWQgMyBvZmZzZXQgMTA3NDkyMTQ3MgoJCQlkZXZfdXVpZCA1MjE5ZmZmYi04NDdhLTQzMjMt
YTMxNi03ZWVlNGI2NDZmNjcKCQkJc3RyaXBlIDEgZGV2aWQgNiBvZmZzZXQgMTA3NDkyMTQ3MgoJ
CQlkZXZfdXVpZCAzOWZmNjAzYi04NWY4LTRjZWEtYTMxOC02MDBlNDU5ZDFhY2EKCQkJc3RyaXBl
IDIgZGV2aWQgNyBvZmZzZXQgNTE1NDA3ODcyMDAKCQkJZGV2X3V1aWQgNzg0MjJiYWYtZjk4Ni00
MmZjLTk4M2ItZGMyOGY4Mjg3NGFjCgkJCXN0cmlwZSAzIGRldmlkIDggb2Zmc2V0IDY4MjM3Nzcw
NzUyMDAKCQkJZGV2X3V1aWQgYmE3NTVmYzQtNGM3Zi00MjJhLWE2NTUtYjY0MzY3MmMyZDRhCglp
dGVtIDIga2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gMzY1NTQxNDQ5OTI0NjA4KQoJ
CWxlbmd0aCAxMzEwNzIgb3duZXIgMiBzdHJpcGVfbGVuIDY1NTM2IHR5cGUgU1lTVEVNfFJBSUQx
QzQKCQlpb19hbGlnbiA2NTUzNiBpb193aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSA0MDk2CgkJbnVt
X3N0cmlwZXMgNCBzdWJfc3RyaXBlcyAxCgkJCXN0cmlwZSAwIGRldmlkIDMgb2Zmc2V0IDEwNzUw
NTI1NDQKCQkJZGV2X3V1aWQgNTIxOWZmZmItODQ3YS00MzIzLWEzMTYtN2VlZTRiNjQ2ZjY3CgkJ
CXN0cmlwZSAxIGRldmlkIDYgb2Zmc2V0IDEwNzUwNTI1NDQKCQkJZGV2X3V1aWQgMzlmZjYwM2It
ODVmOC00Y2VhLWEzMTgtNjAwZTQ1OWQxYWNhCgkJCXN0cmlwZSAyIGRldmlkIDcgb2Zmc2V0IDUx
NTQwOTE4MjcyCgkJCWRldl91dWlkIDc4NDIyYmFmLWY5ODYtNDJmYy05ODNiLWRjMjhmODI4NzRh
YwoJCQlzdHJpcGUgMyBkZXZpZCAyIG9mZnNldCA3ODcxNDAxNjg5MDg4CgkJCWRldl91dWlkIDM5
Y2QxYTMxLTQwMjgtNGU4Ni04M2EyLWU1NDE5YzdhY2I5YwoJaXRlbSAzIGtleSAoRklSU1RfQ0hV
TktfVFJFRSBDSFVOS19JVEVNIDM2NTU0MTQ1MDA1NTY4MCkKCQlsZW5ndGggMzI3NjgwIG93bmVy
IDIgc3RyaXBlX2xlbiA2NTUzNiB0eXBlIFNZU1RFTXxSQUlEMUM0CgkJaW9fYWxpZ24gNjU1MzYg
aW9fd2lkdGggNjU1MzYgc2VjdG9yX3NpemUgNDA5NgoJCW51bV9zdHJpcGVzIDQgc3ViX3N0cmlw
ZXMgMQoJCQlzdHJpcGUgMCBkZXZpZCA2IG9mZnNldCAxMDc1MTgzNjE2CgkJCWRldl91dWlkIDM5
ZmY2MDNiLTg1ZjgtNGNlYS1hMzE4LTYwMGU0NTlkMWFjYQoJCQlzdHJpcGUgMSBkZXZpZCA3IG9m
ZnNldCA1MTU0MTA0OTM0NAoJCQlkZXZfdXVpZCA3ODQyMmJhZi1mOTg2LTQyZmMtOTgzYi1kYzI4
ZjgyODc0YWMKCQkJc3RyaXBlIDIgZGV2aWQgMyBvZmZzZXQgMTA3NTE4MzYxNgoJCQlkZXZfdXVp
ZCA1MjE5ZmZmYi04NDdhLTQzMjMtYTMxNi03ZWVlNGI2NDZmNjcKCQkJc3RyaXBlIDMgZGV2aWQg
NSBvZmZzZXQgNjUzMDkzMjkzMjYwOAoJCQlkZXZfdXVpZCAxYzI0Nzc5Yy1jMjMzLTRkNTItOGU2
MS05OTY2MWFiMzFjY2UKCWl0ZW0gNCBrZXkgKEZJUlNUX0NIVU5LX1RSRUUgQ0hVTktfSVRFTSAz
NjU1NDE0NTAzODMzNjApCgkJbGVuZ3RoIDM5MzIxNiBvd25lciAyIHN0cmlwZV9sZW4gNjU1MzYg
dHlwZSBTWVNURU18UkFJRDFDNAoJCWlvX2FsaWduIDY1NTM2IGlvX3dpZHRoIDY1NTM2IHNlY3Rv
cl9zaXplIDQwOTYKCQludW1fc3RyaXBlcyA0IHN1Yl9zdHJpcGVzIDEKCQkJc3RyaXBlIDAgZGV2
aWQgNyBvZmZzZXQgNTE1NDEzNzcwMjQKCQkJZGV2X3V1aWQgNzg0MjJiYWYtZjk4Ni00MmZjLTk4
M2ItZGMyOGY4Mjg3NGFjCgkJCXN0cmlwZSAxIGRldmlkIDYgb2Zmc2V0IDEwNzU1MTEyOTYKCQkJ
ZGV2X3V1aWQgMzlmZjYwM2ItODVmOC00Y2VhLWEzMTgtNjAwZTQ1OWQxYWNhCgkJCXN0cmlwZSAy
IGRldmlkIDMgb2Zmc2V0IDEwNzU1MTEyOTYKCQkJZGV2X3V1aWQgNTIxOWZmZmItODQ3YS00MzIz
LWEzMTYtN2VlZTRiNjQ2ZjY3CgkJCXN0cmlwZSAzIGRldmlkIDggb2Zmc2V0IDY1NzU2NjE1ODAy
ODgKCQkJZGV2X3V1aWQgYmE3NTVmYzQtNGM3Zi00MjJhLWE2NTUtYjY0MzY3MmMyZDRhCglpdGVt
IDUga2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gMzY1NTQxNDUwNzc2NTc2KQoJCWxl
bmd0aCAzOTMyMTYgb3duZXIgMiBzdHJpcGVfbGVuIDY1NTM2IHR5cGUgU1lTVEVNfFJBSUQxQzQK
CQlpb19hbGlnbiA2NTUzNiBpb193aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSA0MDk2CgkJbnVtX3N0
cmlwZXMgNCBzdWJfc3RyaXBlcyAxCgkJCXN0cmlwZSAwIGRldmlkIDYgb2Zmc2V0IDEwNzU5MDQ1
MTIKCQkJZGV2X3V1aWQgMzlmZjYwM2ItODVmOC00Y2VhLWEzMTgtNjAwZTQ1OWQxYWNhCgkJCXN0
cmlwZSAxIGRldmlkIDMgb2Zmc2V0IDEwNzU5MDQ1MTIKCQkJZGV2X3V1aWQgNTIxOWZmZmItODQ3
YS00MzIzLWEzMTYtN2VlZTRiNjQ2ZjY3CgkJCXN0cmlwZSAyIGRldmlkIDcgb2Zmc2V0IDUxNTQx
NzcwMjQwCgkJCWRldl91dWlkIDc4NDIyYmFmLWY5ODYtNDJmYy05ODNiLWRjMjhmODI4NzRhYwoJ
CQlzdHJpcGUgMyBkZXZpZCAyIG9mZnNldCA3NzcyNjM1MzMyNjA4CgkJCWRldl91dWlkIDM5Y2Qx
YTMxLTQwMjgtNGU4Ni04M2EyLWU1NDE5YzdhY2I5YwoJaXRlbSA2IGtleSAoRklSU1RfQ0hVTktf
VFJFRSBDSFVOS19JVEVNIDM2NTU0MTQ1MTE2OTc5MikKCQlsZW5ndGggMzkzMjE2IG93bmVyIDIg
c3RyaXBlX2xlbiA2NTUzNiB0eXBlIFNZU1RFTXxSQUlEMUM0CgkJaW9fYWxpZ24gNjU1MzYgaW9f
d2lkdGggNjU1MzYgc2VjdG9yX3NpemUgNDA5NgoJCW51bV9zdHJpcGVzIDQgc3ViX3N0cmlwZXMg
MQoJCQlzdHJpcGUgMCBkZXZpZCA2IG9mZnNldCAxMDc2Mjk3NzI4CgkJCWRldl91dWlkIDM5ZmY2
MDNiLTg1ZjgtNGNlYS1hMzE4LTYwMGU0NTlkMWFjYQoJCQlzdHJpcGUgMSBkZXZpZCA3IG9mZnNl
dCA1MTU0MjE2MzQ1NgoJCQlkZXZfdXVpZCA3ODQyMmJhZi1mOTg2LTQyZmMtOTgzYi1kYzI4Zjgy
ODc0YWMKCQkJc3RyaXBlIDIgZGV2aWQgMyBvZmZzZXQgMTA3NjI5NzcyOAoJCQlkZXZfdXVpZCA1
MjE5ZmZmYi04NDdhLTQzMjMtYTMxNi03ZWVlNGI2NDZmNjcKCQkJc3RyaXBlIDMgZGV2aWQgNSBv
ZmZzZXQgNjc1MDM5NDQ0OTkyMAoJCQlkZXZfdXVpZCAxYzI0Nzc5Yy1jMjMzLTRkNTItOGU2MS05
OTY2MWFiMzFjY2UKCWl0ZW0gNyBrZXkgKEZJUlNUX0NIVU5LX1RSRUUgQ0hVTktfSVRFTSAzNjU1
NDE0NTE1NjMwMDgpCgkJbGVuZ3RoIDMyNzY4MCBvd25lciAyIHN0cmlwZV9sZW4gNjU1MzYgdHlw
ZSBTWVNURU18UkFJRDFDNAoJCWlvX2FsaWduIDY1NTM2IGlvX3dpZHRoIDY1NTM2IHNlY3Rvcl9z
aXplIDQwOTYKCQludW1fc3RyaXBlcyA0IHN1Yl9zdHJpcGVzIDEKCQkJc3RyaXBlIDAgZGV2aWQg
NiBvZmZzZXQgMTA3NjY5MDk0NAoJCQlkZXZfdXVpZCAzOWZmNjAzYi04NWY4LTRjZWEtYTMxOC02
MDBlNDU5ZDFhY2EKCQkJc3RyaXBlIDEgZGV2aWQgNyBvZmZzZXQgNTE1NDI1NTY2NzIKCQkJZGV2
X3V1aWQgNzg0MjJiYWYtZjk4Ni00MmZjLTk4M2ItZGMyOGY4Mjg3NGFjCgkJCXN0cmlwZSAyIGRl
dmlkIDMgb2Zmc2V0IDEwNzY2OTA5NDQKCQkJZGV2X3V1aWQgNTIxOWZmZmItODQ3YS00MzIzLWEz
MTYtN2VlZTRiNjQ2ZjY3CgkJCXN0cmlwZSAzIGRldmlkIDUgb2Zmc2V0IDY2NTcwMjkxMTE4MDgK
CQkJZGV2X3V1aWQgMWMyNDc3OWMtYzIzMy00ZDUyLThlNjEtOTk2NjFhYjMxY2NlCglpdGVtIDgg
a2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gMzY1NTQxNDUxODkwNjg4KQoJCWxlbmd0
aCAyNjIxNDQgb3duZXIgMiBzdHJpcGVfbGVuIDY1NTM2IHR5cGUgU1lTVEVNfFJBSUQxQzQKCQlp
b19hbGlnbiA2NTUzNiBpb193aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSA0MDk2CgkJbnVtX3N0cmlw
ZXMgNCBzdWJfc3RyaXBlcyAxCgkJCXN0cmlwZSAwIGRldmlkIDcgb2Zmc2V0IDUxNTQyODg0MzUy
CgkJCWRldl91dWlkIDc4NDIyYmFmLWY5ODYtNDJmYy05ODNiLWRjMjhmODI4NzRhYwoJCQlzdHJp
cGUgMSBkZXZpZCA2IG9mZnNldCAxMDc3MDE4NjI0CgkJCWRldl91dWlkIDM5ZmY2MDNiLTg1Zjgt
NGNlYS1hMzE4LTYwMGU0NTlkMWFjYQoJCQlzdHJpcGUgMiBkZXZpZCAzIG9mZnNldCAxMDc3MDE4
NjI0CgkJCWRldl91dWlkIDUyMTlmZmZiLTg0N2EtNDMyMy1hMzE2LTdlZWU0YjY0NmY2NwoJCQlz
dHJpcGUgMyBkZXZpZCA4IG9mZnNldCA1MTAwMzIzMjA5MjE2CgkJCWRldl91dWlkIGJhNzU1ZmM0
LTRjN2YtNDIyYS1hNjU1LWI2NDM2NzJjMmQ0YQpiYWNrdXBfcm9vdHNbNF06CgliYWNrdXAgMDoK
CQliYWNrdXBfdHJlZV9yb290OgkzNTg1MTUxMTI5MDI2NTYJZ2VuOiAxMzI4MDEwCWxldmVsOiAw
CgkJYmFja3VwX2NodW5rX3Jvb3Q6CTM2NTU0MTQ0OTY2MjQ2NAlnZW46IDEzMjc5NTkJbGV2ZWw6
IDEKCQliYWNrdXBfZXh0ZW50X3Jvb3Q6CTMxNjkxNTcxMjgwMjgxNglnZW46IDEzMjgwMTAJbGV2
ZWw6IDIKCQliYWNrdXBfZnNfcm9vdDoJCTM1ODUxNTQ1NzYzODQwMAlnZW46IDEzMjgwMTEJbGV2
ZWw6IDIKCQliYWNrdXBfZGV2X3Jvb3Q6CTM2MzIwNzg1NzYxODk0NAlnZW46IDEzMjc5NTkJbGV2
ZWw6IDEKCQljc3VtX3Jvb3Q6CTM1ODUxNTQ2MTAyOTg4OAlnZW46IDEzMjgwMTEJbGV2ZWw6IDMK
CQliYWNrdXBfdG90YWxfYnl0ZXM6CTEwNjAxMDc5MDE3NDcyMAoJCWJhY2t1cF9ieXRlc191c2Vk
Ogk2MDMyMzczMjc4NzIwMAoJCWJhY2t1cF9udW1fZGV2aWNlczoJMTAKCgliYWNrdXAgMToKCQli
YWNrdXBfdHJlZV9yb290OgkzNjQ3MDM4Nzk2NTk1MjAJZ2VuOiAxMzI4MDExCWxldmVsOiAwCgkJ
YmFja3VwX2NodW5rX3Jvb3Q6CTM2NTU1NTUzOTA1MDQ5NglnZW46IDEzMjgwMTEJbGV2ZWw6IDEK
CQliYWNrdXBfZXh0ZW50X3Jvb3Q6CTM1OTgyMzQ0ODU3MTkwNAlnZW46IDEzMjgwMTEJbGV2ZWw6
IDIKCQliYWNrdXBfZnNfcm9vdDoJCTM1ODUxNTQ1NzYzODQwMAlnZW46IDEzMjgwMTEJbGV2ZWw6
IDIKCQliYWNrdXBfZGV2X3Jvb3Q6CTM1OTgyMzQ1NzEwNzk2OAlnZW46IDEzMjgwMTEJbGV2ZWw6
IDEKCQljc3VtX3Jvb3Q6CTM1ODUxNTQ2MTAyOTg4OAlnZW46IDEzMjgwMTEJbGV2ZWw6IDMKCQli
YWNrdXBfdG90YWxfYnl0ZXM6CTEwNjAxMDc5MDE3NDcyMAoJCWJhY2t1cF9ieXRlc191c2VkOgk2
MDMyNDc4NTkyNjE0NAoJCWJhY2t1cF9udW1fZGV2aWNlczoJMTAKCgliYWNrdXAgMjoKCQliYWNr
dXBfdHJlZV9yb290OgkzMTY5MDM4ODQ0MDY3ODQJZ2VuOiAxMzI4MDEyCWxldmVsOiAwCgkJYmFj
a3VwX2NodW5rX3Jvb3Q6CTM2NTU1NTUzOTA1MDQ5NglnZW46IDEzMjgwMTEJbGV2ZWw6IDEKCQli
YWNrdXBfZXh0ZW50X3Jvb3Q6CTM2NDcwNDQ3MTk0MTEyMAlnZW46IDEzMjgwMTIJbGV2ZWw6IDIK
CQliYWNrdXBfZnNfcm9vdDoJCTMxNjkwNDE1NDQ5NzAyNAlnZW46IDEzMjgwMTMJbGV2ZWw6IDIK
CQliYWNrdXBfZGV2X3Jvb3Q6CTM1OTgyMzQ1NzEwNzk2OAlnZW46IDEzMjgwMTEJbGV2ZWw6IDEK
CQljc3VtX3Jvb3Q6CTMxNjkwNDE2MTM5NDY4OAlnZW46IDEzMjgwMTMJbGV2ZWw6IDMKCQliYWNr
dXBfdG90YWxfYnl0ZXM6CTEwNjAxMDc5MDE3NDcyMAoJCWJhY2t1cF9ieXRlc191c2VkOgk2MDMy
NTIyNjcxMzA4OAoJCWJhY2t1cF9udW1fZGV2aWNlczoJMTAKCgliYWNrdXAgMzoKCQliYWNrdXBf
dHJlZV9yb290OgkzMTk1MDc3MzQ1OTM1MzYJZ2VuOiAxMzI4MDEzCWxldmVsOiAwCgkJYmFja3Vw
X2NodW5rX3Jvb3Q6CTM2NTU0MTQ0OTY2MjQ2NAlnZW46IDEzMjgwMTMJbGV2ZWw6IDEKCQliYWNr
dXBfZXh0ZW50X3Jvb3Q6CTMxNjkwNDM4NjY3NDY4OAlnZW46IDEzMjgwMTMJbGV2ZWw6IDIKCQli
YWNrdXBfZnNfcm9vdDoJCTMxOTUwODE4NjMwMDQxNglnZW46IDEzMjgwMTQJbGV2ZWw6IDIKCQli
YWNrdXBfZGV2X3Jvb3Q6CTMxNjkwNDM5MTcwNDU3NglnZW46IDEzMjgwMTMJbGV2ZWw6IDEKCQlj
c3VtX3Jvb3Q6CTMxOTUwODE4OTgwNjU5MglnZW46IDEzMjgwMTQJbGV2ZWw6IDMKCQliYWNrdXBf
dG90YWxfYnl0ZXM6CTEwNjAxMDc5MDE3NDcyMAoJCWJhY2t1cF9ieXRlc191c2VkOgk2MDMyNjEx
MjAxMDI0MAoJCWJhY2t1cF9udW1fZGV2aWNlczoJMTAKCgo=
--0000000000001c641205f0561a37--
