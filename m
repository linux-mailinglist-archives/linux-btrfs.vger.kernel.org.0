Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361391EE92E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgFDRLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 13:11:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbgFDRLQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jun 2020 13:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DB18AC20;
        Thu,  4 Jun 2020 17:11:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CD35DA818; Thu,  4 Jun 2020 19:11:11 +0200 (CEST)
Date:   Thu, 4 Jun 2020 19:11:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Btrfs: fix a block group ref counter leak after
 failure to remove block group
Message-ID: <20200604171111.GF27034@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200601181206.24852-1-fdmanana@kernel.org>
 <20200603101112.23369-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603101112.23369-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 03, 2020 at 11:11:12AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When removing a block group, if we fail to delete the block group's item
> from the extent tree, we jump to the 'out' label and end up decrementing
> the block group's reference count once only (by 1), resulting in a counter
> leak because the block group at that point was already removed from the
> block group cache rbtree - so we have to decrement the reference count
> twice, once for the rbtree and once for our lookup at the start of the
> function.
> 
> There is a second bug where if removing the free space tree entries (the
> call to remove_block_group_free_space()) fails we end up jumping to the
> 'out_put_group' label but end up decrementing the reference count only
> once, when we should have done it twice, since we have already removed
> the block group from the block group cache rbtree. This happens because
> the reference count decrement for the rbtree reference happens after
> attempting to remove the free space tree entries, which is far away from
> the place where we remove the block group from the rbtree.
> 
> To make things less error prone, decrement the reference count for the
> rbtree immediately after removing the block group from it. This also
> eleminates the need for two different exit labels on error, renaming
> 'out_put_label' to just 'out' and removing the old 'out'.
> 
> Fixes: f6033c5e333238 ("btrfs: fix block group leak when removing fails")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Updated changelog to describe a second bug the patch fixes, pointed
>     out by Nikolay.

V2 updated in misc-next, thanks.
