Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2285C1598F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgBKSpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:45:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:42412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbgBKSpN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:45:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8B5BADB3;
        Tue, 11 Feb 2020 18:45:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87070DA703; Tue, 11 Feb 2020 18:17:02 +0100 (CET)
Date:   Tue, 11 Feb 2020 18:17:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
Message-ID: <20200211171702.GA2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20200210090201.29979-1-wqu@suse.com>
 <20200210160929.GJ2654@twin.jikos.cz>
 <49498052-99f8-25b6-1db4-569ebc4658b7@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49498052-99f8-25b6-1db4-569ebc4658b7@cobb.uk.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 10, 2020 at 04:26:22PM +0000, Graham Cobb wrote:
> On 10/02/2020 16:09, David Sterba wrote:
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
> > 
> > For waiting on the subvolumes there's 'btrfs subvol sync' and that works
> > as expected.
> 
> I agree. The original wording may be unclear (particularly so for users
> who may have limited English and be confused by the use of "trigger"),
> but it does seem to be different from sync(1) and the proposed change is
> worse.
> 
> How about:
> 
> Force a sync of the filesystem at 'path', similar to the `sync`(1)
> command. In addition, it starts cleaning of deleted subvolumes. To wait
> for subvolume deletion to complete use the `btrfs subvolume sync` command.
> 
> SEE ALSO
>  btrfs-subvolume(8)

That's perfect, thanks. I'll update the docs.
