Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222D22448DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHNLio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 07:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNLio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 07:38:44 -0400
Received: from mail.tuxforce.de (tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF59FC061384;
        Fri, 14 Aug 2020 04:38:43 -0700 (PDT)
Received: from desktop.fritz.box (2001-4dd5-ac5b-0-6dff-1ee7-1f0b-53a0.ipv6dyn.netcologne.de [IPv6:2001:4dd5:ac5b:0:6dff:1ee7:1f0b:53a0])
        by mail.tuxforce.de (Postfix) with ESMTPSA id D992F520092;
        Fri, 14 Aug 2020 13:38:40 +0200 (CEST)
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
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
Date:   Fri, 14 Aug 2020 13:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813221348.GB4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Louis,

On 14/08/2020 00:13, Luis Chamberlain wrote:
> On Thu, Aug 13, 2020 at 11:53:36PM +0200, Lukas Middendorf wrote:
>> With "not used" I mean that the device has been recognized, the si2168
>> module is loaded and si2168_probe() has been called on the device, but I
>> have not started a media player which actually plays a DVB-C stream.
>> Therefore si2168_init() has never been called and the firmware has never
>> been requested or loaded to the device.
>>
>> On resume si2168_init() will be called (although I don't think this actually
>> is really necessary)
> 
> Indeed, that seems odd given its not on probe. So yet another possible
> si2168 bug. Or another way to put it: your cache calls are not needed
> if you remove that si2168_init() if init was not called yet. So simply
> extending the data structure for the driver and seting a bool flag to
> true if init was called should do the trick.
> 
> Then the two cache calls would not be needed.

I already thought about a way to remove the firmware load on suspend if 
it has not happened earlier. But I saw no way to distinguish between 
calls to si2168_init() during resume and calls to si2168_init() at the 
start of device usage.

In contrast to struct dvb_tuner_ops the relevant struct dvb_frontend_ops 
has no separate members "suspend" and "resume" to store callbacks to be 
called instead of sleep and init during suspend and resume. Changing the 
behavior of si2168 would likely include some bigger architectural work 
on the dvb_frontend system to extend dvb_frontend_ops.
It might be possible to just put nothing into dvb_frontend_ops.init but 
instead populate the dvb_tuner_ops part of the struct, but those 
pointers might already be populated externally for some other use.

If I try to do this on my very first kernel contribution without 
in-depth knowledge of how the dvb drivers really work, this will likely 
just explode, if not for me then for somebody else with different hardware.

>> If the kernel does not already know that the files
>> are not present without access to the file system, the system just freezes.
> 
> It is not clear to me what this means. Can you clarify?
> 
>>>>      e) having the firmware files not installed freezes the system during
>>>> resume if the content of /usr/lib/firmware has not been listed before
>>>> suspend (e.g. installing the nvidia driver, so the nouveau driver does not
>>>> access this directory)
>>>
>>> That may be the same issue as in b) assuming that you meant you didn't
>>> use the dvb device, and that the firmware load issue is from nouveau.
>>
>> This is actually just the inverted case of b).
>> The only real relevance of the nouveau driver here is that its (perfectly
>> working) firmware caching on suspend actually seems to be equivalent to
>> manually running "ls" on the firmware directory and afterwards the kernel
>> also knows whether or not the si2168 firmware files are present without file
>> system access.
> 
> OK.. I still don't get it, so let me see if we can decipher what you
> mean here.
> 
> If the firmware is *not* present for the si2168 driver and the device
> has *not* been used yet you get a system freeze which you cannot recover
> from, but only if you are *not* using a driver which also caches its
> firmware already?

Yes, this is exactly what I wanted to say.

A new installation of Fedora 32 without firmware files and with nouveau 
did not show my freeze problem. Installing either the firmware files or 
the nvidia driver started the freeze during resume.

> In this case if the nouveau is used this freeze does not happen, and you
> believe this is because of at least one fetch for the directory is done
> already. If so, then this speedup of a fugure negative dentry lookup on
> btrfs seems like an interesting test case for btrfs developers too look
> at.

According to my previous observations, an alternative to having the 
nouveau driver fetch files to prevent the freeze when no files are 
installed is to manually run "ls" on the firmware directory.

> But we must first undersand the case well.

I will check this corner case again in depth tonight or tomorrow and 
will report my findings, at least as far as it is externally observable 
without in-depth understanding of the internals.


>>>> I'm not sure who really is to blame here:
>>>> - BTRFS (ext4 is fine after all)
>>>> - the firmware loader because the implementation or the documentation are
>>>> wrong
>>>> - si2168 because of not loading the firmware or calling
>>>> firmware_request_cache() before suspend. Also I don't think it is even
>>>> necessary to load the firmware during resume, it should be sufficient to
>>>> load the firmware when the tuner is used. I'm not sure though whether the
>>>> dvb-frontend driver structure allows to properly distinguish between
>>>> resuming and initialization before device usage. The problem can definitely
>>>> be worked around here until the root cause is fixed. I can provide a patch
>>>> if this solution is seen as appropriate.
>>>>
>>>> I'm putting all the maintainers and/or lists of the possible culprits on CC.
>>>
>>> Indeed send the patch to use firmware_request_cache() for si2168.
>>
>> I sent it to the media mailing list (split into two patches).
> 
> Looks good to me, except now that you metion the resuem thing, I think
> you can drop those patches if you do the check I mentioned on resume,
> ie, to verify that init hasn't been called yet.

As I have written above, I likely would have tried that, had I found a 
way to distinguish between calls to init during resume and other calls 
to that function.
Do you know of any safe way to detect that a resume operation is going on?

> Also, might as well rename that function to make it clearer what it does
> as init prefixed or postfixed calls tend to be used for things during
> initialization.

As a pointer to this function goes into the "init" member of the 
dvb_frontend_ops struct, the name seems to be appropriate, at least at 
the moment.

>>> The generic filesystem races on suspend/resume are known, and I will
>>> tackle that once I am done with some other task I am completing.
>>
>> Great to know that the underlying cause for the freeze is known and a
>> solution is being worked on (or at least planned to be worked on).
> 
> There is a sliver possibility here that a negative dentry slowdown may
> cause a btrfs freeze on suspend easily. If so that can likely be fixed
> before that big general filesystem freeze issue I noted with URLs and
> talks. But I think we need to confirm that is what is happening here.

This sounds even better, although I don't really understand your theory.

Lukas
