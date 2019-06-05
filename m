Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695C036096
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfFEP4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 11:56:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFEP4C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 11:56:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59932AEA1;
        Wed,  5 Jun 2019 15:56:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF64EDA843; Wed,  5 Jun 2019 17:56:49 +0200 (CEST)
Date:   Wed, 5 Jun 2019 17:56:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org, Su Yue <Damenly_Su@gmx.com>,
        Peter Hjalmarsson <kanelxake@gmail.com>
Subject: Re: [PATCH] btrfs-progs: fix invalid memory write in get_fs_info()
Message-ID: <20190605155648.GA9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org, Su Yue <Damenly_Su@gmx.com>,
        Peter Hjalmarsson <kanelxake@gmail.com>
References: <20190603012754.2527-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603012754.2527-1-Damenly_Su@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 09:27:54AM +0800, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> As the link reported, btrfs fi sh may crash while a device is removing.
> 
> valgrind reported:
> ======================================================================
> ...
> ==883== Invalid write of size 8
> ==883==    at 0x13C99A: get_device_info (in /usr/bin/btrfs)
> ==883==    by 0x13D715: get_fs_info (in /usr/bin/btrfs)
> ==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> ==883==  Address 0x4d8c7a0 is 0 bytes after a block of size 12,288 alloc'd
> ==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
> ==883==    by 0x13D861: get_fs_info (in /usr/bin/btrfs)
> ==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> ==883==
> ==883== Invalid write of size 8
> ==883==    at 0x13C99D: get_device_info (in /usr/bin/btrfs)
> ==883==    by 0x13D715: get_fs_info (in /usr/bin/btrfs)
> ==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> ==883==  Address 0x4d8c7a8 is 8 bytes after a block of size 12,288 alloc'd
> ==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
> ==883==    by 0x13D861: get_fs_info (in /usr/bin/btrfs)
> ==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> ==883==
> ==883== Syscall param ioctl(generic) points to unaddressable byte(s)
> ==883==    at 0x4CA9CBB: ioctl (in /usr/lib/libc-2.29.so)
> ==883==    by 0x13C9AB: get_device_info (in /usr/bin/btrfs)
> ==883==    by 0x13D715: get_fs_info (in /usr/bin/btrfs)
> ==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> ==883==  Address 0x4d8c7a0 is 0 bytes after a block of size 12,288 alloc'd
> ==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
> ==883==    by 0x13D861: get_fs_info (in /usr/bin/btrfs)
> ==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> ==883==
> --883-- VALGRIND INTERNAL ERROR: Valgrind received a signal 11 (SIGSEGV) - exiting
> --883-- si_code=1;  Faulting address: 0x284D8C7B8;  sp: 0x1002eb5e50
> 
> valgrind: the 'impossible' happened:
>    Killed by fatal signal
> 
> host stacktrace:
> ==883==    at 0x5805261C: get_bszB_as_is (m_mallocfree.c:303)
> ==883==    by 0x5805261C: get_bszB (m_mallocfree.c:315)
> ==883==    by 0x5805261C: vgPlain_arena_malloc (m_mallocfree.c:1799)
> ==883==    by 0x58005AD2: vgMemCheck_new_block (mc_malloc_wrappers.c:372)
> ==883==    by 0x58005AD2: vgMemCheck_malloc (mc_malloc_wrappers.c:407)
> ==883==    by 0x580A7373: do_client_request (scheduler.c:1925)
> ==883==    by 0x580A7373: vgPlain_scheduler (scheduler.c:1488)
> ==883==    by 0x580F57A0: thread_wrapper (syswrap-linux.c:103)
> ==883==    by 0x580F57A0: run_a_thread_NORETURN (syswrap-linux.c:156)
> 
> sched status:
>   running_tid=1
> 
> Thread 1: status = VgTs_Runnable (lwpid 883)
> ==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
> ==883==    by 0x1534AA: ??? (in /usr/bin/btrfs)
> ==883==    by 0x153C49: ??? (in /usr/bin/btrfs)
> ==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
> client stack range: [0x1FFEFFA000 0x1FFF000FFF] client SP: 0x1FFEFFDCE0
> valgrind stack range: [0x1002DB6000 0x1002EB5FFF] top usage: 7520 of 1048576
> 
> ======================================================================
> 
> The above log says that invalid write to allocated @di_args happened
> in get_device_info() called in get_fs_info().
> 
> The size of @di_args is allocated according by fi_args->num_devices.
> And fi_args->num_devices is *the number of dev_items in chunk_tree*.
> However, in the loop to get devices info, btrfs-progs calls ioctl
> BTRFS_IOC_DEV_INFO which just finds device in
> fs_info->fs_devices->devices.
> 
> Let's look at kernel side.
> In btrfs_rm_device(), btrfs_rm_dev_item() causes removal of
> related dev_items in chunk_tree. *Do something*.
> Then delete the device from device->fs_devices.
> 
> So the case is:
> Userspace					kernel
> 
> get_fs_info()					btrfs_rm_device()
> 						...
> 						  btrfs_rm_dev_item()
> 
>   determine fi_args->num_devices and
>     fi_args->max_id by seraching chunk_tree.
>   malloc()					  ...
>   Loop(Crashed): call get_device_info() by devid
>     from 1 to fi_args->max_id.
>     	   					  mutex_lock(&fs_devices->device_list_mutex);
> 						  list_del_rcu(&device->dev_list);
> 					          ...
> 
> In the loop of get_device_info(), get_device_info() still can get info
> of the removing device since it's still in fs_info->fs_devices->devices.
> Then the iterator value @ndev increaments causes invalid access out of
> bounds.
> 
> Solved it by adding the check of @ndev while looping.
> 
> Reported-by: Peter Hjalmarsson <kanelxake@gmail.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1711787
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Applied, thanks.
