Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26F81763FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 20:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCBTbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 14:31:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgCBTbr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 14:31:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B571AF76;
        Mon,  2 Mar 2020 19:31:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75234DA733; Mon,  2 Mar 2020 20:31:21 +0100 (CET)
Date:   Mon, 2 Mar 2020 20:31:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/7] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before
 dropping the reloc root
Message-ID: <20200302193120.GS2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302184757.44176-6-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 01:47:55PM -0500, Josef Bacik wrote:
> We were doing the clear dance for the reloc root after doing the drop of
> the reloc root, which means we have a giant window where we could miss
> having BTRFS_ROOT_DEAD_RELOC_TREE unset and the reloc_root == NULL.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index e60450c44406..acd21c156378 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2291,18 +2291,19 @@ static int clean_dirty_subvols(struct reloc_control *rc)
>  
>  			list_del_init(&root->reloc_dirty_list);
>  			root->reloc_root = NULL;
> -			if (reloc_root) {
> -
> -				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> -				if (ret2 < 0 && !ret)
> -					ret = ret2;
> -			}
>  			/*
>  			 * Need barrier to ensure clear_bit() only happens after
>  			 * root->reloc_root = NULL. Pairs with have_reloc_root.
>  			 */
>  			smp_wmb();
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> +
> +			if (reloc_root) {
> +
> +				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> +				if (ret2 < 0 && !ret)
> +					ret = ret2;
> +			}

This reverts fix 1fac4a54374f7ef385938f3c6cf7649c0fe4f6cd that moved if
(reloc_root) before the clear_bit.
