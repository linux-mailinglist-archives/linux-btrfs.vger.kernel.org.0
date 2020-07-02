Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C362119F1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGBCFq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Jul 2020 22:05:46 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42744 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGBCFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 22:05:45 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 103E1741649; Wed,  1 Jul 2020 22:05:43 -0400 (EDT)
Date:   Wed, 1 Jul 2020 22:05:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Lukas Straub <lukasstraub2@web.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200702020543.GZ10769@hungrycats.org>
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <20200701172218.01c0197d@luklap>
 <20200701153919.GD27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200701153919.GD27795@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 05:39:19PM +0200, David Sterba wrote:
> On Wed, Jul 01, 2020 at 05:22:18PM +0200, Lukas Straub wrote:
> > On Wed,  1 Jul 2020 10:44:38 -0400
> > Josef Bacik <josef@toxicpanda.com> wrote:
> > 
> > > One of the things that came up consistently in talking with Fedora about
> > > switching to btrfs as default is that btrfs is particularly vulnerable
> > > to metadata corruption.  If any of the core global roots are corrupted,
> > > the fs is unmountable and fsck can't usually do anything for you without
> > > some special options.
> > > 
> > > Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> > > what it really does is just allow you to operate without an extent root.
> > > However there are a lot of other roots, and I'd rather not have to do
> > > 
> > > mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> > > 
> > > Instead take his original idea and modify it so it just works for
> > > everything.  Turn it into rescue=onlyfs, and then any major root we fail
> > > to read just gets left empty and we carry on.
> > > 
> > > Obviously if the fs roots are screwed then the user is in trouble, but
> > > otherwise this makes it much easier to pull stuff off the disk without
> > > needing our special rescue tools.  I tested this with my TEST_DEV that
> > > had a bunch of data on it by corrupting the csum tree and then reading
> > > files off the disk.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > > 
> > > I'm not married to the rescue=onlyfs name, if we can think of something better
> > > I'm good.
> > 
> > Maybe you could go a step further and automatically switch to rescue
> > mode if something is corrupt. This is easier for the user than having
> > to remember the mount flags.
> 
> We don't want to do the auto-switching in general as it's a non-standard
> situation.  It's better to get user attention than to silently mount
> with limited capabilities and then let the user find out that something
> went wrong, eg. system services randomly failing to start or work.

To be fair, auto-switching is almost exactly what happens now, with mounts
being the exception.  If the tree corruption is detected after mounting,
we panic and flip the RO bit right in the middle of the work day.
When mounting with default options and a tree error detected during the
mount, we fail to mount at all--IMHO that's the non-standard situation.
