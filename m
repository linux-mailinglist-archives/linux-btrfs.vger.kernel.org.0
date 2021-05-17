Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA9382A4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhEQKzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 06:55:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236591AbhEQKzI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 06:55:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96607B039;
        Mon, 17 May 2021 10:53:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F468DAF1B; Mon, 17 May 2021 12:51:18 +0200 (CEST)
Date:   Mon, 17 May 2021 12:51:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
Message-ID: <20210517105117.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Khaled ROMDHANI <khaledromdhani216@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501225046.9138-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 01, 2021 at 11:50:46PM +0100, Khaled ROMDHANI wrote:
> Fix the warning: variable 'zone' is used
> uninitialized whenever '?:' condition is true.
> 
> Fix that by preventing the code to reach
> the last assertion. If the variable 'mirror'
> is invalid, the assertion fails and we return
> immediately.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>

This took several rounds and none of them was close to what I'd consider
a proper fix, for something that's not really important. As Dan said,
smatch does understand the values passed from the callers and the
function is a static inline so the complete information is available. No
tricky analysis is required, so why does not coverity see that too?

We use assertions to namely catch programmer errors and API misuse,
anything that can happen at runtime or depends on input needs proper
checks and error handling. But for the super block copies, the constant
won't change so all we want is to catch the stupid errors.

> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 8250ab3f0868..23da9d8dc184 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -145,7 +145,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
>  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
>  	default:
>  		ASSERT((u32)mirror < 3);
> -		break;
> +		return 0;

It's been pointed out that this does not apply on the current code but
on top of previous versions, so it's not making it easy for me to apply
the patch and do maybe some tweaks only.

I don't mind merging trivial patches, people can learn the process and
few iterations are not a big deal. What I also hope for is to get some
understanding of the code being changed and not just silencing some
tools' warnings.
