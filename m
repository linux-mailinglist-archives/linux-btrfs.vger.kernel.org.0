Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE553CCDF8
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2019 04:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfJFCwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 22:52:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49592 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfJFCwI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Oct 2019 22:52:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x962pmqA100993;
        Sun, 6 Oct 2019 02:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=yHsCGHkmDM2F4pcziuZm9W71tfQDPQxNzCiZr2/X9HI=;
 b=InczoF/cx00eGlJFTkgaiW83w9jS5RbvxwnA01dshCbrZg+LcYoyKXNVWxAjmuImlHl7
 cgWBLfa98e67RpOF9FR1RlzTBPZKDWWh3qV4K4fo+36mCMF1MJQZLdeLaUfpxiDqGe+8
 bW9Oo3oFVM16Vsa+7uVaQOY+vo6aX3uubAid3HFQHMHXiPgjA1HJ4+/Hal78XQNzPS07
 Moc9ER/6zIjdsOMUlpvtb91M6+EomGXXFuhhGkRQQyp05ZRKNv/V0XbWhMefRCVzDx+M
 Tt02BG+/OQ0drs6zPFcv+89URt4ZvxZUlrZzB//pwlrnHa9UQLHKWHBR27buoWqhISft iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vektr29ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 02:52:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x962mKhT180756;
        Sun, 6 Oct 2019 02:52:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vf4n67dgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 02:52:04 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x962q3vS024939;
        Sun, 6 Oct 2019 02:52:03 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Oct 2019 19:52:03 -0700
Subject: Re: [PATCH 2/4] btrfs: delete identified alien device in
 open_fs_devices
To:     Nikolay Borisov <nborisov@suse.com>
References: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
 <1570175403-4073-3-git-send-email-anand.jain@oracle.com>
 <66defad6-6757-76d2-8819-fd22b9cd1b9e@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <65fab107-87f6-b15f-3e1c-74b586bcf3fe@oracle.com>
Date:   Sun, 6 Oct 2019 10:51:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <66defad6-6757-76d2-8819-fd22b9cd1b9e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9401 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910060028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9401 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910060028
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 06ec3577c6b4..05ade8c7342b 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -803,10 +803,10 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   	disk_super = (struct btrfs_super_block *)bh->b_data;
>>   	devid = btrfs_stack_device_id(&disk_super->dev_item);
>>   	if (devid != device->devid)
>> -		goto error_brelse;
>> +		goto free_alien;
>>   
>>   	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
>> -		goto error_brelse;
>> +		goto free_alien;
>>   
> 
> Imo a better approach is to return a particular error code and do the
> deletion in open_fs_devices. Otherwise it's not apparent why you use
> list_for_each_entry_safe in one function to delete something in a
> different one (whose name by the way doesn't suggest a deletion is going
> on). Looking at the error I think enodev/enxio is appropriate.

  Agreed. And used -EUCLEAN I think that's most appropriate.
  Thanks, Anand
