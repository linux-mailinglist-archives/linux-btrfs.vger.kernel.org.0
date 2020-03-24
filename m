Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02171904B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 05:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgCXEzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 00:55:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCXEzw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 00:55:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02O4n5M1107405;
        Tue, 24 Mar 2020 04:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7e981U1JecT+gU66a0MEXsJILPFvPYbXyFxj9eBd7nA=;
 b=l3igSXPYnNExacYMpiLS+74OxOIcHNfL5eSiJ5kPsPBQIvQtp6PW4s3PKqWa1j1R7544
 gj4AI9vFJJnc/JN3qwHtIWASqXNtoFQrc/blzIcZeWv2jKFEHlnVzUK2T/d1PmotvD8Z
 0B1Tup661QNPR5iEJUWWV3daAKOKYacD0pMWWTIzMti9+q+Rz9m3o3jmmLiTkzCZOeE9
 Luq5hwUbiaHbToQ508NGxpjNOzDX9LldAVAnmfPdc63tgXduOi5Ps8/j3OIEvxIzFesH
 GAwJvFphXwpGOzemMgZfSxLcIHRTMbZeop1kf7pKjxIhJ/m/VnI4LFN25ddQ+iFS5wnK 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavm24c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 04:55:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02O4o5GY048468;
        Tue, 24 Mar 2020 04:55:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yy5k53yeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 04:55:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02O4tiIB012205;
        Tue, 24 Mar 2020 04:55:45 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 21:55:44 -0700
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2c7f2844-b97d-0e15-6ae6-40c9c935aa77@oracle.com>
Date:   Tue, 24 Mar 2020 12:55:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240023
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/21/20 1:56 AM, Goffredo Baroncelli wrote:
> Hi all,
> 
> for a btrfs filesystem, how an user can understand which is the 
> {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk 
> which profile will have ?
> For simple filesystem it is easy looking at the output of (e.g)  "btrfs 
> fi df" or "btrfs fi us". But what if the filesystem is not simple ?
> 
> btrfs fi us t/.
> Overall:
>      Device size:          40.00GiB
>      Device allocated:          19.52GiB
>      Device unallocated:          20.48GiB
>      Device missing:             0.00B
>      Used:              16.75GiB
>      Free (estimated):          12.22GiB    (min: 8.27GiB)
>      Data ratio:                  1.90
>      Metadata ratio:              2.00
>      Global reserve:           9.06MiB    (used: 0.00B)
> 
> Data,single: Size:1.00GiB, Used:512.00MiB (50.00%)
>     /dev/loop0       1.00GiB
> 
> Data,RAID5: Size:3.00GiB, Used:2.48GiB (82.56%)
>     /dev/loop1       1.00GiB
>     /dev/loop2       1.00GiB
>     /dev/loop3       1.00GiB
>     /dev/loop0       1.00GiB
> 
> Data,RAID6: Size:4.00GiB, Used:3.71GiB (92.75%)
>     /dev/loop1       2.00GiB
>     /dev/loop2       2.00GiB
>     /dev/loop3       2.00GiB
>     /dev/loop0       2.00GiB
> 
> Data,RAID1C3: Size:2.00GiB, Used:1.88GiB (93.76%)
>     /dev/loop1       2.00GiB
>     /dev/loop2       2.00GiB
>     /dev/loop3       2.00GiB
> 
> Metadata,RAID1: Size:256.00MiB, Used:9.14MiB (3.57%)
>     /dev/loop2     256.00MiB
>     /dev/loop3     256.00MiB
> 
> System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>     /dev/loop2       8.00MiB
>     /dev/loop3       8.00MiB
> 
> Unallocated:
>     /dev/loop1       5.00GiB
>     /dev/loop2       4.74GiB
>     /dev/loop3       4.74GiB
>     /dev/loop0       6.00GiB
> 
> This is an example of a strange but valid filesystem. So the question 
> is: the next chunk which profile will have ?
> Is there any way to understand what will happens ?
> 
> I expected that the next chunk will be allocated as the last "convert". 
> However I discovered that this is not true.
> 
> Looking at the code it seems to me that the logic is the following (from 
> btrfs_reduce_alloc_profile())
> 
>          if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>                  allowed = BTRFS_BLOCK_GROUP_RAID6;
>          else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>                  allowed = BTRFS_BLOCK_GROUP_RAID5;
>          else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>                  allowed = BTRFS_BLOCK_GROUP_RAID10;
>          else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>                  allowed = BTRFS_BLOCK_GROUP_RAID1;
>          else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>                  allowed = BTRFS_BLOCK_GROUP_RAID0;
> 
>          flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
> 
> So in the case above the profile will be RAID6. And in the general if a 
> RAID6 chunk is a filesystem, it wins !

  That's arbitrary and doesn't make sense to me, IMO mkfs should save
  default profile in the super-block (which can be changed using ioctl)
  and kernel can create chunks based on the default profile. This
  approach also fixes chunk size inconsistency between progs and kernel
  as reported/fixed here
    https://patchwork.kernel.org/patch/11431405/

Thanks, Anand

> But I am not sure.. Moreover I expected to see also reference to DUP 
> and/or RAID1C[34] ...
> 
> Does someone have any suggestion ?
> 
> BR
> G.Baroncelli
> 

