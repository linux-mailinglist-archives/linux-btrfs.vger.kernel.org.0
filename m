Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD59724A85
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbjFFRs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbjFFRsz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 13:48:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013CF10F8
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:48:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9100C21990;
        Tue,  6 Jun 2023 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686073733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34CF/je3QQ7ffTeHnBCUQ1OsQ9tAcOQKgWSSxxuTWVc=;
        b=0g63e9bkRYhXUEScOdCiqBtTUWG5xfsPCbLGOU+tQeYaGSaOy6F+kJ80rJ/SvtVtS8iM5/
        eJci+UwAz74r23QZCZQCcjYGLo8TeH/6DsA2c08VIqF8BONMaSqcve1hK1IazDA7HZWNil
        g2cnhhGxtvKDQeQkxDrJDVY/TNcvry4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686073733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34CF/je3QQ7ffTeHnBCUQ1OsQ9tAcOQKgWSSxxuTWVc=;
        b=ZxgtRjcBplQjViD6/WeDt8Xd2pGPpMI1Y4cuSPGqzLaAn+D6WLfe91zvowf7HohQQBMzFL
        2RZD8iw29xcrMNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A2AD13776;
        Tue,  6 Jun 2023 17:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uC0oGYVxf2TnZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 17:48:53 +0000
Date:   Tue, 6 Jun 2023 19:42:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, boris@bur.io
Subject: Re: [PATCH] btrfs: properly enable async discard when switching from
 RO->RW
Message-ID: <20230606174238.GN25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230605190315.2121377-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605190315.2121377-1-clm@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 05, 2023 at 12:03:15PM -0700, Chris Mason wrote:
> async discard uses the BTRFS_FS_DISCARD_RUNNING bit in the fs_info to force
> discards off when the filesystem has aborted or we're generally not able
> to run discards.  This gets flipped on when we're mounted rw, and also
> when we go from ro->rw.
> 
> Commit 63a7cb13071842 enabled async discard by default, and this meant
> mount -o ro /dev/xxx /yyy had async discards turned on.
> 
> Unfortunately, this meant our check in btrfs_remount_cleanup() would see
> that discards are already on:
> 
>     /* If we toggled discard async */
>     if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
> 	btrfs_test_opt(fs_info, DISCARD_ASYNC))
> 	    btrfs_discard_resume(fs_info);
> 
> So, we'd never call btrfs_discard_resume() when remounting the root
> filesystem from ro->rw.
> 
> drgn shows this really nicely:
> 
> import os
> import sys
> 
> from drgn.helpers.linux.fs import path_lookup
> from drgn import NULL, Object, Type, cast
> 
> def btrfs_sb(sb):
>     return cast("struct btrfs_fs_info *", sb.s_fs_info)
> 
> if len(sys.argv) == 1:
>     path = "/"
> else:
>     path = sys.argv[1]
> 
> fs_info = cast("struct btrfs_fs_info *", path_lookup(prog, path).mnt.mnt_sb.s_fs_info)
> 
> BTRFS_FS_DISCARD_RUNNING = 1 << prog['BTRFS_FS_DISCARD_RUNNING']
> if fs_info.flags & BTRFS_FS_DISCARD_RUNNING:
>     print("discard running flag is on")
> else:
>     print("discard running flag is off")
> 
> [root]# mount | grep nvme
> /dev/nvme0n1p3 on / type btrfs
> (rw,relatime,compress-force=zstd:3,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/)
> 
> [root]# ./discard_running.drgn
> discard running flag is off
> 
> [root]# mount -o remount,discard=sync /
> [root]# mount -o remount,discard=async /
> [root]# ./discard_running.drgn
> discard running flag is on
> 
> The fix used here is calling btrfs_discard_resume() when we're going
> from ro->rw.  It already checks to make sure the async discard flag is
> on, so it'll do the right thing.
> 
> Fixes: 63a7cb13071842 ("btrfs: auto enable discard=async when possible")
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Chris Mason <clm@fb.com>

Added to misc-next, thanks.
