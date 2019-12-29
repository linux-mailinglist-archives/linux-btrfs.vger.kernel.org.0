Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDA12C320
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfL2PiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 10:38:02 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:58542 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2PiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 10:38:01 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1iladk-0003d1-Df; Sun, 29 Dec 2019 15:38:00 +0000
Date:   Sun, 29 Dec 2019 15:38:00 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Raviu <raviu@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Cannot mount or recover btrfs
Message-ID: <20191229153800.GA26346@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Raviu <raviu@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <qxM9wPidCbIA9yMGE4e57cGzc5GkQnFF39Q2h1PLV0XTLpSVZ1nvi9wDfOD3YXIAl3GYyq2wRoG8ncoE692e0MVUah_rmDSRggyZz_trQH0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qxM9wPidCbIA9yMGE4e57cGzc5GkQnFF39Q2h1PLV0XTLpSVZ1nvi9wDfOD3YXIAl3GYyq2wRoG8ncoE692e0MVUah_rmDSRggyZz_trQH0=@protonmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 03:05:14PM +0000, Raviu wrote:
> Hi,
> My system suddenly crashed, after reboot I cannot mount /home any more.
> 
> `uname -a`
> Linux moonIk80 4.12.14-lp151.28.36-default #1 SMP Fri Dec 6 13:50:27 UTC 2019 (8f4a495) x86_64 x86_64 x86_64 GNU/Linux
> 
> btrfs-progs v5.4
> 
> `btrfs fi show`
> Label: none  uuid: 378faa6e-8af0-415e-93f7-68b31fb08a29
>         Total devices 1 FS bytes used 194.99GiB
>         devid    1 size 232.79GiB used 231.79GiB path /dev/mapper/cr_sda4
> 
> 
> The device cannot be mounted.
> [  188.649876] BTRFS info (device dm-1): disk space caching is enabled
> [  188.649878] BTRFS info (device dm-1): has skinny extents
> [  188.656364] BTRFS critical (device dm-1): corrupt leaf: root=2 block=294640566272 slot=104, unexpected item end, have 42739 expect 9971

>>> hex(9971)
'0x26f3'
>>> hex(42739)
'0xa6f3'

   That looks like a single bit error, and it's got a correct checksum
for the incorrect data, which suggests that the error happened while
the metadata was in RAM. The most likely cause here is that your RAM
is bad. (There are other options, but they're also mostly hardware).

   As for fixing it -- first, make really, really sure that your
hardware is OK. After that, I don't think btrfs check will fix it
(although it might). Maybe one of the devs can add something to it to
help.

   Hugo.

> [  188.656374] BTRFS error (device dm-1): failed to read block groups: -5
> [  188.700088] BTRFS error (device dm-1): open_ctree failed
> 
> 
> 
> `btrfs check /dev/mapper/cr_sda4`
> Opening filesystem to check...
> incorrect offsets 9971 42739
> incorrect offsets 9971 42739
> incorrect offsets 9971 42739
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> 
> 

-- 
Hugo Mills             | I'm on a 30-day diet. So far I've lost 18 days.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
