Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED55474792
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 17:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhLNQWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 11:22:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46090 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhLNQWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7F02E1F381;
        Tue, 14 Dec 2021 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639498926;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhK281cXublE+rc8gPffkfCC9z0ydpUHm1neWpvNyI4=;
        b=mBFs1prrb+U8leqMGG0eCPAFcRcydh9Fuwgm4gspAr1SVKkBQ1DaD9YE6qG0QsxRzKVsru
        HOZFnf3QX3NqpXIl3DNwA5nE5xXeGl3L4IRlWc12hBBJFYBFpw1J/xw1fa7YcNmkHl3+jz
        3bwY6BE01BvdJzPtZSFUtjQ72QVGj4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639498926;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhK281cXublE+rc8gPffkfCC9z0ydpUHm1neWpvNyI4=;
        b=5GWYuuLA7pDF4IhtPOirUZsVhsBCgryF9Qjg5Id5PkoRrqiiVUmZVETOEVXDE2xLEk8ANd
        WAoGPp2Rt8FgV+AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 78D95A3B91;
        Tue, 14 Dec 2021 16:22:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39F5FDA781; Tue, 14 Dec 2021 17:21:48 +0100 (CET)
Date:   Tue, 14 Dec 2021 17:21:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Refactor unlock_up
Message-ID: <20211214162148.GW28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211214133939.751395-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214133939.751395-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 03:39:39PM +0200, Nikolay Borisov wrote:
> The purpose of this function is to unlock all nodes in a btrfs path
> which are above 'lowest_unlock' and whose slot used is different than 0.
> As such it used slightly awkward structure of 'if' as well as somewhat
> cryptic "no_skip" control variable which denotes whether we should
> check the current level of skipiability or no.
> 
> This patch does the following (cosmetic) refactorings:
> 
> * Renames 'no_skip' to 'check_skip' and makes it a boolean. This
> variable controls whether we are below the lowest_unlock/skip_level
> levels.
> 
> * Consolidates the 2 conditions which warrant checking whether the
> current level should be skipped under 1 common if (check_skip) branch,
> this increase indentation level but is not critical.
> 
> * Consolidates the 'skip_level < i && i >= lowest_unlock' and
> 'i >= lowest_unlock && i > skip_level' condition into a common branch
> since those are identical.
> 
> * Eliminates the local extent_buffer variable as in this case it doesn't
> bring anything to function readability.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 62066c034363..ab2ea0b2863c 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1348,33 +1348,34 @@ static noinline void unlock_up(struct btrfs_path *path, int level,
>  {
>  	int i;
>  	int skip_level = level;
> -	int no_skips = 0;
> -	struct extent_buffer *t;
> +	int check_skip = true;

this should be bool, right
