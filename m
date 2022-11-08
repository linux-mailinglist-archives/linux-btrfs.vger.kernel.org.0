Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5831620480
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 01:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiKHANY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 19:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHANX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 19:13:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE7C17
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 16:13:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C2F42242A;
        Tue,  8 Nov 2022 00:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667866400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5covRR/tr+e4TMtXW6ahm7k87z3AT3bxtcvqCi6Cazw=;
        b=SyDk4rguOPyj79ZLo29BSzj4x4B2cwt+efQbWk7Q2+qqxhdfclyg8O1jYL2K/B9zynz6cq
        0LHyYwXx83f0NR8n9Npjr2D4YzFpQzVyxYwj/xGZ4b0ff3kVxhg5LWu1zb0wy8i26KUuq5
        6jfXOmTxm85y+vxJwFpw/YSh4eq9LjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667866400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5covRR/tr+e4TMtXW6ahm7k87z3AT3bxtcvqCi6Cazw=;
        b=qFefdNXBeWZXCpA7zMoSjJsSBz7zQczJ10lOfDM1RIJ3y2VMnWcOZYxKilK9XtgI+Ud4jF
        o+8pV2LdHTTTX1CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49CAA139F1;
        Tue,  8 Nov 2022 00:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 38EwESCfaWPWbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 08 Nov 2022 00:13:20 +0000
Date:   Tue, 8 Nov 2022 01:12:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
Message-ID: <20221108001258.GW5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
 <3b5ebb57-af2a-7cf3-6f2e-75d64f17e853@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5ebb57-af2a-7cf3-6f2e-75d64f17e853@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 08, 2022 at 07:45:08AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/11/7 23:07, Anand Jain wrote:
> > There is a repeating code section in the parent function after calling
> > btrfs_alloc_device(), as below.
> > 
> >                name = rcu_string_strdup(path, GFP_...);
> >                 if (!name) {
> >                         btrfs_free_device(device);
> >                         return ERR_PTR(-ENOMEM);
> >                 }
> >                 rcu_assign_pointer(device->name, name);
> > 
> > Except in add_missing_dev() for obvious reasons.
> > 
> > This patch consolidates that repeating code into the btrfs_alloc_device()
> > itself so that the parent function doesn't have to duplicate code.
> > This consolidation also helps to review issues regarding rcu lock
> > violation with device->name.
> > 
> > Parent function device_list_add() and add_missing_dev() uses GFP_NOFS for
> > the alloc, whereas the rest of the parent function uses GFP_KERNEL, so
> > bring the NOFS alloc context using memalloc_nofs_save() in the function
> > device_list_add() and add_missing_dev() is already doing it.
> 
> I'm wondering do we really need to use RCU for device list?
> 
> My understanding of this situation is, btrfs has very limited way to 
> modifiy device list (device add/remove/replace), while most of our 
> operations are read-only for device list.
> 
> Can we just go regular semaphore and get rid of the RCU scheme completely?

We can't get rid of RCU completely right now but as I read your
question, it may be possible to unify the read/write accees to one
locking primitive. I'd like to get rid of the RCU and have tried but
some sort of locking is needed around device name as it can be chnaged
and read independently from ioctl and many printks.

But, the device list and RCU is a bit different. The RCU access to
device list is used in the ioctls that basically iterate devices and
read something. Here RCU is the most lightweight we can do, next is read
side of a read-write primitive.

I haven't looked closer for the device list, but the rwlock or semaphore
could increase lock contention in case there are multiple readers and
writers. So, an ioctl that reads device info (read) can block any write
access (super block commit). Here the RCU allows to access the device
list for read while super block commit can proceed. There are maybe more
examples of the read-write interactions but I'd consider blocking super
block write as a critical one so I pick it as first example.

What we have now is is quite complex but works for all scenarios: device
scan, device add/remove, all vs super block commit, mounted or
unmounted, device name change at any time (vs printks). We could
simplify that, but at the cost of increased contention "correct but
slow", or "complex but you can hammer ioctls and your filesystem will
write data in time".

I don't want to discourage you or anybody from finding optimizations,
small in terms of performance or plain code, like this patch. We might
hit dead ends before finding some viable. I thought the RCU for device
name can be replaced by som some locking scheme but it does not improve
things, RCU (and the _rcu printk helpers) is still better.
