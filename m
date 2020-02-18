Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDED516226D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRIfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 03:35:12 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39944 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgBRIfM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 03:35:12 -0500
Received: by mail-qv1-f67.google.com with SMTP id q9so7859583qvu.7
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXemrpsZrqy8Wm9mmrRfZFiPb2H8T9VScIReW431hA4=;
        b=Xe4C3rUouaUq+iEK2zBtbHm4TIv9ozM0IwcQhWuMywOHQHwcSs55Md+R5O2KI2V+2h
         SAjrNhvNQod0lrP11mx3du+UDXcwHwiyaTCO5Ee5xw+bGRrHJdeNDUUq2AD1lwHgzOvh
         tJ3T+uwvCv2R+GF/2wbKXpPdFwVxDMXegrLn+Y6ggjNUs+rKAZ4fC1wr6Oi2A+CR7wQp
         eq846yMNZ6a6mjlsgVfmESMxPmZKDv68rHIEcjkX93GkBoH1aDyepjW5D/0r2gYxrAU5
         SOPUHFF4jwTkrTnzFq4eErqtJDHOpJAvi1EHk8gm5NxDi9bIzx4VJCNZ6FmmUASyysmg
         LbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXemrpsZrqy8Wm9mmrRfZFiPb2H8T9VScIReW431hA4=;
        b=ex4y2qnYxYdA9jI1P06ozh6J0pGAT/8tm6Y8L2xsxcEzk30NAv0bnFrb9sq7IvNnQN
         6qasbN8GKEziAKMNuZeDgJWZW5/PCO1NvFtszOUkdOVgMS40KEe9/VPz8TLhHBzi3pSl
         z/erjZdZ8wmkZDuDoI3wqzWdKGmnSHzMRvp5hIbGOTbJBHHUvks37Pey2KYQHEthSEWB
         5gpT2N8UYYkTBIdIx7AdlUYXrwlOCeUE5ZMi5yVOIVPriJbbei3iYMcld4OKhbD7DglV
         VPm5W/GoSKDi2N2m0FaE/HaF0/uZ5jYTa+wWOFHao8Es2+IKCmm4yoLObC9zsWLlQJnr
         NcQg==
X-Gm-Message-State: APjAAAUgqA+HuoemxMZ0rrduo34isOg0uiDYmkhdDG84O8VHvwNNYKSl
        a/EWcG4UN1mHmqYyWH9zKlIqa0Y5t9bJQjMKXKs=
X-Google-Smtp-Source: APXvYqxtH1U5PBi3VGmTVS2HsPicWHzSI3J3sVoo8Iq0AGmTrncgR4R+o7aZaclafCz7dwPvBxiUN2r41XKN1PWcDkE=
X-Received: by 2002:a05:6214:b23:: with SMTP id w3mr16136006qvj.181.1582014910765;
 Tue, 18 Feb 2020 00:35:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org> <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
 <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org> <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
In-Reply-To: <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
From:   Menion <menion@gmail.com>
Date:   Tue, 18 Feb 2020 09:34:59 +0100
Message-ID: <CAJVZm6eQs228cH-VpDcuqudKHVr2zq=K4_RV--2bbAoGqTLL7g@mail.gmail.com>
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello again

Task completed, I see in three occurrence of this event:

[518366.156963] INFO: task btrfs-cleaner:1034 blocked for more than 120 sec=
onds.
[518366.156989]       Not tainted 5.5.3-050503-generic #202002110832
[518366.157024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[518366.157044] btrfs-cleaner   D    0  1034      2 0x80004000
[518366.157054] Call Trace:
[518366.157082]  __schedule+0x2d8/0x760
[518366.157094]  schedule+0x55/0xc0
[518366.157105]  schedule_preempt_disabled+0xe/0x10
[518366.157113]  __mutex_lock.isra.0+0x182/0x4f0
[518366.157125]  __mutex_lock_slowpath+0x13/0x20
[518366.157132]  mutex_lock+0x2e/0x40
[518366.157261]  btrfs_delete_unused_bgs+0xc0/0x560 [btrfs]
[518366.157322]  ? __wake_up+0x13/0x20
[518366.157424]  cleaner_kthread+0x124/0x130 [btrfs]
[518366.157437]  kthread+0x104/0x140
[518366.157531]  ? kzalloc.constprop.0+0x40/0x40 [btrfs]
[518366.157565]  ? kthread_park+0x90/0x90
[518366.157575]  ret_from_fork+0x35/0x40

and

[518486.984177] INFO: task btrfs-cleaner:1034 blocked for more than 241 sec=
onds.
[518486.984204]       Not tainted 5.5.3-050503-generic #202002110832
[518486.984216] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[518486.984233] btrfs-cleaner   D    0  1034      2 0x80004000
[518486.984243] Call Trace:
[518486.984271]  __schedule+0x2d8/0x760
[518486.984284]  schedule+0x55/0xc0
[518486.984295]  schedule_preempt_disabled+0xe/0x10
[518486.984305]  __mutex_lock.isra.0+0x182/0x4f0
[518486.984319]  __mutex_lock_slowpath+0x13/0x20
[518486.984326]  mutex_lock+0x2e/0x40
[518486.984451]  btrfs_delete_unused_bgs+0xc0/0x560 [btrfs]
[518486.984464]  ? __wake_up+0x13/0x20
[518486.984562]  cleaner_kthread+0x124/0x130 [btrfs]
[518486.984573]  kthread+0x104/0x140
[518486.984666]  ? kzalloc.constprop.0+0x40/0x40 [btrfs]
[518486.984675]  ? kthread_park+0x90/0x90
[518486.984686]  ret_from_fork+0x35/0x40

and

[518728.646379] INFO: task btrfs-cleaner:1034 blocked for more than 120 sec=
onds.
[518728.646413]       Not tainted 5.5.3-050503-generic #202002110832
[518728.646428] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[518728.646447] btrfs-cleaner   D    0  1034      2 0x80004000
[518728.646460] Call Trace:
[518728.646494]  __schedule+0x2d8/0x760
[518728.646508]  schedule+0x55/0xc0
[518728.646522]  schedule_preempt_disabled+0xe/0x10
[518728.646534]  __mutex_lock.isra.0+0x182/0x4f0
[518728.646550]  __mutex_lock_slowpath+0x13/0x20
[518728.646559]  mutex_lock+0x2e/0x40
[518728.646719]  btrfs_delete_unused_bgs+0xc0/0x560 [btrfs]
[518728.646735]  ? __wake_up+0x13/0x20
[518728.646859]  cleaner_kthread+0x124/0x130 [btrfs]
[518728.646875]  kthread+0x104/0x140
[518728.647019]  ? kzalloc.constprop.0+0x40/0x40 [btrfs]
[518728.647031]  ? kthread_park+0x90/0x90
[518728.647045]  ret_from_fork+0x35/0x40

Is it a kind of normal?
Thanks, bye

Il giorno lun 17 feb 2020 alle ore 15:12 Menion <menion@gmail.com> ha scrit=
to:
>
> ok thanks
> I have launched it (in a tmux session), after 5 minutes the command
> did not return yet, but dmesg and  btrfs balance status
> /array/mount/point report it in progress (0%).
> Is it normal?
>
> Il giorno lun 17 feb 2020 alle ore 14:55 Sw=C3=A2mi Petaramesh
> <swami@petaramesh.org> ha scritto:
> >
> > On 2020-02-17 14:50, Menion wrote:
> > > Is it ok to run it on a mounted filesystem with concurrent read and
> > > write operations?
> >
> > Yes. Please check man btrfs-balance.
> >
> > All such BTRFS operations are to be run on live, mounted filesystems.
> >
> > Performance will suffer and it might be long though.
> >
> > > Also, since the number of HDD is 5, how this "raid1" scheme is deploy=
ed?
> >
> > BTRFS will manage storing 2 copies of every metadata block on 2
> > different disks, and will choose how by itself.
> >
> > =E0=A5=90
> >
> > --
> > Sw=C3=A2mi Petaramesh <swami@petaramesh.org> PGP 9076E32E
> >
