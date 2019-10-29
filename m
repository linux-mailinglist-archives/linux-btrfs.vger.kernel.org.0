Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14288E8B25
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389655AbfJ2OrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 10:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389652AbfJ2OrP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 10:47:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBAEFB478;
        Tue, 29 Oct 2019 14:47:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5EF6DA734; Tue, 29 Oct 2019 15:47:23 +0100 (CET)
Date:   Tue, 29 Oct 2019 15:47:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.3.1
Message-ID: <20191029144723.GW3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20191025121535.28802-1-dsterba@suse.com>
 <22dd7053-8f00-03c0-a803-4b8f897efcea@petaramesh.org>
 <20191029141904.GV3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029141904.GV3001@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 29, 2019 at 03:19:04PM +0100, David Sterba wrote:
> On Fri, Oct 25, 2019 at 11:10:24PM +0200, Swâmi Petaramesh wrote:
> > Hi,
> > 
> > Le 25/10/2019 à 14:15, David Sterba a écrit :
> > > btrfs-progs version 5.3.1 have been released.
> > > 
> > > This fixes (only) linking against libbtrfs (reported by snapper users).
> > > I did houpefully enough testing, the CI is green, builds on various arches, and
> > > snapper running with the library from 5.3.1 works.
> > 
> > Now it looks unhappy on my #Arch...
> > 
> > 
> > root@zafu:/# inxi -S
> > System:    Host: zafu Kernel: 5.3.7-arch1-1-ARCH x86_64 bits: 64 
> > Desktop: Cinnamon 4.2.4 Distro: Arch Linux
> > 
> > root@zafu:/# pacman -Qs btrfs-progs
> > local/btrfs-progs 5.3-1
> >      Btrfs filesystem utilities
> > 
> > root@zafu:/# pacman -Qs snapper
> > local/snap-pac 2.3.1-1
> >      Pacman hooks that use snapper to create pre/post btrfs snapshots 
> > like openSUSE's YaST
> > 
> > root@zafu:/# snapper list
> > snapper: symbol lookup error: /usr/lib/libbtrfs.so.0: undefined symbol: 
> > write_raid56_with_parity
> 
> write_raid56_with_parity should be considered internal symbol and
> snapper does not use it.  I'll have a look how Arch builds snapper.

I've grabbed built packages from
https://www.archlinux.org/packages/staging/x86_64/btrfs-progs/download/
(v5.3.1)

and https://www.archlinux.org/packages/core/x86_64/btrfs-progs/download/
(v5.3)

and the files /usr/lib/libbtrfs.so.0.1 are exactly the same:

$ md5sum progs-5.3*/usr/lib/libbtrfs.so.0.1
34a5ae4d38c5831e620b5ece52c04340  progs-5.3.1/usr/lib/libbtrfs.so.0.1
34a5ae4d38c5831e620b5ece52c04340  progs-5.3/usr/lib/libbtrfs.so.0.1

The file size is 371000 but this should be, because 5.3.1 added several
.o files and on openSUSE the file size grew from ~400KB to ~2MB.

As the PKGBUILD probably only bumps version, I verified that the
kernel.org tarballs indeed contain the right sources and buid with
defaults produces the right library.

So this seems to be something fishy on Arch side, like stale build or I
don't know.
