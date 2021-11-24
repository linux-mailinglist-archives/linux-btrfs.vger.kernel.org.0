Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2945CB5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbhKXRv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:51:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59960 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhKXRv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:51:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 49B71218B2;
        Wed, 24 Nov 2021 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637776127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FqL1Pu96XzcusMwXLDUEndV9MVlGLojPqqVuBbre2A=;
        b=pzl1qqHWRi0dJzjoLJXvMvlarUzPI5zyaT2wGaVN04dAgziLQ8a5F7mcYndf/52lfChoMf
        ONFIx8FhxdqkOB8alMGZQ1bUbbLEX5Mnet2eS8CQy3XdLH7jM1KJLPvVl/oRNVNrvtAiWV
        EYSTxetsiFBTHrT9XcVFt5jvh/n5Dzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637776127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FqL1Pu96XzcusMwXLDUEndV9MVlGLojPqqVuBbre2A=;
        b=Pl6p/WRKB15PfGCYlxj/zp5kx5GhfV+8Dv+aEcsFH2G2acWlV8KKJxK+PT7m3QowZj2O+Z
        5GzrktTz57Et7KDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 154A6A3B87;
        Wed, 24 Nov 2021 17:48:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2FF39DA735; Wed, 24 Nov 2021 18:48:38 +0100 (CET)
Date:   Wed, 24 Nov 2021 18:48:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 06/21] btrfs: zoned: move mark_block_group_to_copy to
 zoned code
Message-ID: <20211124174838.GX28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <7515f0e28e89b7c2266bfcc021f9639dd45ae898.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7515f0e28e89b7c2266bfcc021f9639dd45ae898.1637745470.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:32AM -0800, Johannes Thumshirn wrote:
> mark_block_group_to_copy() is only used in zoned filesystems, so move the
> code to zoned code.

Should it rather be moved to block-group.c, as it logically belongs to
the bg API? That it is used by zoned mode is ok, it's the zoned mode
using that particular helper from the API, but otherwise I don't see
anything specific in that helper.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/dev-replace.c | 126 +----------------------------------------
>  fs/btrfs/zoned.c       | 124 ++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h       |   8 +++
>  3 files changed, 133 insertions(+), 125 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 66fa61cb3f235..7572d80bff2ac 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -460,130 +460,6 @@ static char* btrfs_dev_name(struct btrfs_device *device)
>  		return rcu_str_deref(device->name);
>  }
>  
> -static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
> -				    struct btrfs_device *src_dev)
> -{
> -	struct btrfs_path *path;
> -	struct btrfs_key key;
> -	struct btrfs_key found_key;
> -	struct btrfs_root *root = fs_info->dev_root;
> -	struct btrfs_dev_extent *dev_extent = NULL;
> -	struct btrfs_block_group *cache;
> -	struct btrfs_trans_handle *trans;
> -	int ret = 0;
> -	u64 chunk_offset;
> -
> -	/* Do not use "to_copy" on non zoned filesystem for now */
> -	if (!btrfs_is_zoned(fs_info))
> -		return 0;

Let's take this as an example. My idea of removing the btrfs_is_zoned
calls is something like:

Caller:

	if (need_to_copy_bg(fs_info)) {
		ret = btrfs_mark_block_group_to_copy();
		if (ret)
			...;
	}

Where the need_to_copy_bg obviously wraps the is-zoned check. This
allows to separate the layers a and keep btrfs_mark_block_group_to_copy
in block-group.c where it belongs, while not opencoding the zoned inside
random functions.

This adds the indirection and perhaps too trivial wrappers, but reading
the code is not hurt and layers are more separated.

In summary:
- move the is-zoned checks to callers
- add wrappers that follow the semantics of the check (ie. is-zoned is
  an implementation detail)
- move functions to their respective API file if it exists
