Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D2353610
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Apr 2021 02:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDDAuY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 20:50:24 -0400
Received: from mail.tuxforce.de ([84.38.66.179]:41554 "EHLO mail.tuxforce.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236618AbhDDAuY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Apr 2021 20:50:24 -0400
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id F2E8B520021;
        Sun,  4 Apr 2021 02:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de F2E8B520021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1617497419;
        bh=jWwleqYgvPCMmS8P+zzySZhbZ3gflr3bZrubI9evU1w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L0qM1j9vR5Ur3cT0QiSE1v823U5s+Upj4sfhMhLrKbG4hxbzQG2aLmghjOe4biWNO
         Euc/t66P5EM6MZt+14PD1wnQcRlBYYxfk18RPKymO4LO/18qC/DM5e94FOPnLp+W8H
         jlg+Z9FEAfQIw4h3ESYYJTD0Lvz0Zm6iQLpO1aXwtDmyMkP7BhPyynfIbo1P3PDW7d
         gVqRxavDhPkGADzu6LqqbPpX6wqtSu+ZuNyR+P3r0vCWWJzoYUur6NGLJysb/OIwdY
         UWG2qcJzXbo7EXKBJt9QWmEFLQoLVnyHMI5YuLQRKBkou+s8rWhon29ujgV+s3dRi4
         9ru/b/hxxReIw==
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        dsterba@suse.cz, Lukas Middendorf <kernel@tuxforce.de>
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
 <20210403202538.GW4332@42.do-not-panic.com>
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <e57f9f01-c620-0d72-98de-d0831395bb7e@tuxforce.de>
Date:   Sun, 4 Apr 2021 02:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210403202538.GW4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Great to hear that you now succeeded in reproducing the problem.

On 03/04/2021 22:25, Luis Chamberlain wrote:
> On Sat, Apr 03, 2021 at 12:24:07PM +0200, Lukas Middendorf wrote:
>> One further thing I noticed which might be problematic in rare cases:
>> According to the kernel debug messages, the firmware-loader does not attempt
>> to cache the firmware during suspend,
> 
> Correct, the goal with this test was to purposely *not* call for the
> firmware prior to suspend, and instead *race* (do the wrong thing) at
> resume. It shouldn't really stall... fail yes, but stall, that seems
> fishy.

I understood that.
>> if the previous call to
>> request_firmware() has failed (file not present; call made during previous
>> resume). In my opinion it should attempt to cache the firmware on suspend
>> even in this case
> 
> Yes, that is the *proper* way to do use the firmware API, but we want to
> reproduce the stall, and so we have to recreate the issue you reported
> by doing something bad.

Should firmware_request_cache() always be called, or only instead of 
request_firmware() ? In case request_firmware is called on its own, and 
the firmware file is not present, it might still race on the next resume.
request_firmware seems to be meant to include the cache request for the 
next suspend, but it apparently *does not* if firmware loading fails due 
to a missing file. I think this is something that should either be 
changed or properly documented in the API documentation.


>> Did you also try to create a random test-firmware.bin (I used 1M from
>> /dev/urandom) instead of an empty /lib/firmware ?
> 
> No, right now I want to to just focus on fixing the stall you saw.

This is a second nuance of the stall I saw: The firmware file (in this 
case test-firmware.bin) is present but not in cache.

If you run

ls -lR /lib/firmware > /dev/null

before

systemctl suspend

your reproduction steps will very likely not stall.
If you in addition run

dd if=/dev/urandom of=/lib/firmware/test-firmware.bin bs=1K count=64

during the preparation of /lib/firmware (in addition to or instead of 
your for loop), then it will always stall (as long as the file content 
is not read before suspend).

One stall is happening while the directory content is being listed (to 
find that the file is not present), the second stall is happening while 
actually trying to read the file. Those two stalls likely have the same 
root cause, but it might be different. I just want to make sure you have 
covered all cases.


>>> You might be better off just reposting your
>>> patches with the respective Reviewed-by tags and pestering your
>>> maintainer.
>>
>> I will try to be a little bit more insistent this time. Is "just repost" the
>> usual way to handle if patches are ignored?
> 
> You can repost, v2 just add my reviewed-by. Those patches are indeed
> correct as they are calling for the firmware prior to resume. Maybe
> clarify that.

OK, will do.

> But indeed there is also another issue which you reported which needs to
> be fixed, and for that thanks so much for you patience! I'll be looking
> into this!

Also thank you for your effort.

Lukas



