Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2091724C329
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgHTQON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 12:14:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgHTQOL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 12:14:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BFFBAD2F;
        Thu, 20 Aug 2020 16:14:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C513DA87C; Thu, 20 Aug 2020 18:13:04 +0200 (CEST)
Date:   Thu, 20 Aug 2020 18:13:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: detect nocow for swap after snapshot delete
Message-ID: <20200820161304.GA2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Graham Cobb <g.btrfs@cobb.uk.net>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200818180005.933061-1-boris@bur.io>
 <20200819112941.GK2026@twin.jikos.cz>
 <563ca3a3-d07c-cf1f-cb0f-f41f50f8d516@cobb.uk.net>
 <20200819142548.GN2026@twin.jikos.cz>
 <20200819174609.GA1218106@devvm842.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819174609.GA1218106@devvm842.ftw2.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 10:46:09AM -0700, Boris Burkov wrote:
> My reproduction has been:
> create subvol
> create swapfile in subvol
> btrfs subvol snapshot subvol snapshot
> btrfs subvol delete snapshot
> sync/btrfs fi sync/waiting
> swapon subvol/swapfile
> 
> Note that I haven't been touching the swapfile in any way after
> initially creating it. Nor have I been turning swap on/off in any
> coordinated way before/after the snapshot except to test after the
> snapshot is deleted.

Ok, so this is the minimal testcase.

> I tried both suggestions with and without the patch and saw that with
> the patch, swapon reliably succeeds after 'btrfs subvol sync' and does
> not reliably succeed even after 'btrfs subvol delete -c' or sync calls,
> so it seems that we need the subvolume to be completely cleaned. Without
> the patch, after both 'btrfs subvol delete -c' and after 'btrfs subvol
> sync', the swapon fails.

The patch is fine as is so I'll add it to misc-next and tag for stable.
The remaining part is to document in manual page what to do in case the
snapshot was accidentaly created and needs to be deleted.
