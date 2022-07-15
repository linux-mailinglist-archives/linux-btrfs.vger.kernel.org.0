Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A457620D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiGOMri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGOMri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 08:47:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8916C129
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 05:47:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0A7B1FDC4;
        Fri, 15 Jul 2022 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657889255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhxkH/u8KdZLcavrWPpEDCgRgsJowN2ZjBK4JWFenPY=;
        b=j7aIbi2rRs5gh3vsRTF27FW1NlO/HYlAUCEF1sc1u7EK4cULvfk9uUf4+/s+7xwc3ImuFQ
        BlFD2S45VTkeU9RUaNwRZ69fLiHs0Bht9fiw+Ux8oDkoNq1+/pUj2CIUzj+sfklFVXOClz
        jIGttUaAy3mZoarI5y8HjblGY4W3H/I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8268E13AC3;
        Fri, 15 Jul 2022 12:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pzM9Hedh0WLZFwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Jul 2022 12:47:35 +0000
Message-ID: <383472a6-75e2-8c70-2c1e-a27234e7b761@suse.com>
Date:   Fri, 15 Jul 2022 15:47:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Content-Language: en-US
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1657097693.git.fdmanana@suse.com>
 <20220713135955.GA1114299@falcondesktop>
 <20220715120129.GA13489@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220715120129.GA13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.07.22 г. 15:01 ч., David Sterba wrote:
> On Wed, Jul 13, 2022 at 02:59:55PM +0100, Filipe Manana wrote:
>> On Wed, Jul 06, 2022 at 10:09:44AM +0100, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> After the recent conversions of a couple radix trees to XArrays, we now
>>> can end up attempting to sleep while holding a spinlock. This happens
>>> because if xa_insert() allocates memory (using GFP_NOFS) it may need to
>>> sleep (more likely to happen when under memory pressure). In the old
>>> code this did not happen because we had radix_tree_preload() called
>>> before taking the spinlocks.
>>>
>>> Filipe Manana (3):
>>>    btrfs: fix sleep while under a spinlock when allocating delayed inode
>>>    btrfs: fix sleep while under a spinlock when inserting a fs root
>>>    btrfs: free qgroup metadata without holding the fs roots lock
>>
>> David, are you going to pick these up or revert the patches that did the
>> radix tree to xarray conversion?
> 
> Switching sping lock to mutex seems quite heavy weight, and reverting
> xarray conversion is intrusive, so it's choosing from two bad options,
> also that we haven't identified the problems earlier. Doing such changes
> in rc6 is quite unpleasant, I'll explore the options.


I'm actually in favor of using the mutexes. For example looking at the 
users of root->inode_lock:

btrfs_prune_dentries - we hold the inode_lock and iterate the root's 
in-memory inode list until we find a starting node to start pruning. 
Pointer chasing isn't terribly performant.

fin_next_inode iin relocation - basically the same as btrfs_prune_dentries.

inode_tree_add - again, pointer chasing searching for the correct place 
to add an inode.

inode_tree_del - thiis is indeed a short critsec, but given that mutexes 
have an optimistic spin mode i don't think it'd be a problem here.


btrfs_kill_all_delayed_nodes - rather long critsec where all delayed 
inodes for a root are being iterated -> slow.


btrfs_get_delayed_node - rather short critsec, possibly handled by the 
optimistic spin mode of the mutex

btrfs_get_or_create_delayed_node - xa_insert called under it, in case of 
memory allocation - slow

__btrfs_release_delayed_node - short critsec, handled by optimistic spin

All in all to me it seems that spinlock is the wrong lock type for the 
kind of critical section being protected by it.


btrfs_fs_info::fs_roots_lock - this one indeed seems to protect mostly 
short-lived critsec but the mutexe's optimistic spin mode should handle 
it. But also looking at it I think some of the uses can be eliminated 
altogether and rely simply on the internal locking of the xarray.
