Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71312CE9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfL3KGn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 05:06:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33989 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfL3KGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 05:06:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so45689274otf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 02:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sgkus2SqdNySMY+5l8CxmOI6cbvCJ3H8qjblegj7sZ4=;
        b=O425N/RkTkr5uD1n1ij2Bq+8bxTO32VWTqbcTS6XooNErQVa1W6NKaSnmx82U236bV
         QYbo2cP+xm+tEJVVxN4Lyn9LiX69OODiehMyIbHe+VAw54vj/Yb+8kUYXgB1RyTo8Vtp
         n/tqRfB0YjZlPOsyAVAaOvgjxNvoJGJTynHeaBNuUKbJ1ea5Um7UhwghcGJeXO/DEPW0
         cW3ujHmKdnB28vzUFfoTSJ8IIngMwJ0YQ49CrRGkcD0MTGuPpcfVfkaCFJVemlLz/FKv
         ie248/sNSwB/RkSuJAoAsj69RhMfGE5zZ2EEmhaijMWM5kqZvohZnkvdIFUq3R7Gm8E5
         7umw==
X-Gm-Message-State: APjAAAV+jPymrl2LWfteHCZeE/m/2p7tfyYNPUbTBC9rt6V5NK8TpaPb
        hghotIcBv2btON346cAI2UIrD+T7OGkbNyqSWe1ekw99
X-Google-Smtp-Source: APXvYqxs+YmiNZxaJEtfANyn/EHPFciyuW50F0hwR4M8M9Xc5oJk1nX6+aCrUJLt+POKhcKqO1kg/6H5OIvU3pdiiSg=
X-Received: by 2002:a9d:7ac9:: with SMTP id m9mr70388084otn.80.1577700401274;
 Mon, 30 Dec 2019 02:06:41 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com> <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com> <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com> <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
 <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com> <CAOB=O_hMPVfmFqumfcdS8LxG0tZXR2AiccDwgN1f6Lomntg9uQ@mail.gmail.com>
 <4a28f224-a602-61e7-3404-68a4414df81c@gmx.com> <CAOB=O_i9cjtZD3LxvfN6eg31uzab6PE1E=Gh_4C3KLeMeeZX0g@mail.gmail.com>
 <278545c8-3267-b6d2-8e0e-5de6be572946@gmx.com>
In-Reply-To: <278545c8-3267-b6d2-8e0e-5de6be572946@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Mon, 30 Dec 2019 10:06:30 +0000
Message-ID: <CAOB=O_htKVHzV-eW4i78RKkM_G4BA2BdYBbGRMN0bzJF8xqU7g@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That sucks :-( The only reason I had hope for /etc and /var was they
show up in btrfs check as not having a parent and i figured I could
reparent them onto the new / and have a chance of extracting something
useful from them.  I guess I'll plan on grabbing images of the FS
tomorrow and starting a full rebuild.  Hopefully someone will chime in
with a way to get /etc/ and /var/  before I reach the point I need
them.

On Mon, Dec 30, 2019 at 9:27 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/30 下午5:21, Patrick Erley wrote:
> > On Mon, Dec 30, 2019 at 9:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2019/12/30 下午5:01, Patrick Erley wrote:
> >>> On Mon, Dec 30, 2019 at 8:54 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>> On 2019/12/30 下午4:14, Patrick Erley wrote:
> >>>>> On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>
> >>>>> Should I also paste in the repair log?
> >>>>>
> >>>> Yes please.
> >>>>
> >>>> This sounds very strange, especially for the transid mismatch part.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>
> >>>
> >>>
> >>> enabling repair mode
> >>> WARNING:
> >>>
> >>>     Do not use --repair unless you are advised to do so by a developer
> >>>     or an experienced user, and then only after having accepted that no
> >>>     fsck can successfully repair all types of filesystem corruption. Eg.
> >>>     some software or hardware bugs can fatally damage a volume.
> >>>     The operation will start in 10 seconds.
> >>>     Use Ctrl-C to stop it.
> >>> 10 9 8 7 6 5 4 3 2 1parent transid verify failed on 499774464000
> >>> wanted 3323349 found 3323340
> >>> parent transid verify failed on 499774521344 wanted 3323349 found 3323340
> >>> parent transid verify failed on 499774529536 wanted 3323349 found 3323340
> >>
> >> This message is from open_ctree(), which means the fs is already corrupted.
> >>
> >> Would you like to provide the history between last good btrfs check run
> >> and --repair run?
> >>
> >> Thanks,
> >> Qu
> >
> > In theory, all I did was boot back into 5.1 and continued using the
> > system.
>
> If that's the only thing before --repair (if there is only one repair
> run, and output is exactly what you pasted), then I guess something
> didn't go right in that 5.1 run?
>
> Is that pasted output from the first --repair run?
>
> If there is another run before the pasted output, then it could be
> previous --repair.
>
> Either way, I'm very sorry for the data loss...
>
> > After you said I should go ahead and try to --repair, I
> > rebooted into initramfs and ran the repair, then continued
> > booting(which failed spectacularly, due to almost all of / being
> > missing).  I then rebooted back into initramfs to assess what was
> > going on, and made a liveusb (from which I'm sending this on that
> > system).  Some 'background' on the FS: It was migrated from ext4 ~7?
> > years ago, and has been moved between multiple discs and systems using
> > dd.  Interesting point: The only files/folders that still exist in /
> > were created after I migrated the filesystem.  If I can get /etc and
> > maybe /var back, I'm golden (there are a few bits in each I don't
> > include in my hot backups, so will have to go to offline storage to
> > fetch them).
>
> I'm afraid the only chance we left is btrfs-restore.
>
> And normally for transid error, the chance is pretty low then.
>
> Thanks,
> Qu
>
> >
>
