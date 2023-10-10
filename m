Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE17C00AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjJJPrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjJJPri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 11:47:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D24AF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 08:47:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AACC433C7;
        Tue, 10 Oct 2023 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952857;
        bh=JY70vzwVNQ8EnMfDSPFQ1einwDwX+OFVsKlnWYRxR/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXChM6OPXHJikXNivWCCZqtBOZrxkW8oa1auM4SgK4abngfZnAJLtaKNn1R8VM1rO
         EL8UWdyNapmWn+Hc3Zp1EurOYB7iZ3soIg8MNYm8goD0HSxdkbgbLRUw8FUS+r8egi
         ukyLF5qz9EjXTy9PD15IEQFxv3uLUbDNwraw7tiU3GG83HWklfmq3ztWXtfqlEgr7d
         Q+Ogplpg0CFbmOh9+AQjZdBruJ+zEM9DYDHiufDKDb2Jjy4gWz51jxPD/TJ9MAO3Gj
         1HTtkx4d7R/ac4YbnzP093vyKTl+0cok3lxXMPdhSiBuuPtyU0HTWqaoEYjvYEPgKR
         QjEzKiCyFnSeQ==
Date:   Tue, 10 Oct 2023 16:47:33 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     "Ospan, Abylay" <aospan@amazon.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs_extent_map memory consumption results in "Out of memory"
Message-ID: <ZSVyFaWA5KZ0nTEN@debian0.Home>
References: <13f94633dcf04d29aaf1f0a43d42c55e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f94633dcf04d29aaf1f0a43d42c55e@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 10, 2023 at 03:02:21PM +0000, Ospan, Abylay wrote:
> Greetings Btrfs development team!
> 
> I would like to express my gratitude for your outstanding work on Btrfs. However, I recently experienced an 'out of memory' issue as described below.
> 
> Steps to reproduce:
> 
> 1. Run FIO test on a btrfs partition with random write on a 300GB file:
> 
> cat <<EOF >> rand.fio 
> [global]
> name=fio-rand-write
> filename=fio-rand-write
> rw=randwrite
> bs=4K
> direct=1
> numjobs=16
> time_based
> runtime=90000
> 
> [file1]
> size=300G
> ioengine=libaio
> iodepth=16
> EOF
> 
> fio rand.fio
> 
> 2. Monitor slab consumption with "slabtop -s -a"
> 
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 25820620 23138538  89%    0.14K 922165       28   3688660K btrfs_extent_map
> 
> 3. Observe oom-killer:
> [49689.294138] ip invoked oom-killer: gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC), order=3, oom_score_adj=0
> ...
> [49689.294425] Unreclaimable slab info:
> [49689.294426] Name                      Used          Total	
> [49689.329363] btrfs_extent_map     3207098KB    3375622KB
> ...
> 
> Memory usage by btrfs_extent_map gradually increases until it reaches a critical point, causing the system to run out of memory.
> 
> Test environment: Intel CPU, 8GB RAM (To expedite the reproduction of this issue, I also conducted tests within QEMU with a restricted amount of memory). 
> Linux kernel tested: LTS 5.15.133, and mainline 6.6-rc5
> 
> Quick review of the 'fs/btrfs/extent_map.c' code reveals no built-in limitations on memory allocation for extents mapping.
> Are there any known workarounds or alternative solutions to mitigate this issue?

No workarounds really.

So once we add an extent map to the inode's rbtree, it will stay there until:

1) The corresponding pages in the file range get released due to memory pressure or whatever reason decided by the MM side.
   The release happens in the callback struct address_space_operations::release_folio, which is btrfs_release_folio for btrfs.
   In your case it's direct IO writes... so there are no pages to release, and therefore extent maps don't get released by
   that mechanism.

2) The inode is evicted - when evicted of course we drop all extent maps and release all memory.
   If some application is keeping a file descriptor open for the inode, and writes keep happening (or reads, since they create
   an extent map for the range read too), then no extent maps are released...
   Databases and other software often do that, keep file descriptors open for long periods, while reads and writes are happening
   by the some process or others.

The other side effect, even if no memory exhaustion happens, is that it slows down writes, reads, and other operations, due to
large red black trees of extent maps.

I don't have a ready solution for that, but I had some thinking about this about a year ago or so.
The simplest solution would be to not keep extent maps in memory for direct IO writes/reads...
but it may slow down in some cases at least.

Soon I may start some work to improve that.

Thanks.

> 
> Thank you!
> 
> --
> Abylay Ospan
> 
> 
