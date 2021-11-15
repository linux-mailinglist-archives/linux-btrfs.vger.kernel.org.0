Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310E451584
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347235AbhKOUkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 15:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347662AbhKOTlE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 14:41:04 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B03C061200
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 11:24:21 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q14so16624153qtx.10
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbetVAUo5OZxsQxnRG709OfZCVKW0qtMqw1TKeW/LHA=;
        b=delKKYP1+D4hUsTSll3T5LvEMa8maz5tKRNduqMZie+6Ga4b3hiTJuZPKJGdsKsEnk
         rTixg8tjhq+3YmhfS4hCIsqIzZNp5VxT5RjJzFj2Kgy19u8ddKDK8VCnXUFjPSMA0SVm
         riDZ4LxrcMcSgvqZIwYNSa+yPqssqz1rLBmBxuWeb/oF5Q2/HIP1FYeQbK+leVXXkJHs
         44ivJRV53aiBVzoHomTnoZp8NidhRpwRB9mf7zRb18JwdkqqGOlD/+dCcwhORR1U/7xh
         JZFXzIEf12VygTQqgTJJUARBg+p8whEs7txXaA/20M7H3BVmjzSX/MaQ8wufYp08ur+1
         ZtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbetVAUo5OZxsQxnRG709OfZCVKW0qtMqw1TKeW/LHA=;
        b=fG/OpQ8Y28aFdzgnjAQT8om2s7r54peLSiYkRYaT1MnMQreUb7is+B/CD7PZDYm0Ut
         KylTSD8utajUBwm/unvWJrhRpGH6XR2hrF5g14O5+FJ8FEPllrm7zxdGAfbO34ljP02F
         uOYplHJkiL3hquF+NN8rA7eGNNBIK0BuOl4aK9JhTFhbNp9dqbnZuvp5LWSmFAoltG0i
         VkQ/oFMfggENfAr2Qiw7mA6b9ydz19pa+63EMbrnlPWwikib0ctCX7h5ek6HhLphL3Bd
         Hq0pYcKUkCxb0mzsuIeo3tFb1k1jIYX9HdIZQfS/3uYXs0b+Oxx9CUp3ZTmp7sPz9H28
         ztNg==
X-Gm-Message-State: AOAM531c4HAowdd2xtNVaRblNooUFyobJfP1BBlBrKp2hnZHTVSsBDuc
        ry7GemFq9HnvPn8M5k2N/NAEhA==
X-Google-Smtp-Source: ABdhPJzM9Fdn/HwpmHLZry3+gjCaloKCU7yjQIAbddFuil1BgOe+dgwh80XxMw5kv6hhC5l7qaBRRQ==
X-Received: by 2002:ac8:7d47:: with SMTP id h7mr1507871qtb.188.1637004260740;
        Mon, 15 Nov 2021 11:24:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11sm1046560qko.116.2021.11.15.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:24:20 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:24:19 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Message-ID: <YZKz4wQWo85vCROd@localhost.localdomain>
References: <20211114125101.19751-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114125101.19751-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 14, 2021 at 08:51:01PM +0800, Qu Wenruo wrote:
> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> v2 cache by default.
> 
> However nospace_cache mount option will not work with v2 cache, as it
> would make v2 cache out of sync with on-disk used space.
> 
> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> to reject the mount.
> 
> There are quite some test cases relying on nospace_cache to prevent v1
> cache to take up data space.
> 
> For those test cases, we no longer need the "nospace_cache" mount option
> if the filesystem is already using v2 cache.
> Since v2 cache is using metadata space, it will no longer take up data
> space, thus no extra mount options for those test cases.
> 
> By this, we can keep those existing tests to run without problem for
> both v1 and v2 cache.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks, this explains a weird failure state that I've been seeing with btrfs/199
writing into /tmp and filling everything, which causes the rest of the tests to
fail.

Josef
