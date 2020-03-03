Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69E177A7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgCCPc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 10:32:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgCCPc5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 10:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F0A0B143;
        Tue,  3 Mar 2020 15:32:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE80BDA7AE; Tue,  3 Mar 2020 16:32:33 +0100 (CET)
Date:   Tue, 3 Mar 2020 16:32:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/7] btrfs: run clean_dirty_subvols if we fail to start a
 trans
Message-ID: <20200303153233.GE2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302184757.44176-5-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 01:47:54PM -0500, Josef Bacik wrote:
> If we do merge_reloc_roots() we could insert a few roots onto the dirty
> subvol roots list, where we hold a ref on them.  If we fail to start the
> transaction we need to run clean_dirty_subvols() in order to cleanup the
> refs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f42589cb351c..e60450c44406 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4275,6 +4275,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  	/* get rid of pinned extents */
>  	trans = btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> +		clean_dirty_subvols(rc);
>  		err = PTR_ERR(trans);
>  		goto out_free;
>  	}
> @@ -4701,6 +4702,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>  
>  	trans = btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> +		clean_dirty_subvols(rc);
>  		err = PTR_ERR(trans);
>  		goto out_free;
>  	}

Call to clean_dirty subvolumes is just before the out_free label and
also handles errors so the cleanup should be done there and not before
the gotos.
