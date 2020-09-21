Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F427307D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIURFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 13:05:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgIURFX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 13:05:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17741AC7D;
        Mon, 21 Sep 2020 17:05:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1FEEDA6E0; Mon, 21 Sep 2020 19:04:05 +0200 (CEST)
Date:   Mon, 21 Sep 2020 19:04:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/4] btrfs: use sb state to print space_cache mount option
Message-ID: <20200921170405.GL6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
 <bae2283f-ed1e-d09c-55bd-afedabe9b3f3@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae2283f-ed1e-d09c-55bd-afedabe9b3f3@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 10:50:25AM -0400, Josef Bacik wrote:
> On 9/17/20 2:13 PM, Boris Burkov wrote:
> > To make the contents of /proc/mounts better match the actual state of
> > the file system, base the display of the space cache mount options off
> > the contents of the super block rather than the last mount options
> > passed in. Since there are many scenarios where the mount will ignore a
> > space cache option, simply showing the passed in option is misleading.
> > 
> > For example, if we mount with -o remount,space_cache=v2 on a read-write
> > file system without an existing free space tree, we won't build a free
> > space tree, but /proc/mounts will read space_cache=v2 (until we mount
> > again and it goes away)
> > 
> > There is already mount logic based on the super block's cache_generation
> > and free space tree flag that helps decide a consistent setting for the
> > space cache options, so we just bring those further to the fore. For
> > free space tree, the flag is already consistent, so we just switch mount
> > option display to use it. cache_generation is not always reliably set
> > correctly, so we ensure that cache_generation > 0 iff the file system
> > is using space_cache v1. This requires committing a transaction on any
> > mount which changes whether we are using v1. (v1->nospace_cache, v1->v2,
> > nospace_cache->v1, v2->v1).
> > 
> > References: https://github.com/btrfs/btrfs-todo/issues/5
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Dave already took this, but next time I'd prefer if we'd keep logical changes 
> separate.  So one patch to change /proc/mounts, one patch to deal with clearing 
> the free space generation field if we're not using it.

I haven't taken it yet, adding branches to for-next is only to get test
coverage, by 'taken' you can count addig it to misc-next.
