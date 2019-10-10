Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5073D1EAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 04:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfJJCwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 22:52:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45776 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfJJCwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Oct 2019 22:52:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A2mX02082460;
        Thu, 10 Oct 2019 02:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=tlEXEclMV4oEY4ouZNpdavKAhxmYJFqTC93W54NaUrg=;
 b=sAauRaMQHoinlDXT73t3AqLoO7+3RDmM5guJ7/RhchvgkrXjT2QigdONLerZgxvhIiy1
 mbUfN3SfUzGjbmdyPYtepylLTmGMbnJmlQS02Dseb+YV3iwVdYVb3Z71kPnnDRAF+COI
 DwZr6lrs43fiUeeP/PP5LePiBKlwqko68acyfZ4Iy14hlz5MfzPh483uI9x7uvkUS+ee
 DlV6iq77ZfSDIfz7m76l2SU0Ef4rKRl4xR60cxCL+g+UsSDBsKgDkO1wanhQQQm0liRp
 8xzC2Qiy1rK3hCMEuwjJqhbLGuaicZXB4FL6jR4HBT8AWIG7EQnWMHtckRai4S6b5wZi vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektrr1th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 02:52:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A2mHMF040001;
        Thu, 10 Oct 2019 02:52:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vh8k1xmrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 02:52:25 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9A2qPrM001781;
        Thu, 10 Oct 2019 02:52:25 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 19:52:25 -0700
Subject: Re: [PATCH v3 2/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ad2f336d-eafa-3c8c-d043-718e8efd6c46@oracle.com>
Date:   Thu, 10 Oct 2019 10:52:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010023928.24586-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100026
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/10/19 10:39 AM, Qu Wenruo wrote:
> Refactor the work inside the loop of btrfs_read_block_groups() into one
> separate function, read_one_block_group().
> 
> This allows read_one_block_group to be reused for later BG_TREE feature.
> 
> The refactor does the following extra fix:
> - Use btrfs_fs_incompat() to replace open-coded feature check
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/block-group.c | 215 +++++++++++++++++++++--------------------
>   1 file changed, 108 insertions(+), 107 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c906a2b6c2cf..0c5eef0610fa 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1687,6 +1687,109 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
>   	return ret;
>   }
>   
> +static int read_one_block_group(struct btrfs_fs_info *info,
> +				struct btrfs_path *path,
> +				int need_clear)
> +{
> +	struct extent_buffer *leaf = path->nodes[0];
> +	struct btrfs_block_group_cache *cache;
> +	struct btrfs_space_info *space_info;
> +	struct btrfs_key key;
> +	int mixed = btrfs_fs_incompat(info, MIXED_GROUPS);

  nit:  mixed can be bool. (David can change while integrating.)

Thanks, Anand
