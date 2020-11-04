Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0002A6F4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 21:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgKDU7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 15:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKDU7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 15:59:51 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5137EC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 12:59:51 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i21so19972567qka.12
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 12:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rIr19O8Jya+GQ4VONDhDzACsPMNTICoT35z0QlHIcTY=;
        b=ruUFi5c3Q9Rihm3lJpy7h4rtfrPFiQpS+uRZA3ej3IuWRsw9xuZ360k499FAopWVsi
         aVya1jRC+UuDicV1QK7HJ4CtiGvBAeYkbQakeXknEIEd2MylHGG0EbvIpyJakXG2CYW6
         R0d8YRsIhGyqN9wveYZXF6P0FjtmDlS2rDjDHrcjMYzgkmlJD6pKQMk4oBEBRaBY4+6V
         khSneu0w/C13bf7kuqYSMl85c1QmieTjCoT4jzYoLbNRqXRsady/09VHSR8fzfI0mOfS
         zNuFhJ9XF1EJ9wDhCAiIwh74f1MdMLtxEZ0N8jTCGTfdU/LqFvzMp1okNeKDPstJ5IXU
         QY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIr19O8Jya+GQ4VONDhDzACsPMNTICoT35z0QlHIcTY=;
        b=Rugi+qShPUhE3e0rDO/QWBKDdr2lPy5aEW/T8VPfTH67DOjRWg21t77cKLTBRfDShS
         WpfosBUsnCBa+6NhabX7npP+7wNm5Lgb7z8gUCbyB160xsZJzlNLtC+hJ1mU/PxsHfSg
         SWIv58iXamkHwV0GKG8liZZjeMOSXOC7Jv8nUZZ/PO2vyz5oD7756Bf8yMurNju6pHm6
         Pcr28WSn5zdBNoBgVQSpOsYDBaHWHCjxpSPoT6DmiOcHMrTSLZ8MSk1T5sWvRbE2S1eV
         GIW+OugvMS60IPJ+nKojkzSVV6oiRQSiDhPXp8ceTu7KV3BokuzNqq7zabVXv2G9Vc/P
         qmdw==
X-Gm-Message-State: AOAM5323/qaQT5LdFRsDqqdaK36gk1XhMOyT+JLKTjCk7ol3K3CI1Zwh
        y1aXZ2QWgp23PXr0ZCgXDBeYMSKYLD6urg==
X-Google-Smtp-Source: ABdhPJyVxq/pVnGJYKtNzT3jyDoUUWGRWe5Og0NIYQU7pfunX7QBr3ymKSC4Ah/BCvfkz3Okf5nmWA==
X-Received: by 2002:a37:8cc1:: with SMTP id o184mr29067qkd.205.1604523590161;
        Wed, 04 Nov 2020 12:59:50 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:8f29])
        by smtp.gmail.com with ESMTPSA id e28sm3561537qka.73.2020.11.04.12.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 12:59:49 -0800 (PST)
Subject: Re: [PATCH 3/4] btrfs: don't miss discards after override-schedule
To:     Pavel Begunkov <asml.silence@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
 <feb3b0aaf0d547aafcf08b6106ace158809117fd.1604444952.git.asml.silence@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9cfd00b4-1731-1f56-6b53-d3c210fd8453@toxicpanda.com>
Date:   Wed, 4 Nov 2020 15:59:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <feb3b0aaf0d547aafcf08b6106ace158809117fd.1604444952.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 4:45 AM, Pavel Begunkov wrote:
> If btrfs_discard_schedule_work() is called with override=true, it sets
> delay anew regardless how much time left until the timer should have
> fired. If delays are long (that can happen, for example, with low
> kbps_limit), they might be constantly overriden without having a chance
> to run the discard work.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>   fs/btrfs/ctree.h   |  1 +
>   fs/btrfs/discard.c | 11 +++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d43a82dcdfc0..ad71c8c769de 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -469,6 +469,7 @@ struct btrfs_discard_ctl {
>   	struct btrfs_block_group *block_group;
>   	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
>   	u64 prev_discard;
> +	u64 prev_discard_time;
>   	atomic_t discardable_extents;
>   	atomic64_t discardable_bytes;
>   	u64 max_discard_size;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index b6c68e5711f0..c9018b9ccf99 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -381,6 +381,15 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>   			delay = max(delay, bg_timeout);
>   		}
>   
> +		if (override && discard_ctl->prev_discard) {
> +			u64 elapsed = now - discard_ctl->prev_discard_time;
> +
> +			if (delay > elapsed)
> +				delay -= elapsed;
> +			else
> +				delay = 0;
> +		}
> +
>   		mod_delayed_work(discard_ctl->discard_workers,
>   				 &discard_ctl->work, nsecs_to_jiffies(delay));
>   	}
> @@ -466,6 +475,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
>   	}
>   
>   	discard_ctl->prev_discard = trimmed;
> +	discard_ctl->prev_discard_time = ktime_get_ns();

I noticed these weren't protected by the discard_ctl->lock, so I went to look at 
if that was ok.  It appears to be ok, since this is the workfn, and we only read 
them if there's no pending work, so we're protected there.  Just a note for 
anybody else who finds it weird, though I wouldn't argue with protecting it with 
a lock just to remove any ambiguity.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
