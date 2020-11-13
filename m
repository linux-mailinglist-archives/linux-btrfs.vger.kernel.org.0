Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9762B235B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMSJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMSJn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:09:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9EAC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:09:43 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so9613109qkk.10
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RaURlSC+ZEhxdxkE6te0Bpf6rfiJQu8Gi2LL1lKy8bw=;
        b=u6vyd6yXzVnizNb0zlVj1FC2wGbz/RzT4Q3rdgVYFJLFDVf7nYoCCZEFO19N+Rkl5H
         S86229BcnMCsQA57qgAT7a3vp3cM7uSbtDNT+1OhAR1YtyjjM5mCXGMrlhMfIejD++1x
         oFEHmx1R3UBhT7p34fIkp/HuztzmwYXXpl8FzVxXQOW/BhgLa2UmJR6pY1nbMVhJ2NEg
         jSZu1Is5YIlr3wx9tE/Mg+AZ7kZH4YPPWKgwIxPH3qpJsvfZK+N6nirSTfkhoVbRInwk
         yNWbrx6d3pYW0TR089BtVgPxGA1vLQJ3oq+T+gEgBqNcmBwuBULOaoStV1wTWLUOZy9o
         ZPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RaURlSC+ZEhxdxkE6te0Bpf6rfiJQu8Gi2LL1lKy8bw=;
        b=ArisPRNTTxilJX1VdC9DqnL7FwQhHolI4x5GY9PLTl3gyEzCcnKZpFULLx5hHH3g93
         MASNamRZpMgaK+hMgRLkGTvRBcwQtD5wjOic4m/Es47kp2yzjZz20UKAtHvRVKL/ygc8
         4S4BA0KHjd394nEtZ5OSr8rKmhQoX+skVn/WNDLWVIu3F07jWEwpDEvakyjOebgmxx6y
         /G5/xTVWbjD4L+NFyKwQ5TvG3S6cfbVZw8AfVQ+4BwaS6T8gPWJ0ULfD0/+f4TIwFQ9y
         5OGH7OtuK7EUS95oA1Jy6lwvklMVrjLm/p6DZFiTMapno000lPAWD3Wjgl4mI2+z2OzE
         vMWA==
X-Gm-Message-State: AOAM530YIT1uI3oPvAZwIsZcKl0KcV2A7QTtK+tBN8wQIyFM+Z2SfsMA
        uElj/lcr1lNlQl0bbtjUCywM2iZALK+cBQ==
X-Google-Smtp-Source: ABdhPJxN9MV0rXyTF8gSLMb6ZcuNQC+/LyAXTjcnKBqPRn5vS3WIziq3h0296VJrL5qgw4Xis6VaFg==
X-Received: by 2002:a37:4491:: with SMTP id r139mr3277837qka.244.1605290981878;
        Fri, 13 Nov 2020 10:09:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 205sm7147624qki.50.2020.11.13.10.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:09:40 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove unnecessary attempt do drop extent maps
 after adding inline extent
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <1b80a3ffc965dbf663ab746dc11ea5e9fa1e10bf.1605266387.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8598e119-533c-b1fa-9574-1567a3353430@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:09:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1b80a3ffc965dbf663ab746dc11ea5e9fa1e10bf.1605266387.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 6:24 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At inode.c:cow_file_range_inline(), after we insert the inline extent
> in the fs/subvolume btree, we call btrfs_drop_extent_cache() to drop
> all extent maps in the file range, however that is not necessary because
> we have already done it in the call to btrfs_drop_extents(), which calls
> btrfs_drop_extent_cache() for us, and since at this point we have the file
> range locked in the inode's iotree (we are in the writeback path), we know
> no other task can come in and read stale file extent items or find none
> and therefore create either stale extent maps or an extent map that
> represens a hole.
> 
> So just remove that unnecessary call to btrfs_drop_extent_cache(), as it's
> doing nothing and only wasting time. This call has been around since 2008,
> introduced in commit c8b978188c9a ("Btrfs: Add zlib compression support"),
> but even back then it seems it was not necessary, since we had the range
> locked in the inode's iotree and the call to btrfs_drop_extents() already
> used to always call btrfs_drop_extent_cache().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
