Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7325979F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgIAQQ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 12:16:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35956 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgIAQQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 12:16:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081GBb9c017169;
        Tue, 1 Sep 2020 16:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PapkvZqJEe3T7Jos/ePN5ZQJNPZwyzAhQuyyc7TomXc=;
 b=SZdALdsiKsmM2xtG4q2kLLFY+l6QV51sbu5lCmopqZANrARuG4j1dNnJ5iRYENhaXQtO
 6e/PeN2CjnILjocJ5ro9P+HTuqZO7w0y/+MdYQQht64G8ykVKE/F2yAGrDfdRfyY2AZ8
 fUK+q1h+N1Rkr+VTXmH0wlc2h1/POdrv+xNrItYKgsHcO+3x/KJyRczjONAZc1yCwR81
 EC6lL38iJyd6ABlmTx0ZIpgkMpQcJ5xmGjO5T+kkmvgVOsSPvKTvYJJs/wgcbGJtNCEU
 hgKrC88gHlxj/jC0ST4A44w4ZuB1KvS4kpgkjMdWr7ZrSjaaui7JnvL53AigTcAHREqe LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eym5dut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 16:16:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081GF1av092359;
        Tue, 1 Sep 2020 16:16:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380ss2gj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 16:16:15 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081GGEe2027131;
        Tue, 1 Sep 2020 16:16:14 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 09:16:13 -0700
Subject: Re: [PATCH 01/11] btrfs: initialize sysfs devid and device link for
 seed device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <2db650ec206db1cb3e68590951b59e222fb10116.1598792561.git.anand.jain@oracle.com>
 <1df53e43-2ec8-8e67-8a79-ec90782e9e3a@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c6f502de-1634-f79f-3da4-9febb4d0df27@oracle.com>
Date:   Wed, 2 Sep 2020 00:16:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <1df53e43-2ec8-8e67-8a79-ec90782e9e3a@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010134
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/9/20 12:21 am, Josef Bacik wrote:
> On 8/30/20 10:40 AM, Anand Jain wrote:
>> The following test case leads to null kobject-being-freed error.
>>
>>   mount seed /mnt
>>   add sprout to /mnt
>>   umount /mnt
>>   mount sprout to /mnt
>>   delete seed
>>
>>   kobject: '(null)' (00000000dd2b87e4): is not initialized, yet 
>> kobject_put() is being called.
>>   WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>>   RIP: 0010:kobject_put+0x80/0x350
>>   ::
>>   Call Trace:
>>   btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>>   btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>>   btrfs_ioctl+0x206c/0x22a0 [btrfs]
>>   ksys_ioctl+0xe2/0x140
>>   __x64_sys_ioctl+0x1e/0x29
>>   do_syscall_64+0x96/0x150
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   RIP: 0033:0x7f4047c6288b
>>   ::
>>
>> This is because, at the end of the seed device-delete, we try to remove
>> the seed's devid sysfs entry. But for the seed devices under the sprout
>> fs, we don't initialize the devid kobject yet. So this patch initializes
>> the seed device devid kobject and the device link in the sysfs. This 
>> takes
>> care of the Warning.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
> 
> Ok again, this will not work.
> 

  This comment was answered here [1] before.
    [1]  https://patchwork.kernel.org/patch/11729425/


  Again let me verify with the boilerplate code [2], which dumps
  btrfs_fs_devices and btrfs_device structures along with its
  memory address.
    [2] https://github.com/asj/bbp.git

> Mount a seed fs, you get fs_info->fs_devices pointed at the seed device, 
> and fs_info->fs_devices->devices_kobj is what is initialized.

Right.

$ mount /dev/sda /btrfs
mount: /btrfs: WARNING: device write-protected, mounted read-only.

Note our fs_devices is at 000000005c8322d4, which is paired with sda.

$ cat /proc/fs/btrfs/devlist | egrep "fsid|addr|device:|kobj"
[fsid: 938a1ff2-f493-4a9a-9ed3-3d2ace2f0fb2]
	fs_devs_addr:		000000005c8322d4 <-- fs_devices
	fsid_kobj_state:	1
	fsid_kobj_insysfs:	1
	kobj_state:		1
	kobj_insysfs:		1
		dev_addr:	0000000017aba761
		device:		/dev/sda
		devid_kobj:	1


> Now you sprout.


The relevant code snippets are as below.

-----------------------------
2344 static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)

2361         seed_devices = alloc_fs_devices(NULL, NULL);

2371         old_devices = clone_fs_devices(fs_devices);

2377         list_add(&old_devices->fs_list, &fs_uuids);

2379         memcpy(seed_devices, fs_devices, sizeof(*seed_devices));

2386         list_splice_init_rcu(&fs_devices->devices, 
&seed_devices->devices,
2387                               synchronize_rcu);

2396         list_add_tail(&seed_devices->seed_list, 
&fs_devices->seed_list);

2398         generate_random_uuid(fs_devices->fsid);
-----------------------------


> This does clone_fs_devices(fs_info->fs_devices), which doesn't copy over 
> fs_fdevices->devices_kobj.

  Right. Line 2371.

>  Now we take this clone device, and set 
> fs_info->fsdevices to the cloned fs_devices,

  Hm. No we just add it to the fs_uuids. So that user doesn't have
  to scan again to mount the seed device at a different mount point.
  Line 2377.

> and we add the original 
> fs_devices, which had the sysfs objects init'ed already, to 
> fs_devices->seed_list.

  No. Original fs_devices still remains with fs_info->fs_devices.
  Which moves _devices_ _only_  to seed_devices::devices
  Line 2386.

  Lets verify.

  $ btrfs dev add -f /dev/sdb /btrfs

  Our fs_devices was at 000000005c8322d4.

  And after device add, our fs_devices 000000005c8322d4 is pairing with
  the RW device sdb.

  And the original sda is moved under seed_devices.

  Ignore clone_fs_devices its of no use to our conversation here.
  Which goes away after btrfs dev scan --forget as its not mounted
  anymore.

  As shown below.

$ cat /proc/fs/btrfs/devlist | egrep "fsid|addr|device:|kobj"
[fsid: 938a1ff2-f493-4a9a-9ed3-3d2ace2f0fb2]
	fs_devs_addr:		00000000f0c691d1 <-- clone_fs_devices
	fsid_kobj_state:	0
	fsid_kobj_insysfs:	0
	kobj_state:		null
	kobj_insysfs:		null
		dev_addr:	000000006e24ab09
		device:		/dev/sda
		devid_kobj:	null
[fsid: 91294469-9c0e-45c7-8dc7-af3134ba8cf4]
	fs_devs_addr:		000000005c8322d4 <-- fs_devices
	fsid_kobj_state:	1
	fsid_kobj_insysfs:	1
	kobj_state:		1
	kobj_insysfs:		1
		dev_addr:	0000000039f25fa1
		device:		/dev/sdb
		devid_kobj:	1
	[[seed_fsid: 938a1ff2-f493-4a9a-9ed3-3d2ace2f0fb2]]
		sprout_fsid:		91294469-9c0e-45c7-8dc7-af3134ba8cf4
		fs_devs_addr:		000000005e19db25 <-- seed_devices
		fsid_kobj_state:	1
		fsid_kobj_insysfs:	1
		kobj_state:		1
		kobj_insysfs:		1
			dev_addr:	0000000017aba761
			device:		/dev/sda
			devid_kobj:	1


Clone_fs_devices is freed after forget

$ btrfs dev scan --forget

$ cat /proc/fs/btrfs/devlist | egrep "fsid|addr|device:|kobj"
[fsid: 91294469-9c0e-45c7-8dc7-af3134ba8cf4]
	fs_devs_addr:		000000005c8322d4  <-- fs_devices
	fsid_kobj_state:	1
	fsid_kobj_insysfs:	1
	kobj_state:		1
	kobj_insysfs:		1
		dev_addr:	0000000039f25fa1
		device:		/dev/sdb
		devid_kobj:		1
	[[seed_fsid: 938a1ff2-f493-4a9a-9ed3-3d2ace2f0fb2]]
		sprout_fsid:		91294469-9c0e-45c7-8dc7-af3134ba8cf4
		fs_devs_addr:		000000005e19db25 <-- seed_devcies
		fsid_kobj_state:	1
		fsid_kobj_insysfs:	1
		kobj_state:		1
		kobj_insysfs:		1
			dev_addr:	0000000017aba761
			device:		/dev/sda
			devid_kobj:		1



HTH

Anand
