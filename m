Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36D726FC8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIRMct (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 08:32:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRMcs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 08:32:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F36C8B2BC;
        Fri, 18 Sep 2020 12:33:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98324DA6E0; Fri, 18 Sep 2020 14:31:33 +0200 (CEST)
Date:   Fri, 18 Sep 2020 14:31:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in close_fs_devices (2)
Message-ID: <20200918123133.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000008fbadb05af94b61e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008fbadb05af94b61e@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:22:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15bf1621900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166

1152 static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
1153 {
1154         struct btrfs_device *device, *tmp;
1155
1156         if (--fs_devices->opened > 0)
1157                 return 0;
1158
1159         mutex_lock(&fs_devices->device_list_mutex);
1160         list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
1161                 btrfs_close_one_device(device);
1162         }
1163         mutex_unlock(&fs_devices->device_list_mutex);
1164
1165         WARN_ON(fs_devices->open_devices);
1166         WARN_ON(fs_devices->rw_devices);

1167         fs_devices->opened = 0;
1168         fs_devices->seeding = false;
1169
1170         return 0;
1171 }

It's the 2nd warning, rw_devices > 0 .

> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0

5.9-rc4, we've had some changes around device locking but no idea which
one it could be.
