Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EC169CC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgBXD4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:56:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgBXD4W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:56:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3s0hx131696;
        Mon, 24 Feb 2020 03:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Prwns41aZe5scg4CzMqwIYEhl2oRlHHmw8JUOEr3pZY=;
 b=mvtKdXY0B5rWviv6tXfOiBOyGDpxIjCNXxmbA6eDmc/DiG9NsfG81sfaIIymkymwkbkV
 pddxXKeoknHNd/BAdjrrWrgJwFL+mJnybMbeI9b3O+rRKrnjrUDo2RZzMBo6DDFJBPz3
 bxjssnv6qdI1a5r8fYBGkR/tP9wmrUjYejvAn50q46IBjPkFzngPR+o1pU9O29ZnfOpL
 HJSCxJa93JQi/d32SaC1Jd36s0wHXweBRuZo0/dMLyqok0VRliq+T2kJly6nO+GpeAPW
 163p9FQ3f8PmyOoe8aU5tIgP98OrDy1bST7wAP/qGvxxYtchrdWwKPUCO7k1d+HyBi3C Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ybvr4h0mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:56:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3q1Qg127350;
        Mon, 24 Feb 2020 03:56:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe106gw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:56:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01O3uGEU031902;
        Mon, 24 Feb 2020 03:56:16 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 19:56:16 -0800
Subject: Re: [PATCH 10/11] btrfs: merge unlocking to common exit block in
 btrfs_commit_transaction
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582302545.git.dsterba@suse.com>
 <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b011fa16-bfd3-674a-b067-d98ad6551858@oracle.com>
Date:   Mon, 24 Feb 2020 11:56:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240031
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/22/20 12:31 AM, David Sterba wrote:
> The tree_log_mutex and reloc_mutex locks are properly nested so we can
> simplify error handling and add labels for them. This reduces line count
> of the function.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/transaction.c | 57 +++++++++++++++---------------------------
>   1 file changed, 20 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index fdfdfc426539..3610b6fec627 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2194,10 +2194,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	 * core function of the snapshot creation.
>   	 */
>   	ret = create_pending_snapshots(trans);
> -	if (ret) {
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret)
> +		goto unlock_reloc;
>   
>   	/*
>   	 * We insert the dir indexes of the snapshots and update the inode
> @@ -2210,16 +2208,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	 * the nodes and leaves.
>   	 */
>   	ret = btrfs_run_delayed_items(trans);
> -	if (ret) {
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret)
> +		goto unlock_reloc;
>   
>   	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
> -	if (ret) {
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret)
> +		goto unlock_reloc;
>   
>   	/*
>   	 * make sure none of the code above managed to slip in a
> @@ -2245,11 +2239,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	mutex_lock(&fs_info->tree_log_mutex);
>   
>   	ret = commit_fs_roots(trans);
> -	if (ret) {
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret)
> +		goto unlock_reloc;

                goto unlock_tree_log;


Otherwise looks good. When fixed this you may add.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

>   	/*
>   	 * Since the transaction is done, we can apply the pending changes
> @@ -2267,29 +2258,20 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	 * new delayed refs. Must handle them or qgroup can be wrong.
>   	 */
>   	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
> -	if (ret) {
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret)
> +		goto unlock_tree_log;
>   
>   	/*
>   	 * Since fs roots are all committed, we can get a quite accurate
>   	 * new_roots. So let's do quota accounting.
>   	 */
>   	ret = btrfs_qgroup_account_extents(trans);
> -	if (ret < 0) {
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret < 0)
> +		goto unlock_tree_log;
>   
>   	ret = commit_cowonly_roots(trans);
> -	if (ret) {
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> -	}
> +	if (ret)
> +		goto unlock_tree_log;
>   
>   	/*
>   	 * The tasks which save the space cache and inode cache may also
> @@ -2297,9 +2279,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	 */
>   	if (TRANS_ABORTED(cur_trans)) {
>   		ret = cur_trans->aborted;
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		mutex_unlock(&fs_info->reloc_mutex);
> -		goto scrub_continue;
> +		goto unlock_tree_log;
>   	}
>   
>   	btrfs_prepare_extent_commit(fs_info);
> @@ -2346,8 +2326,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	if (ret) {
>   		btrfs_handle_fs_error(fs_info, ret,
>   				      "Error while writing out transaction");
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		goto scrub_continue;
> +		goto unlock_tree_log;
>   	}
>   
>   	ret = write_all_supers(fs_info, 0);
> @@ -2394,6 +2373,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   
>   	return ret;
>   
> +unlock_tree_log:
> +	mutex_unlock(&fs_info->tree_log_mutex);
> +unlock_reloc:
> +	mutex_unlock(&fs_info->reloc_mutex);
>   scrub_continue:
>   	btrfs_scrub_continue(fs_info);
>   cleanup_transaction:
> 

