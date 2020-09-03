Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234F825BE91
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgICJlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 05:41:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgICJlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 05:41:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839dpkh190015;
        Thu, 3 Sep 2020 09:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=No0fvt4FM4QuAJm5OLFrkVmpdYNtmkK2ez2s66vbsm0=;
 b=uhvL4acU8GiN8EaZNGcOTn5HK8aKsaDmtnY9YIIWo1fE4q7nOkLm0tRx7wXNdzeKLV5g
 ALZAaK6ieuYLHA25DPkGwx9hBbkWeNF8sdOC80i7SZWTVHHIB7eKtk4mAChWLjdmTCgx
 UK0EsWv/il/hCEoRbYLo1XL1eA90N/SKY/CeQejUOxBmT8h3tDoGby+fxR1QsNCNKLVm
 z7B9qJz3SECULBkOICDjr+GMXVoDjsZQicq8VIjrWsvnnXER/kXlbYswl9mePKkPoE4c
 ScaT/1jhsb70+SylJg+FnFF94V7icjpaX3bb97dS1anJSHIf0vJ/PjbvcNbnf5swvJrM /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmn65rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 09:41:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839f7MJ001564;
        Thu, 3 Sep 2020 09:41:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380svsfu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 09:41:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0839fDT8020268;
        Thu, 3 Sep 2020 09:41:13 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 02:41:13 -0700
Subject: Re: [PATCH] btrfs: improve messages when devices rescanned
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <77fc0b0c7c88b14c734b646d1969ccf45a063146.1599118052.git.anand.jain@oracle.com>
 <fe35d005-a3ad-2a30-99a0-99416846d5e1@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6da22ff1-3dc0-d564-4d9d-befa82827bfe@oracle.com>
Date:   Thu, 3 Sep 2020 17:41:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <fe35d005-a3ad-2a30-99a0-99416846d5e1@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030088
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 4:16 pm, Nikolay Borisov wrote:
> 
> 
> On 3.09.20 г. 10:27 ч., Anand Jain wrote:
>> Systems booting without the initramfs seems to scan an unusual kind
>> of device path. And at a later time, the device is updated to the
>> correct path. We generally print the process name and PID of the process
>> scanning the device but we don't capture the same information if the
>> device path is rescanned with a different pathname.
>>
>> But the current message is too long, so drop the unwanted words and add
>> process name and PID.
>>
>> While at this also update the duplicate device warning to include the
>> process name and PID.
>>
>> Reported-by: https://bugzilla.kernel.org/show_bug.cgi?id=89721
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index dc81646b13c0..c386ad722ae1 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -942,16 +942,18 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   				bdput(path_bdev);
>>   				mutex_unlock(&fs_devices->device_list_mutex);
>>   				btrfs_warn_in_rcu(device->fs_info,
>> -			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
>> -					disk_super->fsid, devid,
>> -					rcu_str_deref(device->name), path);
>> +	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
>> +						  path, devid, found_transid,
>> +						  current->comm,
>> +						  task_pid_nr(current));
>>   				return ERR_PTR(-EEXIST);
>>   			}
>>   			bdput(path_bdev);
>>   			btrfs_info_in_rcu(device->fs_info,
>> -				"device fsid %pU devid %llu moved old:%s new:%s",
>> -				disk_super->fsid, devid,
>> -				rcu_str_deref(device->name), path);
>> +				"device path %s changed to %s by %s (pid %d)",
>> +					  rcu_str_deref(device->name),
>> +					  path, current->comm,
>> +					  task_pid_nr(current));
> 
> This 2nd messages is misleading, it's not the process calling
> device_list_add which have changed the path per-se but rather it sees
> the changed path. It's not possible to know why it changed in this
> context. The idea here is "
> 
> "Process %pid saw different dev path %new_dev_path for dev %old_path"

   Hm. How about we stick to the usual scanned by. That is..

   "device path %s changed to %s scanned by %s (pid %d)",

Thanks, Anand

> 
>>   		}
>>   
>>   		name = rcu_string_strdup(path, GFP_NOFS);
>>

