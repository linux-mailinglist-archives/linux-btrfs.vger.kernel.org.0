Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456564834CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiACQd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 11:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiACQd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 11:33:27 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C5C061761
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 08:33:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id m25so30874039qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jan 2022 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdZQY1pJWDz5ZIpUqZejPJlmPU2/98w1sFDmlnJKfPk=;
        b=V772ROCH5xIx6e0iPmeCKU6EMkQ+om2wgROL5GAjpwZsxrd1pHbUWO8Du7GzH8Ttry
         lZ7jNTrurBVSHdooyIozL8oQMQyghwlywy63e0ivm5jqLHZb9GO04OXl0Rq2zJ8ct7IR
         VE+4CNkOOgp4vZNjRaaLMySydhvv6dyZ1CeQ/Tz+IT1NuTzeEYFFZdJJd73A0wbh0bis
         7LPca4G0opOPUztFMJ7QhA2LnAzypJX5wUTMWdZG/J8WyjgKbAenVTnC5yEWedkcCONl
         bAZGWnsA4mYwuNHyzLL0/8u/kG1fzUjrimFmcq1J4jqXvBimkETPhE9i3ACICOJtMAZy
         Xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdZQY1pJWDz5ZIpUqZejPJlmPU2/98w1sFDmlnJKfPk=;
        b=j+nlvIImqTDRVfWTmHQKdmpJ3lXna8O42t/drkQKvnEan7SjbkCp5mWwWocpeEhIVr
         24NSPWj+y/7pAW+oIHKZt7M+QYAN264uJZvh6ik3nAeCidqi3dpPjUYkXrAAN89RvpFn
         dhPIXcnAIS10mb4ccESpp3FHmM9RL50YIntWWRL1cHs6QB0WdMMz8pjbhrH7jjLajpen
         6/t7kHiwfHl/M2L2ToPdMpVW53bGMpuwQjaQUtrrz4yKg2EzkTl5oE8iZKoR2JihDE/r
         01v9wIEzOMy5rasLj5i6yzoB8n/aMzBnHsAUy08NU0IGHY1QaN1kAOU8eHixWRrM+DQa
         +ysA==
X-Gm-Message-State: AOAM531PUAwcOrORdvTcTJDOC1Y7HiNNaQY/VSOkl73bCZ6TujCZSaX6
        gnMVrDSvwK0eOIzbijFSDD4yrFUS31zYdg==
X-Google-Smtp-Source: ABdhPJyzROZiSIvOgN4yKoF19dasjE1Eux519weEwZtVzzoy1jgtlcEvXrkQ29NCYaABC7EVaMvoYw==
X-Received: by 2002:a05:622a:1706:: with SMTP id h6mr40808091qtk.201.1641227606432;
        Mon, 03 Jan 2022 08:33:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j13sm25535153qta.76.2022.01.03.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:33:26 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:33:25 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] btrfs: introduce dedicated helper to scrub
 simple-stripe based range
Message-ID: <YdMlVbcZ0EdjwqWr@localhost.localdomain>
References: <20211221023349.27696-1-wqu@suse.com>
 <20211221023349.27696-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221023349.27696-4-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 21, 2021 at 10:33:48AM +0800, Qu Wenruo wrote:
> The new entrance will iterate through each data stripe which belongs to
> the target device.
> 
> And since inside each data stripe, RAID0 is just SINGLE, while RAID10 is
> just RAID1, we can reuse scrub_simple_mirror() to do the scrub properly.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 60 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ddd069bd2375..aff9db6fbc7e 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3446,6 +3446,55 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>  	return ret;
>  }
>  
> +static int scrub_simple_stripe(struct scrub_ctx *sctx,
> +				struct btrfs_root *extent_root,
> +				struct btrfs_root *csum_root,
> +				struct btrfs_block_group *bg,
> +				struct map_lookup *map,
> +				struct btrfs_device *device,
> +				int stripe_index)
> +{
> +	/* The increment of logical bytenr */
> +	const u64 logical_increment = (map->num_stripes / map->sub_stripes) *
> +				      map->stripe_len;
> +	/*
> +	 * Our starting logical bytenr needs to be calculated based on
> +	 * stripe_index.
> +	 *
> +	 * stripe_index / sub_stripes gives how many data stripes we need to
> +	 * skip.
> +	 */
> +	const u64 orig_logical = (stripe_index / map->sub_stripes) *
> +				 map->stripe_len + bg->start;
> +	const u64 orig_physical = map->stripes[stripe_index].physical;
> +	/*
> +	 * For RAID0, it's fixed to 1.
> +	 * For RAID10, the mirror_num is always 0,1,0,1,...
> +	 */
> +	const int mirror_num = stripe_index % map->sub_stripes + 1;

For me I don't like having big comment blocks in the variable declaration part,
it makes it hard to read.

Also we have this sort of map math in a variety of different places.  If it's
complex enough that it needs a comment then I think it would be good to have
static inline helpers with the math required to get the information we want,
which comments that exist there.  Probably not needed for every little peice of
math, but for the common ones we do all the time it would be good.

If it doesn't make sense for any of the above things I would prefer to see
something like

/*
 * logical_increment - the the size to increment based on the stripe size.
 * orig_logical - the actual logical bytenr based on the stripe we're scrubbing.
 * <etc>
 */
static int scrub_simple_stripe()

I'm not 100% married to this, it's purely a aesthetic opinion.  If I'm the
minority then that's ok, but the above doesn't look great to me.  Thanks,

Josef
