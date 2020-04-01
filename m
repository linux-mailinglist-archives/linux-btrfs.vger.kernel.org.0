Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EBD19B8F6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 01:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgDAXbK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 19:31:10 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48524 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAXbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 19:31:10 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4D921648E38; Wed,  1 Apr 2020 19:31:09 -0400 (EDT)
Date:   Wed, 1 Apr 2020 19:31:09 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     halfdog <me@halfdog.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: FIDEDUPERANGE woes may continue (or unrelated issue?)
Message-ID: <20200401233109.GF13306@hungrycats.org>
References: <2442-1582352330.109820@YWu4.f8ka.f33u>
 <31deea37-053d-1c8e-0205-549238ced5ac@gmx.com>
 <1560-1582396254.825041@rTOD.AYhR.XHry>
 <13266-1585038442.846261@8932.E3YE.qSfc>
 <20200325035357.GU13306@hungrycats.org>
 <3552-1585216388.633914@1bS6.I8MI.I0Ki>
 <20200326132306.GG2693@hungrycats.org>
 <1911-1585557446.708051@Hw65.Ct0P.Jhsr>
 <3800-1585642410.029742@bHdF.V1R4.bmTu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3800-1585642410.029742@bHdF.V1R4.bmTu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 31, 2020 at 08:13:30AM +0000, halfdog wrote:
> halfdog writes:
> > Zygo Blaxell writes:
> >> ...
> >> I would try a mainline kernel just to make sure Debian didn't
> >> backport something they shouldn't have.
> >
> > OK, so let's go for that... If I got you right, you mentioned
> > two scenarios, that might yield relevant information:
> >
> > * Try a mainline kernel prior to "reloc_root" to see if the bug
> >   could already be reproduced with that one.
> > * Try a new 5.5.3 or later to see if the bug still can be reproduced.
> >
> > Which of both would be or higher value to you for the first test?
> >
> > Could you please share a kernel.org link to the exact tarball
> > that should be tested? If there is a specific kernel configuration
> > you deem superior for tests, that would be useful too. Otherwise
> > I would use one from a Debian package with a kernel version quite
> > close and adapt it to the given kernel.
> 
> Yesterday I started preparing test infrastructure and to see
> if my old test documentation still works with current software.
> I ran a modified trinity test on a 128MB btrfs loop mount. The
> test started at 12:02, at 14:30 trinity was OOM killed. As I
> did not monitor the virtual machine, over the next hours without
> trinity running any more also other processes were killed one
> after another until at 21:13 finally also init was killed.
> 
> As I run similar tests for many days on ext4 filesystems, could
> this be related to a btrfs memory leak even leaking just due
> to the btrfs kernel workers? 

How big is the test VM?  I run btrfs on machines as small as 512M,
but no smaller--and I don't try to do memory-hungry things like dedupe
or balance on such machines.  Some kernel debug options use a lot of
memory too, or break it up into pieces too small to use (e.g. KASAN and
the btrfs ref verifier).

> If so, when compiling a test kernel,
> is there any option you recommend setting to verify/rule out/
> pin-point btrfs leakage with trinity?

There is kmemleak.

You can also run 'slabtop' and just watch the numbers grow.
'slabtop' usually names the thing that is leaking.

If the thing you've got too much of is btrfs_delayed_ref_head,
you should definitely go back to 4.19 for now.

> > ...
> 
