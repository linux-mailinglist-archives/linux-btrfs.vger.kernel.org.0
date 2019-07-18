Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AE6C8CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 07:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfGRFjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 01:39:54 -0400
Received: from verein.lst.de ([213.95.11.211]:56583 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfGRFjy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 01:39:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B59368AFE; Thu, 18 Jul 2019 07:39:51 +0200 (CEST)
Date:   Thu, 18 Jul 2019 07:39:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw
 buffers
Message-ID: <20190718053951.GA18122@lst.de>
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com> <20190716151133.GA6073@lst.de> <20190716152222.GJ9224@smile.fi.intel.com> <20190717153706.GJ20977@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717153706.GJ20977@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 17, 2019 at 05:37:06PM +0200, David Sterba wrote:
> > This entire patch because of BTRFS maintainers, they didn't want the explicit
> > casts. Maybe something has been changed, I dunno.
> 
> No change on our side. The uuids are u8 in the on-disk structures, that
> will stay. The uuid functions use a different type so the casts have to
> be added, that's clear. The question is if it's up to the API to provide
> functions that take u8, or btrfs code to put typecasts everywhere or
> carry own wrappers that do that.

So why do you insist on the u8 for the on-disk format?  uuid_t is
defined in RFC4122 as a stable format, and one of the two origins of
our uuid_t infrastructure is the XFS code, where it is used for the
on-disk format.  What is different in btrfs?

> Specifically for uuid, the endianness might matter, so that we use the
> raw buffers makes things more explicit.

u8 arrays hide the endianess, while the RFC4122 UUID is very clearly
defined as having big endian fields where they are bigger than a byte.
