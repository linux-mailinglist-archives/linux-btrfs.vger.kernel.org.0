Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDD210F7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgGAPjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 11:39:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731640AbgGAPjh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 11:39:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 005FDABE4;
        Wed,  1 Jul 2020 15:39:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38623DA781; Wed,  1 Jul 2020 17:39:20 +0200 (CEST)
Date:   Wed, 1 Jul 2020 17:39:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200701153919.GD27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Lukas Straub <lukasstraub2@web.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <20200701172218.01c0197d@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701172218.01c0197d@luklap>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 05:22:18PM +0200, Lukas Straub wrote:
> On Wed,  1 Jul 2020 10:44:38 -0400
> Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > One of the things that came up consistently in talking with Fedora about
> > switching to btrfs as default is that btrfs is particularly vulnerable
> > to metadata corruption.  If any of the core global roots are corrupted,
> > the fs is unmountable and fsck can't usually do anything for you without
> > some special options.
> > 
> > Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> > what it really does is just allow you to operate without an extent root.
> > However there are a lot of other roots, and I'd rather not have to do
> > 
> > mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> > 
> > Instead take his original idea and modify it so it just works for
> > everything.  Turn it into rescue=onlyfs, and then any major root we fail
> > to read just gets left empty and we carry on.
> > 
> > Obviously if the fs roots are screwed then the user is in trouble, but
> > otherwise this makes it much easier to pull stuff off the disk without
> > needing our special rescue tools.  I tested this with my TEST_DEV that
> > had a bunch of data on it by corrupting the csum tree and then reading
> > files off the disk.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > 
> > I'm not married to the rescue=onlyfs name, if we can think of something better
> > I'm good.
> 
> Maybe you could go a step further and automatically switch to rescue
> mode if something is corrupt. This is easier for the user than having
> to remember the mount flags.

We don't want to do the auto-switching in general as it's a non-standard
situation.  It's better to get user attention than to silently mount
with limited capabilities and then let the user find out that something
went wrong, eg. system services randomly failing to start or work.
