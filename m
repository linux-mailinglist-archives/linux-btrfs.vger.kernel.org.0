Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED48624C39
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKJUzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 15:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKJUzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 15:55:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272424BF6;
        Thu, 10 Nov 2022 12:55:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42D7F20136;
        Thu, 10 Nov 2022 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668113700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVn09/fMcbu7gKxOIOXHM9CyA+qxoMo1sg5FRs3O4Ps=;
        b=YEX4NQNtefIWGG6qovrbgjZGy7NEVntfw+YwnYbKxLY+jzvQ00MYRba8hwTwoTqLVlYPst
        QYHxFSukuRiZHNTwDwn+SipsiVXIx3NORob70maWzoOG3XTlOlGtq6A0EfmiWfUMmEEoSD
        51pC+NBZUD2irDrWfWx4Y30qNYO2x8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668113700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVn09/fMcbu7gKxOIOXHM9CyA+qxoMo1sg5FRs3O4Ps=;
        b=2E+9AEeYdCzoyprvx+8No5KjD2zXwT/gWZpPPZNWaN/Al8RerTurINu908YndX+kZQJacF
        tMMltjyVEcdIQ5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F17B01332F;
        Thu, 10 Nov 2022 20:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X7vlOSNlbWNncwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Nov 2022 20:54:59 +0000
Date:   Thu, 10 Nov 2022 21:54:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
Message-ID: <20221110205436.GJ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 10, 2022 at 10:13:42PM +0800, ChenXiaoSong wrote:
> Syzkaller reported BUG as follows:
> 
>   BUG: sleeping function called from invalid context at
>        include/linux/sched/mm.h:274
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0xcd/0x134
>    __might_resched.cold+0x222/0x26b
>    kmem_cache_alloc+0x2e7/0x3c0
>    update_qgroup_limit_item+0xe1/0x390
>    btrfs_qgroup_inherit+0x147b/0x1ee0
>    create_subvol+0x4eb/0x1710
>    btrfs_mksubvol+0xfe5/0x13f0
>    __btrfs_ioctl_snap_create+0x2b0/0x430
>    btrfs_ioctl_snap_create_v2+0x25a/0x520
>    btrfs_ioctl+0x2a1c/0x5ce0
>    __x64_sys_ioctl+0x193/0x200
>    do_syscall_64+0x35/0x80
> 
> Fix this by introducing __update_qgroup_limit_item() helper, allocate
> memory outside of the spin lock.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>

Added to misc-next, thanks.

> +	path = btrfs_alloc_path();

btrfs_alloc_path uses fixed GFP_NOFS flags for kmem_cache_alloc but that
does not try to detect if it could sleep or not.
