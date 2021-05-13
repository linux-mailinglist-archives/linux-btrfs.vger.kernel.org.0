Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41293800B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhEMXK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:10:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMXK2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:10:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89729AEAA;
        Thu, 13 May 2021 23:09:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B612DA8EB; Fri, 14 May 2021 01:06:46 +0200 (CEST)
Date:   Fri, 14 May 2021 01:06:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
Message-ID: <20210513230646.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-8-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:14AM +0800, Qu Wenruo wrote:
> +	inode = BTRFS_I(page->mapping->host);

This is an unrelated comment to the subpage patchset itself, but I've
seen so many page->mapping->host that I think we should add helpers
wrapping all that, eg. page_to_fs_info or page_to_inode or
bio_to_fs_info etc.

> -	TP_printk_btrfs("root=%llu(%s) ino=%llu page_index=%lu start=%llu "
> +	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu "

I don't think the page index is useful, so it's fine to remove it IMO.
