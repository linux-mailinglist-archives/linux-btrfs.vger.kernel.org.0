Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DC2A2D97
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKBPFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 10:05:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:59450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKBPFI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 10:05:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 243CCAC53;
        Mon,  2 Nov 2020 15:05:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05EA4DA7D2; Mon,  2 Nov 2020 16:03:29 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:03:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix build warning due to u64 devided by u32 for
 32bit arch
Message-ID: <20201102150329.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201102073114.66750-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102073114.66750-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 03:31:14PM +0800, Qu Wenruo wrote:
> [BUG]
> When building the kernel with subpage preparation patches, 32bit arches
> will complain about the following linking error:
> 
>    ld: fs/btrfs/extent_io.o: in function `release_extent_buffer':
>    fs/btrfs/extent_io.c:5340: undefined reference to `__udivdi3'
> 
> [CAUSE]
> For 32bits, dividing u64 with u32 need to call div_u64(), not directly
> call u64 / u32.
> 
> [FIX]
> Instead of calling the div_u64() macros, here we introduce a helper,
> btrfs_sector_shift(), to calculate the sector shift, and we just do bit
> shift to avoid executing the expensive division instruction.

I've refreshed and pushed the series adding fs_info::sectorsize_bits so
you can use it for the subpage patches.
