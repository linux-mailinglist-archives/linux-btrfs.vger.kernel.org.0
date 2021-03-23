Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B7A345F97
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhCWN0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 09:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhCWNZt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 09:25:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8444AACBF;
        Tue, 23 Mar 2021 13:25:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43C7CDA7AE; Tue, 23 Mar 2021 14:23:43 +0100 (CET)
Date:   Tue, 23 Mar 2021 14:23:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix uninitialized max_chunk_size
Message-ID: <20210323132343.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323124624.1494552-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323124624.1494552-1-arnd@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 23, 2021 at 01:46:19PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ctl->max_chunk_size member might be used uninitialized
> when none of the three conditions for initializing it in
> init_alloc_chunk_ctl_policy_zoned() are true:
> 
> In function ‘init_alloc_chunk_ctl_policy_zoned’,
>     inlined from ‘init_alloc_chunk_ctl’ at fs/btrfs/volumes.c:5023:3,
>     inlined from ‘btrfs_alloc_chunk’ at fs/btrfs/volumes.c:5340:2:
> include/linux/compiler-gcc.h:48:45: error: ‘ctl.max_chunk_size’ may be used uninitialized [-Werror=maybe-uninitialized]
>  4998 |         ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
>       |                               ^~~
> fs/btrfs/volumes.c: In function ‘btrfs_alloc_chunk’:
> fs/btrfs/volumes.c:5316:32: note: ‘ctl’ declared here
>  5316 |         struct alloc_chunk_ctl ctl;
>       |                                ^~~
> 
> Initialize it to UINT_MAX and rely on the min() expression to limit
> it.
> 
> Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Note that the -Wmaybe-unintialized warning is globally disabled
> by default. For some reason I got this warning anyway when building
> this specific file with gcc-11.

The warning catches a theoretical case but this would not happen in
pracitce.  There are three bits to check and that covers all valid
options, but there should be a final else {} like is in
init_alloc_chunk_ctl_policy_regular that does not let the function
continue as that would mean there are worse problems.

btrfs_alloc_chunk
  init_alloc_chunk_ctl
    init_alloc_chunk_ctl_policy_zoned

and btrfs_alloc_chunk validates the ctl->flags against
BTRFS_BLOCK_GROUP_TYPE_MASK, which is exactly the tree branches.

> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bc3b33efddc5..b42b423b6a10 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4980,6 +4980,7 @@ static void init_alloc_chunk_ctl_policy_zoned(
>  	u64 type = ctl->type;
>  
>  	ctl->max_stripe_size = zone_size;
> +	ctl->max_chunk_size = UINT_MAX;

This would allow the min() work but otherwise is not an expected to
happen at all.

>  	if (type & BTRFS_BLOCK_GROUP_DATA) {
>  		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
>  						 zone_size);
> -- 
> 2.29.2
