Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675624FC39A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiDKRou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiDKRos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 13:44:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F81E3CF
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 10:42:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 271B41F7AD;
        Mon, 11 Apr 2022 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649698953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPy1VJVxQ9L26WD2sHvVFYPsOmZhgv/Ew/NYTkitTRw=;
        b=WlECsmAhJPVAU/Ly3PgulqUXw6O8AKtoL5q8F4rH2r/CSeTvXy0F1fuMWgEFdbr9XdDMZe
        EQCmzhXe1pelfcMf08SxB/gMgHxLVWmIL55JH0lVRQQm26m5Ov4tjtYaaxosK7ctgIqkSV
        6xGlRiq3RILrXwURRk3lPH4Uql5Mj2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649698953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPy1VJVxQ9L26WD2sHvVFYPsOmZhgv/Ew/NYTkitTRw=;
        b=avdCsN4Zd+eqGu1SIVjz6rLSPYhXY1piFkPzPYqoD1GyjGkxStBm8BYWkTsR/PlS4eE0Hy
        NiY5bo+yXz4ywbAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F7F9A3B89;
        Mon, 11 Apr 2022 17:42:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ADA65DA7F7; Mon, 11 Apr 2022 19:38:28 +0200 (CEST)
Date:   Mon, 11 Apr 2022 19:38:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mkfs: use sectorsize as nodesize for mixed
 profiles
Message-ID: <20220411173828.GW15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <59658bb9ea9be5bf991aded9211684ba1c7c8d2d.1648970393.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59658bb9ea9be5bf991aded9211684ba1c7c8d2d.1648970393.git.wqu@suse.com>
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

On Sun, Apr 03, 2022 at 03:20:11PM +0800, Qu Wenruo wrote:
> [BUG]
> When running btrfs/011 with subpage case, even with RAID56 support, it
> still fails with the following error:
> 
>  QA output created by 011
>  *** test btrfs replace
>  mkfs failed
>  (see /home/adam/xfstests-dev/results//btrfs/011.full for details)
> 
> The full log shows:
> 
>  ---------workout "-m single -d single -M" 1 no 64-----------
>  ERROR: illegal nodesize 65536 (not equal to 4096 for mixed block group)
>  mkfs failed
> 
> This is a critical error, making test case to be aborted, without
> checking the rest profiles.
> 
> [CAUSE]
> Mkfs.btrfs always uses the maximum value between sectorsize and page
> size for its mixed profile nodesize.
> 
> For subpage case, it means we always go PAGE_SIZE, no matter whatever
> the sectorsize is passed in.
> 
> [FIX]
> Just get rid of the direct PAGE_SIZE usage when determining nodesize for
> mixed profiles.
> And use sectorsize directly (either passed in by the user, or
> deteremined from page size).

Ok, I think it's a sane fallback, on x86_64 there's no change. Added to
devel, thanks.
