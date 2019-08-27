Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E59EF74
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfH0PxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 11:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726257AbfH0PxX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:53:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB1B0AFDF
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 15:53:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2ED36DA8D5; Tue, 27 Aug 2019 17:53:46 +0200 (CEST)
Date:   Tue, 27 Aug 2019 17:53:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Make btrfs_find_name_in_ext_backref return
 struct btrfs_inode_extref
Message-ID: <20190827155345.GP2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190827114630.2425-1-nborisov@suse.com>
 <20190827114630.2425-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827114630.2425-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 02:46:29PM +0300, Nikolay Borisov wrote:
> btrfs_find_name_in_ext_backref returns either 0/1 depending on whether it
> found a backref for the given name. If it returns true then the actual
> inode_ref struct is returned in one of its parameters. That's pointless,
> instead refactor the function such that it returns either a pointer
> to the btrfs_inode_extref or NULL it it didn't find anything. This
> streamlines the function calling convention.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h      |  9 ++++-----
>  fs/btrfs/inode-item.c | 33 +++++++++++++--------------------
>  fs/btrfs/tree-log.c   |  6 +++---
>  3 files changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 11312aeb6ff6..8b9469df8e3f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2863,11 +2863,10 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
>  struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
>  						   int slot, const char *name,
>  						   int name_len);
> -int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
> -				   u64 ref_objectid, const char *name,
> -				   int name_len,
> -				   struct btrfs_inode_extref **extref_ret);
> -
> +struct btrfs_inode_extref *
> +btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
> +			       u64 ref_objectid, const char *name,
> +			       int name_len);

Please use the common style for function declarations/definitions with
type and name on one line.
