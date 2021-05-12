Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECA37EF8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbhELXNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 19:13:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234252AbhELWWD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 18:22:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05F08AEE7;
        Wed, 12 May 2021 22:20:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DE0FDA919; Thu, 13 May 2021 00:18:22 +0200 (CEST)
Date:   Thu, 13 May 2021 00:18:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210512221821.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:07AM +0800, Qu Wenruo wrote:
> === Patchset structure ===
> 
> Patch 01~02:	hardcoded PAGE_SIZE related fixes
> Patch 03~05:	submit_extent_page() refactor which will reduce overhead
> 		for write path.
> 		This should benefit 4K page the most. Although the
> 		primary objective is just to make the code easier to
> 		read.
> Patch 06:	Cleanup for metadata writepath, to reduce the impact on
> 		regular sectorsize path.
> Patch 07~13:	PagePrivate2 and ordered extent related refactor.
> 		Although it's still a refactor, the refactor is pretty
> 		important for subpage data write path, as for subpage we
> 		could have btrfs_writepage_endio_finish_ordered() call
> 		across several sectors, which may or may not have
> 		ordered extent for those sectors.
> 
> ^^^ Above patches are all subpage data write preparation ^^^

Do you think the patches 1-13 are safe to be merged independently? I've
paged through the whole patchset and some of the patches are obviously
preparatory stuff so they can go in without much risk.

I haven't looked at your git if there are updates from what was posted,
but I don't expect any significant changes, but what I saw looked ok to
me.

If there are changes, please post 1-13 (ie. all the preparatory
patches), I'll put them to misc-next so you can focus on the rest.
