Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE33E1104E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfLCTPi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 14:15:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:34096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLCTPi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 14:15:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C30F5B2B38;
        Tue,  3 Dec 2019 19:15:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27479DA7D9; Tue,  3 Dec 2019 20:15:32 +0100 (CET)
Date:   Tue, 3 Dec 2019 20:15:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: relocation: Output current relocation stage at
 btrfs_relocate_block_group()
Message-ID: <20191203191532.GY2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191129044059.46353-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129044059.46353-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 29, 2019 at 12:40:59PM +0800, Qu Wenruo wrote:
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
>   BTRFS info (device dm-5): found 2 extents, stage: move data extents
>   BTRFS info (device dm-5): relocating block group 22020096 flags system|dup
>   BTRFS info (device dm-5): found 1 extents, stage: move data extents
>   BTRFS info (device dm-5): relocating block group 13631488 flags data
>   BTRFS info (device dm-5): found 1 extents, stage: move data extents
>   BTRFS info (device dm-5): found 1 extents, stage: update data pointers
>   BTRFS info (device dm-5): balance: ended with status: 0
> 
> This patch will not increase the number of lines, but with extra info
> for us to debug the reported problem.
> (Although it's very likely the bug is sticking at "update data pointers"
> stage, even without the patch)
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to msic-next, thanks.
