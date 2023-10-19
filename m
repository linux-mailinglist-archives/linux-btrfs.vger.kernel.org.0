Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2C7D0142
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjJSSUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjJSSUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 14:20:35 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 11:20:32 PDT
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B511D
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 11:20:32 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.171.3])
        by smtp-18.iol.local with ESMTPA
        id tXcHqABdiBe2ftXcHqVCDI; Thu, 19 Oct 2023 20:19:29 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1697739569; bh=vke+fIxxN6kIiUJATCE8VTJ4jXxnXFF3ecvOuPEuHrI=;
        h=From;
        b=LS4Y3wNrhTbxwX3BwBgqDyNr5P1WAunO3FyduNxK73Y2/jKcsbFJW1MR7PHdyCZrT
         Elt7o/GsqAlZrJ7hLcqiGgeVyaS9bdCeIG5rMBBFLirv9Q+hG3PbfJuaQVsnvL+hLp
         Msxc1xEW10u+uKm2xQu1LDSltRLdw3ePZPWv/MYkEP2Yu7X553aWUMDwc8iW0omF4+
         P3phpGXyr8tyOoi97+8AuhclzVMEriU7DqthXgzfYHSQ8677kRamYQeaK7+rquTxII
         gBiEwfHQleipJeHob3TDmRluBfYsecTvQLEqW7OSfDs5SBzuVvWnYx2tPAGU0aPFAL
         em08BQtBhhjIA==
X-CNFS-Analysis: v=2.4 cv=HJQFVKhv c=1 sm=1 tr=0 ts=65317331 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=Asz2sHXNxNX3RrL5zgEA:9 a=QEXdDO2ut3YA:10
Message-ID: <7f605a3d-9386-42e3-affc-a3120646f238@libero.it>
Date:   Thu, 19 Oct 2023 20:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/6] btrfs-progs: mkfs: introduce an experimental --subvol
 option
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1697430866.git.wqu@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <cover.1697430866.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJoghQ9PqyXEyN3VFWRbMRIhpc/ZbHipFytO+dJP35rrt6PTECxsoFwI7agAPjM1NW0JLVn0jVjZwRNdA/mbrxo+kER3KugcFtOqJlTLQ9hpsgJOB6YW
 WxhK1LT7qEYtHrwGYsX+sfVqooZQ7DhzCBSOqHqqhqBUbA9k/2YmoniHZBuz9scrNFMWWBjNLQDRPE3HFoaD8NwkFhkginKwnvI+PWm47TuKlB/XtABjEylC
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,
On 16/10/2023 06.38, Qu Wenruo wrote:
> Issue #42 (good number by the way) is suggesting a very useful feature
> for rootfs image creation.
> 
> Currently we only support "mkfs.btrfs --rootdir" to fill the fs tree
> with target directory, but there has no btrfs specific features
> involved.
> 
> If we can create certain paths as subvolumes, not pure directories, it
> can be very useful to create the whole btrfs image just by "mkfs.btrfs"
> 
> This series is the first step torwards this idea.
> 
> Now we have a new experimental option "--subvol" for mkfs.btrfs, but
> with the following limits:


I have a suggestion and an enhancement request:
- why not use --mk-subvol? to me it seems more clear that a subvolume will be created
- add another option like --mk-default-subvolume that:
	- create a subvolume
	- make it the default.

The use case is the following: in btrfs it is easy make a snapshot, and move/rename/delete
subvolumes and snapshot. The only exception is the subvolid=5 (or /). You cannot delete it.
So if you want to do a snapshot of / and then rollback to this snapshot, it is complicated
because you cannot remove the original subvolume.

Starting from a subvolume different from subvolid=5 makes this easier.
  
> 
> - No co-operation with --rootdir
>    This requires --rootdir to have extra handling for any existing
>    inodes.
>    (Currently --rootdir assumes the fs tree is completely empty)
> 
> - No multiple --subvol options supports
>    This requires us to collect and sort all the paths and start creating
>    subvolumes from the shortest path.
>    Furthermore this requires us to create subvolume under another
>    subvolume.
> 
> Each limit would need a new series of patches to address, but this
> series would already provide a working but not-that-useful
> implementation of "--subvol" option, along with a basic test case for
> it.
> 
> Qu Wenruo (6):
>    btrfs-progs: enhance btrfs_mkdir() function
>    btrfs-progs: enhance and rename btrfs_mksubvol() function
>    btrfs-progs: enhance btrfs_create_root() function
>    btrfs-progs: use a unified btrfs_make_subvol() implementation
>    btrfs-progs: mkfs: introduce experimental --subvol option
>    btrfs-progs: mkfs-tests: introduce a test case to verify --subvol
>      option
> 
>   convert/main.c                             |  60 ++------
>   kernel-shared/ctree.c                      | 106 ++++++--------
>   kernel-shared/ctree.h                      |  12 +-
>   kernel-shared/inode.c                      | 129 ++++++++++++-----
>   kernel-shared/root-tree.c                  |  86 +++++++++++
>   mkfs/common.c                              |  39 -----
>   mkfs/common.h                              |   2 -
>   mkfs/main.c                                | 103 ++++----------
>   mkfs/rootdir.c                             | 157 +++++++++++++++++++++
>   mkfs/rootdir.h                             |   1 +
>   tests/mkfs-tests/031-subvol-option/test.sh |  39 +++++
>   tune/convert-bgt.c                         |   3 +-
>   tune/quota.c                               |   2 +-
>   13 files changed, 473 insertions(+), 266 deletions(-)
>   create mode 100755 tests/mkfs-tests/031-subvol-option/test.sh
> 
> --
> 2.42.0
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

