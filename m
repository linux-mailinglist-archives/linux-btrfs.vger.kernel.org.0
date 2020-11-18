Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8392B8547
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKRUF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 15:05:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:33918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgKRUF7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 15:05:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8953AC6A;
        Wed, 18 Nov 2020 20:05:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34CB8DA701; Wed, 18 Nov 2020 21:04:12 +0100 (CET)
Date:   Wed, 18 Nov 2020 21:04:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 05/24] btrfs: extent_io: extract the btree page
 submission code into its own helper function
Message-ID: <20201118200412.GE20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:30PM +0800, Qu Wenruo wrote:
> In btree_write_cache_pages() we have a btree page submission routine
> buried deeply into a nested loop.
> 
> This patch will extract that part of code into a helper function,
> submit_eb_page(), to do the same work.
> 
> Also, since submit_eb_page() now can return >0 for successful extent
> buffer submission, remove the "ASSERT(ret <= 0);" line.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_io.c | 116 +++++++++++++++++++++++++------------------
>  1 file changed, 69 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index caafe44542e8..fd4845b06989 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3987,10 +3987,75 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>  	return ret;
>  }
>  
> +/*
> + * Submit one page of one extent buffer.
> + *
> + * Will try to submit all pages of one extent buffer, thus will skip some pages
> + * if it's already submitted.

Note that this paragraph

> + *
> + * @page:	The page of one extent buffer
> + * @eb_context:	To determine if we need to submit this page. If current page
> + *		belongs to this eb, we don't need to submit.

belongs under the parameter description, I hope the example is
https://btrfs.wiki.kernel.org/index.php/Development_notes#Coding_style_preferences
instructive enough.
