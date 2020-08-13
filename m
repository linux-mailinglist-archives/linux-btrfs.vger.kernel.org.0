Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5890F243D88
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHMQh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 12:37:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37735 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgHMQhz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 12:37:55 -0400
Received: by mail-io1-f65.google.com with SMTP id b16so7988580ioj.4;
        Thu, 13 Aug 2020 09:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c+txWl2RxzE1fNEzMCl5V1pSh5IxPcSVgzqkCk6AxRE=;
        b=ZLJV2On2wenZcyqFYBRBF+tct1BlVs64UKxKz67Kb80gu5nMJRwVsDBy2pTZ2dxbql
         92DV8T2+CNBeIU3L5tFyQxBSy9PkWnzYDibzpLIc60sdXFdpR20tcMjFtHiEDvBYAhYT
         b1zavEgcxkhNj7ejlkTzkfotcJBQ+Z5DsjQpHWO+JGcaPV5ebv9+7a5K9R44jDUGqBlv
         Ug++otO0DexoeEIpOXPcwFjyYMaQYbfBiu+zR1682Fk9BXo7ovK0I9oWNneRbOc4vsAc
         h2/8LYwlUTuiutGDPM32pY2PLCZ3KwVtB0zzZm34BvvqShm8eFF3K1fbLY0WGvZlQpEJ
         IdvQ==
X-Gm-Message-State: AOAM532hNkgyNe8CfvPFqKlCKPQ5faNjb6/2zGzqde0723akg3RLM0PG
        HsYPZDVH+GELVPZLsTRUCO0=
X-Google-Smtp-Source: ABdhPJwfQgyg8Va1ymGCKeS6Wp7enTcOMHvnbgqrWVQPvbPRSLdU5VbHzpi0AHN/VXjLLVqZO2Ut8g==
X-Received: by 2002:a05:6638:d4f:: with SMTP id d15mr5887306jak.119.1597336671515;
        Thu, 13 Aug 2020 09:37:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q3sm2904067ilg.46.2020.08.13.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 09:37:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4812F403DC; Thu, 13 Aug 2020 16:37:49 +0000 (UTC)
Date:   Thu, 13 Aug 2020 16:37:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>,
        Anand Jain <anand.jain@oracle.com>, mcgrof@kernel.org
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20200813163749.GV4332@42.do-not-panic.com>
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 09, 2020 at 08:51:35PM +0200, Lukas Middendorf wrote:
> Hi,

Hey Lukas, thanks for the report!

> I'm seeing system freezes during resuming from suspend to RAM if all of the
> following is true:
> 1. /usr/lib/firmware is on btrfs
> 2. my Hauppauge WinTV-dualHD USB DVB tuner (contains si2168) is connected
> 3. the firmware file /usr/lib/firmware/dvb-demod-si2168-b40-01.fw (or
> knowledge about its non-existstence)

OK that is SI2168_B40_FIRMWARE and the driver in question is part of
drivers/media/dvb-frontends/si2168.c, its a 1 file driver so si2168
is the respective driver.

> is NOT in a cache in RAM

But the firmware is supposed to go be cached in RAM prior to suspend,
given this driver uses the request_firmware() call, only the async call
request_firmware_nowait() lets you opt-out of the cache, and likewise
with request_firmware_into_buf() you don't use the cache.

Note that some drivers implement their own caching mechanism as well,
like iwlwifi, and so don't need this cache.

Please refer to:

https://www.kernel.org/doc/html/latest/driver-api/firmware/firmware_cache.html

> The exact outcome depends on whether or not I use nvidia or nouveau driver
> an whether or not I have X running. With nvidia I only get some kernel
> messages from suspend on screen, but the system does not seem to react to
> anything (emergency FS sync magic sysrq sometimes works judging from
> HDD-LED). With nouveau and X11 running I just get a black screen with mouse
> cursor and no apparent reaction to key presses (again except for emergency
> FS sync magic sysrq).

If the nouveau driver doesn't yet have proper suspend working, my guess
is that the issue is the dependency on resources by nvidia ont he dvb
driver, and if suspend may be broken there, ordering on suspend would
not be correct. This is only true is suspend on nouveau is broken and I
don't know the anwer to this.

If suspend is not implemented correctly through the entire pipeline then
your only option is to blacklist the driver. On debian this is what I
use for hibernation blacklisting, this will remove the driver prior to
hibernation:

/etc/hibernate/blacklisted-modules

> With nouveau but without X11 running the system even reacts to
> ctrl+alt+F1/F2/F3, but only the first ttys are displaying anything and login
> or any other input is not possible.
> Unplugging the USB device after resume does not return the system back to
> normal.

Please debug further with nouveau as that is the only driver we have
control over.

> Details on the above conditions:
> 1. If /usr/lib/firmware is on ext4 everything works fine. I originally
> noticed this with the complete / on btrfs vs. ext4, but putting
> /usr/lib/firmware on a separate partition is sufficient to make it work or
> fail, depending on the fs type.

The firmware loader just reads the file directly from the filesystem,
that should complete fine but we can find out more details by you
enabling debugging:

echo "file drivers/base/* +p" > /sys/kernel/debug/dynamic_debug/control  

> 2. The si2168 driver drivers/media/dvb-frontends/si2168.c has its
> si2168_init() called during resume. In this function a call to
> request_firmware() happens. The firmware is not actually loaded to the
> device on boot or initial usb connection but just during resume and when the
> DVB-Tuner is used.

That's the thing, the cache is built out of prior requests. We build the
actual firmware cache through a notifier on fw_pm_notify(), and we build
the cache prior to suspend then with device_cache_fw_images().

So whatever issues you might have during suspend/resume because of
a missing firmware would still be present on this driver because the
driver never called for the firmware. If upon resume the firmware is
requested, we race against the filesystem looking for it and that today
can be racy with any filesystem. That fact that you only see it with
one filesystem can be a one-off, as explained in more detail below.

> 3. a) if the device has been used and the firmware has already been loaded,
> the load succeeds during resume

If the device has been used, so long as the file is still present prior
to suspend, then the cache for it will be created. That explains why
this works.

>    b) if the firmware file is not present and the directory content of
> /usr/lib/firmware has been listed (e.g. through loading of a different
> firmware from there; by the nouveau driver in my case) the firmware load
> fails but does not freeze the system

Can you clarify if you mean then that in this case the dvb device is not
used?

Which driver firmware load fails?

>    c) manually reading the firmware files before suspend can make the resume
> succeed, but this does not seem to be reliable

That may because of the dentry cache, and so helping races, doing
something similar as to what the firmware cache does, but in hacky way.

>    d) modifying the si2168 by adding calls to firmware_request_cache() in
> si2168_probe() makes the firmware loading during resume succeed.

That indeed seems like a good idea in general for dvb that should
probably be generalized, if dvb had a way to get a dvb's driver
firmware name and indeed all dvb drivers are not skipping the firmware
cache today.

>    e) having the firmware files not installed freezes the system during
> resume if the content of /usr/lib/firmware has not been listed before
> suspend (e.g. installing the nvidia driver, so the nouveau driver does not
> access this directory)

That may be the same issue as in b) assuming that you meant you didn't
use the dvb device, and that the firmware load issue is from nouveau.

Are all firmware files used by nouveau upon resume the samea as during
probe? If not using firmware_request_cache() for each of them would be
a good idea to resolve possible races issues.

>    f) the system freezes during resume if nothing has caused the firmware
> file to be read from the drive before suspend

Which driver? And yes, this is exactly why the firmware cache thing was
done, and its why that for driver that don't use the firmware cache,
they implement their own caching mechanism.

The firmware must be cached prior to suspend.

> I have observed this with all kernel versions I have tested so far: fedora
> kernels 5.5.18, 5.6.19, 5.7.9, 5.7.11
> vanilla kernels 5.7.12, 5.8.0 and current master (git 06a81c1c)
> 
> Unfortunately I have not yet succeeded in getting useful debug output
> (nothing is in the log files after a reset).  When I disable printk
> console_suspend I can get some messages of the resume process but nothing
> related to si2168 is shown on screen.

Try dynamic printk stuff mentioned.

Even though some of the things you say are not clear yet.

> This certainly looks like the documented promise of request_firmware()
> "The function can be called safely inside device’s suspend and resume
> callback."
> does not hold if 

Inded, this is just false outdated information and needs to be updated.

For now, this should just be re-written to mention in order to help with
current races against the filesystem (detailed way at the bottom of this
email) being brought up on resume, the firmware API relies on a firmware
cache mechanism, and when that is used it is safe to call the
request_firmware() call on resume. If a driver has not yet requested for
the firmware prior to suspend then the firmware cache will not have the
firmware cached in memory prior to suspend, and so to help with this
firmware_request_cache() can be used.  The call to
firmware_request_cache() can be made on device's probe call.

Some drivers may not want to use the firmware cache though, such as
drivers with large firmware which don't want large firmwares to be
taking so much memory prior to suspend/hibernation, and so certain APIs
allow to skip the firwmare cache. Those drivers must implement their own
solutions to ensure that if the firmware is needed on resume it will
be available or not needed.

> the requested firmware files are residing on a btrfs.

There are two issues here. One is that you are using a driver which
may have resume issues because the driver's firmware is not cached
prior to suspend.

The second issue may indeed be a freeze / issues of reading a filesystem
*while racing to suspend / resume*. This issue can happen with any
journaling filesystem today.

More on this below.

In so far as nouveau is concerned, remove the dvb driver and let's debug
that alone separately, and see if the issue is not related to your dvb
driver first.

> The documentation of firmware_request_cache() states that this function
> should be called before suspend if the firmware has not been loaded earlier.
> From the combined documentation I would expect that request_firmware() might
> fail during resume if the firmware is not yet in cache, but it should not
> freeze the system.

Indeed, but then again doing a a race against a filesystem in between
suspend/resume can cause all sorts of issues today, so btrfs is not the
only one with issue there. I had found issue with xfs as well [0]:

[0] https://lwn.net/Articles/735382/

I addressed a topic on this particular issue at LSFFMM in 2018, and here
are the notes from that session:

https://lore.kernel.org/linux-fsdevel/20180426212243.GA27853@wotan.suse.de/

I will pick up this work again now, but it will take a bit of time.

> I'm not sure who really is to blame here:
> - BTRFS (ext4 is fine after all)
> - the firmware loader because the implementation or the documentation are
> wrong
> - si2168 because of not loading the firmware or calling
> firmware_request_cache() before suspend. Also I don't think it is even
> necessary to load the firmware during resume, it should be sufficient to
> load the firmware when the tuner is used. I'm not sure though whether the
> dvb-frontend driver structure allows to properly distinguish between
> resuming and initialization before device usage. The problem can definitely
> be worked around here until the root cause is fixed. I can provide a patch
> if this solution is seen as appropriate.
> 
> I'm putting all the maintainers and/or lists of the possible culprits on CC.

Indeed send the patch to use firmware_request_cache() for si2168.

If you still have issues with nouveau, remove the si2168 driver and see
if you can recreate the issue. If not then something between the two
on suspend is likely the issue. But if the issue still persists then
it would seem to be an issue with suspend on nouveau.

The generic filesystem races on suspend/resume are known, and I will
tackle that once I am done with some other task I am completing.

  Luis
