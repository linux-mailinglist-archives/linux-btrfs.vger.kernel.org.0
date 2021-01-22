Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079B8300CDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbhAVTmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 14:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbhAVTU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 14:20:27 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C3C0613D6
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 11:19:46 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id c7so6262649qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UX6sWvfpYt619eHX626D4UcK0QO9wKCcgj5kSsNjHq8=;
        b=fBdt2ac3zMFBew51ZOwCUddvotGlkzTxgbdeRVS2ByD6r9x5xqCzx1nafhhh2hONeW
         5zIYS4TeLGgyUvRdmrbjojDXtdnhklhpXwGgxBJmajQOq2s66Ku1db+PEIS1pEr38Peq
         2g4WTE6yq/7rtoh66mvgu3ZkmFlYD8mmLtTbtdG1qkSh3dEE8xGMhPcsR+EZoDwHfNM5
         qUdxsRxtKXosvYINKWSQcH0Gzb45bw718Nq5argGM8SAS3GKbEvKFRE95s8ulzWrtTeb
         AVQg8/4yrvgi2fYs2DNkLOUPjS3jvVWqV8LLnBsFKan5selEPgQwGEQlORF2x7ydDXl9
         ve6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UX6sWvfpYt619eHX626D4UcK0QO9wKCcgj5kSsNjHq8=;
        b=oyJQJ5E+MQONj6T6C3ZiRjNUlH6oy3I4Xi3qB7ORluuQAb60r2JP+LvY8xT5XbM1P7
         pMx3Tjbk+o0zWKIyoZ8Zl0bvYNZlS7IF6+gd3mEVPTwA94fvju8HoMwJBE30PHrGLbeb
         7zLld0H6LQ9mxbI40ojc4pWkt9D7BaFtAP/3YRP0Ro0cHKDRu25a2E5sAT2+IcDdOcV8
         INdOidPd7kH9mRTHh98Kbq42R7Sa0/rpcMaGc1v2oSS+cQ2UP8hifzAdEKT4+ADzRZNN
         siyUubo7xlyhQnXyrKjRuNM7HMVg2LksQbLuWjmI0Rm5XwnP9IpwmnyWSR8afI2VBGXs
         65zg==
X-Gm-Message-State: AOAM532sa4xBzUNRx/kZfm3WQiQi9Dw6Q7v+zesnZhk41m0mZfa8LbI3
        Ybs4D4DFZv/KLjFflXYhH9+rj8qrMuR5fuop
X-Google-Smtp-Source: ABdhPJzCTYMcov5EfIB9jNV8xdxM81pl+RseiOmwygLVEyYoIvoIg+XVDRNMN9MBqEHDd0jCR0hHCA==
X-Received: by 2002:ae9:e816:: with SMTP id a22mr6497914qkg.82.1611343184947;
        Fri, 22 Jan 2021 11:19:44 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d26sm6256834qtw.58.2021.01.22.11.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 11:19:44 -0800 (PST)
Subject: Re: [PATCH v3] btrfs: fix log replay failure due to race with space
 cache rebuild
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <c655306f61af9b2d75ed22053a7cdc3f21022d72.1611337435.git.fdmanana@suse.com>
 <afa2ccadd8add70cf742ed7943c01be6fccd13b8.1611340095.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c3fd5a2f-20e0-56d4-ca58-5583416aa869@toxicpanda.com>
Date:   Fri, 22 Jan 2021 14:19:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <afa2ccadd8add70cf742ed7943c01be6fccd13b8.1611340095.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 2:07 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After a sudden power failure we may end up with a space cache on disk that
> is not valid and needs to be rebuilt from scratch.
> 
> If that happens, during log replay when we attempt to pin an extent buffer
> from a log tree, at btrfs_pin_extent_for_log_replay(), we do not wait for
> the space cache to be rebuilt through the call to:
> 
>      btrfs_cache_block_group(cache, 1);
> 
> That is because that only waits for the task (work queue job) that loads
> the space cache to change the cache state from BTRFS_CACHE_FAST to any
> other value. That is ok when the space cache on disk exists and is valid,
> but when the cache is not valid and needs to be rebuilt, it ends up
> returning as soon as the cache state changes to BTRFS_CACHE_STARTED (done
> at caching_thread()).
> 
> So this means that we can end up trying to unpin a range which is not yet
> marked as free in the block group. This results in the call to
> btrfs_remove_free_space() to return -EINVAL to
> btrfs_pin_extent_for_log_replay(), which in turn makes the log replay fail
> as well as mounting the filesystem. More specifically the -EINVAL comes
> from free_space_cache.c:remove_from_bitmap(), because the requested range
> is not marked as free space (ones in the bitmap), we have the following
> condition triggered:
> 
> static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
> (...)
>         if (ret < 0 || search_start != *offset)
>              return -EINVAL;
> (...)
> 
> It's the "search_start != *offset" that results in the condition being
> evaluated to true.
> 
> When this happens we got the following in dmesg/syslog:
> 
> [72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
> [72383.417837] BTRFS info (device sdb): disk space caching is enabled
> [72383.418536] BTRFS info (device sdb): has skinny extents
> [72383.423846] BTRFS info (device sdb): start tree-log replay
> [72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
> [72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
> [72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
> [72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
> [72383.460241] BTRFS error (device sdb): open_ctree failed
> 
> We also mark the range for the extent buffer in the excluded extents io
> tree. That is fine when the space cache is valid on disk and we can load
> it, in which case it causes no problems.
> 
> However, for the case where we need to rebuild the space cache, because it
> is either invalid or it is missing, having the extent buffer range marked
> in the excluded extents io tree leads to a -EINVAL failure from the call
> to btrfs_remove_free_space(), resulting in the log replay and mount to
> fail. This is because by having the range marked in the excluded extents
> io tree, the caching thread ends up never adding the range of the extent
> buffer as free space in the block group since the calls to
> add_new_free_space(), called from load_extent_tree_free(), filter out any
> ranges that are marked as excluded extents.
> 
> So fix this by making sure that during log replay we wait for the caching
> task to finish completely when we need to rebuild a space cache, and also
> drop the need to mark the extent buffer range in the excluded extents io
> tree, as well as clearing ranges from that tree at
> btrfs_finish_extent_commit().
> 
> This started to happen with some frequency on large filesystems having
> block groups with a lot of fragmentation since the recent commit
> e747853cae3ae3 ("btrfs: load free space cache asynchronously"), but in
> fact the issue has been there for years, it was just much less likely
> to happen.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
