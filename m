Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2D198ACC
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 06:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgCaEEm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 31 Mar 2020 00:04:42 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36846 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgCaEEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 00:04:42 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0F107642BDC; Tue, 31 Mar 2020 00:04:40 -0400 (EDT)
Date:   Tue, 31 Mar 2020 00:04:40 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Brad Templeton <4brad@templetons.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
Message-ID: <20200331040440.GH2693@hungrycats.org>
References: <7c0a1398-322f-400a-abe4-dfea98fd46e1@templetons.com>
 <20200328212021.GA13306@hungrycats.org>
 <7778ece0-67d4-8d1c-b773-35f07d81dcbe@templetons.com>
 <20200329064216.GB13306@hungrycats.org>
 <CAJCQCtQjjHWunKi7T2GC4MN708sF5RPJmx+w1o8Y_LDzdK3RXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJCQCtQjjHWunKi7T2GC4MN708sF5RPJmx+w1o8Y_LDzdK3RXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 04:14:46PM -0600, Chris Murphy wrote:
> On Sun, Mar 29, 2020 at 12:42 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > 90 seconds sounds about right for the block group scan when mounting on
> > a 10TB filesystem.  There's a feature called block group tree in kernel
> > 5.5 that helps with that:  it lays out block group items on disk closer
> > together so they can be read in milliseconds.  This is an on-disk format
> > change, so once you enable that feature, you wouldn't be able to mount
> > the filesystem on an older kernel.  This can be a problem if your
> > sound drivers have regressions.  You might want to wait a few kernel
> > releases to be sure you don't need to downgrade.
> 
> I'm not seeing anything about block group tree in btrfs/super.c.
> 
> There is block_group_cache_tree but I'm not seeing anything about it
> in 'man 5 btrfs' using btrfs-progs 5.4, or in the devel branch.
> 
> So I'm not sure what mount option or btrfstune option this would be,
> seems to be automatic?
> https://github.com/kdave/btrfs-progs/commit/2eaf862f46b3ccb6b7248a0417ebf7096bc93b80

Sorry, my mistake...it was in one of the misc-next branches, but seems to
have been dropped.  Maybe not finished yet?

> 
> --
> Chris Murphy
> 
