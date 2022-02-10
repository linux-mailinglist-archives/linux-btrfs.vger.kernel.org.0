Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4C4B149F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 18:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbiBJRyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 12:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiBJRyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 12:54:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C7192
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 09:54:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6CCB221121;
        Thu, 10 Feb 2022 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644515639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4ZuAbVj3DZlGuiYYzlFmyBdxIZFjTcmlkRdO3t1YOc=;
        b=O3hcvWTnCkkLaUJTGpZZLWFvinlGQPh9gCycOQXYGJgg/iUUixVHYe+OtPPxQ3vUnDn8u3
        sC0LHKaA39tc/slT8G1uw2sFR3cMDhujWsNZBui0v5ed/G/yZk687Y+sEGEjNqdOOJAwre
        qz0I7ezHp62Teld8kB0hLg9Kmnjf0ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644515639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4ZuAbVj3DZlGuiYYzlFmyBdxIZFjTcmlkRdO3t1YOc=;
        b=f/Tl0ItHIUykuSXF7RMa4vsTU03t/bNZD8TSzdkNSf1o16N2UyRlzCxdCOdEnrdA+v0GdU
        Iqxq8RVrt8RgLjCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 632D4A3B84;
        Thu, 10 Feb 2022 17:53:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE8FEDA9BA; Thu, 10 Feb 2022 18:50:17 +0100 (CET)
Date:   Thu, 10 Feb 2022 18:50:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: fail transaction when a setget bounds check
 failure is detected
Message-ID: <20220210175017.GT12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1643904960.git.dsterba@suse.com>
 <617931b8ee53e8fcde1560eb86758024ca753f42.1643904960.git.dsterba@suse.com>
 <Yf0OLxcQ5mxiwWM5@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0OLxcQ5mxiwWM5@debian9.Home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 11:29:51AM +0000, Filipe Manana wrote:
> On Thu, Feb 03, 2022 at 06:26:31PM +0100, David Sterba wrote:
> > As the setget check only sets the bit, we need to use it in the
> > transaction:
> > 
> > - when attempting to start a new one, fail with EROFS as if would be
> >   aborted in another way already
> > 
> > - in should_end_transaction
> > 
> > - when transaction is about to end, insert an explicit abort
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/transaction.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 6db634ebae17..f48194df6c33 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -591,6 +591,9 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
> >  	if (BTRFS_FS_ERROR(fs_info))
> >  		return ERR_PTR(-EROFS);
> >  
> > +	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
> > +		return ERR_PTR(-EROFS);
> > +
> >  	if (current->journal_info) {
> >  		WARN_ON(type & TRANS_EXTWRITERS);
> >  		h = current->journal_info;
> > @@ -924,6 +927,9 @@ static bool should_end_transaction(struct btrfs_trans_handle *trans)
> >  {
> >  	struct btrfs_fs_info *fs_info = trans->fs_info;
> >  
> > +	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
> > +		return true;
> > +
> >  	if (btrfs_check_space_for_delayed_refs(fs_info))
> >  		return true;
> >  
> > @@ -969,6 +975,11 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
> >  	struct btrfs_transaction *cur_trans = trans->transaction;
> >  	int err = 0;
> >  
> > +	/* If a serious error was detected abort the transaction early */
> > +	if (!TRANS_ABORTED(trans) &&
> > +	    test_bit(BTRFS_FS_SETGET_COMPLAINS, &info->flags))
> > +		btrfs_abort_transaction(trans, -EIO);
> 
> Instead of sprinkling the test for BTRFS_FS_SETGET_COMPLAINS in all
> these places, it seems to me it could be included in BTRFS_FS_ERROR().

Yeah that's a good idea.

> And then having check_setget_bounds() call btrfs_handle_fs_error().

btrfs_handle_fs_error is a bit heavyweight for all the potential cases
where the eb member check could happen.

> That would remove the need for all this code. Wouldn't it?
> 
> > +
> >  	if (refcount_read(&trans->use_count) > 1) {
> >  		refcount_dec(&trans->use_count);
> >  		trans->block_rsv = trans->orig_rsv;
> 
> This misses one important case:
> 
>   task starts/joins/attaches a transaction
> 
>   fails one of the bounds check when accessing some extent buffer
> 
>   calls btrfs_commit_transaction()
> 
> The transaction ends up committed.
> 
> So a check and abort in the commit path, right before writing the super blocks,
> should be in place.
> 
> With the above suggestions for check_setget_bounds() and BTRFS_FS_ERROR(),
> this case would be handled automatically like the others, so no need for
> sprinkling the checks and aborts in several places.

Agreed with the BTRFS_FS_ERROR part, I'm not sure about calling the
btrfs_handle_fs_error. The function was introduced before the
transaction abort mechanism, which builds on top of it, but there are
still calls to btrfs_handle_fs_error that seem to substitute abort.
Conversions like ba51e2a11e38 ("btrfs: change handle_fs_error in
recover_log_trees to aborts") need to happen, there are still like 30 of
them.
