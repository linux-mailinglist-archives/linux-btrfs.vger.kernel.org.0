Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49A7257A43
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHaNTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:19:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:40706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgHaNTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:19:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A651AD04;
        Mon, 31 Aug 2020 13:19:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EA3EDA840; Mon, 31 Aug 2020 15:18:25 +0200 (CEST)
Date:   Mon, 31 Aug 2020 15:18:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Steve Keller <keller.steve@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Link count for directories
Message-ID: <20200831131825.GX28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Steve Keller <keller.steve@gmx.de>,
        linux-btrfs@vger.kernel.org
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 21, 2020 at 07:40:19PM +0200, Steve Keller wrote:
> Are there any plans to implement the traditional link count behavior in btrfs,
> as described in the following URL?
> 
> https://btrfs.wiki.kernel.org/index.php/Project_ideas#Track_link_count_for_directories
> 
> Would it be a major effort to do so?  I'd really like that feature.

So the main concern is backward compatibility and what would happen if a
filesystem with nlink tracking gets mounted by a kernel without the
support. The wiki project entry seems to be too optimistic regarding
that (and I think it was me adding it there):

  It seems that the link count can be tracked like the other filesystems
  do. This will be even backward compatible:

  * for new directories and subvolumes , set the initial link count to 2
  * a mkdir/rmdir/move/snapshot will update the link count accordingly
    iff the current link count is not 1

Bad scenario:

* new kernel creates directory with many sudirectories, with nlink eg 100
* reboot to an older kernel
* delete some of the subdirectories, nlink untouched and silently out of
  sync
* reboot to new kernel
* creating more subdirectories will not fix nlink, only add the new
  entries, and deletion can go below zero (though it would stay stop at
  1)

This does not sound unrealistic to me, eg booting a new kernel after
update and then going back because some random driver does not work.
All the directories created meanwhile will be affected.

Usually such incompatibilies are shielded by incompat bits but in this
case it sounds like a too heavy measure for a minor performance
optimization.

I'll move the project idea away with explanation why it's not
implemented.
