Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289711FCC4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFQLbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 07:31:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQLbU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 07:31:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04337AEC8;
        Wed, 17 Jun 2020 11:31:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A8A9DA7C3; Wed, 17 Jun 2020 13:31:09 +0200 (CEST)
Date:   Wed, 17 Jun 2020 13:31:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
Message-ID: <20200617113109.GK27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
 <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
 <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
 <a7417666-56a0-be6a-1691-e647802e1df7@toxicpanda.com>
 <0e274dc7-ac05-078a-2a2c-348e72745d45@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e274dc7-ac05-078a-2a2c-348e72745d45@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 07:49:33AM +0800, Qu Wenruo wrote:
> >>> Can we handle stat->dev not having a device set?  Or will this blow up
> >>> in other ways?  Thanks,
> >>
> >> We can handle it without any problem, just users get confused.
> >>
> >> As a common practice, we use different bdev as a namespace for different
> >> subvolumes.
> >> Without a valid bdev, some user space tools may not be able to
> >> distinguish inodes in different subvolumes.
> >>
> > 
> > Alright that's fine then.  But I feel like stat is one of those things
> > that'll flood the console, can we put this somewhere else that's going
> > to be hit less? Thanks,
> 
> Unfortunately, stat() is the only user of btrfs_root::anon_dev.
> 
> While fortunately, the logical is pretty simple, even without the safe
> net we can understand the lifespan pretty well.
> 
> I'm fine to drop this patch if you're concerned about the possible
> warning flood, as the benefit is really not that much.

It could be a developer-only warning but if there's a root with a bad
anon_dev, a simple 'ls -l' would flood the log for sure.
