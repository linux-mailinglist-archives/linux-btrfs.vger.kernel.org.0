Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615093B6A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbfFJOBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 10:01:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390384AbfFJOBs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 10:01:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1125FADE6;
        Mon, 10 Jun 2019 14:01:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B319DAC87; Mon, 10 Jun 2019 16:02:36 +0200 (CEST)
Date:   Mon, 10 Jun 2019 16:02:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hugo Mills <hugo@carfax.org.uk>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Message-ID: <20190610140235.GF30187@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hugo Mills <hugo@carfax.org.uk>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559917235.git.dsterba@suse.com>
 <20190610124226.GA21016@carfax.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610124226.GA21016@carfax.org.uk>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 10, 2019 at 12:42:26PM +0000, Hugo Mills wrote:
>    Hi, David,
> 
> On Mon, Jun 10, 2019 at 02:29:40PM +0200, David Sterba wrote:
> > this patchset brings the RAID1 with 3 and 4 copies as a separate
> > feature as outlined in V1
> > (https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).
> [...]
> > Compatibility
> > ~~~~~~~~~~~~~
> > 
> > The new block group types cost an incompatibility bit, so old kernel
> > will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
> > the filesystem with the new type.
> > 
> > To upgrade existing filesystems use the balance filters eg. from RAID6
> > 
> >   $ btrfs balance start -mconvert=raid1c3 /path
> [...]
> 
>    If I do:
> 
> $ btrfs balance start -mprofiles=raid13c,convert=raid1 \
>                       -dprofiles=raid13c,convert=raid6 /path
> 
> will that clear the incompatibility bit?

No the bit will stay, even though there are no chunks of the raid1c3
type. Same for raid5/6.

Dropping the bit would need an extra pass trough all chunks after
balance, which is feasible and I don't see usability surprises. That you
ask means that the current behaviour is probably opposite to what users
expect.

> (I'm not sure if profiles= and convert= work together, but let's
> assume that they do for the purposes of this question).

Yes they work together.
