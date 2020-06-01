Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1891EA8A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFARw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 13:52:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgFARw5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 13:52:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83957AC7D;
        Mon,  1 Jun 2020 17:52:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DAF2DA79B; Mon,  1 Jun 2020 19:52:52 +0200 (CEST)
Date:   Mon, 1 Jun 2020 19:52:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: space_cache=v1 and v2 at the time time?
Message-ID: <20200601175252.GC18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQVPFi7fB+p4HEVy1Gw3AjzrvQ8qcY6cRbKj3T-+7yVxA@mail.gmail.com>
 <c33f3305-a265-d2a4-75e3-9bdd850604f8@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33f3305-a265-d2a4-75e3-9bdd850604f8@knorrie.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 11:04:07PM +0200, Hans van Kranenburg wrote:
> Hi,
> 
> On 5/27/20 4:12 AM, Chris Murphy wrote:
> > What are the implications of not clearing v1 before enabling v2?
> > 
> > From btrfs insp dump-t, I still see the v1 bitmaps present:
> > 
> > root tree
> > leaf 6468501504 items 42 free space 9246 generation 22 owner ROOT_TREE
> > leaf 6468501504 flags 0x1(WRITTEN) backref revision 1
> > ...
> >     item 30 key (FREE_SPACE UNTYPED 22020096) itemoff 11145 itemsize 41
> >         location key (256 INODE_ITEM 0)
> >         cache generation 17 entries 0 bitmaps 0
> >     item 31 key (FREE_SPACE UNTYPED 1095761920) itemoff 11104 itemsize 41
> >         location key (257 INODE_ITEM 0)
> >         cache generation 17 entries 0 bitmaps 0
> > ...
> > 
> > 
> > And later the free space tree:
> > 
> > free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
> > leaf 6471073792 items 39 free space 15196 generation 22 owner FREE_SPACE_TREE
> > leaf 6471073792 flags 0x1(WRITTEN) backref revision 1
> > fs uuid 3c464210-08c7-4cf0-b175-e4b781ebea19
> > chunk uuid f1d18732-7c3d-401c-8637-e7d4d9c7a0b8
> >     item 0 key (1048576 FREE_SPACE_INFO 4194304) itemoff 16275 itemsize 8
> >         free space info extent count 2 flags 0
> >     item 1 key (1048576 FREE_SPACE_EXTENT 16384) itemoff 16275 itemsize 0
> >         free space extent
> >     item 2 key (1081344 FREE_SPACE_EXTENT 4161536) itemoff 16275 itemsize 0
> >         free space extent
> > ...
> > 
> > I was surprised there's no warning when I use space_cache=v2 without
> > first clearing v1.
> 
> It's just sitting there, occupying some space, doing nothing.

Hm that's not ideal, right? There's support in btrfs check,
"btrfs check --clear-space-cache v1", but it needs unmounted filesystem.
I don't remember if that was discussed when v2 was introduced, but it
seems strange. As we want to make v2 default soon, the conversion should
work without such surprises.
