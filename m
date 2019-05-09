Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6737F18874
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEIKlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 06:41:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfEIKlE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 06:41:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAB62AC11;
        Thu,  9 May 2019 10:41:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90FE1DA8DC; Thu,  9 May 2019 12:42:02 +0200 (CEST)
Date:   Thu, 9 May 2019 12:42:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: extent-tree: Add trace events for space info
 numbers update
Message-ID: <20190509104202.GQ20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190429060333.24172-1-wqu@suse.com>
 <20190429060333.24172-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429060333.24172-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 29, 2019 at 02:03:33PM +0800, Qu Wenruo wrote:
> Add trace event for update_bytes_pinned() and update_bytes_may_use() to
> detect underflow better.
> 
> The output would be something like (only showing data part):
> 
>   ## Buffered write start, 16K total ##
>   2255.954 xfs_io/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=0 diff=4096
>   2257.169 sudo/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=4096 diff=4096
>   2257.346 sudo/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=8192 diff=4096
>   2257.542 sudo/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=12288 diff=4096
> 
>   ## Delalloc start ##
>   3727.853 kworker/u8:3-e/700 btrfs:update_bytes_may_use:(nil)U: type=DATA old=16384 diff=-16384
> 
>   ## Space cache update ##
>   3733.132 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=0 diff=65536
>   3733.169 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=65536 diff=-65536
>   3739.868 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=0 diff=65536
>   3739.891 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=65536 diff=-65536
> 
> These two trace events will allow bcc tool to probe btrfs_space_info
> changes and detect underflow with more details (e.g. backtrace for each
> update).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

1 and 2

Reviewed-by: David Sterba <dsterba@suse.com>
