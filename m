Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B71280C79
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 05:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgJBDOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 23:14:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBDO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 23:14:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0922xhBE140491;
        Fri, 2 Oct 2020 03:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VtJocbrZiVLwb0FxfAG4rJ6Fy0GHy4I+EhzWEF83sgw=;
 b=G781adNV1EcWqqLmPFQNgWm4H6VdkD4TgvPCjHsrc04fQAgg+v9NapSMrnI90eeofY/9
 N25sBGfYzQVuESuJQ28LGAhG1smCaDqNszZE6Bue78esoKOXWmDXPxzRIxL2y6L/rqqn
 cc5XI6QjVjt8LaHCSWhvZZpFPBA3dophhw9KfbSbh3dVZoYpupP/At+TqECsUrbAxjW1
 nMXC/pMmHG/R0DVm2MOL0IbeWHurRZG/Ps/YN8h11iFk2fEnIcUlafPDUxl4yty7HuBe
 nDXg+qDPofUOjKz5X+wCQSJY/fzXdXdREVHUbOEgw0K8jkPRvJmubC4tTiO3th8qfyxk cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33sx9nh40r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 03:14:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09230xTr052406;
        Fri, 2 Oct 2020 03:14:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33uv2ht1jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 03:14:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0923EKCp027880;
        Fri, 2 Oct 2020 03:14:20 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Oct 2020 20:14:20 -0700
Subject: Re: [PATCH 0/2] fix verify_one_dev_extent and btrfs_find_device
To:     David Sterba <dsterba@suse.cz>
Cc:     nborisov@suse.com, wqu@suse.com, dsterba@suse.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1600940809.git.anand.jain@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8cdb74bc-03ec-4a57-8222-03105603eb85@oracle.com>
Date:   Fri, 2 Oct 2020 11:14:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1600940809.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020019
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David,
   ping?

Thanks, Anand


On 24/9/20 6:11 pm, Anand Jain wrote:
> btrfs_find_device()'s last arg %seed is unused, which the commit
> 343694eee8d8 (btrfs: switch seed device to list api) ignored purposely
> or missed.
> 
> But there isn't any regression due to that. And this series makes
> it official that btrfs_find_device() doesn't need the last arg.
> 
> To achieve that patch 1/2 critically reviews the need for the check
> disk_total_bytes == 0 in the function verify_one_dev_extent() and finds
> that, the condition is never met and so deletes the same. Which also
> drops one of the parents of btrfs_find_device() with the last arg false.
> 
> So only device_list_add() is using btrfs_find_device() with the last arg as
> false, which the patch 2/2 finds is not required as well. So
> this patch drops the last arg in btrfs_find_device() altogether.
> 
> Anand Jain (2):
>    btrfs: drop never met condition of disk_total_bytes == 0
>    btrfs: fix btrfs_find_device unused arg seed
> 
>   fs/btrfs/dev-replace.c |  4 ++--
>   fs/btrfs/ioctl.c       |  4 ++--
>   fs/btrfs/scrub.c       |  4 ++--
>   fs/btrfs/volumes.c     | 37 ++++++++++---------------------------
>   fs/btrfs/volumes.h     |  2 +-
>   5 files changed, 17 insertions(+), 34 deletions(-)
> 

