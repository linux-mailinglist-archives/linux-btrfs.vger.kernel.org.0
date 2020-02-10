Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DDF1572B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 11:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgBJKQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 05:16:53 -0500
Received: from bang.steev.me.uk ([81.2.120.65]:52897 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgBJKQx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 05:16:53 -0500
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 05:16:52 EST
Received: from localhost ([::1] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.2)
        id 1j15sd-000I9C-Rm; Mon, 10 Feb 2020 10:01:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Feb 2020 10:01:27 +0000
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
In-Reply-To: <20200210090201.29979-1-wqu@suse.com>
References: <20200210090201.29979-1-wqu@suse.com>
Message-ID: <19c4d62368843534e7f45163fb19a086@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-02-10 09:02, Qu Wenruo wrote:
> Since commit ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
> manual page"), the man page of `btrfs filesystem` shows `sync`
> subcommand will wait for all existing orphan subvolumes to be dropped.
> 
> That's not true, even at that commit, `btrfs fi sync` only calls
> BTRFS_IOC_SYNC ioctl, which is not that much different from vanilla
> sync.
> It doesn't wait for orphan subvolumes to be dropped from the very
> beginning.
> 
> It's `btrfs subvolume sync` doing the wait work.
> 
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Fixes: ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem 
> manual page")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-filesystem.asciidoc | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/btrfs-filesystem.asciidoc
> b/Documentation/btrfs-filesystem.asciidoc
> index 84efaa1a8f8f..3f62a3608cb1 100644
> --- a/Documentation/btrfs-filesystem.asciidoc
> +++ b/Documentation/btrfs-filesystem.asciidoc
> @@ -253,9 +253,8 @@ show sizes in GiB, or GB with --si
>  show sizes in TiB, or TB with --si
> 
>  *sync* <path>::
> -Force a sync of the filesystem at 'path'. This is done via a special 
> ioctl and
> -will also trigger cleaning of deleted subvolumes. Besides that it's 
> equivalent
> -to the `sync`(1) command.
> +Force a sync of the filesystem at 'path'. This should be the same as 
> vanilla

                                                   ^^^^^^
As a user I don't like the use of "should" here. Can we not keep the 
wording of "is equivalent to the `sync(1)` command [but only for the 
specified btrfs filesystem]"?

-- 
Steven Davies

> +'sync' command, but only for specified btrfs.
> 
>  *usage* [options] <path> [<path>...]::
>  Show detailed information about internal filesystem usage. This is 
> supposed to
