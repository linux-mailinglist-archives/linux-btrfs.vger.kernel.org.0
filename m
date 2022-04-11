Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277B4FBD49
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 15:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbiDKNj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 09:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbiDKNjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 09:39:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B472180D;
        Mon, 11 Apr 2022 06:37:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2083D215FF;
        Mon, 11 Apr 2022 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649684259;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11KZMTEDGr7Y36I2Hveh49be2Dvb2g0aFWQxmVrJlYI=;
        b=eDK1BZE9UndY5Nm9Y1Q59yBMO963EEGxBP0S38+VGGctz+x2Fb0yJXLQjsEeMpv39fol/F
        UxqWru6Qnx8Qla0tyL+dE2espoSNyvL6V3VCh/Bnu15mMpRhx1IJxNESIv93US4PeeDFwJ
        03qWuC61jirABqrbJF1paxcbuKv7YK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649684259;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11KZMTEDGr7Y36I2Hveh49be2Dvb2g0aFWQxmVrJlYI=;
        b=LGdulimxNbMm/rpsEUldDVRgpVU3DBCKIiIk43EGsCiab+bFLyjHVXUmCAKOSIv6ZgDjzV
        zspTx+zQhFykusBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C20BBA3B82;
        Mon, 11 Apr 2022 13:37:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69163DA7DA; Mon, 11 Apr 2022 15:33:34 +0200 (CEST)
Date:   Mon, 11 Apr 2022 15:33:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: wait between incomplete batch allocations
Message-ID: <20220411133334.GF15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <07d6dbf34243b562287e953c44a70cbb6fca15a1.1649268923.git.sweettea-kernel@dorminy.me>
 <20220411071124.zwtcarqngqqkdd6q@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411071124.zwtcarqngqqkdd6q@naota-xeon>
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

On Mon, Apr 11, 2022 at 07:11:24AM +0000, Naohiro Aota wrote:
> On Wed, Apr 06, 2022 at 02:24:18PM -0400, Sweet Tea Dorminy wrote:
> > When allocating memory in a loop, each iteration should call
> > memalloc_retry_wait() in order to prevent starving memory-freeing
> > processes (and to mark where allcoation loops are). ext4, f2fs, and xfs
> > all use this function at present for their allocation loops; btrfs ought
> > also.
> > 
> > The bulk page allocation is the only place in btrfs with an allocation
> > retry loop, so add an appropriate call to it.
> > 
> > Suggested-by: David Sterba <dsterba@suse.cz>
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> The fstests btrfs/187 becomes incredibly slow with this patch applied.
> 
> For example, on a nvme ZNS SSD (zoned) device, it takes over 10 hours to
> finish the test case. It only takes 765 seconds if I revert this commit
> from the misc-next branch.
> 
> I also confirmed the same slowdown occurs on regular btrfs. For the
> baseline, with this commit reverted, it takes 335 seconds on 8GB ZRAM
> device running on QEMU (8GB RAM), and takes 768 seconds on a (non-zoned)
> HDD running on a real machine (128GB RAM). The tests on misc-next with the
> same setup above is still running, but it already took 2 hours.
> 
> The test case runs full btrfs sending 5 times and incremental btrfs sending
> 10 times at the same time. Also, dedupe loop and balance loop is running
> simultaneously while all the send commands finish.
> 
> The slowdown of the test case basically comes from slow "btrfs send"
> command. On the HDD run, it takes 25 minutes to run a full btrfs sending
> command and 1 hour 18 minutes to run a incremental btrfs sending
> command. Thus, we will need 78 minutes x 5 = 6.5 hours to finish all the
> send commands, making the test case incredibly slow.
> 
> > ---
> >  fs/btrfs/extent_io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 9f2ada809dea..4bcc182744e4 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/page-flags.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/blkdev.h>
> >  #include <linux/swap.h>
> > @@ -3159,6 +3160,8 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
> >  		 */
> >  		if (allocated == last)
> >  			return -ENOMEM;
> > +
> > +		memalloc_retry_wait(GFP_NOFS);
> 
> And, I just noticed this is because we are waiting for the retry even if we
> successfully allocated all the pages. We should exit the loop if (allocated
> == nr_pages).

Can you please test if the fixup restores the run time? This looks like
a mistake and the delays are not something we'd observe otherwise. If it
does not fix the problem then the last option is to revert the patch.
