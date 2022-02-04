Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B076F4A9A1B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 14:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358900AbiBDNjA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 08:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBDNi7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 08:38:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE1C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 05:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06D90B83693
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 13:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC3DC004E1;
        Fri,  4 Feb 2022 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643981936;
        bh=uiQ4nqAUHU+I+8YrITMnUOPComYSxyk1MMoiPxQTKvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8FIsyT7M8tIFSQm6QadhwuNQ0mHXW/yU7b1UShiWXSynKEkYl3jJiOUwqQ9GMf2s
         wHcNi1OQnmphxiN5Xaxr2+xEeyCaVlsScnlC3WCoUcExATV9sbJn7UzBCvLctEI4hc
         9kcR8Z8+FZc0WACKKjrFuaGptaVANjw6Px8P1Pqq8YG1oo3xQIGFNfI/A4wsawR3N7
         QpQabNGFba9sU5bug0wOin5eD59NLcoRx5S0v/LN2KLQ9cvCI6E/TA2pNu7a6HTbc7
         t7kCEuTYDfCAQCzqX7yxtoNuBKasH2dVTQB26R53Nn4Aaij0aSQ9vQQPnOHNQ5zi0C
         POB2YfRmwwRsQ==
Date:   Fri, 4 Feb 2022 13:38:53 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: fail transaction when a setget bounds check
 failure is detected
Message-ID: <Yf0sbW/Br3am+eTE@debian9.Home>
References: <cover.1643904960.git.dsterba@suse.com>
 <617931b8ee53e8fcde1560eb86758024ca753f42.1643904960.git.dsterba@suse.com>
 <Yf0OLxcQ5mxiwWM5@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0OLxcQ5mxiwWM5@debian9.Home>
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
> And then having check_setget_bounds() call btrfs_handle_fs_error().
> 
> That would remove the need for all this code. Wouldn't it?

In fact just calling btrfs_handle_fs_error() at report_setget_bounds()
or check_setget_bounds() would be all that is needed.
No need for adding the flag BTRFS_FS_SETGET_COMPLAINS, checking for it
at several places, then aborting transaction in those places, etc.

Way more simple and less intrusive.

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
> 
> Thanks.
> 
> > -- 
> > 2.34.1
> > 
