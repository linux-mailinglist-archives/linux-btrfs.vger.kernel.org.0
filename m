Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D27131C94
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 00:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgAFX4i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 18:56:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34561 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgAFX4i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 18:56:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id c127so12981610wme.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 15:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ugwb9IxSVLbycnhdXAXnZ3KOuRRj1iaWXTYi2sS+AQ=;
        b=zf5MYEFomftlq5Fdbk9TOpMaT9Mj8s8+T3APxxWIQs7m5USA5t8TmV8f9SZcJX6YCM
         D66XRHnrWJDu0Nmr+8J1kAvClTGk3fccmj6kiVm9XowqTJW4IY0UNpLIsn/VHyBp5TmJ
         OMciH3jtTI51ggwgQTYRxmTMashNGrlfv4Hwf7FGHjTxM2kBCX/bEV59ZZpMLTc3zkdx
         OJKHSJtl0UdYfbXGF5O/SEu2vLs6XYqYytLDfXOveJ0kKlBGOXNyM1dfY2aXUsSCoQPz
         W+qkedWlQGbK1uTKNeYgMxv14oMo66xZst/8T/byksPtp/X79PJVv22q9IMXW5LriRne
         3okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ugwb9IxSVLbycnhdXAXnZ3KOuRRj1iaWXTYi2sS+AQ=;
        b=PXxpM1liEQKa5pigog80OEXZWX4d28i0uz86N8d6DdOcWIsk56SUtrPORah/jPodrF
         euzUmgxs0CgN5ZK7CpmMlllwqgeIys5mFPV8Q+I3ZOdRI+8A8L2KrGFAGg6oKhWWlMa7
         5H/ezZQyYsZIFn5XJ8KBcSjOqWeMNW2u+2+Mqa7/QJMWHeJjtOlgZaobdV0SLEbe4fH0
         tF3ZGmb2iPSZN8mSj60t2dGk4UrKFHFXCPqCJp3pMOySXP6o2KpejDJirimf5JPTW4wV
         bD2NSR1/jqEatVsy8bO3oc8x7N2q6te6INBpYmOh8FwstsIEtPDY5OGjPXLgNC3YXWmu
         cVjA==
X-Gm-Message-State: APjAAAUYTCj0Ao+qhtDcvbGK3kVxkA4m9TDrgy6bVdc49FAEpGZMQKt+
        9N8Cd9Nr1cYw3ca4SxQNByl0HSMaLY5fWAbFYwm8qA==
X-Google-Smtp-Source: APXvYqxJ51iBDJL7T9OByC33Wy3szKEfJKJ1akVXD6/KqZCg9zqOKo+t/oAHrAAgo00OcOershEdKbDXUUkB3WfKaJ0=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr39309718wmi.101.1578354995238;
 Mon, 06 Jan 2020 15:56:35 -0800 (PST)
MIME-Version: 1.0
References: <1794842.PFUSC7HjHz@paca>
In-Reply-To: <1794842.PFUSC7HjHz@paca>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 6 Jan 2020 16:56:19 -0700
Message-ID: <CAJCQCtRJV1ug8L1Q1pJ5ePJdnFP-osekbqzuDb8QSTQ5b0Tm1Q@mail.gmail.com>
Subject: Re: Errors after SATA hard resets: parent transid verify failed, csum
 mismatch on free space cache
To:     Stephen Conrad <conradsd@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 6, 2020 at 10:32 AM Stephen Conrad <conradsd@gmail.com> wrote:

> In January 2019 the file system remounted read-only.  I have retained the dmesg
> logs and notes on the actions I took at that time.  Summary is that I saw a
> bunch of SATA "link is slow to respond" and "hard resetting link" messages

This is raid1? I can't tell.

Anyway, this is common when drive SCT ERC is a greater duration than
the SCSI command timer (defaults to 30s). Consumer drives often have
it disabled and you'd have to dig through specs to find out what
duration that means, but with HDDs it is often way more than 30s. The
idea is single drive "deep recovery" - it's better for the drive to
become slow than to report EIO for a bad sector. That may be specious,
but for sure it's not a good idea for RAID. First choice is to set SCT
ERC less than 30s. Common is 70 deciseconds for NAS and enterprise
drives. Second choice, if SCT ERC cannot be configured, is change the
SCSI command timer to something like 120-180s, which I know is crazy
but there you go. More here.

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

Note that SCT ERC is a drive firmware configuration. Where the SCSI
command timer is a kernel timer that applies per (whole) block device.
Both reset to defaults on power cycle. You can use a udev rule for
either of these (you only need one, again SCT ERC is preferred if
available). SCT ERC is set by smartctl, and SCSI command timer is set
via sysfs so you can just echo the value you want.


> followed by BTRFS errors, "BTRFS: Transaction aborted (error -5)", and a stack
> trace.  I tried a few things (unsuccessfully) and had to power down the
> hardware.  After a power cycle the file system mounted R/W as normal.   I then
> ran a btrfs check and btrfs scrub which showed no errors.

Make sure timeout mismatch doesn't exist, and if you make a change,
redo the scrub to be sure. You really want the drive to give up as
fast as  possible so Btrfs is informed of the bad read, which will
include the bad sector's LBA, Btrfs can look up what's there, find a
good copy from mirror, and write over the bad sector causing it to be
fixed up.


> In October 2019 I had a similar event.  Logs show SATA "hard resetting link"
> for both drives as well as BTRFS "lost page write due to IO error" messages.

Yeah virtually certain it's a misconfiguration. Very common. Bad
sectors start out recovering pretty quick, but get slower and slower,
eventually hitting the 30s SCSI command timer, and then the kernel
does a link reset. And then these things never get fixed up, because
when the link is reset, the entire drive's command queue is lost. That
means no discrete read error, and no LBA for the bad sector which
Btrfs needs to know in order to find a good copy of that data and
write it back to the bad sector, thereby fixing it.


> The logs show "forced readonly", "BTRFS: Transaction aborted (error -5)" and a
> stack trace.  After hard power cycle I ran a "btrfs check -p" which resulted
> in a stream messages like "parent transid verify failed on 2418006753280
> wanted 34457 found 30647" and then the following:
> parent transid verify failed on 2417279598592 wanted 35322 found 29823

Yuck. That's a lot of missing generations. I have no idea how that's
possible, especially if this is raid1 (or DUP) metadata.


> # btrfs dev stat /mnt/
> [/dev/mapper/K1JG82AD].write_io_errs   15799831
> [/dev/mapper/K1JG82AD].read_io_errs    15764242
> [/dev/mapper/K1JG82AD].flush_io_errs   4385

That is incredibly bad. That drive has dropped many millions of
writes, and the flush errors could mean this drive is failing to
adhere to proper write ordering. Maybe Qu can tell us.


> At this point I was still seeing occasional log entries for "parent transid
> verify failed" and "read error corrected" so I decided to upgrade from Debian9
> to Debian10 to get more current tools.  Running a scrub with Debian10 tools I
> saw errors detected and corrected... I also saw sata link issues during the
> scrub...

Right. You'll also find this discussed a ton on the linux-raid@ list
for the very same reason, it's not unique to Btrfs.


> # date
> Mon 09 Dec 2019 10:29:05 PM EST
> # btrfs scrub start -B -d /dev/disk/by-uuid/X
> scrub device /dev/mapper/K1JG82AD (id 1) done
>         scrub started at Sun Dec  8 23:06:59 2019 and finished after 05:46:26
>         total bytes scrubbed: 2.80TiB with 9490467 errors
>         error details: verify=1349 csum=9489118
>         corrected errors: 9490467, uncorrectable errors: 0, unverified errors:
> 0

Cool!

BTW you'll want to reset those stats with -z, so that you can tell if
these errors start happening again.

> 1) How should I interpret these errors?  Seems that btrfs messages are telling
> me that there are an abundance of errors everywhere, but that they are all
> correctable...  Should I panic?  Should I proceed?

Never panic. Often results in misunderstanding the problem and bad decisions.

The drive with all the errors has a bunch of bad sectors, maybe by now
they've been repaired, but it's not clear until you ensure the timeout
mismatch is addressed. Then the scrub will be reliable, even if there
are stalls on bad sectors that take a damn long time to either
successfully read or fail with the proper error.

What you really want are consumer drives with configurable SCT ERC; or
get "NAS" drives which already have this set to a default of 70
deciseconds.

>
> 2) Is my file system broken? Is my data corrupted?  Should I be able to scrub
> etc to get back to operation without scary log messages? Can I trust data that
> I copy out now, or need to fall back on old/incomplete backups?

Btrfs will EIO rather than propagate corrupt data to user space. You
can trust the data you copy out. This assumes all data has checksums.
If you're using nocow for anything, then there can be silent
corruption.


> 3) What steps are recommended to backup/offload/recover data?  I am considering
> installing the disks into a different machine, then mounting the array read-
> only, and then pulling a full copy of the data...
>
> 4) What steps should I take to clean up the file system errors/messages?  Start
> fresh after full backup, (though I hate the idea of migrating off a redundant
> array onto a single disk in the process)?  Scrub etc?  Evaluate each disk
> independently and rebuild one from the other?

I think all of these are addressed, but let me know if something isn't clear.



-- 
Chris Murphy
