Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A46212422
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGBNHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGBNHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:07:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB00C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:07:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so21126947qts.5
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GMM3jSF1LPrMPgBLMyMtLjLInB1xZd2wk74peKzGqWI=;
        b=KFSMXecMA7fLQLSRQR3y+g9pYWGqx8A64uS0S8nhRJTTtB/1wHS+ZpwsXnaRIe0dlW
         TDwsrhPhSMMSesxvps6HUE/xfXxyieRikgRyh11phuNV8yZwpQN88JQrQlnD3s33Ka/b
         Lv5kP4ofLfFctIRg2cTQEA1uXnhBwXavKVuEBfO7sD2RYHt1sId39onD9Cx2xz6tz6yT
         YVQv8KkMfLCwsffScMCqCI1iuIl/q/mkrNxJH/rHRlOII6giyXJvAFIQUv5I35jJFisH
         fJNXYv/BFRLbp9d7ow0P0cP42KsS0R4WpDJ6iEpgecWlyLzjSSrOI9i9ANNsvNcr3iWT
         OHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GMM3jSF1LPrMPgBLMyMtLjLInB1xZd2wk74peKzGqWI=;
        b=Em3NLQf9HmNOd6a0pqp+kLCprRv1Rc79bKdHd7kallUd4xPugoIzWm2VbffDRRRZXr
         bWl5mF6SLbhcHkVMRtY5nY5QlQCpnqtHczU+Yq4xhyWiFWL1RMD+L6JZHFGv/FePNWaw
         8fcF7eegXnuGumdxWtm3uVECFHbnV2asZyn/2bVeOfvF9LZO0kgGB79eCWZcz/lYZa+l
         wHd1e4L0WyrJ4qub06AQ78+rWcu8feNqev44HQKD3yQEcIrXz0gXsMDXP+GEBwuXiVsH
         MilsQ6rvbAULsPa8VfN7olmKmgctpLPsrnElQOkCtX+zqgYA2e1Kqk6c0OrhTIvQKNDv
         TGfA==
X-Gm-Message-State: AOAM530FIyuGE9Q0+EtkcC/puYnLv35cRfS8SPvHfbjAhY8neDumuF+t
        3fnsyJFsgSGTCWwtIQrfjoOhRnzo6wLQEA==
X-Google-Smtp-Source: ABdhPJyhDLlvI+Rbgme1GaxNic1hOmHSBRNA/KgNjU/DH6wfZ3WMEvqxrvHa0WwIKzOY0RmrFTPbPQ==
X-Received: by 2002:ac8:7242:: with SMTP id l2mr30048502qtp.320.1593695273446;
        Thu, 02 Jul 2020 06:07:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b10sm7643350qkh.124.2020.07.02.06.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:07:52 -0700 (PDT)
Subject: Re: [PATCH 1/8] btrfs: Make get_state_failrec return failrec directly
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3114fd28-4c62-8e76-457e-f475f3a8f076@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:07:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> Only failure that get_state_failrec can get is if there is no failurec
> for the given address. There is no reason why the function should return
> a status code and use a separate parameter for returning the actual
> failure rec (if one is found). Simplify it by making the return type
> a pointer and return ERR_PTR value in case of errors.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/extent-io-tree.h |  4 ++--
>   fs/btrfs/extent_io.c      | 23 ++++++++++++-----------
>   2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index b6561455b3c4..62eef5b1dfc6 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -233,8 +233,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
>   			       struct extent_state **cached_state);
>   
>   /* This should be reworked in the future and put elsewhere. */
> -int get_state_failrec(struct extent_io_tree *tree, u64 start,
> -		      struct io_failure_record **failrec);
> +struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
> +					    u64 start);
>   int set_state_failrec(struct extent_io_tree *tree, u64 start,
>   		      struct io_failure_record *failrec);
>   void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8a7e9da74b87..6f0891ad353b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2121,12 +2121,12 @@ int set_state_failrec(struct extent_io_tree *tree, u64 start,
>   	return ret;
>   }
>   
> -int get_state_failrec(struct extent_io_tree *tree, u64 start,
> -		      struct io_failure_record **failrec)
> +struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
> +					    u64 start)
>   {
>   	struct rb_node *node;
>   	struct extent_state *state;
> -	int ret = 0;
> +	struct io_failure_record *failrec;

Seems we can just do

struct io_failure_record *failrec = ERR_PTR(-ENOENT);

here and avoid the extra stuff below, as we only ever return -ENOENT on failure. 
  Thanks,

Josef
