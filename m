Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B005880C7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiHBRIR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHBRIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 13:08:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20C233E30;
        Tue,  2 Aug 2022 10:08:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43D442031A;
        Tue,  2 Aug 2022 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659460087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/1xUYeHrM1BqHKP5e5fDaxuz2T/jk7uQtkyo8BlmRE=;
        b=dD0Z5E1iOkqy6EcvXiP46+3wqJN8iNHtLCpe0VSR18JR2E4DVBFFrqDsErnCjdyoznzjFd
        jjutw4CLHNt3scGvSzZHl85yui3V/EImvd9zD3npRMNDxtX8nOp7E1ipYmiTDKwcwLilPr
        Cn1RGRHDfYxltcSCH+W7sNJz9DdOH38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659460087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/1xUYeHrM1BqHKP5e5fDaxuz2T/jk7uQtkyo8BlmRE=;
        b=jl7m6JOpghmEoUCKKRNSL5Uk1d24c9TmjxBL7qbVolxJE8choElvjFUKDs6DIYFj1VsvOk
        EelVxo2fkjt6zKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F198413A8E;
        Tue,  2 Aug 2022 17:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9X0dOvZZ6WKMOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 17:08:06 +0000
Date:   Tue, 2 Aug 2022 19:03:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] fs: btrfs: fix a possible use-after-free bug caused by
 incorrect error handling in prepare_to_relocate()
Message-ID: <20220802170305.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zixuan Fu <r33s3n6@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20220721074829.2905233-1-r33s3n6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721074829.2905233-1-r33s3n6@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 03:48:29PM +0800, Zixuan Fu wrote:
> In btrfs_relocate_block_group(), the structure variable rc is allocated.
> Then btrfs_relocate_block_group() calls relocate_block_group() -> 
> prepare_to_relocate() -> set_reloc_control(), and assigns rc to the
> variable fs_info->reloc_ctl. When prepare_to_relocate() returns, it
> calls btrfs_commit_transaction() -> btrfs_start_dirty_block_groups()
> -> btrfs_alloc_path() -> kmem_cache_zalloc(), which may fail. When the
> failure occurs, btrfs_relocate_block_group() detects the error and frees
> rc and doesn't set fs_info->reloc_ctl to NULL. After that, in 
> btrfs_init_reloc_root(), rc is retrieved from fs_info->reloc_ctl and
> then used, which may cause a use-after-free bug.

I've reformatted the paragraph, the call chains are otherwise
incomprehensible.

> This possible bug can be triggered by calling btrfs_ioctl_balance()
> before calling btrfs_ioctl_defrag().
> 
> To fix this possible bug, in prepare_to_relocate(), an if statement
> is added to check whether btrfs_commit_transaction() fails. If the
> failure occurs, unset_reloc_control() is called to set
> fs_info->reloc_ctl to NULL.
> 
> The error log in our fault-injection testing is shown as follows:
> 
> [   58.751070] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
> ...
> [   58.753577] Call Trace:
> ...
> [   58.755800]  kasan_report+0x45/0x60
> [   58.756066]  btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
> [   58.757304]  record_root_in_trans+0x792/0xa10 [btrfs]
> [   58.757748]  btrfs_record_root_in_trans+0x463/0x4f0 [btrfs]
> [   58.758231]  start_transaction+0x896/0x2950 [btrfs]
> [   58.758661]  btrfs_defrag_root+0x250/0xc00 [btrfs]
> [   58.759083]  btrfs_ioctl_defrag+0x467/0xa00 [btrfs]
> [   58.759513]  btrfs_ioctl+0x3c95/0x114e0 [btrfs]
> ...
> [   58.768510] Allocated by task 23683:
> [   58.768777]  ____kasan_kmalloc+0xb5/0xf0
> [   58.769069]  __kmalloc+0x227/0x3d0
> [   58.769325]  alloc_reloc_control+0x10a/0x3d0 [btrfs]
> [   58.769755]  btrfs_relocate_block_group+0x7aa/0x1e20 [btrfs]
> [   58.770228]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
> [   58.770655]  __btrfs_balance+0x1326/0x1f10 [btrfs]
> [   58.771071]  btrfs_balance+0x3150/0x3d30 [btrfs]
> [   58.771472]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
> [   58.771902]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
> ...
> [   58.773337] Freed by task 23683:
> ...
> [   58.774815]  kfree+0xda/0x2b0
> [   58.775038]  free_reloc_control+0x1d6/0x220 [btrfs]
> [   58.775465]  btrfs_relocate_block_group+0x115c/0x1e20 [btrfs]
> [   58.775944]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
> [   58.776369]  __btrfs_balance+0x1326/0x1f10 [btrfs]
> [   58.776784]  btrfs_balance+0x3150/0x3d30 [btrfs]
> [   58.777185]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
> [   58.777621]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
> ...
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>

Added to misc-next, thanks.
