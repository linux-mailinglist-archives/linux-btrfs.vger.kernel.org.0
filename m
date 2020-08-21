Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0B24D710
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHUOLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUOLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 10:11:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8CC061573
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:11:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so1270324qtg.4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/O7GsQlyOvKMn4vyIwYIr3C3iH5spCXWnHT7lFFAbyY=;
        b=azMuqrPNOdNg2w70CvNRuUyt5rnFriNwiKakFhXOpvnFpexz7yruIqjma3h0vFsJ29
         1Qy0FCVqaVtCmh+9q0zyYjIBhcOXxgTRKGSxLUkCIeRf4CLq+NcBGNGQHRaHsLRM67cj
         mO8wJHaXCIGKyaDZBpS5StuxO/+6sdVbK+Bftmmbx2FeI8hJcTGrXqpVUlD+96TC+idA
         rweeIzIkcDeFBMkBNVHufmb7P9Eyd2+Ttbf2rZ6nSnk7eWFWInSZiifqIYYoCLOceKKA
         gzz+kpZG1PXyqTCHH1VqnSrKjJU6DzN9aAx7bmd+f7xzRETL0xhfOacaPITRtNkDhr5U
         Ur6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/O7GsQlyOvKMn4vyIwYIr3C3iH5spCXWnHT7lFFAbyY=;
        b=iltAHH9s9kFgZ7CBkvPIqRv4W3/QwbYH/v1lzOW2BvC+yLCRjvWbx16vmWBkc1/uKu
         SX0jL4QTFWuhutx+A9Dn4kbOjL5FMuG7e9Bh1RddpOoSJDG5NBT6rURD3eYQ61tf+zZw
         UZndrDRGW+DepkHUE3rlfhTK920VplsNW+97rADzJr8aR/tzNVT/TjKd9CFyIWCn0zAs
         uDR8am3+MqrCs9eMo8e24vT7GwE4zR4hxTjT9MJ1ShIvnLDmVSoScyHtTSvB08BAfVU0
         e/ZSIu/L7lA/oEI3XhNIAeW7EMhobf2PTpafXWaTn+MH2szLA0b8/KgkIAmQOrFLA2bx
         gVsA==
X-Gm-Message-State: AOAM532nU162TqNLPzxt46voBsKiA4GR0/htMvMFF8/s1wuSNm1ad/7z
        niH+7xO+q0cuIiUyC1fzevaD0A==
X-Google-Smtp-Source: ABdhPJzfnGpcJKcS4ULozLzoVaIH2pkxr/lK8lZcQc6x9wmaPcOQ6uDtYUIhhN4cj4uKEdsMM0D9Mw==
X-Received: by 2002:aed:2dc1:: with SMTP id i59mr2956362qtd.340.1598019106177;
        Fri, 21 Aug 2020 07:11:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x28sm1798067qki.55.2020.08.21.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:11:45 -0700 (PDT)
Subject: Re: [PATCH] btrfs: check return value of filemap_fdatawrite_range()
To:     Alex Dewar <alex.dewar90@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200821124154.10218-1-alex.dewar90@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c3c0ddbe-e225-22a4-c9bf-9317a50c211b@toxicpanda.com>
Date:   Fri, 21 Aug 2020 10:11:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821124154.10218-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 8:41 AM, Alex Dewar wrote:
> In btrfs_dio_imap_begin(), filemap_fdatawrite_range() is called without
> checking the return value. Add a check to catch errors.
> 
> Fixes: c0aaf9b7a114f ("btrfs: switch to iomap_dio_rw() for dio")
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>   fs/btrfs/inode.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7b57aaa1f9acc..38fde20b4a81b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7347,9 +7347,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>   	 * outstanding dirty pages are on disk.
>   	 */
>   	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> -		     &BTRFS_I(inode)->runtime_flags))
> +		     &BTRFS_I(inode)->runtime_flags)) {
>   		ret = filemap_fdatawrite_range(inode->i_mapping, start,
>   					       start + length - 1);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
>   	if (!dio_data)
> 

Had to check to make sure there's no cleanup that's needed, there isn't, 
you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
