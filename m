Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954A138AFF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhETN2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhETN2H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 09:28:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17CF5ACAD;
        Thu, 20 May 2021 13:26:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31949DA806; Thu, 20 May 2021 15:24:10 +0200 (CEST)
Date:   Thu, 20 May 2021 15:24:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: check error value from btrfs_update_inode in tree
 log
Message-ID: <20210520132410.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
 <c82160a4-03bd-783d-009b-5ab5e25424f9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82160a4-03bd-783d-009b-5ab5e25424f9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 09:07:26AM +0800, Qu Wenruo wrote:
> > -			btrfs_update_inode(trans, root, BTRFS_I(inode));
> 
> I did a quick grep and found that we have other locations where we call
> btrfs_uppdate_inode() without catching the return value:
> 
> $ grep -IRe "^\s\+btrfs_update_inode(" fs/btrfs/
> fs/btrfs/free-space-cache.c:    btrfs_update_inode(trans, root,
> BTRFS_I(inode));
> fs/btrfs/free-space-cache.c:    btrfs_update_inode(trans, root,
> BTRFS_I(inode));
> fs/btrfs/inode.c:               btrfs_update_inode(trans, root, inode);
> fs/btrfs/inode.c:       btrfs_update_inode(trans, root, BTRFS_I(inode));
> 
> Maybe it's better to make btrfs_update_inode() to have __must_check prefix?

We should handle errors everywhere by default, with rare exceptions that
might get a comment why it's ok to ignore the errors. So that would mean
that basically all functions get __must_check attribute if we really
want to catch that.
