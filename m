Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503089AF86
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfHWMaX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 08:30:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731848AbfHWMaX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 08:30:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03AE4B114;
        Fri, 23 Aug 2019 12:30:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D385DA796; Fri, 23 Aug 2019 14:30:45 +0200 (CEST)
Date:   Fri, 23 Aug 2019 14:30:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: rework btrfs_space_info_add_old_bytes
Message-ID: <20190823123044.GN2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190822191102.13732-1-josef@toxicpanda.com>
 <20190822191102.13732-5-josef@toxicpanda.com>
 <b3a697e5-016d-5c8c-f0c6-711e433ca18f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a697e5-016d-5c8c-f0c6-711e433ca18f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 23, 2019 at 10:48:35AM +0300, Nikolay Borisov wrote:
> 
> 
> On 22.08.19 г. 22:10 ч., Josef Bacik wrote:
> > If there are pending tickets and we are overcommitted we will simply
> > return free'd reservations to space_info->bytes_may_use if we cannot
> > overcommit any more.  This is problematic because we assume any free
> > space would have been added to the tickets, and so if we go from an
> > overcommitted state to not overcommitted we could have plenty of space
> > in our space_info but be unable to make progress on our tickets because
> > we only refill tickets from previous reservations.
> > 
> > Consider the following example.  We were allowed to overcommit to
> > space_info->total_bytes + 2mib.  Now we've allocated all of our chunks
> > and are no longer allowed to overcommit those extra 2mib.  Assume there
> > is a 3mib reservation we are now freeing.  Because we can no longer
> > overcommit we do not partially refill the ticket with the 3mib, instead
> > we subtract it from space_info->bytes_may_use.  Now the total reserved
> > space is 1mib less than total_bytes, meaning we have 1mib of space we
> > could reserve.  Now assume that our ticket is 2mib, and we only have
> > 1mib of space to reclaim, so we have a partial refilling to 1mib.  We
> > keep trying to flush and eventually give up and ENOSPC the ticket, when
> > there was the remaining 1mib left in the space_info for usage.
> 
> The wording of this paragraph makes it a bit hard to understand. How
> about something like:

I got lost there too. It's hard too keep track of what changes,
something a bit more strucutred could help understanding it.

Also the subject is too generic, I'd suggest "update overcommit logic
when refilling tickets" or something like that. Using 'rework' or
'revamp' in the subject applies to very few patches.
