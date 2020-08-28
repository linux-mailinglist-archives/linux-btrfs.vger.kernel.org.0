Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73C3255E92
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgH1QHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 12:07:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:46918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgH1QHT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 12:07:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05765AEBB;
        Fri, 28 Aug 2020 16:07:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48381DA6FD; Fri, 28 Aug 2020 18:06:08 +0200 (CEST)
Date:   Fri, 28 Aug 2020 18:06:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: fix compile warning due to global
 fs_info cleanup
Message-ID: <20200828160607.GQ28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200826004734.89905-1-wqu@suse.com>
 <20200826004734.89905-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826004734.89905-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 08:47:33AM +0800, Qu Wenruo wrote:
> [BUG]
> Compiler gives the following warning:
> 
>   check/main.c: In function 'check_chunks_and_extents':
>   check/main.c:8712:30: warning: assignment to 'int (*)(struct btrfs_fs_info *, u64,  u64,  u64,  u64,  u64,  u64,  int)' {aka 'int (*)(struct btrfs_fs_info *, long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  int)'} from incompatible pointer type 'int (*)(u64,  u64,  u64,  u64,  u64,  u64,  int)' {aka 'int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  int)'} [-Wincompatible-pointer-types]
>    8712 |   gfs_info->free_extent_hook = free_extent_hook;
> 
> And obviously, this would screwup original mode repair.
> 
> [CAUSE]
> Commit b91222b3 ("btrfs-progs: check: drop unused fs_info") removes the
> fs_info parameter for free_extent_hook(), but didn't remove the
> parameter for the definition.
> 
> [FIX]
> Also remove the fs_info parameter for the hook definition.
> 
> Fixes: b91222b3 ("btrfs-progs: check: drop unused fs_info")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, I folded this fix to the original patch as it indeed borked the
repair.
