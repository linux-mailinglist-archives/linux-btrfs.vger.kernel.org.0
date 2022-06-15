Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B9554C7BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiFOLuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiFOLug (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF704C403
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 04:50:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 756A61F461;
        Wed, 15 Jun 2022 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655293833;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYcYZeHOOoZdivO2JPF2Zp5+Nc00bXcK6Y7HbfFIVUA=;
        b=P063SiKA0RrkNmjVJ3UfJvUnX9uIMBLsNjy9qdHQEO4Zyv/purKJiGnW5pkOTsHkJyd0gV
        UBlIIoe6R1w/qYMaQVn+u5JT2wpv/K/Wp/04sO5AoZgCY36IgdfSuTTKwfld+QcPmPhU/4
        5KNleAiiigR5BW4/mJATryKFfaSFq2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655293833;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYcYZeHOOoZdivO2JPF2Zp5+Nc00bXcK6Y7HbfFIVUA=;
        b=pB4eYDj1w3MRuRdDqWkeOsZjVZmIqV4bJUcJtcYS02bwv6miwrvXzjiwYSRf+lZ5JF2yKo
        A7msXCM4yLnvRiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 511E1139F3;
        Wed, 15 Jun 2022 11:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YJbdEonHqWL2egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 11:50:33 +0000
Date:   Wed, 15 Jun 2022 13:45:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: cleanups and preparation for the incoming
 RAID56J features
Message-ID: <20220615114559.GS20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652428644.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652428644.git.wqu@suse.com>
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

On Fri, May 13, 2022 at 04:34:27PM +0800, Qu Wenruo wrote:
> Since I'm going to introduce two new chunk profiles, RAID5J and RAID6J
> (J for journal), if we're relying on ad-hoc if () else if () branches to
> calculate thing like number of p/q stripes, it will cause a lot of
> problems.
> 
> In fact, during my development, I have hit tons of bugs related to this.
> 
> One example is alloc_rbio(), it will assign rbio->nr_data, if we forgot
> to update the check for RAID5 and RAID6 profiles, we will got a bad
> nr_data == num_stripes, and screw up later writeback.
> 
> 90% of my suffering comes from such ad-hoc usage doing manual checks on
> RAID56.
> 
> Another example is, scrub_stripe() which due to the extra per-device
> reservation, @dev_extent_len is no longer the same the data stripe
> length calculated from extent_map.
> 
> So this patchset will do the following cleanups preparing for the
> incoming RAID56J (already finished coding, functionality and on-disk
> format are fine, although no journal yet):
> 
> - Calculate device stripe length in-house inside scrub_stripe()
>   This removes one of the nasty mismatch which is less obvious.
> 
> - Use btrfs_raid_array[] based calculation instead of ad-hoc check
>   The only exception is scrub_nr_raid_mirrors(), which has several
>   difference against btrfs_num_copies():
> 
>   * No iteration on all RAID6 combinations
>     No sure if it's planned or not.
> 
>   * Use bioc->num_stripes directly
>     In that context, bioc is already all the mirrors for the same
>     stripe, thus no need to lookup using btrfs_raid_array[].
> 
> With all these cleanups, the RAID56J will be much easier to implement.
> 
> Qu Wenruo (4):
>   btrfs: remove @dev_extent_len argument from scrub_stripe() function
>   btrfs: use btrfs_chunk_max_errors() to replace weird tolerance
>     calculation
>   btrfs: use btrfs_raid_array[] to calculate the number of parity
>     stripes
>   btrfs: use btrfs_raid_array[].ncopies in btrfs_num_copies()

Added to misc-next, thanks.
