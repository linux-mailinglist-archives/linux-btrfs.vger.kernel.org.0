Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A73FD014
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 01:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbhIAAAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 20:00:32 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:38466 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbhIAAAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 20:00:32 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 3DE3C1E0065E;
        Wed,  1 Sep 2021 02:59:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1630454375; bh=oLviwiQroKk0Sz39+DL3kzV8yCJDZGM+mWumdlO2pU4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=S2lBOFiiOKQrmKVd70B3qqhkkWe6iDQKkmhvWIl4aM0z7jKtbOzpP7rdXUW0hwxmW
         tGIswgCnAygiSgWlgr51y1+iM67ZvU//PQymio6BFC6nE9o1By0j+38ctbwoD+zIq0
         kzvF86PUBSw0EUCmCljQsxT7O7WSuOCCRbnZ/aps=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 3493A1E00655;
        Wed,  1 Sep 2021 02:59:35 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id GE7JoslmvzPo; Wed,  1 Sep 2021 02:59:35 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id D022C1E0064D;
        Wed,  1 Sep 2021 02:59:34 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 7D1341BE00F0;
        Wed,  1 Sep 2021 02:59:33 +0300 (EEST)
References: <cover.1629780501.git.anand.jain@oracle.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH V5 0/4] btrf_show_devname related fixes
Date:   Wed, 01 Sep 2021 07:58:29 +0800
In-reply-to: <cover.1629780501.git.anand.jain@oracle.com>
Message-ID: <sfypp3mn.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWenZQszpjRPWfPi+Pm+2AE773b5LV36cwhSEAzE7mEFM2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 24 Aug 2021 at 13:05, Anand Jain <anand.jain@oracle.com> 
wrote:

> v5: Patches reorged.
>  Patch (btrfs: consolidate device_list_mutex in prepare_sprout 
>  to its parent)
>  moved into a new set as it has a dependency on an older patch 
>  in the ML.
>  Change log updated.
> v4: Fix unrelated changes
> v3: Add missing rcu_lock in show_devname
> v2: Use latest_dev so that device path is also shown
>
> Su Yue reported [1] warn() as a result of a race between the 
> following two
> threads,
>   Thread-A: function stack leading to btrfs_prepare_sprout()
> and
>   Thread-B: function stack leading to btrfs_show_devname()
>
> [1] 
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210818041944.5793-1-l@damenly.su/
>
> While btrfs_prepare_sprout() moves the fs_devices::devices into
> fs_devices::seed_list, the btrfs_show_devname searched for the 
> devices
> and found none, leading to the warning as in [1] (above).
>
> The btrfs_prepare_sprout() uses device_list_mutex however
> btrfs_show_devname() don't and, the device_list_mutex in
> btrfs_show_devname() was removed by the patch 88c14590cdd6
> (btrfs: use RCU in btrfs_show_devname for device list traversal)
> for the perforamcne reasons.
>
> This series does not intend to reintroduce the device_list_mutex 
> in
> btrfs_prepare_sprout() but instead saves the pointer to 
> btrfs_devices
> in the fs_devices::latest_dev so that btrfs_show_devname() can 
> use it.
>
> patch 1 converts fs_devices::latest_bdev type from struct 
> block_device to
>         struct btrfs_device and renames it to latest_dev
> patch 2 btrfs_show_devname() uses the 
> fs_devices::latest_dev::name to show
>         the device path in the /proc/self/mounts
> patch 3 fixes a stale latest_dev pointer after the sprout 
> operation
>

For patch [123], you can add

Tested-by: Su Yue <l@damenly.su>

Thanks.
--
Su
> patch 4 fixes an old comment about the function 
> btrfs_show_devname()
>
> Anand Jain (4):
>   btrfs: convert latest_bdev type to struct btrfs_device and 
>   rename
>   btrfs: use latest_dev in btrfs_show_devname
>   btrfs: update latest_dev when we sprout
>   btrfs: fix comment about the btrfs_show_devname
>
>  fs/btrfs/disk-io.c   |  6 +++---
>  fs/btrfs/extent_io.c |  2 +-
>  fs/btrfs/inode.c     |  2 +-
>  fs/btrfs/super.c     | 26 ++++----------------------
>  fs/btrfs/volumes.c   | 17 ++++++++---------
>  fs/btrfs/volumes.h   |  2 +-
>  6 files changed, 18 insertions(+), 37 deletions(-)
