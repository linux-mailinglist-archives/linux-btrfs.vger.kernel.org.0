Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89E2F2072
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 21:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbhAKUMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 15:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391358AbhAKUMr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 15:12:47 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F13C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:12:07 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id f26so49211qka.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4EzAN+mcBbGIa+lLyccyrpaP9QTnMNoFcym6YhBp3D8=;
        b=IMASya93CBxE9Iyya0VKTMxclfINeuvGTU6QvRStG1iZlQGqBpnYS6R+WZGtUpeR7A
         lpgbaYORAXBVAfB9qcgC2VseRU9jzq0BggdMrmG6B4ztE06WdIxghlaluTT26qS2Ejmc
         65P+p+4lRTDfr4ZZeNzZY2n5WskoFV0aq/BLcsu9XRTREjgVzXqbtmovgQgK29tJ2zYf
         0sNE+XgEAy8I66t+Gcn9oHwGBPqQEo5nNM+vQ6mWmq4PMTP6wdP3HijCmiV3eQcFbZe0
         zrijlUReP4lYr1YGwG8+CmVCijnpOsZvA9ZaFXarHnPScwvDYsq1o5XinL+6Eww0QDoa
         gqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EzAN+mcBbGIa+lLyccyrpaP9QTnMNoFcym6YhBp3D8=;
        b=GyNgu9/DsW73Iay+xumZPhL4lhlyZDsAQb4ckghJdIbIyGEeAGqMjzTC/xa+o40yvk
         RNFobpX9KkdZiAZrZF2ojr6xGDWig4x8SVGPEhhkOTbLggAbawrdWzm1x5PkHllqyxcR
         6BSPIxZnEUt2lq4ogWuD0QbMMZpp7rhuYrGULXK2HqJDiWuK+Pg77SKtQGmNWvUJ5rrL
         k6edEvb17pvlouSVZO/ZK/hnWZFnKqFed2s9SBHYmztRR3v7aZQB87Qk2gB2AVu9dQn/
         Vvme6uPaLrMbRFm6fMaLWVdWsj7EHBP5GPjkB5n1s/eEM/NZyZE76UV//VJGwroIrnOM
         Pu1Q==
X-Gm-Message-State: AOAM531Q2ygxZ9iryPAQSsUJ3fbQEEVjxsFFxepOxthC00J3fAagjXUX
        YXqQXDbQxGDsK42fUkGcjPtbEw==
X-Google-Smtp-Source: ABdhPJyHDNFc7S714UpLGh6H9TO8+mtWiV+d2551Res7G9bjidD6KSZuEykfVAv+GwLI2R+l1Kwz0g==
X-Received: by 2002:a37:9b42:: with SMTP id d63mr1029815qke.449.1610395926569;
        Mon, 11 Jan 2021 12:12:06 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x17sm330240qts.59.2021.01.11.12.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 12:12:05 -0800 (PST)
Subject: Re: [PATCH v11 07/40] btrfs: disallow fitrim in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <7e1a3b008e0ded5b0ea1a86ec842618c2bcac56a.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3a4305f2-a3eb-7503-7c53-8c4039378f03@toxicpanda.com>
Date:   Mon, 11 Jan 2021 15:12:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7e1a3b008e0ded5b0ea1a86ec842618c2bcac56a.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> The implementation of fitrim is depending on space cache, which is not used
> and disabled for zoned btrfs' extent allocator. So the current code does
> not work with zoned btrfs. In the future, we can implement fitrim for zoned
> btrfs by enabling space cache (but, only for fitrim) or scanning the extent
> tree at fitrim time. But, for now, disallow fitrim in ZONED mode.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/ioctl.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5b9b0a390f0e..6df362081478 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -527,6 +527,14 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	/*
> +	 * btrfs_trim_block_group() is depending on space cache, which is
> +	 * not available in ZONED mode. So, disallow fitrim in ZONED mode
> +	 * for now.
> +	 */
> +	if (fs_info->zoned)

Should be btrfs_is_zoned(fs_info);  Thanks,

Josef
