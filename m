Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58347DF44A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 14:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjKBNu2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 2 Nov 2023 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjKBNu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 09:50:26 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A67F883
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 06:50:23 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id A2C35AD807C; Thu,  2 Nov 2023 09:50:22 -0400 (EDT)
Date:   Thu, 2 Nov 2023 09:50:22 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Pedro Macedo <pmacedo@pmacedo.com>,
        Anand Jain <anand.jain@oracle.com>,
        Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the
 rest empty
Message-ID: <ZUOpHtII/SQZt1w7@hungrycats.org>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
 <20231026021551.55802873@nvm>
 <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
 <21245ede-7ef3-40ad-828f-91f6845e9273@pmacedo.com>
 <ZUMFvRDAragUzhlY@hungrycats.org>
 <SYCPR01MB4685B23E1FA74D65A3859BDE9EA6A@SYCPR01MB4685.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <SYCPR01MB4685B23E1FA74D65A3859BDE9EA6A@SYCPR01MB4685.ausprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 05:11:00AM +0000, Paul Jones wrote:
> > -----Original Message-----
> > From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> > Sent: Thursday, November 2, 2023 1:13 PM
> > To: Pedro Macedo <pmacedo@pmacedo.com>
> > Cc: Anand Jain <anand.jain@oracle.com>; Roman Mamedov
> > <rm@romanrm.net>; Remi Gauvin <remi@georgianit.com>; linux-
> > btrfs@vger.kernel.org
> > Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
> > empty
> > 
> > On Wed, Nov 01, 2023 at 08:20:56PM +0100, Pedro Macedo wrote:
> > >
> > > On 27.10.23 06:21, Anand Jain wrote:
> > > > On 10/26/23 05:15, Roman Mamedov wrote:
> > > > > On Wed, 25 Oct 2023 17:08:08 -0400 Remi Gauvin
> > > > > <remi@georgianit.com> wrote:
> > > > >
> > > > > > On 2023-10-25 4:29 p.m., Peter Wedder wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > I had a RAID1 array on top of 4x4TB drives. Recently I removed
> > > > > > > one 4TB drive and added two 16TB drives to it. After running a
> > > > > > > full, unfiltered balance on the array, I am left in a
> > > > > > > situation where all the 4TB drives are completely empty, and
> > > > > > > all the data and metadata is on the 16TB drives.
> > > > > > > Is this normal? I was expecting to have at least some data on
> > > > > > > the smaller drives.
> > > > > > >
> > > > > >
> > > > > > Yes, this is normal.  The BTRFS allocates space in drives with
> > > > > > the the most available free space.  The idea is to balance the
> > 'unallocated'
> > > > > > space on each drive, so they can be filled evenly.  The 4TB
> > > > > > drives will be used when the 16TB dives have less than 4TB
> > unallocated.
> > > > >
> > > >
> > > > Correct. That's the only allocation method we have at the moment. Do
> > > > you have any feedback on whether there are any other allocation
> > > > methods that make sense?
> > >
> > >
> > > IMHO, based on the frequency of this question appearing here/on
> > > reddit/other sites, perhaps allocation by absolute space used?  It
> > > should fit the expectations of most folks that if you have free space
> > > on a disk it will be utilised, plus has potential performance
> > > implications by always using as many devices as possible to write to as long
> > as they have any space left.
> > 
> > That is how allocation works with striped profiles:  chunks are allocated using
> > space from all non-full drives, in order to use space and iops optimally.
> > 
> > For a non-striped profile like raid1, it's not possible to use all the space
> > without filling the larger devices first.  As the large devices fill up, their free
> > space becomes equal in size to the smaller devices, and it's always possible to
> > completely fill a raid1 array of equal-sized devices.  If raid1 distributed data
> > across the small devices at the same time as the large devices, it would run
> > out of space on small devices before running out of space on the large ones,
> > so significant space on some devices would be wasted.
> 
> I was always under the impression that space was allocated from the
> emptiest drive(s) on a percentage basis. Was that ever the case and
> has since changed? That seems like the most optimal way to do it.

The current behavior was introduced in 2011, and hasn't changed since
except for regressions in 2015, 2022, and 2023 (now fixed).  Support for
zoned devices was added in 2020, but it doesn't affect regular device
behavior.

btrfs finds the largest contiguous free space block >= 1 GiB on each
device (using the lowest offset to break ties), then creates a chunk
using up to 1 GiB from each of the top N devices with the largest free
byte count (using devid to break ties), where N is the maximum number
of devices supported by the profile.

You could replace "largest free byte count" with "largest proportion
of free space" in the above, but that would only make sense if the
filesystem had never had drives added or replaced.  e.g. in cases where
you had already filled some devices, then replaced them with larger ones,
the space available on a device would not be correlated to its size
at all.

> 
> Paul.
