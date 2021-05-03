Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00372371669
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhECOHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 10:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232784AbhECOHP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 10:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82580B08C;
        Mon,  3 May 2021 14:06:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2910DDA783; Mon,  3 May 2021 16:03:56 +0200 (CEST)
Date:   Mon, 3 May 2021 16:03:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add error handling in btrfs_fileattr_set for
 transaction handle
Message-ID: <20210503140355.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-btrfs@vger.kernel.org
References: <f24fb4c9f8613fe76f5a7201752152637647f8ba.1619797915.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f24fb4c9f8613fe76f5a7201752152637647f8ba.1619797915.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 09:30:55PM +0530, Ritesh Harjani wrote:
> Add error handling in btrfs_fileattr_set in case of an error while
> starting a transaction. This fixes btrfs/232 which otherwise used to
> fail with below signature on Power.
> 
> btrfs/232 [ 1119.474650] run fstests btrfs/232 at 2021-04-21 02:21:22
> <...>
> [ 1366.638585] BUG: Unable to handle kernel data access on read at 0xffffffffffffff86
> [ 1366.638768] Faulting instruction address: 0xc0000000009a5c88
> cpu 0x0: Vector: 380 (Data SLB Access) at [c000000014f177b0]
>     pc: c0000000009a5c88: btrfs_update_root_times+0x58/0xc0
>     lr: c0000000009a5c84: btrfs_update_root_times+0x54/0xc0
>     <...>
>     pid   = 24881, comm = fsstress
> 	 btrfs_update_inode+0xa0/0x140
> 	 btrfs_fileattr_set+0x5d0/0x6f0
> 	 vfs_fileattr_set+0x2a8/0x390
> 	 do_vfs_ioctl+0x1290/0x1ac0
> 	 sys_ioctl+0x6c/0x120
> 	 system_call_exception+0x3d4/0x410
> 	 system_call_common+0xec/0x278
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks.  Added to queue, once misc-next gets synced with master (post
rc1) it'll be added there, until then it'll be in a separate branch
merged to linux-next.
