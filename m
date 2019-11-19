Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16844101A71
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfKSHmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 02:42:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfKSHmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 02:42:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ7dB6H010415;
        Tue, 19 Nov 2019 07:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=YcTd/4b2LyNSHOR/3W5JJ5L0ZjLFyJsPDuzFRPSVBD0=;
 b=H3j7qCvn4nAnWIoqSMdSZhH+MM04Ab3uv1kbKoFs25S48F8jpqJULSOZ0KGr7KdMIhMh
 rbRp5wm7R8Ic0hfn/RVM0FCp1q8IdMDyOgHCNiVKZqkAqK5ZL3hnv1xjQb8QtK/tF43Y
 PjzWFDqDj38DOaQy007z1DCXI+i3qNtvGDb+8hGFV7qOw+3VFd+iuAAmRP2FuzDtI0BP
 5p+QPc6PhMMT5fj2SpCbXEr43nbnXgZLIiC1uziwliVNcmNyV8wh8zR6zKZIUjucCqnC
 hd+CYuiCVGdi5rvH4czmzeikz5S95+YkBSUZ75NfYd7cdNHFAOjmzvCsVvlZpKGeGmYX Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rqcy8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 07:40:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ7dMo8073442;
        Tue, 19 Nov 2019 07:40:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wbxgeskhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 07:40:49 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ7ekXi011925;
        Tue, 19 Nov 2019 07:40:47 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 23:40:46 -0800
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
 <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
 <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
Date:   Tue, 19 Nov 2019 15:40:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190071
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/18/19 8:02 PM, Qu Wenruo wrote:
> 
> 
> On 2019/11/18 下午7:38, Anand Jain wrote:
>> On 18/11/19 3:05 PM, Qu Wenruo wrote:
>>> One user reported an use case where one device can't be replaced due to
>>> tiny device size difference.
>>>
>>> Since it's a RAID10 fs, if we go regular "remove missing" it can take a
>>> long time and even not be possible due to lack of space.
>>>
>>> So here we work around this situation by allowing user to shrink missing
>>> device.
>>> Then user can go shrink the device first, then replace it.
>>
>>
>>   Why not introduce --resize option in the replace command.
>>   Which shall allow replace command to resize the source-device
>>   to the size of the replace target-device.
> 
> Nope, it won't work for degraded mount.

  Umm.. Why?

  (IMHO reasoning adds clarity to the technical discussions. my 1c).

> That's the root problem the patch is going to solve.

  IMO this patch does not the solve the root of the problem and its
  approach is wrong.

  The core problem as I see - currently we are determining the required
  size for the replace-target by means of source-disk size, instead it
  should be calculated by the source-disk space consumption.
  Also warn if target is smaller than source and fail if target is
  smaller than the consumption by the source-disk.

  IMO changing the size of the missing device is point less. What if
  in between the resize and replace the missing device reappears
  in the following unmount and mount.

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>> Reported-by: Nathan Dehnel <ncdehnel@gmail.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>    fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++++----
>>>    1 file changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index de730e56d3f5..ebd2f40aca6f 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1604,6 +1604,7 @@ static noinline int btrfs_ioctl_resize(struct
>>> file *file,
>>>        char *sizestr;
>>>        char *retptr;
>>>        char *devstr = NULL;
>>> +    bool missing;
>>>        int ret = 0;
>>>        int mod = 0;
>>>    @@ -1651,7 +1652,10 @@ static noinline int btrfs_ioctl_resize(struct
>>> file *file,
>>>            goto out_free;
>>>        }
>>>    -    if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>> +
>>> +    missing = test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
>>> +    if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>>> +        !missing) {
>>>            btrfs_info(fs_info,
>>>                   "resizer unable to apply on readonly device %llu",
>>>                   devid);
>>> @@ -1659,13 +1663,24 @@ static noinline int btrfs_ioctl_resize(struct
>>> file *file,
>>>            goto out_free;
>>>        }
>>>    -    if (!strcmp(sizestr, "max"))
>>> +    if (!strcmp(sizestr, "max")) {
>>> +        if (missing) {
>>> +            btrfs_info(fs_info,
>>> +                "'max' can't be used for missing device %llu",
>>> +                   devid);
>>> +            ret = -EPERM;
>>> +            goto out_free;
>>> +        }
>>>            new_size = device->bdev->bd_inode->i_size;
>>> -    else {
>>> +    } else {
>>>            if (sizestr[0] == '-') {
>>>                mod = -1;
>>>                sizestr++;
>>>            } else if (sizestr[0] == '+') {
>>> +            if (missing)
>>> +                btrfs_info(fs_info,
>>> +                "'+size' can't be used for missing device %llu",
>>> +                       devid);
>>>                mod = 1;
>>>                sizestr++;
>>>            }
>>> @@ -1694,6 +1709,12 @@ static noinline int btrfs_ioctl_resize(struct
>>> file *file,
>>>                ret = -ERANGE;
>>>                goto out_free;
>>>            }
>>> +        if (missing) {
>>> +            ret = -EINVAL;
>>> +            btrfs_info(fs_info,
>>> +            "can not increase device size for missing device %llu",
>>> +                   devid);
>>> +        }
>>>            new_size = old_size + new_size;
>>>        }
>>>    @@ -1701,7 +1722,7 @@ static noinline int btrfs_ioctl_resize(struct
>>> file *file,
>>>            ret = -EINVAL;
>>>            goto out_free;
>>>        }
>>> -    if (new_size > device->bdev->bd_inode->i_size) {
>>> +    if (!missing && new_size > device->bdev->bd_inode->i_size) {
>>>            ret = -EFBIG;
>>>            goto out_free;
>>>        }
>>>
>>
> 
