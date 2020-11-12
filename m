Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E29F2B0219
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 10:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKLJkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 04:40:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 04:40:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC9Tbnf135440;
        Thu, 12 Nov 2020 09:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tjYqRdp/2SA0o2HHquurpAUlil99wWPvghk7B75mb/w=;
 b=nU57IHEweeNG47ZE0W+QHH/KvvQSsBPByb6kyByiNurwE2AFFjPFQFe0i8a3bCoARhcN
 lRmJQ3yMFwEmIWMJLi1L1f1YMayhl/4s5/yBaUx78HR0UaFoz3JQkaWrn+MkrQ1Wp7/p
 ZjHTOlH2HOVH9Vmj+KElvBOoee0on813CnaslIFqr6yOhL11QHqJkzMnDGSJC2Wvp8gW
 Up9qtK2w/YnDtSmmEqNlFjhg0yBdWPtQiwaFA4PJtazU6NpDzxDZ3UbZaDyF7eZst5A2
 OuXCCAz8DipW1horKAw2+CTen3b/jiO1fHLAS2HN7DCXFz4hRO1L3/Q5hRkxbrRkpLdl LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72eth3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 09:39:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC9URG7080011;
        Thu, 12 Nov 2020 09:37:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34rtkreykj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 09:37:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AC9brw8026034;
        Thu, 12 Nov 2020 09:37:53 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 01:37:53 -0800
Subject: Re: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
 <29aebf1e-4684-4003-44b4-c5e8846b69eb@oracle.com>
 <SN4PR0401MB359852C46EE68127C7959CD29BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d389866a-4d25-6d8a-aaa8-3403bc7b7c0c@oracle.com>
Date:   Thu, 12 Nov 2020 17:37:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359852C46EE68127C7959CD29BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120058
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/11/20 3:24 pm, Johannes Thumshirn wrote:
> On 12/11/2020 04:09, Anand Jain wrote:
>> On 11/11/20 11:52 pm, Johannes Thumshirn wrote:
>>> A struct btrfs_device's lifetime in device_list_add() is protected by the
>>> device_list_mutex. So don't drop the device_list_mutex when printing a
>>> duplicate device warning in device_list_add.
>>>
>>
>> The only other thread which can free the %device is the userland
>> initiated forget command. But both this (scan) and the forget threads
>> are under %uuid_mutex. So %device is protected from freeing.
>>
>> Did we see any bug reproduced due to this?
>>
>> Thanks.
>>
> 
> Yes and no, I've stumbled across this while trying to fix this syzbot


> report: https://github.com/btrfs/fstests/issues/29


Fix in the ML [1] can fix the above issue grossly.

[1]
 
https://lore.kernel.org/linux-btrfs/20200114060920.4527-2-anand.jain@oracle.com/T/

  There is a scenario where the device->fs_info shall be NULL.

  Consider Thread-A writes device->bdev at 1w and device->fs_info at 2w.
  Thread-B reads device->bdev and device->fs_info at 3r, 4r, and 5r.

  There is a possible rw order as below when the uuid mutex is released.

    1w, 3r, 4r, 5r, 2w

  And this shall lead to the scenario device->bdev != NULL and
  device->fs_info == NULL for the thread-B leading to the Warning.

  Thread-A                                        Thread-B

btrfs_mount_root()
  mutex_lock(&uuid_mutex);
  btrfs_open_devices()
   open_fs_devices()
     btrfs_open_one_device()
        device->bdev = bdev; <----1w
  mutex_unlock(&uuid_mutex);
                                       mutex_lock(&uuid_mutex);
                                       btrfs_scan_one_device()
                                          device_list_add()
                                             if (device->bdev) { <--4r
 
btrfs_warn_in_rcu(device->fs_info, <--5r
::
btrfs_info_in_rcu(device->fs_info, <---6r
                                             }
                                        mutex_unlock(&uuid_mutex);

  btrfs_fill_super()
    open_ctree()
      init_mount_fs_info()
         fs_info->sb = sb; <---2w
      init_tree_roots
        btrfs_read_roots()
          btrfs_init_devices_late()
            mutex_lock(&fs_devices->device_list_mutex);
            device->fs_info = fs_info   <----3w
            mutex_unlock(&fs_devices->device_list_mutex);


Also, I think there isn't a need to use the RCU here? (I may be wrong on 
the rcu part).


> 
> It doesn't fix it though, but still it looks odd we're dropping the
> mutex and then access the device. Doesn't harm the other way round.
> 
> I take it's more of a cosmetic fix than a bug fix.
> 

Thanks, Anand
