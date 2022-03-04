Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500DD4CD5FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiCDOMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 09:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiCDOMd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 09:12:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6D1BA917;
        Fri,  4 Mar 2022 06:11:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 171F521118;
        Fri,  4 Mar 2022 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646403105;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ojJkgZ/ddB58OQgN/NYh5ruO/krR/mrHhfqpKf+jmU=;
        b=EET0Oi3mZDuTG3j+s40BhVBQZ+bEF+SIeHgIW2YrY0bmvNDijaTpgCHAnFa0SUQ1dTc0YX
        jT3HpEOMKOugKDsL4mpsgcIjOkQyoz1yzX7hYMws5iAvsyiDYfoZh/Ct1Co+Xa1/WGYEfi
        8uJCnB5kNIT9V0rpAgl+IIn3gDMKYgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646403105;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ojJkgZ/ddB58OQgN/NYh5ruO/krR/mrHhfqpKf+jmU=;
        b=N19f4fz5Uaxf41D2zPH8itQq+SRuUA1DAa/1Eo1lwFlkd1uy3Y3Xev7GuMDwv9M0lnxVkw
        jXRAyXkMsRE3tLDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 10117A3B81;
        Fri,  4 Mar 2022 14:11:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20D08DA80E; Fri,  4 Mar 2022 15:07:51 +0100 (CET)
Date:   Fri, 4 Mar 2022 15:07:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data in
 device_list_add
Message-ID: <20220304140751.GZ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dongliang Mu <dzm91@hust.edu.cn>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220303144027.1981835-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303144027.1981835-1-dzm91@hust.edu.cn>
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

On Thu, Mar 03, 2022 at 10:40:27PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzbot reported a possible use-after-free in printing information
> in device_list_add.
> 
> Very similar with the bug fixed by commit 0697d9a61099 ("btrfs: don't
> access possibly stale fs_info data for printing duplicate device"),
> but this time the use occurs in btrfs_info_in_rcu.
> 
> ============================================================
> Call Trace:
>  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>  btrfs_printk+0x395/0x425 fs/btrfs/super.c:244
>  device_list_add.cold+0xd7/0x2ed fs/btrfs/volumes.c:957
>  btrfs_scan_one_device+0x4c7/0x5c0 fs/btrfs/volumes.c:1387
>  btrfs_control_ioctl+0x12a/0x2d0 fs/btrfs/super.c:2409
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> ============================================================
> 
> Fix this by modifying device->fs_info to NULL too.
> 
> Reported-and-tested-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Added to misc-next, thanks.
