Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F6321C4FE
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgGKQD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKQD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 12:03:26 -0400
X-Greylist: delayed 2615 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Jul 2020 09:03:26 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A6C08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 09:03:26 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1juHI3-0007NM-AV; Sat, 11 Jul 2020 16:19:47 +0100
Date:   Sat, 11 Jul 2020 16:19:47 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Stirling Westrup <swestrup@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Rebalancing Question
Message-ID: <20200711151947.GA12186@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Stirling Westrup <swestrup@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJt7KB-c4vRYgjJ1WZJyNZuey6nH=y2BcQNVYJa6YAG9MTfKhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJt7KB-c4vRYgjJ1WZJyNZuey6nH=y2BcQNVYJa6YAG9MTfKhQ@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 11, 2020 at 10:42:30AM -0400, Stirling Westrup wrote:
> I have a BTRFS built with two devices md0 and md1 on a server. I wish
> to move as much data as will fit from md0 to md1, but I cannot figure
> out a balance command that will do that.
> 
> My use case is a file server with a fixed number of hard drive slots
> and two raids. md0 is a raid using most of the slots with small
> drives, and md1 is a raid using the remaining slots with large drives.
> I'm trying to shrink md0, so I can remove some small drives and put in
> new large drives to add to md1.
> 
> I have read the notes on the balance command several times but I can't
> figure out how to get it to do what I want, if it's even possible.

   Balance isn't the right tool for this. You can reduce the size that
the FS takes up on md0, using "btrfs fi resize 0:10G /mount/btrfs",
where the 0 is the device ID of md0 (see btrfs fi show), and the 10G
is the target size for the device. You can then use the mdadm tools to
reduce the size of md0 (but no smaller than 10G, in this example).

   I would definitely recommend reducing the FS by more than the
device, just to cope with any rounding errors in tooling.

   If you're removing md0 entirely from the FS, and have space to do
so, then btrfs dev delete is what you need -- but it sounds like
that's not the case here.

   Hugo.

-- 
Hugo Mills             | Great films about cricket: Monster's No-Ball
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
