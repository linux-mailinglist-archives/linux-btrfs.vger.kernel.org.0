Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6605E2F204F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 21:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404157AbhAKUCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 15:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbhAKUCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 15:02:17 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D5C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:01:37 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b64so604006qkc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mgrT4Altg8glIRE+MOOUJE15z5PhjqAtILPKl/TgNP8=;
        b=yAxr2iADLTUmXEiDK5K7FSnU6C8ZRcfTqSe/09PKcZ8TVKMvCwCbCoRMezIqdg8GNS
         oSz6KtIRvv0JoCzAqTfAnI4FYLWCYLdZlyjKGCAUIoSk73t1ORtJyksp/LsPxoSGGVpR
         gt3g1rEW7lh0PRkq+tMnkqiLMqZuFyFYHhXHcu1hQ80FNmfRSfouTzwjDs1p8yA62ibJ
         fuJCFti8lRVU+ffh2slTYfu+M2cAQ26u+LKFFA++ZkDaL8VIlsA0INfu0R427nTb9lXu
         PR/WUQp/L5OWjB1KJgl2oYFlNaIXLCrVNwUlp/VyNZXHK4II/z5J12EEymLM0t4ZA56b
         fIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mgrT4Altg8glIRE+MOOUJE15z5PhjqAtILPKl/TgNP8=;
        b=mp5QUzMpoyTz3/wIHQsolubdc5w/p7FN+hQZcy+OCbN6JT8am5WttFEcUhYwT5E9z/
         9hQWTjajrbIGlMg0dMcF30kGVCC76gvaIoZM5TtLcZHJybGY10l3Vanj8Z8pR7wTt1dd
         kijjytwseT/IplHLCoANKele1JJ3RCe8GNMBjXsSd/EyVMIO1YSZYhnwUDkb5hbEkD1v
         BAysSxXj9sGnoymPJIeerDOnqATQmq4aY76K8HtJUSckyhqm6i8Q9KzmblIZFraZXD4E
         w7TyHrDHvy8loW37WrXk/VvJ5Feui8ObZs48nwsDjVORC6CQkSyeVTMUHrrTFRrVc4l/
         nsUg==
X-Gm-Message-State: AOAM5329gsxJnz9DjhkHpXJfejfoQZqEztp3j90h6oQPNI2mLxN23XV4
        1AqTXZxzxeaIOoC67AgSw8/nyg==
X-Google-Smtp-Source: ABdhPJz+0rghxG3TVomri2fQn9Hcffg7QPgRzkdOAnjI5IBHoiITb5e67MqI4j97kse2T6N0S0HrDg==
X-Received: by 2002:a37:e504:: with SMTP id e4mr997913qkg.191.1610395296098;
        Mon, 11 Jan 2021 12:01:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y16sm443407qki.132.2021.01.11.12.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 12:01:35 -0800 (PST)
Subject: Re: [PATCH v11 05/40] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <8fa3073375cf26759f9c5d3ce083c64d573ad9a6.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3f611f04-39fa-e95e-09f2-28c01f5e2a80@toxicpanda.com>
Date:   Mon, 11 Jan 2021 15:01:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8fa3073375cf26759f9c5d3ce083c64d573ad9a6.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:48 PM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Since we have no write pointer in conventional zones, we cannot determine
> allocation offset from it. Instead, we set the allocation offset after the
> highest addressed extent. This is done by reading the extent tree in
> btrfs_load_block_group_zone_info(). However, this function is called from
> btrfs_read_block_groups(), so the read lock for the tree node can
> recursively taken.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/block-group.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b8bbdd95743e..69e1b24bbbad 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1839,6 +1839,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   		return -ENOMEM;
>   
>   	read_block_group_item(cache, path, key);
> +	btrfs_release_path(path);
>   
>   	set_free_space_tree_thresholds(cache);
>   
> @@ -2009,7 +2010,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   			goto error;
>   		key.objectid += key.offset;
>   		key.offset = 0;
> -		btrfs_release_path(path);
>   	}
>   	btrfs_release_path(path);
>   
> 

Instead why don't we just read in the bgi into the stack, and pass the pointer 
into read_one_block_group(), drop the path before calling read_one_block_group? 
  We don't use the path in read_one_block_group, there's no reason to pass it 
in.  It'll fix your problem and make it a little cleaner.  Thanks,

Josef
