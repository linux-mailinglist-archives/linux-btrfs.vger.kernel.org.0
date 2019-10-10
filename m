Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B3D2E22
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfJJPrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:47:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43973 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfJJPrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:47:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so6015697qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lHwp3NItoshcjdb8lMSUcjYjEthjJAExiZohKIl+65Y=;
        b=Mj+Jmetnn3ZKbSVtFXqF4/9w6g3+4qh1jR0DRxZglIrU1vtOC7Xr4cBhponX9znvuG
         ZGIhrUmhPhNk8zGHX5LKZx6NmhdNrONUJvTMlSONFVjVyDj0HdoXcTc+Onf3HwNMdTBZ
         yr302LkbRkv8Uv3NXFdAC9wQx57RdweakQBH7TBpjiEUU+WZyK8IWDR55Cnl/aI2sjI2
         gn5YyKMbEYcwJT9xTD/rh0RNNWzQrDeqYdvTXdF4taMKAy1Z6eGUhnJA10Z7C4XDIP5i
         mb/ElS8tRljSIyX9Eb5R3G/B+hGTkcxETpmHu82MRjUFffVALdTROW8zJz900C++Vb5U
         3rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lHwp3NItoshcjdb8lMSUcjYjEthjJAExiZohKIl+65Y=;
        b=iql1U5H6nrRDR/dDYafBPdD6blsxZ2LT+w03fWZLcCmqA9xGX3pxX4s/hTm8qwLJEN
         3gEjfgltOv4hJiQ4GySF+dWYGLOTfQfDNURAyb5zwhXbZ6azM7kLJsZG09vWDXLCPBD6
         G/b14qAoV8XzXJwe2DxUMzco3Ac4snVMIjhwDcd9zMyzTjZksWQgw/C1JDt3UPJDxFMD
         +avTFr3q53L6Dpl5Adh9pveQhNsNKmpN5lSViQXyjUR0GeBK+7+O30tt+qYW1Yw0KUKl
         26vceCC7EWgey6DgmuTl9ZTd/uw7JokDd5IGUWB5LZoTIUrGWqlXTYKvcKHEVLAv9a1G
         cN/Q==
X-Gm-Message-State: APjAAAX1L8MPXfQ3RM1Jl81zvguRLyBziRZPXY/VmAkCx0rYz+ZozDo0
        NAJW8gXmrf5zJLifnF9vjX3fKe8rwVn/hw==
X-Google-Smtp-Source: APXvYqyp0vobXH4iaM5ddWcof9MelaElU3lewATfQ2SBlQOJ9v5g874cwg2qTmYgj6q83RDaqoqZrA==
X-Received: by 2002:a05:620a:696:: with SMTP id f22mr10174096qkh.91.1570722441969;
        Thu, 10 Oct 2019 08:47:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id q8sm2759529qtj.76.2019.10.10.08.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:47:21 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:47:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/19] btrfs: add bps discard rate limit
Message-ID: <20191010154718.hdtiwd2eh4ai7zn4@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <17152a4b1f9a0719623af4ef98e5e8670dd70799.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17152a4b1f9a0719623af4ef98e5e8670dd70799.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:42PM -0400, Dennis Zhou wrote:
> Provide an ability to rate limit based on mbps in addition to the iops
> delay calculated from number of discardable extents.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/ctree.h   |  2 ++
>  fs/btrfs/discard.c | 11 +++++++++++
>  fs/btrfs/sysfs.c   | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b0823961d049..e81f699347e0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -447,10 +447,12 @@ struct btrfs_discard_ctl {
>  	spinlock_t lock;
>  	struct btrfs_block_group_cache *cache;
>  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> +	u64 prev_discard;
>  	atomic_t discard_extents;
>  	atomic64_t discardable_bytes;
>  	atomic_t delay;
>  	atomic_t iops_limit;
> +	atomic64_t bps_limit;
>  };
>  
>  /* delayed seq elem */
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index c7afb5f8240d..072c73f48297 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -176,6 +176,13 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  	cache = find_next_cache(discard_ctl, now);
>  	if (cache) {
>  		u64 delay = atomic_read(&discard_ctl->delay);
> +		s64 bps_limit = atomic64_read(&discard_ctl->bps_limit);
> +
> +		if (bps_limit)
> +			delay = max_t(u64, delay,
> +				      msecs_to_jiffies(MSEC_PER_SEC *
> +						discard_ctl->prev_discard /
> +						bps_limit));

I forget, are we allowed to do 0 / some value?  I feel like I did this at some
point with io.latency and it panic'ed and was very confused.  Maybe I'm just
misremembering.

And a similar nit, maybe we just do

u64 delay = atomic_read(&discard_ctl->delay);
u64 bps_delay = atomic64_read(&discard_ctl->bps_limit);
if (bps_delay)
	bps_delay = msecs_to_jiffies(MSEC_PER_SEC * blah)

delay = max(delay, bps_delay);

Or something else.  Thanks,

Josef
