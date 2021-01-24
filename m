Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EF301E21
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAXSa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 13:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAXSa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 13:30:59 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97149C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 10:30:18 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l3k7g-00080s-Mi; Sun, 24 Jan 2021 18:28:28 +0000
Date:   Sun, 24 Jan 2021 18:28:28 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Jakob =?iso-8859-1?Q?Sch=F6ttl?= <jschoett@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Cannot resize filesystem: not enough free space
Message-ID: <20210124182828.GF4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Jakob =?iso-8859-1?Q?Sch=F6ttl?= <jschoett@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <8735yqw5wm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735yqw5wm.fsf@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 24, 2021 at 07:23:21PM +0100, Jakob Schöttl wrote:
> 
> Help please, increasing the filesystem size doesn't work.
> 
> When mounting my btrfs filesystem, I had errors saying, "no space left
> on device". Now I managed to mount the filesystem with -o skip_balance but:
> 
> # btrfs fi df /mnt
> Data, RAID1: total=147.04GiB, used=147.02GiB
> System, RAID1: total=8.00MiB, used=48.00KiB
> Metadata, RAID1: total=1.00GiB, used=458.84MiB
> GlobalReserve, single: total=181.53MiB, used=0.00B

   Can you show the output of "sudo btrfs fi show" as well?

   Hugo.
 
> It is full and resize doesn't work although both block devices sda and
> sdb have more 250 GB and more nominal capacity (I don't have partitions,
> btrfs is directly on sda and sdb):
> 
> # fdisk -l /dev/sd{a,b}*
> Disk /dev/sda: 232.89 GiB, 250059350016 bytes, 488397168 sectors
> [...]
> Disk /dev/sdb: 465.76 GiB, 500107862016 bytes, 976773168 sectors
> [...]
> 
> I tried:
> 
> # btrfs fi resize 230G /mnt
> runs without errors but has no effect
> 
> # btrfs fi resize max /mnt
> runs without errors but has no effect
> 
> # btrfs fi resize +1G /mnt
> ERROR: unable to resize '/mnt': no enough free space
> 
> Any ideas? Thank you!

-- 
Hugo Mills             | Attempted murder, now honestly, what is that? Do
hugo@... carfax.org.uk | they give a Nobel Prize for attempted chemistry?
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                          Sideshow Bob
