Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9E30DB05
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBCNW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 08:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:48542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhBCNWz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 08:22:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1054AB048;
        Wed,  3 Feb 2021 13:22:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4B05DA6FC; Wed,  3 Feb 2021 14:20:22 +0100 (CET)
Date:   Wed, 3 Feb 2021 14:20:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210203132022.GC1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 26, 2021 at 04:33:44PM +0800, Qu Wenruo wrote:
> Qu Wenruo (18):
>   btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to
>     PAGE_START_WRITEBACK
>   btrfs: set UNMAPPED bit early in btrfs_clone_extent_buffer() for
>     subpage support
>   btrfs: introduce the skeleton of btrfs_subpage structure
>   btrfs: make attach_extent_buffer_page() handle subpage case
>   btrfs: make grab_extent_buffer_from_page() handle subpage case
>   btrfs: support subpage for extent buffer page release
>   btrfs: attach private to dummy extent buffer pages
>   btrfs: introduce helpers for subpage uptodate status
>   btrfs: introduce helpers for subpage error status
>   btrfs: support subpage in set/clear_extent_buffer_uptodate()
>   btrfs: support subpage in btrfs_clone_extent_buffer
>   btrfs: support subpage in try_release_extent_buffer()
>   btrfs: introduce read_extent_buffer_subpage()
>   btrfs: support subpage in endio_readpage_update_page_status()
>   btrfs: introduce subpage metadata validation check
>   btrfs: introduce btrfs_subpage for data inodes
>   btrfs: integrate page status update for data read path into
>     begin/end_page_read()
>   btrfs: allow RO mount of 4K sector size fs on 64K page system

This is now in misc-next, with the replaced patch 17 sent recently,
thanks.
