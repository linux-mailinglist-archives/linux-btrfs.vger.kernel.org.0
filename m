Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917EA216BC6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGLjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 07:39:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgGGLjM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 07:39:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 489C8AE28;
        Tue,  7 Jul 2020 11:39:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2EFE3DA818; Tue,  7 Jul 2020 13:38:52 +0200 (CEST)
Date:   Tue, 7 Jul 2020 13:38:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz,
        "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
Message-ID: <20200707113851.GH27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
 <20200702114348.GJ27795@twin.jikos.cz>
 <486ad3ac-a6f4-ef94-7dfc-1a58b6a7b747@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486ad3ac-a6f4-ef94-7dfc-1a58b6a7b747@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 05:43:09PM +0800, Anand Jain wrote:
> On 2/7/20 7:43 pm, David Sterba wrote:
> > On Thu, Jul 02, 2020 at 09:11:20AM +0000, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote:
> >> Hi all,
> >>
> >> I'm collecting file extents for our application from BtrFs filesystem image.
> >> I've noticed that for some files a get the "wrong" physical offset for
> >> start of the extent. I verified it using hexdump of the filesystem
> >> image: when dump the content starting from the address returned from
> >> FIEMAP ioctl, I see that the content is absolutely different from the
> >> content of the file itself. Also, the FIEMAP ioctl reports regular
> >> extent, it is not inline.
> > 
> > There are 3 address spaces:
> > 
> > - device physical offsets
> > - filesystem physical offsets
> > - filesystem logical offsets
> > 
> > What you seem to expect is that device physical and filesystem physical
> > and the same. This is not true in general in btrfs and fiemap will
> > return only the filesystem offsets. To get to the device offsets you'd
> > need to do the reverse mapping.
> 
> Do you think is it a good idea to rather update vfs? A quick check 
> indicates struct fiemap_extent has reserved space to hold the devid, and 
> should handle the backward compatibility issues.

This was proposed a few years back on LSF/MM, whether to extend fiemap
with the device related information or to add a completely new ioctl
that would not have to extend the existing interface in a way that could
become unwieldy.
