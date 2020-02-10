Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A16157F7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 17:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBJQJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 11:09:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:33828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBJQJq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 11:09:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87F82AD69;
        Mon, 10 Feb 2020 16:09:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 846FCDA790; Mon, 10 Feb 2020 17:09:29 +0100 (CET)
Date:   Mon, 10 Feb 2020 17:09:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
Message-ID: <20200210160929.GJ2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20200210090201.29979-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210090201.29979-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 10, 2020 at 05:02:01PM +0800, Qu Wenruo wrote:
> Since commit ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
> manual page"), the man page of `btrfs filesystem` shows `sync`
> subcommand will wait for all existing orphan subvolumes to be dropped.

But this is not what the docs say, nor what the ioctl claims to do.

'trigger cleaning of deleted subvolumes' means that it just starts the
process in some way (eg. by waking up the cleaner kthread that does the
actual cleaning).

For waiting on the subvolumes there's 'btrfs subvol sync' and that works
as expected.
