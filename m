Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729DBFE434
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 18:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKORke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 12:40:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:57484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfKORkd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 12:40:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 207DE69CD7;
        Fri, 15 Nov 2019 17:40:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1898DA818; Fri, 15 Nov 2019 18:40:34 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:40:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/22] btrfs: async discard support
Message-ID: <20191115174034.GD3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:52:54PM -0400, Dennis Zhou wrote:
> Data:
> On a number of webservers, I collected data every minute accounting the
> time we spent in btrfs_finish_extent_commit() (col. 1) and in
> btrfs_commit_transaction() (col. 2). btrfs_finish_extent_commit() is
> where we discard extents synchronously before returning them to the
> free space cache.
> 
> discard=sync:
>                  p99 total per minute       p99 total per minute
>       Drive   |   extent_commit() (ms)  |    commit_trans() (ms)
>     ---------------------------------------------------------------
>      Drive A  |           434           |          1170 
>      Drive B  |           880           |          2330
>      Drive C  |          2943           |          3920
>      Drive D  |          4763           |          5701
> 
> discard=async:
>                  p99 total per minute       p99 total per minute
>       Drive   |   extent_commit() (ms)  |    commit_trans() (ms)
>     --------------------------------------------------------------
>      Drive A  |           134           |           956
>      Drive B  |            64           |          1972
>      Drive C  |            59           |          1032
>      Drive D  |            62           |          1200
> 
> While it's not great that the stats are cumulative over 1m, all of these
> servers are running the same workload and and the delta between the two
> are substantial. We are spending significantly less time in
> btrfs_finish_extent_commit() which is responsible for discarding.

Nice, thanks for getting the numbers. I think we can slap them to the
patch that introduceds async discard which is 5/22.

I went through the patchset, looks good, though I'm sure I missed some
small things, it's a lot of code. I'm going to add it first thing to 5.6
patch queue. There are some minor conflicts with patches in 5.5 queue,
so this will need to be sorted. I've seen some feedback to address,
it would be IMHO best to resend the whole series. Thanks.
