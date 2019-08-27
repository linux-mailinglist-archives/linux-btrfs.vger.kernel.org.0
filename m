Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7039E88E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfH0NEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:04:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfH0NEF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:04:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50938B00E;
        Tue, 27 Aug 2019 13:04:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C40ADA809; Tue, 27 Aug 2019 15:04:25 +0200 (CEST)
Date:   Tue, 27 Aug 2019 15:04:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/9] btrfs: rework wake_all_tickets
Message-ID: <20190827130425.GH2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190822191102.13732-1-josef@toxicpanda.com>
 <20190822191102.13732-7-josef@toxicpanda.com>
 <9ab7f79a-6b04-f548-c9a6-f90b0b353826@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab7f79a-6b04-f548-c9a6-f90b0b353826@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 23, 2019 at 11:17:06AM +0300, Nikolay Borisov wrote:
> > @@ -759,7 +786,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
> >  		if (flush_state > COMMIT_TRANS) {
> >  			commit_cycles++;
> >  			if (commit_cycles > 2) {
> > -				if (wake_all_tickets(&space_info->tickets)) {
> > +				if (maybe_fail_all_tickets(fs_info, space_info)) {
> 
> This looks odd. A function called "maybe_fail" which if it returns true
> then we are sure we haven't failed all tickets, instead make another go
> through the flushing machinery. I think the problem stems from the fact
> it's doing 3 things, namely:
> 
> 1. Failing all tickets, that aren't smaller than the initial one
> 2. Trying to satisfy other tickets apart from the one failed
> 3. If it succeeded it signals to the flushing machinery to make another go
> 
> The function's name really reflects what's going on in 1. But 2 and 3
> are also major part of the logic. I think there is 'impedance mismatch'
> here. I'm at a loss what to do here, honestly.

The function is quite short and splitting it may not be an improvement,
so the semantics should be at least documented, the 3 points you write
look comprehensible so I'd stick that to the function. As this is not
functional change documentation is probably best we can do now to move
forward.
