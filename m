Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD7D7DE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfJOReq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 13:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728653AbfJOReq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 13:34:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 204E0AC71;
        Tue, 15 Oct 2019 17:34:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34315DA7E3; Tue, 15 Oct 2019 19:34:55 +0200 (CEST)
Date:   Tue, 15 Oct 2019 19:34:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: check page->mapping when loading free space
 cache
Message-ID: <20191015173454.GZ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190924205044.31830-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924205044.31830-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 04:50:43PM -0400, Josef Bacik wrote:
> While testing 5.2 we ran into the following panic
> 
> [52238.017028] BUG: kernel NULL pointer dereference, address: 0000000000000001
> [52238.105608] RIP: 0010:drop_buffers+0x3d/0x150
> [52238.304051] Call Trace:
> [52238.308958]  try_to_free_buffers+0x15b/0x1b0
> [52238.317503]  shrink_page_list+0x1164/0x1780
> [52238.325877]  shrink_inactive_list+0x18f/0x3b0
> [52238.334596]  shrink_node_memcg+0x23e/0x7d0
> [52238.342790]  ? do_shrink_slab+0x4f/0x290
> [52238.350648]  shrink_node+0xce/0x4a0
> [52238.357628]  balance_pgdat+0x2c7/0x510
> [52238.365135]  kswapd+0x216/0x3e0
> [52238.371425]  ? wait_woken+0x80/0x80
> [52238.378412]  ? balance_pgdat+0x510/0x510
> [52238.386265]  kthread+0x111/0x130
> [52238.392727]  ? kthread_create_on_node+0x60/0x60
> [52238.401782]  ret_from_fork+0x1f/0x30
> 
> The page we were trying to drop had a page->private, but had no
> page->mapping and so called drop_buffers, assuming that we had a
> buffer_head on the page, and then panic'ed trying to deref 1, which is
> our page->private for data pages.
> 
> This is happening because we're truncating the free space cache while
> we're trying to load the free space cache.  This isn't supposed to
> happen, and I'll fix that in a followup patch.  However we still
> shouldn't allow those sort of mistakes to result in messing with pages
> that do not belong to us.  So add the page->mapping check to verify that
> we still own this page after dropping and re-acquiring the page lock.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Patches 1 and 2 moved to misc-next. Thanks.
