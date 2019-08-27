Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382A99DB85
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 04:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfH0CHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 22:07:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48306 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfH0CHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 22:07:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R24ImJ018957;
        Tue, 27 Aug 2019 02:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LfiNRS0S5XLHXI9bETGZI049KCVtAMuKebz//j3KSQA=;
 b=lkg98ZvgZ5LEqyuAxj9hg1lhcaiebsXgI3xdIbMYD/X6NbNLRWDOu2XHBt6AqZQqk6Dt
 tYQZy3x10Rj0D0r9Wj9D8OqXpxLNa8nTiQ/iK91IKMiJIGeqIh3dtkAAdBk9Q7XJPLRS
 xR5xCRhRNFNmjFceWPdV3BnGYMJb71AonRSApHi1pusYLpeWMSQ+04E194QV3AWhlYxm
 UjD70R79zxd2YvPxdP/lSJmKV0BpUHEDmcbmXnKFJ8iSc3G06Z+hU0tg03Db+HWxTqml
 CED6Qv8ZX9SYQLzuS703OFmGj+AFA4fpVlP4YegbPm6xmdQAVoA5PrmaiuJUEyeeWrxN iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2umqbe8y8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 02:07:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R1x4ZD167707;
        Tue, 27 Aug 2019 02:02:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2umj27h9ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 02:02:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7R22dhk008802;
        Tue, 27 Aug 2019 02:02:39 GMT
Received: from [172.20.10.2] (/183.90.37.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 19:02:39 -0700
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <20190703132158.GV20977@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com>
Date:   Tue, 27 Aug 2019 10:02:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190703132158.GV20977@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270020
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/7/19 9:21 PM, David Sterba wrote:
> On Fri, Jun 28, 2019 at 10:26:11AM +0800, Anand Jain wrote:
>> At the time mkfs.btrfs the device id and stripe index gets reversed as
>> shown in [1]. This patch helps to keep them in order at the time of
>> mkfs.btrfs. And makes it easier to debug.
>>
>> Before:
>> Stripe 0 is on devid 2; Stipe 1 is on devid 1;
>>
>> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
> 
> I've reformatted that so it's not overly long line. For dumps it's ok
> but a command can be split by && or | .
> 
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
> Added to devel, thanks.
> 

  I don't see this patch is integrated. Any idea?

Thanks, Anand
