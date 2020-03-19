Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253D018B9AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSOqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 10:46:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41343 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCSOqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:46:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id i26so1970854qtq.8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dqAf51mxC+S9i3OmpPb1VcGsCSSDzscvq3qaHihWBdY=;
        b=m5I6ojkWMz7Ag1ZeGmVPvOGtasauuhgKuQm4M6niUiuN8wZP0Rz2S01Y6AOfp555K1
         Tfz6ZvlV6pX/KLpSPX9Ovg9RuCgiAPVvDPEmTYt4uZu14TvjEWy9dnMZd/mjjbdee3rc
         qw/SOKuIa44jVKXxUvcxNk2RX+pmtvT3jZtWHMOrvLvXl6gaMxU2PRDGOfSIgGYIwJZw
         7QXkBud5GNnX2oMQZyptdBDF7PhxjukwOXkc4tVBQxUxLvpFn39xUFYY4lFkNXfyijDk
         Pl0Dq4mhfyCpEI35FXrYC82cslhhnAi631SPvEcN507VrIBht7k2gAPB5rdOUxgL8+zT
         F3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqAf51mxC+S9i3OmpPb1VcGsCSSDzscvq3qaHihWBdY=;
        b=YhVb15AAWYIAhRTNxhqTmDecWzG9EzeX/N8OGbkuKL+9mcKxcZJDD9aSQ5Hj5HmVw3
         0b2EFzn2QHg2oewULnhH/KpdL2LsYqww2e/BCHHH53oIS+w3LwUolGtwLsQ1RkTqtbMV
         OO4hhAJuxkrV0VEKEYxW41vnYwbbUveqSF3ONl7CEBmoB2JmYVAKXZo0VHlQOrWhrKED
         WMSG6E7O9Ap/HwbEfajoOhqf4Qs5eIFBNjgFtbFPcB6UFLSBVKhrPv3IS27jN1F+xkoA
         CYByLesqleXHZ47w2gV84Pa4qiftOwjHbE3QWCabjvM7iKP7YsWlWm1ItHBJEE3maQwD
         BY2w==
X-Gm-Message-State: ANhLgQ15z33mnaqofeRPGIbRWl4vwKqtwZ6OwG1ypYzHiIzF4MVE2qu+
        k8FI5r9ycHNTq3Oa+X1J3y3upA==
X-Google-Smtp-Source: ADFU+vvW21ddSk2zql9w2CIuApm6ZCr+roIqnSumZVDHYvpf+BxbLYvdtLug2QM/6A6YOQVQkTJqWA==
X-Received: by 2002:ac8:304e:: with SMTP id g14mr3289032qte.376.1584629205786;
        Thu, 19 Mar 2020 07:46:45 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b6sm1598076qtj.15.2020.03.19.07.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:46:45 -0700 (PDT)
Subject: Re: [PATCH RFC 01/39] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3b73dcf6-0383-016e-887a-c6fa8830f049@toxicpanda.com>
Date:   Thu, 19 Mar 2020 10:46:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> Due to the complex nature of btrfs extent tree, when we want to iterate
> all backrefs of one extent, it involves quite a lot of work, like
> searching the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed
> backrefs.
> 
> Normally this would result pretty complex code, something like:
>    btrfs_search_slot()
>    /* Ensure we are at EXTENT_ITEM/METADATA_ITEM */
>    while (1) {	/* Loop for extent tree items */
> 	while (ptr < end) { /* Loop for inlined items */
> 		/* REAL WORK HERE */
> 	}
>    next:
>    	ret = btrfs_next_item()
> 	/* Ensure we're still at keyed item for specified bytenr */
>    }
> 
> The idea of btrfs_backref_iter is to avoid such complex and hard to
> read code structure, but something like the following:
> 
>    iter = btrfs_backref_iter_alloc();
>    ret = btrfs_backref_iter_start(iter, bytenr);
>    if (ret < 0)
> 	goto out;
>    for (; ; ret = btrfs_backref_iter_next(iter)) {
> 	/* REAL WORK HERE */
>    }
>    out:
>    btrfs_backref_iter_free(iter);
> 
> This patch is just the skeleton + btrfs_backref_iter_start() code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/backref.c | 111 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/backref.h |  39 ++++++++++++++++
>   2 files changed, 150 insertions(+)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 327e4480957b..33fec39bf5ef 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2299,3 +2299,114 @@ void free_ipath(struct inode_fs_paths *ipath)
>   	kvfree(ipath->fspath);
>   	kfree(ipath);
>   }
> +
> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(
> +		struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
> +{
> +	struct btrfs_backref_iter *ret;
> +
> +	ret = kzalloc(sizeof(*ret), gfp_flag);
> +	if (!ret)
> +		return NULL;
> +
> +	ret->path = btrfs_alloc_path();
> +	if (!ret) {
> +		kfree(ret);
> +		return NULL;
> +	}
> +
> +	/* Current backref iterator only supports iteration in commit root */
> +	ret->path->search_commit_root = 1;
> +	ret->path->skip_locking = 1;
> +	ret->path->reada = READA_FORWARD;

Lets kill this by default, the backref stuff is going to be random reads almost 
always.

<snip>

> +
> +	/*
> +	 * Only support iteration on tree backref yet.
> +	 *
> +	 * This is extra precaustion for non skinny-metadata, where

precaution

Thanks,

Josef
