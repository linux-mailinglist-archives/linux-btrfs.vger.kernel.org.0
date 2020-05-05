Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD951C640E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEEWlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 18:41:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33708 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWlV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 18:41:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045MT9sq069511;
        Tue, 5 May 2020 22:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SinBHC75KjAJdIOWuN2SlOqEFq7A2/Ufd9n5mVXftjU=;
 b=Zbi5BU+40sncyJEjh9PbKXpdv4yj30Wo+4ywiXjl+R8Q1kCo2VBtjnFw6DEkGEvvUhMt
 LRZUQBo9cfsi1RDbjAE54hRyQ1lktD88L0TbuBqU5dmCOIkPRXQiBxYaDBefG/9fAN7j
 wntoS06qTQYIPDeVATMPguLJ5CFMj85CTkFRI5H7Rv3JJBHA1yBsb906iGrg+qPoI7JK
 x15EJqYgDvDpelhgIQqfWcFtos2qZ5IMoTx+ubATTAq7QwyTjxrRZOW4D4pxqW3Prf60
 NbvbomuZIJTzAXWefZ0yu/zY3d3GJhi0oDRLLejNiOstOQ0TINqgJlM+TdqnvF7ylgxD fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tmfdpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 22:41:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045MZpqY054086;
        Tue, 5 May 2020 22:41:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r65ccq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 22:41:17 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 045MfGA3012766;
        Tue, 5 May 2020 22:41:16 GMT
Received: from [192.168.1.102] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 May 2020 15:41:16 -0700
Subject: Re: [PATCH v4 3/3] btrfs: free alien device due to device add
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200428152227.8331-4-anand.jain@oracle.com>
 <20200504185826.9954-2-anand.jain@oracle.com>
 <20200505193431.GV18421@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bb507bb4-09a6-e9e5-db84-df4140447be9@oracle.com>
Date:   Wed, 6 May 2020 07:40:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505193431.GV18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050170
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> So I'm not sure how much the review holds when the code changes between
> iterations. The right way is to drop the rev-by and CC the person for
> any non-trivial or maybe for all changes.
> 

  only thing that changed is use of helper function
  btrfs_forget_devices() instead of the open-code, so I kept the rev-by.
  Yeah I kind of noticed late that cc list added during git format-patch
  didn't actually add cc in the git send <patch-file>


>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2664,6 +2664,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   
>>   	/* Update ctime/mtime for libblkid */
>>   	update_dev_time(device_path);
>> +
>> +	/*
>> +	 * Now that we have written a new sb into this device, check all other
>> +	 * fs_devices list if device_path alienates any other scanned device.
>> +	 * Ignore the return as we are successfull in the core task - add
>> +	 * the device.
>> +	 */
>> +	btrfs_forget_devices(device_path);
> 
> Actually this should go before update_dev_time, as this is the point
> when the file change could be detected by udev and rescanned, which
> increases the window between commit and removal from fs_devices.
> 

  You are right, theoretically btrfs_forget_devices() should be before
  update_dev_time()


Noted and agreed on rest of the stuffs.

Thanks, Anand
