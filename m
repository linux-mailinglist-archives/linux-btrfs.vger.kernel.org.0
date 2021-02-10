Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A927316897
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 15:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhBJOBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 09:01:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:47212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231822AbhBJOA7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7A47AE1B;
        Wed, 10 Feb 2021 14:00:16 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:00:15 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 0/6] Add roundrobin raid1 read policy
Message-ID: <20210210140015.GE23499@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <4f24ef7f-c1cf-3cda-b12f-a2c8c84a7e45@oracle.com>
 <20210210121853.GA23499@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210121853.GA23499@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 12:18:53PM +0000, Michal Rostecki wrote:
> > These patches look good. But as only round-robin policy requires
> > to monitor the inflight and last-offset. Could you bring them under
> > if policy=roundrobin? Otherwise, it is just a waste of CPU cycles
> > if the policy != roundrobin.
> > 
> 
> If I bring those stats under if policy=roundrobin, they are going to be
> inaccurate if someone switches policies on the running system, after
> doing any I/O in that filesystem.
> 
> I'm open to suggestions how can I make those stats as lightweight as
> possible. Unfortunately, I don't think I can store the last physical
> location without atomic_t.
> 
> The BIO percpu counter is probably the least to be worried about, though
> I could maybe get rid of it entirely in favor of using part_stat_read().
> 

Actually, after thinking about that more, I'm wondering if I should just
drop the last-offset stat and penalty mechanism entirely. They seem to
improve performance slightly only on mixed workloads (thought I need to
check if that's the case in all-SDD od all NVMe arrays), but still
perform worse than policies that you proposed.

Maybe it'd be better if I just focus on getting the best performance on
non-mixed environments in my policy and thus stick to the simple
`inflight < queue_depth` check...

Thanks,
Michal
