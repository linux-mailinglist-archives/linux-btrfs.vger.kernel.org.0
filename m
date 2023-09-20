Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D87A887F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 17:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjITPgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 11:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjITPgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 11:36:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F6AF;
        Wed, 20 Sep 2023 08:35:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E66821FDD;
        Wed, 20 Sep 2023 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695224156;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxSJenUlNqGXEO8c0cbIPmym8JyNrPQo7RsQf1P+u4I=;
        b=p6Dmul3+Wvg6lGgxB2gCRlUba39jDjlkx/YfgwSXblEVN4H15iO7SqSJD+dM+aAzVkFgDM
        Ix6DscwLAh50WdZSj2VZnXPKwnzNA10OfEh0AZk5oFzqfxL3V8oyIog3MgJbia2aDbgWXe
        MlszYhSIDPxAY0p8rHN3eq2q4Uk+eIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695224156;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxSJenUlNqGXEO8c0cbIPmym8JyNrPQo7RsQf1P+u4I=;
        b=sxwEx9BCYyuUL+uKjVahABT2/jeQUemeP29QGJGkGMm0Y5WuoyUlK9azsEy+tgjBcfTUgo
        niDoI3VXruTCCFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EC3F132C7;
        Wed, 20 Sep 2023 15:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WIHFBlwRC2U6SgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 15:35:56 +0000
Date:   Wed, 20 Sep 2023 17:29:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: KCSAN: data-race in btrfs_calculate_inode_block_rsv_size
 [btrfs] / btrfs_use_block_rsv [btrfs] [EXPERIMENTAL PATCH]
Message-ID: <20230920152922.GC2268@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c9e4e480-6f52-949b-e4b6-3eb0fcda3f83@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e4e480-6f52-949b-e4b6-3eb0fcda3f83@alu.unizg.hr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 20, 2023 at 08:18:35AM +0200, Mirsad Todorovac wrote:
> Hi,
> 
> This is your friendly bug reporter again.
> 
> Please don't throw stuff at me, as I found another KCSAN data-race problem.
> 
> I feel like a boy who cried wolf ...
> 
> I hope this will get some attention, as it looks this time like a real btrfs problem that could cause
> the kernel module to make a wrong turn when managing storage in different threads simultaneously and
> lead to the corruption of data. However, I do not have an example of this corruption, it is by now only
> theoretical in this otherwise great filesystem.
> 
> In fact, I can announce quite a number of KCSAN bugs already in dmesg log:
> 
>     # of
> occuren
>      ces problematic function
> -------------------------------------------
>      182 __bitmap_and+0xa3/0x110
>        2 __bitmap_weight+0x62/0xa0
>      138 __call_rcu_common.constprop.0
>        3 __cgroup_account_cputime
>        1 __dentry_kill
>        3 __mod_lruvec_page_state
>       15 __percpu_counter_compare
>        1 __percpu_counter_sum+0x8f/0x120
>        1 acpi_ut_acquire_mutex
>        2 amdgpu_fence_emit
>        1 btrfs_calculate_inode_block_rsv_size
>        1 btrfs_page_set_uptodate
>       28 copy_from_read_buf
>        3 d_add
>        3 d_splice_alias
>        1 delayacct_add_tsk+0x10d/0x630
>        7 do_epoll_ctl
>        1 do_vmi_align_munmap
>       86 drm_sched_entity_is_ready
>        4 drm_sched_entity_pop_job
>        3 enqueue_timer
>        1 finish_fault+0xde/0x360
>        2 generic_fillattr
>        2 getrusage
>        9 getrusage+0x3ba/0xaa0
>        1 getrusage+0x3df/0xaa0
>        6 inode_needs_update_time
>        1 inode_set_ctime_current
>        1 inode_update_timestamps
>        3 kernfs_refresh_inode
>       22 ktime_get_mono_fast_ns+0x87/0x120
>       13 ktime_get_mono_fast_ns+0xb0/0x120
>       24 ktime_get_mono_fast_ns+0xc0/0x120
>       79 mas_topiary_replace
>       12 mas_wr_modify
>       61 mas_wr_node_store
>        1 memchr_inv+0x71/0x160
>        1 memchr_inv+0xcf/0x160
>       19 n_tty_check_unthrottle
>        5 n_tty_kick_worker
>       35 n_tty_poll
>       32 n_tty_read
>        1 n_tty_read+0x5f8/0xaf0
>        3 osq_lock
>       27 process_one_work
>        4 process_one_work+0x169/0x700
>        2 rcu_implicit_dynticks_qs
>        1 show_stat+0x45b/0xb70
>        3 task_mem
>      344 tick_nohz_idle_stop_tick
>       32 tick_nohz_next_event
>        1 tick_nohz_next_event+0xe7/0x1e0
>       90 tick_sched_do_timer
>        5 tick_sched_do_timer+0x2c/0x120
>        1 wbt_done
>        1 wbt_issue
>        2 wq_worker_tick
>       37 xas_clear_mark
> 
> ------------------------------------------------------
> 
> This report is from a vanilla torvalds tree 6.6-rc2 kernel on Ubuntu 22.04:
> 
> [13429.116126] ==================================================================
> [13429.116794] BUG: KCSAN: data-race in btrfs_calculate_inode_block_rsv_size [btrfs] / btrfs_use_block_rsv [btrfs]

Thanks for the report.  Some data races are known to happen in the
reservation code but all the critical changes are done under locks, so
an optimistic check may skip locking to check a status but then it's
done properly again under a lock. Generally speaking.

We had several reports from static checkers and at least in one case we
added an annotation so KCSAN does not complain:

https://git.kernel.org/linus/748f553c3c4c4f175c6c834358632aff802d72cf

The original report is at

https://lore.kernel.org/linux-btrfs/CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com/

I have briefly looked at your report, it seems to be different from the
one above but still matches the general approach to the reservations. If
it's a false flag then we can add another wrapper with the annotation,
unless it's a real bug.
