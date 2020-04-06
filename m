Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A319FD2E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDFS3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 14:29:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDFS3w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 14:29:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00924AE63;
        Mon,  6 Apr 2020 18:29:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E31BDA726; Mon,  6 Apr 2020 18:00:48 +0200 (CEST)
Date:   Mon, 6 Apr 2020 18:00:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: force chunk allocation if our global rsv is
 larger than metadata
Message-ID: <20200406160048.GO5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313192848.140759-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313192848.140759-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 03:28:48PM -0400, Josef Bacik wrote:
> Nikolay noticed a bunch of test failures with my global rsv steal
> patches.  At first he thought they were introduced by them, but they've
> been failing for a while with 64k nodes.
> 
> The problem is with 64k nodes we have a global reserve that calculates
> out to 13mib on a freshly made file system, which only has 8mib of
> metadata space.  Because of changes I previously made we no longer
> account for the global reserve in the overcommit logic, which means we
> correctly allow overcommit to happen even though we are already
> overcommitted.
> 
> However in some corner cases, for example btrfs/170, we will allocate
> the entire file system up with data chunks before we have enough space
> pressure to allocate a metadata chunk.  Then once the fs is full we
> ENOSPC out because we cannot overcommit and the global reserve is taking
> up all of the available space.
> 
> The most ideal way to deal with this is to change our space reservation
> stuff to take into account the height of the tree's that we're
> modifying, so that our global reserve calculation does not end up so
> obscenely large.
> 
> However that is a huuuuuuge undertaking.  Instead fix this by forcing a
> chunk allocation if the global reserve is larger than the total metadata
> space.  This gives us essentially the same behavior that happened
> before, we get a chunk allocated and these tests can pass.
> 
> This is meant to be a stop-gap measure until we can tackle the "tree
> height only" project.
> 
> Fixes: 0096420adb03 ("btrfs: do not account global reserve in can_overcommit")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
