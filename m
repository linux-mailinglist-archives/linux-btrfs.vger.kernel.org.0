Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3E46A4DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 19:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbhLFStf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 13:49:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42212 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLFSte (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 13:49:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5D45E212C8;
        Mon,  6 Dec 2021 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638816364;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mo+lfhbgT2SNyiInDCNpEqw824PEmjwFaMD3MRCej7I=;
        b=tu1Nz+Px1tnswmGNH/hgrW30JQo1exABQUSDSxPo6Iq3FJ7xs55H0E1cuJXz23iu/HMNyU
        6POGxnHguWB+7kky6UAAPHFwU0IzZXEusC4EB0buCoMP1GOkLjiJYOmt77QpAJLjS0dLSq
        Lkti7d9TU2CjoQyFQhzX0n2JALCurw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638816364;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mo+lfhbgT2SNyiInDCNpEqw824PEmjwFaMD3MRCej7I=;
        b=618gTQAl34jf9vEKtLLhS66CSglM3YNJ/zwU+SO1GpGmS2NLJ5XnBnocobEXksKyXhIBjI
        /wLqx/NflxlEXrDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5449CA3B84;
        Mon,  6 Dec 2021 18:46:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 30EEEDA799; Mon,  6 Dec 2021 19:45:50 +0100 (CET)
Date:   Mon, 6 Dec 2021 19:45:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/18] btrfs: add an inode-item.h
Message-ID: <20211206184549.GT28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1638569556.git.josef@toxicpanda.com>
 <da8f34d466181ae99ccc229088f6173ce42914ae.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da8f34d466181ae99ccc229088f6173ce42914ae.1638569556.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 05:18:03PM -0500, Josef Bacik wrote:
> We have a few helpers in inode-item.c, and I'm going to make a few
> changes to how we do truncate in the future, so break out these
> definitions into their own header file to trim down ctree.h some and
> make it easier to do the work on truncate in the future.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h            | 30 ------------------------------
>  fs/btrfs/delayed-inode.c    |  1 +
>  fs/btrfs/free-space-cache.c |  1 +
>  fs/btrfs/inode-item.c       |  1 +
>  fs/btrfs/inode-item.h       | 37 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/inode.c            |  1 +
>  fs/btrfs/relocation.c       |  1 +
>  fs/btrfs/tree-log.c         |  1 +
>  8 files changed, 43 insertions(+), 30 deletions(-)
>  create mode 100644 fs/btrfs/inode-item.h
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index dfee4b403da1..f33cae82e7dd 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3126,36 +3126,6 @@ int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
>  			  struct btrfs_root *root, u64 offset);
>  int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
>  
> -/* inode-item.c */
> -int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
> -			   struct btrfs_root *root,
> -			   const char *name, int name_len,
> -			   u64 inode_objectid, u64 ref_objectid, u64 index);
> -int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
> -			   struct btrfs_root *root,
> -			   const char *name, int name_len,
> -			   u64 inode_objectid, u64 ref_objectid, u64 *index);
> -int btrfs_insert_empty_inode(struct btrfs_trans_handle *trans,
> -			     struct btrfs_root *root,
> -			     struct btrfs_path *path, u64 objectid);
> -int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
> -		       *root, struct btrfs_path *path,
> -		       struct btrfs_key *location, int mod);
> -
> -struct btrfs_inode_extref *
> -btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
> -			  struct btrfs_root *root,
> -			  struct btrfs_path *path,
> -			  const char *name, int name_len,
> -			  u64 inode_objectid, u64 ref_objectid, int ins_len,
> -			  int cow);
> -
> -struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
> -						   int slot, const char *name,
> -						   int name_len);
> -struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
> -		struct extent_buffer *leaf, int slot, u64 ref_objectid,
> -		const char *name, int name_len);
>  /* file-item.c */
>  struct btrfs_dio_private;
>  int btrfs_del_csums(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 6f134f2c5e68..748bf6b0d860 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -13,6 +13,7 @@
>  #include "ctree.h"
>  #include "qgroup.h"
>  #include "locking.h"
> +#include "inode-item.h"
>  
>  #define BTRFS_DELAYED_WRITEBACK		512
>  #define BTRFS_DELAYED_BACKGROUND	128
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 132209ff2262..55e1be703a39 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -23,6 +23,7 @@
>  #include "block-group.h"
>  #include "discard.h"
>  #include "subpage.h"
> +#include "inode-item.h"
>  
>  #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
>  #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 56755ce9a907..72593a93c43c 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include "ctree.h"
> +#include "inode-item.h"
>  #include "disk-io.h"
>  #include "transaction.h"
>  #include "print-tree.h"
> diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
> new file mode 100644
> index 000000000000..cb4b140e3b7d
> --- /dev/null
> +++ b/fs/btrfs/inode-item.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_INODE_ITEM_H
> +#define BTRFS_INODE_ITEM_H
> +

Please don't forget to add forward declarations for all structure types
and include all other necessary headers for eg. u64 when adding a new
header. I'll add it now.
