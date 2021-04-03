Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B746A3534AD
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhDCQMy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 3 Apr 2021 12:12:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhDCQMx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Apr 2021 12:12:53 -0400
Received: from [192.168.177.174] ([91.56.95.140]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mv2tE-1lkFo837JY-00r35Q; Sat, 03 Apr 2021 18:12:48 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Chris Murphy" <lists@colorremedies.com>
Subject: Re[6]: Filesystem sometimes Hangs
Cc:     "Chris Murphy" <lists@colorremedies.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Sat, 03 Apr 2021 16:12:51 +0000
Message-Id: <em52a23210-b2ff-41aa-a44c-ad3f5cfba009@desktop-g0r648m>
In-Reply-To: <CAJCQCtTTo+fTJ8nfRqWovSeRJEF72C0RQmydGq=ju86HAMMECw@mail.gmail.com>
References: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
 <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com>
 <em7b647410-6346-4e95-b97a-f45ee2de0037@desktop-g0r648m>
 <CAJCQCtQH=k_h7CyRLysea0NgqadPnOVtVTGzdU9pG69RRhqL+g@mail.gmail.com>
 <emf567b17e-42d3-4c32-b254-a19d06ed87c5@desktop-g0r648m>
 <CAJCQCtTTo+fTJ8nfRqWovSeRJEF72C0RQmydGq=ju86HAMMECw@mail.gmail.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.1.1060.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:0LHYQ9ODnIyeIV2Xuz5wj16XVUWsBecN5I4ESe6I/4Op/KGKr6x
 KRhlfb8Kmd6iDNTe4GUM2psa/yCCLeyLLurJqSuYrw2J0A4UATxoLFBYJ+vGt1NhovBFq7m
 jcFt2AFqg8tuo2UxXvVgLTo09dKanTD4sWc0m28EnuPmm1MzfUahjXzEfwNjXGHvzG+LgW/
 uue2AAVFu1QeDMEVKHxQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DEVGSq0ZjPY=:8QNyvsnKNx7KIqvBIiYADt
 G3Q6rj2hTZvVC2nLtxaG9/50/9u6gyijyMw2SOQwSQbUiFNaZ42+hAmymNfGnkWvYxJDRiRWs
 0Z6eqQzFlPvPv14ADB7fXsAJU74D9L/iQy48PY31oHJmCNlFinIxhvDwaI7NYHRrzl7ybUqOt
 QzEqTE5vJIFkQ6UyYe2wBiVBBhVV6bdbjsrJ16RsgvWEZx5bAzm0/ZMJiHz9WFWmlyoxvC4Ea
 vTh73Ghv9BO+wdcHNvzFbgigktPwCrzhpCGKwHDXmvhxTvgwuS5QFidV2vn++Q25q47C4e2Ih
 dIUtLfqWfzh7ul+vUjPn8lM7wf4ZrxnNON0UrOPuO5FOp6eCHzUax2RcR7XYaNhry1L+qkZE1
 4IQB5P92UYPY7FvCbRJ5sAno9tTcrkXTyGMkki5u7VYn7AEVtUitP88IxhggBwLZAwFl08GAT
 gHS1sQ/lLsYv93oze0RtntwveyeeDP3KVzi2jVq/FFiR17spOr2+
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Chris,

thanks for your reply.

>>  >Remove the discard mount option for this file system and see if that
>>  >fixes the problem. Run it for a week or two, or until you're certain
>>  >the problem is still happening (or certain it's gone). Some drives
>>  >just can't handle sync discards, they become really slow and hang,
>>  >just like you're reporting.
>>
>>  In fstab, this option is not set:
>>  /dev/disk/by-label/DataPool1            /srv/dev-disk-by-label-DataPool1
>>          btrfs   noatime,defaults,nofail 0 2
>
>You have more than one btrfs file system.
Indeed:
grep btrfs
/dev/sdc2 on /srv/dev-disk-by-label-DockerImages type btrfs 
(rw,noatime,ssd,discard,space_cache,subvolid=5,subvol=/)
/dev/sdd2 on /srv/dev-disk-by-label-Daten type btrfs 
(rw,relatime,ssd,space_cache,subvolid=5,subvol=/)
/dev/sda1 on /srv/dev-disk-by-label-DataPool1 type btrfs 
(rw,noatime,space_cache,subvolid=5,subvol=/)

You can see, that for sdc2 and sdd2, "ssd" is in the mount options. For 
sdc2 discard is present. I have not added this myelf. But it is in 
fstab.
In fact, I got confused in my previous mail:
sdc is an ssd and not the drive that I was experiencing problems with 
(well: The system was slow when accessing sda1. I cannot exclude, that 
this was caused by sdc2.


>I'm suggesting not using
>discard on any of them to try and narrow down the problem.  Something
>is turning on discards for sdc2, find it and don't use it for a while.
Will do.
>
>>  How do I deactivate discard then?
>>  These drives are spinning disks. I thought that discard is only relevant
>>  for SSDs?
>
>It's relevant for thin provisioning and sparse files too. But if sdc2
>is a HDD then the sync discard message isn't related to the problem,
>but also makes me wonder why something is enabling sync discards on a
>HDD?
See above. It was my mistake, thinking it sdc2 was the spinning disc.

>Anway I think you're on the right track to try 5.11.11 and if you
>experience a hang again, use sysrq+w and that will dump the blocked
>task trace into dmesg. Also include a description of the workload at
>the time of the hang, and recent commands issued.
Ok, will do.

Thanks,
Hendrik
>
>
>
>
>--
>Chris Murphy

