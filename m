Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C84CC535
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiCCS3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 13:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiCCS3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 13:29:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B894EB7170;
        Thu,  3 Mar 2022 10:28:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 53D1D1F386;
        Thu,  3 Mar 2022 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646332104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aeAcL7K8crpzfQmCbSBQTf9/hIKSAhKoB1dP+78DkD0=;
        b=L0KF70U1FkNPIc9RgtYSNOD6izyZjG1efUMBcPmBQgnUGsfDjPO5Wtw/TppWl8QR0qpO4r
        82xUekSzfB/BXYyXgkj8DtKsWQWjZbB0ZgqF+AsGpzVarMGdD5H+kYaWK+V1B8oOeq/byi
        H2Oc8yQrd6nS95pShptRpw3weQ/xC3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646332104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aeAcL7K8crpzfQmCbSBQTf9/hIKSAhKoB1dP+78DkD0=;
        b=ZDjUIe0MyTkr6wyYci+OIGWdnRasnSCiBjGhUiIhxbcCwraGrzdNP+TYgeVDSgxrDIdvOv
        gL8ktkRaAhuB6GDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16084A3B81;
        Thu,  3 Mar 2022 18:28:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 84767DA80E; Thu,  3 Mar 2022 19:24:31 +0100 (CET)
Date:   Thu, 3 Mar 2022 19:24:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data in
 device_list_add
Message-ID: <20220303182431.GW12643@suse.cz>
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
> ---
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b07d382d53a8..c1325bdae9a1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -954,7 +954,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  						  task_pid_nr(current));
>  				return ERR_PTR(-EEXIST);
>  			}
> -			btrfs_info_in_rcu(device->fs_info,
> +			btrfs_info_in_rcu(NULL,

A few lines above this is also NULL and was fixed by 0697d9a61099
("btrfs: don't access possibly stale fs_info data for printing duplicate
device"), so yeah we probably need the same here.
