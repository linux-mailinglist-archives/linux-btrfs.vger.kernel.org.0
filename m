Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255D931FDBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 18:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSRQ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 12:16:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:59672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSRQ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 12:16:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E346B112;
        Fri, 19 Feb 2021 17:15:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C52FFDA84F; Fri, 19 Feb 2021 18:13:47 +0100 (CET)
Date:   Fri, 19 Feb 2021 18:13:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Holger Hoffst?tte <holger@applied-asynchrony.com>,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: error in backport of 'btrfs: fix possible free space tree
 corruption with online conversion'
Message-ID: <20210219171347.GG1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Holger Hoffst?tte <holger@applied-asynchrony.com>,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
References: <20210219111741.95DD.409509F4@e16-tech.com>
 <d07905be-f714-3cbd-01c7-d348ea13c07e@applied-asynchrony.com>
 <20210219232049.554C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219232049.554C.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 11:20:51PM +0800, Wang Yugui wrote:
> > Out of curiosity I decided to check how this happened, but don't see it.
> > Here is the commit that went into 5.10.13 and it looks correct to me:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57
> 
> > The patch that went into 5.10 looks identical to the original commit in 5.11.
> > What tree are you looking at?
> 
> the 5.10.y is the URL that you point out.
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57
> 
> but the right one for 5.11 is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs?id=2f96e40212d435b328459ba6b3956395eed8fa9f
> 
> 5.11:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs?id=2f96e40212d435b328459ba6b3956395eed8fa9f
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0225c5208f44c..47ca8edafb5e6 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -564,6 +564,9 @@ enum {
>  
>  	/* Indicate that we need to cleanup space cache v1 */
>  	BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
> +
> +	/* Indicate that we can't trust the free space tree for caching yet */
> +	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
>  };
>  
>  /*
> 
> but 5.10.y:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e01545538e07f..30ea9780725ff 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -146,6 +146,9 @@ enum {
>  	BTRFS_FS_STATE_DEV_REPLACING,
>  	/* The btrfs_fs_info created for self-tests */
>  	BTRFS_FS_STATE_DUMMY_FS_INFO,
> +
> +	/* Indicate that we can't trust the free space tree for caching yet */
> +	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
>  };
>  
>  #define BTRFS_BACKREF_REV_MAX		256
> 
> Both the line(Line:146 vs Line:564) and the content are wrong.

You're right, good catch.

The wrong value corresponds to BTRFS_FS_QUOTA_ENABLE in the right enum
set, so this could collide. With quotas enabled the on-line conversion
won't be possible as the free space tree would be considered untrusted.
The other way around, no quotas enabled by user, but with tree
conversion going on, then there are a lot of check for the bit set, now
it won't have the quota tree and other structures initialized. This
could be problmenatic.

I'll send a fixup.
