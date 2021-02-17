Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAAB31DE9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhBQRuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 12:50:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBQRuS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 12:50:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3F03B077;
        Wed, 17 Feb 2021 17:49:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60AC3DA7C5; Wed, 17 Feb 2021 18:47:40 +0100 (CET)
Date:   Wed, 17 Feb 2021 18:47:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Couple of misc patches
Message-ID: <20210217174740.GX1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210217131250.265859-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217131250.265859-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 03:12:46PM +0200, Nikolay Borisov wrote:
> Here are 4 patches which are independent of one another. The first 2 just
> change two more function to take btrfs_inode. Patch 3 just extends the usage of
> in_range which renders offset_in_entry redundant thus removing the function.
> Final patch just restructures btrfs_inc_block_group_ro to use a do{} while() loo
> rather than a label-based. This doesn't introduce extra nesting so I don't know
> why the label approach was chosen in the first place.
> 
> Nikolay Borisov (4):
>   btrfs: Make btrfs_replace_file_extents take btrfs_inode
>   btrfs: Make find_desired_extent take btrfs_inode
>   btrfs: Replace offset_in_entry with in_range
>   btrfs: Replace opencoded while loop with proper construct

Added to topic branch, will be in for-next once merge window is over.
Thanks.
