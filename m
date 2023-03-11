Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165856B581E
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Mar 2023 04:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKDwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 22:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCKDwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 22:52:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF01408A4
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 19:52:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78C8222ADD;
        Sat, 11 Mar 2023 03:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678506765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLtg04iDyV6Msc6Ojl96ZssSPX1Fw/zynYpyubV6OzU=;
        b=ggnBYbL87b7jqkycF4FwDBBEnKZBosJUtgWHYpGeuL4XbL4tCzWXTfgKNVvMYtrF8wQfk7
        S6TZZWQqzaPVUXrol64SoB2MeOdLpOpSnQ0pACz30Eq/tAoZue/fK38ww6s7aoM4EjcVYg
        +GXD+qGTBIFxYHLCcuYBbICbs8sQ3Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678506765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLtg04iDyV6Msc6Ojl96ZssSPX1Fw/zynYpyubV6OzU=;
        b=onog9U6ZsAeIy/CBNdwetXp52Ax8XMFgYuRxalkU4DdgQGx4HfPQndtpMvZGIVg7PpgqE9
        uTrrTBmW1eRH3FAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 323FA13A10;
        Sat, 11 Mar 2023 03:52:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id USUIBQ37C2T6cAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Sat, 11 Mar 2023 03:52:45 +0000
Date:   Fri, 10 Mar 2023 21:52:58 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 20/21] btrfs: Add inode->i_count instead of calling
 ihold()
Message-ID: <20230311035258.d3v2f2bngxlyv5td@kora>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <c201e92c0a69df45a8f1c4651028ccfb30aebdd2.1677793433.git.rgoldwyn@suse.com>
 <ZAdu+C8AMlcUOBhH@infradead.org>
 <20230308230357.nk2nqojk5te5eb7d@kora>
 <ZAmjWyq4QvBzuACf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAmjWyq4QvBzuACf@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  1:14 09/03, Christoph Hellwig wrote:
> On Wed, Mar 08, 2023 at 05:03:57PM -0600, Goldwyn Rodrigues wrote:
> > Without this patch, performing a writeback with async writeback
> > (mount option compress) will trigger this warning.
> 
> What is the trace in the warning?
[   57.105512] ------------[ cut here ]------------
[   57.108857] WARNING: CPU: 3 PID: 1631 at fs/inode.c:451 ihold+0x23/0x30
[   57.111887] Modules linked in:
[   57.113984] CPU: 3 PID: 1631 Comm: kworker/u8:9 Not tainted 6.3.0-rc1-dave+ #22 a352fb29779d7031315b84505284616e0ef1983c
[   57.117994] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[   57.122344] Workqueue: writeback wb_workfn (flush-btrfs-5)
[   57.125073] RIP: 0010:ihold+0x23/0x30
[   57.127342] Code: 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 b8 01 00 00 00 f0 0f c1 87 08 02 00 00 83 c0 01 83 f8 01 7e 05 c3 cc cc cc cc <0f> 0b c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
[   57.134365] RSP: 0018:ffffb0f28128faa0 EFLAGS: 00010246
[   57.137069] RAX: 0000000000000001 RBX: ffff9cae8a320e18 RCX: 0000000000000000
[   57.140224] RDX: ffff9cae8a320e18 RSI: ffff9cae849c5300 RDI: ffff9cae96d430a8
[   57.143447] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[   57.146644] R10: ffff9cae849c5308 R11: ffff9cae97640e38 R12: 000000000019a000
[   57.149808] R13: 000000000019afff R14: ffffffffa948e340 R15: 0000000000000000
[   57.153383] FS:  0000000000000000(0000) GS:ffff9caefbd80000(0000) knlGS:0000000000000000
[   57.157007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.160028] CR2: 0000563ecc4d0230 CR3: 000000010aafa006 CR4: 0000000000370ee0
[   57.163259] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   57.166647] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   57.169588] Call Trace:
[   57.171486]  <TASK>
[   57.173625]  btrfs_writepages+0x3ea/0x820
[   57.175995]  do_writepages+0xd5/0x1a0
[   57.178061]  ? lock_is_held_type+0xad/0x120
[   57.180605]  __writeback_single_inode+0x54/0x630
[   57.182981]  writeback_sb_inodes+0x1fc/0x560
[   57.185249]  wb_writeback+0xc5/0x480
[   57.187273]  wb_workfn+0x84/0x650
[   57.189207]  ? lock_acquire+0xc8/0x310
[   57.191033]  ? process_one_work+0x23c/0x630
[   57.192998]  ? lock_is_held_type+0xad/0x120
[   57.194800]  process_one_work+0x2c0/0x630
[   57.196619]  worker_thread+0x50/0x3d0
[   57.198129]  ? __pfx_worker_thread+0x10/0x10
[   57.200005]  kthread+0xea/0x110
[   57.201397]  ? __pfx_kthread+0x10/0x10
[   57.202897]  ret_from_fork+0x2c/0x50
[   57.204490]  </TASK>


-- 
Goldwyn
