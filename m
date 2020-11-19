Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B22B9CB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKSVL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:11:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKSVLZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:11:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08A7FAFA7;
        Thu, 19 Nov 2020 21:11:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C4001DA701; Thu, 19 Nov 2020 22:09:37 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:09:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/24] btrfs: file-item: use nodesize to determine
 whether we need readahead for btrfs_lookup_bio_sums()
Message-ID: <20201119210937.GQ20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-17-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-17-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:41PM +0800, Qu Wenruo wrote:
> In btrfs_lookup_bio_sums() if the bio is pretty large, we want to
> readahead the csum tree.
> 
> However the threshold is an immediate number, (PAGE_SIZE * 8), from the
> initial btrfs merge.
> 
> The value itself is pretty hard to guess the meaning, especially when
> the immediate number is from the age where 4K sectorsize is the default
> and only CRC32 is supported.
> 
> For the most common btrfs setup, CRC32 csum and 4K sectorsize,
> it means just 32K read would kick readahead, while the csum itself is
> only 32 bytes in size.
> 
> Now let's be more reasonable by taking both csum size and node size into
> consideration.
> 
> If the csum size for the bio is larger than one leaf, then we kick the
> readahead.
> This means for current default btrfs, the threshold will be 16M.
> 
> This change should not change performance observably, thus this is mostly
> a readability enhancement.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next.
