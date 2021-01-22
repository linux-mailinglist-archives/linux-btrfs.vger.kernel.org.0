Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F061D300A55
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 18:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbhAVR0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 12:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbhAVQyz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 11:54:55 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F03C061788
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 08:54:07 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id cu2so2918592qvb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M//QUaCP9gtYK1VJeIu1wSekQcqWIx/FWFz51MntAK0=;
        b=jo/9xZzdBl0whJ0n1I8iVSqMfgAD4evQESQ+RxHk8wOsfGdL5oXIXST1Bf9riIKTQq
         0XUjVcP1vXFjascnWT0TFgZbp7OjlkyHAjCqn+b+zhS0sw/bep36vRnTOctL2a9UIAkb
         X9VH8c/XVn00wNkzwOQFkTnnoi7gtumFZrzzA/o+ISZYtNEB9nPNdJJoQ5PRh96lNsny
         ARbUkDyLMu2oBKS98AP6rk6lQB5YofnR6a5JyAI8rH11N8rSWgQZ8ocPKGgQSDJbHhtm
         CPQoUhyulQjMg5tjYlvXrsV1SXDWlxgYx5la4z1YDd9T04p5jQS3PSPPYLnrJwY4HVqh
         FgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M//QUaCP9gtYK1VJeIu1wSekQcqWIx/FWFz51MntAK0=;
        b=Hi4rsu/tKmcQeN2qZpHZ8d3lcgPRiLPWXeDmiB+sjGQK93+O0nhnvuHawKKMlbNd+Q
         oH/XfKLrU0QHmQpGyyyi2oJGecEvtLQ7xL9g5yoSe3sOSds3tEFSuYIAt5d9tN0TjOrS
         16CRYH3j0/MM0hLymH3/x/hGspnW8/FHAd8Rqu4V0xOX9pcrAQpqLpQ0FEyk2NOlubkl
         HfALdO4NgZNCIkVZaL5fM4kd5OoIbP9CKQUVQtexbzND+QgISKIA27gZLQfDxj1o4KFd
         5aYZELAHouRCa75N667QK0bbi8KLfawi17njgn0Y+SYvG4k1hQPsfS+IZ3vyi0ez1kOm
         EDeQ==
X-Gm-Message-State: AOAM530mf6hYGeQuA1S1Xq2Ox62L9IA6N2FP+FztBgY7z+sT54rpwUKm
        0ex1tbpEMJRyig11vPr7P26Nlp7hSXRE8Bjb
X-Google-Smtp-Source: ABdhPJw5v0KE/RAxwuUB25Bqdfm26SpuMnibCYrNuaxmMPCOLt2+VSlIeHbGdgoHSLrMLqLF5BIVjw==
X-Received: by 2002:ad4:4e4d:: with SMTP id eb13mr973464qvb.6.1611334445792;
        Fri, 22 Jan 2021 08:54:05 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 186sm1267363qkh.30.2021.01.22.08.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 08:54:05 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: fix log replay failure when space cache needs
 to be rebuilt
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1611327201.git.fdmanana@suse.com>
 <7950c4b5c5e1579b541477e27fc1e597b5fc44e3.1611327201.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d5e3406d-a4a1-18b4-523e-03f11413b6d2@toxicpanda.com>
Date:   Fri, 22 Jan 2021 11:54:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7950c4b5c5e1579b541477e27fc1e597b5fc44e3.1611327201.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 10:28 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During log replay we first start by walking the log trees and pin the
> ranges for their extent buffers, through calls to the function
> btrfs_pin_extent_for_log_replay().
> 
> However if the space cache for a block group is invalid and needs to be
> rebuilt, we can fail the log replay and mount with -EINVAL like this:
> 
>   [72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
>   [72383.417837] BTRFS info (device sdb): disk space caching is enabled
>   [72383.418536] BTRFS info (device sdb): has skinny extents
>   [72383.423846] BTRFS info (device sdb): start tree-log replay
>   [72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
>   [72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
>   [72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
>   [72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
>   [72383.460241] BTRFS error (device sdb): open_ctree failed
> 
> This is because at the start of btrfs_pin_extent_for_log_replay() we mark
> the range for the extent buffer in excluded extents io tree. That is fine
> when the space cache is valid on disk and we can load it, in which case it
> causes no problems - in fact it is pointless since shortly after, still at
> btrfs_pin_extent_for_log_replay(), we remove the range from the free space
> cache with the call to btrfs_remove_free_space(().
> 
> However, for the case where we need to rebuild the space cache, because it
> is either invalid or it is missing, having the extent buffer range marked
> in the excluded extents io tree leads to a -EINVAL failure from the call
> to btrfs_remove_free_space(), resulting in the log replay and mount to
> fail. This is because by having the range marked in the excluded extents
> io tree, the caching thread ends never marking adding the range of the
> extent buffer marked as free space in the block group since the calls to
> add_new_free_space(), called from load_extent_tree_free(), filter out any
> ranges that are marked as excluded extents.
> 
> So fix this by not marking the extent buffer range in the excluded extents
> io tree at btrfs_pin_extent_for_log_replay() since it leads to the failure
> when a space cache needs to be rebuilt and it is useless when we do not
> need to rebuild a space cache. Also, remove the cleanup of ranges in the
> excluded extents io tree at btrfs_finish_extent_commit() since they were
> there to cleanup the ranges added by btrfs_pin_extent_for_log_replay().
> 
> Fixes: f2fb72983bdcf5 ("btrfs: Mark pinned log extents as excluded")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Hmm it took some time to convince myself this is correct, but because we 
unconditionally do that remove we really have to force ourselves to cache the 
block group every time.  That means my suggestion to do

if (btrfs_test_opt(fs_info, SPACE_CACHE))
	cache block group

would actually cause problems with this patch as well.  I think the best course 
of action is to get rid of this idea that we can do it the fast way or skip it 
altogether now, and just force a full caching of any block group at log replay 
time and then this patch will be the right thing to do.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
