Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711A1FD5CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFQUNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 16:13:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:51734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQUNn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 16:13:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 74F6AAB3D;
        Wed, 17 Jun 2020 20:13:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8747DA728; Wed, 17 Jun 2020 22:13:32 +0200 (CEST)
Date:   Wed, 17 Jun 2020 22:13:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, A L <mail@lechevalier.se>,
        linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: Should "btrfs filesystem defrag -r" follow symlinks?
Message-ID: <20200617201332.GT27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, A L <mail@lechevalier.se>,
        linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>
References: <852f6e36-6adc-0455-5c2b-0477b0c72270@lechevalier.se>
 <20200617200438.GS27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617200438.GS27795@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 10:04:39PM +0200, David Sterba wrote:
> On Sun, Jun 14, 2020 at 03:22:34PM +0200, A L wrote:
> > It is not clear from the man page at 
> > https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-filesystem if 
> > `btrfs filesystem defrag -r` should follow symbolic links or not. 
> > Perhaps the man-page should mention which behaviour is default.
> > 
> > I did some basic tests and it seems that on my setup it does not follow 
> > symlinks.
> 
> That's right, -r does not follow directory symlinks. I think it's a good
> default as 'find' does not do that either. We're using the 'nftw'
> library function with FTW_PHYS, help says "If set, do not follow
> symbolic links.  (This is what you want.)"
> 
> > Perhaps improve defragment with an option to follow symlinks and/or 
> > subvolumes should be added?
> 
> I'll clarify the manual page regarding the default behaviour. Mount
> points are skipped but recursion goes to subvolumes.

Correction, no it does not recurse to subvolumes, it got there through
the * expansion by mistake.
