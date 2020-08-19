Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9F249FE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgHSN3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 09:29:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSN3j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 09:29:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E53AACC6;
        Wed, 19 Aug 2020 13:30:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E33CDA703; Wed, 19 Aug 2020 15:28:31 +0200 (CEST)
Date:   Wed, 19 Aug 2020 15:28:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: prevent hung check firing during long sync IO
Message-ID: <20200819132831.GL2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Xianting Tian <tian.xianting@h3c.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819101451.24266-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101451.24266-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 06:14:51PM +0800, Xianting Tian wrote:
> For sync and flush io, it may take long time to complete.
> So it's better to use wait_for_completion_io_timeout() in a
> while loop to avoid prevent hung check and crash(when set
> /proc/sys/kernel/hung_task_panic).

I wonder if long running IO should trigger the panic/kill of the task at
all. A warning means that the system is under load but as long as it's
making some progress it should be ok, and that seems to be a separate
case from a task that's not making any progress (and terminating it is
probably the best option).

> This is similar to prevent hung task check in submit_bio_wait(),
> blk_execute_rq().

I see, adding that workaround to btrfs would be 3rd occurence and this
should go into a wrapper, eg. wait_for_completion_io_nowarn with
examples where this should be used.
