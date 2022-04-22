Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422C50C18D
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiDVV6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 17:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiDVV63 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 17:58:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B42B21AB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 13:41:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4EF951F748;
        Fri, 22 Apr 2022 20:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650659670;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWT69X4ClHm5YII6CUgjmZmmsXJl1IZTmJzH2QjspOw=;
        b=o8hiuJ/88J3U1y8aLd5omLkLqh4KhOY3x5KjR/+BQSF3wbHnAuwjqMeuYL/LLr+/+ro4Ob
        /x7empXT3U2WcfUiSi6Hkwqo6jCpxgPalQ8TuV5MC5rvDm50ODyjQMS7i84nRckC+L2lTG
        7Ro7Wy0ScuDopjG/k53YCIy42Vx9tgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650659670;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWT69X4ClHm5YII6CUgjmZmmsXJl1IZTmJzH2QjspOw=;
        b=Vllh7byXX+jh2uOeanRHMQApEoRhFKNZ+gayh6HaodyqTwFu4h1bqJzc+eU4UEOq7cuv3J
        dkPjgDqohztJlIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31484131BD;
        Fri, 22 Apr 2022 20:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YwwTC1YRY2LtfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Apr 2022 20:34:30 +0000
Date:   Fri, 22 Apr 2022 22:30:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: re-define btrfs_raid_types
Message-ID: <20220422203025.GJ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650441750.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650441750.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 04:08:26PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> Changelog:
> v2:
> - Fix the start value of BTRFS_RAID_RAID0
> 
> v3:
> - Introduce more static sanity checks
>   They are kinda overkilled, but they are only compile time checks, it
>   should be fine.
> 
> - Keep btrfs_bg_flags_to_raid_index() as regular function
> 
> By the nature of BTRFS_BLOCK_GROUP_* profiles, converting the flag into
> an index should only need one bits AND, one if () check for SINGLE
> profile, one right shift to align the values, one ilog2() call which is
> normally converted into ffs() assembly code.
> 
> But we're using a lot of if () branches to do the convert.
> 
> This patch will re-define btrfs_raid_types by:
> 
> - Move it to volumes.h
>   btrfs_raid_types are only used internally, no need to be exposed
>   through UAPI.
> 
> - Re-order btrfs_raid_types
>   To make them match their value order.
> 
> - Use ilog2() to convert them into index
> 
> - Extra static_assert()s to make sure RAID0 is always the least
>   significant bit in PROFILE_MASK
> 
> 
> Qu Wenruo (2):
>   btrfs: move definition of btrfs_raid_types to volumes.h
>   btrfs: use ilog2() to replace if () branches for
>     btrfs_bg_flags_to_raid_index()

I've added the patches to for-next as it looks good as it is now, feel
free to send an update, either an incremental fixup or full resend.
