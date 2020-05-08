Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F71CB104
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgEHNws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgEHNwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 09:52:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B82C05BD43
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 06:52:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d25so1462409lfi.11
        for <linux-btrfs@vger.kernel.org>; Fri, 08 May 2020 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eQ0tnAOxHeH12c7Laz+vMB4Qs8XzaNiPDbsYhR2qePs=;
        b=Mlcr7HTfHoGzXu4e8foLMCFOqlhUfc1EaRfJp+3YqQneOd7O8r+BuXH8G8OYJGgH7l
         It0+UEWhLuxsfx66/0hM7Rw23UfnfhesoUILp2fysA1APwqsZnIBuIORoQIWx2VUNb0K
         lgA4FXUkZu3CEtlSeUvrq0SB0c3eIsug9dcXLaHWcBP5wiFcSXwTvoHZIzfsSfGTqyTq
         /txfIITl1McFHVXtiFlaJQJat8EYQFy3yb9Ci+xoKzb8mLINarX9T8VfobBNF205IR0I
         UyaJRZoODyD9lUuR8JczB6ROWm638Epl/+ya7bxqP5ezGoBwMCOAMOoaT8+EKK689Fpk
         HOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eQ0tnAOxHeH12c7Laz+vMB4Qs8XzaNiPDbsYhR2qePs=;
        b=QhOh5G0pMPBbhk8ANioqx6Kh+bZfPKyzCR6KCigDRvJVXUdPY5GsrRLOxSRWYevmD4
         Fhttx3KwjCpjewcDOAqcmJIGkLF0kCfBYswagngRL+vBKchfjDGwRLXBj/N8BwR1FQ1Q
         53QSnNTNB96cLsxo8GrHgnLz1V1ojHAmO1jdq49F0a79Vy/Nt9Bx/Nb/B43sm4kxaK7i
         mxpHQnLMSgp2HdFm0bVmMbQgBmC7SFJEscc2JL5OP2vqizqOsYcsIiFX64sDoFTVZFPr
         CvPtGZefzNXnhfNXauzaoR5R/lIFRJxL/qhdKSwlKI370D3TqUZXX+IdOVCTOMDUDvB0
         Iigw==
X-Gm-Message-State: AOAM531okDUaoRyGcHph4+tx6fp6Hg1nAO59xg9FbZ6lZt6fhxfPv7Hh
        09ZHX8A23TFpVLA7or6Nn8O4ztvHP/Ipq9k8oko=
X-Google-Smtp-Source: ABdhPJwqn8RXL1Bvpf0JJmmyY1t+bW84O+QW3e9IEaVzdegefFicRf97JXaS2IoPV/2FAXohPqzwiXLyUsyi7sB3ahI=
X-Received: by 2002:a19:5f04:: with SMTP id t4mr2005468lfb.208.1588945963648;
 Fri, 08 May 2020 06:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com> <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com> <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com> <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com> <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com>
In-Reply-To: <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Fri, 8 May 2020 09:52:30 -0400
Message-ID: <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

5.6.1 also failed the same way. Here's the usage output. This is the
part where you see I've been using RAID5 haha

WARNING: RAID56 detected, not implemented
Overall:
    Device size:                  60.03TiB
    Device allocated:             98.06GiB
    Device unallocated:           59.93TiB
    Device missing:                  0.00B
    Used:                         92.56GiB
    Free (estimated):                0.00B      (min: 8.00EiB)
    Data ratio:                       0.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
   /dev/sdh        8.07TiB
   /dev/sdf        8.07TiB
   /dev/sdg        8.07TiB
   /dev/sdd        8.07TiB
   /dev/sdc        8.07TiB
   /dev/sde        8.07TiB

Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
   /dev/sdh       34.00GiB
   /dev/sdf       32.00GiB
   /dev/sdg       32.00GiB

System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
   /dev/sdf       32.00MiB
   /dev/sdg       32.00MiB

Unallocated:
   /dev/sdh        2.81TiB
   /dev/sdf        2.81TiB
   /dev/sdg        2.81TiB
   /dev/sdd        1.03TiB
   /dev/sdc        1.03TiB
   /dev/sde        1.03TiB

On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
> > If this is saying there's no extra space for metadata, is that why
> > adding more files often makes the system hang for 30-90s? Is there
> > anything I should do about that?
>
> I'm not sure about the hang though.
>
> It would be nice to give more info to diagnosis.
> The output of 'btrfs fi usage' is useful for space usage problem.
>
> But the common idea is, to keep at 1~2 Gi unallocated (not avaiable
> space in vanilla df command) space for btrfs.
>
> Thanks,
> Qu
>
> >
> > Thank you so much for all of your help. I love how flexible BTRFS is
> > but when things go wrong it's very hard for me to troubleshoot.
> >
> > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
> >>> Something went wrong:
> >>>
> >>> Reinitialize checksum tree
> >>> Unable to find block group for 0
> >>> Unable to find block group for 0
> >>> Unable to find block group for 0
> >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> >>> btrfs(+0x6dd94)[0x55a933af7d94]
> >>> btrfs(+0x71b94)[0x55a933afbb94]
> >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
> >>> btrfs(+0x360b2)[0x55a933ac00b2]
> >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
> >>> btrfs(main+0x98)[0x55a933a9fe88]
> >>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b=
3]
> >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
> >>> Aborted
> >>
> >> This means no space for extra metadata...
> >>
> >> Anyway the csum tree problem shouldn't be a big thing, you could leave
> >> it and call it a day.
> >>
> >> BTW, as long as btrfs check reports no extra problem for the inode
> >> generation, it should be pretty safe to use the fs.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
> >>> available. I'll let that try overnight?
> >>>
> >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
> >>>>> Thank you for helping. The end result of the scan was:
> >>>>>
> >>>>>
> >>>>> [1/7] checking root items
> >>>>> [2/7] checking extents
> >>>>> [3/7] checking free space cache
> >>>>> [4/7] checking fs roots
> >>>>
> >>>> Good news is, your fs is still mostly fine.
> >>>>
> >>>>> [5/7] checking only csums items (without verifying data)
> >>>>> there are no extents for csum range 0-69632
> >>>>> csum exists for 0-69632 but there is no extent record
> >>>>> ...
> >>>>> ...
> >>>>> there are no extents for csum range 946692096-946827264
> >>>>> csum exists for 946692096-946827264 but there is no extent record
> >>>>> there are no extents for csum range 946831360-947912704
> >>>>> csum exists for 946831360-947912704 but there is no extent record
> >>>>> ERROR: errors found in csum tree
> >>>>
> >>>> Only extent tree is corrupted.
> >>>>
> >>>> Normally btrfs check --init-csum-tree should be able to handle it.
> >>>>
> >>>> But still, please be sure you're using the latest btrfs-progs to fix=
 it.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>> [6/7] checking root refs
> >>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>>> found 44157956026368 bytes used, error(s) found
> >>>>> total csum bytes: 42038602716
> >>>>> total tree bytes: 49688616960
> >>>>> total fs tree bytes: 1256427520
> >>>>> total extent tree bytes: 1709105152
> >>>>> btree space waste bytes: 3172727316
> >>>>> file data blocks allocated: 261625653436416
> >>>>>  referenced 47477768499200
> >>>>>
> >>>>> What do I need to do to fix all of this?
> >>>>>
> >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
> >>>>>>> Well, the repair doesn't look terribly successful.
> >>>>>>>
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>
> >>>>>> This means there are more problems, not only the hash name mismatc=
h.
> >>>>>>
> >>>>>> This means the fs is already corrupted, the name hash is just one
> >>>>>> unrelated symptom.
> >>>>>>
> >>>>>> The only good news is, btrfs-progs abort the transaction, thus no
> >>>>>> further damage to the fs.
> >>>>>>
> >>>>>> Please run a plain btrfs-check to show what's the problem first.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>>
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
> >>>>>>> Ignoring transid failure
> >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=
=3D84
> >>>>>>> parent level=3D1
> >>>>>>>                                             child level=3D4
> >>>>>>> ERROR: failed to zero log tree: -17
> >>>>>>> ERROR: attempt to start transaction over already running one
> >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
> >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066086400 len=
 4096
> >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066094592 len=
 4096
> >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066102784 len=
 4096
> >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066131456 len=
 4096
> >>>>>>>
> >>>>>>> What is going on?
> >>>>>>>
> >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail=
.com> wrote:
> >>>>>>>>
> >>>>>>>> Chris, I had used the correct mountpoint in the command. I just =
edited
> >>>>>>>> it in the email to be /mountpoint for consistency.
> >>>>>>>>
> >>>>>>>> Qu, I'll try the repair. Fingers crossed!
> >>>>>>>>
> >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> >>>>>>>>>> Hello,
> >>>>>>>>>>
> >>>>>>>>>> I looked up this error and it basically says ask a developer t=
o
> >>>>>>>>>> determine if it's a false error or not. I just started getting=
 some
> >>>>>>>>>> slow response times, and looked at the dmesg log to find a ton=
 of
> >>>>>>>>>> these errors.
> >>>>>>>>>>
> >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: roo=
t=3D5
> >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode =
generation:
> >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>>>> [192088.449823] BTRFS error (device sdh): block=3D203510940835=
840 read
> >>>>>>>>>> time tree block corruption detected
> >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: roo=
t=3D5
> >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode =
generation:
> >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>>>> [192088.462773] BTRFS error (device sdh): block=3D203510940835=
840 read
> >>>>>>>>>> time tree block corruption detected
> >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: roo=
t=3D5
> >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode =
generation:
> >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>>>> [192088.468457] BTRFS error (device sdh): block=3D203510940835=
840 read
> >>>>>>>>>> time tree block corruption detected
> >>>>>>>>>>
> >>>>>>>>>> btrfs device stats, however, doesn't show any errors.
> >>>>>>>>>>
> >>>>>>>>>> Is there anything I should do about this, or should I just con=
tinue
> >>>>>>>>>> using my array as normal?
> >>>>>>>>>
> >>>>>>>>> This is caused by older kernel underflow inode generation.
> >>>>>>>>>
> >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
> >>>>>>>>>
> >>>>>>>>> Or you can go safer, by manually locating the inode using its i=
node
> >>>>>>>>> number (1311670), and copy it to some new location using previo=
us
> >>>>>>>>> working kernel, then delete the old file, copy the new one back=
 to fix it.
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Qu
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thank you!
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>
> >>>>
> >>
>
