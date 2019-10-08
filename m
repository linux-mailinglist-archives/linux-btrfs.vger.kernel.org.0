Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25978CF13C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 05:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfJHD0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 23:26:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57944 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfJHD0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 23:26:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x983OgNr123547;
        Tue, 8 Oct 2019 03:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Q4qVmlStYvPn8pQNflc+L8EQH6P35VA9KgbZB7wV9JA=;
 b=ZClYxMEBQQHZM46yr50aMwzS7Y1C8OMyHquurISslrFaGxhsDVyFed393dxW+OB5s5+A
 +bwrVusJVInobB6WUn4owOCw5tdBrdtKZoamdrIZvck5jq7KTZgzYXSI9jAAtGe0M30Q
 KC0DkMOVBabfNGmZkGTVX6BsTIjXFWmmTdULThB8BLdITmZTnfIf5Pyu8uKWJiJTKlBa
 0nx2mUbDdqsFZWK2PhsP8wD2p9I52K+cCeu9FqcBEpXNTliCgYvDXawLG4a/Vq+lprCF
 GEkE7YAa2zrjnpMcuq5eFKX4NAaBMYd3FNm48G8KeQVx4+izfibdIf2cjpuzSH/jUxPB EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vektrabu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 03:26:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9838pB1137923;
        Tue, 8 Oct 2019 03:26:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vgeuwv85f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 03:26:39 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x983QZ7R008686;
        Tue, 8 Oct 2019 03:26:36 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 20:26:35 -0700
Subject: Re: [PATCH 4/5] btrfs: remove identified alien device in
 open_fs_devices
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-5-anand.jain@oracle.com>
 <b370fdd7-2d97-877f-88e6-3624205c8617@suse.com>
 <b8ffd660-5055-d609-4fcd-169090e7914b@gmx.com>
 <20191007170306.GI2751@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <75fd55f3-3c42-8daa-a3e7-26dadce6228f@oracle.com>
Date:   Tue, 8 Oct 2019 11:26:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007170306.GI2751@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080033
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 1:03 AM, David Sterba wrote:
> On Mon, Oct 07, 2019 at 09:37:49PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/10/7 下午9:30, Nikolay Borisov wrote:
>>>
>>>
>>> On 7.10.19 г. 12:45 ч., Anand Jain wrote:
>>>> Following test case explains it all, even though the degraded mount is
>>>> successful the btrfs-progs fails to report the missing device.
>>>>
>>>>   mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdd && \
>>>>   wipefs -a /dev/sdd && mount -o degraded /dev/sdc /btrfs && \
>>>>   btrfs fi show -m /btrfs
>>>>
>>>>   Label: none  uuid: 2b3b8d92-572b-4d37-b4ee-046d3a538495
>>>> 	Total devices 2 FS bytes used 128.00KiB
>>>> 	devid    1 size 1.09TiB used 2.01GiB path /dev/sdc
>>>> 	devid    2 size 1.09TiB used 2.01GiB path /dev/sdd
>>>>
>>>> This is because btrfs-progs does it fundamentally wrong way that
>>>> it deduces the missing device status in the user land instead of
>>>> refuting from the kernel.
>>>>
>>>> At the same time in the kernel when we know that there is device
>>>> with non-btrfs magic, then remove that device from the list so
>>>> that btrfs-progs or someother userland utility won't be confused.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>   fs/btrfs/disk-io.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index 326d5281ad93..e05856432456 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -3417,7 +3417,7 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
>>>>   	if (btrfs_super_bytenr(super) != bytenr ||
>>>>   		    btrfs_super_magic(super) != BTRFS_MAGIC) {
>>>>   		brelse(bh);
>>>> -		return -EINVAL;
>>>> +		return -EUCLEAN;
>>>
>>> This is really non-obvious and you are propagating the special-meaning
>>> of EUCLEAN waaaaaaaay beyond btrfs_open_one_device. In fact what this
>>> patch does is make the following call chain return EUCLAN:
>>>
>>> btrfs_open_one_device <-- finally removing the device in this function
>>>   btrfs_get_bdev_and_sb <-- propagating it to here
>>>    btrfs_read_dev_super
>>>      btrfs_read_dev_one_super <-- you return the EUCLEAN
>>>
>>>
>>> And your commit log doesn't mention anything about that. EUCLEAN
>>> warrants a comment in this case since it changes behavior in
>>> higher-level layers.

  Ok. Which means the commit log needs to be fixed.

>>
>> And, for most case, EUCLEAN should have a proper kernel message for
>> what's going wrong, the value we hit and the value we expect.

  If its a kernel message for EUCLEAN in the context of mounted state,
  I would say yes, as it indicates a corruption.
  But here we are still in the unmounted context and moving towards
  mounted context. Having an alien device in the fs_devices is not
  something logical bug nor a corruption, it just about a disk whose
  disk superblock got overwritten by the user operation. And its not
  a good idea to log the kernel messages arising from the user
  operation especially in the unmounted context. Otherwise we shall
  endup cluttering the kernel messages. Moreover if there is an alien
  device, the user must use -o degraded and we do have the missing
  kernel messages, and this will suffice to explain the state about the
  fsid being mounted. And the alien fsid, its a stale we don't worry
  about it. So no kernel messages.

>> And for EUCLEAN, it's more like graceful error out for impossible thing.
>> This is definitely not the case, and I believe the original EINVAL makes
>> more sense than EUCLEAN.
> 
> I agree, EUCLEAN is wrong here.
>

   I am ok with any other suitable. It does not matter. And the other
   choice I have is ESTALE.

   But EINVAL is no go because we still want to keep the messed up device
   unless there is a confirmation that its alien.

   In the same function we use EINVAL if the device/partition size
   changed to smaller size after we have scanned the device. Which
   means we still keep the device in the list. Its the user choice,
   no need to meddle with it.

    bytenr = btrfs_sb_offset(copy_num);
    if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
           return -EINVAL;

   But, EUCLEAN /* structure needs cleaning */ is errno which exactly
   says whats needed here. Because an alien device is a kind of
   corruption but it can easily happen due to unplanned device operations
   in the userland. But as it happened before we assembled the volume so
   its safe to clean and is not a road block when there is redundancy
   with degraded option.

Thanks, Anand

