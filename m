Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3604D0125
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbiCGO1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 09:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiCGO1L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 09:27:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333017F6F3
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 06:26:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB377210EC;
        Mon,  7 Mar 2022 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646663175;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNcUzNxXKT0KaAi/89bT1xkoUaFQx4NcFB9CRO35z9Q=;
        b=FVXGG8kWxZQasrqzMd4UfuyYbfsXwLBFnBbmVzDhAQmpAT3FdDi8WoRdtstgprmUign5GQ
        PYkDOkboe7G9BxjUQeg90yJOduobFMkXsT++vU1vypKJt2LXspDQwHcOYdzPKbaNDPUepF
        pGOIX5o6FkE36MO+Y0y4EODhGk+YW1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646663175;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNcUzNxXKT0KaAi/89bT1xkoUaFQx4NcFB9CRO35z9Q=;
        b=FAIvbutZS/0L31SQf15fUSFK49wg6YBagbDZusezPqoY4an2WhgSEmoWCIuo8zIWH5lg7t
        1W24XxUdcLbMwgCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A867AA3B84;
        Mon,  7 Mar 2022 14:26:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9937DA7F7; Mon,  7 Mar 2022 15:22:20 +0100 (CET)
Date:   Mon, 7 Mar 2022 15:22:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wwdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Message-ID: <20220307142220.GF12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wwdc.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
 <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
 <57d23926-12d7-b8b8-ca76-15dd12f802a7@oracle.com>
 <PH0PR04MB741629862E1AADAA467723569B089@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741629862E1AADAA467723569B089@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Mon, Mar 07, 2022 at 12:54:47PM +0000, Johannes Thumshirn wrote:
> On 07/03/2022 13:34, Anand Jain wrote:
> > On 07/03/2022 18:47, Johannes Thumshirn wrote:
> >> btrfs_can_activate_zone() can be called with the device_list_mutex already
> >> held, which will lead to a deadlock.
> > 
> > Could you please state that thread? I tried to trace it back and lost it.
> > 
> 
> 
> For debugging purpose I've added similar code to prepare_allocation() and 
> got a deadlock (see the lockdep splat @[1]).
> 
> 
> So code inspection showed, that we're calling btrfs_can_activate_zone()
> under the same circumstances from can_allocate_chunk() and thus are prone
> to this deadlock as well. I think it should be:
> 
> insert_dev_extents() // Takes device_list_mutex
> `-> insert_dev_extent()
>  `-> btrfs_insert_empty_item()
>   `-> btrfs_insert_empty_items()
>    `-> btrfs_search_slot()
>     `-> btrfs_cow_block()
>      `-> __btrfs_cow_block()
>       `-> btrfs_alloc_tree_block()
>        `-> btrfs_reserve_extent()
>         `-> find_free_extent()
>          `-> find_free_extent_update_loop()
>           `-> can_allocate_chunk()
>            `-> btrfs_can_activate_zone() // Takes device_list_mutex again
> 
> 
> [1]
> [   15.165897] 
> [   15.166062] ============================================
> [   15.166572] WARNING: possible recursive locking detected
> [   15.167117] 5.17.0-rc6-dennis #79 Not tainted
> [   15.167487] --------------------------------------------
> [   15.167733] kworker/u8:3/146 is trying to acquire lock:
> [   15.167733] ffff888102962ee0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: find_free_extent+0x15a/0x14f0 [btrfs]
> [   15.167733] 
> [   15.167733] but task is already holding lock:
> [   15.167733] ffff888102962ee0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: btrfs_create_pending_block_groups+0x20a/0x560 [btrfs]
> [   15.167733] 
> [   15.167733] other info that might help us debug this:
> [   15.167733]  Possible unsafe locking scenario:
> [   15.167733] 
> [   15.171834]        CPU0
> [   15.171834]        ----
> [   15.171834]   lock(&fs_devs->device_list_mutex);
> [   15.171834]   lock(&fs_devs->device_list_mutex);
> [   15.171834] 
> [   15.171834]  *** DEADLOCK ***
> [   15.171834] 
> [   15.171834]  May be due to missing lock nesting notation
> [   15.171834] 
> [   15.171834] 5 locks held by kworker/u8:3/146:
> [   15.171834]  #0: ffff888100050938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1c3/0x5a0
> [   15.171834]  #1: ffffc9000067be80 ((work_completion)(&fs_info->async_data_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1c3/0x5a0
> [   15.176244]  #2: ffff88810521e620 (sb_internal){.+.+}-{0:0}, at: flush_space+0x335/0x600 [btrfs]
> [   15.176244]  #3: ffff888102962ee0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: btrfs_create_pending_block_groups+0x20a/0x560 [btrfs]
> [   15.176244]  #4: ffff8881152e4b78 (btrfs-dev-00){++++}-{3:3}, at: __btrfs_tree_lock+0x27/0x130 [btrfs]
> [   15.179641] 
> [   15.179641] stack backtrace:
> [   15.179641] CPU: 1 PID: 146 Comm: kworker/u8:3 Not tainted 5.17.0-rc6-dennis #79
> [   15.179641] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
> [   15.179641] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
> [   15.179641] Call Trace:
> [   15.179641]  <TASK>
> [   15.179641]  dump_stack_lvl+0x45/0x59
> [   15.179641]  __lock_acquire.cold+0x217/0x2b2
> [   15.179641]  lock_acquire+0xbf/0x2b0
> [   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]
> [   15.183838]  __mutex_lock+0x8e/0x970
> [   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]
> [   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]
> [   15.183838]  ? lock_is_held_type+0xd7/0x130
> [   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]
> [   15.183838]  find_free_extent+0x15a/0x14f0 [btrfs]
> [   15.183838]  ? _raw_spin_unlock+0x24/0x40
> [   15.183838]  ? btrfs_get_alloc_profile+0x106/0x230 [btrfs]
> [   15.187601]  btrfs_reserve_extent+0x131/0x260 [btrfs]
> [   15.187601]  btrfs_alloc_tree_block+0xb5/0x3b0 [btrfs]
> [   15.187601]  __btrfs_cow_block+0x138/0x600 [btrfs]
> [   15.187601]  btrfs_cow_block+0x10f/0x230 [btrfs]
> [   15.187601]  btrfs_search_slot+0x55f/0xbc0 [btrfs]
> [   15.187601]  ? lock_is_held_type+0xd7/0x130
> [   15.187601]  btrfs_insert_empty_items+0x2d/0x60 [btrfs]
> [   15.187601]  btrfs_create_pending_block_groups+0x2b3/0x560 [btrfs]
> [   15.187601]  __btrfs_end_transaction+0x36/0x2a0 [btrfs]
> [   15.192037]  flush_space+0x374/0x600 [btrfs]
> [   15.192037]  ? find_held_lock+0x2b/0x80
> [   15.192037]  ? btrfs_async_reclaim_data_space+0x49/0x180 [btrfs]
> [   15.192037]  ? lock_release+0x131/0x2b0
> [   15.192037]  btrfs_async_reclaim_data_space+0x70/0x180 [btrfs]
> [   15.192037]  process_one_work+0x24c/0x5a0
> [   15.192037]  worker_thread+0x4a/0x3d0
> [   15.192037]  ? process_one_work+0x5a0/0x5a0
> [   15.195630]  kthread+0xed/0x120
> [   15.195630]  ? kthread_complete_and_exit+0x20/0x20
> [   15.195630]  ret_from_fork+0x22/0x30

Thanks, pasted to the changelog of the patch.
