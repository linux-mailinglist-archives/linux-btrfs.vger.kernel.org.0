Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E66259B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiKKLpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiKKLpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:45:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597613F4D;
        Fri, 11 Nov 2022 03:45:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61A67201A6;
        Fri, 11 Nov 2022 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668167106;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n0d2cMxIe4yXkl7ENjvZzfOdmNSV5L2CP6byJwDVNJE=;
        b=pGGz3nZk3qad5q8UyU1x1a0n1py6GXptXiGHtYtZL9WttmUltzLa68impCg4+8YIiBp/oE
        h3xzuvX+cJ4xLflMRgQRZwvXeJvKSyzmTEEU81j9ypBCpK8qFZ4FB2j6KGhEjVwT24+J88
        kfbwNaLgkIq6KYlnDT2BNCPjUyOEXWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668167106;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n0d2cMxIe4yXkl7ENjvZzfOdmNSV5L2CP6byJwDVNJE=;
        b=ViYv4XXbYUUfg0liiIS07iNndOSaIG+jfWgolxo1KJZcFJKJ2NtBpZUrzzaY36IEO8eKMJ
        6iDMmuXzXwlbHqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 205D713273;
        Fri, 11 Nov 2022 11:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kT7zBsI1bmMxMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 11:45:06 +0000
Date:   Fri, 11 Nov 2022 12:44:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, ChenXiaoSong <chenxiaosong2@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
Message-ID: <20221111114442.GK5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
 <20221110205436.GJ5824@twin.jikos.cz>
 <48ac1a74-6349-ccf5-92ef-2189037122b8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ac1a74-6349-ccf5-92ef-2189037122b8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 11, 2022 at 07:31:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/11/11 04:54, David Sterba wrote:
> > On Thu, Nov 10, 2022 at 10:13:42PM +0800, ChenXiaoSong wrote:
> >> Syzkaller reported BUG as follows:
> >>
> >>    BUG: sleeping function called from invalid context at
> >>         include/linux/sched/mm.h:274
> >>    Call Trace:
> >>     <TASK>
> >>     dump_stack_lvl+0xcd/0x134
> >>     __might_resched.cold+0x222/0x26b
> >>     kmem_cache_alloc+0x2e7/0x3c0
> >>     update_qgroup_limit_item+0xe1/0x390
> >>     btrfs_qgroup_inherit+0x147b/0x1ee0
> >>     create_subvol+0x4eb/0x1710
> >>     btrfs_mksubvol+0xfe5/0x13f0
> >>     __btrfs_ioctl_snap_create+0x2b0/0x430
> >>     btrfs_ioctl_snap_create_v2+0x25a/0x520
> >>     btrfs_ioctl+0x2a1c/0x5ce0
> >>     __x64_sys_ioctl+0x193/0x200
> >>     do_syscall_64+0x35/0x80
> >>
> >> Fix this by introducing __update_qgroup_limit_item() helper, allocate
> >> memory outside of the spin lock.
> >>
> >> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> > 
> > Added to misc-next, thanks.
> 
> Please remove it for now, the patch only addressed what MM layer 
> reports, it doesn't really solve the root cause, we're doing a tree 
> modification (btrfs_search_slot()), under a spinlock.

Removed. As the potential sleeping under spinlock is hard to spot we
should add might_sleep to some places.
