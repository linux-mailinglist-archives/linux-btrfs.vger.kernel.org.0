Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA70576120
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiGOMG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGOMGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 08:06:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7D80508
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 05:06:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FF1034D7C;
        Fri, 15 Jul 2022 12:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657886781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sm7n3TFMDGMSXmktxMbHlruIGIXYZpDJ/rBY6eszsiE=;
        b=Q225Riwo77w8MYC8SgpcFwnxjdn6CHDp+JgCDkzttP7LmavUjhxIueFT2kF/oQSvvqBUzd
        S70hjlmVo6ZJ3iBtZmiUpC8KR/1XfRGWI/VO7rFA01MQQtwBF9wQ1oztua7I1lJPTRBeon
        oBNeDPk9iZ0iJrQElLA0z8n1LsPB4pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657886781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sm7n3TFMDGMSXmktxMbHlruIGIXYZpDJ/rBY6eszsiE=;
        b=toGWgicjhbf4X5Nb9ijvEewdINq3x2kBDiICrLJ3c1KWuDgSLnxx5yI/QrnWhXA8AxxE1I
        +IlHqTNToiCAHFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D28013754;
        Fri, 15 Jul 2022 12:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FF09Aj1Y0WL0BQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Jul 2022 12:06:21 +0000
Date:   Fri, 15 Jul 2022 14:01:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Message-ID: <20220715120129.GA13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1657097693.git.fdmanana@suse.com>
 <20220713135955.GA1114299@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713135955.GA1114299@falcondesktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 13, 2022 at 02:59:55PM +0100, Filipe Manana wrote:
> On Wed, Jul 06, 2022 at 10:09:44AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > After the recent conversions of a couple radix trees to XArrays, we now
> > can end up attempting to sleep while holding a spinlock. This happens
> > because if xa_insert() allocates memory (using GFP_NOFS) it may need to
> > sleep (more likely to happen when under memory pressure). In the old
> > code this did not happen because we had radix_tree_preload() called
> > before taking the spinlocks.
> > 
> > Filipe Manana (3):
> >   btrfs: fix sleep while under a spinlock when allocating delayed inode
> >   btrfs: fix sleep while under a spinlock when inserting a fs root
> >   btrfs: free qgroup metadata without holding the fs roots lock
> 
> David, are you going to pick these up or revert the patches that did the
> radix tree to xarray conversion?

Switching sping lock to mutex seems quite heavy weight, and reverting
xarray conversion is intrusive, so it's choosing from two bad options,
also that we haven't identified the problems earlier. Doing such changes
in rc6 is quite unpleasant, I'll explore the options.
