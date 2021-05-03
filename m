Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A13712A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhECIur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhECIur (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 04:50:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C76C06174A;
        Mon,  3 May 2021 01:49:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso4559108wmh.0;
        Mon, 03 May 2021 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bBM0SwmyL24vSMDSlmeLgk7jvyP2F9RB4lw9rD7QFeU=;
        b=bWCrvE2pBKu3m2yy7fF55dhqoSgM00fOlSZA7NF70UvmWNeeU3BjbUheFEPSnl5uDa
         jKrLF1eQu8VO+oIRaITnVGdiyIK9UXpgoOZQVmonZqrdLrGfyZoJC+dAGoh50YwUpPBP
         3WK1aF9IQ1Zkpq0gWENQ5wCaiPs/fORUG+aZ7PZuvZmk2rZ64GOIcLtAgic7G86tIVh+
         pDxP5IXodJi02hV6RLaK2BA/Yx5O5BQM1LVa+3Wg29V1O2bugF6vr9koiMc1Ha8jTG5i
         fMAIUyAv2gS+V1UQv8/AISeY2yCFGNPHsuTTy6RueOlo/+kY93ImL4F6myRV/INIq7J0
         xB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bBM0SwmyL24vSMDSlmeLgk7jvyP2F9RB4lw9rD7QFeU=;
        b=b7R0PF2VoSKHJkTbVyBGIGHBp9BIftiJSmQqSAZMF2Sd2Px8HeZsoBI5IBfJEuYadI
         Qz2/b/IK38ZlSu0O8uso4Prxcli0UlFW0Bb4ipJZJV51CiigVC2VYXJcXNLruSozi6Ab
         /7qpfs/ZwFqz0pGiZNaZVhmG2TiBSn0pnp6jG2q7dPzfYP8ryf+VgQcOv767isZTOFpw
         S8uBbphaCTS1+Fq12Y1ecYPayLIVQJjhJIwyEMyi67DD2ZCPNsVueocEiWwafWt6M3Se
         plufQSLag7AHL9vdjjY1B1tP3cdFvBIaA1Va5kMlIrO5Li4UBb7N8l/SvXCxXT4pdTWJ
         o9BA==
X-Gm-Message-State: AOAM532YA6qJlzK+4/gW/E5Lq08ZztXv4gNRTUnjOjxKs2WY5V6/LpRH
        F4nPSgGPtPbBdswcpuaK6iQ=
X-Google-Smtp-Source: ABdhPJwfRQ7GUGxWCLpcEoZUyT7MIR7VybsFY3NryyEKQXFPq6/jOwxWlvnCkSelnE1k5/1BHXBJHg==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr31415402wmc.51.1620031792997;
        Mon, 03 May 2021 01:49:52 -0700 (PDT)
Received: from ard0534 ([41.62.186.65])
        by smtp.gmail.com with ESMTPSA id r19sm19883771wmq.33.2021.05.03.01.49.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 May 2021 01:49:52 -0700 (PDT)
Date:   Mon, 3 May 2021 09:49:49 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
Message-ID: <20210503084949.GA27017@ard0534>
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
 <eba16312-9d50-9549-76c0-b0512a394669@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eba16312-9d50-9549-76c0-b0512a394669@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 02, 2021 at 12:17:51PM +0200, Christophe JAILLET wrote:
> Le 02/05/2021 à 00:50, Khaled ROMDHANI a écrit :
> > Fix the warning: variable 'zone' is used
> > uninitialized whenever '?:' condition is true.
> > 
> > Fix that by preventing the code to reach
> > the last assertion. If the variable 'mirror'
> > is invalid, the assertion fails and we return
> > immediately.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > ---
> >   fs/btrfs/zoned.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 8250ab3f0868..23da9d8dc184 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -145,7 +145,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
> >   	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> >   	default:
> >   		ASSERT((u32)mirror < 3);
> > -		break;
> > +		return 0;
> >   	}
> >   	ASSERT(zone <= U32_MAX);
> > 
> > base-commit: b5c294aac8a6164ddf38bfbdd1776091b4a1eeba
> > 
> Hi,
> 
> just a few comments.
> 
> If I understand correctly, what you try to do is to silence a compiler
> warning if no case branch is taken.
> 
> First, all your proposals are based on the previous one.
> I find it hard to follow because we don't easily see what are the
> differences since the beginning.
> 
> The "base-commit" at the bottom of your mail, is related to your own local
> tree, I guess. It can't be used by any-one.
> 
> My understanding it that a patch, should it be v2, v3..., must apply to the
> current tree. (In my case, it is the latest linux-next)
> This is not the case here and you have to apply each step to see the final
> result.
> 
> Should this version be fine, a maintainer wouldn't be able to apply it
> as-is.
> 
> You also try to take into account previous comments to check for incorrect
> negative values for minor and catch (the can't happen today) cases, should
> BTRFS_SUPER_MIRROR_MAX change and this function remain the same.
> 
> So, why hard-coding '3'?
> The reason of magic numbers are hard to remember. You should avoid them or
> add a comment about it.
> 
> My own personal variation would be something like the code below (untested).
> 
> Hope this helps.
> 
> CJ
> 
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 70b23a0d03b1..75fe5f001d8b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -138,11 +138,14 @@ static inline u32 sb_zone_number(int shift, int
> mirror)
>  {
>  	u64 zone;
> 
> -	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
> +	ASSERT(mirror >= 0 && mirror < BTRFS_SUPER_MIRROR_MAX);
>  	switch (mirror) {
>  	case 0: zone = 0; break;
>  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
>  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> +	default:
> +		ASSERT(! "mirror < BTRFS_SUPER_MIRROR_MAX but not handled above.");
> +		return 0;
>  	}
> 
>  	ASSERT(zone <= U32_MAX);
>

Thank you for all of your comments. Yes, of course, they will help me.
I will try to handle that more properly.
Thanks again.
