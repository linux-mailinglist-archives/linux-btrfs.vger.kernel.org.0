Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9061B38086B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhENL01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 07:26:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhENL00 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 07:26:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B83EAAFF5;
        Fri, 14 May 2021 11:25:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D637DDA8EB; Fri, 14 May 2021 13:22:43 +0200 (CEST)
Date:   Fri, 14 May 2021 13:22:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid
 succeeded to write superblock
Message-ID: <20210514112243.GT7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210511042501.900731-1-l@damenly.su>
 <20210512140135.GR7604@twin.jikos.cz>
 <k0o3lb1d.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k0o3lb1d.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 13, 2021 at 08:37:29AM +0800, Su Yue wrote:
> 
> On Wed 12 May 2021 at 22:01, David Sterba <dsterba@suse.cz> wrote:
> 
> > On Tue, May 11, 2021 at 12:25:01PM +0800, Su Yue wrote:
> >> Commit 8ef9313cf298 ("btrfs-progs: zoned: implement 
> >> log-structured
> >> superblock") changed to write BTRFS_SUPER_INFO_SIZE bytes to 
> >> device.
> >> The before num of bytes to be written is sectorsize.
> >> It causes mkfs.btrfs failed on my 16k pagesize kvm:
> >
> > What architecture is that?
> >
> The host chip is Apple m1 so it's arm64 but only supporting 16k and 4k
> pagesize. Since btrfs subpage work cares 64k pagesize for now, I
> usually run xfstests with 16k pagesize and 16k sectorsize. So far, so
> good.

Interesting, what's the distro? I haven't found one that would be
pre-built with 16k pages so I assume it's built from scratch. Among all
the page sizes we've seen so far 4k is almost everywhere, 64k is ppc and
arm (both native), and sparc has 8k. 16k is a new one, though I don't
think it would catch something we haven't seen so far it adds a bit to
the CPU capabilities coverage.
