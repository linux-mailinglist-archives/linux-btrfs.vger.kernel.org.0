Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6833ED75D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfJOMIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJOMIV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77A1EB2B4;
        Tue, 15 Oct 2019 12:08:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 395D6DA7E3; Tue, 15 Oct 2019 14:08:31 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:08:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/19] btrfs: async discard support
Message-ID: <20191015120831.GS2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

thanks for working on this. The plain -odiscard hasn't been recommended
to users for a long time, even with the SATA 3.1 drives that allow
queueing the requests.

The overall approach to async discard sounds good, the hard part is not
shoot down the filesystem by trimming live data, and we had a bug like
that in the pastlive data, and we had a bug like that in the past. For
correctness reasons I understand the size of the patchset.

On Mon, Oct 07, 2019 at 04:17:31PM -0400, Dennis Zhou wrote:
> I am currently working on tuning the rate at which it discards in the
> background. I am doing this by evaluating other workloads and drives.
> The iops and bps rate limits are fairly aggressive right now as my
> basic survey of a few drives noted that the trim command itself is a
> significant part of the overhead. So optimizing for larger trims is the
> right thing to do.

We need a sane default behaviour, without the need for knobs and
configuration, so it's great you can have a wide range of samples to
tune it.

As trim is only a hint, a short delay in processing the requests or
slight ineffectivity should be acceptable, to avoid complications in the
code or interfering with other IO.

> Persistence isn't supported, so when we mount a filesystem, the block
> groups are read in as dirty and background trim begins. This makes async
> discard more useful for longer running mount points.

I think this is acceptable.

Regarding the code, I leave comments to the block group and trim
structures to Josef and will focus more on the low-level and coding
style or changelogs.
