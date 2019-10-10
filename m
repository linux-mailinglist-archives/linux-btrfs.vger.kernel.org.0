Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5DD2DF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfJJPlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:41:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42844 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:41:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so9321800qto.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hf7L0yZIZGkKoajt1MfsdCiMFpa1hLcOCbFAu28cMzM=;
        b=Yh+TcciF0hrr15EvPpjFg/1ZAqH+49cBnWopFJ4QXjvx55gXQKnD+H9tkmHkDdaW60
         SBfit0L+XqO1HtSnI0HJfeu7pAOwuXJLlckJZDTDh+k2TBqRvkgUJvpKR3KEOfg/hQZX
         IxZQZ+8jPogHfVwrYl7xmvXcyV6mBiLdJMo7s+Xo6xojxolM6lRCYeyKGfFBFl46epyA
         ki27NBUdMQD7MSWWxgOLQ89imX1+LBvLVEPVD1dTaHq/NkT+Skq8VvSoEZ2MP9RZPp1J
         VdptzCXBfZyZO+0GbNDE8eQCiKTNdxesjGIFOHZCK5iZUmyJ/cvrrgukrj+5OAGQARX8
         ISKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hf7L0yZIZGkKoajt1MfsdCiMFpa1hLcOCbFAu28cMzM=;
        b=ZbYWg62/DT+PboS8o+vux9Cm3sOaoUwIyJ+Dsd8qCRFc6VsrpIBOHMe+oyrkHpF95V
         O4bKPhtqDO1OiDOpp/fm3oK1/9zmJtNshGVzc8Jbs3g2VLU7GBdj6Vv2xet5tUAEq7AG
         jSpdcyzFbC7w1GMcc7eQM7PmGYDM1GYVNFiPb77sznz0nAyVtoMednLfofUzXT/g4IDU
         Z+lRKknBzIijIiK9SV560TRgcW8ck18lGeL4aIP8DebYtxwzYxVN4nii71TGzQNCMekn
         d6paxz6htbbXAOTXU6/1EHFFBB7Nq2WZr0+DSecDtcjuyqarU/1iBwErZHqQxgmgNS60
         1IDg==
X-Gm-Message-State: APjAAAXCOeBVUJU5yzVFGPUch5MCfQcZYMCBjW9zALArMO/D33ozNZVB
        pFzHCTj7MOLmLslUNb+8JSrFew==
X-Google-Smtp-Source: APXvYqz5ExzV5UfcvRxEe06dO6F9kri60iIke+j3BlFGu9D+WtWyQ3CA19aMj+H9vTR16qHk96yyrQ==
X-Received: by 2002:ac8:47c7:: with SMTP id d7mr11394622qtr.29.1570722095228;
        Thu, 10 Oct 2019 08:41:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id x15sm2412714qkh.44.2019.10.10.08.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:41:35 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:41:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/19] btrfs: calculate discard delay based on number of
 extents
Message-ID: <20191010154133.pk62hvu6pgac3mne@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <37690bf17c3b3c9f20137fb186c7af4021bb664b.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37690bf17c3b3c9f20137fb186c7af4021bb664b.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:41PM -0400, Dennis Zhou wrote:
> Use the number of discardable extents to help guide our discard delay
> interval. This value is reevaluated every transaction commit.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/ctree.h       |  2 ++
>  fs/btrfs/discard.c     | 31 +++++++++++++++++++++++++++++--
>  fs/btrfs/discard.h     |  3 +++
>  fs/btrfs/extent-tree.c |  4 +++-
>  fs/btrfs/sysfs.c       | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8479ab037812..b0823961d049 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -449,6 +449,8 @@ struct btrfs_discard_ctl {
>  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
>  	atomic_t discard_extents;
>  	atomic64_t discardable_bytes;
> +	atomic_t delay;
> +	atomic_t iops_limit;
>  };
>  
>  /* delayed seq elem */
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 75a2ff14b3c0..c7afb5f8240d 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -15,6 +15,11 @@
>  
>  #define BTRFS_DISCARD_DELAY		(300ULL * NSEC_PER_SEC)
>  
> +/* target discard delay in milliseconds */
> +#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60ULL * MSEC_PER_SEC)
> +#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
> +#define BTRFS_DISCARD_MAX_IOPS		(10UL)
> +
>  static struct list_head *
>  btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  		       struct btrfs_block_group_cache *cache)
> @@ -170,10 +175,12 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  
>  	cache = find_next_cache(discard_ctl, now);
>  	if (cache) {
> -		u64 delay = 0;
> +		u64 delay = atomic_read(&discard_ctl->delay);
>  
>  		if (now < cache->discard_delay)
> -			delay = nsecs_to_jiffies(cache->discard_delay - now);
> +			delay = max_t(u64, delay,
> +				      nsecs_to_jiffies(cache->discard_delay -
> +						       now));

Small nit, instead

			delay = nsecs_to_jiffies(cache->discard_delay - now);
			delay = max_t(u64, delay,
				      atomic_read(&discard_ctl->delay);

Looks a little cleaner.  Otherwise

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
