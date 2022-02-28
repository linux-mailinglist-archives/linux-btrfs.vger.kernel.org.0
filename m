Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661834C7C16
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 22:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiB1VeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 16:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiB1VeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 16:34:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B513548A
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 13:33:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6CE3F218EE;
        Mon, 28 Feb 2022 21:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646084008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2Pf4wY89jUM51pt5AJTuhBc1uef+yF25gzJDcJUjAM=;
        b=Cz1CUTEIoARA4Wb78/BAzfEGpcGUWd5RUuj9zv2nlEk+HNbgzCDRKObxO5IPw1y6DHd9Ow
        Wp5LbjGinGv71mRYdHQ3+4eZrMoniYCl+1yRah9wefaQ/K1HLuv9Q3RNVYpxnHv1r5H8gq
        c24gbi8JdWcHH7n/16v5ZpEvObbrsuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646084008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2Pf4wY89jUM51pt5AJTuhBc1uef+yF25gzJDcJUjAM=;
        b=Z2jQSYfsIUUIYDhRUckOuj+8CkZykaNRPRCBkgal80nAlkohf9Yo/+iK0cRWU+EPWYksmx
        Q2SCDRA+BrwHooAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 09DDBA3B84;
        Mon, 28 Feb 2022 21:33:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0A1FDA823; Mon, 28 Feb 2022 22:29:36 +0100 (CET)
Date:   Mon, 28 Feb 2022 22:29:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Message-ID: <20220228212936.GM12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20220228014340.21309-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228014340.21309-1-realwakka@gmail.com>
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

On Mon, Feb 28, 2022 at 01:43:40AM +0000, Sidong Yang wrote:
> The commit e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> qgroup rescan worker") by Kawasaki resolves deadlock between quota
> disable and qgroup rescan worker. But also there is a deadlock case like
> it. It's about enabling or disabling quota and creating or removing
> qgroup. It can be reproduced in simple script below.
> 
> for i in {1..100}
> do
>     btrfs quota enable /mnt &
>     btrfs qgroup create 1/0 /mnt &
>     btrfs qgroup destroy 1/0 /mnt &
>     btrfs quota disable /mnt &
> done
> 
> Here's why the deadlock happens:
> 
> 1) The quota rescan task is running.
> 
> 2) Task A calls btrfs_quota_disable(), locks the qgroup_ioctl_lock
>    mutex, and then calls btrfs_qgroup_wait_for_completion(), to wait for
>    the quota rescan task to complete.
> 
> 3) Task B calls btrfs_remove_qgroup() and it blocks when trying to lock
>    the qgroup_ioctl_lock mutex, because it's being held by task A. At that
>    point task B is holding a transaction handle for the current transaction.
> 
> 4) The quota rescan task calls btrfs_commit_transaction(). This results
>    in it waiting for all other tasks to release their handles on the
>    transaction, but task B is blocked on the qgroup_ioctl_lock mutex
>    while holding a handle on the transaction, and that mutex is being held
>    by task A, which is waiting for the quota rescan task to complete,
>    resulting in a deadlock between these 3 tasks.
> 
> To resolve this issue, the thread disabling quota should unlock
> qgroup_ioctl_lock before waiting rescan completion. Move
> btrfs_qgroup_wait_for_completion() after unlock of qgroup_ioctl_lock.
> 
> Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> qgroup rescan worker")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v4: fix typos, changelog.

Perfect, thanks.
