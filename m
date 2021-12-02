Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73C466717
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359161AbhLBPuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359032AbhLBPuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 10:50:19 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82634C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 07:46:56 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 193so275157qkh.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Magg1fK4+F49jR+sSAuMTq6DdVlPNDUUSoYOfinZ4gQ=;
        b=Eo/3B11O1JDWEpgfgRwIYM5X2/3u1WvIgTLBl+hqrQqhe3B6VrcHuyMxr72tYXPnbo
         BbLR5IyJTiS60oNZACvmr2Hfyc3xdn8CX282mgMMylMQbq8Xs+sMO6IJ9O5uJF4HeNJ3
         DN5WcsbFI2IenkIDNF74lHE6EKZWsNdNgZSPHZFHSRPqy+/7Io8zQ4bf3rFmKLk1k/ml
         XQSRnx+nHarrjxrI88P1l569lYxGHMLbf5l230qyv6x4ce1I8mkpnuIx7WugZaQmC7X+
         vcpj7oMv8tdxhvlrzdQngfzhzj1z0t02/C/Yx5bvnHcHXuyMvIzPjNoe+wxg/iLI4YEs
         mxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Magg1fK4+F49jR+sSAuMTq6DdVlPNDUUSoYOfinZ4gQ=;
        b=wDkzUkOF4uhK+TbpKAbPCTsuNoP/ws1uGpqdAIdD+bDihrNLBpet5/B/i4ZXDDXBeL
         H8oWk/1uuHUHk7hQTc/KFU/zzf/EKJTU/xsIJIKl0if9HCnc3VAyWNODMhLWaW5M0yOG
         K3cLWpWwqYEWCmDtrxD5oaHzfBxr85NtOCm6uAX6cx7re7P2gzRWDO5TOtpdvVx6ONxu
         E9MWKZSBLxulfgUbQFDNK1QQwPmIja5hSmMFjv774iWGdElbRQg/62Of1+1MTMBBLNfJ
         I3HmIrsGHIz4ES/wZpv8nYUlf4zihfVVt3y5S/LYWnXOrJdzqcrI6EswEETfG3Z9+Z6B
         Gobg==
X-Gm-Message-State: AOAM531Zft/MUGz3MvOLOSxjuxmlFumB1Kk3Ol/s1uVUTvUIEwIve2eT
        M3odoMyJatPtcin2WDpmJThU+txSRnzHQw==
X-Google-Smtp-Source: ABdhPJwJBD8DNvYlTptFIulH38QNYwcwzgF0t/NthNbzQT20nUbPMEdcR04jYb/Cqhuc196xCkzgcw==
X-Received: by 2002:a05:620a:4450:: with SMTP id w16mr12821025qkp.26.1638460015423;
        Thu, 02 Dec 2021 07:46:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21sm28365qtb.62.2021.12.02.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 07:46:54 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:46:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: reserve extra space for the free space tree
Message-ID: <YajqbY0vnANwsSzg@localhost.localdomain>
References: <cover.1638377089.git.josef@toxicpanda.com>
 <aab24f138d49b8d331a359b66029bb61f12fd44c.1638377089.git.josef@toxicpanda.com>
 <5ae9a490-e439-9e2d-bf6e-47ee7d5bceed@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ae9a490-e439-9e2d-bf6e-47ee7d5bceed@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 04:14:51PM +0200, Nikolay Borisov wrote:
> 
> 
> On 1.12.21 г. 18:45, Josef Bacik wrote:
> > Filipe reported a problem where sometimes he'd get an ENOSPC abort when
> > running delayed refs with generic/619 and the free space tree enabled.
> > This is partly because we do not reserve space for modifying the free
> > space tree, nor do we have a block rsv associated with that tree.  Fix
> > this by making sure any free space tree defaults to using the
> > delayed_refs_rsv, and make sure we reserve the space for those
> > allocations.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-rsv.c   |  1 +
> >  fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > index b3086f252ad0..b3ee49b0b1e8 100644
> > --- a/fs/btrfs/block-rsv.c
> > +++ b/fs/btrfs/block-rsv.c
> > @@ -426,6 +426,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
> >  	switch (root->root_key.objectid) {
> >  	case BTRFS_CSUM_TREE_OBJECTID:
> >  	case BTRFS_EXTENT_TREE_OBJECTID:
> > +	case BTRFS_FREE_SPACE_TREE_OBJECTID:
> >  		root->block_rsv = &fs_info->delayed_refs_rsv;
> >  		break;
> >  	case BTRFS_ROOT_TREE_OBJECTID:
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index da9d20813147..533521be8fdf 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -84,6 +84,17 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
> >  	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
> >  	u64 released = 0;
> >  
> > +	/*
> > +	 * We have to check the mount option here because we could be enabling
> > +	 * the free space tree for the first time and don't have the compat_ro
> > +	 * option set yet.
> > +	 *
> > +	 * We need extra reservations if we have the free space tree because
> > +	 * we'll have to modify that tree as well.
> > +	 */
> > +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
> > +		num_bytes <<= 1;
> > +
> >  	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
> >  	if (released)
> >  		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
> > @@ -108,6 +119,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
> >  
> >  	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
> >  						    trans->delayed_ref_updates);
> > +	/*
> > +	 * We have to check the mount option here because we could be enabling
> > +	 * the free space tree for the first time and don't have the compat_ro
> > +	 * option set yet.
> > +	 *
> > +	 * We need extra reservations if we have the free space tree because
> > +	 * we'll have to modify that tree as well.
> > +	 */
> > +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
> > +		num_bytes <<= 1;
> 
> That num_bytes * 2 is heuristically derived, right? If so I'd like this
> to be mentioned explicitly in the changelog.

No, the delayed refs is number of items we're modifying in the extent tree.  If
we have the free space tree we have to modify the same number of items in the
free space tree, so it's 2x the space reservations required.  Thanks,

Josef
