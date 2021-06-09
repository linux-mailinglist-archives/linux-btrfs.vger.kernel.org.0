Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461173A198B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhFIPba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 11:31:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhFIPb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 11:31:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 808E41FD62;
        Wed,  9 Jun 2021 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623252574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/GESPtg8Pnhjm76QD1EuJIUFaAMdraQ2yoaBcZfMRc=;
        b=E723qE2qRHg81345gBuJ+NM7qYTRWcbxLjHknDy/Cyso0JGg4iM7tbPBuzuc3bpB0eASo5
        3AtM5cliD84n3p2ivFtnH3x4fz+5Gx17YQgxWtrqpDKlynQ0gYYdwTROeSW20ybwJkEP7u
        Mt7iU1QYfZjKqARfr3pP/KaifuGflqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623252574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/GESPtg8Pnhjm76QD1EuJIUFaAMdraQ2yoaBcZfMRc=;
        b=gP4+tEvhjhWEPCvWxGLB4YReKqp1op1foyoDtEGsqXQdViCHFV66QI8XcJH7T4h/R0HGm6
        ppWjcEFE6o8PAyBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7AE15A3B81;
        Wed,  9 Jun 2021 15:29:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 64503DA908; Wed,  9 Jun 2021 17:26:50 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:26:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10]  btrfs: defrag: rework to support sector
 perfect defrag
Message-ID: <20210609152650.GC27283@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210608025927.119169-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608025927.119169-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 08, 2021 at 10:59:17AM +0800, Qu Wenruo wrote:
> This branch is based on subpage RW branch, as the last patch needs to
> enable defrag support for subpage cases.
> 
> But despite that one, all other patches can be applied on current
> misc-next.
> 
> [BACKGROUND]
> In subpage rw branch, we disable defrag completely due to the fact that
> current code can only work on page basis.
> 
> This could lead to problems like btrfs/062 crash.
> 
> Thus this patchset will make defrag to work on both regular and subpage
> sectorsize.
> 
> [SOLUTION]
> To defrag a file range, what we do is pretty much like buffered write,
> except we don't really write any new data to page cache, but just mark
> the range dirty.
> 
> Then let later writeback to merge the range into a larger extent.
> 
> But current defrag code is working on per-page basis, not per-sector,
> thus we have to refactor it a little to make it to work properly for
> subpage.
> 
> This patch will separate the code into 3 layers:
> Layer 0:	btrfs_defrag_file()
> 		The defrag entrace
> 		Just do proper inode lock and split the file into
> 		page aligned 256K clusters to defrag
> 
> Layer 1:	defrag_one_cluster()
> 		Will collect the initial targets file extents, and pass
> 		each continuous target to defrag_one_range()
> 
> Layer 2:	defrag_one_range()
> 		Will prepare the needed page and extent locking.
> 		Then re-check the range for real target list, as initial
> 		target list is not consistent as it doesn't hage
> 		page/extent locking to prevent hole punching.
> 
> Layer 3:	defrag_one_locked_target()
> 		The real work, to make the extent range defrag and
> 		update involved page status
> 
> [BEHAVIOR CHANGE]
> In the refactor, there is one behavior change:
> 
> - Defraged sector counter is based on the initial target list
>   This is mostly to avoid the paremters to be passed too deep into
>   defrag_one_locked_target().
>   Considering the accounting is not that important, we can afford some
>   difference.

As you're going to resend, please fix all occurences of 'defraged' to
'defragged'.

I'll give the patchset some testing bug am not sure if it isn't too
risky to put it to the 5.14 queue as it's about time to do only safe
changes.
