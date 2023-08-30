Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09E78E229
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbjH3WNZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 18:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbjH3WNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 18:13:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D41A8
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 15:12:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 698DC5C00A5;
        Wed, 30 Aug 2023 18:11:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 30 Aug 2023 18:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1693433513; x=1693519913; bh=II
        kDh8Uf9EvjGB9oa3dawahv502hBFyUvAB20891Mfw=; b=tk8lAFxBLxaJuwIbl/
        w0gVoR2rMIUmSoFtVV9RYGaxPqMLXbVrRDUVrwfUywjI2Enwlt91C7Kte9pxaO9S
        mcxL33bMsDQuQ5TfcfDrmnvhTbscxH00BaWfIOh+SpwLhN93ifdtWyJyjGPzdkdd
        hp1eY4d6q6xHxoxqYRrRfnzbv5RktqrwpaFaJM9J6wPMlbllWzBiLPXAwju5ccFy
        w05+/jjmIbWSMbGDincy9DuIHOnVKbptvp9n40yUDuuMCfzuoChQsRT8VVn5N/CN
        GK+vQu3WOTZjbVwDKUCaDEc7Kmhz2QXa2xOeYwogsswrBdg933aL+WEttRCjy62/
        PO0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693433513; x=1693519913; bh=IIkDh8Uf9EvjG
        B9oa3dawahv502hBFyUvAB20891Mfw=; b=QqIfn//DwjmaRGL1JiacuWqcrP5M9
        CFoqr/DdxzRlfu+GimqRXcFQbnx3zgI+BMS8g1JTz2X8NmXwWtVUHhcYBWqTrREv
        0+YXYlSUcoITlwRis98R1uZQZGE5Ynq8z09qRhlI3Ks0hbU/oMD0c315fSKhm8AY
        wf8hBg9YA7ugAHS+SeCHrma5yqqSzZ504KQBpVYZ/TLIWc1/nnzunv70dTNrxGYm
        J70tK4SFK3X21SBu8E7RJtfL5B6cBCshPphvQ/6nbVbf5wIKRNi7nY9pkT7wMS6c
        8k7YBftgheqP3lT5zNXVWJQ0qnu7f0St8f1JQIDwfup8B9a30ujQSAKIA==
X-ME-Sender: <xms:qb7vZIdcr9X2aSHXDzIXfVkiy1Ua7J4iTfCn4wyVAIatuGvuarittg>
    <xme:qb7vZKPLNS_I5Yzi2fAFb0-Gh1pBLNvee3k7JbohCeZRRVZo7p-IESs5GMIBKoE7M
    BKwXzvXGYeBLYfv2RY>
X-ME-Received: <xmr:qb7vZJh-gHqv3CPEwrjPwC4ir6s1ebaXQVr5uk16MEUH7-9Ga1ED-tWR9BG3jJI6D7g0zczWkGENuUfCBLtnarb2xUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefledgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:qb7vZN_idWNpk8_tFgTd78AuEayVhNlJixHL_wizIoCXNJxvOPc0ZQ>
    <xmx:qb7vZEu33QbMZFO3gLXSOLjbt7NiLT-MeE-VEwvOlD5_NXl5dqcvCw>
    <xmx:qb7vZEEJH6Nrhd7uyFlXkC6xo-0WT1Y85ElKFbvL88GiA5iq8MNeCA>
    <xmx:qb7vZK3WdXULDhwmqUcckhBc1E3G3N1ovEdPeY1wjf1AwKZCYmfzEQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 18:11:52 -0400 (EDT)
Date:   Wed, 30 Aug 2023 15:09:20 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: qgroup: use qgroup_iterator facility to
 replace @tmp ulist of qgroup_update_refcnt()
Message-ID: <20230830220920.GC834639@zen>
References: <cover.1693391268.git.wqu@suse.com>
 <e6d30c5f77867f20ca19244e5c37881188855d6e.1693391268.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d30c5f77867f20ca19244e5c37881188855d6e.1693391268.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 30, 2023 at 06:37:27PM +0800, Qu Wenruo wrote:
> For function qgroup_update_refcnt(), we use @tmp list to iterate all the
> involved qgroups of a subvolume.
> 
> It's a perfect match for qgroup_iterator facility, as that @tmp ulist
> has a very limited lifespan (just inside the while() loop).
> 
> By migrating to qgroup_iterator, we can get rid of the GFP_ATOMIC memory
> allocation and no more error handling needed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 08f4fc622180..6fcf302744e2 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2463,13 +2463,11 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
>   * Walk all of the roots that points to the bytenr and adjust their refcnts.
>   */
>  static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
> -				struct ulist *roots, struct ulist *tmp,
> -				struct ulist *qgroups, u64 seq, int update_old)
> +				struct ulist *roots, struct ulist *qgroups,
> +				u64 seq, int update_old)
>  {
>  	struct ulist_node *unode;
>  	struct ulist_iterator uiter;
> -	struct ulist_node *tmp_unode;
> -	struct ulist_iterator tmp_uiter;
>  	struct btrfs_qgroup *qg;
>  	int ret = 0;
>  
> @@ -2477,40 +2475,35 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
>  		return 0;
>  	ULIST_ITER_INIT(&uiter);
>  	while ((unode = ulist_next(roots, &uiter))) {
> +		LIST_HEAD(tmp);
> +
>  		qg = find_qgroup_rb(fs_info, unode->val);
>  		if (!qg)
>  			continue;
>  
> -		ulist_reinit(tmp);
>  		ret = ulist_add(qgroups, qg->qgroupid, qgroup_to_aux(qg),
>  				GFP_ATOMIC);
>  		if (ret < 0)
>  			return ret;
> -		ret = ulist_add(tmp, qg->qgroupid, qgroup_to_aux(qg), GFP_ATOMIC);
> -		if (ret < 0)
> -			return ret;
> -		ULIST_ITER_INIT(&tmp_uiter);
> -		while ((tmp_unode = ulist_next(tmp, &tmp_uiter))) {
> +		qgroup_iterator_add(&tmp, qg);
> +		list_for_each_entry(qg, &tmp, iterator) {
>  			struct btrfs_qgroup_list *glist;
>  
> -			qg = unode_aux_to_qgroup(tmp_unode);
>  			if (update_old)
>  				btrfs_qgroup_update_old_refcnt(qg, seq, 1);
>  			else
>  				btrfs_qgroup_update_new_refcnt(qg, seq, 1);
> +
>  			list_for_each_entry(glist, &qg->groups, next_group) {
>  				ret = ulist_add(qgroups, glist->group->qgroupid,
>  						qgroup_to_aux(glist->group),
>  						GFP_ATOMIC);

Thinking out loud, could we use the same trick and put another global
list on the qgroups to handle this one? Or some other "single global
allocation up to #qgroups" trick.

>  				if (ret < 0)
>  					return ret;
> -				ret = ulist_add(tmp, glist->group->qgroupid,
> -						qgroup_to_aux(glist->group),
> -						GFP_ATOMIC);
> -				if (ret < 0)
> -					return ret;
> +				qgroup_iterator_add(&tmp, glist->group);
>  			}
>  		}
> +		qgroup_iterator_clean(&tmp);
>  	}
>  	return 0;
>  }
> @@ -2675,7 +2668,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct ulist *qgroups = NULL;
> -	struct ulist *tmp = NULL;
>  	u64 seq;
>  	u64 nr_new_roots = 0;
>  	u64 nr_old_roots = 0;
> @@ -2714,12 +2706,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  		ret = -ENOMEM;
>  		goto out_free;
>  	}
> -	tmp = ulist_alloc(GFP_NOFS);
> -	if (!tmp) {
> -		ret = -ENOMEM;
> -		goto out_free;
> -	}
> -
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
>  	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
>  		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
> @@ -2734,13 +2720,13 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  	seq = fs_info->qgroup_seq;
>  
>  	/* Update old refcnts using old_roots */
> -	ret = qgroup_update_refcnt(fs_info, old_roots, tmp, qgroups, seq,
> +	ret = qgroup_update_refcnt(fs_info, old_roots, qgroups, seq,
>  				   UPDATE_OLD);
>  	if (ret < 0)
>  		goto out;
>  
>  	/* Update new refcnts using new_roots */
> -	ret = qgroup_update_refcnt(fs_info, new_roots, tmp, qgroups, seq,
> +	ret = qgroup_update_refcnt(fs_info, new_roots, qgroups, seq,
>  				   UPDATE_NEW);
>  	if (ret < 0)
>  		goto out;
> @@ -2755,7 +2741,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  out:
>  	spin_unlock(&fs_info->qgroup_lock);
>  out_free:
> -	ulist_free(tmp);
>  	ulist_free(qgroups);
>  	ulist_free(old_roots);
>  	ulist_free(new_roots);
> -- 
> 2.41.0
> 
