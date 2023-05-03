Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37B6F4F97
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 06:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjECEsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 00:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjECEsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 00:48:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57736449C
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 21:47:55 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1pviIL38vm-001hpB; Wed, 03
 May 2023 06:47:44 +0200
Message-ID: <f488fc4e-3a5b-c3f6-1958-25f91c9d378e@gmx.com>
Date:   Wed, 3 May 2023 12:47:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/9] btrfs: auto hierarchy for simple qgroups of nested
 subvols
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
 <b311f17d76094253b5b38be3ea845438628f17ad.1683075170.git.boris@bur.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b311f17d76094253b5b38be3ea845438628f17ad.1683075170.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lGpKcQjhV2hvMCvfce2bbPXh/cjcbgKZN4wp841XenAXEb8r0wD
 fBclpawtX63DcGAAAJMSvtzwhBsESrztGmFfLCC+ryuKWlCNcqSKuPpAK3jZtWy1mtnF8bd
 lUyQL01N+k4JmJSVJm4Z0dqCumGLP6gi6+JyzNznFdWlui9GEmt7ZHgTAOfPtLAJb3hyxvk
 oetQ1XPN6PEvC6/d3zmIQ==
UI-OutboundReport: notjunk:1;M01:P0:0UKLeHzHvmw=;NF9X69U1uD1tRKwR1735nmQ9DbM
 yA/z0febl/BQPK8NjldrOKxu81Zm/mFMmdLJwB3qjf74d2yRNTFOE9QY9KC9jf/V6wo1+3Eue
 kDW/lfX5aROgngwk7tHmj6q/B62LgztqU0IEp3jar5+PObWDGICrmoOAZY1x/jSBXhc4Zdp2r
 5mh4lIvxqV9uPrKAvTCo24e7kzQp7XGLKfiP7+uBIzwgRauKG7kSRb42OYjUUiSs4Z81IQCfL
 FFtR8oQd0YVtsWDWmVH1LYSCDHPzVbzP6svkyzvDIMJxmRJET4D66ZSg9WiwumJG5m0MXbj0d
 pxVYvQk3vp0Hx49v0ytBjod5qGkmVrTUlubldW+nkDDfOAnZTFQXnVAgTiKRcNRwsQg2wzLVt
 RJuzpi09FbPBrYFjtp9Of3T35a+1vb+Ms3EopLmS84l9yC4nZT5PZfbE9M0JuEBrIMnCptmR4
 6BgFC6wPm2zfuz55xlYqROogJjI6421s0YCBYh9qqGhAL1tjxV5Jj7bPWam1yqMqPjYNclZYR
 Y2yI33JiIqY3MBRvhDIOvH08Dp6nLONqgn6Penl28MgaWUlCUVzZL4oJrmvvzMtsEHcvm7W3+
 RqszvJnUHBPZXZdjeXNIRqhw55G77rKqaUhNHBHPTshbtuZP/xHRvRUblO2EhbfH5rThsDI1B
 iFYb3dWReu4JY4ZELtg6vmIkGpjuABBj7G1sXz60LwR2yP3i6BMlP+Khu8MG71YeQhVRpTxgK
 OUr2Abxus0c5gW2hF5rh31yNI2FNLxp+Jb3V33sU+17TS9VcbUJ49W+lkqr5XEqWks8WB16re
 Ne1tGVJWsDEX77oMkzhwE/ss0j8cYnBZKKdsyQWMzN/yrjQjYbRUbIAK122PPeDw7Kqb76WUT
 OedDf5NpuftWWfZBBP4T79FCg+2md76d3xScdQIt7UJUjFia+ecqd5bIw1Aog9QPyNrSDZInt
 9lcrh6jh8n104j8blTYHheMNylQ=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/3 08:59, Boris Burkov wrote:
> Consider the following sequence:
> - enable quotas
> - create subvol S id 256 at dir outer/
> - create a qgroup 1/100
> - add 0/256 (S's auto qgroup) to 1/100
> - create subvol T id 257 at dir outer/inner/
> 
> With full qgroups, there is no relationship between 0/257 and either of
> 0/256 or 1/100. There is an inherit feature that the creator of inner/
> can use to specify it ought to be in 1/100.
> 
> Simple quotas are targeted at container isolation, where such automatic
> inheritance for not necessarily trusted/controlled nested subvol
> creation would be quite helpful. Therefore, add a new default behavior
> for simple quotas: when you create a nested subvol, automatically
> inherit as parents any parents of the qgroup of the subvol the new inode
> is going in.
> 
> In our example, 257/0 would also be under 1/100, allowing easy control
> of a total quota over an arbitrary hierarchy of subvolumes.
> 
> I think this _might_ be a generally useful behavior, so it could be
> interesting to put it behind a new inheritance flag that simple quotas
> always use while traditional quotas let the user specify, but this is a
> minimally intrusive change to start.

I'm not sure if the automatically qgroup inherit is a good idea.

Consider the following case, a subvolume is created under another 
subvolume, then it got inherited into qgroup 1/0.

But don't forget that a subvolume can be easily moved to other 
directory, should we also change which qgroup it belongs to?


Another point is, if a container manager tool wants to do the same 
inherit behavior, it's not that hard to query the owner group of the 
parent directory, then pass "-i" option for "btrfs subvolume create" or 
"btrfs subvolume snapshot" commands.

As the old saying goes, kernel should only provide a mechanism, not a 
policy. To me, automatically inherit qgroup owner looks more like a policy.

Thanks,
Qu

> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/ioctl.c       |  2 +-
>   fs/btrfs/qgroup.c      | 46 +++++++++++++++++++++++++++++++++++++++---
>   fs/btrfs/qgroup.h      |  6 +++---
>   fs/btrfs/transaction.c |  2 +-
>   4 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ca7d2ef739c8..4d6d28feb5c6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -652,7 +652,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>   	/* Tree log can't currently deal with an inode which is a new root. */
>   	btrfs_set_log_full_commit(trans);
>   
> -	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
> +	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
>   	if (ret)
>   		goto out;
>   
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index e3d0630fef0c..6816e01f00b5 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1504,8 +1504,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
>   	return ret;
>   }
>   
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> -			      u64 dst)
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
>   {
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_qgroup *parent;
> @@ -2945,6 +2944,42 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>   	return ret;
>   }
>   
> +static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
> +			       u64 inode_rootid,
> +			       struct btrfs_qgroup_inherit **inherit)
> +{
> +	int i = 0;
> +	u64 num_qgroups = 0;
> +	struct btrfs_qgroup *inode_qg;
> +	struct btrfs_qgroup_list *qg_list;
> +
> +	if (*inherit)
> +		return -EEXIST;
> +
> +	inode_qg = find_qgroup_rb(fs_info, inode_rootid);
> +	if (!inode_qg)
> +		return -ENOENT;
> +
> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> +		++num_qgroups;
> +	}
> +
> +	if (!num_qgroups)
> +		return 0;
> +
> +	*inherit = kzalloc(sizeof(**inherit) + num_qgroups * sizeof(u64), GFP_NOFS);
> +	if (!*inherit)
> +		return -ENOMEM;
> +	(*inherit)->num_qgroups = num_qgroups;
> +
> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> +		u64 qg_id = qg_list->group->qgroupid;
> +		*((u64 *)((*inherit)+1) + i) = qg_id;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Copy the accounting information between qgroups. This is necessary
>    * when a snapshot or a subvolume is created. Throwing an error will
> @@ -2952,7 +2987,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>    * when a readonly fs is a reasonable outcome.
>    */
>   int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
> +			 u64 objectid, u64 inode_rootid,
> +			 struct btrfs_qgroup_inherit *inherit)
>   {
>   	int ret = 0;
>   	int i;
> @@ -2994,6 +3030,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		goto out;
>   	}
>   
> +	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
> +
>   	if (inherit) {
>   		i_qgroups = (u64 *)(inherit + 1);
>   		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
> @@ -3020,6 +3059,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   	if (ret)
>   		goto out;
>   
> +
>   	/*
>   	 * add qgroup to all inherited groups
>   	 */
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index b300998dcbc7..aecebe9d0d62 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -272,8 +272,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
>   void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
>   int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
>   				     bool interruptible);
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> -			      u64 dst);
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
>   int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>   			      u64 dst);
>   int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
> @@ -367,7 +366,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>   int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
>   int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
>   int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit);
> +			 u64 objectid, u64 inode_rootid,
> +			 struct btrfs_qgroup_inherit *inherit);
>   void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
>   			       u64 ref_root, u64 num_bytes,
>   			       enum btrfs_qgroup_rsv_type type);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 0edfb58afd80..6befcf1b4b1f 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1557,7 +1557,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>   
>   	/* Now qgroup are all updated, we can inherit it to new qgroups */
>   	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
> -				   inherit);
> +				   parent->root_key.objectid, inherit);
>   	if (ret < 0)
>   		goto out;
>   
