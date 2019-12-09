Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A069F117133
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLIQLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 11:11:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:46538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfLIQLz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 11:11:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B12E5B109;
        Mon,  9 Dec 2019 16:11:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DEBC8DA783; Mon,  9 Dec 2019 17:11:45 +0100 (CET)
Date:   Mon, 9 Dec 2019 17:11:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Sebastian <sebastian.scherbel@fau.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 0/2] btrfs: Move dereference behind null checks
Message-ID: <20191209161144.GJ2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Sebastian <sebastian.scherbel@fau.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
References: <20191207221818.3641-1-sebastian.scherbel@fau.de>
 <ba7c4979-3f5b-4efc-49aa-9e1f130a5876@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7c4979-3f5b-4efc-49aa-9e1f130a5876@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 10:30:06AM +0100, Johannes Thumshirn wrote:
> On 07/12/2019 23:18, Sebastian wrote:
> > From: Sebastian Scherbel <sebastian.scherbel@fau.de>
> > 
> > Regarding Bug 205003, points 1 and 2
> > This patch series moves two dereferences after the null check to avoid
> > a possible null pointer dereference.
> > 
> > Sebastian Scherbel (2):
> >   btrfs: Move dereference behind null check in check integrity
> >   btrfs: Move dereference behind null check in check volumes
> > 
> >  fs/btrfs/check-integrity.c | 4 +++-
> >  fs/btrfs/volumes.c         | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> 
> I've already submitted a series addressing these and David merged it:
> https://lore.kernel.org/linux-btrfs/20191205131959.19184-1-jth@kernel.org/

Yes, that's been in misc-next since ~friday, I'm not sure when I pushed
the branch.

Sebastian, thanks for the patches, this sometimes happens that the work
is duplicated. Johannes removed the BUG_ON and WARN_ON completely though
your change is also correct assuming that the two are not redundant.
