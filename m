Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6762D15E8DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 18:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404749AbgBNRDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 12:03:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:35070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404533AbgBNRDV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 12:03:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1036DB123;
        Fri, 14 Feb 2020 17:03:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E8DFDA703; Fri, 14 Feb 2020 18:03:05 +0100 (CET)
Date:   Fri, 14 Feb 2020 18:03:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2] btrfs: destroy qgroup extent records on transaction
 abort
Message-ID: <20200214170304.GD2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>
References: <20200211072537.25751-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211072537.25751-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 03:25:37PM +0800, Qu Wenruo wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> We clean up the delayed references when we abort a transaction but
> we leave the pending qgroup extent records behind, leaking memory.
> 
> This patch destroyes the extent records when we destroy the delayed
> refs and checks to ensure they're gone before releasing the transaction.
> 
> Fixes: 3368d001ba5df (btrfs: qgroup: Record possible quota-related extent for qgroup.)
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> [Rebased to latest upstream, remove to_qgroup() helper, use
>  rbtree_postorder_for_each_entry_safe() wrapper]
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Update the commit message to remove to_qgroup()

Added to misc-next, thanks.

> +void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
> +{
> +	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
> +	struct btrfs_qgroup_extent_record *entry;
> +	struct btrfs_qgroup_extent_record *next;
> +	struct rb_root *root = &delayed_refs->dirty_extent_root;

I've removed the delayed_refs varaible indirection:

	root = &trans->delayed_refs.dirty_extent_root;

> +	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
> +		ulist_free(entry->old_roots);
> +		kfree(entry);
> +	}
> +}
