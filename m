Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518EB3E8432
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 22:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhHJUSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 16:18:08 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:56630 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232731AbhHJUSI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 16:18:08 -0400
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id DYBzmeOt3zHnRDYBzmfL7y; Tue, 10 Aug 2021 22:17:44 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1628626664; bh=YBXdDEIlbv6o35/5RDVl+Ev6JZbJlcZ8ZQ+M9PUaEro=;
        h=From;
        b=FIyDQ3fbR3IqpXByIf1UL/qL0/Yv2K0VGkFSvc5bZyPrnwvHVZWAPM4SvXGXumSQW
         S/XYFeRpXgKrSCcrUTUu5TbVn/XQsTOntpsm9pVXoLLaVhA2PIhFClteO0CnO9f/wD
         EfZ0mDCJjZzp2S6tNgaTV7zqzvBBgyBOMv0kkWp8FyeXrkQ7qz4aw62V1GmppRsR7F
         Hf8Ax+R2GRSsfqb+urYPHtwL27xw0lukk/FfdR++q+Hbv3LBOPm1lZQ9y74rzhTwQN
         /mTiQfH5o5E1dPKobOPFfB6bqrv6Ap99qHE7BInbrkzcCXOXw3XGCEIrdy7FJofknS
         zF4AskjSF41cg==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=6112dee8 cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=QMlGLysAAkh2loSHXMMA:9 a=QEXdDO2ut3YA:10
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
 <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it>
 <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
 <a8ee4ee6-ce11-45d4-f793-a98921cc8405@inwind.it>
 <CAGdWbB5mU-3J0wsha92Ry9HYdH1G7-0H05rza10RVLcKt1QKbQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <cf7399d4-1d41-5223-e633-e90ea4cde9e5@inwind.it>
Date:   Tue, 10 Aug 2021 22:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB5mU-3J0wsha92Ry9HYdH1G7-0H05rza10RVLcKt1QKbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGy353BepKmDub4ln+gBZ5bFAs7LSWY+uG5DNnsJpS4vUDQ2uBPLqqRITiJ/nDUMXSFHasP0/PmMfqFphDsi/H2n2aDPToLQVF8S1WMn0TO4uL3VJ8x2
 tgvLdbQlsBk1rPs4ibiG757NDFi/0/BBDn4OfNAvWIkaX4syhMp80PteG1/goTa1HXbvloyXdNU39a/4ddvNd/4Pfo7KXHs4oL5I+kTrgx2zAy8Kxhd3M1Gt
 N7E1x5TMPlGleXHlQG3/lFglnnoXLlswB4gv2gqxrI6uv9AyruJKzYQLpcfx9J623kMYrbV4p8FQL3JmYQLvyGC6uwqI6qh6/WB2+kCVOKY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/21 6:27 PM, Dave T wrote:
> On Tue, Aug 10, 2021 at 12:17 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>> On 8/10/21 6:03 PM, Dave T wrote:
>>> On Tue, Aug 10, 2021 at 11:43 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
[...]
>> What is more interesting is the dependencies between srv-nfs-var-cache-pacman.mount and nfs-server.service. I suspect (but I don't have any proof) that systemd is confused by the tuple {btrfs subvolume, bind mount, nfs dependecies}.
>>
>> What happens if you restart the nfs-server ?
> 
> As part of this issue, nfs clients have been experiencing slowness and
> sometimes hangs. I have restarted the nfs server service a few times
> while this issue was happening and it seems to temporarily resolve the
> client issues, but I'm not 100% sure because a specific incident will
> resolve eventually on its own without any intervention by me. But
> future incidences of slowness or temporary hangs are continuing and I
> do think this is all related.
> 
> Restarting the nfs server service does not make the nested mounts we
> are discussing go away. I have to unwind them with multiple calls to
> umount -- although the number of calls is less than the number of
> nested mounts, which I find confusing. Typically just 2-3 calls to
> umount will unmount a nesting 5-6 deep.
> 
> Clients connect to a number of different nfs shares from this server,
> yet none of the others wind up with nested mounts like
> srv-nfs-var-cache-pacman.mount . All mounts are configured the same
> way, using the same bind mount parameters in fstab.
> 

Unfortunately I don't have any more suggestions..

My opinion is that the problem is not related to the btrfs itself, but it is more a side effect of the interaction between systemd and btrfs. What about looking to the log ?

$ sudo journalctl -u  srv-nfs-var-cache-pacman.mount

Then check the log near the mount/unmount

To avoid this problem enterely, what about using a symlink instead of the bind mount ?

Something like

# rmdir /srv/nfs/var/cache/pacman ; ln -sf /var/cache/pacman /srv/nfs/var/cache/pacman


BR
GB

>>>
>>>>
>>>> [...]
>>>>>
>>>>> As mentioned, I have (temporarily) stopped unmounting these volumes
>>>>> and I just leave them mounted all the time. The logs now look like
>>>>> this:
>>>>>
>>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes...
>>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
>>>>> 3) was already mounted. Nothing to do.
>>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
>>>>> 3) was already mounted. Nothing to do.
>>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
>>>>> 3) was already mounted. Nothing to do.
>>>>
>>>> This told another story. It seems that "btrbk" itself already try to mount the btrfs subvolume. I understood that it was the systemd unit to do that. Could you share the content of btrbk_run.sh ?
>>>>
>>>
>>> # systemctl cat btrbk.service
>>> # /usr/lib/systemd/system/btrbk.service
>>> [Unit]
>>> Description=btrbk backup
>>> Documentation=man:btrbk(1)
>>>
>>> [Service]
>>> Type=oneshot
>>> ExecStart=/usr/bin/btrbk run
>>>
>>> # /etc/systemd/system/btrbk.service.d/override.conf
>>> [Service]
>>> ExecStart=
>>> ExecStart=/usr/local/bin/btrbk_run.sh
>>>
>>>
>>> # cat /usr/local/bin/btrbk_run.sh
>>> #!/bin/bash
>>>
>>> /usr/local/bin/btrbk_mount
>>>
>>> /usr/bin/btrbk --config /etc/btrbk/btrbk.conf run
>>>
>>> # 2021-08-05 My first troubleshooting step is to disable unmounting
>>> these shares.
>>> # /usr/local/bin/btrbk-umount
>>>
>>>
>>> # cat /usr/local/bin/btrbk_mount
>>> #!/bin/bash
>>>
>>> btrbk_mount() {
>>>
>>> echo "mounting btrbk btrtop volumes..."
>>>
>>> findmnt /mnt/btrtop/root
>>> if [[ $? -ne 0 ]]; then \
>>>     mount /mnt/btrtop/root
>>>     if [[ $? -ne 0 ]]; then \
>>>       echo "ERROR: failed to mount [/mnt/btrtop/root] (1 of 3)"
>>>     else
>>>       echo "OK: mounted [/mnt/btrtop/root] (1 of 3)"
>>>     fi
>>> else
>>>     echo "INFO: [/mnt/btrtop/root] (1 of 3) was already mounted. Nothing to do."
>>> fi
>>> findmnt /mnt/btrtop/home
>>> if [[ $? -ne 0 ]]; then \
>>>     mount /mnt/btrtop/home
>>>     if [[ $? -ne 0 ]]; then \
>>>       echo "ERROR: failed to mount [/mnt/btrtop/home] (2 of 3)"
>>>     else
>>>       echo "OK: mounted [/mnt/btrtop/home] (2 of 3)"
>>>     fi
>>> else
>>>     echo "INFO: [/mnt/btrtop/home] (2 of 3) was already mounted. Nothing to do."
>>> fi
>>> findmnt /mnt/btrtop/user
>>> if [[ $? -ne 0 ]]; then \
>>>     mount /mnt/btrtop/user
>>>     if [[ $? -ne 0 ]]; then \
>>>       echo "ERROR: failed to mount [/mnt/btrtop/user] (3 of 3)"
>>>     else
>>>       echo "OK: mounted mount [/mnt/btrtop/user] (3 of 3)"
>>>     fi
>>> else
>>>     echo "INFO: [/mnt/btrtop/user] (3 of 3) was already mounted. Nothing to do."
>>> fi
>>>
>>> echo "Finished mounting btrbk btrtop volumes."
>>>
>>> }
>>>
>>> btrbk_mount
>>>
>>> # end of file /usr/local/bin/btrbk_mount
>>>
>>>
>>>>
>>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop volumes.
>>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes...
>>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
>>>>> 3) was already mounted. Nothing to do.
>>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
>>>>> 3) was already mounted. Nothing to do.
>>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
>>>>> 3) was already mounted. Nothing to do.
>>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop volumes.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> The path /var/cache/pacman is not a subvolume, but it resides on btrfs
>>>>>>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
>>>>>>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
>>>>>>> additional mount operation seems to be causing these nested mounts of
>>>>>>> my bind mount for  /srv/nfs/var/cache/pacman .
>>>>>>>
>>>>>>> P.S. I cannot test without using systemd. (I'm not even sure I
>>>>>>> remember how to use a non-systemd distro anymore!)
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>>>
>>>>
>>>> --
>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
