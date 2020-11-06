Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628282A8B5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 01:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgKFAUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 19:20:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52806 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgKFAUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 19:20:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A603x7N170546;
        Fri, 6 Nov 2020 00:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=h3SqMpTYSDJp7/cr3rtwRNiFgLeY6ktY1qPGo85o7qk=;
 b=JffCftnwGE2hgV9ls5I+IJF0nqD99clM0kve+b9wZh8p9A9YyrAfOYw6e1WteY76X1g5
 ZMAxKJRLl8woN0F/Ux/aVM34p2iO1LNnGPJzBxH+Cw1dy5H5LjCFdCa5D0u8R3n/gdM3
 rvIfFTQBJfAT2l1hTHbeyancT3elSrstxNBBbQ8kNCmInXcHcrMmSR3jQV2vwC4/TCvO
 /XkJA0jSUHnjFzO1OKIWEZgr2sRnnXOJsglylcda1Q9eYMIBkohGOsSBEaw2sbkNyT4x
 F/bVcs2PPqcg5XToCmiqPN1uruznnTdP2VRfg7rz5eknPIutFWgaydzhl6bB5/4u4lEI cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34hhb2eqy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 00:20:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A604wrB105566;
        Fri, 6 Nov 2020 00:20:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34jf4d1590-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 00:20:18 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A60KHBX009974;
        Fri, 6 Nov 2020 00:20:17 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 16:20:17 -0800
Subject: Re: [PATCH RESEND v2 1/3] btrfs: drop never met condition of
 disk_total_bytes == 0
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Nikolay Borisov <nborisov@suse.com>, wqu@suse.com
References: <cover.1604372688.git.anand.jain@oracle.com>
 <682907bcd58ffeece1a76c6ec3b866139a6381bd.1604372689.git.anand.jain@oracle.com>
 <20201105223654.GO6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <019a25c1-d4d2-02e3-3b82-2ae46384b8d3@oracle.com>
Date:   Fri, 6 Nov 2020 08:20:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105223654.GO6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050158
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/11/20 6:36 am, David Sterba wrote:
> On Tue, Nov 03, 2020 at 01:49:42PM +0800, Anand Jain wrote:
>> btrfs_device::disk_total_bytes is set even for a seed device (the
>> comment is wrong).
> 
> That's where I'm a bit lost. It was added in 1b3922a8bc74 ("btrfs: Use
> real device structure to verify dev extent").
> 

  The call chain where we update the btrfs_device::disk_total_bytes is as
  below..


    read_one_dev()
::

 From the section below we get the cloned copy of the seed device.
-----
         if (memcmp(fs_uuid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE)) {
                 fs_devices = open_seed_devices(fs_info, fs_uuid);
                 if (IS_ERR(fs_devices))
                         return PTR_ERR(fs_devices);
         }

         device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
                                    fs_uuid);
------


  Further down in read_one_dev() at and in the 
fill_device_from_item(..., device) we update the 
btrfs_device::disk_total_bytes.

fill_device_from_item(..., device)
::
         device->disk_total_bytes = btrfs_device_total_bytes(leaf, 
dev_item);

Hope this clarifies.

V1 email discussion has more information.

>> The function fill_device_from_item() does the job of reading it from the
>> item and updating btrfs_device::disk_total_bytes. So both the missing
>> device and the seed devices do have their disk_total_bytes updated.
>>
>> Furthermore, while removing the device if there is a power loss, we could
>> have a device with its total_bytes = 0, that's still valid.


> 
> Ok, that's the condition that the commit mentioned above used to detect
> the device and to avoid doing the tree-checker verification.

Ok. Please look at what did the commit 1b3922a8bc74 do? It re-ran the 
btrfs_find_device(seed_devs,..., false), which anyway the 
btrfs_find_device(sprout_devs,..., true) has run just before. In both of 
these btrfs_find_device() runs, the dev returned will be the same. The 
fix makes no sense to the problem as in the commit.


> 
>> So this patch removes the check dev->disk_total_bytes == 0 in the
>> function verify_one_dev_extent(), which it does nothing in it.
> 
> Removing a check that supposedly does notghing, but the referenced
> commit says otherwise.
> 

IMO the reason for the problem found in that commit was wrong. Qu 
commit's email thread has some discussion. But nothing more on the problem.

Also Nikolay had the same question here was my reply.
https://www.spinics.net/lists/linux-btrfs/msg105645.html


>> And take this opportunity to introduce a check if the device::total_bytes
>> is more than the max device size in read_one_dev().
> 
> If this is not related to the the check removal, then it should be an
> independent patch explaing in full what is being fixed. As I read it
> this should be independent as it's checking the upper bound.
> 

  That came from the Josef comments, please refer to the v1 email 
discussion. Most of the above concerns are already discussed there. I am 
ok to move it to a new patch if required.

Thanks, Anand

