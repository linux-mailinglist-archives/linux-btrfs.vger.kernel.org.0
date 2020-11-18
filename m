Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D682B8503
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgKRTkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:40:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:49696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRTkF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:40:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A372BE05;
        Wed, 18 Nov 2020 19:40:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C08E3DA701; Wed, 18 Nov 2020 20:38:18 +0100 (CET)
Date:   Wed, 18 Nov 2020 20:38:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 13/24] btrfs: handle sectorsize < PAGE_SIZE case for
 extent buffer accessors
Message-ID: <20201118193818.GC20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-14-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-14-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:38PM +0800, Qu Wenruo wrote:
> This patch introduces two helpers to do these:
> - get_eb_page_index()
>   This is to calculate the index to access extent_buffer::pages.
>   It's just a simple wrapper around "start >> PAGE_SHIFT".
> 
>   For sectorsize == PAGE_SIZE case, nothing is changed.
>   For sectorsize < PAGE_SIZE case, we always get index as 0, and
>   the existing page shift works also fine.
> 
> - get_eb_page_offset()

This is too confusing, it does not return offset of the page but offset
in the page, as it is replacement of offset_in_page.  That
get_eb_page_index is clear from the name but the other not.
