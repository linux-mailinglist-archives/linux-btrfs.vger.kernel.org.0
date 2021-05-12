Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3016637BF33
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELOFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 10:05:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhELOFO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 10:05:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E51C9B03A;
        Wed, 12 May 2021 14:04:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C840DA7B0; Wed, 12 May 2021 16:01:35 +0200 (CEST)
Date:   Wed, 12 May 2021 16:01:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid
 succeeded to write superblock
Message-ID: <20210512140135.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210511042501.900731-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511042501.900731-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 12:25:01PM +0800, Su Yue wrote:
> Commit 8ef9313cf298 ("btrfs-progs: zoned: implement log-structured
> superblock") changed to write BTRFS_SUPER_INFO_SIZE bytes to device.
> The before num of bytes to be written is sectorsize.
> It causes mkfs.btrfs failed on my 16k pagesize kvm:

What architecture is that?

> 
>   $ /usr/bin/mkfs.btrfs -s 16k -f -mraid0 /dev/vdb2 /dev/vdb3
>   btrfs-progs v5.12
>   See http://btrfs.wiki.kernel.org for more information.
> 
>   ERROR: superblock magic doesn't match
>   ERROR: superblock magic doesn't match
>   common/device-scan.c:195: btrfs_add_to_fsid: BUG_ON `ret != sectorsize`
>   triggered, value 1
>   /usr/bin/mkfs.btrfs(btrfs_add_to_fsid+0x274)[0xaaab4fe8a5fc]
>   /usr/bin/mkfs.btrfs(main+0x1188)[0xaaab4fe4dc8c]
>   /usr/lib/libc.so.6(__libc_start_main+0xe8)[0xffff7223c538]
>   /usr/bin/mkfs.btrfs(+0xc558)[0xaaab4fe4c558]
> 
>   [1]    225842 abort (core dumped)  /usr/bin/mkfs.btrfs -s 16k -f -mraid0
>   /dev/vdb2 /dev/vdb3
> 
> btrfs_add_to_fsid() now always calls sbwrite() to write
> BTRFS_SUPER_INFO_SIZE bytes to device, so change condition of
> the BUG_ON().
> Also add comments for sbread() and sbwrite().
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to devel, thanks.
