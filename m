Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFB261D55
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgIHTfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 15:35:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730984AbgIHP5a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 11:57:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E505BAC2F;
        Tue,  8 Sep 2020 15:57:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4986BDA781; Tue,  8 Sep 2020 17:55:45 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:55:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, nborisov@suse.com
Subject: Re: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Message-ID: <20200908155545.GB18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com,
        nborisov@suse.com
References: <cover.1599234146.git.anand.jain@oracle.com>
 <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 05, 2020 at 01:34:21AM +0800, Anand Jain wrote:
> The following test case leads to null kobject-being-freed error.
> 
>  mount seed /mnt
>  add sprout to /mnt
>  umount /mnt
>  mount sprout to /mnt
>  delete seed
> 
>  kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
>  WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>  RIP: 0010:kobject_put+0x80/0x350
>  ::
>  Call Trace:
>  btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>  btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>  btrfs_ioctl+0x206c/0x22a0 [btrfs]
>  ksys_ioctl+0xe2/0x140
>  __x64_sys_ioctl+0x1e/0x29
>  do_syscall_64+0x96/0x150
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f4047c6288b
>  ::
> 
> This is because, at the end of the seed device-delete, we try to remove
> the seed's devid sysfs entry. But for the seed devices under the sprout
> fs, we don't initialize the devid kobject yet. So add a kobject state
> check, which takes care of the Warning.
> 
> Fixes: 668e48af btrfs: sysfs, add devid/dev_state kobject and device attributes

Please note that the correct format of the Fixes: tag is

Fixes: 668e48af7a94 ("btrfs: sysfs, add devid/dev_state kobject and device attributes")

> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
