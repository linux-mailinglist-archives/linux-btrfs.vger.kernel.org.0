Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2A1E0F7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbgEYN2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 09:28:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388737AbgEYN2c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 09:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3386CABC2;
        Mon, 25 May 2020 13:28:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF892DA728; Mon, 25 May 2020 15:27:34 +0200 (CEST)
Date:   Mon, 25 May 2020 15:27:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
Message-ID: <20200525132734.GT18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
References: <20200318211157.11090-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318211157.11090-1-kreijack@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 18, 2020 at 10:11:56PM +0100, Goffredo Baroncelli wrote:
> this patch adds support for the raid5/6 profiles in the command
> 'btrfs filesystem usage'.
> 
> Until now the problem was that the value r_{data,metadata}_used is not
> easy to get for a RAID5/6, because it depends by the number of disks.
> And in a filesystem it is possible to have several raid5/6 chunks with a
> different number of disks.

I'd like to get the raid56 'fi du' fixed but the way you implement it
seems to be a too big leap. I've tried to review this patch several
times but always got the impression that reworking the calculations to
make it work for some profiles will most likely break something else. It
has happened in the past.

So, let's start with the case where the filesystem does not have
multiple profiles per block group type, eg. just raid5 for data and
calculate that.

If this also covers the raid56 case with different stripe counts, then
good but as this is special case I won't mind addressing it separately.

The general case of multiple profiles per type is probably an
intermediate state of converting profiles, we can return something sane
if possible or warn as what we have now.

I'm fine if you say you're not going to implement that.
