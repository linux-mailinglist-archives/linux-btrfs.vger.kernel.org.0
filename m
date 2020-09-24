Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8827683C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 07:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgIXFTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 01:19:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgIXFTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 01:19:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08O5JVrD044024;
        Thu, 24 Sep 2020 05:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RH3ECJQ25hVbx+mD/6DeosLf2BmjGjsL/mAa3DALs1g=;
 b=SFRAxGQ0G8EzT+fEX9Gmh2yihbIlweVyYgDCOW3l755aysbg1geAHQyXm5Zjemcpd4f5
 A42K/o2IlvTW2Nx7c/pSs0I4UIyEIem/AkDaQ8OulaLobTgRSCceBJw7Elg0grQywCaq
 BPAIABvbkgw197e0AWB0OFQ02YiD+mAB5VqsIAqwzrZmmVIkdPj99tp6j2wUbqK03PS8
 aAci4kF47WKkJ5tdE1ZcKi5lwtZQtsSP2xOV0/xMAH7OeyWK0hMTgVbPZxRWTBdLbahP
 FEDLQD+kRHZTtZ6yvxGlZKeHuTQY/7hRU1v1TkRk3MP1Vz64til5Sj1v5c+VLQhwfjzv Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcpu2x9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 05:19:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08O5GQBj116696;
        Thu, 24 Sep 2020 05:19:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33nujqed8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 05:19:25 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08O5JPRa006356;
        Thu, 24 Sep 2020 05:19:25 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 22:19:24 -0700
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
 <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
 <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d89eaa08-90e1-f0bf-2d91-1db7101d9d59@oracle.com>
Date:   Thu, 24 Sep 2020 13:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=2
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240044
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/9/20 9:42 pm, Josef Bacik wrote:
> On 9/23/20 12:42 AM, Anand Jain wrote:
>>
>>
>> On 22/9/20 9:08 pm, Josef Bacik wrote:
>>> On 9/22/20 8:33 AM, Anand Jain wrote:
>>>> syzbot reported a warning [1] in close_fs_devcies() which it reproduces
>>>> using a crafted image.
>>>>
>>>>          WARN_ON(fs_devices->rw_devices);
>>>>
>>>> The crafted image successfully creates a replace-device with the 
>>>> devid 0.
>>>> But as there isn't any replace-item. We clean the extra the devid 0, at
>>>> __btrfs_free_extra_devids().
>>>>
>>>> rw_devices is incremented in btrfs_open_one_device() for all write-able
>>>> devices except for devid == BTRFS_DEV_REPLACE_DEVID.
>>>> But while we clean up the extra devices in __btrfs_free_extra_devids()
>>>> we used the BTRFS_DEV_STATE_REPLACE_TGT flag which isn't set because
>>>> there isn't the replace-item. So rw_devices went below zero.
>>>>
>>>> So let __btrfs_free_extra_devids() also depend on the
>>>> devid != BTRFS_DEV_REPLACE_DEVID to manage the rw_devices.
>>>>
>>>
>>> This is an invalid state for the fs to be in,
>>
>> OK, to be more specific. There is an alien device that is pretending 
>> to be the replace-target (devid = 0).
>>
>>  > I'd rather fix it by
>>  > detecting we have a devid == BTRFS_DEV_REPLACE_DEVID with no
>>  > corresponding dev_replace item and fail out before we get to this
>>  > point.  Thanks,
>>
>> Yes. __btrfs_free_extra_devids() is already doing in a way the same.
>>
>> ------------------------------------
>> 1040 static void __btrfs_free_extra_devids(struct btrfs_fs_devices 
>> *fs_devices,
>> ::
>> 1059 if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
>> ::
>> 1070 if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
>> 1071 &device->dev_state)) {
>> 1072 continue;
>> 1073 }
>> ------------------------------------
>>
>> OR I did not understand what do you mean.
>>
> 
> Yeah I mean we do something in btrfs_init_dev_replace(), like when we 
> search for the key, we double check to make sure we don't have a devid 
> == BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key.  If we 
> do we return -EIO and bail out of the mount.  Thanks,

  That's brilliant approach. Let me try.

Thanks, Anand

> 
> Josef
