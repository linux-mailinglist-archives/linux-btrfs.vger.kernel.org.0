Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B453561656E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKBO7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKBO7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 10:59:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C32AE4
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 07:59:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA6BF22BBD;
        Wed,  2 Nov 2022 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667401174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3OXvH0k/pQYSAMUxlI0rvjkfUWEZmmh8sFSky5Rqp8=;
        b=eJs3ifU5uFkvPREsAAU0GsUSwiGjl81d7Wddz4Kpg+akvIWRMzW7pjNXCrRISnuXwDQ1sN
        clwrlvqJETPXV1RJVuVqShxL921sTzipf7AczXsvv3yxcb0OGOred0rHSEsRRoHDRS1Sn1
        A2GbvnBxKuEFD+/oihsiE2tKGqvLmNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667401174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3OXvH0k/pQYSAMUxlI0rvjkfUWEZmmh8sFSky5Rqp8=;
        b=QyBncf/Yc6AJjYDYmlBH2mDTjIb00tsysO44kwZ6+cpOSeIy6ldfeSJXwO4WgjqBcz2qt5
        Hg4o9t4MfzGrPnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD39D13AE0;
        Wed,  2 Nov 2022 14:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I3IdLdaFYmO/bwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 02 Nov 2022 14:59:34 +0000
Date:   Wed, 2 Nov 2022 15:59:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs: raid56: use submit-and-wait method to
 handle raid56 worload
Message-ID: <20221102145915.GG5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667300355.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667300355.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 01, 2022 at 07:16:00PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add coverage for raid56 recover and scrub paths
>   In fact, with full coverage we can do better cleanups, which gets
>   reflected to the changed lines.
> 
> - Better naming schemes
>   We now have 3 main entrances:
>   * recover_rbio()
>   * rmw_rbio()
>   * scrub_rbio()
> 
>   And their work related functions will be called:
>   * {recover|rmw|scrub}_rbio_work()
>   * {recover|rmw|scrub}_rbio_work_locked()
> 
>   The later is for unlock_stripe() to call, where we hold the full
>   stripe lock.
> 
> - More extracted helpers
>   Now we have the following helpers:
>   * {recover|rmw|scrub}_assemble_{read|write}_bios()
>   * submit_read_bios()
>   * submit_write_bios()
> 
> Currently btrfs raid56 has very chaotic jumps using endio functions:
> 
> E.g. for raid_parity_write(), if we go sub-stripe, the function jumps
> would be:
> 
>   raid_parity_write()
>    |
>    v
>   __raid56_parity_write()
>    |
>    v
>   partial_stripe_write()
>    |
>    v
>   start_async_work(rmw_work) <<< Delayed work
>    |
>    v
>   raid56_rmw_stripe()
>    |
>    v
>   raid56_rmw_end_io_work() <<< End io jump
>    |
>    v
>   validate_rbio_for_rmw()
>    |
>    v
>   finish_rmw()
>    |
>    v
>   raid_write_end_io() <<< End io jump
>    |
>    v
>   rbio_orig_end_io()
> 
> During a simple sub-stripe write, we have to go through over 10
> functions, two end_io jump, at least one delayed work.
> 
> With this patchset, we only go like this:
> 
>   raid_parity_write()
>    |
>    v
>   rmw_rbio_work() <<< Delayed work
>    |
>    v
>   rbio_work()
>    |
>    v
>   rbio_orig_end_io()
> 
> And inside rbio_work(), there is no more end io jumps or extra delayed
> work.
> Everything except IO is single threaded, and the IO is just
> submit-and-wait.
> 
> This patchset will rework the raid56 write path (recover and scrub path
> is not touched yet) by:
> 
> - Introduce a single entrance for recover/rmw/scrub.
>   The main function will be called {recover|rmw|scrub}_rbio(),
>   executed in rmw_worker workqueue.
> 
> - Unified handling for all writes (full/sub-stripe, cached/non-cached,
>   degraded or not), recover (dedicated, and in writes/scrub path) and
>   scrub.
> 
> - No special handling for cases we can skip some workload
>   E.g. for sub-stripe write, if we have a cached rbio, we can skip the
>   read.
> 
>   Now we just assemble the read bio list, submit all bios (none in
>   this case) and wait for the IO to finish.
> 
>   Since we submitted zero bios, the rbio::stripes_pending is 0, the
>   wait immediately returned, needing no extra handling.
> 
> - No more need for end_io_work or raid56_endio_workers
>   Since we don't rely on endio functions to jump to the next step.
> 
> By this, we have unified entrance for all raid56 writes, and no extra
> jumping/workqueue mess to interrupt the workflow.
> 
> This would make later destructive RMW fix much easier to add, as the
> timing of each step in RMW cycle should be very easy to grasp.
> 
> Thus I hope this series can be merged before the previous RFC series of
> destructive RMW fix.
> 
> Qu Wenruo (12):
>   btrfs: raid56: extract the vertical stripe recovery code into
>     recover_vertical()
>   btrfs: raid56: extract the pq generation code into a helper
>   btrfs: raid56: extract the recovery bio list build code into a helper
>   btrfs: raid56: extract sector recovery code into a helper
>   btrfs: raid56: switch recovery path to a single function
>   btrfs: raid56: extract the rmw bio list build code into a helper
>   btrfs: raid56: extract rwm write bios assembly into a helper
>   btrfs: raid56: introduce the a main entrance for rmw path
>   btrfs: raid56: switch write path to rmw_rbio()
>   btrfs: raid56: extract scrub read bio list assembly code into a helper
>   btrfs: raid56: switch scrub path to use a single function
>   btrfs: remove the unused btrfs_fs_info::endio_raid56_workers and
>     btrfs_raid_bio::end_io_work

Thanks for untangling it. You may want to add some recognizable prefix
like raid56_ to functions that could block for io, simple helpers do not
need it and they'll be probably inlined anyway.

Added to misc-next. Please proceed with the RMW fix series.
