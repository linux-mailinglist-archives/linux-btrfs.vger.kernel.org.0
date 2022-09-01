Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FD55A9A1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiIAOX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiIAOXe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:23:34 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F3D7644A
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:23:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r6so13498230qtx.6
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BuNe8Sl7arrZ9p/dClaIrMUMm8tVitmwPRVfWUaiIBE=;
        b=gnPfkk0uj0SaY+nI+d4n5gTom6yBr5oBEVa33GW3FlTuLcvbVobdmaUm4IXgi4Splw
         vWC/0eu+Z3xKE7+0fp8ZuCO1JI1ZrUV1uImfJhtVkLXAKlikOT+jAdmFhkKxBTHx92Jn
         2Orbadj+mtxaWDJjzkahOzkVJbZCTsccoTKEZ/kw/iXkIzfTFAU10UfPXA3LA2k1ytHb
         BgDgFTn/yuY8/z8wpqumUI4Yat02iJaMCX49RMUMuNo3pYOJPKZUzoAJclrvFxfCxm9V
         g475l6WonPWfC7+cIzSPzxfHp/G9KYNmiXig5GuWIXnOzXF1wdB7D/F/7XGyfSIGdlQ4
         ceqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BuNe8Sl7arrZ9p/dClaIrMUMm8tVitmwPRVfWUaiIBE=;
        b=5lTnjJcHV9rtuFuMN05GzMPnJ5fVHznobmDeRj3gmwXjBmDH4c8He+DV26PyXpWr0a
         93RIBp8b230gBO1Patc3lk8htOrnMSsSSlNMcQRlJPIXF1p+siSgtSPmPnwrL2qrsSEL
         5EEjptzZ9rRHnHrxBLFhCPIlw4I6NQ36UQQ9NC5xXn9/PbleZz6AxVg3qdgdyPhPwmgk
         4nskRUnmTLaHtW8PY3B1slJutcKLFuLBxrX328l1/Rmn8d62AVFDnlgWBnOb5I+GV0nU
         guanaoKNSWlPIS/ASdB7JK9O+4E2RoHhPLNJa+GJzqW9hnLzAja/vhk9gNq/LHIPulhl
         qiUw==
X-Gm-Message-State: ACgBeo3VQdPEEbOpt/05f9/1SRvdHZohtYnhcCyiZlPwsXut1mMOln5m
        NaQMtZuaju5L78hh2dotDKV1kzFq1TK6RA==
X-Google-Smtp-Source: AA6agR5TXiCbtGau4wg7SXK7vDF9EyEmm6A1zjFuppxkPS8ahm4lgnuLyI5xPhSS3Zc0oQ4S1zfDhA==
X-Received: by 2002:ac8:7dc6:0:b0:344:5ac2:8b59 with SMTP id c6-20020ac87dc6000000b003445ac28b59mr23462524qte.661.1662042188449;
        Thu, 01 Sep 2022 07:23:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21-20020ac84b75000000b0034502695369sm9266857qts.54.2022.09.01.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:23:08 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:23:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: speedup checking for extent sharedness
 during fiemap
Message-ID: <YxDAS3KLIvGxcLYW@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <5e696c29b65f6558b8012596aa513101ed04a21a.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e696c29b65f6558b8012596aa513101ed04a21a.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> One of the most expensive tasks performed during fiemap is to check if
> an extent is shared. This task has two major steps:
> 
> 1) Check if the data extent is shared. This implies checking the extent
>    item in the extent tree, checking delayed references, etc. If we
>    find the data extent is directly shared, we terminate immediately;
> 
> 2) If the data extent is not directly shared (its extent item has a
>    refcount of 1), then it may be shared if we have snapshots that share
>    subtrees of the inode's subvolume b+tree. So we check if the leaf
>    containing the file extent item is shared, then its parent node, then
>    the parent node of the parent node, etc, until we reach the root node
>    or we find one of them is shared - in which case we stop immediately.
> 
> During fiemap we process the extents of a file from left to right, from
> file offset 0 to eof. This means that we iterate b+tree leaves from left
> to right, and has the implication that we keep repeating that second step
> above several times for the same b+tree path of the inode's subvolume
> b+tree.
> 
> For example, if we have two file extent items in leaf X, and the path to
> leaf X is A -> B -> C -> X, then when we try to determine if the data
> extent referenced by the first extent item is shared, we check if the data
> extent is shared - if it's not, then we check if leaf X is shared, if not,
> then we check if node C is shared, if not, then check if node B is shared,
> if not than check if node A is shared. When we move to the next file
> extent item, after determining the data extent is not shared, we repeat
> the checks for X, C, B and A - doing all the expensive searches in the
> extent tree, delayed refs, etc. If we have thousands of tile extents, then
> we keep repeating the sharedness checks for the same paths over and over.
> 
> On a file that has no shared extents or only a small portion, it's easy
> to see that this scales terribly with the number of extents in the file
> and the sizes of the extent and subvolume b+trees.
> 
> This change eliminates the repeated sharedness check on extent buffers
> by caching the results of the last path used. The results can be used as
> long as no snapshots were created since they were cached (for not shared
> extent buffers) or no roots were dropped since they were cached (for
> shared extent buffers). This greatly reduces the time spent by fiemap for
> files with thousands of extents and/or large extent and subvolume b+trees.
> 
> Example performance test:
> 
>     $ cat fiemap-perf-test.sh
>     #!/bin/bash
> 
>     DEV=/dev/sdi
>     MNT=/mnt/sdi
> 
>     mkfs.btrfs -f $DEV
>     mount -o compress=lzo $DEV $MNT
> 
>     # 40G gives 327680 128K file extents (due to compression).
>     xfs_io -f -c "pwrite -S 0xab -b 1M 0 40G" $MNT/foobar
> 
>     umount $MNT
>     mount -o compress=lzo $DEV $MNT
> 
>     start=$(date +%s%N)
>     filefrag $MNT/foobar
>     end=$(date +%s%N)
>     dur=$(( (end - start) / 1000000 ))
>     echo "fiemap took $dur milliseconds (metadata not cached)"
> 
>     start=$(date +%s%N)
>     filefrag $MNT/foobar
>     end=$(date +%s%N)
>     dur=$(( (end - start) / 1000000 ))
>     echo "fiemap took $dur milliseconds (metadata cached)"
> 
>     umount $MNT
> 
> Before this patch:
> 
>     $ ./fiemap-perf-test.sh
>     (...)
>     /mnt/sdi/foobar: 327680 extents found
>     fiemap took 3597 milliseconds (metadata not cached)
>     /mnt/sdi/foobar: 327680 extents found
>     fiemap took 2107 milliseconds (metadata cached)
> 
> After this patch:
> 
>     $ ./fiemap-perf-test.sh
>     (...)
>     /mnt/sdi/foobar: 327680 extents found
>     fiemap took 1646 milliseconds (metadata not cached)
>     /mnt/sdi/foobar: 327680 extents found
>     fiemap took 698 milliseconds (metadata cached)
> 
> That's about 2.2x faster when no metadata is cached, and about 3x faster
> when all metadata is cached. On a real filesystem with many other files,
> data, directories, etc, the b+trees will be 2 or 3 levels higher,
> therefore this optimization will have a higher impact.
> 
> Several reports of a slow fiemap show up often, the two Link tags below
> refer to two recent reports of such slowness. This patch, together with
> the next ones in the series, is meant to address that.
> 
> Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
