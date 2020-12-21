Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2F2DFEA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgLURAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 12:00:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:54888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgLURAl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 12:00:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D70AB04C;
        Mon, 21 Dec 2020 17:00:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9876DA7EF; Mon, 21 Dec 2020 17:58:17 +0100 (CET)
Date:   Mon, 21 Dec 2020 17:58:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 02/13] btrfs: initialize test inodes location
Message-ID: <20201221165817.GC6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1608135557.git.josef@toxicpanda.com>
 <33244ea952212da691e6723057488f8143efd949.1608135557.git.josef@toxicpanda.com>
 <7199c541-ea79-f92c-921b-f4ec7c4cfe81@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7199c541-ea79-f92c-921b-f4ec7c4cfe81@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 18, 2020 at 12:30:13PM +0200, Nikolay Borisov wrote:
> 
> 
> On 16.12.20 г. 18:22 ч., Josef Bacik wrote:
> > While testing other things I was noticing that sometimes my VM would
> > fail to load the btrfs module because the self test failed like this
> > 
> > BTRFS: selftest: fs/btrfs/tests/inode-tests.c:963 miscount, wanted 1, got 0
> > 
> > This turned out to be because sometimes the btrfs ino would be the btree
> > inode number, and thus we'd skip calling the set extent delalloc bit
> > helper, and thus not adjust ->outstanding_extents.  Fix this by making
> > sure we init test inodes with a valid inode number so that we don't get
> > random failures during self tests.
> 
> This warrants slightly more explanation why this initialization is
> required, namely that newly allocated indoes are initialized by passing
> a set callback, since we are acquiring inodes for tests we need to
> simulate this behavior by, effectively, open coding
> btrfs_init_locked_inode.

Makes sense, thanks. I've updated the changelog, the patch was sent
independently and has been added to misc-next already.
