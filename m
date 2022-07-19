Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3157A917
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 23:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiGSVhj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 17:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiGSVhi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 17:37:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B75760515
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 14:37:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC4A91FE0E;
        Tue, 19 Jul 2022 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658266654;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ftf1RYSHfXenaVPX+d93bTtPCaFArbC9HltVnuxBnKA=;
        b=zH7/hnBZ3mYJ1bDY2u6xnlhs8asuJ/6z28MV9NvUKpzQHjj8kdD7tTjU+RvHCQ5jv0rflp
        qaT3ZIe25fbARUtHHcRDF1Qn5kY/i5lkakLo/6RfpWDeO5tsp1137zi+WUyuSJvZnLBowB
        ak2LzKiUdvZeLILHY6poMj7f4CjN5Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658266654;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ftf1RYSHfXenaVPX+d93bTtPCaFArbC9HltVnuxBnKA=;
        b=oZOlX1+sQDg79qKQjlD5ECaD8gRDH12DuLCTlocIG34LkdIG8c4uuODRDWSQT6eVXzcHm6
        uyxR28MNJUVCcDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F5813488;
        Tue, 19 Jul 2022 21:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rPNoLx4k12KDGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Jul 2022 21:37:34 +0000
Date:   Tue, 19 Jul 2022 23:32:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: error writing primary super block on zoned btrfs
Message-ID: <20220719213241.GS13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220718054944.GA22359@lst.de>
 <YtVSBLTuRCED9mYb@casper.infradead.org>
 <PH0PR04MB74161E9598C27B8CEA10F53F9B8F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220719151345.GA21932@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719151345.GA21932@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 05:13:45PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 07:53:45AM +0000, Johannes Thumshirn wrote:
> > Ha but zoned btrfs uses two zones as a ringbuffer for its super-block, could
> > it be, that we're accumulating too many page references somewhere? And then it
> > behaves like having millions of filesystems mounted?
> 
> That fact the superblock moves for zoned devices probably has
> something to do with it.  But the whole code leaves me really puzzling.
> 
> Why does wait_dev_supers even do a find_get_page vs just stashing
> three page pointers away in the btrfs_device structure?

The superblock used to be written written using buffer heads, the
current code is direct transformation of the buffer head API to bios, so
it's still using page cache.

I've sent a patchset to write it with separate pages, but this breaks
userspace as the reads are from page cache. This should be done by
direct io, also I'll need more time to test it properly, the
kernel/userspace interactions were missed initially.

> Why does this abuse wait_on_page_locked vs using a completion?

This is I think still from the buffer head times, the page lock waiting
was available and hasn't been converted to completion.

> Why does the code count errors while only an error on the primary
> superblock has any consequences?

Because the primary superblock is the important one, error on the
secondary should not bring down the filesystem if the primary can be
written.

> What is the point of the secodary superblocks if they aren't written
> on fsync?

Writing superblock is an IO hit, used to be noticeable on rotational
devices, and fsync is meant to be fast. It's I believe a performance
optimization. The secondary superblocks are rarely used so they don't
get the same treatment as primary.

> How does just setting the whole page uptodat work on file systems
> with a block size smaller than the page size where we don't know
> what is in the rest of the page?

This was pointed out by Matthew some time ago, the part of the page
after superblock will be uninitialized.
