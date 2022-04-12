Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F44FE76E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbiDLRsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiDLRsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 13:48:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6F18B35
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 10:46:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 69E46212B7;
        Tue, 12 Apr 2022 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649785590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnYNT9IY00AR9bK4+32D3jCnyev8Hq5T8ew73+U2wxg=;
        b=mT6VcsdEDKVHSYLkFmLOlcMgRJYVswRBsKYmM3gINepUDCqlngx/XGIwvPn2DzaJKjYsPV
        FgNCtYN1yfSI7feaTDgqm6UatPqi+EwSTLoasn/YZIunxlJ5fUXuaYAgmC6uFTzn2q5fkg
        HgqDdtTDTxF56wYrmr78yk3quobApJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649785590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnYNT9IY00AR9bK4+32D3jCnyev8Hq5T8ew73+U2wxg=;
        b=yWhQv/aVHTcyGviizBOmq8RDJD5scrIBHshiyYTbFWsdMoOMex6PQY350Po1675ZxoCaWS
        ycFlA87XJ/PoOYAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6112EA3B82;
        Tue, 12 Apr 2022 17:46:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C2ADDA7B0; Tue, 12 Apr 2022 19:42:25 +0200 (CEST)
Date:   Tue, 12 Apr 2022 19:42:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/17] btrfs: add subpage support for RAID56
Message-ID: <20220412174225.GY15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
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

On Tue, Apr 12, 2022 at 05:32:50PM +0800, Qu Wenruo wrote:
> The branch can be fetched from github, based on latest misc-next branch
> (with bio and memory allocation refactors):
> https://github.com/adam900710/linux/tree/subpage_raid56
> 
> [CHANGELOG]
> v2:
> - Rebased to latest misc-next
>   There are several conflicts caused by bio interface change and page
>   allocation update.
> 
> - A new patch to reduce the width of @stripe_len to u32
>   Currently @stripe_len is fixed to 64K, and even in the future we
>   choose to enlarge the value, I see no reason to go beyond 4G for
>   stripe length.
> 
>   Thus change it u32 to avoid some u64-divided-by-u32 situations.
> 
>   This will reduce memory usage for map_lookup (which has a lifespan as
>   long as the mounted fs) and btrfs_io_geometry (which only has a very
>   short lifespan, mostly bounded to bio).
> 
>   Furthermore, add some extra alignment check and use right bit shift
>   to replace involved division to avoid possible problems on 32bit
>   systems.
> 
> - Pack sector_ptr::pgoff and sector_ptr::uptodate into one u32
>   This will reduce memory usage and reduce unaligned memory access
> 
>   Please note that, even with it packed, we still have a 4 bytes padding
>   (it's u64 + u32, thus not perfectly aligned).
>   Without packed attribute, it will cost more memory usage anyway.
> 
> - Call kunmap_local() using address with pgoff
>   As it can handle it without problem, no need to bother extra search
>   just for pgoff.
> 
> - Use "= { 0 }" for structure initialization
> 
> - Reduce comment updates to minimal
>   If one comment line is not really touched, then don't touch it just to
>   fix some bad styles.

v2 updated in for-next, I had a local branch with more changes so I
transferred the changes manually.
