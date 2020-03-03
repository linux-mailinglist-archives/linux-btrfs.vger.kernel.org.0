Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08E1779BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgCCPAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 10:00:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:42492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgCCPAO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 10:00:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7227B321;
        Tue,  3 Mar 2020 15:00:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01351DA7AE; Tue,  3 Mar 2020 15:59:50 +0100 (CET)
Date:   Tue, 3 Mar 2020 15:59:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: drop block from cache on error in relocation
Message-ID: <20200303145950.GC2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302184757.44176-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 01:47:51PM -0500, Josef Bacik wrote:
> If we have an error while building the backref tree in relocation we'll
> process all the pending edges and then free the node.  This isn't quite
> right however as the node could be integrated into the existing cache
> partially, linking children within itself into the cache, but not
> properly linked into the cache itself.

I'm missing description of what's the problem. Something is linked and
then freed, followed by 'fixed by'.

> The fix for this is simple, use
> remove_backref_node() instead of free_backref_node(), which will clean
> up the cache related to this node completely.

So this means that some entries are left in the cache? Leaked memory or
something else?

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4fb7e3cc2aca..507361e99316 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  			free_backref_node(cache, lower);
>  		}
>  
> -		free_backref_node(cache, node);
> +		remove_backref_node(cache, node);
>  		return ERR_PTR(err);
>  	}
>  	ASSERT(!node || !node->detached);

There's a similar pattern in clone_backref_node

1317 fail:
1318         while (!list_empty(&new_node->lower)) {
1319                 new_edge = list_entry(new_node->lower.next,
1320                                       struct backref_edge, list[UPPER]);
1321                 list_del(&new_edge->list[UPPER]);
1322                 free_backref_edge(cache, new_edge);
1323         }
1324         free_backref_node(cache, new_node);

Does this also need to be fixed?
