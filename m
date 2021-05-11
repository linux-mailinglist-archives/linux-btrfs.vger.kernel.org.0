Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05737A874
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEKOID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 10:08:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhEKOID (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 10:08:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA75AAECB;
        Tue, 11 May 2021 14:06:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6BEA4DAF29; Tue, 11 May 2021 16:04:26 +0200 (CEST)
Date:   Tue, 11 May 2021 16:04:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] btrfs: make read time repair to be only submitted
 for each corrupted sector
Message-ID: <20210511140426.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210511061449.228635-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511061449.228635-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 02:14:46PM +0800, Qu Wenruo wrote:
> v4:
> - Fix a bug that end_page_read() get called twice for the same range
>   This happens when the corrupted sector has no extra copy, thus
>   btrfs_submit_read_repair() return -EIO, leaving both
>   btrfs_submit_read_repair() and end_bio_extent_readpage() to
>   call end_page_read() twice on the good copy.
>   Thankfully this only affects subpage.
> 
> - Fix a bug that sectors after unrepairable corruption are not released
>   Since btrfs_submit_read_repair() is responsible for the page release,
>   we can no longer just error out.
>   Or some ordered extent will not be able to finish.
> 
> - Remove patch "btrfs: remove the dead branch in btrfs_io_needs_validation()"
>   The cleanup will break bisect, as DIO can still generate cloned bio.
>   Thus remove it and let the final cleanup patch to handle everything.

V4 replaced in for-next, thanks.
