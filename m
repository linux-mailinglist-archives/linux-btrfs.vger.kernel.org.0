Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770A7B0B54
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI0RyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0RyW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:54:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C4B4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:54:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B324A1F894;
        Wed, 27 Sep 2023 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695837259;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKz7vBGoZiKKYNXwmXjqL+IUg1a8EpVt4fMP4w1b5rY=;
        b=KuXNbqSTL30a9C6k0H7f+zif1LRBpB2Iac2K9zG6xj7JK55tW4YJIDafDos+cQwRGtRQSM
        25I4Oyhm1nf+yWTUqh6TThatt4nfjVMwgMrYCVA2wAHkMIycVR0ZsOntOzxG4G1pPJyoAm
        gjhWZiPj7QNpwF2Z5S193rvezlk7OnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695837259;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKz7vBGoZiKKYNXwmXjqL+IUg1a8EpVt4fMP4w1b5rY=;
        b=TwrWpqAGZ3uHM2QKtmlvsnLddH1YbNpcbM2bC0jGIx6b7s0iYAdBhqqNmgT11GbQB7Aqem
        tbQLGEDyfulelEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7336413479;
        Wed, 27 Sep 2023 17:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LvBpG0tsFGU+NgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Sep 2023 17:54:19 +0000
Date:   Wed, 27 Sep 2023 19:47:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Filipe Manana <fdmanana@suse.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs]
 6c9131ed0d: stress-ng.sync-file.ops_per_sec -44.2% regression
Message-ID: <20230927174741.GB13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202309261552.a03eeb4c-oliver.sang@intel.com>
 <ZRMqjzDP/G+MKL5R@debian0.Home>
 <20230926190824.GA407285@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926190824.GA407285@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 03:08:24PM -0400, Josef Bacik wrote:
> On Tue, Sep 26, 2023 at 08:01:35PM +0100, Filipe Manana wrote:
> > On Tue, Sep 26, 2023 at 03:34:59PM +0800, kernel test robot wrote:
> > > Hello,
> > > 
> > > kernel test robot noticed a -44.2% regression of stress-ng.sync-file.ops_per_sec on:
> > > commit: 6c9131ed0d644324adeeaccd2feeef8d04950b2d ("btrfs: always reserve space for delayed refs when starting transaction")
> > > https://github.com/kdave/btrfs-devel.git dev/guilherme/temp-fsid-v4
> > 
> > David, can you remove this patch from misc-next/for-next in the meanwhile?
> > 
> > Starting to reserve space in advance for delayed refs is causing the slowdown,
> > and I can reproduce it with the stress-ng test reported below.
> > 
> > By avoiding refilling the delayed block reserve I can recover about 60% of the
> > lost performance, but that increases the chance in extreme scenarios of exhausting
> > the global reserve and reaching a dead end -ENOSPC while committing transactions.
> > It has happened rarely, both upstream and on SLE kernels.
> > 
> > At the moment I don't see how to keep both the upfront reservation of space for
> > delayed refs and the refill of the delayed refs reserve without the performance
> > impact on a test like that stress-ng test.
> 
> It's ok to eat a performance regression for correctness.  I think if you can
> reduce the pain that's good, but going slower is better than not going at all.
> 
> Long term I have plans to make this better, stress-ng hilights the problem here
> quite nicely.  The more pressure we have on the enospc machinery the more likely
> we're going to do tickets and hit arbitrary waits.
> 
> What I want to do is take away the strict "we're over the limit, you now must
> flush and wait" behavior and instead have something more akin to what MM does,
> simply allow overcommit to occur, add the usage to a per-cpu counter everywhere
> to avoid the spin lock contention, and then switch to the normal "ticket and
> wait" system once we exceed certain thresholds.
> 
> Basically I want ENOSPC to not do anything until we're down to no chunk space
> left and we're within 80% full in the available metadata block group.  This will
> drastically improve performance, but is a larger project.
> 
> Until then trading performance for correctness is simply what we have to do.
> Thanks,

So the conclusion is to keep the patch for now, right? The performance
fixes could be done on top of that, so the correctness comes first.
