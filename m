Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03849153114
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 13:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgBEMuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 07:50:52 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:34177 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEMuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 07:50:52 -0500
Received: by mail-wr1-f51.google.com with SMTP id t2so2614515wrr.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s9ORseT5pqLH7IGHWONiZpmTAl9Z/vpuq1ydpG4axqE=;
        b=YPQkrs1pRmG+mpX/4N6sJpZwwzX+TVhqmtDUIjrD+ePFZu+BLsaYT8nQAjXxBYFJXF
         xQ5IDkBO2l1xSrnK0S+sJ+gI2ZwKzYfFKU1iq1xpWab2f4WIzTTj+/BHbL0TSAeJExpM
         bH6QqtmaY06Q6XDlmJ/gcWnuODXqdSnfjjtKQ8zsZLbed4m+9diaGC1Mbi91oUPnFmv3
         vx6NKoheOsQppQNtrQJbvFmv7opt5T3ThPTOz6RNJQ5cOPQzZajMfDgfc7+aby0weyi+
         U1GJj8MLoMN56wCG4XLaiHFZo6Lzy7JZ23ZiFLr4Wtc8nFsj5Y2gikI6Ba4Goj/0zF7B
         6Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=s9ORseT5pqLH7IGHWONiZpmTAl9Z/vpuq1ydpG4axqE=;
        b=H4qUjX8Jrpr6Vn6dY1Qol8nGSUTbUNMIGoFPxbdfD/5b8ORimhbVZdNUjiuHaN1jS/
         3gBBpjEusfWLluuNg/M4X1yFpOyObY5s55elhyFoQtc+RmDVJkX+ztDNsG7F84TcLmwT
         8sv3wtdWIUtpDydsa2NB7H/jJEiXinwGY02Gwhfv0lBkxpjJ6YYycv7QYpcv2Y7e7FfR
         RvSFTUNqDT2+7d7SEgvQGUPDFsLDWbVNvcKDK9l/N5VsgkuBofknoP4edoalRjj/I+tr
         skRMDHDM7fr35CLku1OvEfGoRP5/0A6qb1OtyV2JGyTHumae8ETe0kn9oREYD/OBoZWH
         monw==
X-Gm-Message-State: APjAAAU+VKLqFOzpqdbC7vfUt9eaKK3BDpavoHB97Q3foMr8dBF1Y2qX
        PoneGEl7w8Nh5Zd+f+tcR/0XGGZT
X-Google-Smtp-Source: APXvYqwMPX7SHSOAQDdJct46Tq32OMW5w/1PUVxB8PwYM9fFJwJZ0SJcWJajTF2CiBtyR4ADxyJ2Vw==
X-Received: by 2002:a5d:5263:: with SMTP id l3mr27829445wrc.405.1580907048344;
        Wed, 05 Feb 2020 04:50:48 -0800 (PST)
Received: from [172.30.6.50] ([194.254.15.132])
        by smtp.googlemail.com with ESMTPSA id t1sm8344446wma.43.2020.02.05.04.50.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 04:50:47 -0800 (PST)
Subject: Re: Endless mount and backpointer mismatch
From:   Pepie 34 <pepie34@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <c541f131-c60b-4957-0f86-3039da69f788@gmail.com>
 <f7966f07-38e1-f72e-984d-31f46dd2f5ec@gmx.com>
 <68862258-d3e8-3568-5d1a-6f42bdb8d3b9@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pepie34@gmail.com; keydata=
 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
Message-ID: <f4bd3226-2cf1-cacb-6f80-2838ba9121d0@gmail.com>
Date:   Wed, 5 Feb 2020 13:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <68862258-d3e8-3568-5d1a-6f42bdb8d3b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

For your information I have updated my kernel to 5.4.8-1~bpo10+1 and
btrfs-progs to 5.2.1-1~bpo10+1 (from buster backports).

From there I could mount rw with skip_balance, then cancel balance. 
After that, btrfs scrub and btrfs check displayed no error, except
inconsistency in the space cache which I corrected by a clear_cache.

By the way, do you advise to use space_cache on encrypted device ?

Best regards,

Pepie 34

Le 28/01/2020 à 18:32, Pepie 34 a écrit :
> Le 28/01/2020 à 02:23, Qu Wenruo a écrit :
>> On 2020/1/28 上午5:20, Pepie 34 wrote:
>>> Dear BTRFS community,
>>>
>>> I've a raid 1 setup on two luks encrypted drives for 4 years that serves
>>> me as btrbk backup target from an other computer.
>>> There is a lot of ro snaptshots on it.
>>>
>>> I've mistakenly launched a balance on it which was extremely slow and
>>> tried to cancelled it.
>>> After two days of cancelling without results, I decided to power off the
>>> computer.
>>>
>>> After the reboot, even with the skip_balance mount option, the mounting
>>> is endless, no error in the kernel message and it never mounts.
>> Is there anything like "relocating block group XXXX flags XXXX" ?
> No but other messages see below
>
>
>>> What I have done so far:
>>> - mount the volume with the ro option (fast to mount, data OK).
>>> - scrub in ro mode, no error found
>> So data are all OK.
>> Just need a way to cancel the balance.
>>
>>> - btrfs check
>>> In the extent check  there is plenty of errors like this :
>>> =>
>>> ref mismatch on [9404816285696 32768] extent item 6, found 5
>>>
>>> incorrect local backref count on 9404816285696 parent 5712684302336
>>> owner 0 offset 0 found 0 wanted 1 back 0x55f371ee1ad0
>>> backref disk bytenr does not match extent record, bytenr=9404816285696,
>>> ref bytenr=0
>>> backpointer mismatch on [9404816285696 32768]
>>> <=
>> It could be caused by half-balanced fs.
>> Need to re-check after we cancel the balance.
>>
>>> No errors in other checks, though checking "quota groups" is very slow.
>> That's caused by the nature of qgroup.
>>
>>> What should I do ? btrfs check --repair ?
>>> btrfs check --init-extent-tree ?
>>> btrfs --clear-space-cache ?
>> None of the options should affect data, but none of them are recommened.
>>
>> Since the problem is about the balance.
>>
>> Have you tried to mount the fs with RO,skip_balance, then remount it rw?
> I have mount it ro,skip_balance then rw.
>
> It is now 12h it is trying to mount rw.
>
> I 've messages that tasks have taken more than 120 seconds in the kernel
> log.
>
> Some samples:
>
> [43621.876315] INFO: task btrfs-transacti:21846 blocked for more than
> 120
> seconds.                                                                                                                                
>
> [43621.876325]       Not tainted 4.19.0-6-amd64 #1 Debian
> 4.19.67-2+deb10u2                                                                                                                                       
>
> [43621.876327] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this
> message.                                                                                                                          
>
> [43621.876331] btrfs-transacti D    0 21846      2
> 0x80000000                                                                                                                                                     
>
> [43621.876334] Call
> Trace:                                                                                                                                                                                        
>
> [43621.876345]  ?
> __schedule+0x2a2/0x870                                                                                                                                                                          
>
> [43621.876347] 
> schedule+0x28/0x80                                                                                                                                                                                
>
> [43621.876394]  btrfs_commit_transaction+0x75f/0x880
> [btrfs]                                                                                                                                                      
>
> [43621.876399]  ?
> finish_wait+0x80/0x80                                                                                                                                                                           
>
> [43621.876419]  transaction_kthread+0x147/0x180
> [btrfs]                                                                                                                                                           
>
> [43621.876440]  ? btrfs_cleanup_transaction+0x530/0x530
> [btrfs]                                                                                                                                                   
>
> [43621.876443] 
> kthread+0x112/0x130                                                                                                                                                                               
>
> [43621.876445]  ?
> kthread_bind+0x30/0x30                                                                                                                                                                          
>
> [43621.876447] 
> ret_from_fork+0x22/0x40                                                                                                                                                                                                              
>
>
>
> [44346.867777] INFO: task mount:21595 blocked for more than 120
> seconds.                                                                                                                                          
>
> [44346.867788]       Not tainted 4.19.0-6-amd64 #1 Debian 4.19.67-2+deb10u2
> [44346.867791] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [44346.867795] mount           D    0 21595  21594 0x00000000
> [44346.867797] Call Trace:
> [44346.867809]  ? __schedule+0x2a2/0x870
> [44346.867812]  ? __wake_up_common+0x7a/0x190
> [44346.867814]  schedule+0x28/0x80
> [44346.867859]  wait_current_trans+0xc3/0xf0 [btrfs]
> [44346.867863]  ? finish_wait+0x80/0x80
> [44346.867884]  start_transaction+0x317/0x3e0 [btrfs]
> [44346.867908]  merge_reloc_root+0xf5/0x560 [btrfs]
> [44346.867933]  merge_reloc_roots+0xda/0x1f0 [btrfs]
> [44346.867957]  btrfs_recover_relocation+0x42d/0x490 [btrfs]
> [44346.867978]  open_ctree+0x1860/0x1bf0 [btrfs]
> [44346.867995]  btrfs_mount_root+0x682/0x740 [btrfs]
> [44346.867999]  ? cpumask_next+0x16/0x20
> [44346.868002]  ? pcpu_alloc+0x321/0x640
> [44346.868005]  mount_fs+0x3e/0x145
> [44346.868008]  vfs_kern_mount.part.36+0x54/0x120
> [44346.868024]  btrfs_mount+0x16f/0x860 [btrfs]
> [44346.868027]  ? path_lookupat.isra.48+0xa3/0x220
> [44346.868028]  ? legitimize_path.isra.41+0x2d/0x60
> [44346.868030]  ? cpumask_next+0x16/0x20
> [44346.868031]  ? pcpu_alloc+0x321/0x640
> [44346.868032]  ? mount_fs+0x3e/0x145
> [44346.868034]  mount_fs+0x3e/0x145
> [44346.868035]  vfs_kern_mount.part.36+0x54/0x120
> [44346.868037]  do_mount+0x20e/0xcc0
> [44346.868039]  ? _cond_resched+0x15/0x30
> [44346.868041]  ? kmem_cache_alloc_trace+0x155/0x1d0
> [44346.868043]  ksys_mount+0xb6/0xd0
> [44346.868044]  __x64_sys_mount+0x21/0x30
> [44346.868047]  do_syscall_64+0x53/0x110
> [44346.868050]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [44346.868052] RIP: 0033:0x7ff50cb41fea
> [44346.868060] Code: Bad RIP value.
> [44346.868061] RSP: 002b:00007ffd2257b2e8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a5
> [44346.868063] RAX: ffffffffffffffda RBX: 000055cc47409a40 RCX:
> 00007ff50cb41fea
> [44346.868064] RDX: 000055cc4740be00 RSI: 000055cc47409c50 RDI:
> 000055cc4740aa50
> [44346.868065] RBP: 00007ff50ce961c4 R08: 000055cc47409c70 R09:
> 000055cc474119e0
> [44346.868065] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> [44346.868066] R13: 0000000000000000 R14: 000055cc4740aa50 R15:
> 000055cc4740be00
>
> Besides shutting down the computer, is there a proper way to stop the
> mounting ?
>
> Best regards,
>
> Pepie 34
>
>
>> Thanks,
>> Qu
>>
>>> Will the "init extent tree" option break btrfs receive with old snapshot
>>> parents ?
>>>
>>> Best regards,
>>>
>>> Pepie34
>>>

