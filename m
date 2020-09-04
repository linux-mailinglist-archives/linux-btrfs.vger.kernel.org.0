Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DD25D74D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgIDL3p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 07:29:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgIDL31 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Sep 2020 07:29:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27C44AE41;
        Fri,  4 Sep 2020 11:29:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C4F1DA6E0; Fri,  4 Sep 2020 13:28:11 +0200 (CEST)
Date:   Fri, 4 Sep 2020 13:28:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/15] btrfs: initialize sysfs devid and device link for
 seed device
Message-ID: <20200904112810.GW28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <0b11ff81143ebfcaa1da26296ee12afcfe41dbb5.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b11ff81143ebfcaa1da26296ee12afcfe41dbb5.1599091832.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 08:57:42AM +0800, Anand Jain wrote:
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
> fs, we don't initialize the devid kobject yet. So this patch initializes
> the seed device devid kobject and the device link in the sysfs. This takes
> care of the Warning.

So this is the fix but needs 5 more cleanup patches and this makes it
too hard to backport. Is there an isolated patch that can be also
applied to current 5.9 queue.

The test leads to a crash so once the test lands in fstests all testing
machines without the fix will crash, so we need fix first, cleanup
later. There are also the seed list changes to this need to reflect that
somehow.
