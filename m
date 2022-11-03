Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4782E618512
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKCQrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKCQrC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 12:47:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBF5F86
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 09:45:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9B30219EA;
        Thu,  3 Nov 2022 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667493914;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AT2S5iwYhlG+OCf4G9ani8sxW1HiHiWDFvKgGskYjsQ=;
        b=zblSSN53Ycf6so8JYut29yc9+fpwZpJDT27T+X4r6wCCAkYs6TEMauVtBeGVrOBTAGGcGN
        M4vsGXEDLuOXhjTVPiuL2AjTejjpwvl3CI8V8ncmQziQg0Hr4EMLqBLZeH6Ay+QpY9I/F2
        5Q4pYwpqvlsYWLabeG6ZuCszr2RlnBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667493914;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AT2S5iwYhlG+OCf4G9ani8sxW1HiHiWDFvKgGskYjsQ=;
        b=KcE0zF4xdSpaaK+ZDeOTlIOZ+xlV2oJMcQ/WDgCqWX96JAdHXUceCRGfN5flarZrrSiq3N
        xV1T5D9Mw/zeKRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E6A313AAF;
        Thu,  3 Nov 2022 16:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VutiHRrwY2O/TAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 03 Nov 2022 16:45:14 +0000
Date:   Thu, 3 Nov 2022 17:44:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH 1/3] btrfs: Fix wrong check in btrfs_free_dummy_root()
Message-ID: <20221103164455.GP5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
 <20221101025356.1643836-2-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101025356.1643836-2-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:54AM +0800, Zhang Xiaoxu wrote:
> The btrfs_alloc_dummy_root() use ERR_PTR as the error return value
> rather than NULL, if error happened, there will be a null-ptr-deref
> when free the dummy root:
> 
>   BUG: KASAN: null-ptr-deref in btrfs_free_dummy_root+0x21/0x50 [btrfs]
>   Read of size 8 at addr 000000000000002c by task insmod/258926
> 
>   CPU: 2 PID: 258926 Comm: insmod Tainted: G        W          6.1.0-rc2+ #5
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x34/0x44
>    kasan_report+0xb7/0x140
>    kasan_check_range+0x145/0x1a0
>    btrfs_free_dummy_root+0x21/0x50 [btrfs]
>    btrfs_test_free_space_cache+0x1a8c/0x1add [btrfs]
>    btrfs_run_sanity_tests+0x65/0x80 [btrfs]
>    init_btrfs_fs+0xec/0x154 [btrfs]
>    do_one_initcall+0x87/0x2a0
>    do_init_module+0xdf/0x320
>    load_module+0x3006/0x3390
>    __do_sys_finit_module+0x113/0x1b0
>    do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fixes: aaedb55bc08f ("Btrfs: add tests for btrfs_get_extent")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Added to misc-next, thanks. Patches 2 and 3 are dropped as Filipe sent
the complete fixes in his series.
