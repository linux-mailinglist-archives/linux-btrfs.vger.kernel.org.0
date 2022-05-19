Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3052D19D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiESLhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiESLhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:37:36 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351C5C361
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:37:31 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 7D66E9B806; Thu, 19 May 2022 12:37:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.me.uk; s=201703;
        t=1652960247; bh=T2FQvaFShlLMEGDubd4AXYQLXGEYqZJXI5pxmjUiMnA=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=FU3+IRyBZ8RUEVBuSjMN6FI724wiyKRvR5axlRuiMGqdBqQmWHdlR0OEnU+KlbXNN
         lQQWzmFcISSamvZpZSjFKLwHiEHFCUUIEjCKx7duXV/V1ofT8b5X0ZK2ZA1dN6nvQz
         QKkHA2By1JfQlLXopRRUAHVwjOp6JaXBaduR65LrvjgsPDBQH20YpvsohvmfJhWiSD
         MSmO8v5Gzjp8uSriTmikPK/ft2owCMyMneN5f8H1jJ18nT7hiOEacZQhDkjFrqFnaS
         1a8nEwAe9kbnqjMlzeuXELy8tEMydbpUValoXrVev7nzIIbEO69Zsp3bPDwHuwM3JG
         wbVM6gf9/Nidw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 88D319B6AE;
        Thu, 19 May 2022 12:32:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.me.uk; s=201703;
        t=1652959946; bh=T2FQvaFShlLMEGDubd4AXYQLXGEYqZJXI5pxmjUiMnA=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=cAhBopxo0s49hAyNzVUxIQN5Wj60C+5N67/tjNX5YwOiDLOkziJTOsDdv9Qp/ZSYv
         vfxHfC21cQX9YiFfr2lCXI2BXxa91xZWF/YwodYVG+4kVS7QCv/joWXYmcfyYAuWWf
         ikxLin5NuBsHiTkExya9RkNmK2NGCr4JJJxnBwJL8j7ZyK3RCQr4rgpyvkrL0TS6iY
         gvoiyq+8MGdKOMsleRM2u63NGUvqr5hHcXZJAS8/g+pgsJklyJFFRZM5LVtz2enHWa
         tJ5xFgeuTbtnuaAHVOrBuT0esu03cyT/vpaK5xWK58CqrnLh7XmVTYUM5jUQVVsjvr
         JZ5tCR3rhIFeg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 4806616FC5C;
        Thu, 19 May 2022 12:32:26 +0100 (BST)
Message-ID: <fbc486d1-b798-c3f5-7dae-0f0cbf4613d9@cobb.uk.net>
Date:   Thu, 19 May 2022 12:32:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Graham Cobb <g.btrfs@cobb.me.uk>
Subject: Re: can't boot into filesystem
Content-Language: en-US
To:     arnaud gaboury <arnaud.gaboury@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
 <CAK1hC9usm5ArZEf3xd4Tnd730_EBU4zwv3tL5wopu=XP2a4gJA@mail.gmail.com>
In-Reply-To: <CAK1hC9usm5ArZEf3xd4Tnd730_EBU4zwv3tL5wopu=XP2a4gJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 12:14, arnaud gaboury wrote:
> the issue has been solved.
> I chrooted the filesystem, then run btrfs filesystem show. There, I
> saw the external device I tried to attach tomy btrfs filesystem. That
> was the change in my fstab. But I realized that the device was still
> in my filesystem.
> I ran btrfs delete and now I Am Back to my OS.
> My error came from the fact that going back to the original fstab was
> not enough as the external device was still added tomy filesystem.

Great. In fact, if you add a device to a btrfs filesystem you do not
make any change to fstab - when mounting a multi-device filesystem,
btrfs will search for all the devices involved (and fail to mount if any
are missing, by default).

For that reason, adding an external device to your root filesystem
should be avoided if possible, as external devices, or their connectors
or power supplies, are more likely to get damaged and then you can't boot.

> 
> On Thu, May 19, 2022 at 12:39 PM Graham Cobb <g.btrfs@cobb.me.uk> wrote:
>>
>> You will probably get a much more useful reply from a developer later
>> but in the meantime...
>>
>> Probably your rescue CD has an older kernel - new kernels do more
>> validation on the filesystem. In that case, there is something wrong
>> with the filesystem but the old kernel hasn't noticed.
>>
>> You might want to try a rescue CD based on a newer kernel. And/or you
>> should do a "btrfs check" with the latest btrfs-progs that you can run.
>> You could even chroot into /mnt/@ (bind mounting dev, proc and sys, of
>> course) and see if you can run the btrfs image from /mnt/@/usr/bin/btrfs
>> while booted in your rescue CD. If so, try using it to do a "btrfs
>> check" on your filesystem. If not, use the btrfs check from the rescue
>> CD itself. In either case, DO NOT SPECIFY --repair UNLESS A DEVELOPER
>> TELLS YOU TO!!
>>
>> By the way, /mnt/@ IS your root - it isn't a copy of it. You can see in
>> fstab that the "@" subvolume of your disk gets mounted into "/" on boot.
>>
>> On 19/05/2022 10:58, arnaud gaboury wrote:
>>> My OS has been freshly installed on a btrfs filesystem. I am quite new
>>> to btrfs, especially when mounting specific partitions. After a change
>>> in my fstab, I couldn't boot into the filesystem. Booting from a
>>> rescue CD, I changed the fstab back to its original. Unfortunately I
>>> still can't boot.
>>> Here is part of the error message I have:
>>> devid 2 uuid XXYYY is missing
>>> failed to read chunk tree: -2
>>>
>>> part of my fstab:
>>> LABEL=magnolia   / btrfs  rw,noatime.....,subvol=@
>>> LABEL=magnolia  /btrbk_pool  btrfs  noatime,....,subvolid=5
>>> LABEL=magnolia   /home   btrfs .....,subvol=/@home
>>> ......
>>>
>>>
>>>
>>> I am now back to rescue CD. I can mount my filesystem with no error:
>>> # mount -t btrfs /dev/sdb2 /mnt
>>> # ls -al /mnt/
>>> @
>>> btrbk_snapshots
>>> @home
>>> home
>>>
>>> I can see my filesystem when I ls the @ directory.
>>> What can I do to boot my filesystem which is perfectly reproduced in
>>> the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
>>> the root of /mnt  when my device sdb2 is mounted?
>>> Sorry for the lack of formatting and info, but I can't use the browser
>>> from the rescue CD so I am writing from another computer.
>>

