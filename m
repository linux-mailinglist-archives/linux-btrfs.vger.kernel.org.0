Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAD22FA4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG0Urj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG0Urj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 16:47:39 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD49C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 13:47:39 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1k0A20-00066E-9i; Mon, 27 Jul 2020 21:47:32 +0100
Date:   Mon, 27 Jul 2020 21:47:32 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Understanding "Used" in df
Message-ID: <20200727204732.GJ12186@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3225288.0drLW0cIUP@merkaba>
 <20200723045106.GL10769@hungrycats.org>
 <1622535.kDMmNaIAU4@merkaba>
 <558ef4c5-ee61-8a0d-5ca5-43a07d6e64ac@gmail.com>
 <CAJCQCtRgug3uTLBuraWmCiCoAY9VV94nQ0TBXz9jkUyuRhLnzQ@mail.gmail.com>
 <8034c0e6-a1d2-5ba9-fdcf-d9b355fd34d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8034c0e6-a1d2-5ba9-fdcf-d9b355fd34d1@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 10:48:18PM +0300, Andrei Borzenkov wrote:
> 27.07.2020 22:30, Chris Murphy пишет:
> > On Mon, Jul 27, 2020 at 10:43 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> >>
> >> Unfortunately, "df" does not display "free" (I was wrong in other post).
> >> But using stat ...
> >>
> >>
> >> $ LANGUAGE=en stat -f .
> >> ...
> >> Block size: 4096       Fundamental block size: 4096
> >> Blocks: Total: 115164174  Free: 49153062   Available: 43297293
> >>
> >> $ LANGUAGE=en df -B 4K .
> >> Filesystem     4K-blocks     Used Available Use% Mounted on
> >> /dev/sda4      115164174 66011112  43297293  61% /
> >>
> >> 115164174 - 49153062 == 66011112
> >>
> >> But there is no way you can compute Available from other values - it is
> >> whatever filesystem returns.
> >>
> > 
> > It's definitely goofy in the odd device raid1 case.
> 
> Well, I already explained why it happens. Yes, it looks like a bug, the
> question is how to do better estimation without performing exhaustive
> single-chunk allocation every time. Three equal size devices looks
> simple, but consider general case of multiple devices of different size
> or different amount of free space.

   There's an O(n^2) algorithm in the number of devices. It's what I
used to implement the online space checker[1]. I've put up a write up
of the process at [2]. Without proof -- I wasn't able to work it out
-- but nobody's been able to catch it out yet.

   Hugo.

[1] https://carfax.org.uk/btrfs-usage/
[2] https://carfax.org.uk/files/temp/btrfs-allocator.pdf

-- 
Hugo Mills             | >squeek< *POP*
hugo@... carfax.org.uk | gluglugluglug
http://carfax.org.uk/  | <pause>
PGP: E2AB1DE4          | gluglugluglug!
