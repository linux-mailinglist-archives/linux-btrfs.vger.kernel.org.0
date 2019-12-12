Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A357811D671
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 19:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfLLS5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 13:57:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbfLLS5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 13:57:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so3947076wrr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOkF8k/h9bzC06XfGOtuLlFl9sn484hdvG1aPYgO5+E=;
        b=EExzFFhg2q5Mj8qC4qSCQ9g7XETbJvUMKhWw/mbsqfPKi2GpNzaKVhmci3IeMXjHvj
         WPmxCgm8yoOdoxWF55Iv5TQ0EyjI2w6kyWGrjJwWlJP/eUFD4gdCfl0EL1TNAWVtof9E
         xtxtpzSDISUZaWORyTDZOF71/+bbkUhGG8zRfSSPjJRgoxwLUPonwF7RiM/4GmmScImK
         pecR+HziqGna3o8jDRQwTvefzYPoVFcGj0BK0qN6aweCCB8RAiZb9uhdTqIPxeXMuNXQ
         VBQWMUNdmpU79rpQogDSt5OvIIpJMicBH2va6SjRAQiQSxNLDD9ZMclomkdjIHWByEU/
         Kj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOkF8k/h9bzC06XfGOtuLlFl9sn484hdvG1aPYgO5+E=;
        b=kp2iReWJxBfDFVVtt+rcQMS8Tm+abCAIg0ndXeLiZWZF0PDj42z62YgisPDxm7w88c
         9F0mtM9fPl+St5ZRmaP9rmhw6xBr8y2iAuevhg1bVWio4TX9Gsh/4f2ulTRJEp502woz
         J6HSCgolPNkmqc6ng6HKXr9jwNk8biF+EVrtJzGtc+f6dEqJ+lENdDKfCvYkKshZpmgP
         sLMzIZp6z2zX0L5xIi/4hrRWracRiRWSwukbyz2cm6iymBmMJj8EliwXOLwq7pwYI70h
         a5tR8oFuutWDSD7Ei/Cvp6/BAP2MCtd/Z4nDEGJInlYSmehvSrbe1S7hIPsd7QG/8OqB
         Eg7g==
X-Gm-Message-State: APjAAAXV8iiJgT2QIvIfQZVR6fJb/vjXFGReOF3oVX2apgjk9BLmhnat
        KuXYvIueepgJrTnesuKDDAUxltsKACuhKzTohA89i6bZE9tRag==
X-Google-Smtp-Source: APXvYqwR4G8MHF/GA2dN7Swjhe7vscAU2eofC7QOQMAQokcNWocy+lP2JQKCvsmjVTsrXUNedIgyhXzHDYa86XxuVX4=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr7923865wrp.167.1576177023802;
 Thu, 12 Dec 2019 10:57:03 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl> <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
In-Reply-To: <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 12 Dec 2019 11:56:47 -0700
Message-ID: <CAJCQCtQMxVrmhuiv04wVBanhn2vPuxDwLWwU0QheSMnbPB_Sxw@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 8:40 AM Cerem Cem ASLAN <ceremcem@ceremcem.net> wrote:

> My second action is, as there is only a disk present at the moment, to
> convert the Single data profile to DUP (which I couldn't, due to
> "Input/output error"s) in order to be able to fix any further
> corruption. I'll replace the disk by two new disks in the meanwhile
> and setup a RAID-1 with them.
>
> While searching for "converting to DUP profile", I noticed that the
> man page of btrfs explicitly states:
>
> > In any case, a device that starts to misbehave and repairs from the DUP copy should be replaced! DUP is not backup.
>
> Based on that, the uncorrectable errors (in Single profile) also means
> that we should replace the misbehaving disk.

If the single copy of metadata is critical for getting data off the
drive, and that single copy of metadata can't be read due to UNC error
from the drive, then it means normal operation of that file system
isn't possible. It's now a data scraping job.

My tactic would be to mount it ro, and try to get all the data off I
can through the normal means (file copy, rsync, whatever), doing it in
order of priority to improve the chance of successfully getting out
the most important data. Once this method consistently fails you'll
need to go to btrfs restore which is an offline scraping tool and
rather tedious to use.
https://btrfs.wiki.kernel.org/index.php/Restore

But if there's a scant amount of minimum necessary metadata intact,
you will get your data off, even if there are errors in the data
(that's one of the options in restore is to ignore errors). Whereas
normal operation Btrfs won't hand over anything with checksum errors,
you get EIO instead. So there's a decent chance of getting the data
off the drive this way.






>
> > Try 'smartctl -t long', then wait some minutes (it will give you an
> > estimate of how many), then look at the detailed self-test log output from
> > 'smartctl -x'.  The long self-test usually reads all sectors on the disk
> > and will quantify errors (giving UNC sector counts and locations).
>
> I tried this one, however I couldn't interpret the results. Here is
> the `smartctl -a /dev/sda` output:
> https://gist.github.com/1a741135af10f6bebcaf6175c04594df

196 Reallocated_Event_Count 0x0032   050   050   000    Old_age
Always       -       2652
197 Current_Pending_Sector  0x0022   084   084   000    Old_age
Always       -       1167

I don't know how many spare sectors a drive typically has, let alone
this particular make/model. This is somewhat inflated in that the
numbers likely are 512 byte sectors, so for every bad 4096 byte
physical sector, you see 8 bad sectors reported.

First order of priority is to get data off the drive, if you don't
have a current backup.
Second, once you have a backup or already do, demote this drive
entirely, and start your restore from backup using good drives.

Later you can mess around with this marginally reliable drive if you
want, maybe in a raid1 context. I'm suspicious whether there are in
fact some UNC write errors. The most recent error starting at line 95,
says both reads and writes were happening. Was it the read that
trigger the error (probably), in which case you could keep using this
drive, while remaining very suspicious of it and the high likelihood
it will betray you again in the future. If it is a write error, you'll
see that in dmesg just like read errors. That's disqualifying. You
pretty much have to take the drive out of use as it means it can't
remap sectors anymore at all, probably because it's run out of reserve
sectors.

I personally wouldn't mess around with this drive, trying to produce
DUP metadata out of likely corrupt single metadata. It doesn't help
the situation.

Oh and last but actually I should have mentioned it first, because
you'll want to do this right away. You might check if this drive has
configurable SCT ERC.

smartctl -l scterc /dev/

If it does, it might be worth explicitly setting the timeout to
something crazy. Like 180 seconds. That means a command something
like:

smartctl -l scterc,1800,70

That'll leave up to 180 seconds to keep retrying reads, and 7 seconds
for writes (doesn't matter what the write value is, you shouldn't be
writing anyway, but no point in waiting a long time for writes). Maybe
maybe maybe, very off chance, that this improves the chance the drive
firmware can recover data from these bad sectors.

Which by the way those bad sectors may have developed relatively
quickly. If some piece of surface material broke off and got caught
however briefly by the drive head, it could have scraped 300 sectors
instantly before the debris was flung off. Of course, it's also
possible it's been degrading slowly over six months.




-- 
Chris Murphy
