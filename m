Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE6522BE8D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXHDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 03:03:33 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:36875 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGXHDd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 03:03:33 -0400
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2020 03:03:32 EDT
X-Envelope-From: rolf.wald@lug-balista.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 06O6rF3t005157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 08:53:15 +0200
Received: from [192.168.241.72] (debian-01.wald.home [192.168.241.72])
        by mail.wald.home (Postfix) with ESMTPSA id 098461961DC;
        Fri, 24 Jul 2020 08:53:13 +0200 (CEST)
Subject: Re: df free space not correct with raid1 pools with an odd number of
 devices
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jorge Bastos <jorge.mrbastos@gmail.com>
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
From:   Rolf Wald <rolf.wald@lug-balista.de>
Message-ID: <3d4c91cf-64d7-2912-ba4a-66af5cbfb5a3@lug-balista.de>
Date:   Fri, 24 Jul 2020 08:53:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 24.07.20 um 06:40 schrieb Chris Murphy:
> On Thu, Jul 23, 2020 at 4:24 AM Jorge Bastos <jorge.mrbastos@gmail.com> wrote:
> 
>> 3 x 500GB (not correct)
>>
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/sdd1       699G  3.4M  466G   1% /mnt/cache
> 
>>
>> btrfs fi usage -T /mnt/cache
>> Overall:
>>     Device size:                   1.36TiB
>>     Device allocated:              4.06GiB
>>     Device unallocated:            1.36TiB
>>     Device missing:                  0.00B
>>     Used:                        288.00KiB
>>     Free (estimated):            697.61GiB      (min: 697.61GiB)
> 
> 
> Looks about correct? 1.36TiB*1024/2=696.32GiB
> 
> The discrepancy with Btrfs free showing ~1.3GiB more than device/2,
> might be cleared up by using --raw and computing from bytes. But Free
> rounded up becomes 698GiB which is 1GiB less than df's reported
> 699GiB. Again, it might be useful to look at bytes to see what's going
> on because they're each using different rounding up.
> 


Agreed, but the number of available bytes are definitely wrong on 
btrfs-raid1 with odd device number. They don't correspodent to
Free on btrfs file usage nor to the unallocated bytes (divided by 2)

eg. my 3-device btrfs-raid1 with 3 2T disks:

df -h / -> /dev/sdb2       2,8T    2,1T  521G   80% /

btrfs fi us / ->
Overall:
     Device size:                   5.46TiB
     Device allocated:              4.28TiB
     Device unallocated:            1.18TiB
     Device missing:                  0.00B
     Used:                          4.04TiB
     Free (estimated):            722.24GiB      (min: 722.24GiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
...

I hope, this problem could be solved. Applications show now false 
information about free space.

Thanks, Rolf

> 
> 
> 
>> Same for 5 devices and I assume any other odd number of devices:
>>
>> 5 x 500GB
>>
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/sdd1       1.2T  3.4M  931G   1% /mnt/cache
>>
>> btrfs fi usage -T /mnt/cache
>> Overall:
>>     Device size:                   2.27TiB
>>     Device allocated:              4.06GiB
>>     Device unallocated:            2.27TiB
>>     Device missing:                  0.00B
>>     Used:                        288.00KiB
>>     Free (estimated):              1.14TiB      (min: 1.14TiB)
> 
> 2.27/2=1.135 So that's pretty spot on for Free. And yes, df will round
> this up yet again to 1.2TiB because it always rounds up.
> 
> 
> 

-- 
Mit freundlichen Grüßen (kind regards) Rolf Wald
LUG-Balista Hamburg e.V., Germany
c/o Bürgerhaus Barmbek
Lorichsstr. 28a
22307 Hamburg
http://www.lug-hamburg.de
No HTML please
S/MIME signed email preferred, encryption wanted
