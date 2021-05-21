Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9838C670
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhEUMYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:24:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhEUMYn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:24:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBF30AAA6;
        Fri, 21 May 2021 12:23:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89A42DA733; Fri, 21 May 2021 14:20:44 +0200 (CEST)
Date:   Fri, 21 May 2021 14:20:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: return errors from btrfs_del_csums in
 cleanup_ref_head
Message-ID: <20210521122044.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1621435862.git.josef@toxicpanda.com>
 <73314ceb4a87c4a6fc559834235e63f7aae79570.1621435862.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73314ceb4a87c4a6fc559834235e63f7aae79570.1621435862.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 10:52:46AM -0400, Josef Bacik wrote:
> We are unconditionally returning 0 in cleanup_ref_head, despite the fact
> that btrfs_del_csums could fail.  We need to return the error so the
> transaction gets aborted properly, fix this by returning ret from
> btrfs_del_csums in cleanup_ref_head.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b84bbc24ff57..790de24576ac 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1826,7 +1826,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
>  
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_delayed_ref_root *delayed_refs;
> -	int ret;
> +	int ret = 0;

>  
>  	delayed_refs = &trans->transaction->delayed_refs;

ret is used for a return just after this line

	ret = run_and_cleanup_extent_op(trans, head);

so not necessary to initialize at the declaration

>  
> @@ -1868,7 +1868,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
>  	trace_run_delayed_ref_head(fs_info, head, 0);
>  	btrfs_delayed_ref_unlock(head);
>  	btrfs_put_delayed_ref_head(head);
> -	return 0;
> +	return ret;
>  }
>  
>  static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
> -- 
> 2.26.3
