Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62C814FD58
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 14:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBBNaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 08:30:01 -0500
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:52098 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgBBNaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Feb 2020 08:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1580650198;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=kqAi9KNwM/CHWXeE7cvAQvnnf0f/H2SYRcAYxqxhiho=;
        b=dE2c+LfTVO3velAcSh4v3Up8LaSA6bvOOKrpmtezmfOJbIv82zyWXVe5z6OShh6O
        ZAYMizyoy5XausYE2cUwLDLT8/mONC6ybo1h+aI0y9gom1JnB/mt8N4qTJbiUdUrPsf
        7tVXQrIhiTQyo1jwRgAjfym7UEXx5UbE7KNbGhKY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1580650198;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=kqAi9KNwM/CHWXeE7cvAQvnnf0f/H2SYRcAYxqxhiho=;
        b=ZjdUkvNBPwKaLoWdVQHpPdRr9OMDNjS7W/R2UozmCDqPr65Bj0PBTXg8o9SsKiQa
        W34tPonSFqbt1yo/EYqzH5k7Yt9ce5IPCiduJRTqZ7UTjRGCYbpiraxXzXm32TTxSS1
        /899x+kAlUkg4hbrTZxVa9iRqNmglxsPpwKBNq8I=
Subject: Re: My first attempt to use btrfs failed miserably
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Skibbi <skibbi@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <cd628b1f-25b7-0f3b-0b31-2122acdfcd36@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <010201700617f6d3-a19297d3-8722-4745-acde-7a740c5ee33f-000000@eu-west-1.amazonses.com>
Date:   Sun, 2 Feb 2020 13:29:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <cd628b1f-25b7-0f3b-0b31-2122acdfcd36@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.02.02-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.02.2020 13:56 Qu Wenruo wrote:
>
> On 2020/2/2 下午8:45, Skibbi wrote:
>> Hello,
>> So I decided to try btrfs on my new portable WD Password Drive
>> attached to Raspberry Pi 4. I created GPT partition, created luks2
>> volume and formatted it with btrfs. Then I created 3 subvolumes and
>> started copying data from other disks to one of the subvolumes. After
>> writing around 40GB of data my filesystem crashed. That was super fast
>> and totally discouraged me from next attempts to use btrfs :(
>> But I would like to help with development so before I reformat my
>> drive I can help you identifying potential issues with this filesystem
>> by providing some debugging info.
>>
>> Here are some details:
>>
>> root@rpi4b:~# uname -a
>> Linux rpi4b 4.19.93-v7l+ #1290 SMP Fri Jan 10 16:45:11 GMT 2020 armv7l GNU/Linux
> Pretty old kernel, nor recently enough backports.
>
> And since you're already using rpi4, no reason to use armv7 kernel.
> You can go aarch64, Archlinux ARM has latest kernel for it.
>
>> root@rpi4b:~# btrfs --version
>> btrfs-progs v4.20.1
> Old progs too.
>
>> root@rpi4b:~# btrfs fi show
>> Label: 'NAS'  uuid: b16b5b3f-ce5e-42e6-bccd-b48cc641bf96
>>         Total devices 1 FS bytes used 42.48GiB
>>         devid    1 size 4.55TiB used 45.02GiB path /dev/mapper/NAS
>>
>> root@rpi4b:~# dmesg |grep btrfs
>> [223167.290255] BTRFS: error (device dm-0) in
>> btrfs_run_delayed_refs:2935: errno=-5 IO failure
>> [223167.389690] BTRFS: error (device dm-0) in
>> btrfs_run_delayed_refs:2935: errno=-5 IO failure
>> root@rpi4b:~# dmesg |grep BTRFS
>> [201688.941552] BTRFS: device label NAS devid 1 transid 5 /dev/sda1
>> [201729.894774] BTRFS info (device sda1): disk space caching is enabled
>> [201729.894789] BTRFS info (device sda1): has skinny extents
>> [201729.894801] BTRFS info (device sda1): flagging fs with big metadata feature
>> [201729.902120] BTRFS info (device sda1): checking UUID tree
>> [202297.695253] BTRFS info (device sda1): disk space caching is enabled
>> [202297.695271] BTRFS info (device sda1): has skinny extents
>> [202439.515956] BTRFS info (device sda1): disk space caching is enabled
>> [202439.515976] BTRFS info (device sda1): has skinny extents
>> [202928.275644] BTRFS error (device sda1): open_ctree failed
>> [202934.389346] BTRFS info (device sda1): disk space caching is enabled
>> [202934.389361] BTRFS info (device sda1): has skinny extents
>> [203040.718845] BTRFS info (device sda1): disk space caching is enabled
>> [203040.718863] BTRFS info (device sda1): has skinny extents
>> [203285.351377] BTRFS error (device sda1): bad tree block start, want
>> 31457280 have 0
> This means some tree read failed miserably.
> It looks like btrfs is trying to read something from trimmed range.
>
>> [203285.383180] BTRFS error (device sda1): bad tree block start, want
>> 31506432 have 0
>> [203285.466743] BTRFS info (device sda1): read error corrected: ino 0
>> off 32735232 (dev /dev/sda1 sector 80320)
> This means btrfs still can get one good copy.
>
> Something is not working properly, either from btrfs or the lower stack.
>
> Have you tried to do the same thing without LUKS? Just btrfs over raw
> partition.
>
> And it's recommended to use newer kernel anyway.

I disagree. 4.19.y is an okay kernel to use w.r.t. btrfs, especially
since all the newer stable versions currently have the statfs() is zero
bug. The btrfs-tools version doesn't matter much, unless one has to use
"btrfs check", which is (hopefully) not usually necessary. As you can
see the kernel is also ~20 days old and 4.19.y is a LTS kernel, so it
still gets (btrfs) updates/bugfixes.

I would suspect a hardware issue with the WD disk (run badblocks for a
while to check). The USB can also cause problems (the USB 3.0 DMA was a
hack in RPI4 that wasn't merged upstream last I looked), but you didn't
list the whole dmesg...

>
> Thanks,
> Qu
>> --
>> Best regards
>>

