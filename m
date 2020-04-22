Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAECA1B42C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVLGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgDVLGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 07:06:47 -0400
X-Greylist: delayed 1361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Apr 2020 04:06:47 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68587C03C1A8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 04:06:47 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1jRDDK-0002gR-6E; Wed, 22 Apr 2020 12:06:46 +0100
Date:   Wed, 22 Apr 2020 12:06:46 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: RAID 1 | Newbie Question
Message-ID: <20200422110646.GF32577@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>,
        linux-btrfs@vger.kernel.org
References: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
 <20200422104403.GE32577@savella.carfax.org.uk>
 <d59a8a2e-2aae-0177-a0a8-6c238776814a@peter-speer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59a8a2e-2aae-0177-a0a8-6c238776814a@peter-speer.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 22, 2020 at 12:55:08PM +0200, Stefanie Leisestreichler wrote:
> 
> 
> On 22.04.20 12:44, Hugo Mills wrote:
> >     You can't set up btrfs RAID-1 to use only one device. It's only
> > possible to end up like that if you set up a 2-device RAID-1 and then
> > unplug a device and mount it in degraded mode.
> 
> It was this sentence in the btrfs wiki, what confused me, also comments in
> the net that btrfs is not giving you RAID with redundant data
> (https://btrfs.wiki.kernel.org/index.php/FAQ):
> 
> "It is possible with all of the descriptions below, to construct a RAID-1
> array from two or more devices, and have those devices live on the same
> physical drive. This configuration does not offer any form of redundancy for
> your data."

   There's a difference between "device" and "disk" here. If you make
two partitions on one device, and that device fails, then there's no
(disk) redundancy.

   If you make two partitions on one disk and one partition on another
disk, and use all three partitions (block devices) to make a RAID-1,
then you're still going to lose the filesystem if the disk with two
partitions on it fails.

   I'm not sure what the comments are about not giving redundant data
-- if you configure your FS to use one of the redundant RAID levels,
then that's what you get.

   Hugo.

-- 
Hugo Mills             | emacs: Eighty Megabytes And Constantly Swapping.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
