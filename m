Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BCB1D5E44
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 May 2020 05:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgEPDoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 23:44:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57080 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPDoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 23:44:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04G3i6iZ061402;
        Sat, 16 May 2020 03:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JUcHrpya+bujL1DA+z3P0NMdtlR21V5v5kYbEbrXhmE=;
 b=LDm/QKheWH4Iunag0S+YyTDD/glen9AiVtzxkJi0bY2IR9oABJg6RLW+w8WZPMxtZN4w
 2OSdc1FmzlRoE566VihWOSuOKJL6jdcQF0QeR2nfyBu3YSq7Lul/c0omZHRDhXLuzv5w
 fJ23G7txYLHsMwIYUavo2F8ypK+2wRyydNC2HwXj94+ZyAvee5rZvTRcI1UXFrR+kPX9
 BKvTFVljESVB5bIWejhE0ZQ5PcDffgE0IBqQXWCZAv8zmUSHftaKiAXTgmV0R85iEHWm
 aEWU534O4TXgSh/b0W5wxpmbyvQCLSJXuVSsl0Zh31JL7OPDTeRdVavNCMU/Nu+fFAU0 Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kqr2t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 16 May 2020 03:44:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04G3cKAo108061;
        Sat, 16 May 2020 03:44:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 312678mtgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 May 2020 03:44:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04G3i13R016029;
        Sat, 16 May 2020 03:44:03 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 20:44:01 -0700
Subject: Re: [PATCH] btrfs: fix lockdep warning chunk_mutex vs
 device_list_mutex
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
 <20200513194659.34493-1-anand.jain@oracle.com>
 <20200515174047.GN18421@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4fa7f041-5816-1d94-1148-780b10e705af@oracle.com>
Date:   Sat, 16 May 2020 11:43:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515174047.GN18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005160029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005160029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/5/20 1:40 am, David Sterba wrote:
> On Thu, May 14, 2020 at 03:46:59AM +0800, Anand Jain wrote:
>> A full list of tests just started.
>>
>>   fs/btrfs/volumes.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 60ab41c12e50..ebc8565d0f73 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -984,7 +984,6 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>>   	if (IS_ERR(fs_devices))
>>   		return fs_devices;
>>   
> 
> So now here's the device_list_mutex taken by a caller but inside
> clone_fs_devices there's
> 
> 	fs_devices = alloc_fs_devices(orig->fsid, NULL);
> 
> just before this line and it does a GFP_KERNEL allocation.

Oh right the allocations. Its not just about the other locks
as I thought before.

There are two ways to fix.
   Use GFP_NOFS
    I am not yet sure if it not possible. There were some previous
    work on the GFP flags. I need to review them. or,
   Move the allocation outside the locks.

  Looking into both of these choices.

Thanks, Anand

> This could
> deadlock through the allocator trying to flush data and then superblock
> write locking the device_list_mutex again.
> 
>> -	mutex_lock(&orig->device_list_mutex);
>>   	fs_devices->total_devices = orig->total_devices;
>>   
>>   	list_for_each_entry(orig_dev, &orig->devices, dev_list) {

