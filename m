Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1E4B732
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFSLgM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 07:36:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727244AbfFSLgM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 07:36:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F00D7AEB3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 11:36:10 +0000 (UTC)
Date:   Wed, 19 Jun 2019 06:36:08 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Evaluate io_tree in find_lock_delalloc_range()
Message-ID: <20190619113608.zy24txjcu42nzhb6@fiona>
References: <20190619003524.32377-1-rgoldwyn@suse.de>
 <8a7dd8d7-a918-b618-d8e2-bf0ff182cfdc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7dd8d7-a918-b618-d8e2-bf0ff182cfdc@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  9:05 19/06, Nikolay Borisov wrote:
> 
> 
> On 19.06.19 г. 3:35 ч., Goldwyn Rodrigues wrote:
> > Simplification.
> > No point passing the tree variable when it can be evaluated
> > from inode.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The patch is good, however, there are several calls to find_
> lock_delalloc_range in btrfs tests so you'd need to fix those 
> invocations, otherwise compilation of the in-kernel test suite will fails. 
> 
> fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> 
> 

Oh, I missed the test, even if it was listed as EXPORT_FOR_TESTS.
Looking at the tests, it seems it needs to work on a different io_tree than
in the inode. So, I suppose this patch should NOT be included for the sake
of tests. Perhaps we should use wrapper functions for simplifications.

-- 
Goldwyn
