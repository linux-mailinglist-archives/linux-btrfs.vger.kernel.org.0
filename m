Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAE5B6DC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiIMMyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiIMMyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 08:54:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5602606
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:54:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B09DE1F921;
        Tue, 13 Sep 2022 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663073671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgmhSz5YHnK2yutZh0IKfEo9ljlbmafRopFmdu7X6Y4=;
        b=JbVNNHlngBsx7/Bmq6EscL6EoQphTgzlzadoVIXbNw7ULvK0Ge7kdDjSkLAwQK9tkdIGVg
        EFi0nLiaxYEIQS5ToI2urjq+FMkNVe7wYEqVioF2qI4Q+F179bSOxa57Zkt1WA/eG3+tMV
        5Gu3k/CPFkQNQBzgAo+WkvWjdUPRnUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663073671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgmhSz5YHnK2yutZh0IKfEo9ljlbmafRopFmdu7X6Y4=;
        b=NLc0p4MQkWaSPwEUDg9U3Fo8bEiQl7r24v/U20WTVWkCBQepvBWQJFzXF2pfz4LOwlamBI
        X4tx4kBRyX3j28DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FA26139B3;
        Tue, 13 Sep 2022 12:54:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p0YrIod9IGOqDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Sep 2022 12:54:31 +0000
Date:   Tue, 13 Sep 2022 14:49:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove
 extraneous args
Message-ID: <20220913124904.GL32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662760286.git.josef@toxicpanda.com>
 <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
 <Yx89bhyk7wrrmWox@infradead.org>
 <Yx9z3bAkEanf1D5e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx9z3bAkEanf1D5e@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 02:01:01PM -0400, Josef Bacik wrote:
> On Mon, Sep 12, 2022 at 07:08:46AM -0700, Christoph Hellwig wrote:
> > On Fri, Sep 09, 2022 at 05:53:14PM -0400, Josef Bacik wrote:
> > > This is exported, so rename it to btrfs_clean_io_failure.  Additionally
> > > we are passing in the io tree's and such from the inode, so instead of
> > > doing all that simply pass in the inode itself and get all the
> > > components we need directly inside of btrfs_clean_io_failure.
> > 
> > So this goes away entirely in my "consolidate btrfs checksumming, repair
> > and bio splitting", not sure if there is much point in renaming it in
> > the meantime.
> 
> Yeah I meant to put a note about this in the cover letter.  I'm leaving these
> initial patches so Dave has options, he can take mine and then take yours at a
> later date which will remove the functionality, otherwise he can take yours and
> just drop my patches related to this code.  I obviously prefer your patches to
> remove the code altogether, but if those don't get merged before mine then this
> is a reasonable thing to bridge the gap.  Thanks,

Right now I'm inclined to add your series first as most of the patches
are safe to take before code freeze.  It's also prep for extent tree v2
and for the user space sync.

The first patches touch code that gets removed in the checksumming
series, when that one will get merged I don't know but it will be
considered for 6.2 cycle.

