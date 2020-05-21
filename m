Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36A41DC6F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEUGUp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 21 May 2020 02:20:45 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34814 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUGUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 May 2020 02:20:44 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C58E26D2DC4; Thu, 21 May 2020 02:20:43 -0400 (EDT)
Date:   Thu, 21 May 2020 02:20:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     Justin Engwer <justin@mautobu.com>, linux-btrfs@vger.kernel.org
Subject: Re: I think he's dead, Jim
Message-ID: <20200521062043.GE10769@hungrycats.org>
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <20200520013255.GD10769@hungrycats.org>
 <20200520205319.GA26435@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200520205319.GA26435@latitude>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 10:53:19PM +0200, Johannes Hirte wrote:
> On 2020 Mai 19, Zygo Blaxell wrote:
> > 
> > Corollary:  Never use space_cache=v1 with raid5 or raid6 data.
> > space_cache=v1 puts some metadata (free space cache) in data block
> > groups, so it violates the "never use raid5 or raid6 for metadata" rule.
> > space_cache=v2 eliminates this problem by storing the free space tree
> > in metadata block groups.
> > 
> 
> This should not be a real problem, as the space-cache can be discarded
> and rebuild anytime. Or do I miss something?

Keep in mind that there are multiple reasons to not use space_cache=v1;
space_cache=v1 is quite slow, especially on filesystems big enough that
raid5 is in play, even when it's not recovering from integrity failures.

The free space cache (v1) is stored in nodatacow inodes, so it has all
the btrfs RAID data integrity problems of nodatasum, plus the parity
corruption and write hole issues of raid5.  Free space tree (v2) is
stored in metadata, so it has csums to detect data corruption and transid
checks for dropped writes, and if you are using raid1 metadata you also
avoid the parity corruption bug in btrfs's raid5/6 implementation and
the write hole.  v2 is faster too, especially at commit time.

The probability of undetected space_cache=v1 failure is low, but not zero.
In the event of failure, the filesystem should detect the error when it
tries to create new entries in the extent tree--they'll overlap existing
allocated blocks, and the filesystem will force itself read-only, so
there should be no permanent damage other than killing any application
that was writing to the disk at the time.

Come to think of it, though, the space_cache=v1 problems are not specific
to raid5.  You shouldn't use space_cache=v1 with raid1 or raid10 data
either, for the same reasons.

In the raid5/6 case it's a bit simpler:   kernels that can't do
space_cache=v2 (4.4 and earlier) don't have working raid5 recovery either.

> -- 
> Regards,
>   Johannes Hirte
> 
