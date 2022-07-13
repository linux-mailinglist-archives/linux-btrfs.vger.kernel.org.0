Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00C0573826
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiGMOAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiGMOAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 10:00:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CAD255B1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEFFBB81F66
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 13:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F35FC34114;
        Wed, 13 Jul 2022 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657720798;
        bh=t+f1+iTpw3HG8YGRO/xdxGi+b2nPfKxV6YmAXAwV60s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxvSRyHNigyz5YgSChEOxTKHjZBtmfB4GK+kTJbQNWV2Ga6LRM5MlYGM2ompJEcBp
         BlXyzhLMHsk4pW8ESOPGfy0a9ntAF6Th5hWDYPSZ+yZ4YXNHFnupmLF9/MpWK2O/EX
         oXS2qG5mi03XZDCW2/AtoMQuF5USRga5VyiS6LSFnLXBRnRL9RR28GCkYzWQ+eaErW
         9vBBbFHM5xUBKM1+tjd8c85+DB99h7WNmhEY+oHLxWHeRL8bfD+8/hBRG+mzV14351
         BMBeXjtI3Hd3g9j1tFxA5YSdooBbJCXAABl1mD09lGtRYE0QmXJdHtpt07bWRGDIrZ
         9Vwdu4ONATEHg==
Date:   Wed, 13 Jul 2022 14:59:55 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: Re: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Message-ID: <20220713135955.GA1114299@falcondesktop>
References: <cover.1657097693.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657097693.git.fdmanana@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 06, 2022 at 10:09:44AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After the recent conversions of a couple radix trees to XArrays, we now
> can end up attempting to sleep while holding a spinlock. This happens
> because if xa_insert() allocates memory (using GFP_NOFS) it may need to
> sleep (more likely to happen when under memory pressure). In the old
> code this did not happen because we had radix_tree_preload() called
> before taking the spinlocks.
> 
> Filipe Manana (3):
>   btrfs: fix sleep while under a spinlock when allocating delayed inode
>   btrfs: fix sleep while under a spinlock when inserting a fs root
>   btrfs: free qgroup metadata without holding the fs roots lock

David, are you going to pick these up or revert the patches that did the
radix tree to xarray conversion?

> 
>  fs/btrfs/ctree.h         |  6 +++---
>  fs/btrfs/delayed-inode.c | 24 ++++++++++++------------
>  fs/btrfs/disk-io.c       | 38 +++++++++++++++++++-------------------
>  fs/btrfs/inode.c         | 30 ++++++++++++++++--------------
>  fs/btrfs/relocation.c    | 11 +++++++----
>  fs/btrfs/transaction.c   | 14 +++++++-------
>  6 files changed, 64 insertions(+), 59 deletions(-)
> 
> -- 
> 2.35.1
> 
