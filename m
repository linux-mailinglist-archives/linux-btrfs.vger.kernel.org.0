Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE9581BDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 23:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiGZV5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 17:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGZV5w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 17:57:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489220F45
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 14:57:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E88BD372BF;
        Tue, 26 Jul 2022 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658872669;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+O2wrmc7JODNMBJ1+YLOkz7BTRN5RJuvewWNXCGsSE=;
        b=mvcsSzvdsgQyoE4mM6bc0w+TDNaWAOEiUO6aija5/Ttu2+GBzivlf99d2lo8vPRpIXU/DA
        FWlREFbCzZWTXmClUGAZRfWMO/kw1g2OEH9dfGa4JVVYDGY/gT2NT9vFBUnfYe4TKi3vqu
        kDOYJctad+8S0N8qo7lPsNPF6jOXGdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658872669;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+O2wrmc7JODNMBJ1+YLOkz7BTRN5RJuvewWNXCGsSE=;
        b=4rdt8VmO/YZktTwNrk2ZwQpuZ+H/JGCJXoXXd/L3eJx9f6I1lz4jFKmTxbLxBwVfJcUtir
        sSiYnV7Lat06AFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B88B013322;
        Tue, 26 Jul 2022 21:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1MEhLF1j4GLpXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 21:57:49 +0000
Date:   Tue, 26 Jul 2022 23:52:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: separate BLOCK_GROUP_TREE feature from
 extent-tree-v2
Message-ID: <20220726215252.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1658293417.git.wqu@suse.com>
 <20220726175922.GH13489@twin.jikos.cz>
 <56492a5b-8d98-38af-50f2-57a75a3417fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56492a5b-8d98-38af-50f2-57a75a3417fc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 05:47:25AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/27 01:59, David Sterba wrote:
> > On Wed, Jul 20, 2022 at 01:06:58PM +0800, Qu Wenruo wrote:
> >> Qu Wenruo (3):
> >>    btrfs: enhance unsupported compat RO flags handling
> >>    btrfs: don't save block group root into super block
> >>    btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2
> >
> > It's short series and I don't see any new code to use the separate tree
> > for bg items, so it's on top of the extent tree v2, right?
> 
> Yes, it's based on extent tree v2 prepare code that is already in the
> mainline code.
> 
> >
> >  From the last time we were experimenting with the block group tree, I
> > was trying to avoid a new tree but there were problems. So, I think we
> > can go with the separate tree that you suggest. We have reports about
> > slow mount and people use large filesystems, so this is justified.
> >
> > Will it be possible to convert existing filesystem to use the bg tree?
> 
> Yes, that's completely planned as the old bg tree code, btrfs-progs
> convert tool will be provided (mostly in btrfstune).

Ok, good. I'm thinking if we should go for an online conversion too or
not, because on a many-TB filesystem it would possibly take a long time
but the benefit is not to unmount and do the conversion.

We could copy what the free space conversion does on remount, for bg
tree implemented as "set some flag via sysfs" and ten trigger remount
that does all th work. It should be less or comparable work to free
space tree conversion, it's basically copying the block group items to
the new tree and deleting from extent tree.
