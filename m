Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE8244FB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 23:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHNV7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHNV7o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 17:59:44 -0400
Received: from mail.tuxforce.de (tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F3C061385;
        Fri, 14 Aug 2020 14:59:43 -0700 (PDT)
Received: from linux.fritz.box (2001-4dd5-ac5b-0-c3ce-e3c9-ac3c-4f69.ipv6dyn.netcologne.de [IPv6:2001:4dd5:ac5b:0:c3ce:e3c9:ac3c:4f69])
        by mail.tuxforce.de (Postfix) with ESMTPSA id 89EC6520088;
        Fri, 14 Aug 2020 23:59:36 +0200 (CEST)
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
Message-ID: <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
Date:   Fri, 14 Aug 2020 23:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814163723.GC4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/08/2020 18:37, Luis Chamberlain wrote:
> On Fri, Aug 14, 2020 at 01:38:40PM +0200, Lukas Middendorf wrote:
>>> If the firmware is *not* present for the si2168 driver and the device
>>> has *not* been used yet you get a system freeze which you cannot recover
>>> from, but only if you are *not* using a driver which also caches its
>>> firmware already?
>>
>> Yes, this is exactly what I wanted to say.
>>
> 
> OK great.. but..
> 
>> A new installation of Fedora 32 without firmware files
> 
> Fedora 32 comes with no firmware at all? Are you sure? How about your
> wifi?

Fedora does come with firmware files for many devices (wifi, nouveau, …) 
but not for dvb devices. Firmware for the si2168 has to be installed as 
an extra package dvb-firmware from rpmfusion. When I talk about "no 
firmware files" or "install the firmware files" I mean the si2168 (and 
other dvb hardware) firmware files only. The nouveau firmware files are 
always present.

>> and with nouveau did
>> not show my freeze problem. Installing either the firmware files or the
>> nvidia driver started the freeze during resume.
> 
> Here now you say that if you install either the firmware files for
> either si2168 or nouveau can cause a freeze, 

no, I'm talking just about the firmware files for si2168

> meanwhile what I wrote
> above and you agreed is what you meant, says that the freeze happens
> only if you *don't* have the firmware for nouveau present *and* you
> also don't have the any other firmware present.

This statement for me seems different compared to the statement in your 
last mail which I agreed to.
In the case that I *don't* have the firmware files for si2168 (!) 
present it happens only if no other firmware is cached on suspend (in my 
case by the nouveau driver). No statement made about cases where the 
si2168 firmware file is present.


> You also clarify here your freeze happens on resume only. Is that right?
> Never on suspend, but if the freeze happens, it happens only on resume?

Correct. I have not seen a freeze on suspend. It only happens on resume.


> The actual case where you reach a freeze is still not clear yet. Let's
> try to clarify this.

OK, let's try that again. To freeze during resume all of 1-4 has to be true:
1. /usr/lib/firmware is on btrfs
2. my Hauppauge WinTV-dualHD USB DVB tuner (contains si2168) is connected
3. have not actively used the tuner
4. any of the following cases:
4a) si2168 firmware not installed + nouveau driver not used + have not 
run "ls -R /usr/lib/firmware" before suspend
4b) firmware file installed + not run "cat /usr/lib/firmware/dvb*"
4c) firmware file installed + not run "ls -R /usr/lib/firmware" + not 
nouveau driver


Not leading to a freeze is:

A: si2168 firmware not installed + nouveau driver used
B: si2168 firmware not installed + run "ls -R /usr/lib/firmware" before 
suspend
C: used the tuner before suspend (or tried to use, in case that the 
si2168 firmware is not installed)
D: using my patches with firmware_request_cache()
E: si2168 firmware installed + "ls -R /usr/lib/firmware" + "cat 
/usr/lib/firmware/dvb*"
F: si2168 firmware installed + nouveau driver used + "cat 
/usr/lib/firmware/dvb*"

I verified all cases again to make sure I was not remembering anything 
wrong.

The nouveau driver in use seems to be equivalent to running "ls -R 
/usr/lib/firmware" before suspend.

All the cases seem to boil down to:
It freezes if the file system has to be accessed to list the content of 
/usr/lib/firmware or to read the si2168 firmware file


Lukas


