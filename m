Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B73A1E16
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfH2O5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 10:57:33 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:57860 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfH2O5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 10:57:33 -0400
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1i3Lrg-0000mV-Ap; Thu, 29 Aug 2019 15:57:32 +0100
Date:   Thu, 29 Aug 2019 15:57:32 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     UGlee <matianfu@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Need advice for fixing a btrfs volume
Message-ID: <20190829145732.GB2488@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        UGlee <matianfu@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAEgruXsjz36vEZhULWneZKY4yD3x2n05yR8qx9eiN-GOVvfiJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEgruXsjz36vEZhULWneZKY4yD3x2n05yR8qx9eiN-GOVvfiJg@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 29, 2019 at 10:45:37PM +0800, UGlee wrote:
> Dear:
> 
> We are using btrfs in an embedded arm/linux device.
> 
> The bootloader (u-boot) has only limited support for btrfs.
> Occasionally the device lost power supply unexpectedly, leaving an
> inconsistent file system on eMMC. If I dump the partition image from
> eMMC and mount it on linux desktop, the file system is perfectly
> usable.
> 
> My guess is that the linux kernel can fully handle the journalled
> update and garbage data.

   btrfs doesn't have a journal -- if the hardware is telling the
truth about barriers, and about written data reaching permanent
storage, then the FS structures on disk are always consistent. It's
got a log tree which is used for recovery of partial writes in the
case of a crash midway through a transaction, but that doesn't affect
the primary FS structures.

> But the u-boot cannot. So I consider to add a minimal ext4 rootfs
> partition as a fallback. When u-boot cannot read file from btrfs
> partition, it can switch to a minimal Linux system booting from an
> ext4 fs.

> Then I have a chance to use some tool to fix btrfs volume and reboot
> the system. My question is which tools is recommended for this
> purpose?

   It depends on the nature of the failure (if there is one, and why
uboot can't read the FS. Maybe it's saying that if there's a non-empty
log tree, it's not going to handle it (but there would be additional
code needed to check that). If that were the case, then simply
mounting the FS and unmounting it cleanly would work.

> According to the following page:
> 
> https://btrfs.wiki.kernel.org/index.php/Btrfsck
> 
> btrfsck is said to be deprecated. `btrfs check --repair` seems to be a
> full volume check and time-consuming.

   btrfs check --repair *is* btrfsck, under a different name. They're
the same code.

> All I need is just a good superblock and a few files could be
> loaded. Most frequently complaints from u-boot is the superblock
> issue such as `root_backup not found`.  It there a way to just fix
> the superblock, settle all journalled update, and make sure the
> required several files is OK?

   Mount the FS and unmount it cleanly?

   Hugo.

-- 
Hugo Mills             | Prisoner unknown: Return to Zenda.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
