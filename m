Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC819AEDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgDAPh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 11:37:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbgDAPh6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 11:37:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D941BABF6;
        Wed,  1 Apr 2020 15:37:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78D83DA727; Wed,  1 Apr 2020 17:37:22 +0200 (CEST)
Date:   Wed, 1 Apr 2020 17:37:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 01/39] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
Message-ID: <20200401153720.GS5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326083316.48847-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 04:32:38PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -78,4 +78,43 @@ struct prelim_ref {
>  	u64 wanted_disk_byte;
>  };
>  
> +/*
> + * Helper structure to help iterate backrefs of one extent.
> + *
> + * Now it only supports iteration for tree block in commit root.
> + */
> +struct btrfs_backref_iter {
> +	u64 bytenr;
> +	struct btrfs_path *path;
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_key cur_key;
> +	u32 item_ptr;
> +	u32 cur_ptr;
> +	u32 end_ptr;
> +};
> +
> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(
> +		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
> +
> +static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
> +{
> +	if (!iter)
> +		return;
> +	btrfs_free_path(iter->path);
> +	kfree(iter);
> +}

Why do you make so many functions static inline? It makes sense for some
of them but in the following patches there are functions that are either
too big (so when they're inlined it bloats the asm) or called
infrequently so the inlining does not bring much. Code in header files
should be kept to minimum.

There are also functions not used anywhere else than in backref.c so
they don't need to be exported for now. For example
btrfs_backref_iter_is_inline_ref.

> +
> +int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
> +
> +static inline void
> +btrfs_backref_iter_release(struct btrfs_backref_iter *iter)

Please keep the function type and name on the same line, arguments can
go to the next line.

> +{
> +	iter->bytenr = 0;
> +	iter->item_ptr = 0;
> +	iter->cur_ptr = 0;
> +	iter->end_ptr = 0;
> +	btrfs_release_path(iter->path);
> +	memset(&iter->cur_key, 0, sizeof(iter->cur_key));
> +}
> +
>  #endif
> -- 
> 2.26.0
