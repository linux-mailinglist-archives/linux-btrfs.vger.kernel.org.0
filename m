Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3F1F0AC4
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgFGKJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 06:09:33 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:56666 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbgFGKJd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 06:09:33 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id hsF8jSuMBtrlwhsF8jCDAQ; Sun, 07 Jun 2020 12:09:31 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1591524571; bh=iOfRwTs1TIfzhPkhGwOdpL3GWlsnnKcQ8p8rrY8aKFo=;
        h=From;
        b=DbDthcj114FByqd7Hn2We9qcHxowecV1Kkgap0XMoxoq4iW6MZA0z2uDg77BZvffJ
         imTJQ7KIXz8Up8xDmHvGF4fr4Yspow54CQnQBku4NUg0y+flFtnSt0Wf7i2VeVsMRN
         E7XfZp/xGQYueOtGTOei9CyG7l/W9Z3zYW5ea72RzvvN9lKnYCbozGmcFppRcAMlya
         pzWPd8hhHYSdM0pkzRNmqZzY0pG2vQXG5m8yKyr0mfJwdzjVl50ESCZRXgXqURC+Z1
         Uk2ivJz0N1gc/pk+zYGGCGhhxE3Zszsk7L1ilJB/Zs7SkR9PzeOzvUg2udbCD13zSg
         VML9mh7mw1eMQ==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=93y_fqLLj1RK88ajbZwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: balance + ENOFS -> readonly filesystem
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
Date:   Sun, 7 Jun 2020 12:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607083452.GA9208@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPLXqSzsO1TRrmwsghl38PCnPGkVnp47Qm8kHuEkl+L/JGBKKLGocgFQeshSOLLI/j+d/DExd+RHIExDRCsW9RJwV0/KcYgcutaDHLvY5IzOUyaqI6Qg
 bzc9ohjBsX10FOrWNtofzEwBPntb4XJksX5x+ySbXX0xSMHT6SOFetx3VHeXPaYZLOUv8OqKOMuoVbe9AYgqWjhqL+4NT10cLKBFciOjr9C4wZkjdLzvnEk/
 P4S3n/OBOld7aAbca4r2fA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/7/20 10:34 AM, Michał Mirosław wrote:
> On Sun, Jun 07, 2020 at 03:35:36PM +0800, Qu Wenruo wrote:
>> On 2020/6/7 下午1:12, Michał Mirosław wrote:
>>> Dear btrfs developers,
>>>
>>> I just added a new disk to already almost full filesystem and tried to
>>> enable raid1 for metadata (transcript below).
>> May I ask for your per-disk usage?
>>
>> There is a known bug (but rare to hit) that completely unbalance disk
>> usage can lead to unexpected ENOSPC (-28) error at certain critical code
>> and cause the transaction abort you're hitting.
>>
>> If you have added a new disk to an almost full one, then I guess that
>> would be the case...
> 
> # btrfs filesystem usage .
> Overall:
>      Device size:                   1.82TiB
>      Device allocated:            932.51GiB
>      Device unallocated:          930.49GiB
>      Device missing:                  0.00B
>      Used:                        927.28GiB
>      Free (estimated):            933.86GiB      (min: 468.62GiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,single: Size:928.47GiB, Used:925.10GiB
>     /dev/mapper/btrfs1         927.47GiB
>     /dev/mapper/btrfs2           1.00GiB
> 
> Metadata,RAID1: Size:12.00MiB, Used:1.64MiB
>     /dev/mapper/btrfs1          12.00MiB
>     /dev/mapper/btrfs2          12.00MiB
> 
> Metadata,DUP: Size:2.00GiB, Used:1.09GiB
>     /dev/mapper/btrfs1           4.00GiB
> 
> System,DUP: Size:8.00MiB, Used:144.00KiB
>     /dev/mapper/btrfs1          16.00MiB
> 
> Unallocated:
>     /dev/mapper/btrfs1           1.02MiB
>     /dev/mapper/btrfs2         930.49GiB

The old disk is full. And the fact that Metadata has a raid1 profile prevent further metadata allocation/reshape.
The filesystem goes RO after the mount ? If no a simple balance of metadata should be enough; pay attention to select
"single" profile for metadata for this first attempt.

# btrfs balance start -mconvert=single <mnt-point>

This should free about 4G from the old disk. Then, balance the data

# btrfs balance start -d <mnt-point>

Then rebalance the metadata as raid1, because now you should have enough space.

# btrfs balance start -mconvert=raid1 <mnt-point>



> 
>>> The operation failed and
>>> left the filesystem in readonly state. Is this expected?
>>
>> Definitely not.
>>
>> If your disk layout fits my assumption, then the following patchset is
>> worth trying:
>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=297005
> 
> I'll give it a try.
> 
> Best Regards,
> Michał Mirosław
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
