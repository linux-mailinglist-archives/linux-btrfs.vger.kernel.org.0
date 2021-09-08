Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54EF403E33
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352337AbhIHROH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 13:14:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52385 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232976AbhIHROG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 13:14:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 30BD55C0112;
        Wed,  8 Sep 2021 13:12:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Sep 2021 13:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Ah2negzH6LsSLgNhreDrTvTJ/PG
        OOoBYoy8FY6tlTY0=; b=TogOGhndRBgHXQiejk6KX2VQ8zt9R2akeB3aGUpgMB3
        6j1MtYyJsmZULNgrUvZx3sh3H2EWVN4vlTKdX8zZPEwFUlZtuXJClQFP3bqRoDh4
        8rRHHzLsyJJLiJYdwL8ekr+jBbz1cbeHvHvP+KzhWJbXSJlegm0X5hXKb2OLwhJU
        /+4VJwFbzvApbWy/VAbYREpwAN9ChsJWBt3hSOtlzNfWvRPE2abxceNPk1zaoNeY
        v9fvtAMmNzT0EtH99Z25zg/6j62BUsr8nnqBreUGVMOB1368/OrByKmkJiOutSRP
        8xkHhJYNSBEVztZg+Jbbt0sy8m/yrZhQ6GJqRCuurXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ah2neg
        zH6LsSLgNhreDrTvTJ/PGOOoBYoy8FY6tlTY0=; b=GTRGd9CUpU013j6qCgDRh0
        WRlI7OP6ncXvF3Kh5i/riRNOCLpNWm5sI0KYVSE2QiK+lxzEv3LbmkY0XafSl4F1
        YfKBF/AeNcVcvo/9I02NI/eJs6qJ4EsNf3KR0g591XSK8+mg4gyEWnDGCUlNdEyE
        oz285u6CDurLc/W+6SWFgQzyAPld7s0LTLxmqb84u40vClYt7eLWm18uc6+3R7MV
        934pLlEse5XwaBobSW3ClkkvMWk840jxWQXCkogTYjM/5kSJQ0JdJgoLTEvIyw+7
        1xkGw+JJTGyXn35wF/pUvs75I8SrlLkXgczw9Ov638BECWZSGbqml5Uvf2kiPWDQ
        ==
X-ME-Sender: <xms:Ge84YYTPFcEMu11yifYEA6t3C7wJhSHqM7gGFwWX5bndmeLoOladUQ>
    <xme:Ge84YVwPYNzxyhy4ZmO-uyoWT1ogVGxmCGHzddUb_Kke--dbN_mfwcR8Imxi-03Vf
    RrTQ6ndXCryxcs-2ms>
X-ME-Received: <xmr:Ge84YV2K4wqmnS9PWrhswDr_zNL0CsGXQk_Mbp9EQXptN9Ym6no9afJ217MEWXbqBbthZP3FGjXpSVLGwCkrx8E0Ure-Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepheduveelkeeiteelveeiuefhudehtdeigfehke
    effeegledvueevgefgudeuveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Ge84YcDj0IlPCT3f0WfTdrxflKsMshXBuJuo24unWjpztPmVGD4D2Q>
    <xmx:Ge84YRg90wszxQt4lt5YdHwci5LO_zTxlhLLaSpVdYuRsvOf9q1OeQ>
    <xmx:Ge84YYov23RpCtJvEEUlebbzB8xmdIr1SZOEoAWkhG5V-uyAchRtbA>
    <xmx:Gu84YRK2AqUKXwPdKSGsDCy1bhqFliNs9tSAv7UODjl2najx1D5LoQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 13:12:57 -0400 (EDT)
Date:   Wed, 8 Sep 2021 10:12:56 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix transaction handle leak after verity rollback
 failure
Message-ID: <YTjvGGW0YYMF3bEH@zen>
References: <b390e518f2091df52fd314806cce52fd00a19a00.1631114872.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b390e518f2091df52fd314806cce52fd00a19a00.1631114872.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 04:29:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a verity rollback, if we fail to update the inode or delete the
> orphan, we abort the transaction and return without releasing our
> transaction handle. Fix that by releasing the handle.
> 
> Fixes: 146054090b0859 ("btrfs: initial fsverity support")
> Fixes: 705242538ff348 ("btrfs: verity metadata orphan items")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Oops, I thoughtlessly assumed abort also released the handle. Thank you
for the fix!
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/verity.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index 28d443d3ef93..4968535dfff0 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -451,7 +451,7 @@ static int del_orphan(struct btrfs_trans_handle *trans, struct btrfs_inode *inod
>   */
>  static int rollback_verity(struct btrfs_inode *inode)
>  {
> -	struct btrfs_trans_handle *trans;
> +	struct btrfs_trans_handle *trans = NULL;
>  	struct btrfs_root *root = inode->root;
>  	int ret;
>  
> @@ -473,6 +473,7 @@ static int rollback_verity(struct btrfs_inode *inode)
>  	trans = btrfs_start_transaction(root, 2);
>  	if (IS_ERR(trans)) {
>  		ret = PTR_ERR(trans);
> +		trans = NULL;
>  		btrfs_handle_fs_error(root->fs_info, ret,
>  			"failed to start transaction in verity rollback %llu",
>  			(u64)inode->vfs_inode.i_ino);
> @@ -490,8 +491,9 @@ static int rollback_verity(struct btrfs_inode *inode)
>  		btrfs_abort_transaction(trans, ret);
>  		goto out;
>  	}
> -	btrfs_end_transaction(trans);
>  out:
> +	if (trans)
> +		btrfs_end_transaction(trans);
>  	return ret;
>  }
>  
> -- 
> 2.33.0
> 
