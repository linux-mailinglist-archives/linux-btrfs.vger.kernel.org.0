Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2635336C
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhDCKYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 06:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhDCKYU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Apr 2021 06:24:20 -0400
Received: from mail.tuxforce.de (mail.tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C851C0613E6;
        Sat,  3 Apr 2021 03:24:17 -0700 (PDT)
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id A079C52008D;
        Sat,  3 Apr 2021 12:24:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de A079C52008D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1617445447;
        bh=7EO44gx5PSS2bB24WctMn4RQMyr/4+9A98kzJIZdVw8=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=FwroFo9i6br+MW0n3qTMCz/hzb/jm5mnL0A+iuYN+FyH0ftAslYSRGVS7LP2Zy/Vx
         PFfkYHPgqNgu9VPKw9PqBluISKLsd7wm/EsnlvNRPXncy/uQNqi/ipXrQxfsKWGwk8
         l9+CVQkarUCiD+FaFrAeUxJPdyhoN+bqznOXfxhThGPZQlt+d8icFdEc/1zFwxrup5
         /+F68FzuCV7Cfmvw69+iocDHV8DzbkU8UwGtjIL0unyvtPKnJuInZ7C+F4niMAGTcB
         AtJ+fDlM7QA8HMIOamOJTGWkFYHUqV4GK9a/UAY/MAgqgAlY3+r3fQ9yFBaUtMSOBc
         fdnc6i5mr7/Xw==
From:   Lukas Middendorf <kernel@tuxforce.de>
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>
References: <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
Message-ID: <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
Date:   Sat, 3 Apr 2021 12:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 02/04/2021 20:02, Luis Chamberlain wrote:
> No sorry, I dropped the ball on this but I managed to now spawn up the
> virtual guests where I was doing development to reproduce this. Give
> me some time and I will zero in on this now.
>
> For now what I have is the following to test this, I next will work
> on the userspace part.

I can report that your patch for test_firmware works (applied to current 
master from linus d93a0d4; I get some offsets and had to adjust some 
whitespace for it to apply). With that module (and resume test enabled) 
I get freezes at resume in the same cases that would also cause problems 
with si2168.

I'm testing this on bare metal F34 beta with / on a btrfs. I'm using 
nvidia driver again to make sure the system does not otherwise use any 
firmware from /usr/lib/firmware (confirmed with kernel debug messages 
for firmware_loader). My si2168 is not plugged in.

I tested it with a normal population of files in /usr/lib/firmware , 
without test-firmware.bin and also with a random 1MiB file in place. I 
tested after a reboot so it does not do caching.
With /usr/lib/firmware on a separate ext4 partition I can confirm with 
dmesg that the test_firmware suspend test actually works (does not freeze).
With /usr/lib/firmware on btrfs it fails in both cases (with and without 
the firmware files).
With caching (first suspend with the ext4 partition mounted, then a 
second suspend without) it does not freeze even with the firmware on btrfs.


One further thing I noticed which might be problematic in rare cases:
According to the kernel debug messages, the firmware-loader does not 
attempt to cache the firmware during suspend, if the previous call to 
request_firmware() has failed (file not present; call made during 
previous resume). In my opinion it should attempt to cache the firmware 
on suspend even in this case (If I remember correctly, 
firmware_request_cache also works without the file being present). In 
case some low-memory condition has caused the file system cache to lose 
the information about the file being non-present (or the file has been 
written after the initial attempt and is no longer in the file system 
cache), this might lead to freezes even for well-behaved drivers in case 
they reattempt to do request_firmware() on resume.
If the firmware is found during resume, it is cached on further suspends.
Given how long it took me to narrow down this problem in this (for me) 
reliably reproducible case, something like this happening at random 
would be almost impossible to debug/locate and might actually happen 
frequently in the wild.


On 03/04/2021 00:19, Luis Chamberlain wrote:
> Lukas, can you share your /etc/fstab ?

This is the core part (everything else is unmounted), I shortened the 
UUIDs. The ext4 mount of course is also unmounted when I want it to 
fail, with it in place it reliably not-fails.

UUID=<1> /                       btrfs   subvol=linux1 0 0
UUID=<2> /usr/lib/firmware       ext4    defaults 1 1
UUID=<1> /home/lukas             btrfs   subvol=linux1-f34-lukas 0 0
tmpfs /home/lukas/.cache tmpfs size=16g,gid=lukas,uid=lukas,mode=700 0 0

> Also, how long do you stay in the boot before you try to suspend?

During my reproduction sessions usually only shortly 1-5min, but I think 
I have seen this also after a slightly longer time. I can try to let it 
sit for longer if you think that is important.

On 03/04/2021 00:58, Luis Chamberlain wrote:
> On Fri, Apr 2, 2021 at 3:19 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> Lukas, can you share your /etc/fstab ? Also, how long do you stay in
>> the boot before you try to suspend?
> 
> OK I cannot reproduce the issue with the modified patch I sent to
> test_firmware, which if you enable config_enable_resume_test will
> trigger a request_firmware() on resume, thus trying to mimic the race
> you note. To test this you can simply use a loopback filesystem for
> your /lib/firmware and create a btrfs filesystem for it, and then run:
> 
> echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
> 
> systemctl suspend
> 
> Then resume. You should see "resume test" print on dmesg. I keep my
> /lib/firmware/ empty and still, nothing.

Did you also try to create a random test-firmware.bin (I used 1M from 
/dev/urandom) instead of an empty /lib/firmware ?
If the directory is completely empty, it also does not freeze for me. If 
the directory is empty, any attempt to access its content can likely be 
directly served from cache, even if the actual directory has never been 
accessed before, as long as /lib (which is a symlink to /usr/lib on 
fedora) has been accessed (which will likely always be true). So I have 
to further add to my previous findings that "firmware directory is not 
completely empty" is a further prerequisite for it to fail.

> Can you provide kernel logs for where you are seeing things get stuck at? 

The log does not have any entries from resume. For the attempts where it 
freezes the last entry in journalctl is
systemd-sleep[5050]: Suspending system...

> Note that I had mentioned the races on suspend/resume do exist for any journaling
> filesystem, but this typically happens if you are doing ongoing
> writes. I suppose you are *not* doing writes and your filesystem is
> idle.

I can of course not completely rule out some random write (log files or 
similar), but there is definitely no heavy writing going on. I think 
only writes caused by the act of suspending and resuming could cause it 
this reliably. I have seen it also with a completely isolated btrfs file 
system for /usr/lib/firmware, where there should not have been any 
writes. For ext4 (which is also journaling) it works properly.

> As such without kernel logs I cannot be sure what the issue is, but at
> this point after the initial testing I've done I don't suspect this is
> a firmware API issue. You might be better off just reposting your
> patches with the respective Reviewed-by tags and pestering your
> maintainer.

I will try to be a little bit more insistent this time. Is "just repost" 
the usual way to handle if patches are ignored?

Lukas
