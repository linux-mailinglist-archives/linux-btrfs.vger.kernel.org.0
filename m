Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2011432C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 16:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfLEPAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 10:00:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729187AbfLEPA3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 10:00:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E8C1B19E;
        Thu,  5 Dec 2019 15:00:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5518DA733; Thu,  5 Dec 2019 16:00:22 +0100 (CET)
Date:   Thu, 5 Dec 2019 16:00:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
Message-ID: <20191205150022.GR2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 07:27:02PM +0800, Anand Jain wrote:
> Anand Jain (4):
>   btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
>   btrfs: sysfs, add UUID/devinfo kobject
>   btrfs: sysfs, rename device_link add,remove functions
>   btrfs: sysfs, add devid/dev_state kobject and attribute

So we can start adding things to devinfo, I did a quick test how the
sysfs directory looks like, the base structure seems ok.

Unlike other sources for sysfs file data (like superblock), the devices
can appear and disappear during the lifetime of the filesystem and as
pointed out in the patches, some synchronization is needed.

But it could be more tricky. Reading from the sysfs files should not
block normal operation (no device_list_mutex) but also must not lead to
use-after-free in case the device gets deleted.

I haven't found a simple locking scheme that would avoid accessing a
freed device structure, the sysfs callback can happen at any time and
the structure can be freed already.

So this means that btrfs_sysfs_dev_state_show cannot access it directly
(using offsetof(kobj, ...)). The safe (but not necessarily the best) way
I have so far is to track the device kobjects in the superblock and add
own lock for accessing this structure.

This avoids increasing contention of device_list_mutex, each sysfs
callback needs to take the lock first, lookup the device and print the
value if it's found. Otherwise we know the device is gone.

The lock is rwlock_t, sysfs callbacks take read-side, device deletion
takes write possibly outside of the device_list_mutex before the device
is actually going to be deleted. This relies on fairness of the lock so
the write will happen eventually (even if there are many readers).
