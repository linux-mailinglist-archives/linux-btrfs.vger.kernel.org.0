Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2A23FFC1
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Aug 2020 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHIS56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Aug 2020 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgHIS55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Aug 2020 14:57:57 -0400
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Aug 2020 11:57:57 PDT
Received: from mail.tuxforce.de (tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920BC061756;
        Sun,  9 Aug 2020 11:57:57 -0700 (PDT)
Received: from desktop.fritz.box (2001-4dd5-ac5b-0-3676-7f00-19c9-c30f.ipv6dyn.netcologne.de [IPv6:2001:4dd5:ac5b:0:3676:7f00:19c9:c30f])
        by mail.tuxforce.de (Postfix) with ESMTPSA id ECC89520092;
        Sun,  9 Aug 2020 20:51:35 +0200 (CEST)
From:   Lukas Middendorf <kernel@tuxforce.de>
Subject: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-btrfs@vger.kernel.org
Message-ID: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
Date:   Sun, 9 Aug 2020 20:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm seeing system freezes during resuming from suspend to RAM if all of 
the following is true:
1. /usr/lib/firmware is on btrfs
2. my Hauppauge WinTV-dualHD USB DVB tuner (contains si2168) is connected
3. the firmware file /usr/lib/firmware/dvb-demod-si2168-b40-01.fw (or 
knowledge about its non-existstence) is NOT in a cache in RAM

The exact outcome depends on whether or not I use nvidia or nouveau 
driver an whether or not I have X running. With nvidia I only get some 
kernel messages from suspend on screen, but the system does not seem to 
react to anything (emergency FS sync magic sysrq sometimes works judging 
from HDD-LED). With nouveau and X11 running I just get a black screen 
with mouse cursor and no apparent reaction to key presses (again except 
for emergency FS sync magic sysrq).
With nouveau but without X11 running the system even reacts to 
ctrl+alt+F1/F2/F3, but only the first ttys are displaying anything and 
login or any other input is not possible.
Unplugging the USB device after resume does not return the system back 
to normal.

Details on the above conditions:
1. If /usr/lib/firmware is on ext4 everything works fine. I originally 
noticed this with the complete / on btrfs vs. ext4, but putting 
/usr/lib/firmware on a separate partition is sufficient to make it work 
or fail, depending on the fs type.
2. The si2168 driver drivers/media/dvb-frontends/si2168.c has its 
si2168_init() called during resume. In this function a call to 
request_firmware() happens. The firmware is not actually loaded to the 
device on boot or initial usb connection but just during resume and when 
the DVB-Tuner is used.
3. a) if the device has been used and the firmware has already been 
loaded, the load succeeds during resume
    b) if the firmware file is not present and the directory content of 
/usr/lib/firmware has been listed (e.g. through loading of a different 
firmware from there; by the nouveau driver in my case) the firmware load 
fails but does not freeze the system
    c) manually reading the firmware files before suspend can make the 
resume succeed, but this does not seem to be reliable
    d) modifying the si2168 by adding calls to firmware_request_cache() 
in si2168_probe() makes the firmware loading during resume succeed.
    e) having the firmware files not installed freezes the system during 
resume if the content of /usr/lib/firmware has not been listed before 
suspend (e.g. installing the nvidia driver, so the nouveau driver does 
not access this directory)
    f) the system freezes during resume if nothing has caused the 
firmware file to be read from the drive before suspend

I have observed this with all kernel versions I have tested so far: 
fedora kernels 5.5.18, 5.6.19, 5.7.9, 5.7.11
vanilla kernels 5.7.12, 5.8.0 and current master (git 06a81c1c)

Unfortunately I have not yet succeeded in getting useful debug output 
(nothing is in the log files after a reset).  When I disable printk 
console_suspend I can get some messages of the resume process but 
nothing related to si2168 is shown on screen.

This certainly looks like the documented promise of request_firmware()
"The function can be called safely inside device’s suspend and resume 
callback."
does not hold if the requested firmware files are residing on a btrfs.
The documentation of firmware_request_cache() states that this function 
should be called before suspend if the firmware has not been loaded 
earlier. From the combined documentation I would expect that 
request_firmware() might fail during resume if the firmware is not yet 
in cache, but it should not freeze the system.

I'm not sure who really is to blame here:
- BTRFS (ext4 is fine after all)
- the firmware loader because the implementation or the documentation 
are wrong
- si2168 because of not loading the firmware or calling 
firmware_request_cache() before suspend. Also I don't think it is even 
necessary to load the firmware during resume, it should be sufficient to 
load the firmware when the tuner is used. I'm not sure though whether 
the dvb-frontend driver structure allows to properly distinguish between 
resuming and initialization before device usage. The problem can 
definitely be worked around here until the root cause is fixed. I can 
provide a patch if this solution is seen as appropriate.

I'm putting all the maintainers and/or lists of the possible culprits on CC.

Best regards,

Lukas Middendorf

