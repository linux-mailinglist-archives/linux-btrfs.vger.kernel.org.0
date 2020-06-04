Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88C1EE936
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgFDRO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 13:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbgFDROy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jun 2020 13:14:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C23FAABC2;
        Thu,  4 Jun 2020 17:14:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C381DDA818; Thu,  4 Jun 2020 19:14:49 +0200 (CEST)
Date:   Thu, 4 Jun 2020 19:14:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Btrfs: remove no longer necessary chunk mutex
 locking cases
Message-ID: <20200604171449.GG27034@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200601181227.28585-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601181227.28585-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 01, 2020 at 07:12:27PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Initially when the 'removed' flag was added to a block group to avoid
> races between block group removal and fitrim, by commit 04216820fe83d5
> ("Btrfs: fix race between fs trimming and block group remove/allocation"),
> we had to lock the chunks mutex because we could be moving the block
> group from its current list, the pending chunks list, into the pinned
> chunks list, or we could just be adding it to the pinned chunks if it was
> not in the pending chunks list. Both lists were protected by the chunk
> mutex.
> 
> However we no longer have those lists since commit 1c11b63eff2a67
> ("btrfs: replace pending/pinned chunks lists with io tree"), and locking
> the chunk mutex is no longer necessary because of that. The same happens
> at btrfs_unfreeze_block_group(), we lock the chunk mutex because the block
> group's extent map could be part of the pinned chunks list and the call
> to remove_extent_mapping() could be deleting it from that list, which
> used to be protected by that mutex.
> 
> So just remove those lock and unlock calls as they are not needed anymore.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Rebased on 5.8 changes, since the previous patch had to be rebased too.

2 and 3 in misc next, thanks.
