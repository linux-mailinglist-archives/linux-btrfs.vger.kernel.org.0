Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66073753C62
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjGNOAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjGNOAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 10:00:22 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F442701
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:00:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-577637de4beso18028847b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689343220; x=1691935220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TU6csxFMt8Ity3ymFKWfVD1EzRvVzcXivSToqLG099I=;
        b=p3qz+Oln8SGeAYfSRHaNiTD0v0+DtpRhisXPFHtY02LlBWX9O/81ruZjcObAa0ei7S
         XH6N3qSC+QUdR2OesAuzbX8F/U0i/Bt6JM9yqIvNvteW46BBu0z+WnMLAh/WS5Q09vN0
         cpjIdXOF7lajMBQllmDqn/LP48x9hG8vfP7OLsdt14JJkQ9nfPi+H+tyIUT98zW/HiHJ
         gO5pTk66CcsTVLM6mv2iknyplqBX7U0nb7GpQ719W8JNOJN3yGxCyDJW5x8nqVGvC5Vx
         rYxxVXGqEdBqVNLih0sgn6/3kVbcirNIBjYHQ1+CVW9sqv7kTg2rdM5oQL4aisO3zHS6
         /CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343220; x=1691935220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU6csxFMt8Ity3ymFKWfVD1EzRvVzcXivSToqLG099I=;
        b=dy6SX0NcU1VPMi+u1q3BePKxipKlkdHJJb//U29aiCaIpq6epsBEXd80PmpSStBEBh
         90g4oVeBwx+kmlUgfN0JdDdHb/uDl5fJlsR27fyDK0kCLgIC4aCQjMSgOvEgGTTTizTW
         AkymqGQ2uGLi8zTCliZSCTvcIQ3bpZ14ndkCOmFwhyuffjU4vUeTPR8FKGQdiHJ6vv8g
         eJ7l1aGBJWsZBBg5ZAOXrE3EatDKJqQHGIfInOvSTLNZadJ+8cDayQDU1FFOvOdc9EOV
         /4XcKHmpl6TIfPDTlckcxp/2cMybbTuzhWUUsDPDb2OMVO9PRgRUUYjF2wU49521eXlE
         RGJA==
X-Gm-Message-State: ABy/qLYKerGdoL6i5d8mHv55eaXbhNHzJI9Lsizkny8w81x0HsTy8tjV
        JaacfmfnYWOsbHceBKHUl6y4zg==
X-Google-Smtp-Source: APBJJlFIS/j3xhTSFs5EU3cnFlftkQEKCSnsA7gWKVsP8YYsyTfdIWYjQkprLG+HCrfloQdOHO4HuQ==
X-Received: by 2002:a25:b21b:0:b0:bff:5cf8:806a with SMTP id i27-20020a25b21b000000b00bff5cf8806amr4640065ybj.7.1689343219935;
        Fri, 14 Jul 2023 07:00:19 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e3-20020a056902034300b00c3a96009bdfsm1772575ybs.35.2023.07.14.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:00:19 -0700 (PDT)
Date:   Fri, 14 Jul 2023 10:00:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix warning when putting transaction with
 qgroups enabled after abort
Message-ID: <20230714140018.GA466183@perftesting>
References: <b3c8ed953bbac475211b40c2f100e57168a56f45.1689336707.git.fdmanana@suse.com>
 <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
