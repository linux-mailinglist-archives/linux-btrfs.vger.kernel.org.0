Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DCF1A852
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2019 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfEKPwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 May 2019 11:52:11 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:44147 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfEKPwL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 May 2019 11:52:11 -0400
X-Greylist: delayed 1702 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 May 2019 11:52:10 EDT
Received: from [2001:8b0:162c:2:b531:9106:c59e:e299]
        by smtp.steev.me.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        id 1hPTqk-0006wc-LF; Sat, 11 May 2019 16:23:46 +0100
Subject: Re: [PATCH 0/3] readmirror feature
References: <20190425115946.2550-1-anand.jain@oracle.com>
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Message-ID: <2c4001e0-e264-3f02-cfb3-41befe189207@steev.me.uk>
Date:   Sat, 11 May 2019 16:24:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425115946.2550-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tested-by: Steven Davies <btrfs-list@steev.me.uk>

Series (inc. btrfs-progs changes) tested working as expected against 
current btrfs-devel and btrfs-progs/devel.

Am I correct in thinking that if more than one devid is assigned as a 
readmirror, the lowest available devid will be preferred?

Also I think it would be nice to be able to set this property at mkfs time.

I'd love to see this feature make it upstream.

-- 
Steven Davies

On 25/04/2019 12:59, Anand Jain wrote:
> These patches are tested to be working fine.
> 
> Function call chain  __btrfs_map_block()->find_live_mirror() uses
> thread pid to determine the %mirror_num when the mirror_num=0.
> 
> This patch introduces a framework so that we can add policies to determine
> the %mirror_num. And adds the devid as the readmirror policy.
> 
> The property is stored as an extented attributes of root inode
> (BTRFS_FS_TREE_OBJECTID).
> User provided devid list is validated against the fs_devices::dev_list.
> 
>   For example:
>     Usage:
>       btrfs property set <mnt> readmirror devid<n>[,<m>...]
>       btrfs property set <mnt> readmirror ""
> 
>     mkfs.btrfs -fq -draid1 -mraid1 /dev/sd[b-d] && mount /dev/sdb /btrfs
>     btrfs prop set /btrfs readmirror devid1,2
>     btrfs prop get /btrfs readmirror
>      readmirror=devid1,2
>     getfattr -n btrfs.readmirror --absolute-names /btrfs
>      btrfs.readmirror="devid1,2"
>     btrfs prop set /btrfs readmirror ""
>     getfattr -n btrfs.readmirror --absolute-names /btrfs
>      /btrfs: btrfs.readmirror: No such attribute
>     btrfs prop get /btrfs readmirror
> 
> RFC->v1:
>    Drops pid as one of the readmirror policy choices and as usual remains
>    as default. And when the devid is reset the readmirror policy falls back
>    to pid.
>    Drops the mount -o readmirror idea, it can be added at a later point of
>    time.
>    Property now accepts more than 1 devid as readmirror device. As shown
>    in the example above.
> 
> Anand Jain (3):
>    btrfs: add inode pointer to prop_handler::validate()
>    btrfs: add readmirror property framework
>    btrfs: add readmirror devid property
> 
>   fs/btrfs/props.c   | 120 +++++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/props.h   |   4 +-
>   fs/btrfs/volumes.c |  25 +++++++++-
>   fs/btrfs/volumes.h |   8 +++
>   fs/btrfs/xattr.c   |   2 +-
>   5 files changed, 150 insertions(+), 9 deletions(-)
> 
> Anand Jain (2):
>    btrfs-progs: add helper to create xattr name
>    btrfs-progs: add readmirror policy
> 
>   props.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 68 insertions(+), 7 deletions(-)
> 
