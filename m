Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773C632B43
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKURnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 12:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKURnO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 12:43:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6633213F04
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 09:43:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B95221AD4;
        Mon, 21 Nov 2022 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669052588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToIg3QXoJMAnTftEzslcbBlHVStV3bEKoCzgRiQrbXI=;
        b=mUt/tDyHB+ZJTS4+BOic4QFUx1cXu0EShSguWAaftZNWr5FwPuO0P/2WfKowtlH6oy3E6k
        5qyWgzDCqZSBMu+wjdidUX72TRF9hngCuOfIJDAPtx2RmhqugunH0tXQn8ihTtZfsGY4ao
        HTxSH1hlsw63wPQnnmi5P9IdHzjqvl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669052588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToIg3QXoJMAnTftEzslcbBlHVStV3bEKoCzgRiQrbXI=;
        b=Ysz+xW/hAZL/B0/0pHK2G/+8H0ayqi4BCA5kNuaqiBkhOd0LwyM9BEa+cQjyaqTJqggZrC
        2LxFj+TvA8XwASAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 704D61376E;
        Mon, 21 Nov 2022 17:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yQ9aGqy4e2OeCwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Nov 2022 17:43:08 +0000
Date:   Mon, 21 Nov 2022 18:42:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use kvcalloc in btrfs_get_dev_zone_info
Message-ID: <20221121174239.GY5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221120124303.17918-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120124303.17918-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 20, 2022 at 01:43:03PM +0100, Christoph Hellwig wrote:
> Otherwise the kernel memory allocator seems to be unhappy about failing
> order 6 allocations for the zones array, that cause 100% reproducible
> mount failures in my qemu setup:
> 
> [   26.078981] mount: page allocation failure: order:6, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
> [   26.079741] CPU: 0 PID: 2965 Comm: mount Not tainted 6.1.0-rc5+ #185
> [   26.080181] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   26.080950] Call Trace:
> [   26.081132]  <TASK>
> [   26.081291]  dump_stack_lvl+0x56/0x6f
> [   26.081554]  warn_alloc+0x117/0x140
> [   26.081808]  ? __alloc_pages_direct_compact+0x1b5/0x300
> [   26.082174]  __alloc_pages_slowpath.constprop.0+0xd0e/0xde0
> [   26.082569]  __alloc_pages+0x32a/0x340
> [   26.082836]  __kmalloc_large_node+0x4d/0xa0
> [   26.083133]  ? trace_kmalloc+0x29/0xd0
> [   26.083399]  kmalloc_large+0x14/0x60
> [   26.083654]  btrfs_get_dev_zone_info+0x1b9/0xc00
> [   26.083980]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> [   26.084328]  btrfs_get_dev_zone_info_all_devices+0x54/0x80
> [   26.084708]  open_ctree+0xed4/0x1654
> [   26.084974]  btrfs_mount_root.cold+0x12/0xde
> [   26.085288]  ? lock_is_held_type+0xe2/0x140
> [   26.085603]  legacy_get_tree+0x28/0x50
> [   26.085876]  vfs_get_tree+0x1d/0xb0
> [   26.086139]  vfs_kern_mount.part.0+0x6c/0xb0
> [   26.086456]  btrfs_mount+0x118/0x3a0
> [   26.086728]  ? lock_is_held_type+0xe2/0x140
> [   26.087043]  legacy_get_tree+0x28/0x50
> [   26.087323]  vfs_get_tree+0x1d/0xb0
> [   26.087587]  path_mount+0x2ba/0xbe0
> [   26.087850]  ? _raw_spin_unlock_irqrestore+0x38/0x50
> [   26.088217]  __x64_sys_mount+0xfe/0x140
> [   26.088506]  do_syscall_64+0x35/0x80
> [   26.088776]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
