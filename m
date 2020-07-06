Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94742158B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgGFNlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGFNlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:41:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB3C061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:41:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e12so28894839qtr.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Rx656C5l7n4RyHVzxpZOSTdGQ3qQFauMp7QEiwDm3LA=;
        b=UOfZGYwyFhP5Hh0qm8lVbINVRsS30gcqRnuzztCdnzYXrckRWd8GVP8ndd4ZklFuL8
         A2psuhvR4HdQOR+IQGTlWr6AJS3PmhFSII+iVD1pZdF3b7oDnKjc9HtU8sj2qgntbjfi
         4ISLjYGeWzNVw5+UPC9jpz8iLrxFpKVnjSP1+BlMrikgn3zpKyAOKEn3eh1j/F2JUIT4
         UchH+wWLQo4t4XebNeMaRWtsfnBb5u3Y+fy2y1JHMvV3fSZvxcHi7q7w6u2krYETvNOY
         MWVfAc0u2il+LxBzkBCiMKC1FNrwe4rgOyirQaTpgKHiA07aHRqnFIid9r8B3ulGG1Ta
         /C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rx656C5l7n4RyHVzxpZOSTdGQ3qQFauMp7QEiwDm3LA=;
        b=ZRmGUofIE1IQBai+aJuFgMoXM2lSdf9qhGuh4ezB8XbQ17PgF8hvZlYTBK5n2eoQ7Z
         vzetPkcrlm4c8TpZ+rxHcuHJaBpmDbZmGzs2pojOsLlqlBZ0TDQmqRLSzvuUq7yOWTuI
         vGNgbI3I0neNN8nEMtkI/SHfIJReCoYXqPHi5g5mI6P54ewCokkArU0uJsBz021kKqlc
         931OctSJxqxAt4Ql6J2aQvtwlsazJvKLWMRLh1IF10KNHF1Y0AKh3PBG6sWnyPxDihsw
         CamotzFr+EMSSH0wDK7k6QbQzxl1GRi3TXqrRiEB6V+OTaAbK5DAW4hoUtCRcmIaKh0g
         hxaw==
X-Gm-Message-State: AOAM533YProv3URCCSBQvGPGRBzpJryfcxtxTs0BLzNGIiRQ9RbfKZ87
        K9iEppk9dbuqrBqGd9ZCdhMSKxIKslJNkw==
X-Google-Smtp-Source: ABdhPJwuKfc/yEAJXOMBnboQ8/d1TZZl6hDUYaDRe/yscMTkecWVKoCTQ6JgbLJFRFvtkmADUK8cZQ==
X-Received: by 2002:aed:25fd:: with SMTP id y58mr49162761qtc.310.1594042910202;
        Mon, 06 Jul 2020 06:41:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y67sm16641042qka.101.2020.07.06.06.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:41:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] btrfs: qgroup: Try to flush qgroup space when we
 get -EDQUOT
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200703061902.33350-1-wqu@suse.com>
 <20200703061902.33350-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3248eb25-5558-f5be-e15b-a16d39dd0cb1@toxicpanda.com>
Date:   Mon, 6 Jul 2020 09:41:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703061902.33350-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/3/20 2:19 AM, Qu Wenruo wrote:
> [PROBLEM]
> There are known problem related to how btrfs handles qgroup reserved
> space.
> One of the most obvious case is the the test case btrfs/153, which do
> fallocate, then write into the preallocated range.
> 
>    btrfs/153 1s ... - output mismatch (see xfstests-dev/results//btrfs/153.out.bad)
>        --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
>        +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01 20:24:40.730000089 +0800
>        @@ -1,2 +1,5 @@
>         QA output created by 153
>        +pwrite: Disk quota exceeded
>        +/mnt/scratch/testfile2: Disk quota exceeded
>        +/mnt/scratch/testfile2: Disk quota exceeded
>         Silence is golden
>        ...
>        (Run 'diff -u xfstests-dev/tests/btrfs/153.out xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
> we always reserve space no matter if it's COW or not.
> 
> Such behavior change is mostly for performance, and reverting it is not
> a good idea anyway.
> 
> For preallcoated extent, we reserve qgroup data space for it already,
> and since we also reserve data space for qgroup at buffered write time,
> it needs twice the space for us to write into preallocated space.
> 
> This leads to the -EDQUOT in buffered write routine.
> 
> And we can't follow the same solution, unlike data/meta space check,
> qgroup reserved space is shared between data/meta.
> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
> check after qgroup reservation failure is not a solution.
> 
> [FIX]
> To solve the problem, we don't return -EDQUOT directly, but every time
> we got a -EDQUOT, we try to flush qgroup space by:
> - Flush all inodes of the root
>    NODATACOW writes will free the qgroup reserved at run_dealloc_range().
>    However we don't have the infrastructure to only flush NODATACOW
>    inodes, here we flush all inodes anyway.
> 
> - Wait ordered extents
>    This would convert the preallocated metadata space into per-trans
>    metadata, which can be freed in later transaction commit.
> 
> - Commit transaction
>    This will free all per-trans metadata space.
> 
> Also we don't want to trigger flush too racy, so here we introduce a
> per-root mutex to ensure if there is a running qgroup flushing, we wait
> for it to end and don't start re-flush.
> 
> Fixes: c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ctree.h   |   1 +
>   fs/btrfs/disk-io.c |   1 +
>   fs/btrfs/qgroup.c  | 118 ++++++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 108 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4dd478b4fe3a..891f47c7891f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1162,6 +1162,7 @@ struct btrfs_root {
>   	spinlock_t qgroup_meta_rsv_lock;
>   	u64 qgroup_meta_rsv_pertrans;
>   	u64 qgroup_meta_rsv_prealloc;
> +	struct mutex qgroup_flushing_mutex;
>   
>   	/* Number of active swapfiles */
>   	atomic_t nr_swapfiles;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c27022f13150..0116e0b487c9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1116,6 +1116,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
>   	mutex_init(&root->log_mutex);
>   	mutex_init(&root->ordered_extent_mutex);
>   	mutex_init(&root->delalloc_mutex);
> +	mutex_init(&root->qgroup_flushing_mutex);
>   	init_waitqueue_head(&root->log_writer_wait);
>   	init_waitqueue_head(&root->log_commit_wait[0]);
>   	init_waitqueue_head(&root->log_commit_wait[1]);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 398de1145d2b..bf9076bc33eb 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3481,13 +3481,14 @@ static int qgroup_revert(struct btrfs_inode *inode,
>   		int clear_ret;
>   
>   		entry = rb_entry(n, struct ulist_node, rb_node);
> -		if (entry->val >= start + len)
> -			break;
> -		if (entry->val + entry->aux <= start)
> -			goto next;
>   		start = entry->val;
>   		end = entry->aux;
>   		len = end - start + 1;
> +
> +		if (start >= start + len)
> +			break;
> +		if (start + len <= start)
> +			goto next;

This is unrelated to the change at hand, put this in the 1st patch.

>   		/*
>   		 * Now the entry is in [start, start + len), revert the
>   		 * EXTENT_QGROUP_RESERVED bit.
> @@ -3512,17 +3513,62 @@ static int qgroup_revert(struct btrfs_inode *inode,
>   }
>   
>   /*
> - * Reserve qgroup space for range [start, start + len).
> + * Try to free some space for qgroup.
>    *
> - * This function will either reserve space from related qgroups or doing
> - * nothing if the range is already reserved.
> + * For qgroup, there are only 3 ways to free qgroup space:
> + * - Flush nodatacow write
> + *   Any nodatacow write will free its reserved data space at
> + *   run_delalloc_range().
> + *   In theory, we should only flush nodatacow inodes, but it's
> + *   not yet possible, so we need to flush the whole root.
>    *
> - * Return 0 for successful reserve
> - * Return <0 for error (including -EQUOT)
> + * - Wait for ordered extents
> + *   When ordered extents are finished, their reserved metadata
> + *   is finally converted to per_trans status, which can be freed
> + *   by later commit transaction.
>    *
> - * NOTE: this function may sleep for memory allocation.
> + * - Commit transaction
> + *   This would free the meta_per_trans space.
> + *   In theory this shouldn't provide much space, but any more qgroup space
> + *   is needed.
>    */
> -int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
> +static int try_flush_qgroup(struct btrfs_root *root)
> +{
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	if (!is_fstree(root->root_key.objectid))
> +		return 0;
> +

This will just retry the reservation again without having done anything.  Is it 
even possible to end up here with a !fs_tree?  If it is then maybe we should 
return -EDQUOT here so we don't retry the reservation again.

> +	/*
> +	 * We don't want to run flush again and again, so if there is a running
> +	 * one, we won't try to start a new flush, but exit directly.
> +	 */
> +	ret = mutex_trylock(&root->qgroup_flushing_mutex);
> +	if (!ret) {
> +		mutex_lock(&root->qgroup_flushing_mutex);
> +		mutex_unlock(&root->qgroup_flushing_mutex);
> +		return 0;
> +	}
> +
> +	ret = btrfs_start_delalloc_snapshot(root);
> +	if (ret < 0)
> +		goto unlock;
> +	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
> +
> +	trans = btrfs_join_transaction(root);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		goto unlock;
> +	}
> +
> +	ret = btrfs_commit_transaction(trans);
> +unlock:
> +	mutex_unlock(&root->qgroup_flushing_mutex);
> +	return ret;
> +}

I still hate this but implementing tickets for quotas probably doesn't make 
sense right now.

<snip>

> +
> +	ret = qgroup_reserve_meta(root, num_bytes, type, enforce);
> +	if (!ret)
> +		return ret;
> +	if (ret < 0 && ret != -EDQUOT)
> +		return ret;

if (ret <= 0 && ret != -EDQUOT)
	return ret;

Thanks,

Josef
