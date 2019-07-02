Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909EA5C876
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 06:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfGBEkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 00:40:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jul 2019 00:40:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x624dOte099569;
        Tue, 2 Jul 2019 04:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cWyVwwBwoOQENt47MIx1sYGapVGDKeaMR3vZa7rvygU=;
 b=J3HvWlTUFD9zbD39L48zfeyX3HYhPNzoYcuitY9Y4l1J4nHAbXTLn1IxlMx3GZ05ywbd
 9TwH70l8r+MVxF6qk0hZ15UpuN/t5cAlQG0hAvjB/ORRFRNyQo6xCiuBd8+qH3p4i+Mb
 2XHjfqagv6xhXu4TevXjSUi4StkS21APJtYEAaoE8QQfeG4Mbhoetx5faJ0YTAD4QbZF
 Bhb6HDgUNhFBiB0Q9EGyocVNSVMniA59xtSVq1B5K9CXhi65wvkHDb9EISw6MJGfeVap
 tGuW7WQGr+MAjYC5UqIWsTrl+gLlcphRnAki0a44xrm0Y1c9X2UQjHJHcQ7N5uY4KOg3 Aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2te61e115x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 04:40:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x624c0J0176706;
        Tue, 2 Jul 2019 04:40:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tebbjhfg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 04:40:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x624e5BC022106;
        Tue, 2 Jul 2019 04:40:05 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 21:40:05 -0700
Subject: Re: [PATCH 2/2] btrfs: Move free_pages_out label in inline extent
 handling branch in compress_file_range
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190701165055.15483-1-nborisov@suse.com>
 <20190701165055.15483-2-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e69a9a0c-7c0e-36dc-7f9e-697a83e5523b@oracle.com>
Date:   Tue, 2 Jul 2019 12:39:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701165055.15483-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/19 12:50 AM, Nikolay Borisov wrote:
> This label is only executed if compress_file_range fails to create an
> inline extent. So move its code in the semantically related inline
> extent handling branch. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/inode.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3b0bf5ea9eb6..072a300f8487 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -600,7 +600,14 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>   						     PAGE_SET_WRITEBACK |
>   						     page_error_op |
>   						     PAGE_END_WRITEBACK);
> -			goto free_pages_out;
> +
> +			for (i = 0; i < nr_pages; i++) {
> +				WARN_ON(pages[i]->mapping);
> +				put_page(pages[i]);
> +			}
> +			kfree(pages);
> +
> +			return 0;
>   		}
>   	}
>   
> @@ -678,15 +685,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>   	compressed_extents += 1;
>   
>   	return compressed_extents;
> -
> -free_pages_out:
> -	for (i = 0; i < nr_pages; i++) {
> -		WARN_ON(pages[i]->mapping);
> -		put_page(pages[i]);
> -	}
> -	kfree(pages);
> -
> -	return 0;
>   }
>   
>   static void free_async_extent_pages(struct async_extent *async_extent)
> 

