Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937A64DDF32
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Mar 2022 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiCRQlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Mar 2022 12:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiCRQlI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Mar 2022 12:41:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E38FD1CF0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Mar 2022 09:39:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C0C8C1F397;
        Fri, 18 Mar 2022 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647621586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYSWL2AV5+J7GgGKBm8Dfj6KfXvLyvn/neUU0sRhIyM=;
        b=qrcO6jqODGj6pLVqrT+vkE2a5n7kmBVhJpEkcA3jAAqkxUERCBJjHzdZDvtTkp0HncpYJ3
        LvltC43grgdIf3jHPKfpadIqEFIKgw5IIzolVhhGSVDBCeL/n4QHf96eIsqWzsUmYjQdHb
        jgWJRtYND0yOIo64TiZ3VdHNP8UIJgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647621586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYSWL2AV5+J7GgGKBm8Dfj6KfXvLyvn/neUU0sRhIyM=;
        b=2YYs2giFuVF+IPhpdoDl4wamp0Un98EWZcz5m35nv9Ys/PAUgx+e0VXEZQ11DcnRXdRmSu
        dVcLwfsW0o37FUCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B6145A3B81;
        Fri, 18 Mar 2022 16:39:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 644BADA7E1; Fri, 18 Mar 2022 17:35:46 +0100 (CET)
Date:   Fri, 18 Mar 2022 17:35:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the uninitialized btrfs_bio::iter
Message-ID: <20220318163546.GF12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f7698bebfcbd1687dbf8742290cd8d88b891590f.1647476483.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7698bebfcbd1687dbf8742290cd8d88b891590f.1647476483.git.wqu@suse.com>
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

On Thu, Mar 17, 2022 at 08:23:12AM +0800, Qu Wenruo wrote:
> [BUG]
> There are reports about compression crash with error injection, mostly
> triggering the following ASSERT()s in dec_and_test_compressed_bio():
> 
> 	ASSERT(btrfs_bio(bio)->iter.bi_size);
> 
> The call trace triggered by generic/475 (needs compress mount option)
> looks like this:
> 
>   assertion failed: btrfs_bio(bio)->iter.bi_size, in fs/btrfs/compression.c:213
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ctree.h:3551!
>   invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
>   CPU: 5 PID: 6548 Comm: fsstress Tainted: G           OE     5.17.0-rc7-custom+ #10
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>   Call Trace:
>    <TASK>
>    dec_and_test_compressed_bio.cold+0x16/0x2c [btrfs]
>    end_compressed_bio_read+0x37/0x170 [btrfs]
>    btrfs_submit_compressed_read+0x803/0x820 [btrfs]
>    submit_one_bio+0xc7/0x100 [btrfs]
>    btrfs_readpage+0xec/0x130 [btrfs]
>    filemap_read_folio+0x53/0xf0
>    filemap_get_pages+0x6f3/0xa10
>    filemap_read+0x1d6/0x520
>    new_sync_read+0x24e/0x360
>    vfs_read+0x1a1/0x2a0
>    ksys_read+0xc9/0x160
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [CAUSE]
> Unlike regular IO path, we will initialize btrfs_bio::iter in
> btrfs_map_bio(), for error path, we have to manually initialize
> btrfs_bio::iter before calling the endio function.
> 
> In above case, due to injected errors, we go to finish_cb: tag directly
> without submitting with btrfs_map_bio() call.
> 
> This leaves btrfs_bio::iter for the compressed bio uninitialized and
> caught by the ASSERT().
> 
> [FIX]
> Fix it by calling btrfs_bio_save_iter() before we call endio for the
> compressed bio.
> 
> Please fold this fix into commit "btrfs: make
> dec_and_test_compressed_bio() to be split bio compatible".
> 
> If needed, I can update the series and resend, but if this is the only
> problem, it may be better not to flood the list with 17 patches.

No need to resend, fixup folded to the patch and the series will be in
for-next again, thanks.
