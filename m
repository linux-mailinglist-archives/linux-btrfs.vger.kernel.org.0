Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF379741C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbjIGPfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbjIGPcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 11:32:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815471FE5
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 08:32:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DEB9A21870;
        Thu,  7 Sep 2023 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694087591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mSWy/o6gcv6wq+9Jgr/Mcb0vkzeQsZDog6MWuL/Asw=;
        b=hLx133LrLqTbt8hrOMzNnaZqSpNd+YsaPLRwP+3hRIL0eX7m1OLeJYJI65BrgXJfp7Co8/
        R97x4uP3BWQGP66M0e6QxTyuhPRIYd2oMt+tsPfdXERKjVQIknXBVti4hzh88HdEXvpOEM
        YER3YnxLTu6dxv1VFM0tHTb6LpzM4Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694087591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mSWy/o6gcv6wq+9Jgr/Mcb0vkzeQsZDog6MWuL/Asw=;
        b=+EAg8wMVHh7aZ6Sc0Q5lptVTzaeKbpX/Q+nu+WHmUf9WQUDNzIo+qHgs8dDJ9Quh/vhWZt
        aKJqCngqxbDZPjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4774138F9;
        Thu,  7 Sep 2023 11:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XCU5K6e5+WRSCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 11:53:11 +0000
Date:   Thu, 7 Sep 2023 13:46:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 07/18] btrfs: function for recording simple quota
 deltas
Message-ID: <20230907114639.GF3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <85ff3dcd358a340f89e93a09eafd02e051944bcd.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ff3dcd358a340f89e93a09eafd02e051944bcd.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:54PM -0700, Boris Burkov wrote:
> Rather than re-computing shared/exclusive ownership based on backrefs
> and walking roots for implicit backrefs, simple quotas does an increment
> when creating an extent and a decrement when deleting it. Add the API
> for the extent item code to use to track those events.
> 
> Also add a helper function to make collecting parent qgroups in a ulist
> easier for functions like this.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/qgroup.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/qgroup.h | 11 ++++++-
>  2 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8e3a4ced3077..dedc532669f4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -332,6 +332,35 @@ static int del_relation_rb(struct btrfs_fs_info *fs_info,
>  	return -ENOENT;
>  }
>  
> +static int qgroup_collect_parents(struct btrfs_qgroup *qgroup,
> +				  struct ulist *ul)
> +{
> +	struct ulist_iterator uiter;
> +	struct ulist_node *unode;
> +	struct btrfs_qgroup_list *glist;
> +	struct btrfs_qgroup *qg;
> +	int ret = 0;
> +
> +	ulist_reinit(ul);
> +	ret = ulist_add(ul, qgroup->qgroupid,
> +			qgroup_to_aux(qgroup), GFP_ATOMIC);

Qu has sent a series to get rid of the GFP_ATOMIC allocations when
processing qgruops, so this would be good to port to the qgroup
iterators as well but it's a recent change and can be done later as an
optimization.

> +	if (ret < 0)
> +		goto out;
> +	ULIST_ITER_INIT(&uiter);
> +	while ((unode = ulist_next(ul, &uiter))) {
> +		qg = unode_aux_to_qgroup(unode);
> +		list_for_each_entry(glist, &qg->groups, next_group) {
> +			ret = ulist_add(ul, glist->group->qgroupid,
> +					qgroup_to_aux(glist->group), GFP_ATOMIC);
> +			if (ret < 0)
> +				goto out;
> +		}
> +	}
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
>  			       u64 rfer, u64 excl)
> @@ -4535,3 +4564,47 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
>  	}
>  	*root = RB_ROOT;
>  }
> +
> +int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,

You can abbreviate all the 'simple_quota' in identifiers as 'squota'.

> +				    struct btrfs_simple_quota_delta *delta)
> +{
> +	int ret;
> +	struct ulist *ul = fs_info->qgroup_ulist;
> +	struct btrfs_qgroup *qgroup;
> +	struct ulist_iterator uiter;
> +	struct ulist_node *unode;
> +	struct btrfs_qgroup *qg;
> +	u64 root = delta->root;
> +	u64 num_bytes = delta->num_bytes;
> +	int sign = delta->is_inc ? 1 : -1;

	const int sign = (delta->is_inc ? 1 : -1);

> +
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
> +		return 0;
> +
> +	if (!is_fstree(root))
> +		return 0;
> +
> +	spin_lock(&fs_info->qgroup_lock);
> +	qgroup = find_qgroup_rb(fs_info, root);
> +	if (!qgroup) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	ret = qgroup_collect_parents(qgroup, ul);
> +	if (ret)
> +		goto out;
> +
> +	ULIST_ITER_INIT(&uiter);
> +	while ((unode = ulist_next(ul, &uiter))) {
> +		qg = unode_aux_to_qgroup(unode);
> +		qg->excl += num_bytes * sign;
> +		qg->rfer += num_bytes * sign;
> +		qgroup_dirty(fs_info, qg);
> +	}
> +
> +out:
> +	spin_unlock(&fs_info->qgroup_lock);
> +	if (!ret && delta->rsv_bytes)
> +		btrfs_qgroup_free_refroot(fs_info, root, delta->rsv_bytes, BTRFS_QGROUP_RSV_DATA);
> +	return ret;
> +}
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index d4c4d039585f..94d85b4fbebd 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -235,6 +235,14 @@ struct btrfs_qgroup {
>  	struct kobject kobj;
>  };
>  
> +struct btrfs_simple_quota_delta {

struct btrfs_squota_delta

> +	u64 root; /* The fstree root this delta counts against */
> +	u64 num_bytes; /* The number of bytes in the extent being counted */
> +	u64 rsv_bytes; /* The number of bytes reserved for this extent */
> +	bool is_inc; /* Whether we are using or freeing the extent */
> +	bool is_data; /* Whether the extent is data or metadata */

Please put the comments on separate lines before the struct member definitions.

> +};
> +
>  static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
>  {
>  	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
> @@ -447,5 +455,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
>  		struct btrfs_root *root, struct extent_buffer *eb);
>  void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
>  bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
> -
> +int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_simple_quota_delta *delta);

Please keep the newline before the last #endif

>  #endif
> -- 
> 2.41.0
