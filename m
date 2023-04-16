Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559BC6E37C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDPLnq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 07:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDPLnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 07:43:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082121BD0
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 04:43:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c9so18222780ejz.1
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681645421; x=1684237421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6K+0YVE/unc21gZvIdOwhLSQxs/rZQTHc8aBg5ft/s=;
        b=bMx50lTfRrh3SxUNSE226cCKbtEHl67Fh4X6rCC8QWo2FoGI5np9uF21VPXO2SEGll
         OzC4NsMYVb5l9Km0f4GQTTGvpPYHcTMJkK6x/WSLLdtioattDkJQchctl7yss+HK2HB7
         H+ZoaLJ0ZzYzUPMMh3LgtxWx/mZadCgZnVqAXLGmJcQGttB9EjGtBy9PKeKuLs25XUz0
         nwR+a6JYIMUH8VShvXey9S69EE99ciyzBxJDeU5lSlWpacm6IFY3tJcfHGM9kxp9oh/F
         G92QcPV1TjfR7ecSRnUCn36X6gECHhVdZKRtEyXbmdi+Sh83NghKUJEQKFWNEUruM8S7
         GbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681645421; x=1684237421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6K+0YVE/unc21gZvIdOwhLSQxs/rZQTHc8aBg5ft/s=;
        b=aef/6/g20ZDcuFrbVbVRLFV6TIsPi3lmBdfAGP5SKnvg/J2EkmxfMbe26J+K2ftBrZ
         tjRdsNEzAyq5iyBgMIT5gZ/3seOm8qiSinQCfIIamNXuQE/zO34+/juKURn+jCNcHKlD
         R5W/1hPRe/wpc/rLJt0LMOcnZ9EEUBnErEZKfesCfg16faew+/mAsFT0wWlEPlkg1xuQ
         2kmTw7juEYzCR2UdFXLHTplfgAL6nS/evhdeyEkJKh3tA/QqQt5ylhp4YQM0WtMqCUsZ
         krqQ5wNTYYmtK6HLKIZfb8spgHz8cRekfGEjR/rjuJtkAbJPp2+TJFu5wj0EBiAs657G
         PJ0g==
X-Gm-Message-State: AAQBX9fQ/xRjWKT9uzRYLEiDoE691puhq26kyRjaxpBoe2q4zDbOpK5k
        73LG/n7SJckNNjC489ocDyCPeXT2eeeynhiX/SP9I3vMvPNZ+Q==
X-Google-Smtp-Source: AKy350anZEs1aj5xqt4cdQOTmfgrCyD0zktqXDp8Zd5yv9T5e6ZtJzWxur5e9wGVV74MQRP8+mjHXdX9v0bPWBZPzuo=
X-Received: by 2002:a17:906:eb81:b0:93e:c1ab:ae67 with SMTP id
 mh1-20020a170906eb8100b0093ec1abae67mr2138093ejb.2.1681645421182; Sun, 16 Apr
 2023 04:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com> <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
 <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
 <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com> <CAL5DHTEYeEXLrV0+=d2wsYpxZvW2+Ku61CC3hLFNOUtOMTxi2A@mail.gmail.com>
 <4adbf458-97ac-535c-cd26-2f1f724cf5d3@gmx.com>
In-Reply-To: <4adbf458-97ac-535c-cd26-2f1f724cf5d3@gmx.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Sun, 16 Apr 2023 13:43:28 +0200
Message-ID: <CAL5DHTHQp-8EvwwcjJRuZR90Tn9LnV6aQKVkkRfZi+dx+H203A@mail.gmail.com>
Subject: Re: scrub/balance a specif LBA range
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

#uname -a
Linux sysrescue 6.1.20-1-lts  x86_64 GNU/Linux


````
# btrfs device remove /dev/loop101 /mnt/volum1/
ERROR: error removing device '/dev/loop101': Input/output error
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
WARNING:    Data: raid5, raid6
````

## Dmesg
````
[ 2734.955532] BTRFS info (device loop101): relocating block group
103315594543104 flags data|raid6
[ 2738.169941] btrfs_print_data_csum_error: 92 callbacks suppressed
[ 2738.169950] BTRFS warning (device loop101): csum failed root -9 ino
275 off 940359680 csum 0x2b42e85b expected csum 0xea6c2bd2 mirror
````

The output is  suppressed, so the fault that there is an error on the
second and/ third disk is hidden.
So there may need a third and a fourth error message, in Dmesg:
nr3: Error: Was unable to so read  with integri block group XXX, with
the following offsets ZZZ1, ZZ2
nr4: Error: BTRFS $task, stop due  to inability to read with integri
block. (until a options to skip is implemented)

There may need to be an option to read a file with corruption_errs.

[/dev/loop102].corruption_errs  56
[/dev/loop103].corruption_errs  12

````
# btrfs inspect-internal logical-resolve 93730951016448 volum1/
inode 13386884 subvol @plexConfig could not be accessed: not mounted
````
Why does the subvolum need to be mounted,  to resolve content?


I now have a workflow that allows me to continue removing devices,
even if it involves a lot of manual work.
1. Start `btrfs device remove /dev/loop101 /mnt/volum1/`
2. When stop, read Dmesg:
      - BTRFS info (device loop101): relocating block group
**93446497894400** flags data|raid5
      - BTRFS warning (device loop101): csum failed root -9 ino 329
off ** 2920988672** csum 0x79a48ce1 expected csum 0xf590b5be mirror 1
3. `btrfs inspect-internal logical-resolve
$((103315594543104+940359680)) /mnt/volum1/`
       - inode 613878 subvol @plexconfig could not be accessed: not mounted
3B. If file is not on top root volume mount, subvolum that is points to
       - `mount /dev/loop101 ,subvol=3D@plexconfig /mnt/plexconfig/`
       - `btrfs inspect-internal logical-resolve
$((103315594543104+940359680)) /mnt/plexconfig/`
5. Delete or move files.
6. Repeat

s=C3=B8n. 16. apr. 2023 kl. 10:56 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>
>
> On 2023/4/16 16:36, Torstein Eide wrote:
> > Qu, it must be frustrating to listen to me.
> > I appreciate all the help you give both for me and my problems, and
> > also your contribution to BTRFS.
> >
> > Okay, I will try that.
> >
> >
> > #btrfs filesystem usage -T -g /mnt/
> >
> > Overall:
> >      Device size:                       52160.13GiB
> >      Device allocated:                  22114.09GiB
> >      Device unallocated:                30046.04GiB
> >      Device missing:                        0.00GiB
> >      Used:                              19436.54GiB
> >      Free (estimated):                  25711.53GiB      (min: 12082.50=
GiB)
> >      Free (statfs, df):                 13766.30GiB
> >      Data ratio:                               1.27
> >      Metadata ratio:                           3.00
> >      Global reserve:                        0.50GiB      (used: 0.00GiB=
)
> >      Multiple profiles:                         yes      (data)
> >
> >                  Data        Data       Metadata System
> > Id Path         RAID5       RAID6      RAID1C3  RAID1C3 Unallocated
> > -- ------------ ----------- ---------- -------- ------- -----------
> >   1 /dev/loop101  2739.00GiB  339.00GiB        -       -  2511.03GiB
> >   2 /dev/loop102  2882.00GiB  903.00GiB        -       -  1804.03GiB
>
> Oh, indeed you really mean no other Meta/Sys chunks on that devid 2, and
> since you're really converting to RAID6, then your initial command is
> correct.
>
> Although the LBA thing still needs the extra multiplication.
>
> >   3 /dev/loop105  2882.00GiB  903.00GiB 31.00GiB       -  3636.04GiB
> >   4 /dev/loop104  2882.00GiB  903.00GiB 31.00GiB 0.03GiB  3636.01GiB
> >   5 /dev/loop106  2882.00GiB  903.00GiB 37.00GiB 0.03GiB  9216.97GiB
> >   6 /dev/loop103  2882.00GiB  903.00GiB 12.00GiB 0.03GiB  9241.97GiB
> > -- ------------ ----------- ---------- -------- ------- -----------
> >     Total        14267.00GiB 3048.00GiB 37.00GiB 0.03GiB 30046.04GiB
> >     Used         12106.80GiB 3029.00GiB 20.12GiB 0.00GiB
> >
> >
> >
> >
> > #uname -a
> > Linux ubuntu 5.19.0-32-generic #33~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
> > Mon Jan 30 17:03:34 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> >
> >
> > The Dmesg outputs the following:
> > [ 5308.421903] BTRFS info (device loop101): balance: start
> > -dconvert=3Draid6,soft,devid=3D1
> > [ 5308.539366] BTRFS info (device loop101): relocating block group
> > 93725670768640 flags data|raid5
> > [ 5354.099960] btrfs_print_data_csum_error: 92 callbacks suppressed
> > [ 5354.099963] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280235520 csum 0xb96d5c53 expected csum 0x040f4404 mirror 1
> > [ 5354.099967] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
> > [ 5354.099968] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105219, gen 0
> > [ 5354.100015] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280239616 csum 0x90e00007 expected csum 0x3094a9df mirror 1
> > [ 5354.100018] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105220, gen 0
> > [ 5354.100026] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280243712 csum 0xbc290143 expected csum 0x734662fc mirror 1
> > [ 5354.100029] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105221, gen 0
> > [ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1
> > [ 5354.100036] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105222, gen 0
> > [ 5354.100043] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280251904 csum 0x34856001 expected csum 0x04a0ca74 mirror 1
> > [ 5354.100045] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105223, gen 0
> > [ 5354.100053] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280256000 csum 0x14fb4051 expected csum 0x7cd42005 mirror 1
> > [ 5354.100056] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105224, gen 0
> > [ 5354.100065] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280260096 csum 0x32870ab6 expected csum 0x52d34048 mirror 1
> > [ 5354.100067] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105225, gen 0
> > [ 5354.100076] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280264192 csum 0x4e089939 expected csum 0x0f56b841 mirror 1
> > [ 5354.100079] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105226, gen 0
> > [ 5354.100088] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280268288 csum 0xc9887e92 expected csum 0xae8d7cfd mirror 1
> > [ 5354.100091] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105227, gen 0
> > [ 5354.100100] BTRFS warning (device loop101): csum failed root -9 ino
> > 1385 off 5280272384 csum 0x5425dba6 expected csum 0xa86edd67 mirror 1
> > [ 5354.100102] BTRFS error (device loop101): bdev /dev/loop101 errs:
> > wr 7172193, rd 64992, flush 58, corrupt 105228, gen 0
> > [ 5356.447967] BTRFS info (device loop101): balance: ended with status:=
 -5
> >
> > Based on the Dmesg, there is nothing that says why it ended before all
> > 2.7TiB was converted.
>
> It shows the conversion failed due to unrecoverable data during balance.
>
> But weirdly, the error only mentioned mirror 1 (directly read from
> disks), we should have an extra mirror for RAID5 (rebuild using parity),
> but it doesn't even seem to try rebuild.
> (Or it rebuilds some but still some unrepairable?)
>
> Considering the latest LTS is already v6.1, mind to try that kernel or
> the latest one, retry the same command and attach the dmesg for the
> newer kernel?
>
> >
> > There is no output of what files are affected.
>
> All my bad, I forgot relocation is doing a completely different error
> report than scrub.
>
> >
> > My rationale for using convert is that I like to remove 2 devices that
> > are failing, and since BTRFS currently don't support *remove flag*,
> > like we talked about before. I am using convert to give me extra
> > protection and options to disconnect the 2 devices, and do the `btrfs
> > device remove` with *missing*.
> >
> >
> > And it stops `btrfs device remove`, I like to continue removing or
> > converting to Raid6. Since `btrfs device remove` does not take input,
> > I am using balance as an alternative to work around the limitations of
> > `btrfs device remove`.
> >
> >
> > My point was:
> > block group 1 (no errors, converted|moved successful)
> > block group 2 (Single  (dual raid6) error, sometimes i continue to
> > iterate over the groups, sometimes i ends to early, like above and
> > below)
> > block group 3 (dual  (tripel on raid6) error, )
> >
> > Is there a way to tell BTRFS, while iterating blocks, if an
> > unrecoverable block, print (or store for print at the end), and do the
> > next block?
>
> Unfortunately, as you have already experienced, it's not yet supported
> to output those helpful info during balance.
>
> There is a way to get the offending files, but it's complex:
>
>  > [ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
>  > 1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1
>
> In above error message, it shows it's offset 5280247808 inside the block
> group 93725670768640 causing the error.
>
> You can convert the logical bytenr (93725670768640 + 5280247808) to
> filenames using "btrfs ins" subcommand:
>
>   # btrfs ins logical-resolve 93730951016448 <mnt>
>
>
> On the other hand, scrub is able to do error reporting much better, but
> it has its own problems related to RAID56 (slow perf if scrubbing the
> full fs, no support to only scrub certain blocks, bad error reporting
> for RAID56 P/Q stripes etc).
>
> So unfortunately you're stuck in a very user-unfriendly situation...
>
> But I'd recommend go newer kernel first to make sure the kernel is not
> doing something wrong first.
>
> If possible, please also try scrub first for that devid 2, which has a
> much better error reporting.
>
>
> And for us developers, we need to make the error reporting during
> balance much better first, then also enhance the error reporting during
> read-repair.
>
> Thanks,
> Qu
>
> >
> > Dual error , on raid6, unsure why it failed (I did use the wrong filter=
):
> > [ 1068.539127] BTRFS info (device loop101): balance: start
> > -dconvert=3Draid5,soft,usage=3D70,devid=3D1
> > [ 1068.546592] BTRFS info (device loop101): relocating block group
> > 103315594543104 flags data|raid6
> > [ 1068.855596] btrfs_print_data_csum_error: 91 callbacks suppressed
> > [ 1068.855600] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror 1
> > [ 1068.855607] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
> > [ 1068.855608] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 52, gen 0
> > [ 1068.855816] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror 1
> > [ 1068.855821] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 53, gen 0
> > [ 1068.855837] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror 1
> > [ 1068.855840] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 54, gen 0
> > [ 1068.855850] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403976192 csum 0x6207b5ba expected csum 0xd383f082 mirror 1
> > [ 1068.855853] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 55, gen 0
> > [ 1068.855860] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror
> > **2**
> > [ 1068.855863] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror
> > **2**
> > [ 1068.855964] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403980288 csum 0xd7b71b5b expected csum 0x7612c037 mirror 1
> > [ 1068.855967] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 56, gen 0
> > [ 1068.855976] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403984384 csum 0x60f71f94 expected csum 0x956a021b mirror 1
> > [ 1068.855979] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 57, gen 0
> > [ 1068.855980] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror
> > **2**
> > [ 1068.855989] BTRFS warning (device loop101): csum failed root -9 ino
> > 1310 off 403988480 csum 0x613d06ef expected csum 0x75e3d8f4 mirror 1
> > [ 1068.855992] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 58, gen 0
> > [ 1068.856000] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 59, gen 0
> > [ 1068.856008] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 60, gen 0
> > [ 1068.856040] BTRFS error (device loop101): bdev /dev/loop102 errs:
> > wr 0, rd 0, flush 0, corrupt 61, gen 0
> > [ 1069.116491] BTRFS info (device loop101): balance: ended with status:=
 -5
> >
> > s=C3=B8n. 16. apr. 2023 kl. 09:38 skrev Qu Wenruo <quwenruo.btrfs@gmx.c=
om>:
> >>
> >>
> >>
> >> On 2023/4/16 15:24, Torstein Eide wrote:
> >>> The correct format is then:
> >>>
> >>> `btrfs balance start -v
> >>> -ddevid=3D2,convert=3Draid6,drange=3D11454997800..11454997807` (conve=
rt
> >>> force move, only data on that device)
> >>> `btrfs balance start -v -ddevid=3D2,convert=3Draid6,drange=3D11455002=
752..11455002759`
> >>
> >> I guess that LBA is in 512 or 4K unit (because we're seeing unaligned
> >> bytenr like 11454997807).
> >>
> >> So the proper range should need to be multiplied by 512 or 4096 based =
on
> >> the block size of the device.
> >>
> >> Furthermore, if you're not doing convert, no need to specify convert=
=3D.
> >>
> >> And finally, you need to duplicate all the filters for metadata and
> >> system, just in case those profiles are involved in the drange.
> >>
> >> So the full output would looks like something like this: (assuming 512
> >> as block size)
> >>
> >> # btrfs balance start -ddevid=3D2,drange=3D5864958873600..586495887769=
5 \
> >>                         -mdevid=3D2,drange=3D5864958873600..5864958877=
695 \
> >>                         -sdevid=3D2,drange=3D5864958873600..5864958877=
695 \
> >>                         <mnt>
> >>>
> >>> And so on?
> >>>
> >>> Since I believe one of the ranges is matched with a bad sector on a
> >>> different device, can I tell BTRFS to, if failed work on the next
> >>> block that is not dual failure?
> >>
> >> Sorry I didn't get your point.
> >>
> >> Balance would try its best to rebuild the data (as long as it's
> >> checksumed), even there is a bad sector, btrfs can still detect and
> >> rebuild the good data.
> >>
> >> And of course, if btrfs failed to rebuild a data matching the csum, it
> >> would fail the balance.
> >>
> >> If you're concerned about that failure, in that case dmesg should outp=
ut
> >> which file is causing the problem, and you can delete the file and ret=
ry
> >> the balance.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> s=C3=B8n. 16. apr. 2023 kl. 02:23 skrev Qu Wenruo <quwenruo.btrfs@gmx=
.com>:
> >>>>
> >>>>
> >>>>
> >>>> On 2023/4/16 08:16, Qu Wenruo wrote:
> >>>>>
> >>>>>
> >>>>> On 2023/4/16 02:59, Torstein Eide wrote:
> >>>>>> Hi
> >>>>>> I have a disk with "Pending Sector remap".
> >>>>>> That can be view with:
> >>>>>>
> >>>>>> ``smartctl -l defects  /dev/sdd``
> >>>>>>
> >>>>>> ````
> >>>>>> Pending Defects log (GP Log 0x0c)
> >>>>>> Index                LBA    Hours
> >>>>>>        0        11454997800        -
> >>>>>> ....
> >>>>>>        7        11454997807        -
> >>>>>>        8        11455002752        -
> >>>>>> ....
> >>>>>>       15        11455002759        -
> >>>>>>       16        11464481352        -
> >>>>>> ....
> >>>>>>       31        11464486423        -
> >>>>>>       32        11480702000        -
> >>>>>> ....
> >>>>>>        39        11480702007        -
> >>>>>> ````
> >>>>>>
> >>>>>> Can I tell btrfs scrub or balance to move files on these locations=
?
> >>>>>> I was thinking the balance `drange` may work but was unsure of the
> >>>>>> correct format.
> >>>>>
> >>>>> You can use balance to only balance a logical range.
> >>>>
> >>>> s/logical/physical/
> >>>>
> >>>>>
> >>>>> And it's indeed the drange option.
> >>>>>
> >>>>> Although you may need to specify the option for both metadata, data=
 and
> >>>>> system, or go --full-balance to make sure all chunks are covered.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
