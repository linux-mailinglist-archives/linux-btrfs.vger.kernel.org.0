Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FA7DEA90
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 03:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbjKBCNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbjKBCNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 22:13:34 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA37FE4
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 19:13:31 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C5C45AD6539; Wed,  1 Nov 2023 22:13:17 -0400 (EDT)
Date:   Wed, 1 Nov 2023 22:13:17 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Pedro Macedo <pmacedo@pmacedo.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the
 rest empty
Message-ID: <ZUMFvRDAragUzhlY@hungrycats.org>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
 <20231026021551.55802873@nvm>
 <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
 <21245ede-7ef3-40ad-828f-91f6845e9273@pmacedo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21245ede-7ef3-40ad-828f-91f6845e9273@pmacedo.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 01, 2023 at 08:20:56PM +0100, Pedro Macedo wrote:
> 
> On 27.10.23 06:21, Anand Jain wrote:
> > On 10/26/23 05:15, Roman Mamedov wrote:
> > > On Wed, 25 Oct 2023 17:08:08 -0400
> > > Remi Gauvin <remi@georgianit.com> wrote:
> > > 
> > > > On 2023-10-25 4:29 p.m., Peter Wedder wrote:
> > > > > Hello,
> > > > > 
> > > > > I had a RAID1 array on top of 4x4TB drives. Recently I
> > > > > removed one 4TB drive and added two 16TB drives to it. After
> > > > > running a full, unfiltered balance on the array, I am left
> > > > > in a situation where all the 4TB drives are completely
> > > > > empty, and all the data and metadata is on the 16TB drives.
> > > > > Is this normal? I was expecting to have at least some data
> > > > > on the smaller drives.
> > > > > 
> > > > 
> > > > Yes, this is normal.  The BTRFS allocates space in drives with the the
> > > > most available free space.  The idea is to balance the 'unallocated'
> > > > space on each drive, so they can be filled evenly.  The 4TB drives will
> > > > be used when the 16TB dives have less than 4TB unallocated.
> > > 
> > 
> > Correct. That's the only allocation method we have at the moment. Do you
> > have any feedback on whether there are any other allocation methods that
> > make sense?
> 
> 
> IMHO, based on the frequency of this question appearing here/on reddit/other
> sites, perhaps allocation by absolute space used?  It should fit the
> expectations of most folks that if you have free space on a disk it will be
> utilised, plus has potential performance implications by always using as
> many devices as possible to write to as long as they have any space left.

That is how allocation works with striped profiles:  chunks are allocated
using space from all non-full drives, in order to use space and iops
optimally.

For a non-striped profile like raid1, it's not possible to use all the
space without filling the larger devices first.  As the large devices
fill up, their free space becomes equal in size to the smaller devices,
and it's always possible to completely fill a raid1 array of equal-sized
devices.  If raid1 distributed data across the small devices at the same
time as the large devices, it would run out of space on small devices
before running out of space on the large ones, so significant space on
some devices would be wasted.

In some cases you really do want the data distributed across all the small
devices first, even though some of the space can't be used at first.
e.g. you plan to replace the small devices with larger ones later,
and you don't want to have to do an expensive balance operation each
time you replace a small device with a large one.  In that case, you
can use 'btrfs fi resize' to set the larger devices to the same size
as the smaller devices.  That will provide the equal filling of the
devices you want as the small devices fill up, and it will run out of
space when the only free space remaining is all on the large device.
Before that happens, you can replace the small devices with larger ones,
resize all the devices to the same size as the large one, and fill the
devices equally until all available space is used.  You'd have to manage
the device sizes yourself, because there's no way btrfs could guess you
planned to do this in advance.



> Regards,
> 
> Pedro
> 
> 
> > 
> > Thanks, Anand
> > 
> > > Interesting question and resolution. I'd be surprised by that as well.
> > > 
> > > Now, a great chance to "btrfs dev delete" all three remaining 4TB
> > > drives and
> > > unplug them for the time being, to save on noise, heat and power
> > > consumption!
> > 
