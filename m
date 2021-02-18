Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D431EE19
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 19:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhBRSQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 13:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhBRQPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 11:15:02 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8952CC06121D
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 08:14:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o21so1763829qtr.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 08:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zmmyy/59e13ZAH2hA2IJQINd+2FrJeGOnuo1dgsSw3M=;
        b=nIHAFV0fpy64FkT0TILvnx3FiXhhxyv6ZE7pywc+PifgkKcYtAUpIbhh/a4mUYf2H3
         g4/NUSTCUZ1qSBuysepavnMKO7yNUA07T3zCv+XM8uyM7S9fGHlAk1fhjaf5OyAQ5y/J
         XnEGE4Hn1jHPZbI33Qxb66Vl6hT58lOWtX7sWkqAFpMSPdF8LFr/ybF/yPIk0Oguv0sW
         DPOFB2fNe5fYAdkriIa7QrH05hAIPx5E4AASpBdwDKwZKiUK3Ud6/sVw/ItscfXMBbF6
         dTRptEsbNjktv96M3u0fZJRW4lWpQGRwrcQSREQWVRRzfM+T5WMj6KVutRbdevMKONhN
         MNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zmmyy/59e13ZAH2hA2IJQINd+2FrJeGOnuo1dgsSw3M=;
        b=t/s2EfpbQ9ZDUaJa7LlT7GZLZ90KGfaQf7HhmHG0uJhjKQ2FB0F+zBrEq4d2mipa4p
         h3ElatvH8csXMAAy660y6XI2sJhzURl0QqgFJEuTO5OulJ8kf2+SAFn5yH1+n0iBbHI6
         f3dfVzTGoKC3HaIBrIgLgDxVwXEB4ZrsEvCRJbKVeM/AzRkDylfY6SWp26bRyhkMSmIA
         mGm2Zmm8Dk+/SanzG0hKTWhLbQb6KlcnKxE3dBNS/mH5zqlIqTuS5PuPGSdnUqRCZWsC
         51DPRTwlFZzcoM2a3u4uV9fl6r3oF5XC0GpgJv4irD7qgtdoltl46HW7BuDIb+I+ZV3T
         H6kw==
X-Gm-Message-State: AOAM5306a3I8/YiBgW6Ybzn25umwAS2ggM0iVwSvtl9wfx817J0dNBB1
        nFHBt8jEb+nfOj2X/p5LIMbI846ri9CnQBLd
X-Google-Smtp-Source: ABdhPJyScK5wEG6Ng33OHGnN3StaAZSTlheeagQsU7RpGCTPITq/poKrQG9OiLseoUOKJCdE+fYcTw==
X-Received: by 2002:ac8:44a3:: with SMTP id a3mr3106684qto.322.1613664859136;
        Thu, 18 Feb 2021 08:14:19 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::1105? ([2620:10d:c091:480::1:70a3])
        by smtp.gmail.com with ESMTPSA id c9sm4250063qkl.60.2021.02.18.08.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 08:14:18 -0800 (PST)
Subject: Re: [PATCH] btrfs: make btrfs_dirty_inode() to always reserve
 metadata space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210108053659.87728-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6bc8bef5-43a0-f6c6-9b43-2f62a3e4e051@toxicpanda.com>
Date:   Thu, 18 Feb 2021 11:14:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210108053659.87728-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/21 12:36 AM, Qu Wenruo wrote:
> There are several qgroup flush related bugs fixed recently, all of them
> are caused by the fact that we can trigger qgroup metadata space
> reservation holding a transaction handle.
> 
> Thankfully the only situation to trigger above reservation is
> btrfs_dirty_inode().
> 
> Currently btrfs_dirty_inode() will try join transactio first, then
> update the inode.
> If btrfs_update_inode() fails with -ENOSPC, then it retry to start
> transaction to reserve metadata space.
> 
> This not only forces us to reserve metadata space with a transaction
> handle hold, but can't handle other errors like -EDQUOT.
> 
> This patch will make btrfs_dirty_inode() to call
> btrfs_start_transaction() directly without first try joining then
> starting, so that in try_flush_qgroup() we won't hold a trans handle.
> 
> This will slow down btrfs_dirty_inode() but my fstests doesn't show too
> much different for most test cases, thus it may be worthy to skip such
> performance "optimization".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'm not interested in slowing down the !qgroups case just for qgroups.  We want 
to short circuit the start here because it has the potential to be _very_ 
expensive, when we may very well have space already allocated for the inode.

The best solution I can think of for this is to add a bool to indicate that we 
don't want to attempt to make reservations.  The only problem here is if the 
inode doesn't have space allocated for it, if it doesn't we need to fall back 
anyway.  The speed up comes from inodes that already have the delayed inode 
setup.  So simply tell it to error out if we're not already set up, and then we 
can fail back to btrfs_start_transaction().  That'll keep us in line with our 
performance for !qgroups and solve your qgroup related deadlock problems.  Thanks,

Josef
