Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA624EDD4
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHWPFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 11:05:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHWPFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 11:05:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07NF5ZOb110681;
        Sun, 23 Aug 2020 15:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3GmE08Xdswk+yiT7OzFi03mX7mBD9zHLFLGFLVcTMnU=;
 b=BGxnJu0HB0sx/pPIfYMxPZNgcwKB9A0Tki31bm8YWMfG4ENYhUJkhWfxKXn8p6A+2doO
 fzIu2JSvYNRU1tUdfx9haL45Ooj/g+MURN0j97gjg5RYuFzuEbj69CJ8NinDeQmhO/GJ
 rFC1socbJ4ZPkrRV+ekjjwD8ljUR+4XyRBMPSR6jihThd7WYtNHlAynoS7jFbPY17FS4
 2HsdOyb3BH8NwewexY+2iZHStG4ye55JlS+DRbJB+53ZiUlz8SDJfboQYjQhTo8P2G7+
 sX/uPs7VKppl4M1jTURBfsEhXDHyl4hzR8T1rlVYfOPsqU+mjI8lFasf5jG+81lY0AWu Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333cse18s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Aug 2020 15:05:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07NF00v5088638;
        Sun, 23 Aug 2020 15:05:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 333ru2exng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Aug 2020 15:05:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07NF5XOe028064;
        Sun, 23 Aug 2020 15:05:33 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Aug 2020 08:05:33 -0700
Subject: Re: [PATCH RFC 2/2] btrfs: fix replace of seed device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     boris@bur.io
References: <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
 <eb6040708e4f351ae668726862e3f112f64d8ab9.1598012410.git.anand.jain@oracle.com>
 <56431875-619d-fb49-efb2-9fcd265a8a69@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0f7add45-911f-825a-965e-7cd76bb3ee22@oracle.com>
Date:   Sun, 23 Aug 2020 23:05:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <56431875-619d-fb49-efb2-9fcd265a8a69@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008230168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008230169
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/8/20 10:38 pm, Josef Bacik wrote:
> On 8/21/20 9:15 AM, Anand Jain wrote:
>> If you replace a seed device in a sprouted fs, it appears to have
>> successfully replaced the seed device, but if you look closely, it 
>> didn't.
>>
>> Here is an example.
>>
>> mkfs.btrfs -fq /dev/sda
>> btrfstune -S1 /dev/sda
>> mount /dev/sda /btrfs
>> btrfs dev add /dev/sdb /btrfs
>> umount /btrfs; btrfs dev scan --forget
>> mount -o device=/dev/sda /dev/sdb /btrfs
>> btrfs rep start -f /dev/sda /dev/sdc /btrfs; echo $?
>> 0
>>
>>    BTRFS info (device sdb): dev_replace from /dev/sda (devid 1) to 
>> /dev/sdc started
>>    BTRFS info (device sdb): dev_replace from /dev/sda (devid 1) to 
>> /dev/sdc finished
>>
>> btrfs fi show
>> Label: none  uuid: ab2c88b7-be81-4a7e-9849-c3666e7f9f4f
>>     Total devices 2 FS bytes used 256.00KiB
>>     devid    1 size 3.00GiB used 520.00MiB path /dev/sdc
>>     devid    2 size 3.00GiB used 896.00MiB path /dev/sdb
>>
>> Label: none  uuid: 10bd3202-0415-43af-96a8-d5409f310a7e
>>     Total devices 1 FS bytes used 128.00KiB
>>     devid    1 size 3.00GiB used 536.00MiB path /dev/sda
>>
>> So as per the replace start command and kernel log replace was 
>> successful.
>>
>> Now let's try to clean mount.
>>
>> umount /btrfs;  btrfs dev scan --forget
>>
>> mount -o device=/dev/sdc /dev/sdb /btrfs
>> mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/sdb, 
>> missing codepage or helper program, or other error.
>>
>> [  636.157517] BTRFS error (device sdc): failed to read chunk tree: -2
>> [  636.180177] BTRFS error (device sdc): open_ctree failed
>>
>> That's because per dev items it is still looking for the original seed
>> device.
>>
>> btrfs in dump-tree -d /dev/sdb
>>
>>     item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
>>         devid 1 total_bytes 3221225472 bytes_used 545259520
>>         io_align 4096 io_width 4096 sector_size 4096 type 0
>>         generation 6 start_offset 0 dev_group 0
>>         seek_speed 0 bandwidth 0
>>         uuid 59368f50-9af2-4b17-91da-8a783cc418d4  <--- seed uuid
>>         fsid 10bd3202-0415-43af-96a8-d5409f310a7e  <--- seed fsid
>>     item 1 key (DEV_ITEMS DEV_ITEM 2) itemoff 16087 itemsize 98
>>         devid 2 total_bytes 3221225472 bytes_used 939524096
>>         io_align 4096 io_width 4096 sector_size 4096 type 0
>>         generation 0 start_offset 0 dev_group 0
>>         seek_speed 0 bandwidth 0
>>         uuid 56a0a6bc-4630-4998-8daf-3c3030c4256a  <- sprout uuid
>>         fsid ab2c88b7-be81-4a7e-9849-c3666e7f9f4f <- sprout fsid
>>
>> But the replaced target has the following uuid+fsid in its superblock
>> which doesn't match with the expected uuid+fsid in its devitem.
>>
>> btrfs in dump-super /dev/sdc | egrep 
>> '^generation|dev_item.uuid|dev_item.fsid|devid'
>> generation    20
>> dev_item.uuid    59368f50-9af2-4b17-91da-8a783cc418d4
>> dev_item.fsid    ab2c88b7-be81-4a7e-9849-c3666e7f9f4f [match]
>> dev_item.devid    1
>>
>> So if you provide the original seed device the mount shall be successful.
>> Which so long happening in the test case btrfs/163.
>>
>> btrfs dev scan --forget
>> mount -o device=/dev/sda /dev/sdb /btrfs
>>
>> Fix in this patch:
>> Make it as you can't replace a seed device, you can only add a new device
>> and then delete the seed device. If replace is attempted then returns 
>> -EINVAL.
>> As in the below changes.
>>
>> Another possible fix:
>> If we want to keep the ability to replace for seed-device, then we could
>> update the fsid of the replace-target blocks. And after replacement, you
>> have seed device but with sprout fsid. But then I don't know what is the
>> point and if there is any such use case.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
> 
> This is something Boris dug into until I told him to drop it.  I _think_ 
> I'm ok with this, but really what I'd rather do is restripe the whole fs 
> with the new UUID for this case.  Where did that redo the UUID work go? 

Redo the UUID part is not yet implemented. Perhaps restripe the whole
fs- is another approach, both of these approaches have the same question
unanswered what use case does the replace of seed device solve and would
it be a redundant operation to device add and delete ops.

Thanks, Anand

> Thanks,
> 
> Josef
