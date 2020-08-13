Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AE243D5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMQ2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 12:28:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgHMQ2S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 12:28:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC940AD5C;
        Thu, 13 Aug 2020 16:28:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 172CEDA6EF; Thu, 13 Aug 2020 18:27:14 +0200 (CEST)
Date:   Thu, 13 Aug 2020 18:27:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 12/23] btrfs: add flushing states for handling data
 reservations
Message-ID: <20200813162714.GN2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
 <20200721142234.2680-13-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721142234.2680-13-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 10:22:23AM -0400, Josef Bacik wrote:
> Currently the way we do data reservations is by seeing if we have enough
> space in our space_info.  If we do not and we're a normal inode we'll
> 
> 1) Attempt to force a chunk allocation until we can't anymore.
> 2) If that fails we'll flush delalloc, then commit the transaction, then
>    run the delayed iputs.
> 
> If we are a free space inode we're only allowed to force a chunk
> allocation.  In order to use the normal flushing mechanism we need to
> encode this into a flush state array for normal inodes.  Since both will
> start with allocating chunks until the space info is full there is no
> need to add this as a flush state, this will be handled specially.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h      | 2 ++
>  fs/btrfs/space-info.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e882ae15eea..a181f4959a1d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2592,6 +2592,8 @@ enum btrfs_reserve_flush_enum {
>  	 *
>  	 * Can be interruped by fatal signal.
>  	 */
> +	BTRFS_RESERVE_FLUSH_DATA,
> +	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,

The new states are inserted between a comment that is there for the
FLUSH_ALL state. I'm not sure it's still valid or needs separate
comments and can't tell from looking at other patches in the series.

>  	BTRFS_RESERVE_FLUSH_ALL,
