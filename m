Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634891629FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgBRQAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 11:00:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:58942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQAg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 11:00:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 216F9B4E0;
        Tue, 18 Feb 2020 16:00:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0B6ADA7BA; Tue, 18 Feb 2020 17:00:18 +0100 (CET)
Date:   Tue, 18 Feb 2020 17:00:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix btrfs_wait_ordered_range() so that it waits
 for all ordered extents
Message-ID: <20200218160018.GP2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200213122950.12115-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213122950.12115-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 13, 2020 at 12:29:50PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs_wait_ordered_range() once we find an ordered extent that has
> finished with an error we exit the loop and don't wait for any other
> ordered extents that might be still in progress.
> 
> All the users of btrfs_wait_ordered_range() expect that there are no more
> ordered extents in progress after that function returns. So past fixes
> such like the ones from the two following commits:
> 
>   ff612ba7849964 ("btrfs: fix panic during relocation after ENOSPC before
>                    writeback happens")
> 
>   28aeeac1dd3080 ("Btrfs: fix panic when starting bg cache writeout after
>                    IO error")
> 
> don't work when there are multiple ordered extents in the range.
> 
> Fix that by making btrfs_wait_ordered_range() wait for all ordered extents
> even after it finds one that had an error.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/228#issuecomment-569777554
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
