Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5086E1B4F93
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDVVqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 17:46:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVVqL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 17:46:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 294B0AA55;
        Wed, 22 Apr 2020 21:46:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B082DA704; Wed, 22 Apr 2020 23:45:26 +0200 (CEST)
Date:   Wed, 22 Apr 2020 23:45:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     wu000273@umn.edu
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu
Subject: Re: [PATCH] btrfs: fix a potential racy
Message-ID: <20200422214526.GT18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, wu000273@umn.edu, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu
References: <20200419015907.15503-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419015907.15503-1-wu000273@umn.edu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 18, 2020 at 08:59:07PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function reada_find_extent and reada_extent_put, kref_get(&zone->refcnt)
> are not called in a lock context. Potential racy may happen. It's possible
> that thread1 decreases the kref to 0, and thread2 increases the kref to 1,
> then thread1 releases the pointer.

There are several things I don't see or understand why they woudl be a
problem.

kref_get does not need to be take under locks in case it's not the first
reference or if it's clear that eg. the caller has taken a reference and
it'll never go to 0.

The references are supposed to be lightweight so taking the locks per
kref_get does not follow a good pattern.

The kref type is a wrapper around refcount_t, that detects if there's an
increment from 0->1, similar to what you suggest that could happen. It
might be tricky to actually hit that case so I'm not saying that it's
all ok, just that we haven't seen that so far.

Your description of the race needs to be expanded as it's too terse,
where exactly the increments could happen, how would be the calls in the
two cpus interleaved, like

cpu1				cpu2

				reada_find_extent()
				   kref_get
				   ...
reada_find_extent()
   				   kref_put (last put, refs == 0)
   kref_get (inc from zero)
   ...

Then it's easer to reason about the actual races and the context where
it could happen. Eg. btrfs_reada_add adds one reference from the
beginning, so the final put does not happen in the middle of
reada_find_extent unless something would be seriously broken and that
would manifest very clearly.
