Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2538D115150
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 14:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLFNtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 08:49:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLFNtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 08:49:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6DiPnG196536;
        Fri, 6 Dec 2019 13:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=EvMwXw7ANiini1X8rsbOSK8Kkjiv2M/puYsb3JtNblY=;
 b=glQe1XUNHLRnqP0IwMad/76+Vz1PLaKqFSbcZhOgnfFCl8Sw5AZ07xCwiPUEWse+vDTG
 b0XBXJruH+Ukfn/Xm7Izwd5jpazZ4nFAcmZdcXbU/aVOJ9M3Www1xNnhY054u4SlA+Xs
 7fHtbJluRohu0mo4OWx9HBqJ0zNFgM88iJX+QHLDDdjt4VvFT/Jtko/n0noiwOWzmbFF
 MgS0+8ipXrr6lfxuedud7H4V8N4j4fcqcl4RDGbsyNCKopMrfldgA4vUi9L2kVUtsfu9
 +E36WXDYrlqfVlpCqdIwvDz0qhncr4d9bVBmeBZxG2IoNbo3JHYN/P98zU8l+WGnGwti Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wkfuuvcdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 13:49:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6Dn6X4145652;
        Fri, 6 Dec 2019 13:49:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wqerah6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 13:49:13 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB6DnAV5002745;
        Fri, 6 Dec 2019 13:49:10 GMT
Received: from [10.186.51.247] (/10.186.51.247)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 05:49:10 -0800
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
 <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
 <20191205151428.GS2734@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
Date:   Fri, 6 Dec 2019 21:49:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191205151428.GS2734@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060119
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/12/19 11:14 PM, David Sterba wrote:
> On Thu, Dec 05, 2019 at 10:38:15PM +0800, Anand Jain wrote:
>>> So the values copy the device state macros, that's probably ok.
>>    Yep.
> 
> Although, sysfs files should print one value per file, which makes sense
> in many cases, so eg. missing should exist separately too for quick
> checks for the most common device states. The dev_state reflects the
> internal state and is likely useful only for debugging.
> 

  I agree. Its better to create an individual attribute for each of the
  device states. For instance..

    under the 'UUID/devinfo/<devid>' kobject
    attributes will be:
      missing
      in_fs_metadata
      replace_target

   cat missing
    0
   cat in_fs_metadata
    1

   ..etc

  which seems to be more or less standard for block devices.

  Will fix it in v2.

>>>> +static ssize_t btrfs_sysfs_dev_state_show(struct kobject *kobj,
>>>> +					  struct kobj_attribute *a, char *buf)
>>>> +{
>>>> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
>>>> +						   devid_kobj);
>>>> +
>>>> +	btrfs_dev_state_to_str(device, buf, PAGE_SIZE);
>>>
>>> The device access is unprotected, you need at least RCU but that still
>>> does not prevent from the device being freed by deletion.
>>
>>    We need RCU let me fix. Device being deleted is fine, there
>>    is nothing to lose, another directory lookup will show that
>>    UUID/devinfo/<devid> is gone is the device is deleted.
> 
> The device can be gone from the list but the sysfs files can still
> exist.
> 
>      CPU1                                   CPU2
> 
> btrfs_rm_device
>                                          open file
>    btrfs_sysfs_rm_device_link
>      btrfs_free_device
>        kfree(device)
>                                          call read, access freed device
> 

   I completely missed the sysfs synchronization with device delete.
   As in the other email discussion, I think a new rwlock shall suffice.
   And as its lock is only between device delete and sysfs so it shall
   be light weight without affecting the other device_list_mutex holders.

Thanks,
Anand

>>> The
>>> device_list_mutex is quite heavy and allowing a DoS by repeatedly
>>> reading the file contents is not something we want to allow.
>>>
>>
>>     Yes we don't have to use device_list_mutex here, as its read,
>>     a refresh/re-read will refresh the dev_state.
> 
> The point is not to synchronize the device state values but the device
> object itself.



