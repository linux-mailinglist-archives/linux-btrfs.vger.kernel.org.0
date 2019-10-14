Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1ED5E4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfJNJJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 05:09:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbfJNJJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 05:09:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9E99FXA154272;
        Mon, 14 Oct 2019 09:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=emESOTBSvx/WYWjZnTk1gICqdjtegDyo9cLmF+mXFOQ=;
 b=RQaX/KgleAPVOREosnBY8ff0C9wkItFMBXEmElB3Sl4zd7bDwPuxAJfvW9cmnoaLewB7
 eJYLs0o7TDEvNm22LsgmCihu+S5oOunsr+jFrYDHynIKRD96kow89kXY3N5GoLB7yYLR
 4HFe0nyVEtvlYBS08+Yv0ys39oUVyGh9fgm90Fm54acZuFVXxlk5CATTwoKA6YHS90kx
 ZWK1W++DnZC8sLhY9pfQUCwwgxryAm41FN/Mvf9ufJfscWcUmSf0+7lTfnMyQNC9B69p
 fC9u8SBwEPTJnklWBlGTdOvayCaPztT5gYXrKeqv7Ib9ofFBdYNwlzr3vGA61TBFXywj ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68u7hh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 09:09:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9E99Rd4167937;
        Mon, 14 Oct 2019 09:09:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vkr9wd2h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 09:09:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9E98GRp008611;
        Mon, 14 Oct 2019 09:08:16 GMT
Received: from [172.20.10.3] (/183.90.36.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 09:08:16 +0000
Subject: Re: [PATCH v3 3/3] btrfs: Introduce new incompat feature, BG_TREE, to
 speed up mount time
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-4-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <16b15fd5-cee8-784b-31e9-d5473cd72474@oracle.com>
Date:   Mon, 14 Oct 2019 17:08:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010023928.24586-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=905
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=992 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 044981cf6df9..1c5728e6a660 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1570,6 +1570,8 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>   	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
>   		return fs_info->free_space_root ? fs_info->free_space_root :
>   						  ERR_PTR(-ENOENT);
> +	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)


> +		return fs_info->bg_root ? fs_info->bg_root: ERR_PTR(-ENOENT);

  An explicit check is better than implicit check for example:
------------
return btrfs_fs_incompat(fs_info, BG_TREE) ? \
	fs_info->bg_root : ERR_PTR(-ENOENT);
------------


Thanks, Anand
