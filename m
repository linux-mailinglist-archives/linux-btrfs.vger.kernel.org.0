Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B9722CE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjFEQqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFEQql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 12:46:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1631D9
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 09:46:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E8991FE74;
        Mon,  5 Jun 2023 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685983598;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+6GoU6xQKS5QllNqiBKyK2gtxp1ZSnlfvNfJSgw4RBs=;
        b=OtxMlGzkJ+lv0OT11aArlQpZd10G8iwdcoTcoXC/mVr9ZC+WcJ3jw/jOX+akiayDfKJ6vF
        4PCPa0t+uCMYnbNjT2bD3bHMcJk7fgIriubKmLxs37WX++SVt0Mxv4Y74fdsmS1f0ylzqN
        xYlGx5AJGmgbofby2ovAdij1I9TmGcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685983598;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+6GoU6xQKS5QllNqiBKyK2gtxp1ZSnlfvNfJSgw4RBs=;
        b=xLzhR+PTU96cf4Nlgo31CwDKU3wUq9+/G0jrAswkp8Vsv6iHKP9ToxctUdxlTpqRIUhEL3
        bM0EabMbK+AoolBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 405FC139C8;
        Mon,  5 Jun 2023 16:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rrXZDm4RfmRGHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Jun 2023 16:46:38 +0000
Date:   Mon, 5 Jun 2023 18:40:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a crash in metadata repair path
Message-ID: <20230605164023.GB25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
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

On Fri, May 26, 2023 at 08:30:20PM +0800, Qu Wenruo wrote:
> [BUG]
> Test case btrfs/027 would crash with subpage (64K page size, 4K
> sectorsize) with the following dying messages:
> 
>  debug: map_length=16384 length=65536 type=metadata|raid6(0x104)
>  assertion failed: map_length >= length, in fs/btrfs/volumes.c:8093
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/messages.c:259!
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  Call trace:
>   btrfs_assertfail+0x28/0x2c [btrfs]
>   btrfs_map_repair_block+0x150/0x2b8 [btrfs]
>   btrfs_repair_io_failure+0xd4/0x31c [btrfs]
>   btrfs_read_extent_buffer+0x150/0x16c [btrfs]
>   read_tree_block+0x38/0xbc [btrfs]
>   read_tree_root_path+0xfc/0x1bc [btrfs]
>   btrfs_get_root_ref.part.0+0xd4/0x3a8 [btrfs]
>   open_ctree+0xa30/0x172c [btrfs]
>   btrfs_mount_root+0x3c4/0x4a4 [btrfs]
>   legacy_get_tree+0x30/0x60
>   vfs_get_tree+0x28/0xec
>   vfs_kern_mount.part.0+0x90/0xd4
>   vfs_kern_mount+0x14/0x28
>   btrfs_mount+0x114/0x418 [btrfs]
>   legacy_get_tree+0x30/0x60
>   vfs_get_tree+0x28/0xec
>   path_mount+0x3e0/0xb64
>   __arm64_sys_mount+0x200/0x2d8
>   invoke_syscall+0x48/0x114
>   el0_svc_common.constprop.0+0x60/0x11c
>   do_el0_svc+0x38/0x98
>   el0_svc+0x40/0xa8
>   el0t_64_sync_handler+0xf4/0x120
>   el0t_64_sync+0x190/0x194
>  Code: aa0403e2 b0fff060 91010000 959c2024 (d4210000)
> 
> [CAUSE]
> In btrfs/027 we test RAID6 with missing devices, in this particular
> case, we're repairing a metadata at the end of a data stripe.
> 
> But at btrfs_repair_io_failure(), we always pass a full PAGE for repair,
> and for subpage case this can cross stripe boundary and lead to the
> above BUG_ON().
> 
> This metadata repair code is always there, since the introduction of
> subpage support, but this can trigger BUG_ON() after the bio split
> ability at btrfs_map_bio().
> 
> [FIX]
> Instead of passing the old PAGE_SIZE, we calculate the correct length
> based on the eb size and page size for both regular and subpage cases.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
