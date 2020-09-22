Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8041B2744B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVOwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIVOwR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:52:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26AEC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:52:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g72so19243070qke.8
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dF1fa23J+l+HEWIXsoK1ROlWlXhWeKk0bxWwAqVjy6A=;
        b=R/YjV4UwaRJaRG9MQlKAYtN1BOWc8h82b6sGyauvHvepfQsfJzCmVK9FhxF3nnsJ2F
         cEBRu7HaKjfHjjWrxaXpf0ud6Zzm/krjFOmgV65w+fTPAtPLXuFbYTJWoYtO5uXFTcxP
         1QPSjVoI3Aosl0SzyEAWjTJh1fC+CMsOVJho9mFPoFpNYp2UDJGLxdjbjgOxv4n5PNuz
         H7fAMMBoF2x0h/wfJWeHTRBl4d9KfVU2YKGVgdMU5ze2Esklk9DHAQkqadozEp+g9HXo
         1SZ5Dv+MRAVYL/ge1w7bR31LLCumyh9OlxKJ5P/bVJ1k9h6lzEVq+7QW4PvjRz7zYTk8
         c1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dF1fa23J+l+HEWIXsoK1ROlWlXhWeKk0bxWwAqVjy6A=;
        b=pZDUUWJdp+Kctwz2917D6KvH8v/0y14tN0whSbkoMspnJQMYMWCdxrjFc8WIda/xHO
         v5Szwjp2OaLoeBVRWj0ETYOQz8NZ44Mp5w9QObEJpOMdFC2L0LCaaavY8liW+f8JfeK4
         zr1ieLT5OCn/b9v4n/MMzimmnAq6c3pmJQGugv02s5k9cVNHf9oVv+s5hlWNZXQtD0Um
         65M45wdGbiwyxp9u01i9+ahCQALNiFhBgkcK3S0dVHQb1Gy1gK28birq4hycPSGkV4W7
         uJH0OGfLiIjouVT7jutbt+te7aH1iqDfNUizkaHNoxiiTMBDnKfK9ARLXaaPJle1bNGB
         8B9Q==
X-Gm-Message-State: AOAM530d3OtyiiyEbihZgqHUJ5/lyftXHwjPKYPGc+BsQVUmJrhSO3vj
        5On6WDNjyAzmB2JStYGMdYyDeA==
X-Google-Smtp-Source: ABdhPJxasZxfhJZ5H4uf8BgLFKo+hiKwBWwEWJEVZFgSQMLbqae8mXbxm2At9NC2QyAm2exLoabS9g==
X-Received: by 2002:a37:62c4:: with SMTP id w187mr5124409qkb.102.1600786336392;
        Tue, 22 Sep 2020 07:52:16 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 205sm11386504qki.118.2020.09.22.07.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:52:15 -0700 (PDT)
Subject: Re: [PATCH 11/15] btrfs: Use inode_lock_shared() for direct writes
 within EOF
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-12-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f3a6965f-f3e2-9bef-3dc6-b53cdc715833@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:52:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-12-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Direct writes within EOF are safe to be performed with inode shared lock
> to improve parallelization with other direct writes or reads because EOF
> is not changed and there is no race with truncate().
> 
> Direct reads are already performed under shared inode lock.
> 
> This patch is precursor to removing btrfs_inode->dio_sem.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/btrfs/file.c | 33 +++++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index d9c3be19d7b3..50092d24eee2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1977,7 +1977,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	loff_t pos;
>   	ssize_t written = 0;
> -	bool relock = false;
>   	ssize_t written_buffered;
>   	loff_t endbyte;
>   	int err;
> @@ -1986,6 +1985,15 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>   	if (iocb->ki_flags & IOCB_NOWAIT)
>   		ilock_flags |= BTRFS_ILOCK_TRY;
>   
> +	/*
> +	 * If the write DIO within EOF,  use a shared lock
> +	 */
> +	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
> +		ilock_flags |= BTRFS_ILOCK_SHARED;
> +	else if (iocb->ki_flags & IOCB_NOWAIT)
> +		return -EAGAIN;
> +
> +relock:

Huh?  Why are you making it so EOF extending NOWAIT writes now fail?  We are 
still using ILOCK_TRY here, so we may still not block, am I missing something? 
Thanks,

Josef
