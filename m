Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D246D752A1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGMSDH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGMSDG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:03:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B0271F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:03:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 808AA1F383;
        Thu, 13 Jul 2023 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689271384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tR6wJx3ORbQpWq6+h2EleWrqJvDTMH2xX275bek1TG8=;
        b=jkPXQ8er3qqyrklO8w9CXVbZrRaVYB2Z/x6R6L0xvZTvSTz+xwH4JwB4wKDTIUONOtfjLv
        FlX8Ai3nUZI34o9hCoZ2mkudHP37M3mBYetkxFtOkS4Z4GIGbUKioQ12K122BShrc54arp
        w1r7G3PolUKcLR8eo0Qr3AvSS5SUQK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689271384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tR6wJx3ORbQpWq6+h2EleWrqJvDTMH2xX275bek1TG8=;
        b=ae2fJKU+zSxUcQIKKHu0Xk90FaHs4GFgf2dh5rVov6PP7bGv/K8VQaTgUWSkOkGnTrniyO
        H4PX5kKl/v1dcsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51F6B13489;
        Thu, 13 Jul 2023 18:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KIsvE1g8sGQlbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 18:03:04 +0000
Date:   Thu, 13 Jul 2023 19:56:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set_page_extent_mapped after read_folio in
 btrfs_cont_expand
Message-ID: <20230713175627.GX30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f6704eb17e95f3f23a49ec7e4807f4fa45192965.1689180044.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6704eb17e95f3f23a49ec7e4807f4fa45192965.1689180044.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 12, 2023 at 12:44:12PM -0400, Josef Bacik wrote:
> While trying to get the subpage blocksize tests running, I hit the
> following panic on generic/476
> 
> assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:229
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/subpage.c:229!
> Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> CPU: 1 PID: 1453 Comm: fsstress Not tainted 6.4.0-rc7+ #12
> Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
> pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : btrfs_subpage_assert+0xbc/0xf0
> lr : btrfs_subpage_assert+0xbc/0xf0
> Call trace:
>  btrfs_subpage_assert+0xbc/0xf0
>  btrfs_subpage_clear_checked+0x38/0xc0
>  btrfs_page_clear_checked+0x48/0x98
>  btrfs_truncate_block+0x5d0/0x6a8
>  btrfs_cont_expand+0x5c/0x528
>  btrfs_write_check.isra.0+0xf8/0x150
>  btrfs_buffered_write+0xb4/0x760
>  btrfs_do_write_iter+0x2f8/0x4b0
>  btrfs_file_write_iter+0x1c/0x30
>  do_iter_readv_writev+0xc8/0x158
>  do_iter_write+0x9c/0x210
>  vfs_iter_write+0x24/0x40
>  iter_file_splice_write+0x224/0x390
>  direct_splice_actor+0x38/0x68
>  splice_direct_to_actor+0x12c/0x260
>  do_splice_direct+0x90/0xe8
>  generic_copy_file_range+0x50/0x90
>  vfs_copy_file_range+0x29c/0x470
>  __arm64_sys_copy_file_range+0xcc/0x498
>  invoke_syscall.constprop.0+0x80/0xd8
>  do_el0_svc+0x6c/0x168
>  el0_svc+0x50/0x1b0
>  el0t_64_sync_handler+0x114/0x120
>  el0t_64_sync+0x194/0x198
> ---[ end trace 0000000000000000 ]---
> 
> This happens because during btrfs_cont_expand we'll get a page, set it
> as mapped, and if it's not Uptodate we'll read it.  However between the
> read and re-locking the page we could have called release_folio() on the
> page, but left the page in the file mapping.  release_folio() can clear
> the page private, and thus further down we blow up when we go to modify
> the subpage bits.  Fix this by putting the set_page_extent_mapped()
> after the read.  This is safe because read_folio() will call
> set_page_extent_mapped() before it does the read, and then if we clear
> page private but leave it on the mapping we're completely safe
> re-setting set_page_extent_mapped().  With this patch I can now run
> generic/476 without panicing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
