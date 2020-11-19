Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00A92B9CB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKSVKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:10:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:35382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgKSVKz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:10:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18352ABF4;
        Thu, 19 Nov 2020 21:10:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9C9DDA701; Thu, 19 Nov 2020 22:09:07 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:09:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 06/24] btrfs: remove the phy_offset parameter for
 btrfs_validate_metadata_buffer()
Message-ID: <20201119210907.GN20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-7-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-7-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:31PM +0800, Qu Wenruo wrote:
> Parameter @phy_offset is the offset against the bio->bi_iter.bi_sector.
> @phy_offset is mostly for data io to lookup the csum in btrfs_io_bio.
> 
> But for metadata, it's completely useless as metadata stores their own
> csum in its btrfs_header.
> 
> Remove this useless parameter from btrfs_validate_metadata_buffer().
> 
> Just an extra note for parameters @start and @end, they are not utilized
> at all for current sectorsize == PAGE_SIZE case, as we can grab eb directly
> from page.
> 
> But those two parameters are very important for later subpage support,
> thus @start/@len are not touched here.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next.
