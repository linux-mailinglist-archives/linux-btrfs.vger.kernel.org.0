Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155453EE8CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhHQIrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhHQIrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 04:47:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D9C061764
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8SnolkeUNSfzktYY6KMZbOIGW/zdj1it3VzvMb6YMug=; b=NQbxHcErnDhCG88jh/M+326lSH
        VVHW32IyppKWFYIdkGFgebbsFBVzTBdEHLCc+/HvufFI75IpIcnIrTsvsDhqgUZk6JMvZR7MMPX4H
        O0TsOQgLiKMacBGisjddlK+XsLbpcIlG0CoGNTe+q1IC5YsUebMJmQn949NrzbQjbZnz1b5EljrN1
        DnQRwAyivrjdzQXTzetHfd1EGuqAUoiaTIGM0JyTbZIxGoB20E3MlRRYEONW/dtJViYWfF5WQu2Cq
        u3qrAQ9acb60wNJI3w4DHVfGv28qilA1FptwD5xvfBtmlJhpw3XTSjsiSUN6eBHE/8aV5F4INZnzl
        8eEBI7lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFuk8-00AQ7U-L9; Tue, 17 Aug 2021 08:46:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 980E03004B2;
        Tue, 17 Aug 2021 10:46:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 825DA2019CD43; Tue, 17 Aug 2021 10:46:42 +0200 (CEST)
Date:   Tue, 17 Aug 2021 10:46:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>, willy@infradead.org
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
Message-ID: <YRt3cnhgP+AcwK92@hirez.programming.kicks-ass.net>
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
 <20210816102022.GU5047@twin.jikos.cz>
 <1e15b3ab-e3a3-548b-86a7-c309deed0f12@suse.com>
 <YRqAO41JqBwutUKd@hirez.programming.kicks-ass.net>
 <20210816204354.GI5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816204354.GI5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 10:43:54PM +0200, David Sterba wrote:
> On Mon, Aug 16, 2021 at 05:11:55PM +0200, Peter Zijlstra wrote:
> > Something a little like the *completely* untested below....
> > 
> > Then I imagine someone could do something like:
> > 
> > struct my_tree_node {
> > 	...
> > 	spinlock_t lock;
> 
> Is this meant to work only for spinlocks or does it work for rwsem too?
> I guess with lockdep it does not matter but we use rwsem for tree locks.

Anything with a ->dep_map member works; courtesy of macros :-) That very
much includes rwsems.

> > @@ -4920,6 +4962,15 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >  
> >  	class_idx = class - lock_classes;
> >  
> > +	if (nest_lock) {
> > +		if (!__lock_is_held(nest_lock, -1)) {
> > +			print_lock_nested_lock_not_held(curr, hlock, ip);
> > +			return 0;
> > +		}
> > +		if (nest_lock->type == LD_LOCK_NEST_FUNC)
> 
> That's probably nest_lock->lock_type, does not compile otherwise.

Yes, sorry, typing so hard :-)
