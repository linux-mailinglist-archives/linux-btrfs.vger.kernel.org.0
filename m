Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217991873E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 21:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbgCPUSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 16:18:00 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42036 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732518AbgCPUSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 16:18:00 -0400
Received: by mail-qv1-f65.google.com with SMTP id ca9so9626828qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5fWNXstZejEalbH2FKIJMks7PiWEcLUS3lVT4hM8h0=;
        b=d4vXbCAJZNkx/d/oSFzNSsqQFL/EaPFFw66nG/5xVq0p0Kfm9mnnd/GF5qAZzQ0D3u
         3LXJKbrJdKOW7X/ov7K0WBeBwUAZQSVR+Tkihul4NnNv/euD2qkMUo8tyGACDK4GdidH
         SdBpHvu67bqmx2FZHi4OYhsPi3uK9Eo26sfogPsCN568IyHO0nmiOe7hG5Bzs9Wtt1l/
         6PnUv2ylVWslv4/s7DRQub/P1Mds0E654sYchMWXmIBOOhhfYQTs8TZVJ5SMNMGIl7Cv
         LaQ4RAKOPwVMyDBcl+HfJlrIz1z8ic/R5g43WrImSzuV6eusPzBxkP9rMC9grVsdoaGP
         AdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5fWNXstZejEalbH2FKIJMks7PiWEcLUS3lVT4hM8h0=;
        b=IxxCYm8AmAGbD61JR/QV0yYVR2C3olLvdzSnS5HYfv0K29H4oR8g9hFFxCBDE6xsf/
         QVsAYnO6pH34AYsxq1LduZmnUvyFvodmYSu8rGIuXbTycy0wAYLnL1KNHT40LDS69ehz
         zzSkcQZ9QYglf/BH1VI1nCYFApbMIDyanXlEF2dR0dKGCe6qM7kdNnDlF2X/nvJZbvjt
         zrJyn0hGf28YR3MF8PCcwjAYf5BtANfdsPkFe577lUkkbBTMEh251/Kseayk8unvoqBU
         a81PdIjERb45PsCQp3YZ0J922rYaDkaVESHuc0xuyqo5Bk8QrTc+sl1bHCG8Mp1Q/epM
         CPCw==
X-Gm-Message-State: ANhLgQ1tCu7r2vmHeunIiUh6PFrqUDj1JibAvr0TyigvQW49HfA0ImeQ
        OCOtmCMwcfuT36VZPz1mTUQ=
X-Google-Smtp-Source: ADFU+vsANIVEQUqMT5TQ2YeUmjj15hqMVIN73vwNoIXuqzZMfJBsKUnuPjNIPG78KLUL7JwCHbbWYQ==
X-Received: by 2002:a0c:a910:: with SMTP id y16mr1578994qva.139.1584389876353;
        Mon, 16 Mar 2020 13:17:56 -0700 (PDT)
Received: from paca.localnet (c-98-229-166-121.hsd1.ma.comcast.net. [98.229.166.121])
        by smtp.gmail.com with ESMTPSA id w18sm451462qkw.130.2020.03.16.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 13:17:55 -0700 (PDT)
From:   Stephen Conrad <conradsd@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Errors after SATA hard resets: parent transid verify failed, csum mismatch on free space cache
Date:   Mon, 16 Mar 2020 16:17:54 -0400
Message-ID: <6003403.r5gNk4GDqt@paca>
In-Reply-To: <CAJCQCtRJV1ug8L1Q1pJ5ePJdnFP-osekbqzuDb8QSTQ5b0Tm1Q@mail.gmail.com>
References: <1794842.PFUSC7HjHz@paca> <CAJCQCtRJV1ug8L1Q1pJ5ePJdnFP-osekbqzuDb8QSTQ5b0Tm1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Monday, January 6, 2020 6:56:19 PM EDT Chris Murphy wrote:
> On Mon, Jan 6, 2020 at 10:32 AM Stephen Conrad <conradsd@gmail.com> wrote:
> > In January 2019 the file system remounted read-only.  I have retained the
> > dmesg logs and notes on the actions I took at that time.  Summary is that
> > I saw a bunch of SATA "link is slow to respond" and "hard resetting link"
> > messages
> This is raid1? I can't tell.
> 

# btrfs filesystem show <UUID>
Label: none  uuid: <UUID>
        Total devices 2 FS bytes used 2.80TiB
        devid    1 size 5.46TiB used 2.80TiB path /dev/mapper/XXX
        devid    2 size 5.46TiB used 2.80TiB path /dev/mapper/YYY
 
# btrfs filesystem df /mnt/raid 
Data, RAID1: total=2.80TiB, used=2.80TiB
System, RAID1: total=32.00MiB, used=416.00KiB
Metadata, RAID1: total=4.00GiB, used=3.16GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

> Anyway, this is common when drive SCT ERC is a greater duration than
> the SCSI command timer (defaults to 30s). Consumer drives often have
> it disabled and you'd have to dig through specs to find out what
> duration that means, but with HDDs it is often way more than 30s. The
> idea is single drive "deep recovery" - it's better for the drive to
> become slow than to report EIO for a bad sector. That may be specious,
> but for sure it's not a good idea for RAID. First choice is to set SCT
> ERC less than 30s. Common is 70 deciseconds for NAS and enterprise
> drives. Second choice, if SCT ERC cannot be configured, is change the
> SCSI command timer to something like 120-180s, which I know is crazy
> but there you go. More here.
> 
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
> 
> Note that SCT ERC is a drive firmware configuration. Where the SCSI
> command timer is a kernel timer that applies per (whole) block device.
> Both reset to defaults on power cycle. You can use a udev rule for
> either of these (you only need one, again SCT ERC is preferred if
> available). SCT ERC is set by smartctl, and SCSI command timer is set
> via sysfs so you can just echo the value you want.
> 

These are WD Red Pro drives.  At the time I set things up (Fall 2017) they 
were not fully supported in smartmontools and while I was aware of the 
importance of SCT ERC I was unable to see or change the settings.  Based on 
some internet hearsay I proceeded with assumption that the default would be 
acceptable.

Now (2020 / Debian 10) they are fully supported by smartmontools:
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.19.0-8-amd64] (local build)
Model Family:     Western Digital Red Pro
Device Model:     WDC WD6002FFWX-68TZ4N0
Firmware Version: 83.H0A83
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
SMART overall-health self-assessment test result: PASSED
SCT capabilities:              (0x003d) SCT Status supported.
                                        SCT Error Recovery Control supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

# smartctl -l scterc /dev/disk/by-id/ata-WDC_WD6002FFWX-68TZ4N0_...
SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

So at least now both disks look like they are defaulting to 7 seconds.  Since 
this is a firmware thing I presume that they always have been at 7 seconds.

# cat /sys/block/sdb/device/timeout 
30
# cat /sys/block/sdc/device/timeout 
30

So all of my timing looks like it is (and probably always has been) good...

> > followed by BTRFS errors, "BTRFS: Transaction aborted (error -5)", and a
> > stack trace.  I tried a few things (unsuccessfully) and had to power down
> > the hardware.  After a power cycle the file system mounted R/W as normal.
> >   I then ran a btrfs check and btrfs scrub which showed no errors.
> 
> Make sure timeout mismatch doesn't exist, and if you make a change,
> redo the scrub to be sure. You really want the drive to give up as
> fast as  possible so Btrfs is informed of the bad read, which will
> include the bad sector's LBA, Btrfs can look up what's there, find a
> good copy from mirror, and write over the bad sector causing it to be
> fixed up.
> 
> > In October 2019 I had a similar event.  Logs show SATA "hard resetting
> > link" for both drives as well as BTRFS "lost page write due to IO error"
> > messages.
> Yeah virtually certain it's a misconfiguration. Very common. Bad
> sectors start out recovering pretty quick, but get slower and slower,
> eventually hitting the 30s SCSI command timer, and then the kernel
> does a link reset. And then these things never get fixed up, because
> when the link is reset, the entire drive's command queue is lost. That
> means no discrete read error, and no LBA for the bad sector which
> Btrfs needs to know in order to find a good copy of that data and
> write it back to the bad sector, thereby fixing it.
> 
> > The logs show "forced readonly", "BTRFS: Transaction aborted (error -5)"
> > and a stack trace.  After hard power cycle I ran a "btrfs check -p" which
> > resulted in a stream messages like "parent transid verify failed on
> > 2418006753280 wanted 34457 found 30647" and then the following:
> > parent transid verify failed on 2417279598592 wanted 35322 found 29823
> 
> Yuck. That's a lot of missing generations. I have no idea how that's
> possible, especially if this is raid1 (or DUP) metadata.
> 
> > # btrfs dev stat /mnt/
> > [/dev/mapper/K1JG82AD].write_io_errs   15799831
> > [/dev/mapper/K1JG82AD].read_io_errs    15764242
> > [/dev/mapper/K1JG82AD].flush_io_errs   4385
> 
> That is incredibly bad. That drive has dropped many millions of
> writes, and the flush errors could mean this drive is failing to
> adhere to proper write ordering. Maybe Qu can tell us.
> 
> > At this point I was still seeing occasional log entries for "parent
> > transid
> > verify failed" and "read error corrected" so I decided to upgrade from
> > Debian9 to Debian10 to get more current tools.  Running a scrub with
> > Debian10 tools I saw errors detected and corrected... I also saw sata
> > link issues during the scrub...
> 
> Right. You'll also find this discussed a ton on the linux-raid@ list
> for the very same reason, it's not unique to Btrfs.
> 
> > # date
> > Mon 09 Dec 2019 10:29:05 PM EST
> > # btrfs scrub start -B -d /dev/disk/by-uuid/X
> > scrub device /dev/mapper/K1JG82AD (id 1) done
> > 
> >         scrub started at Sun Dec  8 23:06:59 2019 and finished after
> >         05:46:26
> >         total bytes scrubbed: 2.80TiB with 9490467 errors
> >         error details: verify=1349 csum=9489118
> > 
> >         corrected errors: 9490467, uncorrectable errors: 0, unverified 
errors:
> > 0
> 
> Cool!
> 
> BTW you'll want to reset those stats with -z, so that you can tell if
> these errors start happening again.
> 
> > 1) How should I interpret these errors?  Seems that btrfs messages are
> > telling me that there are an abundance of errors everywhere, but that
> > they are all correctable...  Should I panic?  Should I proceed?
> 
> Never panic. Often results in misunderstanding the problem and bad
> decisions.
> 
> The drive with all the errors has a bunch of bad sectors, maybe by now
> they've been repaired, but it's not clear until you ensure the timeout
> mismatch is addressed. Then the scrub will be reliable, even if there
> are stalls on bad sectors that take a damn long time to either
> successfully read or fail with the proper error.
> 
> What you really want are consumer drives with configurable SCT ERC; or
> get "NAS" drives which already have this set to a default of 70
> deciseconds.
> 

As I just added above, these are WD Red Pro drives.

> > 2) Is my file system broken? Is my data corrupted?  Should I be able to
> > scrub etc to get back to operation without scary log messages? Can I
> > trust data that I copy out now, or need to fall back on old/incomplete
> > backups?
> 
> Btrfs will EIO rather than propagate corrupt data to user space. You
> can trust the data you copy out. This assumes all data has checksums.
> If you're using nocow for anything, then there can be silent
> corruption.
> 
> > 3) What steps are recommended to backup/offload/recover data?  I am
> > considering installing the disks into a different machine, then mounting
> > the array read- only, and then pulling a full copy of the data...
> > 
> > 4) What steps should I take to clean up the file system errors/messages? 
> > Start fresh after full backup, (though I hate the idea of migrating off a
> > redundant array onto a single disk in the process)?  Scrub etc?  Evaluate
> > each disk independently and rebuild one from the other?
> 
> I think all of these are addressed, but let me know if something isn't
> clear.

I have pulled the drives from the original server and installed them in a 
different workstation.  On that system I mounted the array read-only 
(deliberately) and made a new additional backup copy of all the files.  Neither 
drive had any SMART errors logged and both disks passed a long self test.

At that point I ran a btrfs check and step "[2/7] checking extents" logs a 
number of errors.  I am seeing four errors like "space cache generation (xxx) 
does not match inode (yyy)", twelve errors like "csum mismatch on free space 
cache", and each of those errors are followed by a "failed to load free space 
cache for block group ZZZZ".  I then mounted read/write and ran a scrub, which 
reported zero errors.  Re-running the btrfs check however shows the same 
errors as before.

In this entire process neither disk had any more link reset errors while 
installed in the new(different) system and the error counts shown by "btrfs dev 
stat" remained constant.  I also note that he smart data for these drives has 
a much higher "Power_Cycle_Count" than expected for the server, so either the 
link errors were resulting in disk power cycles, or perhaps the disk was power 
cycling and causing link resets.  In any case it seems that my original 
problem is hardware related (power supply/firmware/chipset/etc.).  Seems my 
disks are good but I still have residual file system trouble.

At this point what are my options to correct the remaining errors shown in 
btrfs check?  Then what steps can I take to verify my data integrity and gain 
confidence that everything is OK?

In order to debug the hardware on the original server, any ideas on generating 
a lot of disk activity to try to test for link resets without risking any 
data?

Thanks



