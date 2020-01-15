Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE813BB9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAOI5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 03:57:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53942 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgAOI5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 03:57:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F8sw38017259;
        Wed, 15 Jan 2020 08:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=7+i63dVJBxlOSZ/d9PqNqCpj8zpCOmDFL8aAo+Cj12o=;
 b=kRUrW4FE55OAatYUkKgGd/OTVgW6U4rhY1kV4ZIjOG9vBR/qFOg2RZe0tP7AHqDTb3mF
 rb3JPhBNe2+RGq5K+n5OSsvg276Q3wNP8fUoQIHXwvIipmucPCnb4ON+nbETCjUZVUeE
 GgBPlAmVO593xqQOHnWxfQpXzo+AYRKNjzyU8aM3uN9HobY4kIqOnNTFdzdePsIRLkfT
 3ZeLPdZIIAWopu7FeLorkrkKLyIL0DQ5MRebVcLR/T4Y3DpvwG0Zo0cG6WcR6rAzMSwM
 F3hxf4dfwmz9T5L8pkeGhQuCoQjueulakdKdz8rlBT8xduohI3qI9mPiZ4xcx4K9ND+X uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf73yjw4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 08:57:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F8pDBu050231;
        Wed, 15 Jan 2020 08:57:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xh3165sws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 08:57:10 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00F8v8rd002643;
        Wed, 15 Jan 2020 08:57:09 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 00:57:08 -0800
Subject: Re: [PATCH 4/5] btrfs: remove identified alien device in
 open_fs_devices
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-5-anand.jain@oracle.com>
 <b370fdd7-2d97-877f-88e6-3624205c8617@suse.com>
 <b8ffd660-5055-d609-4fcd-169090e7914b@gmx.com>
 <20191007170306.GI2751@twin.jikos.cz>
 <75fd55f3-3c42-8daa-a3e7-26dadce6228f@oracle.com>
Message-ID: <c50c690f-d5f6-8012-740f-1cc5b0fe9c7e@oracle.com>
Date:   Wed, 15 Jan 2020 16:56:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <75fd55f3-3c42-8daa-a3e7-26dadce6228f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150074
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/19 11:26 AM, Anand Jain wrote:
> On 10/8/19 1:03 AM, David Sterba wrote:
>> On Mon, Oct 07, 2019 at 09:37:49PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2019/10/7 下午9:30, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 7.10.19 г. 12:45 ч., Anand Jain wrote:
>>>>> Following test case explains it all, even though the degraded mount is
>>>>> successful the btrfs-progs fails to report the missing device.
>>>>>
>>>>>   mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdd && \
>>>>>   wipefs -a /dev/sdd && mount -o degraded /dev/sdc /btrfs && \
>>>>>   btrfs fi show -m /btrfs
>>>>>
>>>>>   Label: none  uuid: 2b3b8d92-572b-4d37-b4ee-046d3a538495
>>>>>     Total devices 2 FS bytes used 128.00KiB
>>>>>     devid    1 size 1.09TiB used 2.01GiB path /dev/sdc
>>>>>     devid    2 size 1.09TiB used 2.01GiB path /dev/sdd
>>>>>
>>>>> This is because btrfs-progs does it fundamentally wrong way that
>>>>> it deduces the missing device status in the user land instead of
>>>>> refuting from the kernel.
>>>>>
>>>>> At the same time in the kernel when we know that there is device
>>>>> with non-btrfs magic, then remove that device from the list so
>>>>> that btrfs-progs or someother userland utility won't be confused.
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>>   fs/btrfs/disk-io.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>>> index 326d5281ad93..e05856432456 100644
>>>>> --- a/fs/btrfs/disk-io.c
>>>>> +++ b/fs/btrfs/disk-io.c
>>>>> @@ -3417,7 +3417,7 @@ int btrfs_read_dev_one_super(struct 
>>>>> block_device *bdev, int copy_num,
>>>>>       if (btrfs_super_bytenr(super) != bytenr ||
>>>>>               btrfs_super_magic(super) != BTRFS_MAGIC) {
>>>>>           brelse(bh);
>>>>> -        return -EINVAL;
>>>>> +        return -EUCLEAN;
>>>>
>>>> This is really non-obvious and you are propagating the special-meaning
>>>> of EUCLEAN waaaaaaaay beyond btrfs_open_one_device. In fact what this
>>>> patch does is make the following call chain return EUCLAN:
>>>>
>>>> btrfs_open_one_device <-- finally removing the device in this function
>>>>   btrfs_get_bdev_and_sb <-- propagating it to here
>>>>    btrfs_read_dev_super
>>>>      btrfs_read_dev_one_super <-- you return the EUCLEAN
>>>>
>>>>
>>>> And your commit log doesn't mention anything about that. EUCLEAN
>>>> warrants a comment in this case since it changes behavior in
>>>> higher-level layers.
> 
>   Ok. Which means the commit log needs to be fixed.
> 
>>>
>>> And, for most case, EUCLEAN should have a proper kernel message for
>>> what's going wrong, the value we hit and the value we expect.
> 
>   If its a kernel message for EUCLEAN in the context of mounted state,
>   I would say yes, as it indicates a corruption.
>   But here we are still in the unmounted context and moving towards
>   mounted context. Having an alien device in the fs_devices is not
>   something logical bug nor a corruption, it just about a disk whose
>   disk superblock got overwritten by the user operation. And its not
>   a good idea to log the kernel messages arising from the user
>   operation especially in the unmounted context. Otherwise we shall
>   endup cluttering the kernel messages. Moreover if there is an alien
>   device, the user must use -o degraded and we do have the missing
>   kernel messages, and this will suffice to explain the state about the
>   fsid being mounted. And the alien fsid, its a stale we don't worry
>   about it. So no kernel messages.
> 
>>> And for EUCLEAN, it's more like graceful error out for impossible thing.
>>> This is definitely not the case, and I believe the original EINVAL makes
>>> more sense than EUCLEAN.
>>
>> I agree, EUCLEAN is wrong here.
>>
> 
>    I am ok with any other suitable. It does not matter. And the other
>    choice I have is ESTALE.
> 
>    But EINVAL is no go because we still want to keep the messed up device
>    unless there is a confirmation that its alien.
> 
>    In the same function we use EINVAL if the device/partition size
>    changed to smaller size after we have scanned the device. Which
>    means we still keep the device in the list. Its the user choice,
>    no need to meddle with it.
> 
>     bytenr = btrfs_sb_offset(copy_num);
>     if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>            return -EINVAL;


    I didn't know that btrfs/197 btrfs/198 is failing.
    I found that we need this patch series so that it
    passes these tests. Logs for failing test cases are here [1].

    Any feedback if errno -ESTALE is better instead of -EUCLEAN? As
    mentioned I can't use -EINVAL because its already been used.

[1]
btrfs/197	- output mismatch (see /xfstests-dev/results//btrfs/197.out.bad)
     --- tests/btrfs/197.out	2020-01-08 18:08:44.040258593 +0800
     +++ /xfstests-dev/results//btrfs/197.out.bad	2020-01-15 
16:32:23.870187397 +0800
     @@ -3,23 +3,19 @@
      Label: none  uuid: <UUID>
      	Total devices <NUM> FS bytes used <SIZE>
      	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
     -	*** Some devices missing

      raid5
      Label: none  uuid: <UUID>
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/197.out 
/xfstests-dev/results//btrfs/197.out.bad'  to see the entire diff)
btrfs/198	- output mismatch (see /xfstests-dev/results//btrfs/198.out.bad)
     --- tests/btrfs/198.out	2020-01-08 18:08:44.040258593 +0800
     +++ /xfstests-dev/results//btrfs/198.out.bad	2020-01-15 
16:32:28.882282030 +0800
     @@ -3,23 +3,19 @@
      Label: none  uuid: <UUID>
      	Total devices <NUM> FS bytes used <SIZE>
      	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
     -	*** Some devices missing

      raid5
      Label: none  uuid: <UUID>
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/198.out 
/xfstests-dev/results//btrfs/198.out.bad'  to see the entire diff)

Thanks, Anand



>    But, EUCLEAN /* structure needs cleaning */ is errno which exactly
>    says whats needed here. Because an alien device is a kind of
>    corruption but it can easily happen due to unplanned device operations
>    in the userland. But as it happened before we assembled the volume so
>    its safe to clean and is not a road block when there is redundancy
>    with degraded option.
> 
> Thanks, Anand
> 

