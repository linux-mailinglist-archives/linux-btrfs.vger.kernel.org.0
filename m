Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69AAFDC68
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKOLkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 06:40:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:52832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbfKOLkI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 06:40:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7626ACB4;
        Fri, 15 Nov 2019 11:40:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4616DA783; Fri, 15 Nov 2019 12:40:09 +0100 (CET)
Date:   Fri, 15 Nov 2019 12:40:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Pernegger <pernegger@gmail.com>
Subject: Re: [PATCH 2/2] btrfs: rescue/zero-log: Manually write all supers to
 handle extent tree error more gracefully
Message-ID: <20191115114009.GQ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Christian Pernegger <pernegger@gmail.com>
References: <20191111075059.30352-1-wqu@suse.com>
 <20191111075059.30352-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111075059.30352-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 03:50:59PM +0800, Qu Wenruo wrote:
> [BUG]
> Even "btrfs rescue zero-log" only reset btrfs_super_block::log_root and
> btrfs_super_block::log_root_level, we still use trasction to write all
> super blocks for all devices.
> 
> This means we can't handle things like corrupted extent tree:
> 
>   checksum verify failed on 2172747776 found 000000B6 wanted 00000000
>   checksum verify failed on 2172747776 found 000000B6 wanted 00000000
>   bad tree block 2172747776, bytenr mismatch, want=2172747776, have=0
>   WARNING: could not setup extent tree, skipping it
>   Clearing log on /dev/nvme/btrfs, previous log_root 0, level 0
>   ERROR: Corrupted fs, no valid METADATA block group found
>   ERROR: attempt to start transaction over already running one
> 
> [CAUSE]
> Because we have extra check in transaction code to ensure we have valid
> METADATA block groups.
> 
> In fact we don't really need transaction at all.
> 
> [FIX]
> Instead of commit transaction, we can just call write_all_supers()
> manually, so we can still handle multi-device fs while avoid above
> error.
> 
> Also, add OPEN_CTREE_NO_BLOCK_GROUPS open ctree flag to make it more
> robust.
> 
> Reported-by: Christian Pernegger <pernegger@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, v1 has been replaced.
