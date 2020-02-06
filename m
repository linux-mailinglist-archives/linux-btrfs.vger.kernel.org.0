Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C778154969
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBFQkn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:40:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32998 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFQkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:40:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id h4so6192300qkm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SNL/5GYn78OQvIKuuitQxNVCddkHHysLfwwTANoa/1c=;
        b=NJDz9+TN+fZWZ1/NGxoR9+yJ/66cNUO/O4UyZv42rVOUSc8YjMaeXql3VZIL0mq8ND
         b6gfBKhEhDSSAGyg3+G5LNJ9gBOxT4V5d3qpjA9W/dKxtgZjyAhE0vUOdQDTV2GTLtwd
         nXK6j0nJy/1t1Dp5CMGj0yCmY/bs2mCG+4Ym5ByQmBLLh2fZy4beEp9++r6V6nBnh3Qi
         LWQVGf4mDBZZiEHvJBOOC6qBBMVy/p5Vi6wuWjiX0LYRrJ0ceFiF/Fxw6DW/E/jKa6gK
         uNhmocvDO9tyyDC1DeiCxKqv9Tj0eGQVzEu4KOfNFJT1guz4GdyDOcttxTIqB5xw8UK5
         Qxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SNL/5GYn78OQvIKuuitQxNVCddkHHysLfwwTANoa/1c=;
        b=FPmWNJiPeBhSgVkj4tqvDNjWhAUXhvabSI/oNheAFoiWJStcRpzYFB9G7WiK7Jaa1i
         VDd05ksPAxkZb5zDg/lOib5FfHrBX9lGGEYJ9jmjILS08vCF6CCjQE0npaE74dt+rx+L
         nELp4g3WVkewRBb1reMtp/2It5ik+W9uVu1R1rI9pyWejNoRuWRtqkOLke9xl5kiAF/6
         IPF2HbE7VTBBC+muSfHGMkxO/oGMbWwmoCM48YaS6TEL6Sw3Gb2cp9lZbsSQAecdd2B0
         O/0egQfDU/YOfvdX6rKJkGNH+D35Y4ECp7M7P3tvSlGnI8o0VukECTQEtXvtxrvSYdLy
         vFhA==
X-Gm-Message-State: APjAAAWqw+HznVZySlKvRnLDeP8XxPF9UxVCgG4nFReMkk2t8WbuzmhD
        KRaW0xh5WvkTLuUa8rHDsW6tjw==
X-Google-Smtp-Source: APXvYqxt8tl5kXH71nFlEdWiSZdMG9/vhwvvW7LsGwA+HI/E0BHeM+MEMZZd7GKhiXu6GxRe/dCfzA==
X-Received: by 2002:a37:a1ce:: with SMTP id k197mr1979999qke.141.1581007242542;
        Thu, 06 Feb 2020 08:40:42 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v80sm1672575qka.15.2020.02.06.08.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:40:41 -0800 (PST)
Subject: Re: [PATCH 05/20] btrfs: factor out set_parameters()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-6-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <82286a4a-0688-2ada-b245-abdb998147c4@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:40:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-6-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
> Factor out set_parameters() from __btrfs_alloc_chunk(). This function
> initialises parameters of "struct alloc_chunk_ctl" for allocation.
> set_parameters() handles a common part of the initialisation to load the
> RAID parameters from btrfs_raid_array. set_parameters_regular() decides
> some parameters for its allocation.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/volumes.c | 96 ++++++++++++++++++++++++++++------------------
>   1 file changed, 59 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cfde302bf297..a5d6f0b5ca70 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4841,6 +4841,60 @@ struct alloc_chunk_ctl {
>   	int ndevs;
>   };
>   
> +static void set_parameters_regular(struct btrfs_fs_devices *fs_devices,
> +				   struct alloc_chunk_ctl *ctl)

init_alloc_chunk_ctl_policy_regular()

> +{
> +	u64 type = ctl->type;
> +
> +	if (type & BTRFS_BLOCK_GROUP_DATA) {
> +		ctl->max_stripe_size = SZ_1G;
> +		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
> +	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> +		/* for larger filesystems, use larger metadata chunks */
> +		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> +			ctl->max_stripe_size = SZ_1G;
> +		else
> +			ctl->max_stripe_size = SZ_256M;
> +		ctl->max_chunk_size = ctl->max_stripe_size;
> +	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		ctl->max_stripe_size = SZ_32M;
> +		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
> +		ctl->devs_max = min_t(int, ctl->devs_max,
> +				      BTRFS_MAX_DEVS_SYS_CHUNK);
> +	} else {
> +		BUG();
> +	}
> +
> +	/* We don't want a chunk larger than 10% of writable space */
> +	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
> +				  ctl->max_chunk_size);
> +}
> +
> +static void set_parameters(struct btrfs_fs_devices *fs_devices,
> +			   struct alloc_chunk_ctl *ctl)

init_alloc_chunk_ctl().  These function names need to be more descriptive.  Thanks,

Josef
