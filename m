Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336D02A80DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgKEO32 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 09:29:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:33586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKEO31 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 09:29:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC248AAF1;
        Thu,  5 Nov 2020 14:29:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 088B7DA6E3; Thu,  5 Nov 2020 15:27:47 +0100 (CET)
Date:   Thu, 5 Nov 2020 15:27:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] Block group caching fixes
Message-ID: <20201105142747.GJ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 09:58:03AM -0400, Josef Bacik wrote:
> The main fixes are
>   
>   btrfs: do not shorten unpin len for caching block groups
>   btrfs: update last_byte_to_unpin in switch_commit_roots
>   btrfs: protect the fs_info->caching_block_groups differently
> 
> And the work to make space cache async is in the following patches
> 
>   btrfs: cleanup btrfs_discard_update_discardable usage
>   btrfs: load free space cache into a temporary ctl
>   btrfs: load the free space cache inode extents from commit root
>   btrfs: async load free space cache
> 
> Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs: do not shorten unpin len for caching block groups
>   btrfs: update last_byte_to_unpin in switch_commit_roots
>   btrfs: explicitly protect ->last_byte_to_unpin in unpin_extent_range
>   btrfs: cleanup btrfs_discard_update_discardable usage
>   btrfs: load free space cache into a temporary ctl
>   btrfs: load the free space cache inode extents from commit root
>   btrfs: async load free space cache
>   btrfs: protect the fs_info->caching_block_groups differently

Added to misc-next, thanks. Some of the fixes look like stable candidate
but eg. "btrfs: protect the fs_info->caching_block_groups differently"
depends on the other patches and in whole is not a simple fix.

Patches 1 and apply to 5.4 and 5.8 respectively but for lower versions
there are conflicts and not trivial so that's all.
