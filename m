Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABF7192A72
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 14:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYNwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 09:52:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:41830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgCYNwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 09:52:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACDA1AD0F;
        Wed, 25 Mar 2020 13:52:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0544DA7EB; Wed, 25 Mar 2020 14:51:46 +0100 (CET)
Date:   Wed, 25 Mar 2020 14:51:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] Fix up some stupid delayed ref flushing behaviors
Message-ID: <20200325135146.GA5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313211220.148772-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313211220.148772-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:12:15PM -0400, Josef Bacik wrote:
> While debugging Zygo's delayed ref problems it was clear there were a bunch of
> cases that we're running delayed refs when we don't need to be, and they result
> in a lot of weird latencies.
> 
> Each patch has their individual explanations.  But the gist of it is we run
> delayed refs in a lot of arbitrary ways that have just accumulated throughout
> the years, so clean up all of these so we can have more consistent performance.

It would be fine to remove the delayed refs being run from so many
places but I vaguely remember some patches adding them with "we have to
run delayed refs here or we will miss something and that would be a
corruption". The changelogs in patches from 3 on don't point out any
specific problems and I miss some reasoning about correctness, ideally
for each line of btrfs_run_delayed_refs removed.

As a worst case I really don't want to get to a situation where we start
getting reports that something broke because of the missing delayed
refs, followed by series of "oh yeah I forgot we need it here, add it
back".

The branch with this patchset is in for-next but I'm still not
comfortable with adding it to misc-next as I can't convince myself it's
safe, so more reviews are welcome.
