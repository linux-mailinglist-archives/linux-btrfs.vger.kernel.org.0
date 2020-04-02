Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DE19C76E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbgDBQzh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 12:55:37 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:50629 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388689AbgDBQzg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 12:55:36 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id K37rjl0LrMAUpK37rjBW5l; Thu, 02 Apr 2020 18:55:33 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1585846533; bh=ubjmuuo+nw1PQz9KMHYL1VGWUH0EyiBz6ELDTR08dXY=;
        h=From;
        b=BU/ZkAMEr+CshE1++PQr8SwzkUyLfuSQVasRarjSYASJbGmV60FYTthDvwJVJvdYD
         Ne9jSsgkjbBny2CTLRRGL0VKLyjKeqC1osInWrB1F19lFCzeZNQ/tFZ6qtG5Ss4Vrc
         z76lWJdKffODZh2FwY2sEvR+pjRgKq5Kgj2hP40uQ6y9CM7mtO5fddPc1LyDXfOJmu
         GegqPva8ZcWdYQv4jyPx4opsl7AcTq1MxOxq/4JDvWqonlwHOSe1gIkDpZEPgQYclc
         LGjdpZwCLmwQ5pM+Cp6is4ERyIipZ7kAr8cc85N+zlnGSjW/r6O9eVD5NqAb/GZa7D
         5x4pPNAlYBYoA==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=Zu_UBlEkk2cA:10 a=Uq0mbvy6AAAA:8
 a=LyQO4dtgB6Wm7OhjR5AA:9 a=43hJES3UyIqiRDcS:21 a=u9jbxHOECnuVY9WC:21
 a=AWzbc7it75AA:10 a=9nAYT2xhiIK_ZOnRzmc7:22
Reply-To: kreijack@inwind.it
Subject: Re: comment about 'btrfs: add ssd_metadata mode'
To:     Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200402094040.B687.409509F4@e16-tech.com>
 <20200402115628.CBB1.409509F4@e16-tech.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <93480f19-c4ce-d2a2-cc6d-e9169dc7a414@inwind.it>
Date:   Thu, 2 Apr 2020 18:55:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402115628.CBB1.409509F4@e16-tech.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIKMHlfS32UNG3C++Bc0tD4jtgJi094bj7IQaZ5DZpdJ7A6/WtuSveRXE6x46T5NvFemqEWSv9UehI6MjbHANnDhLTCbPRgc5x7Wfp3P4JtdKXOEa54g
 slG7sxv2mXhCMqfxZyi5PwQrweY4HMmn/JCg+s85qiEcbt8C2LKUZme0PkrqNxkH+myKn2AH+HnZPFQeVCT5nxswnQpzciOFvJo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/2/20 5:56 AM, Wang Yugui wrote:
> Hi, Goffredo Baroncelli
> 
> 'btrfs balance' after 'mkfs.btrfs' seem OK to make sure
> not any HDD will be used as metadata.

Yes this is the expected behavior.
> 
> test env:
> 	kernel:5.4.29 + patch(btrfs: add ssd_metadata mode)
> 	/dev/sdb	hdd
> 	/dev/sdc 	ssd
> 
> test script:
> 	mkfs.btrfs -m single -d single /dev/sdc1 /dev/sdb1 -f
> 	mkdir -p /test &&
> 	mount /dev/sdb1 /test  || exit $?
> 
> 	btrfs fi usage /test
> 	btrfs balance start --full-balance /test
> 	btrfs fi usage /test
> 
> output of the script

[...]

> + btrfs balance start --full-balance /test
> Done, had to relocate 3 out of 3 chunks
> + btrfs fi usage /test
> Overall:
>      Device size:                 605.50GiB
>      Device allocated:              2.03GiB
>      Device unallocated:          603.46GiB
>      Device missing:                  0.00B
>      Used:                        640.00KiB
>      Free (estimated):            604.46GiB      (min: 604.46GiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:                3.25MiB      (used: 0.00B)
> 
> Data,single: Size:1.00GiB, Used:512.00KiB
>     /dev/sdb1       1.00GiB
> 
> Metadata,single: Size:1.00GiB, Used:112.00KiB
>     /dev/sdc1       1.00GiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB
>     /dev/sdc1      32.00MiB
> 
> Unallocated:
>     /dev/sdb1     418.19GiB
>     /dev/sdc1     185.28GiB

If the /dev/sdc1 is an SSD, yes my code works as expected :-)

> 
> Best Regards
> 王玉贵
> 2020/04/02
> 
>> Hi, Goffredo Baroncelli
>>
>> Thanks for the nice ideal of 'btrfs: add ssd_metadata mode'.
>>
>> a comment:
>> Should we add ssd_metadata mode to mkfs.btrfs too?
>> If so, we can let the first chunk works as expected too?

Having the first chunk correctly allocated, doesn't really matter. As you can saw a simple "btrfs bal"
rearrange the chunks. Updating mkfs.btrfs is not so urgency [*].

This patch is an experiment to have some feedback. There are a lot of open points:
- it is really useful ? I expect that in few years all disks will be SSD
- there are a lot of open point about what would returns (e.g.) "btrfs fi us": still is it correct to return as free space the sum of the free space of each disks ?
- increasing the speed of reading/writing metadata, how impact to the overall speed of the filesystem ? I expect no too much. If I find some spare time, I would measure the upgrading time of a debian from stable to unstable in the following scenarios:
- ssd
- ssd+hdd
- hdd

>>
>> Best Regards
>> 王玉贵
>> 2020/04/02

BR
G.Baroncelli
>>
>> --------------------------------------
>> 北京京垓科技有限公司
>> 王玉贵	wangyugui@e16-tech.com
>> 电话：+86-136-71123776
> 
> --------------------------------------
> 北京京垓科技有限公司
> 王玉贵	wangyugui@e16-tech.com
> 电话：+86-136-71123776
> 
[*] Anyway, I am inclined to think that the mkfs.btrfs should put the drive in a "initial state" only. The building of the files-system should be done only in the kernel the first time that it see a disk in a "initial state". This would avoid to have a lot of user space code which deals with the internal structure of a filesystem. There are a lot of repetition between the btrfs user space code and the btrfs kernel space code.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
