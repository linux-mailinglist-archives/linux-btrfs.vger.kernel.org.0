Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7825DCA9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgIDPAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 11:00:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730202AbgIDPAW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Sep 2020 11:00:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 782FBAFC0;
        Fri,  4 Sep 2020 15:00:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF54BDA6E0; Fri,  4 Sep 2020 16:59:07 +0200 (CEST)
Date:   Fri, 4 Sep 2020 16:59:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: dio iomap DSYNC workaround
Message-ID: <20200904145907.GY28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <82c9a7d696fa353738c6998a33b581d76414e4f9.1599146199.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c9a7d696fa353738c6998a33b581d76414e4f9.1599146199.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 11:16:51AM -0400, Josef Bacik wrote:
> iomap dio will run generic_write_sync() for us if the iocb is DSYNC.
> This is problematic for us because of 2 reason, 1 we hold the
> inode_lock() during this operation, and we take it in
> generic_write_sync().  Secondly we hold a read lock on the dio_sem but
> take the write lock in fsync.
> 
> Since we don't want to rip out this code right now, but reworking the
> locking is a bit much to do on such short of a notice, work around this
> problem with this masterpiece of a patch.
> 
> First, we clear DSYNC on the iocb so that the iomap stuff doesn't know
> that it needs to handle the sync.  We save this fact in
> current->journal_info, because we need to see do special things once
> we're in iomap_begin, and we have no way to pass private information
> into iomap_dio_rw().
> 
> Next we specify a separate iomap_dio_ops for sync, which implements an
> ->end_io() callback that gets called when the dio completes.  This is
> important for AIO, because we really do need to run generic_write_sync()
> if we complete asynchronously.  However if we're still in the submitting
> context when we enter ->end_io() we clear the flag so that the submitter
> knows they're the ones that needs to run generic_write_sync().
> 
> This is meant to be temporary.  We need to work out how to eliminate the
> inode_lock() and the dio_sem in our fsync and use another mechanism to
> protect these operations.
> 
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
