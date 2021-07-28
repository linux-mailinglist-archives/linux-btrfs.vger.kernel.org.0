Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084F43D948C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 19:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1RuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 13:50:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1RuS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 13:50:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E9B3F201BE;
        Wed, 28 Jul 2021 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627494615;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eT5li8UAiiN+phi9zLa1gi8bY3/CLq6/RlUZ73SB1ZM=;
        b=h8nNiXqi/44Tkn27hFWyyfoeuAL4JkK890aeIdQ7yRi0xR+LAzAnkslDLXXEEoo+I9VMTG
        XP6SAcKvLDAR8xCIyeJ51UqQYvozWuDcxmb2LFjalP6N++CzVXMUQnzTTSlcoCUBj70vBm
        lfQnYsk0uqYCCA15h+Xe3HFQUsShrws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627494615;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eT5li8UAiiN+phi9zLa1gi8bY3/CLq6/RlUZ73SB1ZM=;
        b=HRbMLepUUMRjeYrgH9NBxXdW3sLLJcmr2t5bkXHBXzfT7idjkfvzE1mPS/M4sMkySty37m
        oVY7fHe5G1+yJbAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E0DABA3B81;
        Wed, 28 Jul 2021 17:50:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E64E9DA8CC; Wed, 28 Jul 2021 19:47:30 +0200 (CEST)
Date:   Wed, 28 Jul 2021 19:47:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.de>
Cc:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH] btrfs: Introduce btrfs_search_backwards function
Message-ID: <20210728174730.GQ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210726140317.4907-1-mpdesouza@suse.com>
 <20210728131015.GF5047@twin.jikos.cz>
 <40bf54d5d706b8fe265cd59f1babcfea0cb13d5a.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40bf54d5d706b8fe265cd59f1babcfea0cb13d5a.camel@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 01:41:30PM -0300, Marcos Paulo de Souza wrote:
> On Wed, 2021-07-28 at 15:10 +0200, David Sterba wrote:
> > On Mon, Jul 26, 2021 at 11:03:17AM -0300, Marcos Paulo de Souza
> > wrote:
> > > +/*
> > > + * Execute search and call btrfs_previous_item to traverse
> > > backwards if the item
> > > + * was not found. If found, convert the stored item to the correct
> > > endianness.
> > > + *
> > > + * Return 0 if found, 1 if not found and < 0 if error.
> > > + */
> > > +int btrfs_search_backwards(struct btrfs_root *root,
> > > +				struct btrfs_key *key,
> > > +				struct btrfs_key *found_key,
> > 
> > Is it necessary to have 2 keys? All calls pass the same one, so
> > either
> > this should be just one or you have other patches that make use of
> > two
> > distinct keys?
> 
> Yes, in these cases yes, but I can see sometimes other places in the
> btrfs codebase where the key used convert to cpu is different from the
> key used in the search path, so I wanted to make it flexible to future
> users.

We can do that once there's need for this flexibility.

> I believe that we can extent this in the future if needed, so
> I'll send a v2 using only one key argument, and use the same argument
> to convert to the correct endianness.

Thanks, you can also drop the notices about endianness because that's
assumed that all keys normally used are ind the CPU order, the disk keys
are explicitly called 'disk_key' as their use is limited.
