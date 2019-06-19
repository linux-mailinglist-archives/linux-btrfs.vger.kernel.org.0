Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF804B96C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFSNI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 09:08:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbfFSNI1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 09:08:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 436B9ADE0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 13:08:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DBB0DA88C; Wed, 19 Jun 2019 15:09:13 +0200 (CEST)
Date:   Wed, 19 Jun 2019 15:09:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Evaluate io_tree in find_lock_delalloc_range()
Message-ID: <20190619130912.GE8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190619003524.32377-1-rgoldwyn@suse.de>
 <8a7dd8d7-a918-b618-d8e2-bf0ff182cfdc@suse.com>
 <20190619113608.zy24txjcu42nzhb6@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619113608.zy24txjcu42nzhb6@fiona>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 06:36:08AM -0500, Goldwyn Rodrigues wrote:
> On  9:05 19/06, Nikolay Borisov wrote:
> > 
> > 
> > On 19.06.19 г. 3:35 ч., Goldwyn Rodrigues wrote:
> > > Simplification.
> > > No point passing the tree variable when it can be evaluated
> > > from inode.
> > > 
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > The patch is good, however, there are several calls to find_
> > lock_delalloc_range in btrfs tests so you'd need to fix those 
> > invocations, otherwise compilation of the in-kernel test suite will fails. 
> > 
> > fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> > fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> > fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> > fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> > fs/btrfs/tests/extent-io-tests.c:       found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
> > 
> > 
> 
> Oh, I missed the test, even if it was listed as EXPORT_FOR_TESTS.
> Looking at the tests, it seems it needs to work on a different io_tree than
> in the inode.

If it's possible/correct to set the test inode tree pointer, then I
guess the change still applies. The testing code works on dummy
or otherwise crafted structures, so this kind of tweak does not sound
off.
