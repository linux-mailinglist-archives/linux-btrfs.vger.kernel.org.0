Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0027E286
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgI3HX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 03:23:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36496 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HX4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 03:23:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U7NkAl148248;
        Wed, 30 Sep 2020 07:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Dr4Fby3T9I1eQ6rAF38+A7tTXOaAdnxHvIe1GZ8Sf8I=;
 b=zBnYnJIt5WJMP85sjkaDCTZhmHiSaeDEzG+XVBp27CMlUUk0kE3hQUGBdPYuOe0uIg1c
 y/q9/4+Y8gd6G/3uakoEYSpVALGMXKvZmZT3GeNcn1STtTM+X+wcuBF9N6qUjqvTj/ts
 1I6BkitGG/9PPY9EPzBuQZ7CiYiZ89by6DNVy5NKovst01HKJcXdft7XrNbwCbw56YPl
 mgK00fEMHqGxzPAlIMhlg3V5c8HSYJynnHRxXObcOoFn5EOC8zlbN22GZs0xq2fXquLS
 aSAN7MEClE7GVSM/EJEatxs+9oanFvjeb6Yq0SFtn8QpzpCiVvpYuG+/OmvxAUNgqrgk vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkkxwr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 07:23:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U7FmC8087662;
        Wed, 30 Sep 2020 07:21:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33tfjy6m1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 07:21:53 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08U7LrW7017747;
        Wed, 30 Sep 2020 07:21:53 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 00:21:52 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: free device without BTRFS_MAGIC
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <1ee9b318e3bb851aaec9c1efd1eadb117ad46638.1600741332.git.anand.jain@oracle.com>
 <abf4c158-6b31-be1a-8645-59fc0ca7306a@toxicpanda.com>
Message-ID: <2d4b10fd-a5f4-7e6b-85f4-f92591e2a539@oracle.com>
Date:   Wed, 30 Sep 2020 15:21:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <abf4c158-6b31-be1a-8645-59fc0ca7306a@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=2 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/9/20 2:14 am, Josef Bacik wrote:
> On 9/21/20 11:13 PM, Anand Jain wrote:
>> Many things can happen after the device is scanned and before the device
>> is mounted.
>>
>> One such thing is losing the BTRFS_MAGIC on the device.
>>
>> If it happens we still won't free that device from the memory and causes
>> the userland to confuse.
>>
>> For example: As the BTRFS_IOC_DEV_INFO still carries the device path 
>> which
>> does not have the BTRFS_MAGIC, the btrfs fi show still shows device
>> which does not belong. As shown below.
>>
>> mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb
>>
>> wipefs -a /dev/sdb
>> mount -o degraded /dev/sda /btrfs
>> btrfs fi show -m
>>
>> /dev/sdb does not contain BTRFS_MAGIC and we still show it as part of
>> btrfs.
>> Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd
>>          Total devices 2 FS bytes used 128.00KiB
>>          devid    1 size 3.00GiB used 571.19MiB path /dev/sda
>>          devid    2 size 3.00GiB used 571.19MiB path /dev/sdb
>>
> 
> Wouldn't this also happen if the bytenrs didn't match?  In that case you 
> aren't freeing anything, and we'd still show the improper device 
> correct?  So why not deal with that case in a similar way?  Thanks,

Freeing the device without the BTRFS_MAGIC is mandatory because the
device does not belong to btrfs even though we could notice from the
sysfs that there is missing flag on this devid.

I think I should check for the BTRFS_MAGIC first before bytenr check,
I shall swap them in v2 if there are no other comments. We need this
patch as a fix for the test case btrfs/198.

However bytenrs mismatch indicates corruption. If the degraded mount
option is not provided we would fail the mount. The user shall have the
opportunity to fix the corrupted superblock. We don't automatically
recover the corrupted superblock from the backup superblock copies. If
the degraded mount option is provided the corrupted device still be in
the device_list but with the missing flag set. Just by looking at btrfs
fi show the user won't know that one of the devices is not part of the
volume however when he looks into the /sys/fs/btrfs/fsid/devinfo/<devid>
/missing it shall show 1. Our serviceability part of the degraded volume
has some unfinished business when we evaluate it against the standard
RAS features, but we are slowly getting there.

Thanks, Anand

> 
> Josef
