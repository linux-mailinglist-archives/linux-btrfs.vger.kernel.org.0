Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96630097D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 18:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbhAVQrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 11:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbhAVQnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 11:43:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31685C06178B
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 08:43:08 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o18so4516775qtp.10
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1ovhGaTBdETVnoaNSx37ZdDcTGayv0Bm5/iEGE7X0UI=;
        b=TWtj/JmDTXRFs8HB8dc/bGLZwiUUPF8QSAkdMHpigZ7+BCMvOH9QhLHOvPBAMtKxFs
         TMFg2E0ViS0eBMvge3gLBjv8g2iu9P5gGR5VPIyL5AGaEu8vLBi46doToGs8l/AhNj7/
         5u9LPiBBFEkmkp16oDaGKFGS9GHn8QLfqfpIstu8v3isClbqsjLl2ljN5kgj9Bn0UThj
         scvIUzah0G9xVMK3VKYg5f6igUmCqsFcVvFtFkegBjipXBdkxHGvgxo4Q9bB1Je6azeG
         cRm22dQBtxqltSpXnKVkAWvY2pMOk0AIFgN7M9Ya+2Gt7LBOMbtfgMm99EE4VW0g5H8N
         iUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ovhGaTBdETVnoaNSx37ZdDcTGayv0Bm5/iEGE7X0UI=;
        b=XcA5K7IDpReTW/5XbD0u3kYQUe/QsSh2esw+iBqrWouss1KCihO8RROukkbvRPswQj
         x49LlgNSmauSnQj+N74Zpb6jXHlkPbsraJtDDD8FBNh4b/WCbqqNsoQ3lduObb87tA+W
         qHpne/hxBWzxk2F+uXinbjgc/6/7JYSbIjbx3Wgi8y/23GZq83RuejZ2aVWRlcSo0cwz
         R09DWsQXA3pTY/WYIvmdFzX4P9Oco+Be6o8yXqHWG0e8Ib0xIE5x7SfIfAKb2kDXA3hp
         CuEn3Le+pT6KalQS0JD49URcBhQq886OoLxZahzqXnMknjnvAtWD8FqnXYTkdpatxgbe
         328Q==
X-Gm-Message-State: AOAM530TriUYstjYZFUQnXu+B+4TWevPNenO1ZVKY/KTX9yVKvzksdPt
        I5E2J+kU/JIPO1g6gPABF1N1ClFlzSTtrrh/
X-Google-Smtp-Source: ABdhPJwBZXkjM+f1h3yCkp3gbHOws6fe9F/dXfyYQ6NAEvxWAfe+KOXdNTbnCInAXy/lMN/qkfj03A==
X-Received: by 2002:ac8:4d93:: with SMTP id a19mr4984020qtw.356.1611333786797;
        Fri, 22 Jan 2021 08:43:06 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s6sm3260877qtx.63.2021.01.22.08.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 08:43:05 -0800 (PST)
Subject: Re: [PATCH 1/2] btrfs: fix log replay failure due to race with space
 cache rebuild
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1611327201.git.fdmanana@suse.com>
 <d20f67adb1ab345a9af9e0262e1aba0772832751.1611327201.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <89cf3d62-7544-9c7a-7c5a-145d4252389c@toxicpanda.com>
Date:   Fri, 22 Jan 2021 11:43:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d20f67adb1ab345a9af9e0262e1aba0772832751.1611327201.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 10:28 AM, fdmanana@kernel.org wrote:
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
> as well as mounting the filesystem. When this happens we got the following
> in dmesg/syslog:
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
> So fix this by making sure that during log replay we wait for the caching
> task to finish completely when we need to rebuild a space cache.
> 
> Fixes: e747853cae3ae3 ("btrfs: load free space cache asynchronously")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This could actually happen before, it was just less likely because we'd start 
the async thread from the callers context.  I assume we're getting the -EINVAL 
from the remove_from_bitmap() function?  So we've loaded part of the free space 
but not all of it, and thus get the -EINVAL.  This probably needs the earlier 
Fixes, all the async patch did was make it easier to hit.

<snip>

> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 30b1a630dc2f..594534482ad3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2600,6 +2600,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
>   				    u64 bytenr, u64 num_bytes)
>   {
>   	struct btrfs_block_group *cache;
> +	struct btrfs_caching_control *caching_ctl;
>   	int ret;
>   
>   	btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
> @@ -2615,6 +2616,13 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
>   	 * the pinned extents.
>   	 */
>   	btrfs_cache_block_group(cache, 1);

Instead we could probably just do

if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
	btrfs_cache_block_group(cache, 0);
	btrfs_wait_block_group_cache_done(cache);
}

here instead of changing all of the function arguments and such.  Thanks,

Josef
