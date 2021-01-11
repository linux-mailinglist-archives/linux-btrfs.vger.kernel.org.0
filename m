Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17B12F21A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbhAKVSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:18:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:50458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbhAKVSD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:18:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D39DFAB92;
        Mon, 11 Jan 2021 21:17:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1309DA701; Mon, 11 Jan 2021 22:15:29 +0100 (CET)
Date:   Mon, 11 Jan 2021 22:15:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Roman Anasal <roman.anasal@bdsu.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
Message-ID: <20210111211529.GE6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Roman Anasal <roman.anasal@bdsu.de>,
        linux-btrfs@vger.kernel.org
References: <20210111190243.4152-1-roman.anasal@bdsu.de>
 <20210111190243.4152-3-roman.anasal@bdsu.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111190243.4152-3-roman.anasal@bdsu.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 08:02:43PM +0100, Roman Anasal wrote:
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6299,12 +6299,18 @@ static int changed_inode(struct send_ctx *sctx,
>  		right_gen = btrfs_inode_generation(sctx->right_path->nodes[0],
>  				right_ii);
>  
> +		u64 left_type = S_IFMT & btrfs_inode_mode(
> +				sctx->left_path->nodes[0], left_ii);
> +		u64 right_type = S_IFMT & btrfs_inode_mode(
> +				sctx->right_path->nodes[0], right_ii);

Minor note, we don't use the declarations mixed with code, so the
variables need to be declared separatelly, but I can fix that unless
there's another reason to update and resend the patches.
