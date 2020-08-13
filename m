Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302182440ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMVxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMVxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 17:53:38 -0400
Received: from mail.tuxforce.de (tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5CEC061757;
        Thu, 13 Aug 2020 14:53:38 -0700 (PDT)
Received: from desktop.fritz.box (2001-4dd5-ac5b-0-6dff-1ee7-1f0b-53a0.ipv6dyn.netcologne.de [IPv6:2001:4dd5:ac5b:0:6dff:1ee7:1f0b:53a0])
        by mail.tuxforce.de (Postfix) with ESMTPSA id D3E2C52008B;
        Thu, 13 Aug 2020 23:53:36 +0200 (CEST)
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
 <20200813163749.GV4332@42.do-not-panic.com>
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
Date:   Thu, 13 Aug 2020 23:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813163749.GV4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Luis,

On 13/08/2020 18:37, Luis Chamberlain wrote:
> On Sun, Aug 09, 2020 at 08:51:35PM +0200, Lukas Middendorf wrote:
>> The exact outcome depends on whether or not I use nvidia or nouveau driver
>> an whether or not I have X running. With nvidia I only get some kernel
>> messages from suspend on screen, but the system does not seem to react to
>> anything (emergency FS sync magic sysrq sometimes works judging from
>> HDD-LED). With nouveau and X11 running I just get a black screen with mouse
>> cursor and no apparent reaction to key presses (again except for emergency
>> FS sync magic sysrq).
> 
> If the nouveau driver doesn't yet have proper suspend working, my guess
> is that the issue is the dependency on resources by nvidia ont he dvb
> driver, and if suspend may be broken there, ordering on suspend would
> not be correct. This is only true is suspend on nouveau is broken and I
> don't know the anwer to this.

Sorry for being a bit unclear here. nouveau seems to be working 
perfectly fine for me when it comes to this issue. Not using nouveau 
actually adds one more case in which the system freezes (when no 
firmware files are installed; case e) below). Of course I can not 
completely rule out a different problem with the nouveau driver, but my 
problem seems to be caused by si2168 only.

> If suspend is not implemented correctly through the entire pipeline then
> your only option is to blacklist the driver. On debian this is what I
> use for hibernation blacklisting, this will remove the driver prior to
> hibernation:
> 
> /etc/hibernate/blacklisted-modules

I will likely not have to do that now with the proper solution I have 
for si2168, but this can come in handy in the future should I hit some 
other suspend problem.

>> With nouveau but without X11 running the system even reacts to
>> ctrl+alt+F1/F2/F3, but only the first ttys are displaying anything and login
>> or any other input is not possible.
>> Unplugging the USB device after resume does not return the system back to
>> normal.
> 
> Please debug further with nouveau as that is the only driver we have
> control over.

Sure. I only mentioned the nvidia driver because the case "no firmware 
files installed" only seems to freeze the system on resume with the 
nvidia driver but not with nouveau.

>> Details on the above conditions:
>> 1. If /usr/lib/firmware is on ext4 everything works fine. I originally
>> noticed this with the complete / on btrfs vs. ext4, but putting
>> /usr/lib/firmware on a separate partition is sufficient to make it work or
>> fail, depending on the fs type.
> 
> The firmware loader just reads the file directly from the filesystem,
> that should complete fine but we can find out more details by you
> enabling debugging:
> 
> echo "file drivers/base/* +p" > /sys/kernel/debug/dynamic_debug/control

I already figured that out (I used "module firmware_class" though).


>> 2. The si2168 driver drivers/media/dvb-frontends/si2168.c has its
>> si2168_init() called during resume. In this function a call to
>> request_firmware() happens. The firmware is not actually loaded to the
>> device on boot or initial usb connection but just during resume and when the
>> DVB-Tuner is used.
> 
> That's the thing, the cache is built out of prior requests. We build the
> actual firmware cache through a notifier on fw_pm_notify(), and we build
> the cache prior to suspend then with device_cache_fw_images().
> 
> So whatever issues you might have during suspend/resume because of
> a missing firmware would still be present on this driver because the
> driver never called for the firmware. If upon resume the firmware is
> requested, we race against the filesystem looking for it and that today
> can be racy with any filesystem. That fact that you only see it with
> one filesystem can be a one-off, as explained in more detail below.
> 
>> 3. a) if the device has been used and the firmware has already been loaded,
>> the load succeeds during resume
> 
> If the device has been used, so long as the file is still present prior
> to suspend, then the cache for it will be created. That explains why
> this works.

Yes, indeed. I had confirmed that with the firmware_class debug messages 
enabled.

> 
>>     b) if the firmware file is not present and the directory content of
>> /usr/lib/firmware has been listed (e.g. through loading of a different
>> firmware from there; by the nouveau driver in my case) the firmware load
>> fails but does not freeze the system
> 
> Can you clarify if you mean then that in this case the dvb device is not
> used?
> 
> Which driver firmware load fails?

With "not used" I mean that the device has been recognized, the si2168 
module is loaded and si2168_probe() has been called on the device, but I 
have not started a media player which actually plays a DVB-C stream. 
Therefore si2168_init() has never been called and the firmware has never 
been requested or loaded to the device.

On resume si2168_init() will be called (although I don't think this 
actually is really necessary) and the firmware load of si2168 fails if 
the firmware files are not installed. If the kernel does not already 
know that the files are not present without access to the file system, 
the system just freezes.


>>     c) manually reading the firmware files before suspend can make the resume
>> succeed, but this does not seem to be reliable
> 
> That may because of the dentry cache, and so helping races, doing
> something similar as to what the firmware cache does, but in hacky way.
> 
>>     d) modifying the si2168 by adding calls to firmware_request_cache() in
>> si2168_probe() makes the firmware loading during resume succeed.
> 
> That indeed seems like a good idea in general for dvb that should
> probably be generalized, if dvb had a way to get a dvb's driver
> firmware name and indeed all dvb drivers are not skipping the firmware
> cache today.
> 
>>     e) having the firmware files not installed freezes the system during
>> resume if the content of /usr/lib/firmware has not been listed before
>> suspend (e.g. installing the nvidia driver, so the nouveau driver does not
>> access this directory)
> 
> That may be the same issue as in b) assuming that you meant you didn't
> use the dvb device, and that the firmware load issue is from nouveau.

This is actually just the inverted case of b).
The only real relevance of the nouveau driver here is that its 
(perfectly working) firmware caching on suspend actually seems to be 
equivalent to manually running "ls" on the firmware directory and 
afterwards the kernel also knows whether or not the si2168 firmware 
files are present without file system access.

> 
> Are all firmware files used by nouveau upon resume the samea as during
> probe? If not using firmware_request_cache() for each of them would be
> a good idea to resolve possible races issues.

I have not compared them one-by-one, but as I have already written, 
nouveau seems fine here.

> 
>>     f) the system freezes during resume if nothing has caused the firmware
>> file to be read from the drive before suspend
> 
> Which driver? And yes, this is exactly why the firmware cache thing was
> done, and its why that for driver that don't use the firmware cache,
> they implement their own caching mechanism.
> 
> The firmware must be cached prior to suspend.
> 
>> I have observed this with all kernel versions I have tested so far: fedora
>> kernels 5.5.18, 5.6.19, 5.7.9, 5.7.11
>> vanilla kernels 5.7.12, 5.8.0 and current master (git 06a81c1c)
>>
>> Unfortunately I have not yet succeeded in getting useful debug output
>> (nothing is in the log files after a reset).  When I disable printk
>> console_suspend I can get some messages of the resume process but nothing
>> related to si2168 is shown on screen.
> 
> Try dynamic printk stuff mentioned.

I have tried that, but in case the system freezes, I have not managed to 
get any useful debug info on the screen. But

> Even though some of the things you say are not clear yet.

I'm very sorry for that. But it always is a compromise between giving 
all possible information and not producing a huge pile of text.


[snip: lots of interesting information]

>> I'm not sure who really is to blame here:
>> - BTRFS (ext4 is fine after all)
>> - the firmware loader because the implementation or the documentation are
>> wrong
>> - si2168 because of not loading the firmware or calling
>> firmware_request_cache() before suspend. Also I don't think it is even
>> necessary to load the firmware during resume, it should be sufficient to
>> load the firmware when the tuner is used. I'm not sure though whether the
>> dvb-frontend driver structure allows to properly distinguish between
>> resuming and initialization before device usage. The problem can definitely
>> be worked around here until the root cause is fixed. I can provide a patch
>> if this solution is seen as appropriate.
>>
>> I'm putting all the maintainers and/or lists of the possible culprits on CC.
> 
> Indeed send the patch to use firmware_request_cache() for si2168.

I sent it to the media mailing list (split into two patches).

> If you still have issues with nouveau, remove the si2168 driver and see
> if you can recreate the issue. If not then something between the two
> on suspend is likely the issue. But if the issue still persists then
> it would seem to be an issue with suspend on nouveau.

Nouveau does seem to work (including suspend), except if you actually 
need some decent 3D performance.

> The generic filesystem races on suspend/resume are known, and I will
> tackle that once I am done with some other task I am completing.

Great to know that the underlying cause for the freeze is known and a 
solution is being worked on (or at least planned to be worked on).

Lukas
