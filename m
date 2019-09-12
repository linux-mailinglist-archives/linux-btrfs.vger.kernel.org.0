Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E207AB09B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfILHsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 03:48:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILHsQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 03:48:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C7i1PT187345;
        Thu, 12 Sep 2019 07:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=IGjLnVINfveFiecUer9XPRhDat9TVbcKxftPu7H0x1Y=;
 b=eWt/XSLl6UCqgc5pjg73dx8prQ4XYGQhoz9rJGjsdIbfPklsQKbsHpP8xDwDmI49S8sA
 kcLHfEbuD+phK9umicMK2MDJRFZMMYWHoMDVwQ9J0ibao4v/7KWK3zgA0kpeEGEVLkhp
 PzfqPm9Uyt3rbf5gQVxW96VBRPwm1cd0rjTdOEJEhM3UqhLMKFEFpObn/P7TadfuOiqK
 5HKP09rSsa1WPciWOVi9tKsHXFS+iJKT7QJgHeLSH2ISPH4j1dKdWwdkMQ5KsLfl9XTj
 xtUQUlKTOsrw0oubEKRnWAGgiXP2IGpzuL/X7/xxOUfV4uhVT4pPW+eFQiFtb7t04hMB xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uw1jyen4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 07:48:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C7hQ84116668;
        Thu, 12 Sep 2019 07:48:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uyew4wau3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 07:48:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8C7mBL2031723;
        Thu, 12 Sep 2019 07:48:11 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 00:48:10 -0700
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190826090438.7044-1-anand.jain@oracle.com>
 <20190911163758.GG2850@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5813d7aa-bfa0-698d-5c51-cf29e7c5c945@oracle.com>
Date:   Thu, 12 Sep 2019 15:48:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190911163758.GG2850@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/9/19 12:37 AM, David Sterba wrote:
> On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>> thread pid to determine the %mirror_num when the mirror_num=0.
>>
>> This patch introduces a framework so that we can add policies to determine
>> the %mirror_num. And also adds the devid as the readmirror policy.
>>
>> The new property is stored as an item in the device tree as show below.
>>      (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
>>
>> To be able to set and get this new property also introduces new ioctls
>> BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
>> is defined as
>>          struct btrfs_ioctl_readmirror_args {
>>                  __u64 type; /* RW */
>>                  __u64 device_bitmap; /* RW */
>>          }
> 
> I don't remember if there was a suggestion to use ioctls for read
> mirror, but the property interface should be sufficient. Besides this
> ioctl interafce is quite an anti-pattern: narrow use, non-extensible
> structure, alternative and more convenient interface already available.

  Extended attribute interface f(get/set)attr is inode bound, but
  the readmirror property is filesystem bound. For the readmirror we
  can still use the extended attribute, but it might be considered as
  abuse which we haven't done so far, here below [1] is the list of
  property with the interface it uses and where the property is saved.

[1]
  property      interface  save-as
  ro            ioctl      root-item
  label         ioctl      super-block
  compression   xattr      xattr
  v1:readmirror xattr      xattr
  v2:readmirror ioctl      dev-tree-item

  You are asking for the combination of
    property   interface  save-as
    readmirror xattr      dev-tree-item

  I can give a try.

>> An usage example as follows:
>>          btrfs property set /btrfs readmirror devid:1,3
>>          btrfs property get /btrfs readmirror
>>            readmirror devid:1 3
>>          btrfs property set /btrfs readmirror ""
>>          btrfs property get /btrfs readmirror
>>            readmirror default
>>
>> This patchset has been tested completely, however marked as RFC for the
>> following reasons and comments on them (or any other) are appreciated as
>> usual.
>>   . The new objectid is defined as
>>        #define BTRFS_READMIRROR_OBJECTID -1ULL
>>     Need consent we are fine to use this value, and with this value it
>>     shall be placed just before the DEV_STATS_OBJECTID item which is more
>>     frequently used only during the device errors.
> 
> -1 can be considered a special value in other cases, not necessarily
> here but if the ordering of items is the only reason I'd say no. The
> keys/items will most likely land in the same node so there's no point
> forcing the order.

  Agreed. Any suggestion on the value for the BTRFS_READMIRROR_OBJECTID.

>> .  I am using a u64 bitmap to represent the devices id, so the max device
>>     id that we could represent is 63, its a kind of limitation which should
>>     be addressed before integration, I wonder if there is any suggestion?
> 
> Uh 63, so now an implementation detail is posing a global limit? That
> sounds backwards.

   Yes. And I was thinking of u64 array but that doesn't scale as well.
   Anyways I have in the list to try using xattr interface which may
   address this issue.

>>     Kindly note that, multiple ioctls with each time representing a set of
>>     device(s) is not a choice because we need to make sure the readmirror
>>     changes happens in a commit transaction.
> 
> I believe this can be guaranteed by the properties interface, ie. single
> value gets processed at once and with some locking around the state of
> devices can be updated atomically.
> 
> The open question is still how to store the readmirror property
> per-device, it could be either an item or bit inside the device
> structure.

  We discussed that before here.

 
https://lore.kernel.org/linux-btrfs/8d31c3a2-3fb0-63af-3173-948ed0e84de3@oracle.com/

> Besides the interface, I'm kind of missing the usecase description what
> is expected from the read mirror policies and how they could affect
> various scenarios. Maybe it was in some of the previous iterations, it's
> hard too track everything so this should be part of the cover letter (or
> at leat linked if it's too much text).
> 

  Yep. My mistake I missed it link it. Sorry about that.

Thanks, Anand
