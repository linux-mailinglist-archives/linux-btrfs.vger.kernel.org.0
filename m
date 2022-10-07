Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833B5F7C3F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJGR3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJGR3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:29:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823210C4F7
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:29:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 96B951F8B8;
        Fri,  7 Oct 2022 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665163739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6kQZsx9NO05htMIkGLNrRUc8M77UhF5E70Dyy10VaY=;
        b=osvdLb7bxpwuLf8CUTwPsU+6fZdb2T+16YfItQzm8dEf0wC2zRybWo0kxHxpagtJwRZV4L
        q6oMHZkNJBji96z0Hs95OHtbmurfyMR3gOhQy17nQVdLcEYEEH8rG2glTBICXIsox65mEj
        6PS3KLn+TyyBhz4Mp5fHu2TPJMtXd5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665163739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6kQZsx9NO05htMIkGLNrRUc8M77UhF5E70Dyy10VaY=;
        b=ne/o6wUDH3acb+LtaCGrKuVYBuFB/E84KqNRGrdb/Nt3zscfIIeWP5sEaRaz3uQ81w76MH
        9jYeS5OUPD0E1GBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58C6213A9A;
        Fri,  7 Oct 2022 17:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H3GOFNthQGOMWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:28:59 +0000
Date:   Fri, 7 Oct 2022 19:28:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 11/17] btrfs: move flush related definitions to
 space-info.h
Message-ID: <20221007172855.GA13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <a946709036f0527dba6ec810e9cd61b19d267d6c.1663167823.git.josef@toxicpanda.com>
 <3929da6f-686f-9545-ffde-81f3aa3586ca@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3929da6f-686f-9545-ffde-81f3aa3586ca@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 05:21:16PM +0800, Qu Wenruo wrote:
> >   #include "compression.h"
> > +#include "space-info.h"
> >   
> >   #define BTRFS_PROP_HANDLERS_HT_BITS 8
> >   static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
> 
> >   struct btrfs_space_info {
> >   	spinlock_t lock;
> >   
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index be7df8d1d5b8..2add5b23c476 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -49,6 +49,7 @@
> >   #include "discard.h"
> >   #include "qgroup.h"
> >   #include "raid56.h"
> > +#include "space-info.h"
> 
> Why super.c needs this header?
> 
> The moved code is definition for btrfs_reserve_flush_enum and 
> btrfs_flush_state, but I didn't see any direct usage inside super.c.

It still compiles without the header and I don't think it should be
included, I don't see any usage of the space-info.h definitions.
