Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6933F272
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCQOUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 10:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhCQOTg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 10:19:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81FF7AC47;
        Wed, 17 Mar 2021 14:19:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68BD3DA6E2; Wed, 17 Mar 2021 15:17:33 +0100 (CET)
Date:   Wed, 17 Mar 2021 15:17:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-btrfs@vger.kernel.org, sbabic@denx.de, ngompa13@gmail.com,
        Claudius Heine <ch@denx.de>, osandov@osandov.com
Subject: Re: Fwd: btrfs-progs: libbtrfsutil is under LGPL-3.0 and statically
 liked into btrfs
Message-ID: <20210317141733.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        linux-btrfs@vger.kernel.org, sbabic@denx.de, ngompa13@gmail.com,
        Claudius Heine <ch@denx.de>, osandov@osandov.com
References: <YFHtnGvRH+QlwRN6@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFHtnGvRH+QlwRN6@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 12:53:00PM +0100, Adam Borowski wrote:
> This is https://bugs.debian.org/985400
> 
> ----- Forwarded message from Claudius Heine <ch@denx.de> -----
> 
> Dear Maintainer,
> 
> I looked into the licenses of the btrfs-progs project and found that the
> libbtrfsutils library is licensed under LGPL-3.0-or-later [1]
> 
> The `copyright` file does not show this this.
> 
> IANAL, but I think since `btrfs` (under GPL-2.0-only [2]) links to `libbtrfsutil`
> statically this might cause a license conflict. See [3]. This would be the part
> that might require upstream fixing.

Thanks for bringing it up.

> [1] https://github.com/kdave/btrfs-progs/blob/master/libbtrfsutil/btrfsutil.h
> [2] https://github.com/kdave/btrfs-progs/blob/master/btrfs.c
> [3] http://gplv3.fsf.org/dd3-faq#gpl-compat-matrix

As explained in that link

 "Use a library" means that you're not copying any source directly, but
 instead interacting with it through linking, importing, or other
 typical mechanisms that bind the sources together when you compile or
 run the code.

the static link applies and the licenses do not allow that. So what are
the options:

- relicense libbtrfsutil to LGPL v2.1 or later
- relicense libbtrfsutil to LGPL v2.1 only

There was another request to relicense it
https://lore.kernel.org/linux-btrfs/b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de/

I'm not aware of any objections to relicensing, it hasn't happend in
5.11 due to time reasons but I think 5.12 is feasible.

If there's anybody willing to drive the process please let me know. The
mpv project did relicensing as well and we can draw some inspiration
from there https://github.com/mpv-player/mpv/issues/2033 . It took them
like 5 years but the number of contributors we'd need to ask is small and
most of them are known so it should not take more than a month.
