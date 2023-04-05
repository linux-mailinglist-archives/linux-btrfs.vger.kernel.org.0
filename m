Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD16D77DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbjDEJPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjDEJO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 05:14:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2363599
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 02:14:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b20so139409471edd.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680686096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGdRmTYLHHUGsoykBnDCZA4YSMNY4Ggha4PaeuQOgp0=;
        b=jfklbcXDuRruw0lHSKTggSzJS+mjUlu4+Uej82j8U6YZRv2K8XPGsSxLa1bY68qNex
         AIEwBVjPnh3iLsBz6jGX2ddahDqRUzoEm0Of84xNiVJyW0gV2YiUwBj9+nuNtNze7mnC
         5oq1/MnmUkKCAz8PEUgkrLQu5UbmIrW3HxqCgHJOr9sjvmXN9EBBk1KsXCLv50MmKfkE
         +Y5KsMdT5ftuW4NE9TvOw4WkxMTBziBZGFRurpG4329czaIa3I5NUBuOKIcBflMj+4QU
         Q05RQeE857PCkjwoEa3c2mOjZ4ztlVi5HrjumKO7R3b9/4TqmKgPQj0hFjlf04Gyepvv
         K+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGdRmTYLHHUGsoykBnDCZA4YSMNY4Ggha4PaeuQOgp0=;
        b=5fVo38scWUNoFWf6opP4A+dWLxnISwL3UsRF+26jmD9jOaS6+ofTnYCeoUqlU5WuXJ
         XJwG2pwZ95l+OCa4aFllLZrP5AYHYJJl8p4W4mDUG4YpS5jDTHNn8lFa56f4GhN3Ni75
         6KhB0Iuh4BOdfTcvOFGK0ISk3feWjgXNJezfMayBmkQew/zPRmb9q/Z9OM27j86ymOt+
         Yk4Q0ft1chsKo8aSC5XQrOnHjYRlOB1csRj4r2muw6bKzRQoUHeE+YT4+WOElTiP6Z9C
         /sYZ6nja5usGVT9LizWwc3jS4l5eP7TuyXdJ8oJs17utviLP1OFDBBdpmTfffwdYhlVR
         RYCw==
X-Gm-Message-State: AAQBX9fmc16YruPHzo0gpxzTE7eTnzlirQf1rAhtsOa4+8wo+tRlrjJi
        g1R/yBhzgUWf2RczNwckOboPSexgrzqOS4vYmrfZ4u0QrmjQsw==
X-Google-Smtp-Source: AKy350YXRytbsPp7Lv/oLI+r6H4smTZXsfzN9FMmtmBRr34Kc0cGsfROTsVtgcim7I0mt8uLF4rHLMrIJxC9e+s1aYI=
X-Received: by 2002:a17:907:6294:b0:946:f3f9:67ac with SMTP id
 nd20-20020a170907629400b00946f3f967acmr1659941ejc.3.1680686095897; Wed, 05
 Apr 2023 02:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAL5DHTE6ffo2PUdOEeN1OqaCen_an15L3suOXS4cNkz__kPzXQ@mail.gmail.com>
 <3af78c98-3d14-4145-c57e-2fc761fcd1ad@gmx.com> <CAL5DHTEw7H-iQuUyd+9d+eNicyn=ZZH3+x9QLogYo-hP91awgw@mail.gmail.com>
 <0b2d4582-84dd-b8d2-cfd0-5930cddbecca@gmx.com> <CAL5DHTF1bC5mDFu_fBjJarYW=gB_i0vOveyTfy6z2NxXv+Sg8Q@mail.gmail.com>
 <719a413a-6912-672b-d4d5-cf50c766d36e@gmx.com>
In-Reply-To: <719a413a-6912-672b-d4d5-cf50c766d36e@gmx.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Wed, 5 Apr 2023 11:14:44 +0200
Message-ID: <CAL5DHTFQP44Q6W-sgBcEtOcgasz7sadoiwTvAecZxwYS+t-sFQ@mail.gmail.com>
Subject: Re: [Bug] Device removal, writes to disk being removed
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I hope we see a change to device removal.

ENOSPC (Error NO SPace) is absolut a problem, but not a problem BTRFS
can solve on its own.
BTRFS can't magically create space.
ENOSPC have 3 solutions:

1. The user frees up space from volume.
2. The user adds space to the volum.
3. The user changes the data profile, to a space saving profile. f.eks
Raid1C4 to single.

BTRFS can at best in the background reserve space to do Raid5(d2)  to
single conversion (200% to 100%), by reservering space. 1-5% of space,
minimum of  1 block allocation, by default?

The most important thing BTRFS can do to avoid ENOSPC, is to have good
UI, both in TUI, but also in WEB like Cockpit,  and API like
SNMP/JSON.

For all TUI overview pages like `btrfs fs (df|show|usage)` and
functions like `balance|remove|replace` it can be a warning|error code
and message, that based on current state/usage  the volume will run
out of space (please add space, free up space or change data profile).


ons. 5. apr. 2023 kl. 09:30 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>
>
> On 2023/4/5 15:01, Torstein Eide wrote:
> > I understand that the device removal ioctl can only handle one device one time.
> >
> > But can't it be solved with a flag on devices that says "This device
> > is to be removed, don't write to it"? And the BIO, checks at mount
> > time, and when a flag is updated, what disk it should write
> > new/updated chunks to.
>
> That's feasible, but would need quite some big changes to both chunk
> allocator and the ioctl interface itself.
>
> This behavior change mostly means we split the device removal to two
> different phases, the marking and the real work.
>
> And the extra bit may lead to unexpected ENOSPC, thus it's not something
> we can easily implement right now.
>
> Thanks,
> Qu
>
> >
> > ons. 5. apr. 2023 kl. 08:53 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
> >>
> >>
> >>
> >> On 2023/4/5 14:11, Torstein Eide wrote:
> >>> ons. 5. apr. 2023 kl. 00:52 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
> >>>>
> >>>>
> >>>>
> >>>> On 2023/4/5 04:21, Torstein Eide wrote:
> >>>>> There is a bug with:
> >>>>> -  `btrfs device remove $Disk_1 $Disk_2 $volume`
> >>>>>
> >>>>> When multiple devices from a volume, it still writes to $Disk_2, will
> >>>>> removing $disk_1.
> >>>>
> >>>> Device removal is done by relocating all the chunks from the target
> >>>> device, ONE BY ONE.
> >>>>
> >>>> Thus it means when removing disk1, we can still utilize the space in disk2.
> >>>>
> >>>> In fact, even removing disk1, it's still possible to write data into it
> >>>> until the last chunk is being relocated.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>
> >>> I think iterating over all chunks from the target device, ONE By ONE,
> >>> is the only way to go.
> >>>
> >>> But is it best practice to utilize the space in disk2? When the user
> >>> has told the system this device is to be removed.
> >>
> >> Unfortunately the device removal ioctl can only handle one device one time.
> >>
> >> This means above "btrfs device remove disk1 disk2 mnt", it's no
> >> different than "btrfs dev remove disk1 mnt && btrfs dev remove disk2 mnt".
> >>
> >> Thus no matter if it's chunk or device, they are all handled ONE BY ONE,
> >> and when deleting the first device we may still write into the 2nd device.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> illustrated below with RAID5/6, that is shared between all devices.
> >>>
> >>> | Device | Starting | -1 Device | -2 Device |
> >>> |-------:|:--------:|:---------:|:---------:|
> >>> |    SDA |     X    |           |           |
> >>> |    SDB |     X    |     X     |           |
> >>> |    SDC |     X    |     X     |     X     |
> >>> |    SDD |     X    |     X     |     X     |
> >>> |    SDE |     X    |     X     |     X     |
> >>> |    SDD |     X    |     X     |     X     |
> >>>
> >>> Instead of:
> >>> | Device | Starting | -1 Device | -2 Device |
> >>> |-------:|:--------:|:---------:|:---------:|
> >>> |    SDA |     X    |           |           |
> >>> |    SDB |     X    |           |           |
> >>> |    SDC |     X    |     X     |     X     |
> >>> |    SDD |     X    |     X     |     X     |
> >>> |    SDE |     X    |     X     |     X     |
> >>> |    SDD |     X    |     X     |     X     |
> >>>
> >>> When the same chuck is on disk2.
> >>>
> >>> The same for disk1, when the user has told the system this device is
> >>> to be removed, is it best practice to write to it?
> >>>
> >>> One of the most common reasons to remove a disk is when its dying, is
> >>> then best practice to add more writes to it?
> >>>>>
> >>>>> ## Command used:
> >>>>> ````
> >>>>> btrfs device remove /dev/bcache5 /dev/bcache3 /volum1/
> >>>>> ````
> >>>>>
> >>>>> ## iostat
> >>>>> ````
> >>>>> Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
> >>>>> MB_read    MB_wrtn    MB_dscd
> >>>>> sdc (R1)       225.00        27.19         0.00         0.00
> >>>>> 27          0          0
> >>>>> sdd (R2)        94.00         0.00       105.56         0.00
> >>>>> 0        105          0
> >>>>> sde              324.00        27.19       113.06         0.00
> >>>>> 27        113          0
> >>>>> sdf               322.00        26.75       113.13         0.00
> >>>>>     26        113          0
> >>>>> sdg              310.00        26.00       108.06         0.00
> >>>>> 26        108          0
> >>>>> sdh              325.00        27.19       113.06         0.00
> >>>>> 27        113          0
> >>>>> ````
> >>>>>
> >>>>> ## uname -a:
> >>>>> ````
> >>>>> Linux server2 5.15.0-69-generic #76~20.04.1-Ubuntu SMP Mon Mar 20
> >>>>> 15:54:19 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> >>>>> ````
> >>>>>
> >>>>> ## btrfs version
> >>>>> ````
> >>>>> btrfs-progs v5.4.1
> >>>>> ````
> >
> >
> >
