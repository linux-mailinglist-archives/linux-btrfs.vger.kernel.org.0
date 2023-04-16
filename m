Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D86E3617
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjDPIhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDPIhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 04:37:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A332D5D
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 01:36:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c9so17650640ejz.1
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681634218; x=1684226218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eODuKZQAsF/buRanRLGBOeH9xaPqK4Nu59OuxdEaBVE=;
        b=LX1TtqU0r3V2K/j3Iz/1LaBZcT8YCzRRinxIaryTmEn2oKDPpOwAY0IsxXFF7Nzos7
         4CAko6ZpOzWckQhWMOHMYdpL2G6HG/qrKyJbasArKi8ILqt66CZKK0nHvOTqSNFsr2ZG
         bFQG0yETV5m+tzEUALjOfbLK1CDISTqYbbcqvClMyx8o8C6qPdy+AHABHFfkpz35G66O
         BrgPVMZ3v2qXI348pixRpYkh8NUb5J3akExkYSnC6VmnpE6ZzCruKD/17JADJX3CxIEA
         Ue2ATXf+80QUu4HAo79qb5hedrok5aq2lUFhzCpheUJMXUMz5yMVj7DAFt6SIXnUHWcW
         gUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634218; x=1684226218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eODuKZQAsF/buRanRLGBOeH9xaPqK4Nu59OuxdEaBVE=;
        b=J7qOrDeDiTBMJyyc+nf9283vYNiurfZuDEoGJv50CdpRjvFpwhNQpzoRMMLdJhfre5
         kWf3q2Tt0YBOWBck5rKWKnBpwFMuOx6aCwGXglxlDIetPyb2I5j0Vfw1xiyFNYoUV+Y+
         BAVC5P7ejU3sg1wjCDvsMIoc2SzCFEfdH3Z9iNftkkv3IL4ZUdMt6JcwOWDqE0jy+1Jo
         u33xnADLXU5qTAGVAawdUjN5Q8jXLwifofJtQy699qnAOw8KYRU1eOXSCK7wN3gKS96T
         wI4+TO5WVEc+9wO6vsCUi5RqJBQ0pvi16id5na0ssF6bI0VxgmPi9rgf1TvwjhOr+wJS
         WC1w==
X-Gm-Message-State: AAQBX9e5WK06Q0nbSj1tyCD9u3GnqW6KVLtyLPuk+wUvX9k2NhRY7QAj
        PoGCGrQQEBKdqRp0pcK2roo+n4zSI36D4B4xhMYOjLY0w8CxXw==
X-Google-Smtp-Source: AKy350ZDMjP4x7tubrxBdgjEBBZQByVadtWv4UDcYoJvC4byjCj3FhqA1JpJBiyGJ1183ErBdsILpItuUFxgrlJ85TM=
X-Received: by 2002:a17:906:3717:b0:946:a095:b314 with SMTP id
 d23-20020a170906371700b00946a095b314mr1681021ejc.2.1681634217273; Sun, 16 Apr
 2023 01:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com> <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
 <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com> <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com>
In-Reply-To: <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Sun, 16 Apr 2023 10:36:44 +0200
Message-ID: <CAL5DHTEYeEXLrV0+=d2wsYpxZvW2+Ku61CC3hLFNOUtOMTxi2A@mail.gmail.com>
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

Qu, it must be frustrating to listen to me.
I appreciate all the help you give both for me and my problems, and
also your contribution to BTRFS.

Okay, I will try that.


#btrfs filesystem usage -T -g /mnt/

Overall:
    Device size:                       52160.13GiB
    Device allocated:                  22114.09GiB
    Device unallocated:                30046.04GiB
    Device missing:                        0.00GiB
    Used:                              19436.54GiB
    Free (estimated):                  25711.53GiB      (min: 12082.50GiB)
    Free (statfs, df):                 13766.30GiB
    Data ratio:                               1.27
    Metadata ratio:                           3.00
    Global reserve:                        0.50GiB      (used: 0.00GiB)
    Multiple profiles:                         yes      (data)

                Data        Data       Metadata System
Id Path         RAID5       RAID6      RAID1C3  RAID1C3 Unallocated
-- ------------ ----------- ---------- -------- ------- -----------
 1 /dev/loop101  2739.00GiB  339.00GiB        -       -  2511.03GiB
 2 /dev/loop102  2882.00GiB  903.00GiB        -       -  1804.03GiB
 3 /dev/loop105  2882.00GiB  903.00GiB 31.00GiB       -  3636.04GiB
 4 /dev/loop104  2882.00GiB  903.00GiB 31.00GiB 0.03GiB  3636.01GiB
 5 /dev/loop106  2882.00GiB  903.00GiB 37.00GiB 0.03GiB  9216.97GiB
 6 /dev/loop103  2882.00GiB  903.00GiB 12.00GiB 0.03GiB  9241.97GiB
-- ------------ ----------- ---------- -------- ------- -----------
   Total        14267.00GiB 3048.00GiB 37.00GiB 0.03GiB 30046.04GiB
   Used         12106.80GiB 3029.00GiB 20.12GiB 0.00GiB




#uname -a
Linux ubuntu 5.19.0-32-generic #33~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Mon Jan 30 17:03:34 UTC 2 x86_64 x86_64 x86_64 GNU/Linux


The Dmesg outputs the following:
[ 5308.421903] BTRFS info (device loop101): balance: start
-dconvert=3Draid6,soft,devid=3D1
[ 5308.539366] BTRFS info (device loop101): relocating block group
93725670768640 flags data|raid5
[ 5354.099960] btrfs_print_data_csum_error: 92 callbacks suppressed
[ 5354.099963] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280235520 csum 0xb96d5c53 expected csum 0x040f4404 mirror 1
[ 5354.099967] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
[ 5354.099968] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105219, gen 0
[ 5354.100015] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280239616 csum 0x90e00007 expected csum 0x3094a9df mirror 1
[ 5354.100018] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105220, gen 0
[ 5354.100026] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280243712 csum 0xbc290143 expected csum 0x734662fc mirror 1
[ 5354.100029] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105221, gen 0
[ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1
[ 5354.100036] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105222, gen 0
[ 5354.100043] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280251904 csum 0x34856001 expected csum 0x04a0ca74 mirror 1
[ 5354.100045] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105223, gen 0
[ 5354.100053] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280256000 csum 0x14fb4051 expected csum 0x7cd42005 mirror 1
[ 5354.100056] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105224, gen 0
[ 5354.100065] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280260096 csum 0x32870ab6 expected csum 0x52d34048 mirror 1
[ 5354.100067] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105225, gen 0
[ 5354.100076] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280264192 csum 0x4e089939 expected csum 0x0f56b841 mirror 1
[ 5354.100079] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105226, gen 0
[ 5354.100088] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280268288 csum 0xc9887e92 expected csum 0xae8d7cfd mirror 1
[ 5354.100091] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105227, gen 0
[ 5354.100100] BTRFS warning (device loop101): csum failed root -9 ino
1385 off 5280272384 csum 0x5425dba6 expected csum 0xa86edd67 mirror 1
[ 5354.100102] BTRFS error (device loop101): bdev /dev/loop101 errs:
wr 7172193, rd 64992, flush 58, corrupt 105228, gen 0
[ 5356.447967] BTRFS info (device loop101): balance: ended with status: -5

Based on the Dmesg, there is nothing that says why it ended before all
2.7TiB was converted.

There is no output of what files are affected.

My rationale for using convert is that I like to remove 2 devices that
are failing, and since BTRFS currently don't support *remove flag*,
like we talked about before. I am using convert to give me extra
protection and options to disconnect the 2 devices, and do the `btrfs
device remove` with *missing*.


And it stops `btrfs device remove`, I like to continue removing or
converting to Raid6. Since `btrfs device remove` does not take input,
I am using balance as an alternative to work around the limitations of
`btrfs device remove`.


My point was:
block group 1 (no errors, converted|moved successful)
block group 2 (Single  (dual raid6) error, sometimes i continue to
iterate over the groups, sometimes i ends to early, like above and
below)
block group 3 (dual  (tripel on raid6) error, )

Is there a way to tell BTRFS, while iterating blocks, if an
unrecoverable block, print (or store for print at the end), and do the
next block?

Dual error , on raid6, unsure why it failed (I did use the wrong filter):
[ 1068.539127] BTRFS info (device loop101): balance: start
-dconvert=3Draid5,soft,usage=3D70,devid=3D1
[ 1068.546592] BTRFS info (device loop101): relocating block group
103315594543104 flags data|raid6
[ 1068.855596] btrfs_print_data_csum_error: 91 callbacks suppressed
[ 1068.855600] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror 1
[ 1068.855607] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
[ 1068.855608] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 52, gen 0
[ 1068.855816] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror 1
[ 1068.855821] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 53, gen 0
[ 1068.855837] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror 1
[ 1068.855840] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 54, gen 0
[ 1068.855850] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403976192 csum 0x6207b5ba expected csum 0xd383f082 mirror 1
[ 1068.855853] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 55, gen 0
[ 1068.855860] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror
**2**
[ 1068.855863] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror
**2**
[ 1068.855964] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403980288 csum 0xd7b71b5b expected csum 0x7612c037 mirror 1
[ 1068.855967] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 56, gen 0
[ 1068.855976] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403984384 csum 0x60f71f94 expected csum 0x956a021b mirror 1
[ 1068.855979] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 57, gen 0
[ 1068.855980] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror
**2**
[ 1068.855989] BTRFS warning (device loop101): csum failed root -9 ino
1310 off 403988480 csum 0x613d06ef expected csum 0x75e3d8f4 mirror 1
[ 1068.855992] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 58, gen 0
[ 1068.856000] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 59, gen 0
[ 1068.856008] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 60, gen 0
[ 1068.856040] BTRFS error (device loop101): bdev /dev/loop102 errs:
wr 0, rd 0, flush 0, corrupt 61, gen 0
[ 1069.116491] BTRFS info (device loop101): balance: ended with status: -5

s=C3=B8n. 16. apr. 2023 kl. 09:38 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>
>
> On 2023/4/16 15:24, Torstein Eide wrote:
> > The correct format is then:
> >
> > `btrfs balance start -v
> > -ddevid=3D2,convert=3Draid6,drange=3D11454997800..11454997807` (convert
> > force move, only data on that device)
> > `btrfs balance start -v -ddevid=3D2,convert=3Draid6,drange=3D1145500275=
2..11455002759`
>
> I guess that LBA is in 512 or 4K unit (because we're seeing unaligned
> bytenr like 11454997807).
>
> So the proper range should need to be multiplied by 512 or 4096 based on
> the block size of the device.
>
> Furthermore, if you're not doing convert, no need to specify convert=3D.
>
> And finally, you need to duplicate all the filters for metadata and
> system, just in case those profiles are involved in the drange.
>
> So the full output would looks like something like this: (assuming 512
> as block size)
>
> # btrfs balance start -ddevid=3D2,drange=3D5864958873600..5864958877695 \
>                        -mdevid=3D2,drange=3D5864958873600..5864958877695 =
\
>                        -sdevid=3D2,drange=3D5864958873600..5864958877695 =
\
>                        <mnt>
> >
> > And so on?
> >
> > Since I believe one of the ranges is matched with a bad sector on a
> > different device, can I tell BTRFS to, if failed work on the next
> > block that is not dual failure?
>
> Sorry I didn't get your point.
>
> Balance would try its best to rebuild the data (as long as it's
> checksumed), even there is a bad sector, btrfs can still detect and
> rebuild the good data.
>
> And of course, if btrfs failed to rebuild a data matching the csum, it
> would fail the balance.
>
> If you're concerned about that failure, in that case dmesg should output
> which file is causing the problem, and you can delete the file and retry
> the balance.
>
> Thanks,
> Qu
>
> >
> > s=C3=B8n. 16. apr. 2023 kl. 02:23 skrev Qu Wenruo <quwenruo.btrfs@gmx.c=
om>:
> >>
> >>
> >>
> >> On 2023/4/16 08:16, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2023/4/16 02:59, Torstein Eide wrote:
> >>>> Hi
> >>>> I have a disk with "Pending Sector remap".
> >>>> That can be view with:
> >>>>
> >>>> ``smartctl -l defects  /dev/sdd``
> >>>>
> >>>> ````
> >>>> Pending Defects log (GP Log 0x0c)
> >>>> Index                LBA    Hours
> >>>>       0        11454997800        -
> >>>> ....
> >>>>       7        11454997807        -
> >>>>       8        11455002752        -
> >>>> ....
> >>>>      15        11455002759        -
> >>>>      16        11464481352        -
> >>>> ....
> >>>>      31        11464486423        -
> >>>>      32        11480702000        -
> >>>> ....
> >>>>       39        11480702007        -
> >>>> ````
> >>>>
> >>>> Can I tell btrfs scrub or balance to move files on these locations?
> >>>> I was thinking the balance `drange` may work but was unsure of the
> >>>> correct format.
> >>>
> >>> You can use balance to only balance a logical range.
> >>
> >> s/logical/physical/
> >>
> >>>
> >>> And it's indeed the drange option.
> >>>
> >>> Although you may need to specify the option for both metadata, data a=
nd
> >>> system, or go --full-balance to make sure all chunks are covered.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
