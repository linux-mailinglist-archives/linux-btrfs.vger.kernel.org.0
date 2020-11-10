Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079592ADA70
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgKJPak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 10:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbgKJPak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 10:30:40 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBAC0613CF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Nov 2020 07:30:40 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so4701741qke.8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Nov 2020 07:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=awtt2N3bMoJlI0DC8k6UKhrRAAJv5KsFBFcxRiJ4b5Y=;
        b=qCFIC8AGsdsIQGbMDH0Wcwv3u6LYEJCdzJ3uy/9C519XPPCJg/N/7l3v218+VdhY3C
         j97BUztqPq2wBFo8Y0XSI2egiD6IMNFYfilz4HHEerrW7PozF9tSXbcphmC6tGExbXGi
         mFbW73FLwrQbMxUu08pTkVIYE8C/Svf/ZrqN1yeUujX2jH2zmXdG49VbGD0QLiaNX86z
         0QRkF8zcPIzgbxw+hvn7h3kAcwnMS9AiLtrSltVmKCLV9wDu4OM4tpyynC0ODxowrfpc
         ZPIrIJRSRd1+/S3xW1OFAgQWUVH09E9Wsii2bREVISxU4OVWilZ7I0DEfpYNbyBVSI5o
         JwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=awtt2N3bMoJlI0DC8k6UKhrRAAJv5KsFBFcxRiJ4b5Y=;
        b=S/oZJaufGJOsM0L858tdHD4ELoQtFHhba9Z4PN96jMQAKRFE6h9WtKsLgPfGkTJuGi
         Oe+6tFQpECokgZfrx1KiGBFz8pN01u9o0Yaj2GgGXzYqaKWG+WlUdeqhkGhDBvLiMiIy
         nTU4/WV8tmiB6ttM1roHfJiMyXGREErYK981Iune3R38WG0uRvfyN2gmgdhrGyCmixKL
         lWcTbSr9KEtqjxV4E71oN0ply2HFuBCn6xQtO7VSdrENBWEAzGtMrBXamYpytQ1gwiH8
         bHnr5xZD61Qr7pxkt+7D/VLa4q2ba2GhayedHcTsEoZj0WO0pWuUWUMdKcfGN2SSoyuD
         XIoQ==
X-Gm-Message-State: AOAM531CfpxQlDnKTdEuUh9UVLuBhiB7QsvGgkb1Rltm3r0fvymSpRnu
        xp0tftxMXrAd81PcqgQMbLUmY+XCRaVLuAVq
X-Google-Smtp-Source: ABdhPJyD+HR3mwID0Dx/hp/01lk0Tbdu4HMgfeY0t9KrcHt8JzjkFXugMGxdY8sB4W3+zbkvEq6LKw==
X-Received: by 2002:a05:620a:4d1:: with SMTP id 17mr10131352qks.40.1605022238433;
        Tue, 10 Nov 2020 07:30:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n4sm8650868qkf.42.2020.11.10.07.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 07:30:37 -0800 (PST)
Subject: Re: [PATCH v2 2/2] btrfs: pass disk_bytenr directly for
 check_data_csum()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201110020909.23438-1-wqu@suse.com>
 <20201110020909.23438-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <19a1507a-2a9e-805d-3b0d-66609f07decb@toxicpanda.com>
Date:   Tue, 10 Nov 2020 10:30:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110020909.23438-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/9/20 9:09 PM, Qu Wenruo wrote:
> Parameter @icsum for check_data_csum() is a little hard to understand.
> So is the @phy_offset for btrfs_verify_data_csum().
> 
> Both parameters are calculated values for csum lookup.
> 
> Instead of some calculated value, just pass @disk_bytenr and let the
> final and only user, check_data_csum(), to calculate whatever it needs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 14 ++++++++------
>   fs/btrfs/inode.c     | 26 +++++++++++++++++---------
>   2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bd5a22bfee68..f8b5d3d4e5b0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>   	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
>   	struct extent_io_tree *tree, *failure_tree;
>   	struct processed_extent processed = { 0 };
> -	u64 offset = 0;
> +	u64 disk_bytenr = (bio->bi_iter.bi_sector << 9);

This doesn't work, bi_sector can be remapped based on the underlying device, and 
thus can be different between submit and endio.  To illustrate this point, make 
2 partitions on a single device, mkfs the second partition, and then run 
xfstests with this patch applied, all sorts of fun will happen.

In fact we should probably add such a test to xfstests to catch anybody relying 
on bi_sector to stay the same.  Thanks,

Josef
