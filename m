Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2A2479E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgHQWE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgHQWE5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 18:04:57 -0400
Received: from mail.tuxforce.de (tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA4C061342;
        Mon, 17 Aug 2020 15:04:56 -0700 (PDT)
Received: from linux-2.fritz.box (2001-4dd5-ac5b-0-c3ce-e3c9-ac3c-4f69.ipv6dyn.netcologne.de [IPv6:2001:4dd5:ac5b:0:c3ce:e3c9:ac3c:4f69])
        by mail.tuxforce.de (Postfix) with ESMTPSA id BAAE0520089;
        Tue, 18 Aug 2020 00:04:51 +0200 (CEST)
From:   Lukas Middendorf <kernel@tuxforce.de>
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
 <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
Message-ID: <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
Date:   Tue, 18 Aug 2020 00:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817152056.GD4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/08/2020 17:20, Luis Chamberlain wrote:
> On Fri, Aug 14, 2020 at 11:59:36PM +0200, Lukas Middendorf wrote:
>> On 14/08/2020 18:37, Luis Chamberlain wrote:
>>> On Fri, Aug 14, 2020 at 01:38:40PM +0200, Lukas Middendorf wrote:
>>>>> If the firmware is *not* present for the si2168 driver and the device
>>>>> has *not* been used yet you get a system freeze which you cannot recover
>>>>> from, but only if you are *not* using a driver which also caches its
>>>>> firmware already?
>>>>
>>>> Yes, this is exactly what I wanted to say.
>>>>
>>>
>>> OK great.. but..
>>>
>>>> A new installation of Fedora 32 without firmware files
>>>
>>> Fedora 32 comes with no firmware at all? Are you sure? How about your
>>> wifi?
>>
>> Fedora does come with firmware files for many devices (wifi, nouveau, …) but
>> not for dvb devices. Firmware for the si2168 has to be installed as an extra
>> package dvb-firmware from rpmfusion. When I talk about "no firmware files"
>> or "install the firmware files" I mean the si2168 (and other dvb hardware)
>> firmware files only. The nouveau firmware files are always present.
> 
> OK so how do you know that other firmware is not getting loaded or cached?

dmesg with firmware_class debug output enabled

> 
> Other than checking kernel logs you can rm -rf /lib/firmware/ and then
> only place the files you want to test.
> 
>>>> and with nouveau did
>>>> not show my freeze problem. Installing either the firmware files or the
>>>> nvidia driver started the freeze during resume.
>>>
>>> Here now you say that if you install either the firmware files for
>>> either si2168 or nouveau can cause a freeze,
>>
>> no, I'm talking just about the firmware files for si2168
> 
> OK so if you install the firmware files of si2168 you do run into a
> freeze, and this freeze happens on resume from suspend?
> 
> Without the si2168 firmware the freeze does not happen.
> 
> Is that right?
> 
>> In the case that I *don't* have the firmware files for si2168 (!) present it
>> happens only if no other firmware is cached on suspend (in my case by the
>> nouveau driver). No statement made about cases where the si2168 firmware
>> file is present.
> 
> OK this statement is clear and is very different from the one I made
> above.
> 
> But note, that this is true, how are you *sure* that no other firmware
> other than nouveau is being used? What about wifi? or bluetooth?

I don't have wifi or bluetooth enabled in the BIOS. If I don't use the 
nouveau driver, "dmesg | grep firmware" is completely empty after boot 
except for the kernel command line part "ddebug_query=module 
firmware_class +pmf". After suspend + resume I just get two lines for 
the calls to cache and uncache firmwares. If any other firmware is used, 
it is apparently not using the standard firmware loader.
If I rename the directory /usr/lib/firmware everything seems to work as 
before (nouveau and si2168 not loaded) and I don't see any complaints 
about missing firmware in dmesg.

If I enable my secondary rtl8125 Ethernet controller in the BIOS (I only 
tested this now, I always had it disabled previously), I can see its 
firmware being loaded on boot and cached on suspend. This then has an 
effect on my freeze problem identical to using the nouveau driver.

>>> You also clarify here your freeze happens on resume only. Is that right?
>>> Never on suspend, but if the freeze happens, it happens only on resume?
>>
>> Correct. I have not seen a freeze on suspend. It only happens on resume.
> 
> OK this is only if and only if you haven't used the si2168 device,
> right? And since this is related to si2168 we know that even if you
> don't use the si2168 device its function which calls to load firmware
> *does* get called on resume, even though that same function was not
> called on probe, as the device is not used.
> 
> If true, then the race to freeze here happens on resume against btrfs.
> 
> And is the firmware present or not in this case, in which the freeze
> happens?

A freeze can happen on resume with and without the si2168 firmware files 
installed. It however is easier to hit the freeze with the firmware 
files installed. Without the firmware files present the freeze happens 
only if no other driver uses the firmware loader.

>>> The actual case where you reach a freeze is still not clear yet. Let's
>>> try to clarify this.
>>
>> OK, let's try that again. To freeze during resume all of 1-4 has to be true:
>> 1. /usr/lib/firmware is on btrfs
>> 2. my Hauppauge WinTV-dualHD USB DVB tuner (contains si2168) is connected
>> 3. have not actively used the tuner
>> 4. any of the following cases:
>> 4a) si2168 firmware not installed + nouveau driver not used + have not run
>> "ls -R /usr/lib/firmware" before suspend
>> 4b) firmware file installed + not run "cat /usr/lib/firmware/dvb*"
>> 4c) firmware file installed + not run "ls -R /usr/lib/firmware" + not
>> nouveau driver
> 
> OK perfect, now the next question to clarify is *are you sure* that no
> other firmware is used, other than si2168 and nouveau?

I'm totally sure that no other firmware is used through the standard 
firmware loader. I'm also almost sure that no firmware from 
/usr/lib/firmware is used though any other means.

>> Not leading to a freeze is:
>>
>> A: si2168 firmware not installed + nouveau driver used
>> B: si2168 firmware not installed + run "ls -R /usr/lib/firmware" before
>> suspend
>> C: used the tuner before suspend (or tried to use, in case that the si2168
>> firmware is not installed)
>> D: using my patches with firmware_request_cache()
>> E: si2168 firmware installed + "ls -R /usr/lib/firmware" + "cat
>> /usr/lib/firmware/dvb*"
>> F: si2168 firmware installed + nouveau driver used + "cat
>> /usr/lib/firmware/dvb*"
>>
>> I verified all cases again to make sure I was not remembering anything
>> wrong.
> 
> This helps, thanks so much, now we'll have to write a reproducer, thanks
> for the report!!

Will you do it yourself or do you expect me to do anything for this?

>> The nouveau driver in use seems to be equivalent to running "ls -R
>> /usr/lib/firmware" before suspend.
>>
>> All the cases seem to boil down to:
>> It freezes if the file system has to be accessed to list the content of
>> /usr/lib/firmware or to read the si2168 firmware file
> 
> Let's confirm first whether or not your system is using other firmware
> files too or not.

I confirmed that above. Why is this so important, anyway?

Lukas
