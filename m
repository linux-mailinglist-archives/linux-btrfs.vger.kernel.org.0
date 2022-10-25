Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBD60CDDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJYNsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJYNsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 09:48:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C465188101
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 06:48:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D771F1F38C;
        Tue, 25 Oct 2022 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666705718;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r75QtccPqL258FOXdSmb8y4zg16NrcU5nzPaPzHsOiY=;
        b=dTxIAgjt2vYvjukMH3NfdTG1n5j+fyIV53yEPBoTxk7+FnvDgmGpB78ASz1w0NNezqrmih
        XL5PUp9mKlYf1c6yc/6ITzxM49+C4kyXURCzldInREWbSKhyR8RgT/TF+a5p/K7TzffKx2
        WdsJQncrE5KM2zDBZwl1SNkWqVSww5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666705718;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r75QtccPqL258FOXdSmb8y4zg16NrcU5nzPaPzHsOiY=;
        b=A6gs+5U7f44Yd6nfiL/FaEHc3NnaZXkon1fc3n9VEYOTvzj70GBd4zAfRGP/K3+Qb2jU0R
        Z8kpTSoh6A9Cc/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A33B4134CA;
        Tue, 25 Oct 2022 13:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PcA/JjbpV2MCSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 13:48:38 +0000
Date:   Tue, 25 Oct 2022 15:48:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] btrfs: raid56: do full stripe data checksum
 verification and recovery at RMW time
Message-ID: <20221025134824.GK5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665730948.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665730948.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 03:17:08PM +0800, Qu Wenruo wrote:
> There is a long existing problem for all RAID56 (not only btrfs RAID56),
> that if we have corrupted data on-disk, and we do a RMW using that
> corrupted data, we lose the chance of recovery.
> 
> Since new parity is calculated using the corrupted sector, we will never
> be able to recovery the old data.
> 
> However btrfs has data checksum to save the day here, if we do a full
> scrub level verification at RMW time, we can detect the corrupted data
> before we do any write.
> 
> Then do the proper recovery, data checksum recheck, and recovery the old
> data and call it a day.
> 
> This series is going to add such ability, currently there are the
> following limitations:
> 
> - Only works for full stripes without a missing device
>   The code base is already here for a missing device + a corrupted
>   sector case of RAID6.
> 
>   But for now, I don't really want to test RAID6 yet.
> 
> - We only handles data checksum verification
>   Metadata verification will be much more complex, and in the long run
>   we will only recommend metadata RAID1C3/C4 profiles to compensate
>   RAID56 data profiles.
> 
>   Thus we may never support metadata verification for RAID56.
> 
> - If we found corrupted sectors which can not be repaired, we fail
>   the whole bios for the full stripe
>   This is to avoid further data corruption, but in the future we may
>   just continue with corrupte data.
> 
>   This will need extra work to rollback to the original corrupte data
>   (as the recovery process will change the content).
> 
> - Way more overhead for substripe write RMW cycle
>   Now we need to:
> 
>   * Fetch the datacsum for the full stripe
>   * Verify the datacsum
>   * Do RAID56 recovery (if needed)
>   * Verify the recovered data (if needed)
> 
>   Thankfully this only affects uncached sub-stripe writes.
>   The successfully recovered data can be cached for later usage.
> 
> - Will not writeback the recovered data during RMW
>   Thus we still need to go back to recovery path to recovery.
> 
>   This can be later enhanced to let RMW to write the full stripe if
>   we did some recovery during RMW.
> 
> 
> - May need further refactor to change how we handle RAID56 workflow
>   Currently we use quite some workqueues to handle RAID56, and all
>   work are delayed.
> 
>   This doesn't look sane to me, especially hard to read (too many jumps
>   just for a full RMW cycle).
> 
>   May be a good idea to make it into a submit-and-wait workflow.
> 
> [REASON for RFC]
> Although the patchset does not only passed RAID56 test groups, but also
> passed my local destructive RMW test cases, some of the above limitations
> need to be addressed.
> 
> And whther the trade-off is worthy may still need to be discussed.

So this improves reliability at the cost of a full RMW cycle, do you
have any numbers to compare? The affected workload is a cold write in
the middle of a stripe, following writes would likely hit the cached
stripe. For linear writes the cost should be amortized, for random
rewrites it's been always problematic regarding performance but I don't
know if the raid5 (or any striped profile) performance was not better in
some sense.
