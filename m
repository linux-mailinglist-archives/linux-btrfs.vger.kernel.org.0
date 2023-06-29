Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBB74291E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 17:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjF2PI3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2PI2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 11:08:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0516F10CE
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 08:08:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D69A1F388;
        Thu, 29 Jun 2023 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688051305;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uye6J+9/nNjwWR8Wew+H7lfuEnxetapY8wOak1S3Law=;
        b=iYGgqyFTTPU1HECwmocsnTkxgW/7N7LuYTHw7rSBVo1lefemcKPVDTSAg+U0HBuihPcIQ7
        YCT58yMOR0W43FoYpMt/q2oJhbsBd+iyhxQymibpmIqCFc8DTPjijGgxS4EZizHoGwGhAu
        pBCU+2uqG7DXNSdTY11bjDsl1EFHv4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688051305;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uye6J+9/nNjwWR8Wew+H7lfuEnxetapY8wOak1S3Law=;
        b=hHshSL7qMzkrKZEi/kPdK2Lzo/GdoEx+/+VvT7vBpgJdypdHNTjy2+N/Fg79DxU2+eBzyY
        VEleyxzmhx6BYzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DD5D13905;
        Thu, 29 Jun 2023 15:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lsMxDmmenWSJLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 15:08:25 +0000
Date:   Thu, 29 Jun 2023 17:01:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        syzbot+c0f3acf145cb465426d5@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix race between balance and cancel/pause
Message-ID: <20230629150156.GK16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 23, 2023 at 01:05:41AM -0400, Josef Bacik wrote:
> Syzbot reported a panic that looks like this
> 
> assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:465
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/messages.c:259!
> RIP: 0010:btrfs_assertfail+0x2c/0x30 fs/btrfs/messages.c:259
> Call Trace:
>  <TASK>
>  btrfs_exclop_balance fs/btrfs/ioctl.c:465 [inline]
>  btrfs_ioctl_balance fs/btrfs/ioctl.c:3564 [inline]
>  btrfs_ioctl+0x531e/0x5b30 fs/btrfs/ioctl.c:4632
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The reproducer is running a balance and a cancel or pause in parallel.  The way
> balance finishes is a bit wonky, if we were paused we need to save the
> balance_ctl in the fs_info, but clear it otherwise and cleanup.  However
> we rely on the return values being specific errors, or having a cancel
> request or no pause request.  If balance completes and returns 0, but we
> have a pause or cancel request we won't do the appropriate cleanup, and
> then the next time we try to start a balance we'll trip this ASSERT.
> 
> The error handling is just wrong here, we always want to clean up,
> unless we got -ECANCELLED and we set the appropriate pause flag in the
> exclusive op.  With this patch the reproducer ran for an hour without
> tripping, previously it would trip in less than a few minutes.
> 
> Reported-by: syzbot+c0f3acf145cb465426d5@syzkaller.appspotmail.com
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
