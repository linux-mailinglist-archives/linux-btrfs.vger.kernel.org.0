Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC01D175C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgEMOS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 10:18:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733142AbgEMOS5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 10:18:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6CCCAFA7;
        Wed, 13 May 2020 14:18:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57F0DDA703; Wed, 13 May 2020 16:18:04 +0200 (CEST)
Date:   Wed, 13 May 2020 16:18:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Rename BTRFS_ROOT_REF_COWS to
 BTRFS_ROOT_SHAREABLE
Message-ID: <20200513141802.GL18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200513061611.111807-1-wqu@suse.com>
 <20200513061611.111807-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513061611.111807-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 13, 2020 at 02:16:10PM +0800, Qu Wenruo wrote:
> The name BTRFS_ROOT_REF_COWS is not helpful to show what it really
> means.
> 
> In fact, that bit can only be set to those trees:
> - Subvolume roots
> - Data reloc root
> - Reloc roots for above roots
> 
> All other trees won't get this bit set.
> So just by the result, it is obvious that, roots with this bit set can
> have tree blocks shared with other trees.
> Either shared by snapshots, or by reloc roots (an special snapshot
> created by relocation).
> 
> This patch will rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE to
> make it easier to understand, and update all comment mentioning
> "reference counted" to follow the rename.

The new name sounds good to me.

> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1275,12 +1275,13 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>  	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
>  
>  	/*
> -	 * DON'T set REF_COWS for log trees
> +	 * DON'T set SHAREABLE bit for log trees.
>  	 *
> -	 * log trees do not get reference counted because they go away
> -	 * before a real commit is actually done.  They do store pointers
> -	 * to file data extents, and those reference counts still get
> -	 * updated (along with back refs to the log tree).
> +	 * User has no way to create snapshot for log trees, and they go away
> +	 * before a real commit is actually done.

I think that refering to 'user' is confusing as the reference counting
or the sharing is an internal mechanics, there's no existing interface
for users to directly manipulate the log trees.

> +	 *
> +	 * They do store pointers to file data extents, and those reference
> +	 * counts still get updated (along with back refs to the log tree).
>  	 */
