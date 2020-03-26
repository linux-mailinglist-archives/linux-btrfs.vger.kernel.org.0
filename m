Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8995D193631
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 03:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCZCwG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 25 Mar 2020 22:52:06 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39064 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZCwF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 22:52:05 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6E1A4633AA4; Wed, 25 Mar 2020 22:51:56 -0400 (EDT)
Date:   Wed, 25 Mar 2020 22:51:56 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200326025156.GW13306@hungrycats.org>
References: <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
 <20200322234934.GE2693@hungrycats.org>
 <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
 <28ddb178-674b-fab7-afa4-18a575299c1d@cobb.uk.net>
 <20200325040950.GV13306@hungrycats.org>
 <SYBPR01MB38972C6A31FA985B0D9494109ECE0@SYBPR01MB3897.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <SYBPR01MB38972C6A31FA985B0D9494109ECE0@SYBPR01MB3897.ausprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 25, 2020 at 04:30:16AM +0000, Paul Jones wrote:
> > -----Original Message-----
> > From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> > owner@vger.kernel.org> On Behalf Of Zygo Blaxell
> > Sent: Wednesday, 25 March 2020 3:10 PM
> > To: Graham Cobb <g.btrfs@cobb.uk.net>
> > Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
> > Subject: Re: Question: how understand the raid profile of a btrfs filesystem
> 
> > Disk removes are where the current system breaks down.  'btrfs device
> > remove' is terrible:
> > 
> > 	- can't cancel a remove except by rebooting or forcing ENOSPC
> > 
> > 	- can't resume automatically after a reboot (probably a good
> > 	thing for now, given there's no cancel)
> > 
> > 	- can't coexist with a balance, even when paused--device remove
> > 	requires the balance to be _cancelled_ first
> > 
> > 	- doesn't have any equivalent to the 'convert' filter raid
> > 	profile target in balance info
> > 
> > so if you need to remove a device while you're changing profiles, you have to
> > abort the profile change and then relocate a whole lot of data without being
> > able to specify the correct target profile.
> > 
> > The proper fix would be to reimplement 'btrfs dev remove' using pieces of
> > the balance infrastructure (it kind of is now, except where it's not), and so
> > 'device remove' can keep the 'convert=' target.  Then you don't have to lose
> > the target profile while doing removes (and fix the other problems too).
> 
> I've often thought it would be handy to be able to forcefully set the
> disk size or free space to zero, like how it is reported by 'btrfs
> fi sh' during a remove operation. That way a balance operation can be
> used for various things like profile changes or multiple disk removals
> (like replacing 4x1T drives with 1x4T drive) without unintentionally
> writing a bunch of data to a disk you don't want to write to anymore.

I forgot "can only remove one disk at a time" in the list above.  We can
add multiple disks at once (well, add one at a time, then use balance to
do all the relocation at once), but the opposite operation isn't possible.

That is an elegant way to set up balances to do a device delete/shrink,
too.

> It would also allow for a more gradual removal for disks that need
> replacing but not as an emergency, as data will gradually migrate
> itself to other discs as it is COWed.
> 
> Paul.
