Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EDAEC91
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbfIJOBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 10:01:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46302 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfIJOBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 10:01:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ADx9SE160969;
        Tue, 10 Sep 2019 14:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=iTxy/OrYk458OBzM1yRYFIvBUWYwK+MEHAlH7xdsCWA=;
 b=ZlnzCYgx0BhkvtzN5UiNbm1ngZ8lpPhzZVQ8yTdnouHw0t/avjjTC9ftPiFtgXeghPzy
 ba5MxJ3B43czHbILrbwwwB7/zgYoDi2WDQXk9+cSvVLoHWRGFaqx3g7YMplMlGlnBJER
 EduNBop794x/EZOfLks8GS7XlxmAlut/ypKIJurbeaJsFCtdASspILMzFXtzAO4omlqK
 y7q0/+VBOPPwef9ylsHlShXPdgjCAF3ByXCuUqWicEPLgddfyytlWPH2WKd9zGZsfQIC
 dngZvwDDI2B0UVo/GUfNM8MH9J/Q9uRrekegFMqcmQK6ZC/Q0WLgiNnX99e9qNG2tNvP Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2uw1m8un14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 14:01:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ADxU1T113963;
        Tue, 10 Sep 2019 14:01:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uwq9q1jax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 14:01:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8AE165M005235;
        Tue, 10 Sep 2019 14:01:06 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 07:01:06 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 1/2] btrfs: Consider system chunk array size for new
 SYSTEM chunks
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190828023313.22417-1-wqu@suse.com>
Message-ID: <47068de6-cf88-f243-437d-7383ad239179@oracle.com>
Date:   Tue, 10 Sep 2019 22:01:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190828023313.22417-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100138
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/8/19 10:33 AM, Qu Wenruo wrote:
> For SYSTEM chunks, despite the regular chunk item size limit, there is
> another limit due to system chunk array size.
> 
> The extra limit is removed in a refactor, so just add it back.
> 
> Fixes: e3ecdb3fdecf ("btrfs: factor out devs_max setting in __btrfs_alloc_chunk")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a447d3ec48d5..8b72d03738d9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4966,6 +4966,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
>   		max_stripe_size = SZ_32M;
>   		max_chunk_size = 2 * max_stripe_size;
> +		devs_max = min_t(int, devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


>   	} else {
>   		btrfs_err(info, "invalid chunk type 0x%llx requested",
>   		       type);
> 

