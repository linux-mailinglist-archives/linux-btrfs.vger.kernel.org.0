Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74045353581
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhDCUZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 16:25:44 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:42885 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhDCUZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Apr 2021 16:25:44 -0400
Received: by mail-pg1-f182.google.com with SMTP id g35so910412pgg.9;
        Sat, 03 Apr 2021 13:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+7Y5GINbi1mWBXHFvuCqJH2OIKRyOt6rdwA2FXpuIg=;
        b=sPrrSLhOivg517cLWSrH1b7+Ui/XqpD1RZIcN2M0fJQxLhfpoYkQYzXxNCe1CNUBGO
         hz641idptPbKeEWz9x2vi+8zCaE/5AUu+ssyntsA+Eobw4Aw+c2zA25Jlmhj3A4Neovi
         NfvTx3jpoYQdKeouT/OEPhvfAxzm38ssOkkCdwTC1QmpvXUIIe2KaSzR2lQTkbJlhkKF
         OlegxsEWyLi5QaUFxkNIhnbfvYjQbf0lN6/Tz3gHvtR0x3LNXEQ+DoWhLMLSrRlAgYpu
         sBMTYfD98N+A5OTBDdQIfJINQI2ybtXQ7z6OHQj2AVoWNbiUKJqTqSuHD5rv7rLc5a15
         7k4A==
X-Gm-Message-State: AOAM531POGN0TdH8KuECIbjjSyB0cAE7hnrw9R2/VrkaWRg9kA3/G850
        QKteSJX0alJMS3Q9X4bCi+Q=
X-Google-Smtp-Source: ABdhPJwRZRpuHqHOmcqD28IYH0vpIvbrZXVWjjRv0QQrhV9Nu/htIL3sthJFXGLwI8pxWH0VZVxp8w==
X-Received: by 2002:a62:52d7:0:b029:224:6be5:ab22 with SMTP id g206-20020a6252d70000b02902246be5ab22mr17693156pfb.63.1617481540374;
        Sat, 03 Apr 2021 13:25:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id co20sm11064775pjb.32.2021.04.03.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 13:25:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 673FE403EA; Sat,  3 Apr 2021 20:25:38 +0000 (UTC)
Date:   Sat, 3 Apr 2021 20:25:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>,
        Greg KH <gregkh@linuxfoundation.org>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20210403202538.GW4332@42.do-not-panic.com>
References: <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
 <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 03, 2021 at 12:24:07PM +0200, Lukas Middendorf wrote:
> 
> On 02/04/2021 20:02, Luis Chamberlain wrote:
> > No sorry, I dropped the ball on this but I managed to now spawn up the
> > virtual guests where I was doing development to reproduce this. Give
> > me some time and I will zero in on this now.
> > 
> > For now what I have is the following to test this, I next will work
> > on the userspace part.
> 
> I can report that your patch for test_firmware works (applied to current
> master from linus d93a0d4; I get some offsets and had to adjust some
> whitespace for it to apply). With that module (and resume test enabled) I
> get freezes at resume in the same cases that would also cause problems with
> si2168.

Beautiful!

> I'm testing this on bare metal F34 beta with / on a btrfs. I'm using nvidia
> driver again to make sure the system does not otherwise use any firmware
> from /usr/lib/firmware (confirmed with kernel debug messages for
> firmware_loader). My si2168 is not plugged in.

OK I was not able to reproduce but the details below also clarify why,
so I now was able to reproduce! So I don't need to specifically test
with this distro, but others may do so.

> I tested it with a normal population of files in /usr/lib/firmware , without
> test-firmware.bin and also with a random 1MiB file in place. I tested after
> a reboot so it does not do caching.
> With /usr/lib/firmware on a separate ext4 partition I can confirm with dmesg
> that the test_firmware suspend test actually works (does not freeze).
> With /usr/lib/firmware on btrfs it fails in both cases (with and without the
> firmware files).
> With caching (first suspend with the ext4 partition mounted, then a second
> suspend without) it does not freeze even with the firmware on btrfs.

OK thanks for confirming!

> One further thing I noticed which might be problematic in rare cases:
> According to the kernel debug messages, the firmware-loader does not attempt
> to cache the firmware during suspend, 

Correct, the goal with this test was to purposely *not* call for the
firmware prior to suspend, and instead *race* (do the wrong thing) at
resume. It shouldn't really stall... fail yes, but stall, that seems
fishy.

> if the previous call to
> request_firmware() has failed (file not present; call made during previous
> resume). In my opinion it should attempt to cache the firmware on suspend
> even in this case 

Yes, that is the *proper* way to do use the firmware API, but we want to
reproduce the stall, and so we have to recreate the issue you reported
by doing something bad.

> (If I remember correctly, firmware_request_cache also
> works without the file being present). In case some low-memory condition has
> caused the file system cache to lose the information about the file being
> non-present (or the file has been written after the initial attempt and is
> no longer in the file system cache), this might lead to freezes even for
> well-behaved drivers in case they reattempt to do request_firmware() on
> resume.
> If the firmware is found during resume, it is cached on further suspends.

Right.

> Given how long it took me to narrow down this problem in this (for me)
> reliably reproducible case, something like this happening at random would be
> almost impossible to debug/locate and might actually happen frequently in
> the wild.

OK thanks for the report!

> On 03/04/2021 00:19, Luis Chamberlain wrote:
> > Lukas, can you share your /etc/fstab ?
> 
> This is the core part (everything else is unmounted), I shortened the UUIDs.
> The ext4 mount of course is also unmounted when I want it to fail, with it
> in place it reliably not-fails.
> 
> UUID=<1> /                       btrfs   subvol=linux1 0 0
> UUID=<2> /usr/lib/firmware       ext4    defaults 1 1
> UUID=<1> /home/lukas             btrfs   subvol=linux1-f34-lukas 0 0
> tmpfs /home/lukas/.cache tmpfs size=16g,gid=lukas,uid=lukas,mode=700 0 0
> 
> > Also, how long do you stay in the boot before you try to suspend?
> 
> During my reproduction sessions usually only shortly 1-5min, but I think I
> have seen this also after a slightly longer time. I can try to let it sit
> for longer if you think that is important.

No, I was looking to see how easy it is to reproduce right after a
fresh boot, now that I can reproduce I confirm it happens right away.

> On 03/04/2021 00:58, Luis Chamberlain wrote:
> > On Fri, Apr 2, 2021 at 3:19 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > 
> > > Lukas, can you share your /etc/fstab ? Also, how long do you stay in
> > > the boot before you try to suspend?
> > 
> > OK I cannot reproduce the issue with the modified patch I sent to
> > test_firmware, which if you enable config_enable_resume_test will
> > trigger a request_firmware() on resume, thus trying to mimic the race
> > you note. To test this you can simply use a loopback filesystem for
> > your /lib/firmware and create a btrfs filesystem for it, and then run:
> > 
> > echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
> > 
> > systemctl suspend
> > 
> > Then resume. You should see "resume test" print on dmesg. I keep my
> > /lib/firmware/ empty and still, nothing.
> 
> Did you also try to create a random test-firmware.bin (I used 1M from
> /dev/urandom) instead of an empty /lib/firmware ?

No, right now I want to to just focus on fixing the stall you saw.

> If the directory is completely empty, it also does not freeze for me.

This is a very important piece of information, thanks!

> If the
> directory is empty, any attempt to access its content can likely be directly
> served from cache, even if the actual directory has never been accessed
> before, as long as /lib (which is a symlink to /usr/lib on fedora) has been
> accessed (which will likely always be true). So I have to further add to my
> previous findings that "firmware directory is not completely empty" is a
> further prerequisite for it to fail.

Indeed, that helps!

So creating say 1000 random files in /lib/firmware on a freshly created
btrfs partition helps reproduce:

mkfs.btrfs /dev/whatever
mount /dev/wahtever /lib/firmware
# Put it on /etc/fstab too

Generate 1000 random files on it:

```
for n in {1..1000}; do                                                          
    dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
done  
```

Then reboot, upon reboot do:

modprobe test_firmware
echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
systemctl suspend

If its a guest wake it up:

virsh dompmwakeup domidofguest

> > Can you provide kernel logs for where you are seeing things get stuck
> > at?
> 
> The log does not have any entries from resume. For the attempts where it
> freezes the last entry in journalctl is
> systemd-sleep[5050]: Suspending system...

I confirm.

> > Note that I had mentioned the races on suspend/resume do exist for any journaling
> > filesystem, but this typically happens if you are doing ongoing
> > writes. I suppose you are *not* doing writes and your filesystem is
> > idle.
> 
> I can of course not completely rule out some random write (log files or
> similar), but there is definitely no heavy writing going on. I think only
> writes caused by the act of suspending and resuming could cause it this
> reliably. I have seen it also with a completely isolated btrfs file system
> for /usr/lib/firmware, where there should not have been any writes. For ext4
> (which is also journaling) it works properly.

Nope, no writes are going on.

> > As such without kernel logs I cannot be sure what the issue is, but at
> > this point after the initial testing I've done I don't suspect this is
> > a firmware API issue. You might be better off just reposting your
> > patches with the respective Reviewed-by tags and pestering your
> > maintainer.
> 
> I will try to be a little bit more insistent this time. Is "just repost" the
> usual way to handle if patches are ignored?

You can repost, v2 just add my reviewed-by. Those patches are indeed
correct as they are calling for the firmware prior to resume. Maybe
clarify that.

But indeed there is also another issue which you reported which needs to
be fixed, and for that thanks so much for you patience! I'll be looking
into this!

  Luis
