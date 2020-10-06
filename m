Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4428442F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJFDLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 23:11:02 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47766 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJFDLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 23:11:02 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1010883E6B8; Mon,  5 Oct 2020 23:11:00 -0400 (EDT)
Date:   Mon, 5 Oct 2020 23:11:00 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Casey Matson-deKay <caseymdk@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Best way to break RAID5/6?
Message-ID: <20201006031100.GL5890@hungrycats.org>
References: <CAG8D92WMf8x8YX-tMd48ZS0aEABxc2keBukwh1VeS9nryExk0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG8D92WMf8x8YX-tMd48ZS0aEABxc2keBukwh1VeS9nryExk0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 05, 2020 at 06:46:53PM -0700, Casey Matson-deKay wrote:
> Hi all,
> 
> I'm new to the community, but love the work being done here. I'm an
> embedded C developer and PCB designer, and would like to get involved
> in btrfs.
> 
> I, like many, am frustrated at the mystery of raid5/6 functionality.
> More for the learning experience than anything, I was wondering about
> the best known methods to break raid5/6 in a test setup, in order to
> understand the patterns by which it breaks, and eventually, play
> around with the kernel code to understand what's going on more in
> depth.

Welcome to btrfs!

Here's a list of known raid5 bugs with background references:

	https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/

> My initial thought, taking 3 USB drives, configuring them in RAID5,
> and pulling one out during a write, seems a bit simplistic. Are there

Just pulling one out is sufficient to hit the first bug:  some reads
fail in degraded mode.  

> known raid failure modes that would be more apt for learning and
> understanding where the raid bugs lie in btrfs, and how to trigger and
> explore them?
> 
> Thank you!
> 
> Casey
