Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15AF120F63
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfLPQ0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 11:26:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLPQ0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 11:26:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so8004432wro.9
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2019 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuoW5wyGr6cmjeeul1Mvu9Fge6BaEsl+8uixypTRWx8=;
        b=cAK/moM//dasgkiJrhMBL8r/jf0/+RUNfOrX8aRYIHl4NARQQV2lOy6EKn/6kPrsxZ
         hRSyQSZudxDh5GSe2rLDBCthBC1q02BvJZ985j/htiCIB5LyRgVRMNgM9QtBRVDPCU3m
         BD4CaLTOVGr6guEWP3neN1x4SBseaPoXte0cE497b/krx0WBvTEd2s0XwKyRaf0rVDLz
         CeHdecBkLKDMG9OQuGw1136xSb1q5IYQ4WA/KTMNr9mB55y2zlKtaGt+q7jVSxHqZh6G
         djVTlPIHgRDUr3gCByIYYRY1yg39l3Z0Alwf81tL5mU9EZ+YjPtOLvNcOJpzgyP9+pgC
         PWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuoW5wyGr6cmjeeul1Mvu9Fge6BaEsl+8uixypTRWx8=;
        b=rGULTf0VHOWxE3yIFdkepM31IRugbul56ZvC0WMv8Z2Oqrtl84L99LALEPFww34iRM
         ZonrFQlP9EibgZQuFfUB7hn1+GWUWhg/DnFmM5sf+SaA9kmdEyMnqpZeYtE2T91Bx4pC
         Xtx63lBLeh9CInwF7YvsjfRaxTbEZi1wf55joxDQ4sJZf2rjsunuN80FKLKJVCTAeYEx
         H/mRD2+6WL6ARdUSmAxirpbZ/cIeBR1YT4IAYkvAF2/2DOirstA2BanlQoQLEw65RmcR
         7XeOOXDHABclIWTvI1wr5+IPK65QjqpTtdBdUQWgst7HTPS1bqo6BITCkylMnIKRs+7g
         z5Ag==
X-Gm-Message-State: APjAAAVp/6vKKXgh/LGMCfxH+mPrUOpwsThZNudC4Y+tcB/zjyYgyjtC
        SshYdHghEZYNRNjIn2plZTgixwpkHYoKPkO7iu0aVSw5bbBJiA==
X-Google-Smtp-Source: APXvYqyP/j0iG5dSAemcXBh7Mneg00VOOYfgVznECqtURNDkCAZTsYftUGhlY5NcuL2FkGMTriCMoVm1Lz290H/D8so=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr32471069wrm.262.1576513577214;
 Mon, 16 Dec 2019 08:26:17 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl> <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
 <CAJCQCtQMxVrmhuiv04wVBanhn2vPuxDwLWwU0QheSMnbPB_Sxw@mail.gmail.com> <CAN4oSBfmjuUS-MwrrcMMmvf7gN7pntAafy8aLP9Su0G-dpTYjg@mail.gmail.com>
In-Reply-To: <CAN4oSBfmjuUS-MwrrcMMmvf7gN7pntAafy8aLP9Su0G-dpTYjg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 16 Dec 2019 09:26:00 -0700
Message-ID: <CAJCQCtQV5orYh7Q8uXTeyYEQHAbgoKRQGgKhSZfC34sbX5uCWg@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 16, 2019 at 3:36 AM Cerem Cem ASLAN <ceremcem@ceremcem.net> wrote:
>
> > smartctl -l scterc /dev/
>
> SCT Error Recovery Control:
>            Read: Disabled
>           Write: Disabled

For daily production use I recommend changing both to 7 seconds, it's
possible to setup a udev rule for this so it's always in place for
specific drives by /dev/by whatever you want, wwn or serial or label.
Whereas /dev/sda /dev/sdb is not always reliably assigned during
startup.

The logic is that it's better to have quick failures. These produce
discrete errors, with the affected LBA for the sector, and Btrfs can
act on this with self-healing, whether it's an ordinary read, or a
scrub. Self-healing does require redundancy. But even with single copy
data, you'll get a path to file reference for the affected file. It's
often easier to just delete that file and copy it from backup.

Whereas with ERC disabled, it's uncertain what the error timeout is.
With consumer drives, so-called "deep recovery" is possible which can
take an extraordinary amount of time, and manifests as storage stack
slow down. But by default the kernel's SCSI block layer has a command
timer of its own, by default 30 seconds. If a command hasn't completed
in 30 seconds, this kernel command timer will try to reset the device.
Upon reset, the entire command queue is lost on SATA drives; on SAS
drives just that delayed command is excised, but in either case, it's
never discovered what sector is causing the delay. Essentially the
real problem gets masked by the reset.

The end result is that it's possible for bad sectors to just get worse
and worse (slower and slower recovery) until the data on them is lost
for good, and in the meantime the storage stack gets hung up on these
slow read delays as the drive firmware keeps retrying to read from
marginal sectors. There might be a reasonable use case for long
recoveries, e.g. a boot drive, with single copy data and metadata,
where it's better to have slow downs than to have EIO blow things up
in a non-obvious way. I personally would still favor short recovery
below 30 seconds, and that way I'll see a discrete drive read error
along with the blow up, and make the connection. Whereas slow downs
have no log entries until there's a link reset by the kernel.

Also, 7 seconds comes from what I typically see from NAS and
enterprise drives. So it's not a random pick, but other values are
sane as well as long as SCT ERC is less than the SCSI command timer
value (which is per block device, it is not a setting in the device,
it is a kernel setting, found in /sys )

Bit older reference but is still valid across Linux distros
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/online_storage_reconfiguration_guide/task_controlling-scsi-command-timer-onlining-devices


>
> It seems like the drive has STC ERC support but disabled. However some
> weird error is thrown with your correct syntax:
>
> =======> INVALID ARGUMENT TO -l: scterc,1800,70
>
> It's an interesting approach to setup long read time windows. I'll
> keep this in mind even though this time I'm determined to make the
> correct setup that will make such a data scraping job unnecessary.

It could be a firmware bug *shrug* try something else like:

-l scterc,1200,1200

Maybe it wants them to be identical.


> First problem was that I "hoped" the machine would just crash with
> "DRDY ERR"s when the disk has *any* problems.

Right. So instead look through logs suggesting there have been link
resets (typically from libata but it depends on what drives you have,
what this error looks like exactly). Link resets prevent the drive
specific error from happening. Hence you want the drive's internal
firmware to give up on error recovery before the kernel gives up on
command delays.

More here which itself has a pile of links to this same issue
affecting md arrays.

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch



-- 
Chris Murphy
