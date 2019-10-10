Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0300CD2E8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfJJQ0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfJJQ0Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F545AE78;
        Thu, 10 Oct 2019 16:26:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 824A7DA7E3; Thu, 10 Oct 2019 18:26:37 +0200 (CEST)
Date:   Thu, 10 Oct 2019 18:26:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Rename btrfs_join_transaction_nolock
Message-ID: <20191010162637.GX2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008174306.2395-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008174306.2395-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 08, 2019 at 08:43:06PM +0300, Nikolay Borisov wrote:
> This function is used only during the final phase of freespace cache
> writeout. This is necessary since using the plain btrfs_join_transaction
> api is deadlock prone. The deadlock looks like:
> 
> T1:
> btrfs_commit_Transaction
>  commit_cowonly_roots
>     btrfs_write_dirty_block_groups
>      btrfs_wait_cache_io
>       __btrfs_wait_cache_io
>        btrfs_wait_ordered_range <-- Triggers ordered IO for freespace
>        inode and blocks transaction commit until freespace cache
>        writeout.
> 
> T2: <-- after T1 has triggered the writeout
> finish_ordered_fn
>  btrfs_finish_ordered_io
>   btrfs_join_transaction <--- this would block waiting for current
>   transaction to commit, but since trans commit is waiting for this
>   writeout to finish.
> 
> The special purpose functions prevents it by simply skipping the "wait
> for writeout" since it's guaranteed the transaction won't proceed until
> we are done.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
