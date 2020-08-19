Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3725E24A1B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHSO04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 10:26:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgHSO0z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 10:26:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75D1DACAF;
        Wed, 19 Aug 2020 14:27:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3DCCDA703; Wed, 19 Aug 2020 16:25:48 +0200 (CEST)
Date:   Wed, 19 Aug 2020 16:25:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: detect nocow for swap after snapshot delete
Message-ID: <20200819142548.GN2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200818180005.933061-1-boris@bur.io>
 <20200819112941.GK2026@twin.jikos.cz>
 <563ca3a3-d07c-cf1f-cb0f-f41f50f8d516@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563ca3a3-d07c-cf1f-cb0f-f41f50f8d516@cobb.uk.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 12:59:28PM +0100, Graham Cobb wrote:
> On 19/08/2020 12:29, David Sterba wrote:
> > How often could the snapshot deletion and swapfile activation happen at
> > the same time? Snapshotting subvolume with the swapfile requires
> > deactivation, snapshot/send/whatever and then activation. This sounds
> > like a realistic usecase.
> 
> It is very likely when the swapfile is one that is only used
> occasionally (for example, when running a particular program which needs
> a massive amount of virtual memory, or having to stop using a different
> swapfile because a disk looks like it is starting to fail).
> 
> If the swapfile is not normally used, it is not unlikely it got
> snapshotted (as part of a larger operation, presumably) while
> deactivated. When the user tries to use it, they realise it isn't
> working because it is snapshotted, so they delete the snapshot and then
> immediately try to activate it again -- causing confusion when it still
> fails.

That makes sense from user POV. I still don't uderstand if it's
sufficient to commit the transaction deleting the snapshot or if it's
necessary to wait until the subvolume is completely cleaned.

The former would require 'btrfs subvol delte -c /snapshot' while the
latter needs the id of the subvolume and then
'btrfs subvol sync /path id'.
