Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590A112CE2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfL3JVg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 04:21:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45035 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfL3JVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 04:21:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so42928036otj.11
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 01:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ULl1uc6HW6X9bHzhIUlNiafKQdm3dkUlJ7IN1ObRsQ0=;
        b=ZFRscXr0P+Q1PmKr5VQpU84NvUklmoRenETQWz7tDBfvt/iwP4HUezIjikRPLB1KV2
         hTM2mZbGCytA3/GhD8ziPP3AgLA0VV9dkUYgTxVGgOx+bjjuofuNKPzDKyFWsYr9Li6o
         mwSMlP8TiSCenVzr2AT9TmuxLJyUUao4461pqfRkwN0A2t0UB6dfu3RfV23dpZjFEkbM
         atZMgS35T+9cXcFC5WFErFSEquOCL8xmEOAJIA4zQ3LaqEg9HgoOtLwUe4AGkF8yv0TZ
         1+/YCZvpElAJfKBRC7uuMNjypi1Q5gnI7O2RfuRmnYb8XHugxH54ZK+0GSGBcgZdbrrH
         WzOw==
X-Gm-Message-State: APjAAAVOjckAx5Zfaw/gE4KFwoCwMgkhyqolbC8kq0BEIzzPeMLDpyoR
        +zHqmPAjaeP0Rk7cAfYX2b3vuG75nRRFourXKK2P5oSA
X-Google-Smtp-Source: APXvYqxYqrycYEJ3asy3AjmEozvWF4YjF6k10hPNiozNloPuCuVt5rjy0WHk4UR6usfHQ2Km08dAtLmGdJKw3yM/BTc=
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr71869690otp.108.1577697695165;
 Mon, 30 Dec 2019 01:21:35 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com> <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com> <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com> <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
 <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com> <CAOB=O_hMPVfmFqumfcdS8LxG0tZXR2AiccDwgN1f6Lomntg9uQ@mail.gmail.com>
 <4a28f224-a602-61e7-3404-68a4414df81c@gmx.com>
In-Reply-To: <4a28f224-a602-61e7-3404-68a4414df81c@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Mon, 30 Dec 2019 09:21:24 +0000
Message-ID: <CAOB=O_i9cjtZD3LxvfN6eg31uzab6PE1E=Gh_4C3KLeMeeZX0g@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 9:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/30 下午5:01, Patrick Erley wrote:
> > On Mon, Dec 30, 2019 at 8:54 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> On 2019/12/30 下午4:14, Patrick Erley wrote:
> >>> On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>
> >>> Should I also paste in the repair log?
> >>>
> >> Yes please.
> >>
> >> This sounds very strange, especially for the transid mismatch part.
> >>
> >> Thanks,
> >> Qu
> >>
> >
> >
> >
> > enabling repair mode
> > WARNING:
> >
> >     Do not use --repair unless you are advised to do so by a developer
> >     or an experienced user, and then only after having accepted that no
> >     fsck can successfully repair all types of filesystem corruption. Eg.
> >     some software or hardware bugs can fatally damage a volume.
> >     The operation will start in 10 seconds.
> >     Use Ctrl-C to stop it.
> > 10 9 8 7 6 5 4 3 2 1parent transid verify failed on 499774464000
> > wanted 3323349 found 3323340
> > parent transid verify failed on 499774521344 wanted 3323349 found 3323340
> > parent transid verify failed on 499774529536 wanted 3323349 found 3323340
>
> This message is from open_ctree(), which means the fs is already corrupted.
>
> Would you like to provide the history between last good btrfs check run
> and --repair run?
>
> Thanks,
> Qu

In theory, all I did was boot back into 5.1 and continued using the
system.  After you said I should go ahead and try to --repair, I
rebooted into initramfs and ran the repair, then continued
booting(which failed spectacularly, due to almost all of / being
missing).  I then rebooted back into initramfs to assess what was
going on, and made a liveusb (from which I'm sending this on that
system).  Some 'background' on the FS: It was migrated from ext4 ~7?
years ago, and has been moved between multiple discs and systems using
dd.  Interesting point: The only files/folders that still exist in /
were created after I migrated the filesystem.  If I can get /etc and
maybe /var back, I'm golden (there are a few bits in each I don't
include in my hot backups, so will have to go to offline storage to
fetch them).
