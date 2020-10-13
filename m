Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBD28D6BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 01:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgJMXB0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 13 Oct 2020 19:01:26 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40254 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgJMXB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 19:01:26 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 19:01:26 EDT
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D384E850147; Tue, 13 Oct 2020 18:54:49 -0400 (EDT)
Date:   Tue, 13 Oct 2020 18:54:49 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "@hungrycats.org"@hungrycats.org
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Raid5 Write Hole: Is it worse than in MD?
Message-ID: <20201013225449.GQ5890@hungrycats.org>
References: <em46b9d48d-39d4-44bc-9fd7-a08d9a96fca2@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <em46b9d48d-39d4-44bc-9fd7-a08d9a96fca2@ryzen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 13, 2020 at 09:34:50AM +0000, Hendrik Friedel wrote:
> Hello,
> 
> I recently read this article about the write-hole in md:
> https://lwn.net/Articles/665299/
> 
> Whilst the article is focused on the journal as a fix for the write hole (by
> the way: Is that possible with btrfs?), it made me wonder, if the write hole
> in btrfs is any worse than in md?

It is hard to compare them directly, because write hole is only one of
several ways a raid5 array can fail on either mdadm or btrfs, and both
have significant shortcomings.

btrfs and mdadm have separate strengths and weaknesses in their raid5
implementations.  e.g. btrfs can often recover from data corruption that
is not reported by the drives, while mdadm can't detect or repair it.
On the other hand, mdadm has no problems reading a degraded non-corrupted
raid5 array that I know of, while btrfs has some known troubles there.

It's possible to implement a raid5 stripe update journal (or tree), but
it's not the only possible solution (or only part of a complete solution).
Other possible solutions include:

	- adjust the allocator to minimize stripe RMW update operations
	(effectively banning them outright for datacow and metadata), or

	- throw out the existing raid5/6 implementation and start
	over with an implementation that works in harmony with the
	copy-on-write semantics, more like the way data compression in
	btrfs works now (effectively solving the problem the same way
	ZFS did).

These all have various performance and capability tradeoffs.  Some of
them can even be combined (e.g. minimize RMW updates with allocator
changes, fall back to stripe log tree for the rest).

> Regards,
> Hendrik
> 
