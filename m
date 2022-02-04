Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151014A9AF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiBDOaX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 09:30:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38612 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiBDOaW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 09:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE6EFB82199
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 14:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A95C004E1;
        Fri,  4 Feb 2022 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643985020;
        bh=hXap89/g4UZJ0wIJqMZpxz0r9dSYJQ37hfuPZ0Z6V44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITbjjwXeIdP5nxgQYx5meM0pDhQDGU3OE7uPlvQsrIuih4BlQhOVMLSISzyZn9MW7
         LPFQzuwAbVNiEOPXaNrtl9HTp53bALX6TySCUuUgPoDnwpg4iiooyXA+5UufEjGBOY
         t/F+oysnReMD9UG9JPzbW3aHCn1HX6amOwC1ckPPa8JWPccqwIgiW3Nl9HNUrP/Kq5
         bW/WqPtfrrrzXnUBHeSZ6MUBG1eHK92Da3owPOXFQHb+cmeKhKlLVMYqbxviNk4XDp
         qtIYwd3HwQ157xWGtLdy9bK+euHoB9vMEtOUfqw/snz+gJIWU8K2U6gjiko4DJe6ZE
         YpAa4CuCNZt7g==
Date:   Fri, 4 Feb 2022 14:30:17 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Andy Smith <andy@strugglers.net>
Cc:     Lukas Straub <lukasstraub2@web.de>, linux-btrfs@vger.kernel.org
Subject: Re: "Too many links (31)" issue
Message-ID: <Yf04eXr3KqG4BYZP@debian9.Home>
References: <20220203163108.ipdv3yxbe7eb6vc4@bitfolk.com>
 <20220203221506.212e72e8@gecko>
 <20220203222752.7x4nq4y6wgi6anfi@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203222752.7x4nq4y6wgi6anfi@bitfolk.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 03, 2022 at 10:27:52PM +0000, Andy Smith wrote:
> Hi Lukas,
> 
> On Thu, Feb 03, 2022 at 10:15:06PM +0000, Lukas Straub wrote:
> > On Thu, 3 Feb 2022 16:31:08 +0000
> > Andy Smith <andy@strugglers.net> wrote:
> > > I searched around on this topic and found hits from 10 years ago
> > > about maximum hardlinks per directory and being dependent upon
> > > length of file path. Is that still relevant today?
> > > 
> > > [...]
> > > 
> > > Is there anything I can do to get this working?
> > 
> > Hello, Have you tried the "extended_iref" mount option? 
> 
> During my searching I did see mention of it, but as far as I could
> see this is a mkfs feature not a mount option, and it's default on
> now anyway. So I already have it don't I? (how to check enabled
> filesystem features?)

Yes, it's a feature enabled by mkfs, and it has been enabled by
default for many years now.

You can confirm if it's enabled like this:

$ cat /sys/fs/btrfs/80353f52-8425-45c2-a9a2-103c3e25ebb9/features/extended_iref 
1

Where the 8035(...) is the UUID of the mounted filesystem.
You can get the UUID using blkid:

$ blkid
(...)
/dev/sdj: UUID="80353f52-8425-45c2-a9a2-103c3e25ebb9" UUID_SUB="0d1e7dfe-6ec8-494c-8467-bc4eabca56f2" BLOCK_SIZE="4096" TYPE="btrfs"
(...)

With extent irefs, the hard link limit is 65535 (64K - 1), I just confirmed
with a quick test that it is indeed being respected:

$ mkfs.btrfs -f /dev/sdj
$ mount /dev/sdj /mnt/sdj
$ cd /mnt/sdj
$ touch foo
$ for ((i = 1; i < 65536; i++)); do echo "Iteration $i"; ln foo foo_$i; done
(...)
Iteration 65534
Iteration 65535
ln: failed to create hard link to 'foo': Too many links

$ stat foo
  File: foo
  Size: 0         	Blocks: 0          IO Block: 4096   regular empty file
Device: 2ch/44d	Inode: 257         Links: 65535
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-04 14:18:49.788113075 +0000
Modify: 2022-02-04 14:18:49.788113075 +0000
Change: 2022-02-04 14:21:58.432166650 +0000
 Birth: 2022-02-04 14:18:49.788113075 +0000

$ ls -1 | wc -l
65535


> 
> Anyway, it is not recognised as a mount option.
> 
> Cheers,
> Andy
