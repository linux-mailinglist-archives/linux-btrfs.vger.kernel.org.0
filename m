Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955611C592D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgEEOWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 10:22:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgEEOWt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 10:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB7D0AD03;
        Tue,  5 May 2020 14:22:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 56F0ADA726; Tue,  5 May 2020 16:22:00 +0200 (CEST)
Date:   Tue, 5 May 2020 16:22:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: supporting zstd fast levels on Btrfs
Message-ID: <20200505142200.GT18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nick Terrell <terrelln@fb.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQSevDB5kaGTSS1TfQKen+BY5krKvHUZc4MKVPZCypiPg@mail.gmail.com>
 <BBF3FE73-8797-4E4F-9802-984897A42AF1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BBF3FE73-8797-4E4F-9802-984897A42AF1@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 05, 2020 at 04:39:45AM +0000, Nick Terrell wrote:
> > On May 4, 2020, at 6:31 PM, Chris Murphy <lists@colorremedies.com> wrote:
> > 
> > Looks like since zstd v1.3.4 there are five negative levels (also
> > --fast levels), that looks like they'd be in the ballpark of competing
> > with lz4. That might be useful even with some of the faster NVMe
> > drives, ~2G/s.
> > 
> > Any idea if it's possible or even likely?
> 
> Zstd in the kernel would have to be updated to a newer version for this to be possible.
> As zstd development slows down, I want to spend some time to update the version in
> the kernel. But, I don’t expect to find the time to do this for some time.
> 
> After that there is a limitation in the number of bits required to store the compression
> Level. Last time I looked there were 15 possible values. These naturally map to
> compression levels 1-15. That isn’t necessarily set in stone, but the BtrFS folks would
> could answer that better.

The 4 bits for level are arbitrary for now, only for in-memory tracking
and not stored on-disk. Also I think that 15 levels should be enough, so
even if the number can be changed I don't see it as likely.

Possible improvements in the speed/ratio trade offs in the levels sound
OK to me, the only constraint is to keep the default at 3 with more or
less same performance/ratio. Let's say the level 1 implementation can be
changed to the fast levels as mentioned above, as this still meets the
user expectation of fast/lor-ratio outcome.
