Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBD455B52
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 13:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbhKRMQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 07:16:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40690 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbhKRMPI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 07:15:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B24AC1FD35;
        Thu, 18 Nov 2021 12:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637237527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2wWUY4VU5fdLQZIGhIY13+gYrdWfa4QiJFeTylge7RA=;
        b=VzKvHeXoDu7FxlRFv5kyoANuDk6SrbqNL33bgNlU1vUWvWwKhRINQpG6AkHUNrvb/z8Uy6
        wDjD9QdQptde+qahdiofB6cWpMGQVP9tp0TwlBiDM5r0aDUZ8b3MwV9dz71xQTITCP/NQX
        bYURDdfAjTZ3XWPejk4B6YAu4pqz49Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637237527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2wWUY4VU5fdLQZIGhIY13+gYrdWfa4QiJFeTylge7RA=;
        b=wVLudHXPWRJwSP9ezcQb2tzxQJZz3FWTDuVdNyuMhQrP8k5BIRecROLQ8+DpulWqEzzf5O
        s6H1M4tpuOmj23AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AA7C6A3B88;
        Thu, 18 Nov 2021 12:12:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4AF67DA735; Thu, 18 Nov 2021 13:12:03 +0100 (CET)
Date:   Thu, 18 Nov 2021 13:12:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 02/25] btrfs: rework async transaction committing
Message-ID: <20211118121203.GZ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636144971.git.josef@toxicpanda.com>
 <5a181fb41c864ca518a35defc2547abef30afb18.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a181fb41c864ca518a35defc2547abef30afb18.1636144971.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 04:45:28PM -0400, Josef Bacik wrote:
> Currently we do this awful thing where we get another ref on a trans
> handle, async off that handle and commit the transaction from that work.
> Because we do this we have to mess with current->journal_info and the
> freeze counting stuff.
> 
> We already have an async thing to kick for the transaction commit, the
> transaction kthread.  Replace this work struct with a flag on the
> fs_info to tell the kthread to go ahead and commit even if it's before
> our timeout.  Then we can drastically simplify the async transaction
> commit path.

I wanted to get rid of the async commit completely and reusing the
pending operations that's basically the same what you add as the new fs
bit.

https://lore.kernel.org/linux-btrfs/808c557f1ae3034fdfa2d2361e864aac90ba5a94.1622733245.git.dsterba@suse.com/

There's also a followup removing transaction_blocked_wait, I got some
hangs in btrfs/011. I haven't tested 3/4 separately so I don't know the
exact cause.

> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -595,6 +595,9 @@ enum {
>  	/* Indicate whether there are any tree modification log users */
>  	BTRFS_FS_TREE_MOD_LOG_USERS,
>  
> +	/* Indicate that we want the transaction kthread to commit right now. */
> +	BTRFS_FS_COMMIT_TRANS,

This is duplicating functionality behind BTRFS_PENDING_COMMIT, otherwise
simplifying the async commit is good of course.
