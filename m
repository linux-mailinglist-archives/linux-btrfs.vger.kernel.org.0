Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE208243B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfHERuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 13:50:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbfHERuW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 13:50:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6949BB0BF;
        Mon,  5 Aug 2019 17:50:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86A56DABC7; Mon,  5 Aug 2019 19:50:53 +0200 (CEST)
Date:   Mon, 5 Aug 2019 19:50:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] Rework eviction space flushing
Message-ID: <20190805175052.GD28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190801221937.22742-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801221937.22742-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 01, 2019 at 06:19:32PM -0400, Josef Bacik wrote:
> This is a set of patches to address how we do space flushing for inode
> evictions.  Historically we've only been allowed to do a few things to reclaim
> space for inode evictions, mostly because we'd deadlock with iput.  But we have
> delayed iputs in place to make sure we're always doing iput where it's
> completely safe to do an iput.
> 
> However we do run iputs for flushing, so we can't just do FLUSH_ALL, otherwise
> we could deadlock.  Also we still want to prioritize evictions for space
> reclamation because we likely will free up space for other people to make
> reservations.
> 
> The first 4 patches are preparation patches, just refactoring so we can add this
> new flushing time for eviction.  This allows us to clean up our current ad-hoc
> loop we have for reclaiming space for evictions and use the common helpers that
> everybody else uses.  Thanks,

I'll add this as a topic branch to for-next for testing, I have only
skimmed the patches and did not do any kind of review.
