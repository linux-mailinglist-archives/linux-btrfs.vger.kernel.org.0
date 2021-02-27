Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E165326DB0
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 16:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhB0P7G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 27 Feb 2021 10:59:06 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38714 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhB0P7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Feb 2021 10:59:05 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EDCA79AA0E8; Sat, 27 Feb 2021 10:58:20 -0500 (EST)
Date:   Sat, 27 Feb 2021 10:58:20 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Message-ID: <20210227155820.GL32440@hungrycats.org>
References: <cover.1614028083.git.kreijack@inwind.it>
 <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
 <20210223135330.GU1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210223135330.GU1993@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 23, 2021 at 02:53:30PM +0100, David Sterba wrote:
> On Mon, Feb 22, 2021 at 10:19:06PM +0100, Goffredo Baroncelli wrote:
> > From: Goffredo Baroncelli <kreijack@inwind.it>
> > 
> > This ioctl is a base for returning / setting information from / to  the
> > fields of the btrfs_dev_item object.
> 
> Please don't add a new ioctl for properties, they're using the xattr as
> interface alrady.

We had some earlier discussion about why xattrs on an inode are a
bad idea for this feature:

	https://lore.kernel.org/linux-btrfs/20210123172118.GJ28049@hungrycats.org/

TL;DR they shouldn't be copied from one filesystem to another.

Maybe it's better from a CLI UI point of view to put them under 'btrfs
dev' instead of 'btrfs property'?
