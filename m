Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E477C5DD76
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 06:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfGCEQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 00:16:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfGCEQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jul 2019 00:16:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x634EW2e132378;
        Wed, 3 Jul 2019 04:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cieF/VfyHdRT4ILhLIDgDEcOp5SHASOypt87NV9hXi8=;
 b=lnZDhwTIrEoxdyTKuaD+K/BQoICCtZH9vCxO67xkMjnAyhpbGdHlrw7kHJK/Zbn7vQQq
 mvmVh0oBzt1wU8NE7fuRPsvxSUAQYmmDus5jqhqy4cs3J4RpB6UCGEKG5dAO8dfx4MkW
 ssTG95OcfbL+QJ7TOrHMwZ88nBOMAbnlVbHUMY0selBb5xrg9H7bZ7Cj9qcUFNomoEo3
 KiNNTZ8GUvUkfgAbXLC1jTb8+PfvJ+xR0roeqzJyr133gZ3mxmzSadnZegStWNU26oSk
 77iFaFJerJx8z/vPnI0sJmFVKFPOnDeucEO3zPdKh4DGYatbjOVDQg+a1znqy7NsDhU1 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tbq1pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 04:16:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x634CxOO103081;
        Wed, 3 Jul 2019 04:16:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebkumtf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 04:16:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x634GrZH003044;
        Wed, 3 Jul 2019 04:16:53 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 21:16:53 -0700
Subject: Re: [PATCH][next] btrfs: fix memory leak of path on error return path
To:     Colin King <colin.king@canonical.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190702141028.11566-1-colin.king@canonical.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2e750263-c61a-cda4-a647-f1913b548c33@oracle.com>
Date:   Wed, 3 Jul 2019 12:16:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190702141028.11566-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030052
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/19 10:10 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the allocation of roots or tmp_ulist fails the error handling
> does not free up the allocation of path causing a memory leak. Fix this by
> freeing path with a call to btrfs_free_path before taking the error return
> path.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 5911c8fe05c5 ("btrfs: fiemap: preallocate ulists for btrfs_check_shared")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/extent_io.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1eb671c16ff1..d7f37a33d597 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4600,6 +4600,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	tmp_ulist = ulist_alloc(GFP_KERNEL);
>   	if (!roots || !tmp_ulist) {
>   		ret = -ENOMEM;
> +		btrfs_free_path(path);
>   		goto out_free_ulist;
>   	}
>   
> 

