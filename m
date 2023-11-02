Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F327DF877
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjKBROx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKBROw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 13:14:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F1B184;
        Thu,  2 Nov 2023 10:14:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0F631F8D4;
        Thu,  2 Nov 2023 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698945284;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFHFH90Sk24oByP56Xhe8dLZYrPFog06RyTMXGwb5VY=;
        b=AWiMwHvXmyW2ol5xb9RxZsGHoeNBsdCR9Ujz75Gprin5gFeHrYvMjDnFItsDi8b1+Q3mSm
        6k68l6qeYc2ccCgJIuyKWcMhDzrkn6r56yerl6AMNPM172JQrri3XTuILm/xWvY8/Mwvt9
        qUme59hMeDK5xbOJKhGAgFzHRNppxWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698945284;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFHFH90Sk24oByP56Xhe8dLZYrPFog06RyTMXGwb5VY=;
        b=FRaFnjVzE97PXWsv6PAmQo+mM/iXmKRloWmIS0puoqBSHS+CGg3ZGwticcVZxQA5FJCnlM
        gC8ZuOJto7l0zUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 577CE13584;
        Thu,  2 Nov 2023 17:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yxWbFATZQ2ULYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 02 Nov 2023 17:14:44 +0000
Date:   Thu, 2 Nov 2023 18:07:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102170745.GF11264@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102123446.GA3305034@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > Thanks,
> > 
> > Just in case you forgot about it. I did send a patch to convert btrfs to
> > the new mount api in June:
> > 
> > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > 
> 
> Yeah Daan told me about this after I had done the bulk of the work.  I
> shamelessly stole the dup idea, I had been doing something uglier.
> 
> > Can I ask you to please please copy just two things from that series:
> > 
> > (1) Please get rid of the second filesystems type.
> > (2) Please fix the silent remount behavior when mounting a subvolume.
> >
> 
> Yeah I've gotten rid of the second file system type, the remount thing is odd,
> I'm going to see if I can get away with not bringing that over.  I *think* it's
> because the standard distro way of doing things is to do
> 
> mount -o ro,subvol=/my/root/vol /
> mount -o rw,subvol=/my/home/vol /home
> <boot some more>
> mount -o remount,rw /
> 
> but I haven't messed with it yet to see if it breaks.  That's on the list to
> investigate today.  Thanks,

It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
subvolumes with different ro/rw options"), the functionality should
be preserved else it's a regression.
