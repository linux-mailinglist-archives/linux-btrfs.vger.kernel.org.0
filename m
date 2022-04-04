Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75F4F18ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378434AbiDDP4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 11:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbiDDP4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 11:56:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE666140B3
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 08:54:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8D0D1F385;
        Mon,  4 Apr 2022 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649087686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8i59qpPGIxI7lUrvc36GGrQY6E2Pq1OzMurNWvG33U=;
        b=nXtGzNL8RzpeGre+2uEq1gWPVymoI20XfRsk2ZNpia7Y7k0v51H9NvJp96omdTpsDfzWzn
        0q4rKrK+Z2Mc5D2D7ulRRFYhX0mNXD7H99oV6D0201Ffa2EOyb25RVgt5J2tJ771aOL6Rl
        IUJ8bPxnDmkqCNy4wc8/7a/ydwcIw/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649087686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8i59qpPGIxI7lUrvc36GGrQY6E2Pq1OzMurNWvG33U=;
        b=4gvDYrCvK/bqL4wFFjJe8bz1x8enE+TritFBMJQmrd0lzFsTEcNBt2qPqgM3MtFS8rE52S
        OONL/Yqk+0Nv01AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C937A3B83;
        Mon,  4 Apr 2022 15:54:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 010A1DA80E; Mon,  4 Apr 2022 17:50:45 +0200 (CEST)
Date:   Mon, 4 Apr 2022 17:50:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] btrfs: rework background block group relocation
Message-ID: <20220404155045.GQ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648543951.git.johannes.thumshirn@wdc.com>
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

On Tue, Mar 29, 2022 at 01:56:05AM -0700, Johannes Thumshirn wrote:
> This is a combination of Josef's series titled "btrfs: rework background
> block group relocation" and my patch titled "btrfs: zoned: make auto-reclaim
> less aggressive" plus another preparation patch to address Josef's comments.
> 
> I've opted for rebasinig my path onto Josef's series to avoid and fix
> conflicts, as we're both touching the same code.
> 
> Here's the original cover letter from Josef:
> 
> Currently the background block group relocation code only works for zoned
> devices, as it prevents the file system from becoming unusable because of block
> group fragmentation.
> 
> However inside Facebook our common workload is to download tens of gigabytes
> worth of send files or package files, and it does this by fallocate()'ing the
> entire package, writing into it, and then free'ing it up afterwards.
> Unfortunately this leads to a similar problem as zoned, we get fragmented data
> block groups, and this trends towards filling the entire disk up with partly
> used data block groups, which then leads to ENOSPC because of the lack of
> metadata space.
> 
> Because of this we have been running balance internally forever, but this was
> triggered based on different size usage hueristics and stil gave us a high
> enough failure rate that it was annoying (figure 10-20 machines needing to be
> reprovisioned per week).
> 
> So I modified the existing bg_reclaim_threshold code to also apply in the !zoned
> case, and I also made it only apply to DATA block groups.  This has completely
> eliminated these random failure cases, and we're no longer reprovisioning
> machines that get stuck with 0 metadata space.
> 
> However my internal patch is kind of janky as it hard codes the DATA check.
> What I've done here is made the bg_reclaim_threshold per-space_info, this way
> a user can target all block group types or just the ones they care about.  This
> won't break any current users because this only applied in the zoned case
> before.
> 
> Additionally I've added the code to allow this to work in the !zoned case, and
> loosened the restriction on the threshold from 50-100 to 0-100.
> 
> I tested this on my vm by writing 500m files and then removing half of them and
> validating that the block groups were automatically reclaimed.
> 
> https://lore.kernel.org/linux-btrfs/cover.1646934721.git.josef@toxicpanda.com/
> 
> Changes to v1:
> * Fix zoned threshold calculation (Pankaj)
> * Drop unneeded patch
> 
> Johannes Thumshirn (1):
>   btrfs: zoned: make auto-reclaim less aggressive
> 
> Josef Bacik (3):
>   btrfs: make the bg_reclaim_threshold per-space info
>   btrfs: allow block group background reclaim for !zoned fs'es
>   btrfs: change the bg_reclaim_threshold valid region from 0 to 100

Added to misc-next, thanks.
