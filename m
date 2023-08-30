Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B96878E205
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 00:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbjH3WDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 18:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244215AbjH3WDC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 18:03:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31777FB
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 15:02:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B22115C0003;
        Wed, 30 Aug 2023 18:01:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 30 Aug 2023 18:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1693432882; x=1693519282; bh=/U
        e9cgPRlNmDI3ITBwzEr9+BZRw7qwTzHxBLNEpviPQ=; b=AhYT4K1Lrn3wQ29lcF
        UyscQLhY30N+Ly0u9sqdRoEXMJkA8THZRaGqlhExIRvJUCEI3Ko4bx/BMUo/SVfy
        irK+3667/i5KdfQDyIROO/USlW2s3VGBKvhr+1AVIzUCn7ajuWLa8/jrHaDq9mlz
        X9C9SlBB3MqeSfjFEUcD8NejJLTR5h/Y16NiDJkfXTFpn0hJ7bZsJpcuwFtitDUz
        4WqKp16oo+RfDOCMlQxPwMkf1HeuOWuFbaE0+yInfHq5jbDHo6srgiRE5Ddh3Luv
        ZbrGkoddZOW5NoSLh44mevNE8RX7rX4C/BnUmqhlyDftwu09/exb05SK4grbjeej
        lNPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693432882; x=1693519282; bh=/Ue9cgPRlNmDI
        3ITBwzEr9+BZRw7qwTzHxBLNEpviPQ=; b=lo3N72K+YspR++F3Qw2/Vq/6PsDXv
        GeVS3gQp//8H5LqgItc+9gnXuu/dS4wpUoNH+qgefbOtnd+dQZH+kXb1dxaG5Yy1
        IMenRvb8Y2Z6jHB2jd+ZGdqOvVIBlxuAfuBVaZZUtAeDqPpTPgV5fkuvGTfSlT5O
        nbXcF2psovZEh4MpzoYuQ9L3yTrSgxfUs9gqAoZ9FW/V5vnTxmPoCC5O0um7eTaK
        BGuTd35it5EHKBzLzT+/C/vK9/WrnME5nuWokx91NedjTVR6o2XdWIPw8MhOEBw/
        c666hRJdeqCpyJ02XJjD53YdP8j3XQyXfcwqqK7SLxm8Np1i0lyVQBuNQ==
X-ME-Sender: <xms:MrzvZFA2wsf8s7X8NsmtQQ2VSR1cczBzSlYWhL07VI2wO0zcnvW20w>
    <xme:MrzvZDgcM0QOrMuxfqC6BB8RbKrr_0FaIBcvo5xEc8HOqsMc1iNRuELl8bgZkt9TO
    7y9JF2gPxCF6TdJcCE>
X-ME-Received: <xmr:MrzvZAmsHYB3Mf7GqpuOwGT63yz8YlWl8lR0MCFjF0gvt3wt2tc58Z9z-k2VM5KOvymSe4uEP4QWgz-vPZfUe6vQ5rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:MrzvZPzBYeDQB1v7cz-ODNUCY9VQyJ0W2XYGV4S0v-fvorbEJo3G8Q>
    <xmx:MrzvZKTEe_a1qoBHAq9utZzpvSXgYS1LYRY64G_JzO6znOZTrRqCrA>
    <xmx:MrzvZCaudCWGFtpDCJGxKhSXCG16sRQgIGDnPef_dNNLA7BQw1-jmg>
    <xmx:MrzvZD7hRo7X14qdLxKUFqhFVmYuK1JsGlCLupWritrFRb5oE6GBTg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 18:01:22 -0400 (EDT)
Date:   Wed, 30 Aug 2023 14:58:48 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: qgroup: iterate qgroups without memory
 allocation for qgroup_reserve()
Message-ID: <20230830215848.GA834639@zen>
References: <cover.1693391268.git.wqu@suse.com>
 <af338549020e57415b5e4079f37e05b5655991f8.1693391268.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af338549020e57415b5e4079f37e05b5655991f8.1693391268.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 30, 2023 at 06:37:23PM +0800, Qu Wenruo wrote:
> Qgroup heavily relies on ulist to go through all the involved
> qgroups, but since we're using ulist inside fs_info->qgroup_lock
> spinlock, this means we're doing a lot of GFP_ATOMIC allocation.
> 
> This patch would reduce the GFP_ATOMIC usage for qgroup_reserve() by
> eliminating the memory allocation completely.
> 
> This is done by moving the needed memory to btrfs_qgroup::iterator
> list_head, so that we can put all the involved qgroup into a on-stack list, thus
> eliminate the need to allocate memory holding spinlock.
> 
> The only cost is the slightly higher memory usage, but considering the
> reduce GFP_ATOMIC during a hot path, it should still be acceptable.
> 
> Function qgroup_reserve() is the perfect start point for this
> conversion.

This looks great, thanks! I like it more than my array/ulist hybrid
since it never allocates :)

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 68 +++++++++++++++++++++++------------------------
>  fs/btrfs/qgroup.h |  9 +++++++
>  2 files changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 74244b4bb0e9..de34e2aef710 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -216,6 +216,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
>  	INIT_LIST_HEAD(&qgroup->groups);
>  	INIT_LIST_HEAD(&qgroup->members);
>  	INIT_LIST_HEAD(&qgroup->dirty);
> +	INIT_LIST_HEAD(&qgroup->iterator);
>  
>  	rb_link_node(&qgroup->node, parent, p);
>  	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
> @@ -1367,6 +1368,25 @@ static void qgroup_dirty(struct btrfs_fs_info *fs_info,
>  		list_add(&qgroup->dirty, &fs_info->dirty_qgroups);
>  }
>  
> +static void qgroup_iterator_add(struct list_head *head, struct btrfs_qgroup *qgroup)
> +{
> +	if (!list_empty(&qgroup->iterator))
> +		return;
> +
> +	list_add_tail(&qgroup->iterator, head);
> +}
> +
> +static void qgroup_iterator_clean(struct list_head *head)
> +{
> +
> +	while (!list_empty(head)) {
> +		struct btrfs_qgroup *qgroup;
> +
> +		qgroup = list_first_entry(head, struct btrfs_qgroup, iterator);
> +		list_del_init(&qgroup->iterator);
> +	}
> +}
> +
>  /*
>   * The easy accounting, we're updating qgroup relationship whose child qgroup
>   * only has exclusive extents.
> @@ -3154,12 +3174,11 @@ static bool qgroup_check_limits(const struct btrfs_qgroup *qg, u64 num_bytes)
>  static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
>  			  enum btrfs_qgroup_rsv_type type)
>  {
> -	struct btrfs_qgroup *qgroup;
> +	struct btrfs_qgroup *cur;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	u64 ref_root = root->root_key.objectid;
>  	int ret = 0;
> -	struct ulist_node *unode;
> -	struct ulist_iterator uiter;
> +	LIST_HEAD(qgroup_list);
>  
>  	if (!is_fstree(ref_root))
>  		return 0;
> @@ -3175,53 +3194,32 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
>  	if (!fs_info->quota_root)
>  		goto out;
>  
> -	qgroup = find_qgroup_rb(fs_info, ref_root);
> -	if (!qgroup)
> +	cur = find_qgroup_rb(fs_info, ref_root);
> +	if (!cur)
>  		goto out;
>  
> -	/*
> -	 * in a first step, we check all affected qgroups if any limits would
> -	 * be exceeded
> -	 */
> -	ulist_reinit(fs_info->qgroup_ulist);
> -	ret = ulist_add(fs_info->qgroup_ulist, qgroup->qgroupid,
> -			qgroup_to_aux(qgroup), GFP_ATOMIC);
> -	if (ret < 0)
> -		goto out;
> -	ULIST_ITER_INIT(&uiter);
> -	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
> -		struct btrfs_qgroup *qg;
> +	qgroup_iterator_add(&qgroup_list, cur);
> +	list_for_each_entry(cur, &qgroup_list, iterator) {
>  		struct btrfs_qgroup_list *glist;
>  
> -		qg = unode_aux_to_qgroup(unode);
> -
> -		if (enforce && !qgroup_check_limits(qg, num_bytes)) {
> +		if (enforce && !qgroup_check_limits(cur, num_bytes)) {
>  			ret = -EDQUOT;
>  			goto out;
>  		}
>  
> -		list_for_each_entry(glist, &qg->groups, next_group) {
> -			ret = ulist_add(fs_info->qgroup_ulist,
> -					glist->group->qgroupid,
> -					qgroup_to_aux(glist->group), GFP_ATOMIC);
> -			if (ret < 0)
> -				goto out;
> -		}
> +		list_for_each_entry(glist, &cur->groups, next_group)
> +			qgroup_iterator_add(&qgroup_list, glist->group);
>  	}
> +
>  	ret = 0;
>  	/*
>  	 * no limits exceeded, now record the reservation into all qgroups
>  	 */
> -	ULIST_ITER_INIT(&uiter);
> -	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
> -		struct btrfs_qgroup *qg;
> -
> -		qg = unode_aux_to_qgroup(unode);
> -
> -		qgroup_rsv_add(fs_info, qg, num_bytes, type);
> -	}
> +	list_for_each_entry(cur, &qgroup_list, iterator)
> +		qgroup_rsv_add(fs_info, cur, num_bytes, type);
>  
>  out:
> +	qgroup_iterator_clean(&qgroup_list);
>  	spin_unlock(&fs_info->qgroup_lock);
>  	return ret;
>  }
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 7bffa10589d6..5dc0583622c3 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -220,6 +220,15 @@ struct btrfs_qgroup {
>  	struct list_head groups;  /* groups this group is member of */
>  	struct list_head members; /* groups that are members of this group */
>  	struct list_head dirty;   /* dirty groups */
> +
> +	/*
> +	 * For qgroup iteration usage.
> +	 *
> +	 * The iteration list should always be empty until
> +	 * qgroup_iterator_add() is called.
> +	 * And should be reset to empty after the iteration is finished.

Can you also add a note that this relies on global exclusion under the
qgroup spin lock?

> +	 */
> +	struct list_head iterator;
>  	struct rb_node node;	  /* tree of qgroups */
>  
>  	/*
> -- 
> 2.41.0
> 
