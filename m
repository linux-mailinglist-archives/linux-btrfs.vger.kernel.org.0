Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2E369100
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDWLWV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhDWLWU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:22:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99976B10B;
        Fri, 23 Apr 2021 11:21:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DB8BDA7FE; Fri, 23 Apr 2021 13:19:23 +0200 (CEST)
Date:   Fri, 23 Apr 2021 13:19:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/2] btrfs: Remove unused function btrfs_reada_detach()
Message-ID: <20210423111923.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406162404.11746-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 11:24:03AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_reada_detach() is not called by any function. Remove.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h | 1 -
>  fs/btrfs/reada.c | 9 +--------
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f2fd73e58ee6..2acbd8919611 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3700,7 +3700,6 @@ struct reada_control {
>  struct reada_control *btrfs_reada_add(struct btrfs_root *root,
>  			      struct btrfs_key *start, struct btrfs_key *end);
>  int btrfs_reada_wait(void *handle);
> -void btrfs_reada_detach(void *handle);
>  int btree_readahead_hook(struct extent_buffer *eb, int err);
>  void btrfs_reada_remove_dev(struct btrfs_device *dev);
>  void btrfs_reada_undo_remove_dev(struct btrfs_device *dev);
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 06713a8fe26b..0d357f8b65bc 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -24,7 +24,7 @@
>   * To trigger a readahead, btrfs_reada_add must be called. It will start
>   * a read ahead for the given range [start, end) on tree root. The returned
>   * handle can either be used to wait on the readahead to finish
> - * (btrfs_reada_wait), or to send it to the background (btrfs_reada_detach).
> + * (btrfs_reada_wait).

btrfs_reada_detach is part of public readahead API, providing the
background readahead.
