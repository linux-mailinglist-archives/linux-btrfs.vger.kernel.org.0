Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D090327E07
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhCAMPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 07:15:05 -0500
Received: from mail.knebb.de ([188.68.42.176]:56630 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhCAMPA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 07:15:00 -0500
Received: by mail.knebb.de (Postfix, from userid 121)
        id 6A44DE358F; Mon,  1 Mar 2021 13:14:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=1.7 tests=ALL_TRUSTED,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p5de00be0.dip0.t-ipconnect.de [93.224.11.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id 92AC8E0C25;
        Mon,  1 Mar 2021 13:14:14 +0100 (CET)
Subject: Re: Adding Device Fails - Why?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
 <0a746faf-6c3c-542b-ac71-8d5012e998bc@gmx.com>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Message-ID: <fae2c36d-956f-29a6-7001-28e973f86408@knebb.de>
Date:   Mon, 1 Mar 2021 13:10:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0a746faf-6c3c-542b-ac71-8d5012e998bc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

unfortunately I do not have any sources or compilers installed on this 
box. So I am unable to install this here. I can not even take a snapshot 
to install and compile because it is a two-node setup with drbd so 
resetting to a snapshot will fail for the drbd sync.

A reboot did not help.

I am happy in helping to debug this issue. But compiling on the 
"production" machine is not really fine...

I will setup a different machine to see if I can reproduce it there (I 
doubt it, though)....

/KNEBB

Am 01.03.2021 um 13:06 schrieb Qu Wenruo:
>
>
> On 2021/3/1 下午7:19, Christian Völker wrote:
>> Hi all,
>>
>> I am using BTRS on a Debian10 system. I am trying to extend my existing
>> filesystem with another device but adding it fails for no reason.
>>
>> This is my setup of existing btrfs:
>>
>>   2x DRBD Devices (Network RAID1)
>>   top of each a luks encrypted device (crypt_drbd1 and crypt_drbd3):
>>
>> vdb                         254:16   0  1,1T  0 disk
>> └─drbd1                     147:1    0  1,1T  0 disk
>>    └─crypt_drbd1             253:3    0  1,1T  0 crypt
>> vdc                         254:32   0  900G  0 disk
>> └─drbd2                     147:2    0  900G  0 disk
>>    └─crypt2                  253:4    0  900G  0 crypt
>> vdd                         254:48   0  800G  0 disk
>> └─drbd3                     147:3    0  800G  0 disk
>>    └─crypt_drbd3             253:5    0  800G  0 crypt /var/lib/backuppc
>>
>>
>>
>> I have now a third drbd device (drbd2) which I encrypted, too (crypt2).
>> And tried to add to existing fi.
>> Here further system information:
>>
>> Linux backuppc41 5.10.0-3-amd64 #1 SMP Debian 5.10.13-1 (2021-02-06)
>> x86_64 GNU/Linux
>> btrfs-progs v5.10.1
>>
>> root@backuppc41:~# btrfs fi sh
>> Label: 'backcuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>>          Total devices 2 FS bytes used 1.83TiB
>>          devid    3 size 799.96GiB used 789.96GiB path dm-5
>>          devid    4 size 1.07TiB used 1.06TiB path dm-3
>>
>>
>> I can create an additional btrfs filesystem with mkfs.btrfs on the new
>> device without any issues:
>>
>> root@backuppc41:~# btrfs fi sh
>> Label: 'backcuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>>          Total devices 2 FS bytes used 1.83TiB
>>          devid    3 size 799.96GiB used 789.96GiB path dm-5
>>          devid    4 size 1.07TiB used 1.06TiB path dm-3
>>
>> Label: none  uuid: b111a08e-2969-457a-b9f1-551ff65451d1
>>          Total devices 1 FS bytes used 128.00KiB
>>          devid    1 size 899.96GiB used 2.02GiB path /dev/mapper/crypt2
>>
>>
>> But I can not add this device to the existing btrfs fi:
>> root@backuppc41:~# wipefs /dev/mapper/crypt2 -a
>> /dev/mapper/crypt2: 8 bytes were erased at offset 0x00010040 (btrfs): 5f
>> 42 48 52 66 53 5f 4d
>>
>> root@backuppc41:~# btrfs device add /dev/mapper/crypt2 
>> /var/lib/backuppc/
>> ERROR: error adding device 'dm-4': No such file or directory
>>
>> This is what I see in dmesg:
>> [43827.535383] BTRFS info (device dm-5): disk added /dev/drbd2
>> [43868.910994] BTRFS info (device dm-5): device deleted: /dev/drbd2
>> [48125.323995] BTRFS: device fsid 2b4b631c-b500-4f8d-909c-e88b012eba1e
>> devid 1 transid 5 /dev/mapper/crypt2 scanned by mkfs.btrfs (4937)
>> [57799.499249] BTRFS: device fsid b111a08e-2969-457a-b9f1-551ff65451d1
>> devid 1 transid 5 /dev/mapper/crypt2 scanned by mkfs.btrfs (5178)
>
> If you can recompile btrfs module, would you mind to test the following
> diff to help us debugging the problem?
>
> Of course, after applying the diff and recompiling the module, you still
> need to use the new btrfs module to try add the device again to trigger
> the error.
>
> Thanks,
> Qu
>>
>>
>>
>> And these are the mapping in dm:
>>
>> root@backuppc41:~# ll /dev/mapper/
>> insgesamt 0
>> lrwxrwxrwx 1 root root       7 28. Feb 21:08 backuppc41--vg-root -> 
>> ../dm-1
>> lrwxrwxrwx 1 root root       7 28. Feb 21:08 backuppc41--vg-swap_1 ->
>> ../dm-2
>> crw------- 1 root root 10, 236 28. Feb 21:08 control
>> lrwxrwxrwx 1 root root       7  1. Mär 12:12 crypt2 -> ../dm-4
>> lrwxrwxrwx 1 root root       7 28. Feb 20:21 crypt_drbd1 -> ../dm-3
>> lrwxrwxrwx 1 root root       7 28. Feb 20:21 crypt_drbd3 -> ../dm-5
>> lrwxrwxrwx 1 root root       7 28. Feb 21:08 vda5_crypt -> ../dm-0
>>
>>
>> Anyone having an idea why I can not add the device to the existing
>> filesystem? The error message is not really helpful...
>>
>> Thanks a lot!
>>
>> /KNEBB
>>
>>
>>

