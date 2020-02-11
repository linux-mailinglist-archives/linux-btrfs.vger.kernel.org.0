Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928F61598F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgBKSpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:45:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:42398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbgBKSpN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:45:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F934AD11;
        Tue, 11 Feb 2020 18:45:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 681D8DA7D3; Tue, 11 Feb 2020 18:39:10 +0100 (CET)
Date:   Tue, 11 Feb 2020 18:39:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
Message-ID: <20200211173909.GB2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20200210090201.29979-1-wqu@suse.com>
 <20200210160929.GJ2654@twin.jikos.cz>
 <a853cd2a-2752-d3ea-4fc7-80a1ec7e1180@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a853cd2a-2752-d3ea-4fc7-80a1ec7e1180@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 08:29:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/2/11 上午12:09, David Sterba wrote:
> > On Mon, Feb 10, 2020 at 05:02:01PM +0800, Qu Wenruo wrote:
> >> Since commit ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
> >> manual page"), the man page of `btrfs filesystem` shows `sync`
> >> subcommand will wait for all existing orphan subvolumes to be dropped.
> >
> > But this is not what the docs say, nor what the ioctl claims to do.
> >
> > 'trigger cleaning of deleted subvolumes' means that it just starts the
> > process in some way (eg. by waking up the cleaner kthread that does the
> > actual cleaning).
> 
> Then at least we shouldn't really confuse the end user (me included)
> about the cleanup.

Yeah, documentation improvements are welcome.

> In fact the cleaner wake up doesn't really have a user-observable impact.

The observable impact is that the cleaning starts immediatelly and not
after the periodic wakeup. This was the original intention behind
2fad4e83e1259 ("btrfs: wake up transaction thread from SYNC_FS ioctl").
I don't remember exactly, maybe it was on IRC somebody asking for it.

> We should at least avoid mentioning such thing.

That there's some connection between 'fi sync' and the cleaning should
be IMHO mentioned in the docs. The tools provide some commands as
building blocks and some as all-in-one, so there should be enough
information to let user decide what to do.

It's not easy to find the balance between the level of detail and amount
of related information, also to maintain consistency accross all
documents. As if writing documentation is hard, idk.
