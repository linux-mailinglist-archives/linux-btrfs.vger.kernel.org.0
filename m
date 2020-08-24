Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B42503BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgHXQuQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 12:50:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:32830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgHXQuE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 12:50:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A3A4AD4B;
        Mon, 24 Aug 2020 16:50:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 374E0DA730; Mon, 24 Aug 2020 18:48:55 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:48:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: consolidate seed mutex to sprout mutex
Message-ID: <20200824164854.GN2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 08:03:45AM +0800, Anand Jain wrote:
> In a sprouted btrfs, the seed's fs_devices are cloned and link-
> listed under the sprout's fs_devices. The fs_info::fs_devices
> points to the sprout::fs_devices and various critical operations
> like device-delete holds the top-level device_list_mutex
> sprout::fs_devices::device_list_mutex and _not_ the seed level
> mutex such as sprout::fs_devices::seed::fs_devices::device_list_mutex.
> 
> Also all related readers (except for two threads- reada and init_devices_late)
> hold the sprout::fs_devices::device_list_mutex too. And those two threads
> which are missing to hold the correct lock are being fixed here.
> 
> I take the approach to fix the read end instead of fixing the writer end
> which are not holding the seed level mutex because to keep things
> simple and there isn't much benefit burning extra CPU cycles in going 
> through the lock/unlock process as we traverse through the
> fs_devices::seed fs_devices (for example as in reada and init_devices_late
> threads).
> 
> The first two patches (1/7, 2/7) fixes the threads using the
> seed::device_list_mutex.
> 
> And rest of the patches ([3-7]/7) are cleanups and these patches
> are independent by themself.
> 
> These patchset has been tested with full xfstests btrfs test cases and
> found to have no new regressions.
> 
> Anand Jain (7):
>   btrfs: reada: use sprout device_list_mutex
>   btrfs: btrfs_init_devices_late: use sprout device_list_mutex
>   btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
>   btrfs: cleanup unused return in btrfs_close_devices
>   btrfs: cleanup btrfs_assign_next_active_device()
>   btrfs: cleanup unnecessary goto in open_seed_device
>   btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file
>     global declare

The series conflicts from patch 1 with the seed updates from Nik. The
branch is now in for-next and will be in misc-next soon.
