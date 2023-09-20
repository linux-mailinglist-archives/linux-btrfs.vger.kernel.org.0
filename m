Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8709C7A8C46
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjITTJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjITTJD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 15:09:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9FBAF
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 12:08:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E256722038;
        Wed, 20 Sep 2023 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695236935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IT/LLGoqtIJEmQEwkJLrBi0Nc/FsenvPaMDsZqmK9rI=;
        b=VbVxRUECqLpSyRdSypleMYtTBLxPzBnYNFnbI63vPWk1H4Obdyz5VeCKzGgSNspkrN1RZ/
        jgTlXnKd17B86xnMuQ7Yg0hi14Hk7/RANyppgfC2QURJ+FRbZxvTz1v83iJiw8B/GUTz4p
        5TumwaBYIvU06SFfkvSRpbqUwDSzUvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695236935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IT/LLGoqtIJEmQEwkJLrBi0Nc/FsenvPaMDsZqmK9rI=;
        b=QkwGJTpWH9fTNDZX52d6UYQSQbR1ORbytGp9iOj/v+YtNxHMhNNqADltXsslnvhQjNU5V6
        ljHPn/Ru5aKoUgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5C601333E;
        Wed, 20 Sep 2023 19:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3vWXK0dDC2UaNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 19:08:55 +0000
Date:   Wed, 20 Sep 2023 21:02:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
Message-ID: <20230920190221.GH2268@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
 <20230918201441.GA299788@zen>
 <20230920135923.GA3796940@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920135923.GA3796940@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 20, 2023 at 09:59:23AM -0400, Josef Bacik wrote:
> On Mon, Sep 18, 2023 at 01:14:41PM -0700, Boris Burkov wrote:
> > On Mon, Sep 18, 2023 at 03:27:47PM -0400, Josef Bacik wrote:
> > > A user reported some unpleasant behavior with very small file systems.
> > > The reproducer is this
> > > 
> > > mkfs.btrfs -f -m single -b 8g /dev/vdb
> > > mount /dev/vdb /mnt/test
> > > dd if=/dev/zero of=/mnt/test/testfile bs=512M count=20
> > > 
> > > This will result in usage that looks like this
> > > 
> > > Overall:
> > >     Device size:                   8.00GiB
> > >     Device allocated:              8.00GiB
> > >     Device unallocated:            1.00MiB
> > >     Device missing:                  0.00B
> > >     Device slack:                  2.00GiB
> > >     Used:                          5.47GiB
> > >     Free (estimated):              2.52GiB      (min: 2.52GiB)
> > >     Free (statfs, df):               0.00B
> > >     Data ratio:                       1.00
> > >     Metadata ratio:                   1.00
> > >     Global reserve:                5.50MiB      (used: 0.00B)
> > >     Multiple profiles:                  no
> > > 
> > > Data,single: Size:7.99GiB, Used:5.46GiB (68.41%)
> > >    /dev/vdb        7.99GiB
> > > 
> > > Metadata,single: Size:8.00MiB, Used:5.77MiB (72.07%)
> > >    /dev/vdb        8.00MiB
> > > 
> > > System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
> > >    /dev/vdb        4.00MiB
> > > 
> > > Unallocated:
> > >    /dev/vdb        1.00MiB
> > > 
> > > As you can see we've gotten ourselves quite full with metadata, with all
> > > of the disk being allocated for data.
> > > 
> > > On smaller file systems there's not a lot of time before we get full, so
> > > our overcommit behavior bites us here.  Generally speaking data
> > > reservations result in chunk allocations as we assume reservation ==
> > > actual use for data.  This means at any point we could end up with a
> > > chunk allocation for data, and if we're very close to full we could do
> > > this before we have a chance to figure out that we need another metadata
> > > chunk.
> > > 
> > > Address this by adjusting the overcommit logic.  Simply put we need to
> > > take away 1 chunk from the available chunk space in case of a data
> > > reservation.  This will allow us to stop overcommitting before we
> > > potentially lose this space to a data allocation.  With this fix in
> > > place we properly allocate a metadata chunk before we're completely
> > > full, allowing for enough slack space in metadata.
> > 
> > LGTM, this should help and I've been kicking around the same idea in my
> > head for a while.
> > 
> > I do think this is kind of a band-aid, though. It isn't hard to imagine
> > that you allocate data chunks up to the 1G, then allocate a metadata
> > chunk, then fragment/under-utilize the data to the point that you
> > actually fill up the metadata and get right back to this same point.
> > 
> > Long term, I think we still need more/smarter reclaim, but this should
> > be a good steam valve for the simple cases where we deterministically
> > gobble up all the unallocated space for data.
> 
> This is definitely a bit of a bandaid, because we can have any number of things
> allocate a chunk at any given time, however this is more of a concern for small
> file systems where we only have the initial 8mib metadata block group.

Is really 8M for metadata? The default mkfs creates something like this:

Filesystem size:    4.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP             256.00MiB
  System:           DUP               8.00MiB
