Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE541108E75
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKYNHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 08:07:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:48752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfKYNHm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 08:07:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26B86AE2E;
        Mon, 25 Nov 2019 13:07:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9DDBDA898; Mon, 25 Nov 2019 14:07:39 +0100 (CET)
Date:   Mon, 25 Nov 2019 14:07:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: handle error in btrfs_cache_block_group
Message-ID: <20191125130739.GA2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191119185900.2985-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119185900.2985-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 01:59:00PM -0500, Josef Bacik wrote:
> We have a BUG_ON(ret < 0) in find_free_extent from
> btrfs_cache_block_group.  If we fail to allocate our ctl we'll just
> panic, which is not good.  Instead just go on to another block group.
> If we fail to find a block group we don't want to return ENOSPC, because
> really we got a ENOMEM and that's the root of the problem.  Save our
> return from btrfs_cache_block_group(), and then if we still fail to make
> our allocation return that ret so we get the right error back.
> 
> Tested with inject-error.py from bcc.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
