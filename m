Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39278326DA9
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB0PxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 27 Feb 2021 10:53:09 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37616 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhB0PxH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Feb 2021 10:53:07 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 966AA9AA0B2; Sat, 27 Feb 2021 10:52:23 -0500 (EST)
Date:   Sat, 27 Feb 2021 10:52:23 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Message-ID: <20210227155223.GK32440@hungrycats.org>
References: <cover.1614028083.git.kreijack@inwind.it>
 <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
 <20210223135330.GU1993@twin.jikos.cz>
 <e60ed8a6-833c-77ed-f5a0-b069680b2cab@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e60ed8a6-833c-77ed-f5a0-b069680b2cab@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 24, 2021 at 10:27:45AM +0800, Anand Jain wrote:
> On 23/02/2021 21:53, David Sterba wrote:
> > On Mon, Feb 22, 2021 at 10:19:06PM +0100, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > This ioctl is a base for returning / setting information from / to  the
> > > fields of the btrfs_dev_item object.
> > 
> > Please don't add a new ioctl for properties, they're using the xattr as
> > interface alrady.
> > 
> 
> IMO a feature like this can be in memory only initially[1]. And later
> when this feature is stable, add its on-disk.

The "metadata_only" and "data_only" settings need to be persistent for
the feature to really work.

It is very expensive to recover (need to balance metadata on a spinning
disk) if the filesystem allocates a new chunk after mount but before
userspace can reestablish the preferences.  The whole point of
metadata_only and data_only is that we never have to do that.

> [1] https://patchwork.kernel.org/project/linux-btrfs/patch/0ed770d6d5e37fc942f3034d917d2b38477d7d20.1613668002.git.anand.jain@oracle.com/
> 
> 
> Thanks, Anand
> 
