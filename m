Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A44CD595
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiCDNzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 08:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiCDNzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 08:55:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3990515B99D;
        Fri,  4 Mar 2022 05:54:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DFB801F386;
        Fri,  4 Mar 2022 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646402082;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnx66aWeykrzI2XBQv7Kx5jZUN33fVmg1ARGMWpelfY=;
        b=iTrWdsmDK1S4NboUAhMqnFvdWBSELXhlHkF3jJwhTAwb5Fs/fv1AOCRgy8sRX9xcNht9no
        grpDBosjamSuehPsL8JiGi0KP4z0CDSIKozde2a54j1NGPiSb7vRc7XhfYwDaKLgwF/vGv
        VtEaZMz7iBHpawYosGBDw1/azw99eNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646402082;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnx66aWeykrzI2XBQv7Kx5jZUN33fVmg1ARGMWpelfY=;
        b=FtJtQkec5uCj7/Iheh2GsT6By6GvhuKne8SEjp38JlclBPYOOEDtaCrJ1fwodYNWsSM5Pi
        /kjQxcQJ2yO1B2DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 93DEDA3B8F;
        Fri,  4 Mar 2022 13:54:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3123DA80E; Fri,  4 Mar 2022 14:50:49 +0100 (CET)
Date:   Fri, 4 Mar 2022 14:50:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data in
 device_list_add
Message-ID: <20220304135049.GY12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <20220303144027.1981835-1-dzm91@hust.edu.cn>
 <20220303182431.GW12643@suse.cz>
 <e3f0ab62-3d1f-a316-2d7b-a0b791120f87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f0ab62-3d1f-a316-2d7b-a0b791120f87@oracle.com>
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

On Fri, Mar 04, 2022 at 07:53:27AM +0800, Anand Jain wrote:
> On 04/03/2022 02:24, David Sterba wrote:
> > On Thu, Mar 03, 2022 at 10:40:27PM +0800, Dongliang Mu wrote:
> >>
> >> Fix this by modifying device->fs_info to NULL too.
> >>
> >> Reported-and-tested-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
> >> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >> ---
> >>   fs/btrfs/volumes.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index b07d382d53a8..c1325bdae9a1 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -954,7 +954,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >>   						  task_pid_nr(current));
> >>   				return ERR_PTR(-EEXIST);
> >>   			}
> >> -			btrfs_info_in_rcu(device->fs_info,
> >> +			btrfs_info_in_rcu(NULL,
> > 
> > A few lines above this is also NULL and was fixed by 0697d9a61099
> > ("btrfs: don't access possibly stale fs_info data for printing duplicate
> > device"), so yeah we probably need the same here.
> 
> So it appears that device->fs_info was garbage instead of NULL OR
> fs_info->sb was NULL?

I think it's a warning that something could happen, in this case
potential garbage value of fs_info.

> Because we always had a check if fs_info is null in btrfs_printk()
> further the commit a0f6d924cada ("btrfs: remove stub device info from
> messages when we have no fs_info") made it better.

Yeah, that's removing a potential crash but still the NULL value could
come from a freed memory. Seems taht we can't rely on fs_info in
device_list_add at all and passing NULL is the only safe way.
