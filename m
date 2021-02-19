Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A996320173
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 23:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSWqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 17:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBSWqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 17:46:34 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57453C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 14:45:54 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 8E26B9BBB8; Fri, 19 Feb 2021 22:45:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1613774708;
        bh=OpOQ44WiMwkk3qWEMWrYrgWLCjP7J5FJ1dE8c4Hw15Q=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=c7Sl95MC1TwIsqLSRhsMBhjxhOUaLS67OYJffxa/bVjbQYaz41AYeyJkMxgZOdUXZ
         Bnz0C4U9QpOBRFoKotthZY5kT3zqapDYgewDViV7Gy/UpuR5KCw09Q4PC92Lr6Vz5k
         yvtRk3ZWNcvGCu2uM+xG5cwzlhka0wbr0tz1gKMXduCnyGLRjZd6S0wzqmhYwo15X6
         +Iv9/6c0XlbKKDh3iVUCu4Gl2d0edvM19vAQh5xjQ5VnGAz/QWPUARct9lvtgs6cy7
         YtkcBJxMsvuiKhS1zNrf+ijGqxUCon7yF8DsWJpPMOhdKf5dp6KcN9RGbyBnPvePlG
         L3D7PXys3j78w==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A9EA79B777;
        Fri, 19 Feb 2021 22:45:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1613774700;
        bh=OpOQ44WiMwkk3qWEMWrYrgWLCjP7J5FJ1dE8c4Hw15Q=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=GXRfVlgDdZxzrRUTWYqwUi8IrDg433gT4e8Bl7Rwz5VfiTf2EsP7chSAGb3HfqeHr
         +QOvioVyLVmTG9jPyiusLpdVv+2eQkEsHrmkEf+fn9wN6SqishtLExKm+o1p0rmyCu
         dxfdltwb/Z6LBegPjJOB3iT+FbLStK5rcXa7kqd9SXPeC5jQs1RbnaTx6fzcPu32vX
         nN8f56EZBHRdMT+65LhRfzuE97ckCeXRgXQj187NplzHeVu6K0pjK+3BnUO++AQCfW
         +/A7JdGuQs6ZqCcQtSnZKJ9ddUgRDtPz0tzdAlSRNRIBiTQavO7PVN8o2HMn3NJx+Z
         FjR6f5E7wxt4Q==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 6F7F01FF287;
        Fri, 19 Feb 2021 22:45:00 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Joshua <joshua@mailmag.net>, linux-btrfs@vger.kernel.org
References: <8ae61a4f-8a7f-332f-a6b6-4ad808cc88c8@cobb.uk.net>
 <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
 <2cf10687560a2acb0b9445dfe570867b@mailmag.net>
Subject: Re: Large multi-device BTRFS array (usually) fails to mount on boot.
Message-ID: <f559cfb0-1e9c-7dc8-f54d-2a9fc71980cd@cobb.uk.net>
Date:   Fri, 19 Feb 2021 22:45:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2cf10687560a2acb0b9445dfe570867b@mailmag.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 19/02/2021 17:42, Joshua wrote:
> February 3, 2021 3:16 PM, "Graham Cobb" <g.btrfs@cobb.uk.net> wrote:
> 
>> On 03/02/2021 21:54, joshua@mailmag.net wrote:
>>
>>> Good Evening.
>>>
>>> I have a large BTRFS array, (14 Drives, ~100 TB RAW) which has been having problems mounting on
>>> boot without timing out. This causes the system to drop to emergency mode. I am then able to mount
>>> the array in emergency mode and all data appears fine, but upon reboot it fails again.
>>>
>>> I actually first had this problem around a year ago, and initially put considerable effort into
>>> extending the timeout in systemd, as I believed that to be the problem. However, all the methods I
>>> attempted did not work properly or caused the system to continue booting before the array was
>>> mounted, causing all sorts of issues. Eventually, I was able to almost completely resolve it by
>>> defragmenting the extent tree and subvolume tree for each subvolume. (btrfs fi defrag
>>> /mountpoint/subvolume/) This seemed to reduce the time required to mount, and made it mount on boot
>>> the majority of the time.
>>
>> Not what you asked, but adding "x-systemd.mount-timeout=180s" to the
>> mount options in /etc/fstab works reliably for me to extend the timeout.
>> Of course, my largest filesystem is only 20TB, across only two devices
>> (two lvm-over-LUKS, each on separate physical drives) but it has very
>> heavy use of snapshot creation and deletion. I also run with commit=15
>> as power is not too reliable here and losing power is the most frequent
>> cause of a reboot.
> 
> Thanks for the suggestion, but I have not been able to get this method to work either.
> 
> Here's what my fstab looks like, let me know if this is not what you meant!
> 
> UUID={snip} /         ext4  errors=remount-ro 0 0
> UUID={snip} /mnt/data btrfs defaults,noatime,compress-force=zstd:2,x-systemd.mount-timeout=300s 0 0

Hmmm. The line from my fstab is:

LABEL=lvmdata   /mnt/data       btrfs
defaults,subvolid=0,noatime,nodiratime,compress=lzo,skip_balance,commit=15,space_cache=v2,x-systemd.mount-timeout=180s,nofail
  0       3

I note that I do have "nofail" in there, although it doesn't fail for me
so I assume it shouldn't make a difference.

I can't swear that the disk is currently taking longer to mount than the
systemd default (and I will not be in a position to reboot this system
any time soon to check). But I am quite sure this made a difference when
I added it.

Not sure why it isn't working for you, unless it is some systemd
problem. It isn't systemd giving up and dropping to emergency because of
some other startup problem that occurs before the mount is finished, is
it? I could believe systemd cancels any mounts in progress when that
happens.

Graham
