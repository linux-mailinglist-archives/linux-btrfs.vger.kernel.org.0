Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80730AC24
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 16:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhBAP6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 10:58:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:58244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231785AbhBAP6H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 10:58:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED61CACB7;
        Mon,  1 Feb 2021 15:57:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6544BDA6FC; Mon,  1 Feb 2021 16:55:36 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:55:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210201155536.GT1993@twin.jikos.cz>
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
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> Currently the branch also contains partial RW data support (still some
> ordered extent and data csum mismatch problems)
> 
> Great thanks to David/Nikolay/Josef for their effort reviewing and
> merging the preparation patches into misc-next.
> 
> === What works ===
> Just from the patchset:
> - Data read
>   Both regular and compressed data, with csum check.
> 
> - Metadata read
> 
> This means, with these patchset, 64K page systems can at least mount
> btrfs with 4K sector size read-only.
> This should provide the ability to migrate data at least.
> 
> While on the github branch, there are already experimental RW supports,
> there are still ordered extent related bugs for me to fix.
> Thus only the RO part is sent for review and testing.
> 
> === Patchset structure ===
> Patch 01~02:	Preparation patches which don't have functional change
> Patch 03~12:	Subpage metadata allocation and freeing
> Patch 13~15:	Subpage metadata read path
> Patch 16~17:	Subpage data read path
> Patch 18:	Enable subpage RO support

> v5:
> - Use the updated version from David as base
>   Most comment/commit message update should be kept as is.
> 
> - A new separate patch to move UNMAPPED bit set timing
> 
> - New comment on why we need to prealloc subpage inside a loop
>   Mostly for further 16K page size support, where we can have
>   eb across multiple pages.
> 
> - Remove one patch which is too RW specific
>   Since it introduces functional change which only makes sense for RW
>   support, it's not a good idea to include it in RO support.
> 
> - Error handling fixes
>   Great thanks to Josef.
> 
> - Refactor btrfs_subpage allocation/freeing
>   Now we have btrfs_alloc_subpage() and btrfs_free_subpage() helpers to
>   do all the allocation/freeing.
>   It's pretty easy to convert to kmem_cache using above helpers.
>   (already internally tested using kmem_cache without problem, in fact
>    it's all the problems found in kmem_cache test leads to the new
>    interface)
> 
> - Use btrfs_subpage::eb_refs to replace old under_alloc
>   This makes checking whether the page has any eb left much easier.

All look reasonable for merge, patch 17 still needs an update that'll
replace once you send it.

I'll move it to misc-next after fstests finish, minor updates are still
possible during this week, merge window freeze is approaching.
