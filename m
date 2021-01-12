Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554C32F34D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392592AbhALP4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbhALP4P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:56:15 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F57AC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:55:35 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c14so1845154qtn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kfo++mRTL0+axUxWJs/4HvDJ6pxImj+mNKCIx5TUXoU=;
        b=xGJF3yku02dY26UYTGGpZbqZfQxcAp+6Qzt2XNHQjdd9XUfeNY7R1yMFh7puBmfkO5
         vy5bkL826cqp0RPAesd8Ipyt9474pIgSyuWPDVOD2IeyB7Y13NUlIg+mkdI5FVnFvghb
         thu4A73yNFY7/gINVY9YkQiMX5weiJjHYE2DYiBx8E/4PNJCoHjF8lFeOQdKc5QY37nF
         1KpNqdPhFxyKrCjSzdFh0zL9mn/+SfXvlXjwH+Ivb0+lpoURzAK1OUpIAW6iAxU8pi7V
         u9iejKbp5WMKfaF6CQxrNgoCZarEeKS9WhJGuNZjFdJ+DaXy+z3WRyniGnghp+24Y+iY
         0pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfo++mRTL0+axUxWJs/4HvDJ6pxImj+mNKCIx5TUXoU=;
        b=Ev7r8Zkl+Tdu3lK0fXBTjb4gPLA96QPe3ARhwgpFmNbLIUIdr2VFk9l7IagS2aSn7H
         3qeIQgTcK5749L4LMVNHDGI9gwyVTD+c0rJUcUeR6gc8feAf8B4cvKItw9Lr35vcqw1z
         d4Kifc6vKcUl1lavO6kMuBSG/0+GWGFIppkf0tmw3ucyWxlTDRWcrrHXdZcnJ+3o5CnK
         OqiwI4TRPcudyNkEFLE4AVdIj2Pxc16a2iiQcln2jl1eKSgeDdKKvroqAGKtsX+EPBkc
         zmAWdxTa2+OpuWq5ss8k2RhuNgJQz8ORvlnY4zu5sAjFaGSvYPH9411t25uLLepxmbAq
         Z1EQ==
X-Gm-Message-State: AOAM531ySPjaxUKeKKLkKHTU+Xnn7A17CL2lyiKj74smXDQUIAIBKsoU
        3tMZX47piwka0kigExe3LqCHLg==
X-Google-Smtp-Source: ABdhPJz4s8XbFEn7uo62lz2TFOmSAIO0nb+4mCp7Z4OUicaueYU1jBWa52KbMgZVdmVbpzWuFjyhyQ==
X-Received: by 2002:ac8:7a81:: with SMTP id x1mr5153381qtr.373.1610466934341;
        Tue, 12 Jan 2021 07:55:34 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x47sm1248239qtb.86.2021.01.12.07.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:55:33 -0800 (PST)
Subject: Re: [PATCH v11 20/40] btrfs: use bio_add_zone_append_page for zoned
 btrfs
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <bf6e2912dfc3062a914fb4c1ea5e550ac514725e.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <35fe0719-d947-b745-1a53-0d3903ab8e7a@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:55:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bf6e2912dfc3062a914fb4c1ea5e550ac514725e.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> Zoned device has its own hardware restrictions e.g. max_zone_append_size
> when using REQ_OP_ZONE_APPEND. To follow the restrictions, use
> bio_add_zone_append_page() instead of bio_add_page(). We need target device
> to use bio_add_zone_append_page(), so this commit reads the chunk
> information to memoize the target device to btrfs_io_bio(bio)->device.
> 
> Currently, zoned btrfs only supports SINGLE profile. In the feature,
> btrfs_io_bio can hold extent_map and check the restrictions for all the
> devices the bio will be mapped.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
