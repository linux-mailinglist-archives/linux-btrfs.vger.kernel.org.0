Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D607B20782D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404392AbgFXP6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 11:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404176AbgFXP6o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 11:58:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84E97AD3A;
        Wed, 24 Jun 2020 15:58:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8134EDA79B; Wed, 24 Jun 2020 17:58:30 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:58:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Jiachen YANG <farseerfc@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size
 never exceed device size
Message-ID: <20200624155830.GW27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Jiachen YANG <farseerfc@gmail.com>
References: <20200624115527.855816-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624115527.855816-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 07:55:26PM +0800, Qu Wenruo wrote:
> [BUG]
> The following script could lead to corrupted btrfs fs after
> btrfs-convert:
> 
>   fallocate -l 1G test.img
>   mkfs.ext4 test.img
>   mount test.img $mnt
>   fallocate -l 200m $mnt/file1
>   fallocate -l 200m $mnt/file2
>   fallocate -l 200m $mnt/file3
>   fallocate -l 200m $mnt/file4
>   fallocate -l 205m $mnt/file1
>   fallocate -l 205m $mnt/file2
>   fallocate -l 205m $mnt/file3
>   fallocate -l 205m $mnt/file4
>   umount $mnt
>   btrfs-convert test.img
> 
> The result btrfs will have a device extent beyond its boundary:
>   pening filesystem to check...
>   Checking filesystem on test.img
>   UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
>   [1/7] checking root items
>   [2/7] checking extents
>   ERROR: dev extent devid 1 physical offset 993198080 len 85786624 is beyond device boundary 1073741824
>   ERROR: errors found in extent allocation tree or chunk allocation
>   [3/7] checking free space cache
>   [4/7] checking fs roots
>   [5/7] checking only csums items (without verifying data)
>   [6/7] checking root refs
>   [7/7] checking quota groups skipped (not enabled on this FS)
>   found 913960960 bytes used, error(s) found
>   total csum bytes: 891500
>   total tree bytes: 1064960
>   total fs tree bytes: 49152
>   total extent tree bytes: 16384
>   btree space waste bytes: 144885
>   file data blocks allocated: 2129063936
>    referenced 1772728320
> 
> [CAUSE]
> Btrfs-convert first collect all used blocks in the original fs, then
> slightly enlarge the used blocks range as new btrfs data chunks.
> 
> However the enlarge part has a problem, that it doesn't take the device
> boundary into consideration.
> 
> Thus it caused device extents and data chunks to go beyond device
> boundary.
> 
> [FIX]
> Just to extra check before inserting data chunks into
> btrfs_convert_context::data_chunk.
> 
> Reported-by: Jiachen YANG <farseerfc@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

With the minor tweaks, added to devel, thanks.
