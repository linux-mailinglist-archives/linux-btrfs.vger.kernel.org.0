Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0622B23A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKMSZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgKMSZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:25:12 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D6BC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:25:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so9701562qkf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oNtgpf6SsLgirP4rDgCRiJkXIRGovwd/pc0+zNokHZg=;
        b=w9B6x2msJ3L7X1b/A0D386fRANr6i7qGrl1EfZsxJJQN7lT1xcbMi/WUKLQoHMXEhI
         cl8U+/5IbUGkEfvdNGdp72+84Ulh/TNaEaW2OJoC0QAOBKseemnnOCfb1CLJbvKz60P7
         Nwqkzj2zIwbpENrsKnzw6jCSLt3ZJVWG+ZFzH/iNFqlDJ/ApEoCJ+/AQekD2+n7guhTi
         1q67realZFK/HQMfrK0iYTq4hj/6WwUXWN6UEHM1cDes4kZTFbyyn2hXiMpYjiAzdvDY
         MDjO2giiuvbHZxh3PtJPEczVVMqS+Mq5FcwY8gaQag5it5DJkBfnlmpwF9Xv1GaK7weg
         Q/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNtgpf6SsLgirP4rDgCRiJkXIRGovwd/pc0+zNokHZg=;
        b=DpTuXvnSwTiJ+t/nep8qioceLlqIM2CKoqrjMBADrqM8aeoIu+OMA2tWsTepEvew8H
         UxxmJNrLX89Fr45rVdphFHh1PDPwLIBqPaM908ufwhIm8H40dZWuGNg5r3UMu+F0qmGt
         9Efmwy9+uvDD44vocNCWsia+T2EXfUV6uFJofpF6/WMdGorgmKLPnLZJuLhjo4plqeDR
         qkjjOF0DPh0b5GX+emhYzfp/wa+wcYnHvYigLJMLtcuXpCQZbb4uKxzjLFwxSn+eBwAo
         WTRRgamZZ0p1e5zs2J3ilH0pI79eN92bnqjfSStfQDvHv/UW//nLrwgcPkkIAeeUIEBU
         UY7w==
X-Gm-Message-State: AOAM530sQGpXBcOP1EVLcSmDhUjrTQEiNJ0BcRthDVbLZTawltT1XQ1P
        5BHOEr/RJaquBxnC/fOD6BSYKPasC1myvg==
X-Google-Smtp-Source: ABdhPJxiOSRsP67KVsL/RhcvivPTiA+J+9azke3C9IIR1eWftNtV+3YnfWNxHYPxyWWJnGDqmVFl/Q==
X-Received: by 2002:a05:620a:208b:: with SMTP id e11mr3248954qka.380.1605291909675;
        Fri, 13 Nov 2020 10:25:09 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm6895357qtt.52.2020.11.13.10.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:25:08 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Simplify setup_nodes_for_search
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113072940.479655-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5d09fb4c-e983-b165-032e-66531caf9f59@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:25:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113072940.479655-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 2:29 AM, Nikolay Borisov wrote:
> The function is needlessly convoluted. Fix that by:
> 
> * Removing redundant sret variable definition in both if arms.
> 
> * Replace the again/done labels with direct return statements, the
> function is short enough and doesn't do anything special upon exit.
> 
> * Remove BUG_ON on split_node returning a positive number - it can't
>    happen as split_node returns either 0 or a negative error code.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2:
> - Initialize ret to 0 by default in case we don't hit any of the branch conditions
> and simply exit.
> 
>   fs/btrfs/ctree.c | 30 ++++++++----------------------
>   1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 892b467347a3..5de33cd85cac 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2390,56 +2390,42 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
>   		       int *write_lock_level)
>   {
>   	struct btrfs_fs_info *fs_info = root->fs_info;
> -	int ret;
> +	int ret = 0;
> 
>   	if ((p->search_for_split || ins_len > 0) && btrfs_header_nritems(b) >=
>   	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3) {
> -		int sret;
> 
>   		if (*write_lock_level < level + 1) {
>   			*write_lock_level = level + 1;
>   			btrfs_release_path(p);
> -			goto again;
> +			return -EAGAIN;
>   		}
> 
>   		reada_for_balance(p, level);
> -		sret = split_node(trans, root, p, level);
> +		ret = split_node(trans, root, p, level);
> 
> -		BUG_ON(sret > 0);
> -		if (sret) {
> -			ret = sret;
> -			goto done;
> -		}
>   		b = p->nodes[level];

While you're cleaning up you could delete this line as well.

>   	} else if (ins_len < 0 && btrfs_header_nritems(b) <
>   		   BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 2) {
> -		int sret;
> 
>   		if (*write_lock_level < level + 1) {
>   			*write_lock_level = level + 1;
>   			btrfs_release_path(p);
> -			goto again;
> +			return -EAGAIN;
>   		}
> 
>   		reada_for_balance(p, level);
> -		sret = balance_level(trans, root, p, level);
> +		ret = balance_level(trans, root, p, level);
> +		if (ret)
> +			return ret;
> 
> -		if (sret) {
> -			ret = sret;
> -			goto done;
> -		}
>   		b = p->nodes[level];
>   		if (!b) {
>   			btrfs_release_path(p);
> -			goto again;
> +			return -EAGAIN;
>   		}
>   		BUG_ON(btrfs_header_nritems(b) == 1);

And change this to ASSERT().  Thanks,

Josef
