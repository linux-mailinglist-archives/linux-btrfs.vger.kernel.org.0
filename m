Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318773E7CD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhHJPwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 11:52:07 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:56409 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242136AbhHJPwH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 11:52:07 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 11:52:06 EDT
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id DTufmcs2uzHnRDTufmeTJ5; Tue, 10 Aug 2021 17:43:33 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1628610213; bh=KIdJtgzUhcUVi22Tm8l77qiIglCTsoNwwJgRLB2vdUk=;
        h=From;
        b=gyhsLfuCOuGXxOGCMJz9CllWygCezhZNzV/SwbGEfgo9A0jxVQi6agl6OATGgD8Ad
         bCFitz63On31J61kHKgA9vZyD6ihXY9EUucenTNRyH4Ade7abCT3dNhfAaYUA1bmbL
         QLK5Ma8pRR6eDNdj0qBRTyPKD4g04jC9YLyU6gk6XfB1LGT7SDe6IpIlcFDFDmuubl
         aJp0PAPxNhmAA8Z7fV0Hno1EE3k+saEWO6tV1B6Wwo1VNFK3dFefdNyA6I6whNorzg
         Ib8Sleacp+FB1We3MfLj/bOlelKU0BaCsQz8SAyimbXItVLbwx6ZQRTQlD9T3++iLP
         Jsk2a0cn8Pclw==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=61129ea5 cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=-OG0X8f0pSSBEIufZUAA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     Dave T <davestechshop@gmail.com>
Cc:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
 <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it>
 <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it>
Date:   Tue, 10 Aug 2021 17:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfG4tln91N920h0k0px57v2/xaZEMpkW6YKjzXJ58JoLjxeIh7pm2d3LFivzxw6K8TeFQJM9Lj7P5vixJAvYsUonyLpBtq8ug2Tu4uiE5hkNQnSQoclbb
 HZwXXno82NC5zCBZVGEmc79Ix1j2BafD2BRWzHV+SMYd6fGQFafxIaAfwt5z2SJalciJEaAfGDYOvrIDU7Aj+O9X5l8RjXLMg26N9B22dklmXs1y+Gwx9Oyq
 m8oxy1j2QRbeye/scqwK0d4c8wFl5jA6vEymGu0pMkestio98GyqvN1Oa+KvjLDnWEarEdpnE0WD7iMHMkMsh5OkoK8bJhN8Aje4CMPzoVM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/21 10:15 PM, Dave T wrote:
> On Mon, Aug 9, 2021 at 3:29 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
[...]

> 
> Also, in recent days I stopped mounting and umounting /mnt/btrtop/root
> and just left it mounted all the time. However, when checking today, I
> still found a nested mount:
> 
> ├─/srv/nfs/var/cache/pacman
> │
> │ └─/srv/nfs/var/cache/pacman
> 
> 

Ok, so it seems that these mounts are triggered not by the mount of /mnt/btrtop/root (see below). What is the output of

$ systemctl --reverse list-dependencies -- srv-nfs-var-cache-pacman.mount



[...]
> 
> As mentioned, I have (temporarily) stopped unmounting these volumes
> and I just leave them mounted all the time. The logs now look like
> this:
> 
> Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes...
> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
> 3) was already mounted. Nothing to do.
> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
> 3) was already mounted. Nothing to do.
> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
> 3) was already mounted. Nothing to do.

This told another story. It seems that "btrbk" itself already try to mount the btrfs subvolume. I understood that it was the systemd unit to do that. Could you share the content of btrbk_run.sh ?


> Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop volumes.
> Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes...
> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
> 3) was already mounted. Nothing to do.
> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
> 3) was already mounted. Nothing to do.
> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
> 3) was already mounted. Nothing to do.
> Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop volumes.
> 
>>
>>>
>>> The path /var/cache/pacman is not a subvolume, but it resides on btrfs
>>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
>>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
>>> additional mount operation seems to be causing these nested mounts of
>>> my bind mount for  /srv/nfs/var/cache/pacman .
>>>
>>> P.S. I cannot test without using systemd. (I'm not even sure I
>>> remember how to use a non-systemd distro anymore!)
>>>
>>
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
