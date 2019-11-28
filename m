Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC02710CBEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1PkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 10:40:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:57036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfK1PkG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 10:40:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8B92B496;
        Thu, 28 Nov 2019 15:40:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D241DA971; Thu, 28 Nov 2019 16:40:02 +0100 (CET)
Date:   Thu, 28 Nov 2019 16:40:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relocation: Output current relocation stage at
 btrfs_relocate_block_group()
Message-ID: <20191128154002.GH2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191128075437.10621-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128075437.10621-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 28, 2019 at 03:54:36PM +0800, Qu Wenruo wrote:
> There are several reports of hanging relocation, populating the dmesg
> with things like:
>   BTRFS info (device dm-5): found 1 extents
> 
> The investigation is still on going, but will never hurt to output a
> little more info.
> 
> This patch will also output the current relocation stage, making that
> output something like:
> 
>   BTRFS info (device dm-5): balance: start -d -m -s
>   BTRFS info (device dm-5): relocating block group 30408704 flags metadata|dup
>   BTRFS info (device dm-5): found 2 extents at MOVE_DATA_EXTENT stage
>   BTRFS info (device dm-5): relocating block group 22020096 flags system|dup
>   BTRFS info (device dm-5): found 1 extents at MOVE_DATA_EXTENT stage
>   BTRFS info (device dm-5): relocating block group 13631488 flags data
>   BTRFS info (device dm-5): found 1 extents at MOVE_DATA_EXTENT stage
>   BTRFS info (device dm-5): found 1 extents at UPDATE_DATA_PTRS stage
>   BTRFS info (device dm-5): balance: ended with status: 0
> 
> The string "MOVE_DATA_EXTENT" and "UPDATE_DATA_PTRS" is mostly from the
> macro MOVE_DATA_EXTENTS and UPDATE_DATA_PTRS, but the 'S' from
> MOVE_DATA_EXTENTS is removed in the output string to make the alignment
> better.
> 
> This patch will not increase the number of lines, but with extra info
> for us to debug the reported problem.

Nice. I'd suggest to make it more user friendly

	relocation: found 111 extents, stage: move data blocks
	relocation: found 111 extents, stage: update data pointers

The identifier can be understood what it means but it's IMHO not
important to copy it to the message verbatim.
