Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D2DFE3EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKOR2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 12:28:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbfKOR2w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 12:28:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9C06698A8;
        Fri, 15 Nov 2019 17:28:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79B77DA818; Fri, 15 Nov 2019 18:28:53 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:28:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/22] btrfs: add bps discard rate limit
Message-ID: <20191115172853.GB3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1571865774.git.dennis@kernel.org>
 <8efa082438eea760533f1cddffa74cebdea6f028.1571865774.git.dennis@kernel.org>
 <20191108194126.e7aznojtxhfuaaeg@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108194126.e7aznojtxhfuaaeg@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 08, 2019 at 02:41:27PM -0500, Josef Bacik wrote:
> On Wed, Oct 23, 2019 at 06:53:08PM -0400, Dennis Zhou wrote:
> > Provide an ability to rate limit based on mbps in addition to the iops
> > delay calculated from number of discardable extents.
> 
> I'm sort of confused, are we hiding the ability to set the iops limit and bps
> limit behind BTRFS_DEBUG for a reason?

IMHO the iops and ratelimiting should tune itself and no extra knobs
should be necessary because this depends on the underlying devices and
current load. The user set parameters can be wrong the moment it's done.

Before we find the right way to tune it, the sysfs knobs are there to
make it easy for someobody familiar with the internals of the async
discard working to experiment.

If we'd still want something for regular users, I'd suggest to add some
sort of high-level strategies, like
bursty/batched/conservative/slow/idk. But this would anyway build on
existing default behaviour.
