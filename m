Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA56124DA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfLRQbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:31:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:49828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfLRQbW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:31:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77D64AB71;
        Wed, 18 Dec 2019 16:31:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F1DDDA730; Wed, 18 Dec 2019 17:31:18 +0100 (CET)
Date:   Wed, 18 Dec 2019 17:31:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove BUG_ON used as assertions
Message-ID: <20191218163117.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Aditya Pakki <pakki001@umn.edu>,
        kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191215171237.27482-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215171237.27482-1-pakki001@umn.edu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 15, 2019 at 11:12:36AM -0600, Aditya Pakki wrote:
> alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
> and cannot fail.

Here you say it cannot fail (without a proof)

> There are multiple invocations of BUG_ON on the
> return value to check for failure. The patch replaces certain
> invocations of BUG_ON by returning the error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/btrfs/extent_io.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index eb8bd0258360..e72e5a333e71 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -989,7 +989,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  	node = tree_search_for_insert(tree, start, &p, &parent);
>  	if (!node) {
>  		prealloc = alloc_extent_state_atomic(prealloc);
> -		BUG_ON(!prealloc);
> +		if (!prealloc) {
> +			err = -ENOMEM;
> +			goto out;

And add error handling when it fails, which is in contradiction but
anyway, replacing BUG_ON with error checks requires auditing the whole
call chain up. We've had attempts to do this change already, none of them
was correct so unfortunatelly the BUG_ON needs to stay to avoid errors
being silently ignored.
