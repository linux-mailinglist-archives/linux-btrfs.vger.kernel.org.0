Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C426C4DE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCVOh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCVOhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 10:37:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFB2ED48
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 07:37:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m6so12297084qvq.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679495839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zit3pHzbwqIMKLcGYxhfBKwPKNtejxsOHbtoqJ2XRQs=;
        b=tId5slUrEdqSBa20FPQASLtd785NBLac1kIIlxLbiouqIh9ateMj9cA6exLvT1+Jxy
         xPFehbsZ0KJMWHjRbx+sFvHhHxK7TdDYrYpWuupPqMqQy81Pgm/tLNQ6n/Rt3WyBfDDb
         4aQjhUKAK7H2J8/QKPYu9F93Gv+pim88ciprIwGj8xYfgGcWrAP9vmkUqb2ow64StHA6
         RbAOxegtBuvL0xriU95wNk/1aHohZEA1VS9+P7Leh2/KDjmSfa23n3yO3CyQNOVV5pzy
         msJrap2Kv88coiQiY2imBgFrtT5I3ge+Rs4xRBrV7/BhspkKTOwE21wpiTgCJryorrc9
         DpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zit3pHzbwqIMKLcGYxhfBKwPKNtejxsOHbtoqJ2XRQs=;
        b=dS3aGCxeCfllOrgWGd4zvntetrBEj8pxcYfZYOct37/YbuXLIp7zTRzn/MHzM62FIF
         BrmC9ntE5Pc2J9Hj+dYaGlShiU1FG4zT/78ubl7GMABuM5JWbixaLfyljICqiKNX5zAb
         T4vipT3dYODv4Nt3elHLwU/Xek1nSf/5iJ1eMHF5sRFbMLHXnmzachXf3ouHQON2SRLN
         KhgA78Y+8uRrL0oCMKIeNtQ3PKs9TsOzUqEtd5DrQ+ZVoKiFl01QpPezFlImAWpTudKv
         NS0Bc2j43okBD6byj9YJAb9qLDp74YJGIq4ibDCK/d/190e0I3t/D9iEc7zxz1MvHguR
         Fdeg==
X-Gm-Message-State: AO0yUKUn8KROHahKpF6YBSXpG8Kn+mR1COeNHyRapLYmq7rdLxUYuj7P
        XiU7WXXD3CKQChQM9RkYZDfqcDaTSz01PpekAHBCyg==
X-Google-Smtp-Source: AK7set8CdK7Sw5O1IzZVqU3ke2HBBU4Lbc+5twFSejk4h5rvrZ0J+QfIIgunyr10S/+9uA7hpXbAXA==
X-Received: by 2002:a05:6214:766:b0:5d5:f87a:b3d8 with SMTP id f6-20020a056214076600b005d5f87ab3d8mr5156270qvz.33.1679495838658;
        Wed, 22 Mar 2023 07:37:18 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s188-20020ae9dec5000000b00742a23cada8sm11236215qkf.131.2023.03.22.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:37:18 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:37:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/24] btrfs: cleanups and small fixes mostly around
 block reserves
Message-ID: <20230322143717.GC2169647@perftesting>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 11:13:36AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A set of cleanups and small fixes that started as part of a larger work,
> mostly around block reserves and space reservation, but as they are mostly
> trivial and independent of the rest of that work, I'm sending them out
> separately. More details on the individual changelogs.
> 
> Filipe Manana (24):
>   btrfs: pass a bool to btrfs_block_rsv_migrate() at evict_refill_and_join()
>   btrfs: pass a bool size update argument to btrfs_block_rsv_add_bytes()
>   btrfs: remove check for NULL block reserve at btrfs_block_rsv_check()
>   btrfs: update documentation for BTRFS_RESERVE_FLUSH_EVICT flush method
>   btrfs: update flush method assertion when reserving space
>   btrfs: initialize ret to -ENOSPC at __reserve_bytes()
>   btrfs: simplify btrfs_should_throttle_delayed_refs()
>   btrfs: collapse should_end_transaction() into btrfs_should_end_transaction()
>   btrfs: remove bytes_used argument from btrfs_make_block_group()
>   btrfs: count extents before taking inode's spinlock when reserving metadata
>   btrfs: remove redundant counter check at btrfs_truncate_inode_items()
>   btrfs: simplify btrfs_block_rsv_refill()
>   btrfs: remove obsolete delayed ref throttling logic when truncating items
>   btrfs: don't throttle on delayed items when evicting deleted inode
>   btrfs: calculate the right space for a single delayed ref when refilling
>   btrfs: accurately calculate number of delayed refs when flushing
>   btrfs: constify fs_info argument of the metadata size calculation helpers
>   btrfs: constify fs_info argument for the reclaim items calculation helpers
>   btrfs: add helper to calculate space for delayed references
>   btrfs: calculate correct amount of space for delayed reference when evicting
>   btrfs: fix calculation of the global block reserve's size
>   btrfs: use a constant for the number of metadata units needed for an unlink
>   btrfs: calculate the right space for delayed refs when updating global reserve
>   btrfs: simplify exit paths of btrfs_evict_inode()
> 
>  fs/btrfs/block-group.c    |  7 ++----
>  fs/btrfs/block-group.h    |  2 +-
>  fs/btrfs/block-rsv.c      | 21 +++++++----------
>  fs/btrfs/block-rsv.h      |  2 +-
>  fs/btrfs/delalloc-space.c |  2 +-
>  fs/btrfs/delayed-ref.c    | 49 ++++-----------------------------------
>  fs/btrfs/delayed-ref.h    | 22 +++++++++++++++++-
>  fs/btrfs/disk-io.c        |  1 -
>  fs/btrfs/extent-tree.c    | 27 ++-------------------
>  fs/btrfs/fs.h             | 17 +++++++++++---
>  fs/btrfs/inode-item.c     | 15 +++++-------
>  fs/btrfs/inode.c          | 43 ++++++++++++++++------------------
>  fs/btrfs/space-info.c     | 32 +++++++++++++++++++++----
>  fs/btrfs/space-info.h     |  1 +
>  fs/btrfs/transaction.c    | 15 ++++--------
>  fs/btrfs/volumes.c        |  2 +-
>  16 files changed, 115 insertions(+), 143 deletions(-)

I reviewed this last night but I don't see my reply, so apologies if this is the
second email.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to this series, thanks,

Josef
