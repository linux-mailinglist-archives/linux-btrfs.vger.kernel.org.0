Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33B612E9FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 19:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgABSgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 13:36:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:32886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgABSgS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 13:36:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A40B1AA35;
        Thu,  2 Jan 2020 18:36:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54A18DA733; Thu,  2 Jan 2020 19:36:08 +0100 (CET)
Date:   Thu, 2 Jan 2020 19:36:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs-progs: Bad extent item generation related bug
 fixes
Message-ID: <20200102183607.GQ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191231071220.32935-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 31, 2019 at 03:12:15PM +0800, Qu Wenruo wrote:
> There is an issue reported in github, where an fs get corrupted
> extent tree initialy, then I recommended --init-extent-tree.
> 
> Although --init-extent-tree indeed fixed the original problem, it caused
> new problems, quite a lot of EXTENT_ITEMs now get bad generation number,
> which failed to mount with v5.4.
> 
> The problem turns out to be a bug in backref repair code, which doesn't
> initialize extent_record::generation, causing garbage in EXTENT_ITEMs.
> 
> This patch will:
> - Fix the problem
>   Patch 1
> 
> - Enhance EXTENT_ITEM generation repair
>   Patch 2
> 
> - Make `btrfs check` able to detect such bad generation
>   Patch 3~4
> 
> - Add new test case for above ability
>   Patch 5
> 
> Qu Wenruo (5):
>   btrfs-progs: check: Initialize extent_record::generation member
>   btrfs-progs: check: Populate extent generation correctly for data
>     extents
>   btrfs-progs: check/lowmem: Detect invalid EXTENT_ITEM and EXTENT_DATA
>     generation
>   btrfs-progs: check/original: Detect invalid extent generation
>   btrfs-progs: fsck-tests: Make sure btrfs check can detect bad extent
>     item generation

Thanks for the fixes, added to devel.
