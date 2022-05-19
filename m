Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DE52DA15
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 18:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbiESQXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiESQXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 12:23:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888EC1EE2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 09:23:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72F8821B9D;
        Thu, 19 May 2022 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652977380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DBggyOaajpNrd6mhnIts5GW5diC3XMqVE2QtVv4VWHY=;
        b=KrtlD3rpO++Fjczt7b2GG+JkViCxcho+Fg82pYEIjjt3/LpbqyUcOrEVlJZBjzMJX8CGSx
        /brUFRq9GPDUIPm9HVxHjH0gwgogxpw9rzwP6xCu7oOZEJUxfILn0KnUFbtxk5feIl3HNC
        X3xA5oh7RsXSL2vk6DljGplFa16IPRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652977380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DBggyOaajpNrd6mhnIts5GW5diC3XMqVE2QtVv4VWHY=;
        b=VOrF7u9vHqu+Ff/AeDi/qU92pyc05GC4cv1aEp6AGmZ4RoS9MGP1oDkKtKKyMR2m7f3kHX
        6SJ5Z2KLW2RKWcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3448213456;
        Thu, 19 May 2022 16:23:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMLsC+RuhmIzewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 May 2022 16:23:00 +0000
Date:   Thu, 19 May 2022 18:18:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Message-ID: <20220519161840.GN18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <PH0PR04MB741660777362929B7E3D11DB9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220519133850.GA2735952@falcondesktop>
 <PH0PR04MB74166AC3EE68193876D5171D9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74166AC3EE68193876D5171D9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Thu, May 19, 2022 at 01:51:34PM +0000, Johannes Thumshirn wrote:
> On 19/05/2022 15:39, Filipe Manana wrote:
> > On Thu, May 19, 2022 at 12:24:00PM +0000, Johannes Thumshirn wrote:
> >> What's the status of this patch? It fixes actual errors 
> >> (hung_tasks) for me.
> > Well, there was previous review about it, and nothing was addressed in the
> > meanwhile.
> 
> The question was about the general status of it, not if we're going to merge
> it. I know Josef's reply.

If I see comments that do not suggest there are only simple fixups
needed I'm waiting either for a discussion to resolve the questions or
an updated v2. We want a fix for the reported hang but the fix should be
complete.
