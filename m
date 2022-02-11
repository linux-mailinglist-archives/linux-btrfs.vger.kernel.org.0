Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5F4B2538
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiBKMHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 07:07:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiBKMHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 07:07:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90400F61
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 04:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8040B8294F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 12:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FEAC340E9;
        Fri, 11 Feb 2022 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644581227;
        bh=cBaul5nnxdBTx97Ok2n+opAhE3PCtOWJHpMhdYBq23s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDzuhZd9BIkjYUsYtHX1TsCZtgaNTgPAn3dJGIx0Djy3Vy9UDV7hl/UO7ZUxi3g2O
         c+WZ535Z46MqkkTGIudiiQAn2fSnIDXRCerB3x5UBoAjnOhtiLCf9bzXHlTUFZxpE8
         Nz/vS72fxoxUPXc6CIwPCsIgdztGpMjuZT4pnD3lqN1tq8iUaI/GovuhpLzeLYC5Ni
         B9DZd1Dxn1jC7GNYK8XFjIgBZ0/CjN8pd7LPl87HoGcBch3UahOnctddmqAcktxhNm
         iejk6dcPu7jZq9FFgYJSx8WuyIYfue/x0YYhg4Jg8r3j1Y0eednYjwFjF0KxTkesd0
         kMEX2KYFqwZ3Q==
Date:   Fri, 11 Feb 2022 12:07:04 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: defrag: bring back the old file extent
 search behavior and address merged extent map generation problem
Message-ID: <YgZRaH6urTEoCAZb@debian9.Home>
References: <cover.1644561774.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644561774.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 02:46:11PM +0800, Qu Wenruo wrote:
> Filipe reported that the old defrag code using btrfs_search_forward() to
> do the following optimization:
> 
> - Don't cache extent maps
>   To save memory in the long run
> 
> - Skip entire file ranges which doesn't meet generation requirement
> 
> - Don't use merged extent maps which will have unreliable geneartion
> 
> The first patch will bring back the old behavior, along with the old
> optimizations.
> 
> However the 3rd problem is not that easy to solve, as data
> read/readahead can also load extent maps into the cache, and causing
> extent maps being merged.
> 
> Such already cached and merged extent maps will still confuse autodefrag,
> as if we found cached extent maps, we will not try to read them from
> disk again.
> 
> So to completely prevent merged extent maps tricking autodefrag, here
> comes the 2nd patch, to mark merged extent maps for defrag.
> 
> If we hit an merged extent, and its generation meets our requirement, we
> will not trust it but read from disk to get a reliable generation.
> 
> This should reduce defrag IO caused by the hidden extent map merging
> behavior.
> 
> Changelog:
> v2:
> - Make defrag_get_em() to be more flexiable to handle file extent
>   iteartion
>   Now it will not reject item key which is smaller than our target but
>   doesn't have the wanted type/objectid.
>   It will continue go next next instead, to prevent skipping an extent.
> 
> - Properly reduce path.slots[0]
>   There is a bug where I want to put "if (path.slots[0] == 0)" but I put
>   "if (btrfs_header_nritems(path.slots[0]))".
>   This is fixed with reworked file extent iteration code.
> 
> - Address merged extent maps properly
>   With fixed defrag_get_extent(), we can rely on it to get original em
>   from disk.
>   So what we need to do is just to ignore merged extents which meets
>   our generation requirement.
> 
> v3:
> - Rebased to latest misc-next
> 
> - Fix several generation spell typo
> 
> - Fix a case where btrfs_search_slot() can lead to path->slots[0] >=
>   nritems
> 
> - Fix the commit message on modified extent map
>   Now that part mentioning fsync() doesn't help on the autodefrag bug.
> 
> - Update the wording on extent map read from subvolume trees
> 
> Qu Wenruo (2):
>   btrfs: defrag: bring back the old file extent search behavior
>   btrfs: defrag: don't use merged extent map for their generation check

Ok, for the both patches:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> 
>  fs/btrfs/extent_map.c |   2 +
>  fs/btrfs/extent_map.h |   8 ++
>  fs/btrfs/ioctl.c      | 174 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 180 insertions(+), 4 deletions(-)
> 
> -- 
> 2.35.0
> 
