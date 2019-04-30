Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147F0FAEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfD3OCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Apr 2019 10:02:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49012 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3OCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Apr 2019 10:02:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UDwhvd028510;
        Tue, 30 Apr 2019 14:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7t4cXA+FAjgwb/KRMkrSNcBRtGTfXnhPrSU+1XcTGW8=;
 b=VOM38G5xqIeCgSIQbnciF2Lt+7fSvtYMy4l9vDXBKFFElJHCrXWVleQ8ezT6U+2kZODB
 jutehqd4PhZJIJooK3/1oE6xve6kXj/tXvXgkH1MjF7mlY1T1JHE/U3ITx5MsKDGFn/9
 8cUzSQdnqoB7GEct33vS3VeUBNVoSu8aWOds0nZgDIiBN6IYVORrKBqxCEGKH5HzKDki
 w79l/tpa8x/lySnBMvBptxYb/ZwHtvG57L5u32NDELPhd0hXILmQqFD4tmVjF2MZ0kzQ
 tb2ReeoZ+4K8KBzJDlD2nBgktJsVaShz2HB/w0SfKQFe21jiCJHZSwaZCbJkLUlB/Wk8 tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s5j5u1dme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:02:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UE0jMa066027;
        Tue, 30 Apr 2019 14:02:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2s4ew18nu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:02:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UE2JmR003838;
        Tue, 30 Apr 2019 14:02:19 GMT
Received: from [192.168.1.119] (/116.87.143.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 07:02:19 -0700
Subject: Re: [PATCH] Btrfs: do not abort transaction at btrfs_update_root()
 after failure to COW path
To:     fdmanana@kernel.org
References: <20190429120814.8638-1-fdmanana@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <7d937cda-b5e0-c253-da3c-2328ddc85ac8@oracle.com>
Date:   Tue, 30 Apr 2019 22:02:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190429120814.8638-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=707
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=782 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300089
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/4/19 8:08 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently when we fail to COW a path at btrfs_update_root() we end up
> always aborting the transaction. However all the current callers of
> btrfs_update_root() are able to deal with errors returned from it, many do
> end up aborting the transaction themselves (directly or not, such as the
> transaction commit path), other BUG_ON() or just gracefully cancel whatever
> they were doing.
> 
> When syncing the fsync log, we call btrfs_update_root() through
> tree-log.c:update_log_root(), and if it returns an -ENOSPC error, the log
> sync code does not abort the transaction, instead it gracefully handles
> the error and returns -EAGAIN to the fsync handler, so that it falls back
> to a transaction commit. Any other error different from -ENOSPC, makes the
> log sync code abort the transaction.
> 
> So remove the transaction abort from btrfs_update_log() when we fail to
> COW a path to update the root item, so that if an -ENOSPC failure happens
> we avoid aborting the current transaction and have a chance of the fsync
> succeeding after falling back to a transaction commit.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203413
> Fixes: 79787eaab46121 ("btrfs: replace many BUG_ONs with proper error handling")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/root-tree.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 893d12fbfda0..1a92ad546f91 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -132,10 +132,8 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
>   		return -ENOMEM;
>   
>   	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
> -	if (ret < 0) {
> -		btrfs_abort_transaction(trans, ret);
> +	if (ret < 0)
>   		goto out;
> -	}
>   
>   	if (ret != 0) {
>   		btrfs_print_leaf(path->nodes[0]);
> 

