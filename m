Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB919DBA2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 18:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404398AbgDCQ2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 12:28:11 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:57500 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404229AbgDCQ2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 12:28:11 -0400
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1jKPAq-0002so-T4; Fri, 03 Apr 2020 17:28:04 +0100
Date:   Fri, 3 Apr 2020 17:28:04 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     kreijack@inwind.it
Cc:     Michael <mclaud@roznica.com.ua>,
        Steven Davies <btrfs-list@steev.me.uk>,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
Message-ID: <20200403162804.GT32577@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>, kreijack@inwind.it,
        Michael <mclaud@roznica.com.ua>,
        Steven Davies <btrfs-list@steev.me.uk>, linux-btrfs@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>
References: <20200401200316.9917-1-kreijack@libero.it>
 <20200401200316.9917-2-kreijack@libero.it>
 <236b9155-c2e1-3ed6-f2c7-b71e3c86ac2c@steev.me.uk>
 <cac4903c-7559-93bc-d2a3-cbb8bc223a34@roznica.com.ua>
 <70bd2bfd-cbfe-1d35-6057-d0e6830fc1fe@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70bd2bfd-cbfe-1d35-6057-d0e6830fc1fe@libero.it>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 06:19:59PM +0200, Goffredo Baroncelli wrote:
> On 4/3/20 10:43 AM, Michael wrote:
> > 02.04.2020 12:33, Steven Davies пишет:
> > > On 01/04/2020 21:03, Goffredo Baroncelli wrote:
> > > > From: Goffredo Baroncelli <kreijack@inwind.it>
> [...]
> > > > To enable this mode pass -o ssd_metadata at mount time.
> > > > 
> > > > Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > The idea of this sounds similar to what Anand has been working on with the readmirror patchset[1] which was originally designed to prefer reading from SSD devices in a RAID1 configuration but has evolved into allowing the read policy to be configured through sysfs, at least partly because detecting SSDs correctly is not an exact science. Also, there may be more considerations than just HDD or SSD: for example in my system I use a SATA SSD and an NVMe SSD in RAID1 where the NVMe device is twice the speed of the SSD.
> > May be something like -o metadata_preferred_devices=device_id,[device_id,[device_id]]... ?
> 
> I think that it should be a device property instead of a device list passed at mount time.
> Looking at the btrfs_dev_item structure (which is embedded in the super block), there are several promising fields:
> - seek_speed
> - bandwidth
> - dev_group
> 
> currently these fields are unused.

   The first two of these at least were left over from the last
attempt at this which got anywhere near code.

   If you're going to do this kind of thing, please read (at least) my
(sadly code-less; sorry) proposal from a few years ago:

https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg33632.html

   Essentially, allowing for multiple policies for chunk allocation,
of which this case is a small subset.

   I'd envisaged putting the relevant config data into properties, but
since we didn't actually have them in any sense at the time, I got
bogged down in that part of it.

> Se we are free to use as we wish. For example, if we use 2 bit of dev_group as marker
> for "not for metadata" and "not for date" we can have the following combination:
> - 0 (default) -> the disk is suitable for both data and metadata
> - "not for metadata" -> the disk has an high priority for "data"
> - "not for data" -> the disk has an high priority for "metadata"
> - "not for data" and "not for metadata" -> invalid
> 
> As kernel<->user space interface, I like the idea to export these bits via sysfs.. unfortunately there is no a directory for the devices.... :-(
> 
> 
> > > 
> > > I would therefore vote for configurability of this rather than always choosing SSD over HDD.
> > > 
> > > [1] https://patchwork.kernel.org/project/linux-btrfs/list/?series=245121
> > > 
> > 
> 
> 

-- 
Hugo Mills             | Some days, it's just not worth gnawing through the
hugo@... carfax.org.uk | straps
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
