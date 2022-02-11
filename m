Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFEC4B243D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbiBKLYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 06:24:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBKLYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 06:24:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B1E5D
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 03:24:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EECDB829B6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 11:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28ADC340E9;
        Fri, 11 Feb 2022 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644578642;
        bh=n5xUeMiiZT0UFfWxr/HlIawZ/kFJiBV3dFtnb4J1m4U=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=LbSpePwkt1l4Yg+7zeInyJu2w14V65stuv2IK7zBKv4M2hzgRUP/Nx6Q0MQ+/C+59
         VV/hiNaHt/huAtxIvHGjuMhceFweESbm/2GDqQYBSYQQtWi+HqCtF9VNYEh5HIZluL
         6OrBD6kWNxfYSkhRxNI+MhEFL5cGHeM83Hk8k9F7Xi6NL5QAr8sj261k5m+A0IAoaB
         UCReRwPdfyBC/HnRscE1wLroY5EaWKWPj700UMDIddkawumLMOMKGE4ne8kj+J34j1
         KquBLBCzSU0rSVq8cZ32wtAZQXEw2pn6sJK4LLiPfY0cGy55KwNEypv2/M7LiePBVz
         a0tFepaQ29vig==
Date:   Fri, 11 Feb 2022 11:23:58 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: fail transaction when a setget bounds check
 failure is detected
Message-ID: <YgZHTm2k3/ulqPTO@debian9.Home>
References: <cover.1643904960.git.dsterba@suse.com>
 <617931b8ee53e8fcde1560eb86758024ca753f42.1643904960.git.dsterba@suse.com>
 <Yf0OLxcQ5mxiwWM5@debian9.Home>
 <20220210175017.GT12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210175017.GT12643@twin.jikos.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 06:50:17PM +0100, David Sterba wrote:
> On Fri, Feb 04, 2022 at 11:29:51AM +0000, Filipe Manana wrote:
> > On Thu, Feb 03, 2022 at 06:26:31PM +0100, David Sterba wrote:
> > > As the setget check only sets the bit, we need to use it in the
> > > transaction:
> > > 
> > > - when attempting to start a new one, fail with EROFS as if would be
> > >   aborted in another way already
> > > 
> > > - in should_end_transaction
> > > 
> > > - when transaction is about to end, insert an explicit abort
> > > 
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > >  fs/btrfs/transaction.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > index 6db634ebae17..f48194df6c33 100644
> > > --- a/fs/btrfs/transaction.c
> > > +++ b/fs/btrfs/transaction.c
> > > @@ -591,6 +591,9 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
> > >  	if (BTRFS_FS_ERROR(fs_info))
> > >  		return ERR_PTR(-EROFS);
> > >  
> > > +	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
> > > +		return ERR_PTR(-EROFS);
> > > +
> > >  	if (current->journal_info) {
> > >  		WARN_ON(type & TRANS_EXTWRITERS);
> > >  		h = current->journal_info;
> > > @@ -924,6 +927,9 @@ static bool should_end_transaction(struct btrfs_trans_handle *trans)
> > >  {
> > >  	struct btrfs_fs_info *fs_info = trans->fs_info;
> > >  
> > > +	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
> > > +		return true;
> > > +
> > >  	if (btrfs_check_space_for_delayed_refs(fs_info))
> > >  		return true;
> > >  
> > > @@ -969,6 +975,11 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
> > >  	struct btrfs_transaction *cur_trans = trans->transaction;
> > >  	int err = 0;
> > >  
> > > +	/* If a serious error was detected abort the transaction early */
> > > +	if (!TRANS_ABORTED(trans) &&
> > > +	    test_bit(BTRFS_FS_SETGET_COMPLAINS, &info->flags))
> > > +		btrfs_abort_transaction(trans, -EIO);
> > 
> > Instead of sprinkling the test for BTRFS_FS_SETGET_COMPLAINS in all
> > these places, it seems to me it could be included in BTRFS_FS_ERROR().
> 
> Yeah that's a good idea.
> 
> > And then having check_setget_bounds() call btrfs_handle_fs_error().
> 
> btrfs_handle_fs_error is a bit heavyweight for all the potential cases
> where the eb member check could happen.
> 
> > That would remove the need for all this code. Wouldn't it?
> > 
> > > +
> > >  	if (refcount_read(&trans->use_count) > 1) {
> > >  		refcount_dec(&trans->use_count);
> > >  		trans->block_rsv = trans->orig_rsv;
> > 
> > This misses one important case:
> > 
> >   task starts/joins/attaches a transaction
> > 
> >   fails one of the bounds check when accessing some extent buffer
> > 
> >   calls btrfs_commit_transaction()
> > 
> > The transaction ends up committed.
> > 
> > So a check and abort in the commit path, right before writing the super blocks,
> > should be in place.
> > 
> > With the above suggestions for check_setget_bounds() and BTRFS_FS_ERROR(),
> > this case would be handled automatically like the others, so no need for
> > sprinkling the checks and aborts in several places.
> 
> Agreed with the BTRFS_FS_ERROR part, I'm not sure about calling the
> btrfs_handle_fs_error. The function was introduced before the
> transaction abort mechanism, which builds on top of it, but there are
> still calls to btrfs_handle_fs_error that seem to substitute abort.
> Conversions like ba51e2a11e38 ("btrfs: change handle_fs_error in
> recover_log_trees to aborts") need to happen, there are still like 30 of
> them.

Well, btrfs_handle_fs_error() is handy when we don't have access to a
transaction and we need to prevent a future transaction from starting.

Another alternative, instead of adding that new bit, simply doing something
like the following at check_setget_bounds():

    if (current->journal_info)
        btrfs_abort_transaction(current->journal_info, -EUCLEAN);

For a task doing reads only, and that nevers joins/starts a transaction,
in case it calls a getter that does an out of bounds access, there's no
way to return an error back to user space anyway.

There's always the case a task may do such a bad get and later join/start
a transaction and call a setter with a value computed on top of a bad
value returned by the bad getter.

I still think btrfs_handle_fs_error() is the best to use here. It fits
perfectly for this scenario, without neither the need to add a new bit
nor to sprinkle more logic into transaction.c
