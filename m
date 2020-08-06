Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A123DF75
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Aug 2020 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgHFRr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Aug 2020 13:47:58 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:55729 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730153AbgHFRrr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Aug 2020 13:47:47 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id 3jzTkxGGKDvSy3jzTkMGpz; Thu, 06 Aug 2020 19:47:44 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1596736064; bh=exgdnzkZkbZheknSipBy5iLgMkOVBrirCEItJqPHE9k=;
        h=From;
        b=BfBWpNXEJeNIjMoWkxzjMw/KuQ8iOb6XQ3QgiwiIZsjCRWn/U7djY3ZROYj55WlJr
         VPlAKMRK8lmw6iwIMksrzMIgzdnTvQmr7Jdx8meY9Irc4pV//PFaj5sHtE5/PH51CX
         SBpjYffw/KqClgZEyurHRq4jqpK5dn2hU8wMOWCja8dAC/Gv/3xCD2aHy19og91jRa
         GKz8iYg99oVGIkqXhuhK1aSheiF/kBv15FYxqEAxsoYPK6Z1uJwhrcyH3iz/GugJIR
         i6t+NfB2jHK/pga08d5qypHFb2L0GJ5qucuTeyR6ZCHblCAh8U5E4jYPb9coY1sPwG
         62D34ueQFKyPQ==
X-CNFS-Analysis: v=2.3 cv=b9DMHeOx c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=a2Cch_sRRIrYQifjjCcA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: docs: update the stability and performance
 status of quota
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200806072906.358641-1-wqu@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <7c72a892-da46-6ad6-446b-5ac7b10dc47d@libero.it>
Date:   Thu, 6 Aug 2020 19:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806072906.358641-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKDpKFNTAuUlYnmiTrPXuR+4PujcPL1rfLVI1wphxgrQO9W/RRd+AT14/iYZdAMh91L4yQ97A0ltMBZmwRYK8ZM/89KQFBWDO8EbIuvSUxxDtcykhM0O
 7YC59PDUPrrbL5pM9gMPP9TEsXn6GZtCrM/Rr+bTZY5E9h/krJHUHB4wCFVTHFQx1DHdlaG+iIuOkw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/20 9:29 AM, Qu Wenruo wrote:
> There are a lot of enhancement to btrfs quota through v5.x releases.
> 
> Now btrfs quota is more stable than it used to be.
> 
> So update the man page to relect this.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   Documentation/btrfs-quota.asciidoc | 43 +++++++++++++++++++++++++-----
>   1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/btrfs-quota.asciidoc b/Documentation/btrfs-quota.asciidoc
> index 85ebf729c2fa..1c032f11d001 100644
> --- a/Documentation/btrfs-quota.asciidoc
> +++ b/Documentation/btrfs-quota.asciidoc
> @@ -23,16 +23,47 @@ PERFORMANCE IMPLICATIONS
>   ~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   When quotas are activated, they affect all extent processing, which takes a
> -performance hit. Activation of qgroups is not recommended unless the user
> -intends to actually use them.
> +performance hit.
> +
> +Under most cases, the performance hit should be more or less acceptable for
> +root fs usage.
> +
> +There used to be a huge performance hit for balance with quota enabled.
> +That problem is solved since v5.4 kernel.
>   
>   STABILITY STATUS
>   ~~~~~~~~~~~~~~~~
>   
> -The qgroup implementation has turned out to be quite difficult as it affects
> -the core of the filesystem operation. Qgroup users have hit various corner cases
> -over time, such as incorrect accounting or system instability. The situation is
> -gradually improving and issues found and fixed.
> +Btrfs quota has different stablity for different functionality:
> +
> +Extent accounting
> +^^^^^^^^^^^^^^^^^
> +
> +Pretty stable, there aren't many bugs (if any) affecting the extent accounting
> +through v5.x release cycles.
> +
> +Thus if users just want referenced/exclusive usage of each subvolume, it
> +should be safe to use.
> +
> +Limit
> +^^^^^
> +
> +Should be near stable since v5.9.

Is it correct v5.9 ? We are at v5.8....

> +
> +There used to be some bugs causing early EDQUOT errors before v5.9.
> +But v5.9 should solve them quite well, along with extra safe nets catching any
> +reserved space leakage.
> +
> +Corner cases and small fixes may pop up time by time, but the core limit
> +functionality should be in good shape since v5.9.
> +
> +Multi-level qgroups
> +^^^^^^^^^^^^^^^^^^^
> +
> +Needs more testing. Although the core extent accounting should also work well
> +for higher level qgroups, we don't have good enough test coverage yet.
> +
> +Thus extra testing and bug reports are welcomed.
>   
>   HIERARCHICAL QUOTA GROUP CONCEPTS
>   ---------------------------------
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
