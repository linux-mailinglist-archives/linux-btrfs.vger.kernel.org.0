Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5575C7570B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 02:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGRADK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 20:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRADJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 20:03:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8691BFF
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 17:03:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E5311FD9F;
        Tue, 18 Jul 2023 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689638585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMvtMAljnF1WkjrJUuqCCm+30ZMLdmi3DzpzBm0XnHI=;
        b=JTAzMs6FqJXKLI8WFo9wdkKmQpCBRsb9e4uf67PSCXlKXYBnUlyyMypg3jpGvxH/MylMPv
        w9nZDY2WkfOmGFGKxSCJMR8LM2qIG/yMMThbDzaZKEo60uIezytI1fxHBMAazxUXuBIg/b
        EkvZAfMJNWbviN/fPtH5xi+V9cGwJEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689638585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMvtMAljnF1WkjrJUuqCCm+30ZMLdmi3DzpzBm0XnHI=;
        b=1rvyu5XwEGpKm9RkuxtD2hbEse/x3s5OuguyeO7qwYMBcmVfWOXORYRveXTmPLSiLPFjT3
        wbKS5gdQtTSkGXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE718133FE;
        Tue, 18 Jul 2023 00:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oQfhOLjWtWQjWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Jul 2023 00:03:04 +0000
Date:   Tue, 18 Jul 2023 01:56:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix warning when putting transaction with
 qgroups enabled after abort
Message-ID: <20230717235625.GM20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b3c8ed953bbac475211b40c2f100e57168a56f45.1689336707.git.fdmanana@suse.com>
 <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 01:42:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have a transaction abort with qgroups enabled we get a warning
> triggered when doing the final put on the transaction, like this:
> 
>   [161552.678901] ------------[ cut here ]------------
>   [161552.681530] WARNING: CPU: 4 PID: 81745 at fs/btrfs/transaction.c:144 btrfs_put_transaction+0x123/0x130 [btrfs]
>   [161552.681759] Modules linked in: btrfs blake2b_generic xor (...)
>   [161552.681934] CPU: 4 PID: 81745 Comm: btrfs-transacti Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
>   [161552.681945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>   [161552.681951] RIP: 0010:btrfs_put_transaction+0x123/0x130 [btrfs]
>   [161552.682139] Code: bd a0 01 00 (...)
>   [161552.682146] RSP: 0018:ffffa168c0527e28 EFLAGS: 00010286
>   [161552.682155] RAX: ffff936042caed00 RBX: ffff93604a3eb448 RCX: 0000000000000000
>   [161552.682161] RDX: ffff93606421b028 RSI: ffffffff92ff0878 RDI: ffff93606421b010
>   [161552.682166] RBP: ffff93606421b000 R08: 0000000000000000 R09: ffffa168c0d07c20
>   [161552.682171] R10: 0000000000000000 R11: ffff93608dc52950 R12: ffffa168c0527e70
>   [161552.682175] R13: ffff93606421b000 R14: ffff93604a3eb420 R15: ffff93606421b028
>   [161552.682181] FS:  0000000000000000(0000) GS:ffff93675fb00000(0000) knlGS:0000000000000000
>   [161552.682187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [161552.682193] CR2: 0000558ad262b000 CR3: 000000014feda005 CR4: 0000000000370ee0
>   [161552.682211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [161552.682216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [161552.682221] Call Trace:
>   [161552.682229]  <TASK>
>   [161552.682236]  ? __warn+0x80/0x130
>   [161552.682250]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
>   [161552.682430]  ? report_bug+0x1f4/0x200
>   [161552.682444]  ? handle_bug+0x42/0x70
>   [161552.682456]  ? exc_invalid_op+0x14/0x70
>   [161552.682467]  ? asm_exc_invalid_op+0x16/0x20
>   [161552.682483]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
>   [161552.682661]  btrfs_cleanup_transaction+0xe7/0x5e0 [btrfs]
>   [161552.682838]  ? _raw_spin_unlock_irqrestore+0x23/0x40
>   [161552.682847]  ? try_to_wake_up+0x94/0x5e0
>   [161552.682856]  ? __pfx_process_timeout+0x10/0x10
>   [161552.682872]  transaction_kthread+0x103/0x1d0 [btrfs]
>   [161552.683047]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
>   [161552.683217]  kthread+0xee/0x120
>   [161552.683227]  ? __pfx_kthread+0x10/0x10
>   [161552.683237]  ret_from_fork+0x29/0x50
>   [161552.683259]  </TASK>
>   [161552.683262] ---[ end trace 0000000000000000 ]---
> 
> This corresponds to this line of code:
> 
>   void btrfs_put_transaction(struct btrfs_transaction *transaction)
>   {
>       (...)
>           WARN_ON(!RB_EMPTY_ROOT(
>                           &transaction->delayed_refs.dirty_extent_root));
>       (...)
>   }
> 
> The warning happens because btrfs_qgroup_destroy_extent_records(), called
> in the transaction abort path, we free all entries from the rbtree
> "dirty_extent_root" with rbtree_postorder_for_each_entry_safe(), but we
> don't actually empty the rbtree - it's still pointing to nodes that were
> freed.
> 
> So set the rbtree's root node to NULL to avoid this warning (assign
> RB_ROOT).
> 
> Fixes: 81f7eb00ff5b ("btrfs: destroy qgroup extent records on transaction abort")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Use RB_ROOT macro instead of assigning NULL directly to the root's rb_node.

Added to misc-next, thanks.
