Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706941405F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 10:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAQJV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 04:21:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46408 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgAQJV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 04:21:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H9AJr6123548;
        Fri, 17 Jan 2020 09:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=bOyELip+pSC7EaCHU3OTMQXcSTk+ulmDWNaALBRmuGU=;
 b=Smn6mjaN2wrGaaZNGikyU1rVf5o5+RpiWMW604xJdDhmmb+pq7Un1iYr0nuT6jmL5tVq
 RTewEFRkaJReD8SzS4+bqNqjPeG1SwERPBABcV/8cg+Y/+gpAwc9aOwSIyOVieP8fwjA
 9tCtDaSDam7QSc07hJjBEe/3jyqz6w9ttcj/ruXpUX65k06dn1CX/dH2+eeH1fQBo8nM
 w5v73Jnfb3BBxDGcaSkvdhtMpi/okKRvvOgHdro9o5EksdG+FJSQiRHYshqc6T0c/gZO
 yR3W9qqJLH1srTRU3FR6QyGtcZKZD0y5zzodD+FHptzPyna8UPZcVsvuY+4xdID/VmqF Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74sqffg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 09:21:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H98qEd066894;
        Fri, 17 Jan 2020 09:21:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xk2316kg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 09:21:55 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00H9LsCk011711;
        Fri, 17 Jan 2020 09:21:54 GMT
Received: from [10.186.54.221] (/10.186.54.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 01:21:54 -0800
Subject: Re: [PATCH v3 3/5] btrfs: remove identified alien btrfs device in
 open_fs_devices
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-4-anand.jain@oracle.com>
 <550c6454-be48-51bb-1196-40586e3649b7@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f04ad491-ad34-0a0d-e2ba-11ad3713bedd@oracle.com>
Date:   Fri, 17 Jan 2020 17:10:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <550c6454-be48-51bb-1196-40586e3649b7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170072
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/16/20 11:56 PM, Josef Bacik wrote:
> On 10/7/19 5:45 AM, Anand Jain wrote:
>> In open_fs_devices() we identify alien device but we don't reset its
>> the device::name. So progs device list does not show the device missing
>> as shown in the script below.
>>
>> mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
>> mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdb
>> sleep 3 # avoid racing with udev's useless scans if needed
>> btrfs dev add -f /dev/sdb /btrfs
>> mount -o degraded /dev/sdc /btrfs1
>>
>> No missing device:
>> btrfs fi show -m /btrfs1
>> Label: none  uuid: 3eb7cd50-4594-458f-9d68-c243cc49954d
>>     Total devices 2 FS bytes used 128.00KiB
>>     devid    1 size 12.00GiB used 1.26GiB path /dev/sdc
>>     devid    2 size 12.00GiB used 1.26GiB path /dev/sdb
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Why not just remove the device if there's any error?  I'm not sure why 
> these particular checks make a difference from any other error?  Thanks,

  That's interesting, but disadvantage is user has to re-run the
  device scan if we remove the device for a non-alien device which can
  fail temporarily in btrfs_open_one_device() function stack such as


     *bdev = blkdev_get_by_path(device_path, flags, holder);

   If user land has opened the device with O_EXCL this shall
   fail with -EBUSY. So here we shouldn't remove.


      ret = set_blocksize(*bdev, BTRFS_BDEV_BLOCKSIZE);

   This can fail if the bdev does not accept the blocksize and its
   rather a good idea to remove the device as we won't be able to
   use this device any time. So as this is not a temporary issue,
   here we could remove the device.


         *bh = btrfs_read_dev_super(*bdev);

   This function is still an incomplete (because we don't yet handle
   the corrupted super block #1, there is a patch in the ML but
   in dispute, I think). Needs clarity on how a completed function
   will look like. So here it depends on when this function completes.


      bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, 
BTRFS_SUPER_INFO_SIZE);

   Read can fail momentarily for transport/disconnect/plug-out issue
   and which can reappears and assume if there isn't systemd auto scan
   so here we shouldn't remove.


Thanks, Anand


> Josef
