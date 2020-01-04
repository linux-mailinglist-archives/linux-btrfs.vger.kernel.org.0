Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57F130503
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgADXGl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 18:06:41 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:59748 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgADXGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 18:06:41 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1insVD-0004XO-NG; Sat, 04 Jan 2020 23:06:39 +0000
Date:   Sat, 4 Jan 2020 23:06:39 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Georg =?iso-8859-1?Q?Gro=DFmann?= 
        <georg@grossmann-technologies.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: timed out waiting for device dev-disk-by\x2duuid after disk
 failure on btrfs raid1
Message-ID: <20200104230639.GE26346@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Georg =?iso-8859-1?Q?Gro=DFmann?= <georg@grossmann-technologies.de>,
        linux-btrfs@vger.kernel.org
References: <d081f5fc-7132-6b18-f740-738993fd18e7@grossmann-technologies.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d081f5fc-7132-6b18-f740-738993fd18e7@grossmann-technologies.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 04, 2020 at 11:38:05PM +0100, Georg Großmann wrote:
> Dear btrfs community,
> 
> I wanted to use a setup with Open Suse Tumbleweed together with with a
> btrfs raid 1 on two disks in my virtual box. I want a system that can
> still boot if one of the disks fails so I installed a bootloader to each
> of the disks in /dev/sda1 and /dev/sdb1.
> 
> I then used /dev/sda2 and /dev/sdb2 for the btrfs raid 1. After
> unplugging one disk, the boot process always fails with the message
> "timed out waiting for device dev-disk-by\x2duuid". I found a mailing
> list here
> https://lists.freedesktop.org/archives/systemd-devel/2014-May/019217.html
> which pretty well describes my problem. Unfortunately, I can't find an
> appropriate solution there. Since this mailing list is from 2014, has
> there been some progress in the meantime? Or is this the expected
> behaviour and the user has to help himself out manually?

   With a missing device, you need to mount with the "degraded" mount
option. The current advice is that this should be a manual process.
If the FS in question includes the root filesystem, this will involve
editing the mount options passed to the kernel in the bootloader (GRUB
allows you to do this at boot time).

   Hugo.

-- 
Hugo Mills             | vi vi vi: the Editor of the Beast.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
