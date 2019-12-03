Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580CF10F94F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 08:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLCHwo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 02:52:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34403 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfLCHwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 02:52:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so1445223pff.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5o2tlvcWEzBRNfbWj++og9/XAB65hoZ4kzJK+w5MHK0=;
        b=u6yNhP0bH37Ezd9zi1rdnNGEDWpGNuQz5xXTWKCwrpQZttx1ZKU43uTFUVMGGU5aSU
         1+WPp+ur2RTHkbkzP5VuorrhwVtYEX6YfI8l8fdpC3fwvqg5ktOHEOUNW9SlAzyFdaMB
         jj+NFbcz0SJA6oBliV2XTXs7tUPWvsXIMfsrzkch4X7DuoCXPgKlw9dqq+qLGp9iLU46
         5bB7s9a+2BQleGHEquIZC6I4hF+clAVMSr/++mU1I7sNXvAnVawYXWLfPq2X8r/GlR2k
         nM2V4098mA6BFzzd1Pedc48MQwxdWtfT7K8y4xHu/Y5ZChwbrVEzvCNCg8HKqn/4UdB4
         6+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5o2tlvcWEzBRNfbWj++og9/XAB65hoZ4kzJK+w5MHK0=;
        b=IGluJG4BX0oSjuu25/ZbOG+jKZTEx+1Fs6IbvEpKs4jKpoyP1iOPET00Xly4v8HKSs
         75ZwXRH0BZ57vp4hdSPqTtacVqyXZ/9KiUo6kfABEZc3zOG+qRKbl7NdpXLoXtU34LI6
         kuxSatJPYY6X5l6zPh4bzkTAPr+iGRSuhX6bczdyuOIRk1N6eqiYY+EDpB3OFHB7nBK5
         1iwa/Xq4j8nQoUUlaP8kSE+iAvgBH2GsFKMwI/x5YX8R4D5n7S/Ru+yowBCNahi7DqCU
         IFjPywNghZh/nmRaDrxARDcFQRQpTiGyvZkYqF80UrYsJGCpiUrO6myJRDxOTi6K64oT
         Yy2Q==
X-Gm-Message-State: APjAAAX/NYIAFkBPL334gaWam9iwUaaP0tRzxVYHgGD3ZIOrZvj9GYot
        iYVjawxExC+kYm2V7t4RJwnAgA==
X-Google-Smtp-Source: APXvYqw10Zb4s5nOdklnVCMrfzePmGDUkUgLPRCy838nYuTwPgVnEGyBJ4vX13HCaXOJIfyhSWJQdw==
X-Received: by 2002:a63:6787:: with SMTP id b129mr3986325pgc.103.1575359562751;
        Mon, 02 Dec 2019 23:52:42 -0800 (PST)
Received: from vader ([2620:10d:c090:180::c0f1])
        by smtp.gmail.com with ESMTPSA id r62sm2531427pfc.89.2019.12.02.23.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:52:42 -0800 (PST)
Date:   Mon, 2 Dec 2019 23:52:40 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Simplify len alignment calculation
Message-ID: <20191203075240.GB829117@vader>
References: <20191129093807.525-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129093807.525-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 29, 2019 at 11:38:07AM +0200, Nikolay Borisov wrote:
> Use ALIGN() directly rather than achieving the same thing in a roundabout way.
> No semantic changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/delalloc-space.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index 4cdac4d834f5..c08e905b0424 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -142,8 +142,7 @@ int btrfs_check_data_free_space(struct inode *inode,
>  	int ret;
> 
>  	/* align the range */
> -	len = round_up(start + len, fs_info->sectorsize) -
> -	      round_down(start, fs_info->sectorsize);
> +	len = ALIGN(len, fs_info->sectorsize);

Consider sectorsize = 4096, start = 4095, len = 2. This range spans two
blocks, which is what the original compuation gives. Yours returns one
block instead.
