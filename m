Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9544C51C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKJQiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 11:38:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhKJQiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 11:38:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E8CE11FDC2;
        Wed, 10 Nov 2021 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636562128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVKQeAOVG/x8WG31LIA8nphY2rB7k9FtT1NyZ2A4I2A=;
        b=uqfpWJuMgsj82SeU5Xbia/pjfOz1QwfB2NT8NVprPbfYLtzW1eHQgid3y8foYT+tqXrxyL
        BACuG332EjdsI+xWTN0euILe0YUhKNX/icqoqwAljxWCQmRlYAI0vUiJYXkZWe/a6/n2q2
        KX+1KypP8JHA+J5CAyJIEkw8riNJZ3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636562128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVKQeAOVG/x8WG31LIA8nphY2rB7k9FtT1NyZ2A4I2A=;
        b=DTGvpMHEIygH0Cm7rkwA9USSdZoeuqRjvItOZtvS9SDZaqyFMc0qYNG/YetKrOq0Oq5NSu
        3foaxTNMHo6xExCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E15E4A3B84;
        Wed, 10 Nov 2021 16:35:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A00EDA799; Wed, 10 Nov 2021 17:34:49 +0100 (CET)
Date:   Wed, 10 Nov 2021 17:34:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reduce the scope of the tree log mutex during
 transaction commit
Message-ID: <20211110163449.GW28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <f9f76a38d5a908d438816a778a7d55764a6360f3.1636538581.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f76a38d5a908d438816a778a7d55764a6360f3.1636538581.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 10:05:21AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the transaction commit path we are acquiring the tree log mutex too
> early and we have a stale comment because:
> 
> 1) It mentions a function named btrfs_commit_tree_roots(), which does not
>    exists anymore, it was the old name of commit_cowonly_roots(), renamed
>    a very long time ago by commit 5d4f98a28c7d33 ("Btrfs: Mixed back
>    reference  (FORWARD ROLLING FORMAT CHANGE)"));
> 
> 2) It mentions that we need to acquire the tree log mutex at that point
>    to ensure we have no running log writers. That is not correct anymore,
>    for many years at least, since we are guaranteed that we do not have
>    any log writers at that point simply because we have set the state of
>    the transaction to TRANS_STATE_COMMIT_DOING and have waited for all
>    writers to complete - meaning no one can log until we change the state
>    of the transaction to TRANS_STATE_UNBLOCKED. Any attempts to join the
>    transaction or start a new one will block until we do that state
>    transition;
> 
> 3) The comment mentions a "trans mutex" which doesn't exists since 2011,
>    commit a4abeea41adf ("Btrfs: kill trans_mutex") removed it;
> 
> 4) The current use of the tree log mutex is to ensure proper serialization
>    of super block writes - if someone started a new transaction and uses it
>    for logging, it will wait for the previous transaction to write its
>    super block before writing the super block when attempting to sync the
>    log.
> 
> So acquire the tree log mutex only when it's absolutely needed, before
> setting the transaction state to TRANS_STATE_UNBLOCKED, fix and move the
> stale comment, add some assertions and new comments where appropriate.
> 
> Also, this has no effect on concurrency or performance, since the new
> start of the critical section is still when the transaction is in the
> state TRANS_STATE_COMMIT_DOING.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
