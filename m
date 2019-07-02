Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD91B5C877
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 06:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGBEky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 00:40:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEkx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jul 2019 00:40:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x624coJ0099151;
        Tue, 2 Jul 2019 04:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=72m0hSYmznJPOtRkVIV7hY/xrojx3LtgR0gmjWG+8P8=;
 b=HQhh3ZiKnp4pUzPedOieMoPQyBpsZ3DopZpSTgOP6P5+ywqpi8o4hvkSNfiPD0KLmzps
 3BTYL1vdovQJ7gMO80tl3CH1IwgTHeIYLSEldC/CKTCBl1PtWZy11kKQKUdarwX0Rok4
 rMN0LjaJHV1ijzBk4JWKUiN29jbCrB17GYVSVir2Jp38wgRpLFZSCTAYi9hFlbakRFHa
 GLYknxptumyfhyNhnoiDrv0i6xQDACfsekvf8u9RvMWXZ6Qze4U/nzYSUVag2KrbL+6L
 oxzRBmD0akwx0P//Ofa4RM2nF75AK/ux6kyHXlz56x9+ojASmc1jv+X1d0NDK9vtpOBR RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2te61e1176-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 04:40:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x624chmc047884;
        Tue, 2 Jul 2019 04:40:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tebakhese-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 04:40:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x624enGT022504;
        Tue, 2 Jul 2019 04:40:49 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 21:40:49 -0700
Subject: Re: [PATCH 1/2] btrfs: Return number of compressed extents directly
 in compress_file_range
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190701165055.15483-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <393056e8-8753-907e-5dc7-4dc4119bd1e8@oracle.com>
Date:   Tue, 2 Jul 2019 12:40:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701165055.15483-1-nborisov@suse.com>
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
> compress_file_range returns a void, yet uses a function parameter as a
> return value. Make that more idiomatic by simply returning the number
> of compressed extents directly. Also track such extents in more aptly
> named variables. No functional changes
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/inode.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4e183c2d3555..3b0bf5ea9eb6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -440,8 +440,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
>    * are written in the same order that the flusher thread sent them
>    * down.
>    */
> -static noinline void compress_file_range(struct async_chunk *async_chunk,
> -					 int *num_added)
> +static noinline int compress_file_range(struct async_chunk *async_chunk)
>   {
>   	struct inode *inode = async_chunk->inode;
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -457,6 +456,7 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
>   	int i;
>   	int will_compress;
>   	int compress_type = fs_info->compress_type;
> +	int compressed_extents = 0;
>   	int redirty = 0;
>   
>   	inode_should_defrag(BTRFS_I(inode), start, end, end - start + 1,
> @@ -619,7 +619,7 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
>   		 */
>   		total_in = ALIGN(total_in, PAGE_SIZE);
>   		if (total_compressed + blocksize <= total_in) {
> -			*num_added += 1;
> +			compressed_extents += 1;
>   
>   			/*
>   			 * The async work queues will take care of doing actual
> @@ -636,7 +636,7 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
>   				cond_resched();
>   				goto again;
>   			}
> -			return;
> +			return compressed_extents;
>   		}
>   	}
>   	if (pages) {
> @@ -675,9 +675,9 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
>   		extent_range_redirty_for_io(inode, start, end);
>   	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
>   			 BTRFS_COMPRESS_NONE);
> -	*num_added += 1;
> +	compressed_extents += 1;
>   
> -	return;
> +	return compressed_extents;
>   
>   free_pages_out:
>   	for (i = 0; i < nr_pages; i++) {
> @@ -685,6 +685,8 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
>   		put_page(pages[i]);
>   	}
>   	kfree(pages);
> +
> +	return 0;
>   }
>   
>   static void free_async_extent_pages(struct async_extent *async_extent)
> @@ -1122,12 +1124,12 @@ static noinline int cow_file_range(struct inode *inode,
>   static noinline void async_cow_start(struct btrfs_work *work)
>   {
>   	struct async_chunk *async_chunk;
> -	int num_added = 0;
> +	int compressed_extents = 0;
>   
>   	async_chunk = container_of(work, struct async_chunk, work);
>   
> -	compress_file_range(async_chunk, &num_added);
> -	if (num_added == 0) {
> +	compressed_extents = compress_file_range(async_chunk);
> +	if (compressed_extents == 0) {
>   		btrfs_add_delayed_iput(async_chunk->inode);
>   		async_chunk->inode = NULL;
>   	}
> 

