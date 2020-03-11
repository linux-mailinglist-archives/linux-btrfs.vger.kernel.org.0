Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7F5180D04
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 01:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgCKAvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 20:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:52846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgCKAvB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 20:51:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 566E2B17A;
        Wed, 11 Mar 2020 00:50:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 543EDDA7A7; Wed, 11 Mar 2020 01:50:34 +0100 (CET)
Date:   Wed, 11 Mar 2020 01:50:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relocation: Use btrfs_find_all_leaves() to locate
 parent tree leaves of a data extent
Message-ID: <20200311005034.GD12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200310081415.49080-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310081415.49080-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 04:14:15PM +0800, Qu Wenruo wrote:
> In relocation, we need to locate all parent tree leaves referring one
> data extent, thus we have a complex mechanism to iterate throught extent
> tree and subvolume trees to locate related leaves.
> 
> However this is already done in backref.c, we have
> btrfs_find_all_leaves(), which can return a ulist containing all leaves
> referring to that data extent.
> 
> Use btrfs_find_all_leaves() to replace find_data_references().
> 
> There is a special handling for v1 space cache data extents, where we
> need to delete the v1 space cache data extents, to avoid those data
> extents to hang the data relocation.
> 
> In this patch, the special handling is done by re-iterating the root
> tree leaf.
> Although it's a little less efficient than the old handling, considering
> we can reuse a lot of code, it should be acceptable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This patch is originally in my backref cache branch, but since it's
> pretty independent from other backref cache code, and straightforward to
> test/review, it's sent for more comprehensive test/review/merge.

I'll add the patch to for-next, looks a bit scary.
