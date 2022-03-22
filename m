Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C94E4542
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiCVRjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiCVRjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:39:41 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3FE51596
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:38:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q194so14518043qke.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QEwcN9yy7LeJB8NrKDDkEaQYtcEvNwqJNM+tmaM3Nk0=;
        b=suKXcLW1fNG0XhbOC2BBIX2yCBtIqGFJa2owDRpNZHKSKQyht8KWjV0BHjdo/xoCOU
         P1hm1O/rvPAIfcag7FJ4YdAdsRt0VLMJjD3nftI2CpuOo9PU+2r6LC9uqQax3pJ5q0gB
         0M45Xdlb9FMg/6pUe61hqHLUbPsN5OGwq4SiFAUwsYEU1TimMXN3KuZX4qtuptV0qQmI
         TQkI+nnolqwWpkoMnZUjIaqNtU6fzHmRocxpaRk53+dGLPOhqciQ9ayYkO4hg+et+MSM
         eZPPYeL25Q7c4LlxITSDuxaEWYkv7v8NO0ug9Pn1e+Dvay2h6iPx2g08V3vOZ+WbAcC0
         5o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QEwcN9yy7LeJB8NrKDDkEaQYtcEvNwqJNM+tmaM3Nk0=;
        b=Pg1Nx/9Ss8QBGcNccOsMyp48p9VakqQ7ZT2Cn2fJ80g1Oy5h7xlS0cezSdKkb06RGI
         2WOVB0e6vvI8/gtofLhKrZ3Ycku8cyNOJ8t3KWgfXWg3qLwSsVKw+DK4hayueHDe9mCH
         H4PbaQyzCJJ/p7Ii10vIoj3g75gyYsTOrhdxG92g0ro8Xc0lQ+0+DnO98pVFYWpd2/63
         khhbIxmxhs3cIrza3L4rtHJLzDZoKxPdumMMpwG7UGf/UP6KzC2Iq0Z19orsk4XSRbPj
         SSISJPEp6eKTOYiDRS1ccmxvPFoBtra8wU92QPk/jWRX8AtSLX9z50SpqFn/uKjtxHPh
         xW7g==
X-Gm-Message-State: AOAM533bsioD3Jit8nJs96R5MKLYSlIPoUfDsTNbmosdbeEY59OfwCla
        1zc/P17yHqGYvBzTW/B2yslMMngPsL0IVA==
X-Google-Smtp-Source: ABdhPJwJFP2To49HciWxVCsBXqx+IVebJC3vbWQJVx14tdR0BkgcgNWpMWwoPhrmUz5RsEmf6U7cvw==
X-Received: by 2002:ae9:c21a:0:b0:67e:b484:fab0 with SMTP id j26-20020ae9c21a000000b0067eb484fab0mr4263856qkg.623.1647970691768;
        Tue, 22 Mar 2022 10:38:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u17-20020ac858d1000000b002e1cdbb50besm14208229qta.78.2022.03.22.10.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:38:11 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:38:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/5] btrfs: allow block group background reclaim for
 !zoned fs'es
Message-ID: <YjoJgS244Y9x6OPu@localhost.localdomain>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <ef7463193e228bbb348bf8a8d587aa8b95bebf22.1647878642.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7463193e228bbb348bf8a8d587aa8b95bebf22.1647878642.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 09:14:11AM -0700, Johannes Thumshirn wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> We have found this feature invaluable at Facebook due to how our
> workload interacts with the allocator.  We have been using this in
> production for months with only a single problem that has already been
> fixed.  This will allow us to set a threshold for block groups to be
> automatically relocated even if we don't have zoned devices.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 59f18a10fd5f..628741ecb97b 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3208,6 +3208,31 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
>  	return ret;
>  }
>  
> +static inline bool should_reclaim_block_group(struct btrfs_block_group *block_group,
> +					      u64 bytes_freed)
> +{
> +	const struct btrfs_space_info *space_info = block_group->space_info;
> +	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
> +	const u64 new_val = block_group->used;
> +	const u64 old_val = new_val + bytes_freed;
> +	u64 thresh;
> +

Actually do we want to do a

if (btrfs_zoned())
	return false;

here and leave the auto reclaim zoned behavior the way it is?  Or do you want to
delete your stuff and rely on this as the way that we setup zoned block groups
for relocation?  If we use this then you could make the
fs_info->bg_reclaim_threshold also apply here.  Thanks,

Josef
