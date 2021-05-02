Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0CE370B14
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhEBKSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 May 2021 06:18:49 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57685 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhEBKSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 May 2021 06:18:49 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d27 with ME
        id zmHs2400F21Fzsu03mHtWf; Sun, 02 May 2021 12:17:54 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 May 2021 12:17:54 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <eba16312-9d50-9549-76c0-b0512a394669@wanadoo.fr>
Date:   Sun, 2 May 2021 12:17:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210501225046.9138-1-khaledromdhani216@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 02/05/2021 à 00:50, Khaled ROMDHANI a écrit :
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
> ---
>   fs/btrfs/zoned.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 8250ab3f0868..23da9d8dc184 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -145,7 +145,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
>   	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
>   	default:
>   		ASSERT((u32)mirror < 3);
> -		break;
> +		return 0;
>   	}
>   
>   	ASSERT(zone <= U32_MAX);
> 
> base-commit: b5c294aac8a6164ddf38bfbdd1776091b4a1eeba
> 
Hi,

just a few comments.

If I understand correctly, what you try to do is to silence a compiler 
warning if no case branch is taken.

First, all your proposals are based on the previous one.
I find it hard to follow because we don't easily see what are the 
differences since the beginning.

The "base-commit" at the bottom of your mail, is related to your own 
local tree, I guess. It can't be used by any-one.

My understanding it that a patch, should it be v2, v3..., must apply to 
the current tree. (In my case, it is the latest linux-next)
This is not the case here and you have to apply each step to see the 
final result.

Should this version be fine, a maintainer wouldn't be able to apply it 
as-is.

You also try to take into account previous comments to check for 
incorrect negative values for minor and catch (the can't happen today) 
cases, should BTRFS_SUPER_MIRROR_MAX change and this function remain the 
same.

So, why hard-coding '3'?
The reason of magic numbers are hard to remember. You should avoid them 
or add a comment about it.

My own personal variation would be something like the code below (untested).

Hope this helps.

CJ


diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 70b23a0d03b1..75fe5f001d8b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -138,11 +138,14 @@ static inline u32 sb_zone_number(int shift, int 
mirror)
  {
  	u64 zone;

-	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+	ASSERT(mirror >= 0 && mirror < BTRFS_SUPER_MIRROR_MAX);
  	switch (mirror) {
  	case 0: zone = 0; break;
  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	default:
+		ASSERT(! "mirror < BTRFS_SUPER_MIRROR_MAX but not handled above.");
+		return 0;
  	}

  	ASSERT(zone <= U32_MAX);

