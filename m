Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAD1EF4ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgFEKGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 06:06:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36628 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgFEKGB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jun 2020 06:06:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559umom108746;
        Fri, 5 Jun 2020 10:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Mtd7yOcFxdbMJGc7ZOpvfd3kmfOgF15qVLn3FSSAu3w=;
 b=UAFP4KoFboZArzVexG/C8OMDcGwTX4szTdoG/Ofnhw2eHHXMcdCVC5mJGmR2voGibPBv
 iK0YrlOpNxDqBgINZoKI/KLN/623WU3I1m5b93IEn49QRpo7+wSkkIANmHRgsL1Hcxkf
 4vUh++flww3iynqOAy26coaymhSfxK7h3qeSgOY8LMsVYl0zIlFRinL+AjiEfta2hOlS
 9sslmOxoIjyJZnv+ET+L8UUf7EE4kE/lyJ62tbtWZeHRBJMiBurfdGtsvub6bOQDypQG
 EhAwq0oVlxPx2xw5gmumq1vFOan/SZBOu4ApbkLcgAkQgRWwtjSlin3/wNuwx8Ebajih 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31f91dt54b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 10:05:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559sAG0007949;
        Fri, 5 Jun 2020 10:03:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31f9270utg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 10:03:57 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055A3uiu032637;
        Fri, 5 Jun 2020 10:03:56 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 03:03:56 -0700
Subject: Re: [PATCH v7 2/2] btrfs: Introduce new mount option to skip block
 group items scan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7ef6183b-4e6f-e395-acd3-29057668d304@oracle.com>
Date:   Fri, 5 Jun 2020 18:03:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604071807.61345-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=2 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=2 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> @@ -2010,6 +2056,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   	int need_clear = 0;
>   	u64 cache_gen;
>   
> +	if (btrfs_test_opt(info, SKIPBG))
> +		return fill_dummy_bgs(info);
> +

   Could it first read the block group if it fails then check mount
   option skip + other required options are set to continue/abort?


> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f8ec2d8606fd..84d62bd53940 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2269,11 +2269,15 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>   
>   	root = btrfs_read_tree_root(tree_root, &location);
>   	if (IS_ERR(root)) {
> -		ret = PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, SKIPBG)) {
> +			ret = PTR_ERR(root);
> +			goto out;
> +		}

  Needs a btrfs_warn().

> @@ -2215,9 +2238,12 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   	 * not fit in the free metadata space.  If we aren't ->full then we
>   	 * still can allocate chunks and thus are fine using the currently
>   	 * calculated f_bavail.
> +	 *
> +	 * Or if we're rescuing, set available to 0 anyway.
 >
>   	 */
> -	if (!mixed && block_rsv->space_info->full &&
> -	    total_free_meta - thresh < block_rsv->size)
> +	if (btrfs_test_opt(fs_info, SKIPBG) ||
> +	    (!mixed && block_rsv->space_info->full &&
> +	     total_free_meta - thresh < block_rsv->size))
>   		buf->f_bavail = 0;
>

  I wonder why is this necessary? when RO and nologreply mount options
  are prerequisites of the skip mount option.

  Also its not a good idea that df reports 0 available size.


> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0d6e785bcb98..f89625de1fff 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7594,6 +7594,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
>   	u64 prev_dev_ext_end = 0;
>   	int ret = 0;
>   
> +	/*
> +	 * For rescue=skipbg mount option, we're already RO and are salvaging
> +	 * data, no need for such strict check.
> +	 */
> +	if (btrfs_test_opt(fs_info, SKIPBG))
> +		return 0;
> +

  Here too, can we first verify if the dev extents actually fail, and
  then check if skip + other necessary mount options are set to
  continue/abort the mount. ?

Thanks, Anand

