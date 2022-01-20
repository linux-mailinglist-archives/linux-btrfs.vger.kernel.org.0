Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0557149528D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbiATQoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 11:44:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44594 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiATQoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 11:44:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0ADC4210F3;
        Thu, 20 Jan 2022 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642697043;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6lHsCVz2p0F5vhCM70T1hKq9/LLcsdlrpbUO8gDxn4=;
        b=RYH1/gEklqHIzxf+rRzKXrCrFjMbXJk+l1hl8J6Pm4gio8YsTZV4k34ddSeOTRv37LlDU1
        mKY/d3b1bWxImY7Xn9HCyINXG6EupHuEchXPQUshgLCpnFgrrMEm3tPWdA/JhYK/a8OYOn
        frxjKWVK/6tYPrK3wHecTftZ0vqVIsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642697043;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6lHsCVz2p0F5vhCM70T1hKq9/LLcsdlrpbUO8gDxn4=;
        b=qDtIaTz+E6lXGzr/aV9okouFDLBS/o0OvBiV92rwPTH6svN5imHfJmg8jtuen2UanyjXYh
        xLcYzt9+4we5uJAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0119BA3B99;
        Thu, 20 Jan 2022 16:44:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 421E5DA7A3; Thu, 20 Jan 2022 17:43:25 +0100 (CET)
Date:   Thu, 20 Jan 2022 17:43:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix deadlock when reserving space during defrag
Message-ID: <20220120164324.GU14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 02:27:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When defragging we can end up collecting a range for defrag that has
> already pages under delalloc (dirty), as long as the respective extent
> map for their range is not mapped to a hole, a prealloc extent or
> the extent map is from an old generation.
> 
> Most of the time that is harmless from a functional perspective at
> least, however it can result in a deadlock:
> 
> 1) At defrag_collect_targets() we find an extent map that meets all
>    requirements but there's delalloc for the range it covers, and we add
>    its range to list of ranges to defrag;
> 
> 2) The defrag_collect_targets() function is called at defrag_one_range(),
>    after it locked a range that overlaps the range of the extent map;
> 
> 3) At defrag_one_range(), while the range is still locked, we call
>    defrag_one_locked_target() for the range associated to the extent
>    map we collected at step 1);
> 
> 4) Then finally at defrag_one_locked_target() we do a call to
>    btrfs_delalloc_reserve_space(), which will reserve data and metadata
>    space. If the space reservations can not be satisfied right away, the
>    flusher might be kicked in and start flushing delalloc and wait for
>    the respective ordered extents to complete. If this happens we will
>    deadlock, because both flushing delalloc and finishing an ordered
>    extent, requires locking the range in the inode's io tree, which was
>    already locked at defrag_collect_targets().
> 
> So fix this by skipping extent maps for which there's already delalloc.
> 
> Fixes: eb793cf857828d ("btrfs: defrag: introduce helper to collect target file extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, added to misc-next and to the rest of the defrag fixes.
