Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6BD24ED4B
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHWNFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 09:05:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42702 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHWNFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 09:05:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ND5ZHx131526;
        Sun, 23 Aug 2020 13:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yAwANdsjXLZWmRgj/AILgT/uNE/RueXGF3mJ1FGlkog=;
 b=Do29L7BrBExrZv1AVM+mGdjqz/LQQ5ngznDE5jwJL9KP9dFjp/bs/eLIWM25It5sjw4A
 4pEho6YfjvXR3lInl3UUWqDo4ne7M0osVPheYRw3rasMr7ZO32rPSIVWao8/4/nrbylY
 TJpw+9RmLflPJURH3v0Dg4maQfkS3gwCrlkkIw5EQn9vg6IBeWMHeu66DqFz9zXwOvdx
 vuxOOmDkmYzRFpz737AdjQpT7ng9y/X1uvPQUKx/5WfdQ6bQuw4EoVwMPAR1mSXMzyda
 /YGoJZOIIn+gr6jzkXIFu0lS/BFDMLgG8YrZfYNYfcfDHi/gIsWRrjMhfsFNfQY901mu UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333cse13wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Aug 2020 13:05:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ND4iJE057966;
        Sun, 23 Aug 2020 13:05:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 333r9grma9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Aug 2020 13:05:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07ND5fIF005326;
        Sun, 23 Aug 2020 13:05:41 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Aug 2020 06:05:41 -0700
Subject: Re: [PATCH 1/2] btrfs: initialize sysfs devid and device link for
 seed device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
 <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
 <779bd819-d320-39e3-0a0b-80c0c8455243@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ad2a98b5-320c-4990-d1e5-9c7bc3ae71a0@oracle.com>
Date:   Sun, 23 Aug 2020 21:05:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <779bd819-d320-39e3-0a0b-80c0c8455243@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9721 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008230147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9721 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008230147
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> So now we're using the main fs_devices->devices_kobj, which is the main 
> fs_devices with fs_devices->seed being the seed fs_devices.  This is 
> fine, except when we actually mount a seed device, and in that case we 
> have fs_devices as the seed devices being used, and then if we add a 
> device we'll actually swap in the new fs_devices for the main 
> fs_devices, and we have the seed devices with the actual devices_kobj 
> that we used set in fs_devices->seed, and thus we'll leak the sysfs 
> objects for the seed devices.  Thanks,

Do you mean leaking the devinfo_kobj instead of devices_kobj? If so,
then yes, and this patch fixed it as well (I just found out).

Otherwise, no, there isn't devices_kobj leak.  We make sure only mounted
fsid has the devices_kobj initialized. So during sprouting- the
devices_kobj remains with the fs_info->fs_devices, as we move the seed
devices below the seed_devices.

static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
::
  list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
  synchronize_rcu);
  list_for_each_entry(device, &seed_devices->devices, dev_list)
  device->fs_devices = seed_devices;

And during unmount, we clean up the dev links and devices_kobj.

close_ctree()
   btrfs_sysfs_remove_mounted()
   btrfs_sysfs_remove_fsid()


Anand


> Josef


