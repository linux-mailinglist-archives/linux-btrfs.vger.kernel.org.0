Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D72A89B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 23:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbgKEWYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 17:24:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:60256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbgKEWYp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 17:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79E14AB8F;
        Thu,  5 Nov 2020 22:24:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5CEA7DA6E3; Thu,  5 Nov 2020 23:23:05 +0100 (CET)
Date:   Thu, 5 Nov 2020 23:23:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] fixes for btrfs async discards
Message-ID: <20201105222305.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pavel Begunkov <asml.silence@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604444952.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 04, 2020 at 09:45:50AM +0000, Pavel Begunkov wrote:
> Several fixes for async discards. The first patch might increase discard
> rate, drastically in some cases. That may be a suprise for those
> assuming that hitting iops_limit is rare and rarther outliers. Though,
> it still stays in allowed range, so should be fine.

I think this highly depends on the workload, if you really need to issue
the discards fast because of the rate of the change in the regular data.
That was the point of the async discard and the knobs, the defaults
should be ok for most users and allow adjusting for specific loads.

My testing of the original discard patchset was tailored towards the
default usecase and likely intense than yours. I did not observe the
corner cases where the work queue scheduling was off, or changing the
sysfs values did not poke the right kthreads.

Patches look ok to me and I've added them to topic branch for testing,
going to misc-next later. Thanks.
