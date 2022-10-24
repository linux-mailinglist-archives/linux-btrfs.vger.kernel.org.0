Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9102560B330
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJXQ6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJXQz5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 12:55:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F053EA691
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 08:36:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C00AE1FD8B;
        Mon, 24 Oct 2022 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666621138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFJ1saGqgzlhjEPD9K9nK1dSmoZx4znTQA8mtLx5u10=;
        b=1faX1TOp57VhkhhDEQfwVAEHL7fvWPE+iGhODaJh5F2bIdSvKJFHahVwHc2wJLD5/XRxBI
        NWiyCItRo1R1zLFTuR2NRoDwdk1ZjsCyVzo5iqRljnDK8i1MuqmOLvDT7TJqiGe6i+qk68
        CZvMm6WQcOxgVl17Smc3nsRphCdG7XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666621138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFJ1saGqgzlhjEPD9K9nK1dSmoZx4znTQA8mtLx5u10=;
        b=G0KcdsdhqRH7C+myeyYJCfwxUJ32HLCxbPcjeT4yTeT7hU6/G7WLroag4tepzFpCJ5OtNO
        11x4MdvOr8Uab6BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9803113A79;
        Mon, 24 Oct 2022 14:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6cQvJNKeVmM6GwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 24 Oct 2022 14:18:58 +0000
Date:   Mon, 24 Oct 2022 16:18:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
Subject: Re: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
Message-ID: <20221024141845.GE5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 21, 2022 at 08:43:45AM +0800, Qu Wenruo wrote:
> [BUG]
> There are two reports (the earliest one from LKP, a more recent one from
> kernel bugzilla) that we can have some chunks with 0 as sub_stripes.
> 
> This will cause divide-by-zero errors at btrfs_rmap_block, which is
> introduced by a recent kernel patch ac0677348f3c ("btrfs: merge
> calculations for simple striped profiles in btrfs_rmap_block"):
> 
> 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
> 				 BTRFS_BLOCK_GROUP_RAID10)) {
> 			stripe_nr = stripe_nr * map->num_stripes + i;
> 			stripe_nr = div_u64(stripe_nr, map->sub_stripes); <<<
> 		}
> 
> [CAUSE]
> >From the more recent report, it has been proven that we have some chunks
> with 0 as sub_stripes, mostly caused by older mkfs.
> 
> It turns out that the mkfs.btrfs fix is only introduced in 6718ab4d33aa
> ("btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk")
> which is included in v5.4 btrfs-progs release.
> 
> So there would be quite some old fses with such 0 sub_stripes.
> 
> [FIX]
> Just don't trust the sub_stripes values from disk.
> 
> We have a trusted btrfs_raid_array[] to fetch the correct sub_stripes
> numbers for each profile.
> 
> By this, we can keep the compatibility with older fses while still avoid
> divide-by-zero bugs.
> 
> Fixes: ac0677348f3c ("btrfs: merge calculations for simple striped profiles in btrfs_rmap_block")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Viktor Kuzmin <kvaster@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216559
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
