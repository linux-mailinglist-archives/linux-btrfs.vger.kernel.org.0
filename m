Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5154BE85A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378178AbiBUOqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 09:46:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378251AbiBUOqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 09:46:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1A13E10
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 06:45:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 128A221108;
        Mon, 21 Feb 2022 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645454743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mC+Aywvjx2H9WEUcOwFZdEiDrzyYCDAuHagiB+mlLD8=;
        b=YcRpH+FBmJhvkby/wGclXcNaxt4jceFQkJY1szIysADBTvfqflKvadCBCBq+y0KuZ0HYKz
        OD+ZJthWciWLWOSaQAuZIreYHzOP8JkLIVpBsqU5Xg6e5380gbFElY03Ph7TuUBk+BR4Si
        3xEIC37HhLizcB7JWC2N2SbXdGalAPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645454743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mC+Aywvjx2H9WEUcOwFZdEiDrzyYCDAuHagiB+mlLD8=;
        b=PlAtVCV4edbRhzv96BnGSV2EPLgPsC3feTbc2BlxREzfj3MzXuJCwZMlB4tXI/FLRA8HpY
        vPhd1n3PScBenhAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 06632A3B84;
        Mon, 21 Feb 2022 14:45:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C121DDA823; Mon, 21 Feb 2022 15:41:55 +0100 (CET)
Date:   Mon, 21 Feb 2022 15:41:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: defrag: bring back the old file extent
 search behavior and address merged extent map generation problem
Message-ID: <20220221144155.GF12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644561774.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644561774.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Added to misc-next, thanks.
