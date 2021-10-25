Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E13439D59
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhJYRVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 13:21:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56694 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJYRVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 13:21:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9E5821FD4A;
        Mon, 25 Oct 2021 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635182357;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzNYvDn/1+aTaDbP81bw/vZ6ktlEDVQEcMKhsG++CA8=;
        b=2NULMXXk2d3ouJlv285KVObxSZO0hyMAXP/6cym0yv7uQNhZkbeHb44nw9HY2i22eoXfai
        39Z9vQAMKLiZ3EcLRy+xqaNygZZG8+8C41aIGmzGPdCy7IYtUQcz/JGZpwdCOTaEzFpR9L
        jMH8qkg0SgxN+K4zfbhfxzXTV3VuQac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635182357;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzNYvDn/1+aTaDbP81bw/vZ6ktlEDVQEcMKhsG++CA8=;
        b=PxtIIpEP7yObF0tSRSufWQ0UJk7b08CT0+JryLTxaZyN5X3JH19uvEvHDQ15avDPtnEaHr
        5e9NA1RaCB/WXyAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 97F97A3B88;
        Mon, 25 Oct 2021 17:19:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B6B0DA7A9; Mon, 25 Oct 2021 19:18:46 +0200 (CEST)
Date:   Mon, 25 Oct 2021 19:18:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH resend] btrfs: mount: call btrfs_check_rw_degradable only
 if there is a missing device
Message-ID: <20211025171845.GR20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <f417a0730df69830b07db681eb0992a3ceb99d81.1630639255.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f417a0730df69830b07db681eb0992a3ceb99d81.1630639255.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 06:43:38PM +0800, Anand Jain wrote:
> In open_ctree() in btrfs_check_rw_degradable() [1], we check each block
> group individually if at least the minimum number of devices is available
> for that profile. If all the devices are available, then we don't have to
> check degradable.
> 
> [1]
> open_ctree()
> ::
> 3559 if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
> 
> Also before calling btrfs_check_rw_degradable() in open_ctee() at the
> line number shown below [2] we call btrfs_read_chunk_tree() and down to
> add_missing_dev() to record number of missing devices.
> 
> [2]
> open_ctree()
> ::
> 3454         ret = btrfs_read_chunk_tree(fs_info);
> 
> btrfs_read_chunk_tree()
>  read_one_chunk() / read_one_dev()
>   add_missing_dev()
> 
> So, check if there is any missing device before btrfs_check_rw_degradable()
> in open_ctree().
> 
> With this, in an example, the mount command could save ~16ms.[3] in the
> most common case, that is no device is missing.
> 
> [3]
>  1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
