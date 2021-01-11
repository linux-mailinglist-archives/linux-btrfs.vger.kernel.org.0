Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E42F224D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbhAKV7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:59:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:33282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKV7I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:59:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B030AB3E;
        Mon, 11 Jan 2021 21:58:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6350FDA701; Mon, 11 Jan 2021 22:56:35 +0100 (CET)
Date:   Mon, 11 Jan 2021 22:56:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/13] btrfs: don't get an EINTR during drop_snapshot for
 reloc
Message-ID: <20210111215635.GI6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135557.git.josef@toxicpanda.com>
 <8813454a8863263bf7d0dd3724b7b1d7014482c5.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8813454a8863263bf7d0dd3724b7b1d7014482c5.1608135557.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:22:05AM -0500, Josef Bacik wrote:
> This was partially fixed by f3e3d9cc35252, however it missed a spot when

Please use full commit reference like f3e3d9cc3525 ("btrfs: avoid
possible signal interruption of btrfs_drop_snapshot() on relocation
tree")

> we restart a trans handle because we need to end the transaction.  The
> fix is the same, simply use btrfs_join_transaction() instead of
> btrfs_start_transaction() when deleting reloc roots.
> 

Added Fixes: f3e3d9cc3525 ("btrfs: avoid possible signal interruption of btrfs_drop_snapshot() on relocation tree")

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d79b8369e6aa..08c664d04824 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5549,7 +5549,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  				goto out_free;
>  			}
>  
> -			trans = btrfs_start_transaction(tree_root, 0);

Added same comment as in f3e3d9cc3525

> +			if (for_reloc)
> +				trans = btrfs_join_transaction(tree_root);
> +			else
> +				trans = btrfs_start_transaction(tree_root, 0);
>  			if (IS_ERR(trans)) {
>  				err = PTR_ERR(trans);
>  				goto out_free;
> -- 
> 2.26.2
