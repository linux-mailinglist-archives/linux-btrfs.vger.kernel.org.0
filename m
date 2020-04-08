Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C668E1A27D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 19:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDHRTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 13:19:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgDHRTP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 13:19:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7849AB5C;
        Wed,  8 Apr 2020 17:19:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B662BDA730; Wed,  8 Apr 2020 19:18:36 +0200 (CEST)
Date:   Wed, 8 Apr 2020 19:18:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: fix reclaim counter leak of space_info objects
Message-ID: <20200408171836.GZ5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200407103849.28086-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407103849.28086-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 11:38:49AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Whenever we add a ticket to a space_info object we increment the object's
> reclaim_size counter witht the ticket's bytes, and we decrement it with
> the corresponding amount only when we are able to grant the requested
> space to the ticket. When we are not able to grant the space to a ticket,
> or when the ticket is removed due to a signal (e.g. an application has
> received sigterm from the terminal) we never decrement the counter with
> the corresponding bytes from the ticket. This leak can result in the
> space reclaim code to later do much more work than necessary. So fix it
> by decrementing the counter when those two cases happen as well.
> 
> Fixes: db161806dc5615 ("btrfs: account ticket size at add/delete time")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

There's a minor conflict with Josef's patch "btrfs: run
btrfs_try_granting_tickets if a priority ticket fails" so I'll apply
yours to misc-5.7 as it's a regression fix.

> @@ -1121,7 +1129,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  		 * either the async reclaim job deletes the ticket from the list
>  		 * or we delete it ourselves at wait_reserve_ticket().
>  		 */
> -		list_del_init(&ticket->list);
> +		remove_ticket(space_info, ticket);
>  		if (!ret)
>  			ret = -ENOSPC;
>  	}

The conflicting hunk is:

--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1156,11 +1156,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
        ret = ticket->error;
        if (ticket->bytes || ticket->error) {
                /*
-                * Need to delete here for priority tickets. For regular tickets
-                * either the async reclaim job deletes the ticket from the list
-                * or we delete it ourselves at wait_reserve_ticket().
+                * We were a priority ticket, so we need to delete ourselves
+                * from the list.  Because we could have other priority tickets
+                * behind us that require less space, run
+                * btrfs_try_granting_tickets() to see if their reservations can
+                * now be made.
                 */
-               list_del_init(&ticket->list);
+               if (!list_empty(&ticket->list)) {
+                       list_del_init(&ticket->list);
+                       btrfs_try_granting_tickets(fs_info, space_info);
+               }
+
                if (!ret)
                        ret = -ENOSPC;
        }
---

so I assume the correct fixup is to replace list_del_init with
remove_ticket.
