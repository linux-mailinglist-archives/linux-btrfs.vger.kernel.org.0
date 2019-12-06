Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA564114C4B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 07:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfLFGNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 01:13:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfLFGNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 01:13:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB667BN0009071;
        Fri, 6 Dec 2019 06:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=osWfZe5aILz7HsaBtGkscXW7yjV846UX4fQ9imvmCT0=;
 b=V2yH0TZX9Kj0RjjMPxwq5HHzxfuEW+ZGDVls/+p+e/nU/uu/Ccuhgx1pWS2UBVB0z5EW
 a328CvD5V4wuUF2kGHCAS4v4HtYC7i82oQj7WNljblx2xAYZYodSbSfbGscBSXAOnKfW
 S8AkkuU1YwgXPpwalToKC8D9rN7z3YvewxNl47ML2lwPFrB8mi77dRpNl7TNu1Gow/uM
 P5ZuDsUIBAFv38c791phi0rVKWPPuxvc4xqbrDk4OBbxr0QZtdEsvqJWWDqqX6rWKm/e
 rMOtuKmYg8ScV6SjYF7Lyx1eukCsXWXzy5Jw0FBu2NchVHkxp0ZOnmuLZRBD8aaj/fIa ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfuut1fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 06:13:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB660x0m046926;
        Fri, 6 Dec 2019 06:13:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wptq07278-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 06:13:03 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB66D0pi031692;
        Fri, 6 Dec 2019 06:13:01 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 22:13:00 -0800
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Christian Wimmer <telefonchris@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
Date:   Fri, 6 Dec 2019 14:12:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191206034406.40167-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060053
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/12/19 11:44 AM, Qu Wenruo wrote:
> Device tree is one of the least important tree, it only contains:
> - Device status
>    Like various error count
> - Device extents
>    Only makes sense for chunk allocation and physical->logical map, and
>    even for that only purpose, we can rebuild it easily from chunk tree.
> 
> So device tree even makes less sense compared to extent tree, while we
> still can't skip it at btrfs-progs.
> 
> This makes restore less useful. So this patch will make device tree to
> follow the same requirement for OPEN_CTREE_PARTIAL.
> 
> Reported-by: Christian Wimmer <telefonchris@icloud.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   disk-io.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/disk-io.c b/disk-io.c
> index 659f8b93..22aa2a61 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -947,12 +947,10 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
>   		return ret;
>   	fs_info->extent_root->track_dirty = 1;
>   
> -	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
> -				  fs_info->dev_root);
> -	if (ret) {
> -		printk("Couldn't setup device tree\n");
> -		return -EIO;
> -	}
> +	ret = setup_root_or_create_block(fs_info, flags, fs_info->dev_root,
> +					 BTRFS_DEV_TREE_OBJECTID, "device");
> +	if (ret)
> +		return ret;
>   	fs_info->dev_root->track_dirty = 1;
>   
>   	ret = setup_root_or_create_block(fs_info, flags, fs_info->csum_root,
> 

Cool.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks Anand

