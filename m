Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A32B235C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKMSLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMSLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:11:09 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A0C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:11:08 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 3so7336833qtx.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=W+DuL2aI/+ewkesStt57wP5+fvYD8AKxr1PwkBFg3wM=;
        b=r55eI4/VkG40WA/yiea/aU/d3Jcj4cuFUbtlwr4D71p/JdS9mQLWSOUIasCndvG7/T
         KQO6YqnQy+LaLvFYJVw7wxiimXxva2ZVkDP5rOriCIksGllpmq+DFUuKgqJlyVinvMEw
         JJsEcyb70oAO2XswLZGzrxsSVDedQcuo4zhXLs3PM198rCGdGOha6I8O6xgvzGqHV9+m
         +hQCF3616JwrGHY64d+/qfXH+MZB63mfy9HWnTLVTdTl0MVc4pk/gQrM1lnRi0PR+u1c
         0LU4AfyXC3oSjI1KyHAONl4NBiFU0EMTi+tRgcDqbHBR4svsYsL1cOr/hCtwfPD5iapq
         yqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+DuL2aI/+ewkesStt57wP5+fvYD8AKxr1PwkBFg3wM=;
        b=gf+uNUXPkfBaBMnoxT2Ok4EixNijnm1AC+U/H7k/TXua/Q6nP700ch97iEvz46t/Ah
         mO3kjpYaMMz4eILxJWVi297pQBSe/1qxvXIXSjSktm1FBU2Fx5kooPc9db4HsFAZetCP
         rRRQXz4qQLgXd9iZKrn/j7fWnq1WkhES1LU8ai4l86HMTEUZHsK+UOz0Hs7ktmw1onpl
         HUCZ1ZNrvkmoJG62gj/DEXZaRgE+gYswoa2JxjU4+DkvFbGZMnnWGYTiZcXKg96epwJB
         gLi6QFJ0Lrshcj1zaJq/JqY9DEpWyPzHvAdxPOy5d469upOT/dwMESkBLPNHNPfvs+3t
         R0XQ==
X-Gm-Message-State: AOAM530TqC4zZhcMAyPgeSiqVgj4u+P7Yq7CMI8UAd7Nf7mzyNqbdu/E
        xja/TRTywPJBGf9m/c2isUb+diyPe+s5bQ==
X-Google-Smtp-Source: ABdhPJwVgB2BN8V3FtyZdL+bfqdR7Vh5eeVSmNAEqHjVrc5h4GhgYvbH35dOBKkZyHD6hdaOxD7WsQ==
X-Received: by 2002:aed:3b5d:: with SMTP id q29mr2988571qte.91.1605291067762;
        Fri, 13 Nov 2020 10:11:07 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s27sm7296917qkj.33.2020.11.13.10.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:11:06 -0800 (PST)
Subject: Re: [PATCH] btrfs: stop incrementing log batch when joining log
 transaction
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5c0655d43b2809932ec8aa40d99b94295469e3f1.1605266377.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4a68f7d0-2afd-972c-514e-ad0964f9f4f7@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:11:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <5c0655d43b2809932ec8aa40d99b94295469e3f1.1605266377.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 6:23 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When joining a log transaction we acquire the root's log mutex, then
> increment the root's log batch and log writers counters while holding
> the mutex. However we don't need to increment the log batch there,
> because we are holding the mutex and incremented the log writers counter
> as well, so any other task trying to sync log will wait for the current
> task to finish its logging and still achieve the desired log batching.
> 
> Since the log batch counter is an atomic counter and is incremented twice
> at the very beginning of the fsync callback (btrfs_sync_file()), once
> before flushing delalloc and once again after waiting for writeback to
> complete, eliminating its increment when joining the log transaction
> may provide some performance gains in case we have multiple concurrent
> tasks doing fsyncs against different files in the same subvolume, as it
> reduces contention on the atomic (locking the cacheline and bouncing it).
> 
> When testing fio with 32 jobs, on a 8 cores vm, doing fsyncs against
> different files of the same subvolume, on top of a zram device, I could
> consistently see gains (higher throughput) between 1% to 2%, which is a
> very low value and possibly hard to be observed with a real device (I
> couldn't observe consistent gains with my low/mid end NVMe device).
> So this change is mostly motivated to just simplify the logic, as updating
> the log batch counter is only relevant when an fsync starts and while not
> holding the root's log mutex.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

You had me at "simplify the logic"

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
