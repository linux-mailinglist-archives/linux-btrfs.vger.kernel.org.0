Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D73D248B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhGVMpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 08:45:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhGVMpw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 08:45:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 85579203AA;
        Thu, 22 Jul 2021 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626960386;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pTBQdLZZGPP9AkoKNBHnCCeQdP99Sjmgzgl9f/LHH4=;
        b=V0EHwxj2Jo8klCcK+oaLw36kdjpkQaZYqWHldeDv8c/cP+YD0l1WzoAKD3Z7qLo5q+KyI5
        pldSzSIoPq8nqnrbeX77M+MPUnj1TlHrF+kHCuUuYpLkyPVK2OPqUKjYubjQH9CySuo+XF
        ++H2uHyKvhPtohVgWxxjlkuhIfNk8wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626960386;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pTBQdLZZGPP9AkoKNBHnCCeQdP99Sjmgzgl9f/LHH4=;
        b=0AfFyY/APwJ3ARqAPxhRjXRJcOoEbzVl1J6v0qiKBxqWMeZzzoYbxz3BAc0rYiMGHx4vYT
        UYs/XeRGEdSx28Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E755A4044;
        Thu, 22 Jul 2021 13:26:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB4E2DB2A2; Thu, 22 Jul 2021 15:23:44 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:23:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix lock inversion problem when doing qgroup
 extent tracing
Message-ID: <20210722132344.GT19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <19938c9b47e3e14784c9d17f062da1a51261864f.1626885079.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19938c9b47e3e14784c9d17f062da1a51261864f.1626885079.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 05:31:48PM +0100, fdmanana@kernel.org wrote:
>  int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>  			 struct btrfs_fs_info *fs_info, u64 bytenr,
>  			 u64 time_seq, struct ulist **roots,
> -			 bool ignore_offset)
> +			 bool ignore_offset, bool skip_commit_root_sem)

AFAICS, all callers pass false for ignore_offset, it's obvious from the
patch that updated all call sites.

> +	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
> +				   false, true);

>  				ret = btrfs_find_all_roots(NULL, fs_info,
>  						record->bytenr, 0,
> -						&record->old_roots, false);
> +						&record->old_roots, false, false);

>  			ret = btrfs_find_all_roots(trans, fs_info,
> -				record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
> +			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false, false);

>  		ret = btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
> -					   &roots, false);
> +					   &roots, false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> -			false);
> +			false, false);

>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> -			false);
> +			false, false);

The ignore_offset was added for the BTRFS_IOC_LOGICAL_INO_V2 ioctl, but
it's not used anywhere with btrfs_find_all_roots, only
btrfs_find_all_roots_safe that does the lookup by find_parent_nodes and
passed further to low level helpers.

It's been there since c995ab3cda3f ("btrfs: add a flag to
iterate_inodes_from_logical to find all extent refs for uncompressed
extents"), and the parameter was added to btrfs_find_all_roots maybe for
completeness but I'd rather remove it.

As your patch is a fix and for stable@, the cleanup should be a
followup.

Added to misc-next, thanks.
