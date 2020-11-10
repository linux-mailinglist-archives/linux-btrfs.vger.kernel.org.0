Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6C2AE219
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 22:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKJVsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 16:48:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:48388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbgKJVsZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E8F0ABD1;
        Tue, 10 Nov 2020 21:48:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE069DA7D7; Tue, 10 Nov 2020 22:46:42 +0100 (CET)
Date:   Tue, 10 Nov 2020 22:46:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: fix cases of stat(2) reporting incorrect
 number of used blocks
Message-ID: <20201110214642.GM6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1604486892.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 04, 2020 at 11:07:30AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are several cases where a stat(2) call can report an incorrect number
> of used blocks. In some cases can even result in reporting 0 used blocks,
> which is a specially bad value to report when a file is not empty, and we
> had user bug reports in the past for such cases (the changelogs in the
> patches point to one such report).
> 
> This patchset addresses all those cases. The third patch fixes a race in
> defrag that while it does not result in a functional problem (data loss
> or some corruption), it leads to unnecessary IO and space allocation,
> and it's necessary for the 4th and final patch to work as it is.
> 
> A couple test cases for fstests will follow.
> 
> Filipe Manana (4):
>   btrfs: fix missing delalloc new bit for new delalloc ranges
>   btrfs: refactor btrfs_drop_extents() to make it easier to extend
>   btrfs: fix race when defragging that leads to unnecessary IO
>   btrfs: update the number of bytes used by an inode atomically

Thanks, now added to misc-next. As the fixes seem to be important I've
checked which stable kernels are relevant, so it's 4.19 and 5.4. The
code does not apply due to intermediate cleanups but it should be
easy to resolve.
