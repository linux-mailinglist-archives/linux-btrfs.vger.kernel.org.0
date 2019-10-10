Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB02D1E1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 04:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfJJCC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 22:02:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59510 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfJJCA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Oct 2019 22:00:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A1xPJg061934;
        Thu, 10 Oct 2019 02:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=1eSgc87uKG1A7fkN6oGpQCHa1DCOVLI+ffr+vxiRrOA=;
 b=OE2Piaf7zzUIgKMvSVnvwMGF+RlrNmfi9J0T4Y28NC1zW3Lwc9PQC9CKuv61C3boZHX0
 xToudjO63/uyKA87hpR1jPO47/QkKaZeVFIgBdzfSdMQdJQgJNv+9uwiR28gum9XcyEl
 yXqEl1IsmOxii+pQ4JaItVQIiZQGbIC9umvF+3hpOoIiGEPqUx1cjejWxILJ8lP8r7my
 YKAg9D0IwkEznZ17upirh+1uwygJVgWp+k7SRvGcyr+TaJIt5UFUw+KWCnhi2wkgsVpE
 Unxg479Surt0k30naw04qHxB13hxoW+rwX0pro3+yLHc+8om0+FWoNttBBczNCe9Q35/ iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vejkur5ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 02:00:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A1waEG185431;
        Thu, 10 Oct 2019 02:00:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vhhsnq4jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 02:00:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9A20KM8030939;
        Thu, 10 Oct 2019 02:00:20 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 19:00:19 -0700
Subject: Re: [PATCH v2 2/3] btrfs: disk-io: Remove unnecessary check before
 freeing chunk root
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044909.157750-1-wqu@suse.com>
 <20191008044909.157750-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a51926df-f18b-68dc-9241-7e9df1164199@oracle.com>
Date:   Thu, 10 Oct 2019 10:00:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008044909.157750-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100017
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/19 12:49 PM, Qu Wenruo wrote:
> In free_root_pointers(), free_root_extent_buffers() has checked if the
> @root parameter is NULL.
> So there is no need checking chunk_root before freeing it.

um..

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 044981cf6df9..bfeeac83b952 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2038,8 +2038,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, int chunk_root)
>   	free_root_extent_buffers(info->csum_root);
>   	free_root_extent_buffers(info->quota_root);
>   	free_root_extent_buffers(info->uuid_root);
> -	if (chunk_root)
> -		free_root_extent_buffers(info->chunk_root);
> +	free_root_extent_buffers(info->chunk_root);
>   	free_root_extent_buffers(info->free_space_root);
>   }
>   
> 

This will cause the regression and fails mount from the backup root.

We have %recovery_tree_root: which shall re-read all the trees root
except the chunk root.

I don't think your idea was to re-read the chunk root as well?.

-----------------
recovery_tree_root:
         if (!btrfs_test_opt(fs_info, USEBACKUPROOT))
                 goto fail_tree_roots;

         free_root_pointers(fs_info, 0);
-----------------

Thanks, Anand
