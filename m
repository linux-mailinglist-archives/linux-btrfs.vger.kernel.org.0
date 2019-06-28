Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94E591F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 05:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfF1D3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 23:29:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1D3D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 23:29:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3JOZY191668;
        Fri, 28 Jun 2019 03:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GT/fBrtfG27MH4/7PkM76kMvK4xKIUBpQQiJuFay7ek=;
 b=2Cmt+kmxq392Q0+BqgNpbH8oU12hu/Mbll6nxWxH/q/tFbP8h7j1oz91g4oqWUJ7CltP
 8OAs9mpROnCre4AIAp3c41O+Bzfat3oJDTet6yc5G+gf+lEnrSzDFzGlXH+sqjxhSObV
 IAGPihPk+CFM6xF4iVEGk08++r5aLnvh0OVzYrOAR8muJV5GOh5JjecEo0IgSFASGyfW
 K0eagJatmqN8ZK0sbYE70EQaLxmw3R0E/NB6tT3yDPW8sK6Eszk1sLTZhLGLHdF+t9IE
 blScMMKfAkveeZ70F3dVV2Rxg9MkWKNyV3eX/QtHQuGt8x+4PdrBhusBh1o7ITilw1MB vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtkckk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:28:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3SuHp013216;
        Fri, 28 Jun 2019 03:28:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6vnust-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:28:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S3Stu8006099;
        Fri, 28 Jun 2019 03:28:56 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 20:28:55 -0700
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <0a250a9a-d710-4c7c-ca24-0e4f635a4a99@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5d93d408-2575-f564-32ce-e6c39b3b8d17@oracle.com>
Date:   Fri, 28 Jun 2019 11:28:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0a250a9a-d710-4c7c-ca24-0e4f635a4a99@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280032
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/6/19 10:44 AM, Qu Wenruo wrote:
> 
> 
> On 2019/6/28 上午10:26, Anand Jain wrote:
>> At the time mkfs.btrfs the device id and stripe index gets reversed as
>> shown in [1]. This patch helps to keep them in order at the time of
>> mkfs.btrfs. And makes it easier to debug.
>>
>> Before:
>> Stripe 0 is on devid 2; Stipe 1 is on devid 1;
>>
>> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
>> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsize 112
>> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 0
>> 			stripe 0 devid 2 offset 1048576
>> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
>> 			stripe 1 devid 1 offset 22020096
>> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
>> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 0
>> 			stripe 0 devid 2 offset 9437184
>> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
>> 			stripe 1 devid 1 offset 30408704
>> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>> 	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 itemsize 112
>> 		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 0
>> 			stripe 0 devid 2 offset 277872640
>> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
>> 			stripe 1 devid 1 offset 298844160
>> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>>
>> After:
>> Stripe 0 is on devid 1; Stripe 1 is on devid 2
>>
>> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
>> /dev/sdb: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 66 53 5f 4d
>> /dev/sdc: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 66 53 5f 4d
>> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsize 112
>> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 0
>> 			stripe 0 devid 1 offset 22020096
>> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
>> 			stripe 1 devid 2 offset 1048576
>> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
>> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 0
>> 			stripe 0 devid 1 offset 30408704
>> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
>> 			stripe 1 devid 2 offset 9437184
>> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>> 	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 itemsize 112
>> 		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 2 sub_stripes 0
>> 			stripe 0 devid 1 offset 298844160
>> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
>> 			stripe 1 devid 2 offset 277872640
>> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> But please also check the comment inlined below.
>> ---
>>   volumes.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/volumes.c b/volumes.c
>> index 79d1d6a07fb7..8c8b17e814b8 100644
>> --- a/volumes.c
>> +++ b/volumes.c
>> @@ -1109,7 +1109,7 @@ again:
>>   			return ret;
>>   		cur = cur->next;
>>   		if (avail >= min_free) {
>> -			list_move_tail(&device->dev_list, &private_devs);
>> +			list_move(&device->dev_list, &private_devs);
> 
> This is OK since current btrfs-progs chunk allocator doesn't follow the
> kernel behavior by sorting devices with its unallocated space.
> So it's completely devid based.
> 
> But please keep in mind that, if we're going to unify the chunk
> allocator behavior of kernel and btrfs-progs, the behavior will change.
> 
> As the initial temporary chunk is always allocated on devid 1, reducing
> its unallocated space thus reducing its priority in chunk allocator, and
> making the devid sequence more unreliable.

  Right. For the debug here, I have an experimental code which disables
  the unallocated space sort in the kernel. I don't have a strong reason
  to disable the sort in the kernel so didn't send the patch.

Thanks, Anand

> Thanks,
> Qu
> 
>>   			index++;
>>   			if (type & BTRFS_BLOCK_GROUP_DUP)
>>   				index++;
>> @@ -1166,7 +1166,7 @@ again:
>>   		/* loop over this device again if we're doing a dup group */
>>   		if (!(type & BTRFS_BLOCK_GROUP_DUP) ||
>>   		    (index == num_stripes - 1))
>> -			list_move_tail(&device->dev_list, dev_list);
>> +			list_move(&device->dev_list, dev_list);
>>   
>>   		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
>>   			     calc_size, &dev_offset);
>>
> 

