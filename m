Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBC4AE230
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 20:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356098AbiBHTZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349608AbiBHTZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 14:25:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C216C0613CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 11:25:05 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 49AC5210FB;
        Tue,  8 Feb 2022 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644348304;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NR74pE8BU/vef6UR8FoH6VRpI3YpOozF+vIMBWzke+0=;
        b=rI/fa5W+xIK9TKzpbaYl+FIzksXRI75T1qi+OrefNGHRAVpmWD8Mg13QaswYQxR2L6gCzB
        piawmk/RuQzPGQlorgefaysB/XK+fp7L8xJdsWLVmDNhSe3E9DBBEQJ995P3tyd9f7XVlp
        bP49SdlGwl4Hls1RQFrm1RuQFAw6arU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644348304;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NR74pE8BU/vef6UR8FoH6VRpI3YpOozF+vIMBWzke+0=;
        b=mH0fByKU1rHWteFKyE42cVLmaU8ZC0TImXsZmQHNxmzHOIRwFgcommlXeREy5vShzr5e12
        gQYDA/5IXWlJZkAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 42A0CA3B85;
        Tue,  8 Feb 2022 19:25:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2C7EDAB3F; Tue,  8 Feb 2022 20:21:23 +0100 (CET)
Date:   Tue, 8 Feb 2022 20:21:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: defrag: don't try to defrag extents which are
 under writeback
Message-ID: <20220208192123.GG12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <72af431773a417658d8737f3acb39c1652f7e821.1644303096.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72af431773a417658d8737f3acb39c1652f7e821.1644303096.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 02:54:05PM +0800, Qu Wenruo wrote:
> Once we start writeback (have called btrfs_run_delalloc_range()), we
> allocate an extent, create an extent map point to that extent, with a
> generation of (u64)-1, created the ordered extent and then clear the
> DELALLOC bit from the range in the inode's io tree.
> 
> Such extent map can pass the first call of defrag_collect_targets(), as
> its generation is (u64)-1, meets any possible minimal geneartion check.
> And the range will not have DELALLOC bit, also passing the DELALLOC bit
> check.
> 
> It will only be re-checked in the second call of
> defrag_collect_targets(), which will wait for writeback.
> 
> But at that stage we have already spent our time waiting for some IO we
> may or may not want to defrag.
> 
> Let's reject such extents early so we won't waste our time.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> - Update the subject, commit message and comment.
>   To replace the confusing phrase "be going to be written back" with
>   "under writeback".
> 
> - Update the commit message to indicate it's not always going to be marked
>   for defrag 
>   The second defrag_collect_targets() call will determine its destiny.
> 
> - Update the commit message to show why we want to skip it early
>   To save some time waiting for IO.

Added to misc-next, thanks.
