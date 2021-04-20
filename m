Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBC365F05
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhDTSJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:09:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233381AbhDTSJF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:09:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DCFAB310;
        Tue, 20 Apr 2021 18:08:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 959ACDA83A; Tue, 20 Apr 2021 20:06:13 +0200 (CEST)
Date:   Tue, 20 Apr 2021 20:06:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] btrfs: do more graceful error/warning for 32bit kernel
Message-ID: <20210420180613.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>,
        Josef Bacik <josef@toxicpanda.com>
References: <20210409052420.65096-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409052420.65096-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 09, 2021 at 01:24:20PM +0800, Qu Wenruo wrote:
> Due to the pagecache limit of 32bit systems, btrfs can't access metadata
> at or beyond (ULONG_MAX + 1) << PAGE_SHIFT.
> This is 16T for 4K page size while 256T for 64K page size.
> 
> And unlike other fses, btrfs uses internally mapped u64 address space for
> all of its metadata, this is more tricky than other fses.
> 
> Users can have a fs which doesn't have metadata beyond the boundary at
> mount time, but later balance can cause btrfs to create metadata beyond
> the boundary.
> 
> And modification to MM layer is unrealistic just for such minor use
> case.
> 
> To address such problem, this patch will introduce the following checks,
> much like how XFS handles such problem:
> 
> - Mount time rejection
>   This will reject any fs which has metadata chunk at or beyond the
>   boundary.
> 
> - Mount time early warning
>   If there is any metadata chunk beyond 5/8 of the boundary, we do an
>   early warning and hope the end user will see it.
> 
> - Runtime extent buffer rejection
>   If we're going to allocate an extent buffer at or beyond the boundary,
>   reject such request with -EOVERFLOW.
>   This is definitely going to cause problems like transaction abort, but
>   we have no better ways.
> 
> - Runtime extent buffer early warning
>   If an extent buffer beyond 5/8 of the max file size is allocated, do
>   an early warning.
> 
> Above error/warning message will only be outputted once for each fs to
> reduce dmesg flood.
> 
> Reported-by: Erik Jensen <erikjensen@rkjnsn.net>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I've added some references and updated wording what's the problem. Patch
moved from topic branch to misc-next, thanks.
