Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B3507714
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiDSSJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiDSSJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 14:09:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F93C70D
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:06:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3CD2210F5;
        Tue, 19 Apr 2022 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650391589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=upvZjUNYW/8iWTRsRrbMazAb0v/bxm3vrB9/y/nroTk=;
        b=NyPOcHhe3MGflOSFiQ7uv0TZ00ShTXV0QuvvalktM4Mu6c5Edkq+DwsibpMiKexm/0jeyd
        FH2MLkjHd3FjKXhw5axOx1NTwIeh77XhPsGLbdSMvVEQ9D0HW7N3oWcnMMXJ+X0QwRadPk
        AGrP1y9Shi/18F2VVYDEgICDLnhFXzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650391589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=upvZjUNYW/8iWTRsRrbMazAb0v/bxm3vrB9/y/nroTk=;
        b=Tlwv5sC7dbEDXK1po41GpRq5qcbCqiqd4AVd6v3xBU7N8qJI7luK7kcS2IbuzIbUINc5+f
        ecVDozVi7b9XRiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB66B139BE;
        Tue, 19 Apr 2022 18:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wt+9LCT6XmKGdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 18:06:28 +0000
Date:   Tue, 19 Apr 2022 20:02:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix assertion failure during scrub due to block
 group reallocation
Message-ID: <20220419180225.GG2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <e39beae941fdde3176fe75c35e273e39e0661f4b.1650374396.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39beae941fdde3176fe75c35e273e39e0661f4b.1650374396.git.fdmanana@suse.com>
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

On Tue, Apr 19, 2022 at 02:23:57PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a scrub, or device replace, we can race with block group removal
> and allocation and trigger the following assertion failure:
> 
> [ 7526.385524] assertion failed: cache->start == chunk_offset, in fs/btrfs/scrub.c:3817
> [ 7526.387351] ------------[ cut here ]------------
> [ 7526.387373] kernel BUG at fs/btrfs/ctree.h:3599!
> [ 7526.388001] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [ 7526.388970] CPU: 2 PID: 1158150 Comm: btrfs Not tainted 5.17.0-rc8-btrfs-next-114 #4
> [ 7526.390279] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 7526.392430] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 7526.393520] Code: f3 48 c7 c7 20 (...)
> [ 7526.396926] RSP: 0018:ffffb9154176bc40 EFLAGS: 00010246
> [ 7526.397690] RAX: 0000000000000048 RBX: ffffa0db8a910000 RCX: 0000000000000000
> [ 7526.398732] RDX: 0000000000000000 RSI: ffffffff9d7239a2 RDI: 00000000ffffffff
> [ 7526.399766] RBP: ffffa0db8a911e10 R08: ffffffffa71a3ca0 R09: 0000000000000001
> [ 7526.400793] R10: 0000000000000001 R11: 0000000000000000 R12: ffffa0db4b170800
> [ 7526.401839] R13: 00000003494b0000 R14: ffffa0db7c55b488 R15: ffffa0db8b19a000
> [ 7526.402874] FS:  00007f6c99c40640(0000) GS:ffffa0de6d200000(0000) knlGS:0000000000000000
> [ 7526.404038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7526.405040] CR2: 00007f31b0882160 CR3: 000000014b38c004 CR4: 0000000000370ee0
> [ 7526.406112] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 7526.407148] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 7526.408169] Call Trace:
> [ 7526.408529]  <TASK>
> [ 7526.408839]  scrub_enumerate_chunks.cold+0x11/0x79 [btrfs]
> [ 7526.409690]  ? do_wait_intr_irq+0xb0/0xb0
> [ 7526.410276]  btrfs_scrub_dev+0x226/0x620 [btrfs]
> [ 7526.410995]  ? preempt_count_add+0x49/0xa0
> [ 7526.411592]  btrfs_ioctl+0x1ab5/0x36d0 [btrfs]
> [ 7526.412278]  ? __fget_files+0xc9/0x1b0
> [ 7526.412825]  ? kvm_sched_clock_read+0x14/0x40
> [ 7526.413459]  ? lock_release+0x155/0x4a0
> [ 7526.414022]  ? __x64_sys_ioctl+0x83/0xb0
> [ 7526.414601]  __x64_sys_ioctl+0x83/0xb0
> [ 7526.415150]  do_syscall_64+0x3b/0xc0
> [ 7526.415675]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 7526.416408] RIP: 0033:0x7f6c99d34397
> [ 7526.416931] Code: 3c 1c e8 1c ff (...)
> [ 7526.419641] RSP: 002b:00007f6c99c3fca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 7526.420735] RAX: ffffffffffffffda RBX: 00005624e1e007b0 RCX: 00007f6c99d34397
> [ 7526.421779] RDX: 00005624e1e007b0 RSI: 00000000c400941b RDI: 0000000000000003
> [ 7526.422820] RBP: 0000000000000000 R08: 00007f6c99c40640 R09: 0000000000000000
> [ 7526.423906] R10: 00007f6c99c40640 R11: 0000000000000246 R12: 00007fff746755de
> [ 7526.424924] R13: 00007fff746755df R14: 0000000000000000 R15: 00007f6c99c40640
> [ 7526.425950]  </TASK>
> 
> That assertion is relatively new, introduced with commit d04fbe19aefd2
> ("btrfs: scrub: cleanup the argument list of scrub_chunk()").
> 
> The block group we get at scrub_enumerate_chunks() can actually have a
> start address that is smaller then the chunk offset we extracted from a
> device extent item we got from the commit root of the device tree.
> This is very rare, but it can happen due to a race with block group
> removal and allocation. For example, the following steps show how this
> can happen:
> 
> 1) We are at transaction T, and we have the following blocks groups,
>    sorted by their logical start address:
> 
>    [ bg A, start address A, length 1G (data) ]
>    [ bg B, start address B, length 1G (data) ]
>    (...)
>    [ bg W, start address W, length 1G (data) ]
> 
>      --> logical address space hole of 256M,
>          there used to be a 256M metadata block group here
> 
>    [ bg Y, start address Y, length 256M (metadata) ]
> 
>       --> Y matches W's end offset + 256M
> 
>    Block group Y is the block group with the highest logical address in
>    the whole filesystem;
> 
> 2) Block group Y is deleted and its extent mapping is removed by the call
>    to remove_extent_mapping() made from btrfs_remove_block_group().
> 
>    So after this point, the last element of the mapping red black tree,
>    its rightmost node, is the mapping for block group W;
> 
> 3) While still at transaction T, a new data block group is allocated,
>    with a length of 1G. When creating the block group we do a call to
>    find_next_chunk(), which returns the logical start address for the
>    new block group. This calls returns X, which corresponds to the
>    end offset of the last block group, the rightmost node in the mapping
>    red black tree (fs_info->mapping_tree), plus one.
> 
>    So we get a new block group that starts at logical address X and with
>    a length of 1G. It spans over the whole logical range of the old block
>    group Y, that was previously removed in the same transaction.
> 
>    However the device extent allocated to block group X is not the same
>    device extent that was used by block group Y, and it also does not
>    overlap that extent, which must be always the case because we allocate
>    extents by searching through the commit root of the device tree
>    (otherwise it could corrupt a filesystem after a power failure or
>    an unclean shutdown in general), so the extent allocator is behaving
>    as expected;
> 
> 4) We have a task running scrub, currently at scrub_enumerate_chunks().
>    There it searches for device extent items in the device tree, using
>    its commit root. It finds a device extent item that was used by
>    block group Y, and it extracts the value Y from that item into the
>    local variable 'chunk_offset', using btrfs_dev_extent_chunk_offset();
> 
>    It then calls btrfs_lookup_block_group() to find block group for
>    the logical address Y - since there's currently no block group that
>    starts at that logical address, it returns block group X, because
>    its range contains Y.
> 
>    This results in triggering the assertion:
> 
>       ASSERT(cache->start == chunk_offset);
> 
>    right before calling scrub_chunk(), as cache->start is X and
>    chunk_offset is Y.
> 
> This is more likely to happen of filesystems not larger than 50G, because
> for these filesystems we use a 256M size for metadata block groups and
> a 1G size for data block groups, while for filesystems larger than 50G,
> we use a 1G size for both data and metadata block groups (except for
> zoned filesystems). It could also happen on any filesystem size due to
> the fact that system block groups are always smaller (32M) than both
> data and metadata block groups, but these are not frequently deleted, so
> much less likely to trigger the race.
> 
> So make scrub skip any block group with a start offset that is less than
> the value we expect, as that means it's a new block group that was created
> in the current transaction. It's pointless to continue and try to scrub
> its extents, because scrub searches for extents using the commit root, so
> it won't find any. For a device replace, skip it as well for the same
> reasons, and we don't need to worry about the possibility of extents of
> the new block group not being to the new device, because we have the write
> duplication setup done through btrfs_map_block().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
