Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066C68DCAC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBGPOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjBGPOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 10:14:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51419A
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 07:14:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DEDF5D25A;
        Tue,  7 Feb 2023 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675782873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFIdKsVZf+uJmcaCLjiEd/aSDIlhdH3nKioAaxc1AcM=;
        b=07GEuelQXOf7msy+3xR9Wsj67Fgu0lwREk4cMMx84QW5AJ/SblUkIVNPR2L1BeU3loqCb6
        adE+hE07Qxmt5OyPZFWT19308DUnkRBc8BX8ZLpqn1Jvlu+rTTNOnGxlw/k4jhoay2b1ND
        PNUJRVFzuwtC7qsdOFDTBhffY1h+IIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675782873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFIdKsVZf+uJmcaCLjiEd/aSDIlhdH3nKioAaxc1AcM=;
        b=hVfr718EE8QGlxpeLUHKHZocOoaYPj+cVxuB5lkS53M410TuR1JkiUMeEVBbvldhD+jdiB
        m1wldbAO+FqfVjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24D8A13467;
        Tue,  7 Feb 2023 15:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yWIECNlq4mM5JAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Feb 2023 15:14:33 +0000
Date:   Tue, 7 Feb 2023 16:08:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add size class stats to sysfs
Message-ID: <20230207150844.GF28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674679476.git.boris@bur.io>
 <3e95d7d8a42fa8969f415fc03ad999de3d29a196.1674679476.git.boris@bur.io>
 <20230127132345.GA11562@twin.jikos.cz>
 <Y9RFd5e/zusf5MCm@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9RFd5e/zusf5MCm@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 01:43:19PM -0800, Boris Burkov wrote:
> On Fri, Jan 27, 2023 at 02:23:45PM +0100, David Sterba wrote:
> > On Wed, Jan 25, 2023 at 12:50:33PM -0800, Boris Burkov wrote:
> > > Make it possible to see the distribution of size classes for block
> > > groups. Helpful for testing and debugging the allocator w.r.t. to size
> > > classes.
> > 
> > Please note the sysfs file path.
> > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/sysfs.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > > index 108aa3876186..e1ae4d2323d6 100644
> > > --- a/fs/btrfs/sysfs.c
> > > +++ b/fs/btrfs/sysfs.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/spinlock.h>
> > >  #include <linux/completion.h>
> > >  #include <linux/bug.h>
> > > +#include <linux/list.h>
> > >  #include <crypto/hash.h>
> > >  #include "messages.h"
> > >  #include "ctree.h"
> > > @@ -778,6 +779,42 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
> > >  	return len;
> > >  }
> > >  
> > > +static ssize_t btrfs_size_classes_show(struct kobject *kobj,
> > > +				       struct kobj_attribute *a, char *buf)
> > > +{
> > > +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> > > +	struct btrfs_block_group *bg;
> > > +	int none = 0;
> > > +	int small = 0;
> > > +	int medium = 0;
> > > +	int large = 0;
> > 
> > For simple counters please use unsigned types.
> > 
> > > +	int i;
> > > +
> > > +	down_read(&sinfo->groups_sem);
> > 
> > This is a big lock and reading the sysfs repeatedly could block space
> > reservations. I think RCU works for the block group list and the
> > size_class is a simple read so the synchronization can be lightweight.
> 
> I believe space reservations only hold the read lock. The write lock is
> needed only to remove or add block groups, so this shouldn't slow down
> reservations. Also, FWIW, raid_bytes_show() uses the same
> locking/iteration pattern.

It does use the same lock but it does not lock all space infos, only the
one it's supposed to print the numbers.

> I am not sure how to definitely safely concurrently iterate the block
> groups without taking the lock. Are you suggesting I should just drop
> the locking, and it won't crash but might be inaccurate? Or is there
> some other RCU trick I am missing? I don't believe we use any RCU
> specific methods when deleting from the list.

I don't see the RCU for block groups so some kind of locking needs to be
done, if we don't insist on accurate numbers the mutex can be taken but
eventually yielded (rwsem_is_contended or need_resched).
