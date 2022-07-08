Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43356C022
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiGHSFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiGHSFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 14:05:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB07D1D2
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 11:05:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C70A22125;
        Fri,  8 Jul 2022 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657303549;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZjMqPA9gL+tYvE0Dqq9hP4Oa1a/lJM9PiUjnFhkpNk=;
        b=ElvhFjGU8DSFysrZJNoj0FmGZexZat0mM5EYtfCrfcnkmYO6jaNNU61pLsP3O2/Gr05HIr
        dkWBJCR3HO1XPcwdZxV11N0fdTn9u1fzoFIc0p2wotXygHf0+UkXKuMr57YCHscdN+/ytR
        WG4zsR7sbCchlBRDOw+qzMqGj9d88hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657303549;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZjMqPA9gL+tYvE0Dqq9hP4Oa1a/lJM9PiUjnFhkpNk=;
        b=AarQKPVYoT02TkRE0toTvlNBRAHKb9nlw4y7tuDiT9mWJRYEZIlDUBnqVUuQfXP6c9ud54
        jgJ7u0NsW+G8wdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF85D13A7D;
        Fri,  8 Jul 2022 18:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yp54OfxxyGItMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Jul 2022 18:05:48 +0000
Date:   Fri, 8 Jul 2022 20:01:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/13] btrfs: zoned: fix active zone tracking issues
Message-ID: <20220708180101.GX15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1656909695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
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

On Mon, Jul 04, 2022 at 01:58:04PM +0900, Naohiro Aota wrote:
> This series addresses mainly two issues on zoned btrfs' active zone
> tracking and one issue which is a dependency of the main issue.
> 
> * Background
[...]

Thanks for the writeup, this seems to be fixing a serious problem, also
guessing by the length of the series. Some of the patches are marked for
stable 5.12 or 5.16 but I think this would need to be backported
manually and to 5.18 as the other versions have been EOLed.

As most of the changes are in zoned code I can add the whole series to
misc-next rather sooner than later because the code freeze is near.

I did a quick test and it crashes in the self tests so I can't add the
branch to for-next.

[   13.324894] Btrfs loaded, crc32c=crc32c-generic, debug=on, assert=on, integrity-checker=on, ref-verify=on, zoned=yes, fsverity=yes
[   13.326507] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
[   13.327303] BTRFS: selftest: running btrfs free space cache tests
[   13.328133] BTRFS: selftest: running extent only tests
[   13.328935] BTRFS: selftest: running bitmap only tests
[   13.329770] BTRFS: selftest: running bitmap and extent tests
[   13.330647] BTRFS: selftest: running space stealing from bitmap to extent tests
[   13.331990] BTRFS: selftest: running bytes index tests
[   13.332915] BTRFS: selftest: running extent buffer operation tests
[   13.333924] BTRFS: selftest: running btrfs_split_item tests
[   13.334922] BTRFS: selftest: running extent I/O tests
[   13.335733] BTRFS: selftest: running find delalloc tests
[   13.525595] BUG: unable to handle page fault for address: 0000000000002360
[   13.526677] #PF: supervisor read access in kernel mode
[   13.527480] #PF: error_code(0x0000) - not-present page
[   13.528381] PGD 0 P4D 0 
[   13.528909] Oops: 0000 [#1] PREEMPT SMP
[   13.529604] CPU: 0 PID: 642 Comm: modprobe Not tainted 5.19.0-rc5-default+ #1809
[   13.530742] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[   13.532475] RIP: 0010:find_lock_delalloc_range+0x41/0x2a0 [btrfs]
[   13.535137] RSP: 0018:ffffb750c05ebcd8 EFLAGS: 00010296
[   13.535467] RAX: 0000000000000000 RBX: ffff96b1fe0f3440 RCX: 0000000000000fff
[   13.535880] RDX: ffffb750c05ebd60 RSI: ffff96b1fe0f3440 RDI: ffff96b1838b8f00
[   13.536534] RBP: ffff96b1838b8f00 R08: 0000000000000000 R09: 0000000000000001
[   13.537141] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000001000
[   13.537548] R13: ffff96b1838b8ab8 R14: 0000000000000fff R15: ffffb750c05ebd58
[   13.537956] FS:  00007eff49b43740(0000) GS:ffff96b1fd600000(0000) knlGS:0000000000000000
[   13.538467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.538808] CR2: 0000000000002360 CR3: 0000000003f1c000 CR4: 00000000000006b0
[   13.539213] Call Trace:
[   13.539407]  <TASK>
[   13.539584]  test_find_delalloc+0x19b/0x695 [btrfs]
[   13.539978]  btrfs_test_extent_io+0x1e/0x39 [btrfs]
[   13.540710]  btrfs_run_sanity_tests.cold+0x33/0xcd [btrfs]
[   13.541686]  init_btrfs_fs+0xcc/0x12b [btrfs]
[   13.542328]  ? 0xffffffffc060a000
[   13.542868]  do_one_initcall+0x65/0x330
[   13.543348]  ? rcu_read_lock_sched_held+0x3b/0x70
[   13.543980]  ? trace_kmalloc+0x33/0xe0
[   13.544394]  ? kmem_cache_alloc_trace+0x188/0x270
[   13.544805]  do_init_module+0x4a/0x1f0
[   13.545076]  __do_sys_finit_module+0x9e/0xf0
[   13.545373]  do_syscall_64+0x3c/0x80
[   13.545618]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   13.545961] RIP: 0033:0x7eff49c6da8d
[   13.547264] RSP: 002b:00007ffcb6e6bbc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   13.547724] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007eff49c6da8d
[   13.548184] RDX: 0000000000000000 RSI: 000055a8143faab2 RDI: 000000000000000d
[   13.549012] RBP: 000055a81441d460 R08: 0000000000000000 R09: 0000000000000000
[   13.549550] R10: 000000000000000d R11: 0000000000000246 R12: 000055a8143faab2
[   13.549958] R13: 000055a814423530 R14: 0000000000000000 R15: 000055a814424ab8
[   13.550363]  </TASK>
[   13.550541] Modules linked in: btrfs(+) blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash loop
[   13.551275] CR2: 0000000000002360
[   13.551525] ---[ end trace 0000000000000000 ]---
[   13.551819] RIP: 0010:find_lock_delalloc_range+0x41/0x2a0 [btrfs]
[   13.555923] RSP: 0018:ffffb750c05ebcd8 EFLAGS: 00010296
[   13.557052] RAX: 0000000000000000 RBX: ffff96b1fe0f3440 RCX: 0000000000000fff
[   13.558614] RDX: ffffb750c05ebd60 RSI: ffff96b1fe0f3440 RDI: ffff96b1838b8f00
[   13.559857] RBP: ffff96b1838b8f00 R08: 0000000000000000 R09: 0000000000000001
[   13.561280] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000001000
[   13.562619] R13: ffff96b1838b8ab8 R14: 0000000000000fff R15: ffffb750c05ebd58
[   13.563522] FS:  00007eff49b43740(0000) GS:ffff96b1fd600000(0000) knlGS:0000000000000000
[   13.564612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.565356] CR2: 0000000000002360 CR3: 0000000003f1c000 CR4: 00000000000006b0
