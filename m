Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D8146AB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 15:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgAWODa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 09:03:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46497 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWODa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 09:03:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id e25so2469326qtr.13
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 06:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HJ5f/DRo1Na09jrsXbxvAv0a+KO+xdIQJ/e5aUKMcdk=;
        b=jvsJYhNJ9m9Gtob15dVu4zTSQVYQDH84VS1/y8lT8xWuxil93bG63AFYCdF7+sEkzo
         qOZeEx3BxBarINxugMR7fXiSXqXmbe0ji6v4XzzBrDYfaKlr+X58/qEkqkRPIhfo9zHl
         CpOF6o15LaUOuLabXEK3T6J3BPzwGh8UNrYoxf4jIvnyRFFmW0zcmlQh2FV5a1DxOe2/
         6EngqFkor3dKhZn971bcwORekylNsRFKlXR7xqEwI3hbwYKGPYnrcl6j2zD/OSMD5m9w
         MkTG9YORqAo5cIR+Tw5YQSs4CMWN3ZD1bw2JNWHI3lg+dlQKORpJHjjrlwO1CdFkd7O+
         L+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HJ5f/DRo1Na09jrsXbxvAv0a+KO+xdIQJ/e5aUKMcdk=;
        b=SdsNZGr+p7kyToi2OI5OqGZkN+WgCNlwfY0WEtMTb7eu19Gqua0uFnDvK4LlWD/JU1
         0GKsr6ZnbDbf/XVc5pDw3WM2Wu2OAJ4XIruBs6UY3btYbyIYT2/hhxRC35q7VhU6X+Xo
         oi6OC7sXErEOnIa1UoeiT5boNO+TN99kA1MW0Huzs1zATVAkUq5xgRpuu0hSo0tXhoMs
         3E5RCLaF2mCbEKJPGyyyaNAE/F05RFO902Zb2zH3zb++9NykCYI3wAmGkhNadmLjjZMi
         wdDcx2Qu84akyBxlegdnwYIvHRjCEStZRsbn8mjUf7CzC5c1iqVWsuFS99xwrgePxuZX
         4Log==
X-Gm-Message-State: APjAAAWFvhSqP5R2G41aNUAM9Ho+hxI+qPqoL+ELM4KrJ3UHT6n4s5ez
        e+QBesK8B9e7t3UCfDRUAJ7kKiwVBFswZA==
X-Google-Smtp-Source: APXvYqw7U3uDOr/t5qZeI9376GrzjjCPeKC49wrdUUn1/G6oE2QLLs4oBCauAd5rKgvwS4bKA/eW3w==
X-Received: by 2002:ac8:65da:: with SMTP id t26mr16211921qto.5.1579788208747;
        Thu, 23 Jan 2020 06:03:28 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id d71sm918635qkg.4.2020.01.23.06.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 06:03:28 -0800 (PST)
Subject: Re: [PATCH v2 6/6] btrfs: remove buffer_heads form superblock mirror
 integrity checking
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-7-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5d38b2eb-3b38-06d8-256c-c36cbd9a3dd2@toxicpanda.com>
Date:   Thu, 23 Jan 2020 09:03:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:18 AM, Johannes Thumshirn wrote:
> The integrity checking code for the superblock mirrors is the last remaining
> user of buffer_heads in BTRFS, change it to using plain BIOs as well.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> - Convert from alloc_page() to find_or_create_page()
> ---
>   fs/btrfs/check-integrity.c | 44 +++++++++++++++++++++++++++-----------
>   1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 4f6db2fe482a..45b88bcd6cbb 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -77,7 +77,6 @@
>   
>   #include <linux/sched.h>
>   #include <linux/slab.h>
> -#include <linux/buffer_head.h>
>   #include <linux/mutex.h>
>   #include <linux/genhd.h>
>   #include <linux/blkdev.h>
> @@ -762,28 +761,47 @@ static int btrfsic_process_superblock_dev_mirror(
>   	struct btrfs_fs_info *fs_info = state->fs_info;
>   	struct btrfs_super_block *super_tmp;
>   	u64 dev_bytenr;
> -	struct buffer_head *bh;
>   	struct btrfsic_block *superblock_tmp;
>   	int pass;
>   	struct block_device *const superblock_bdev = device->bdev;
> +	struct page *page;
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct address_space *mapping = superblock_bdev->bd_inode->i_mapping;
> +	gfp_t gfp_mask;
> +	int ret;
>   
>   	/* super block bytenr is always the unmapped device bytenr */
>   	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
>   	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)
>   		return -1;
> -	bh = __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,
> -		     BTRFS_SUPER_INFO_SIZE);
> -	if (NULL == bh)
> +
> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
> +

I don't think we need __GFP_NOFAIL here, it's just check integrity.  Other than 
that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
