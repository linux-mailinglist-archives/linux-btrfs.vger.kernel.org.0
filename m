Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2ED6BBD24
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 20:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjCOTWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjCOTWv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 15:22:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00584836
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 12:22:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0C041FD91;
        Wed, 15 Mar 2023 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678908160;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8QM+71ZEHiZx575QqOMktKyFjaMuvJ2kzjoXYqNpQk=;
        b=F7JtmDKXUlgzPhi55onezfJz2/hIUrUay47/e+mGCuR3daXckYXz6ElH/11K5AIeSiy/zY
        VONrFjGCNqMO1vD1WV/linSbOMbQbZC69tVZOxZMeAQ6ToRNFwGD7Hhys3NqQMCtlA58ea
        5h/RwS7mWmfB9SdXx0xGkDvkwWGmPV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678908160;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8QM+71ZEHiZx575QqOMktKyFjaMuvJ2kzjoXYqNpQk=;
        b=yILQzoDHNWNC+dZiYEa+a63EOBCcsMNrpfb4NPhOFQ6htRrCsKxjG3PtfaVFD6klyQMLjJ
        R+Nlme/HQ+6SBdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 833AC13A00;
        Wed, 15 Mar 2023 19:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fyE1HwAbEmTcXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Mar 2023 19:22:40 +0000
Date:   Wed, 15 Mar 2023 20:16:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/21] Lock extents before pages
Message-ID: <20230315191633.GV10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230302222506.14955-1-rgoldwyn@suse.de>
 <20230309181050.GK10580@twin.jikos.cz>
 <ZArhR3v+Nl/Rq/Nw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArhR3v+Nl/Rq/Nw@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 11:50:31PM -0800, Christoph Hellwig wrote:
> On Thu, Mar 09, 2023 at 07:10:51PM +0100, David Sterba wrote:
> > I've picked the branch from your git repository (applies on top of
> > misc-next) and will add it to for-next. We may need to keep it there for
> > some time, with this kind of core change it's not possible to do reverts
> > in case we find serious problems.
> 
> I am really worried about the i_count hack.  It is fundamentlly wrong
> and breaks inode lifetime rules.  Furthermore there is no attempt
> at understanding why it happens (or even if it is new with this series).

I don't think the i_count hack will stay until the final merge.

> > Optimistic plan is to get it stabilized during current dev cycle and
> > then one more cycle for stabilization once it's in the master branch.
> 
> It is going to clash with quite a bit of other work going in this area
> I fear.

Yeah so we'll need to decide order of merging. The locking change is
needed for iomap conversion and we need to do it at some point, knowing
that it's a risky change. Limiting amout of work in the same area is a
good thing also because of testing.
