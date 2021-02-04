Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41930FA08
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhBDRo2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 4 Feb 2021 12:44:28 -0500
Received: from mail.eclipso.de ([217.69.254.104]:39384 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238573AbhBDRoO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 12:44:14 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 06E46ADA
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Feb 2021 18:43:23 +0100 (CET)
Date:   Thu, 04 Feb 2021 18:43:23 +0100
MIME-Version: 1.0
Message-ID: <24e578627d205151df16b5aebe4a551e@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs
        does, what's that called?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     "Andy Smith" <andy@strugglers.net>
Cc:     <linux-btrfs@vger.kernel.org>, <linux-raid@vger.kernel.org>
In-Reply-To: <20210204105457.GI3712@bitfolk.com>
References: <f5d8af48e8d5543267089286c01c476f@mail.eclipso.de>
        <a2cd87208a74fb36224539fa10727066@mail.eclipso.de>
        <20210204105457.GI3712@bitfolk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--- Ursprüngliche Nachricht ---
Von: Andy Smith <andy@strugglers.net>
Datum: 04.02.2021 11:54:57
An: linux-btrfs@vger.kernel.org
Betreff: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs  does, what's that called?

Hi Cedric,

On Wed, Feb 03, 2021 at 08:33:18PM +0100,   wrote:
> it's called "dm-integrity", as mentioned in this e-mail:
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg93037.html


If you do this it would be very interesting to see performance
figures for the following setups:

- btrfs with raid1 meta and data allocation
- mdadm raid1 on raw devices
- mdadm raid1 on dm-integrity (no encryption) on raw devices
- mdadm raid1 on dm-integrity (encryption) on raw devices

just to see what kind of performance loss dm-integrity and
encryption is going to impose.

After doing it, it would find a nice home on the Linux RAID wiki:

    https://raid.wiki.kernel.org/index.php/Dm-integrity

Cheers,
Andy

Hey Andy,

I would rather see performance figures for these setups:
A) btrfs with 2 (or more) hard drives and one SSD in writeback bcache configuration (unsafe against failure of the ssd):
+-----------------------------+
|      btrfs raid 1 /mnt      |
+--------------+--------------+
| /dev/Bcache0 | /dev/Bcache1 |
+--------------+--------------+
|   bcache writeback Cache    |
|           /dev/sdk1         |
+--------------+--------------+
| Data         | Data         |
| /dev/sdv1    | /dev/sdw1    |
+--------------+--------------+

B) btrfs with 2 (or more) hard drives and two SSD's in dm-raid 1 writeback bcache configuration (unsafe against corruption of any of the ssd's): 
+-----------------------------+
|      btrfs raid 1 /mnt      |
+--------------+--------------+
| /dev/Bcache0 | /dev/Bcache1 |
+--------------+--------------+
|   bcache writeback Cache    |
|           /dev/dm0          |
+--------------+--------------+
| 2x SSD in mdadm raid 1      |
| /dev/sdk1       /dev/sdl1   |
+--------------+--------------+
| Data         | Data         |
| /dev/sdv1    | /dev/sdw1    |
+--------------+--------------+

C) Full stack: btrfs with 2 (or more) hard drives and two identical SSD's in dm-raid 1 with dm-integrity writeback bcache configuration (safe against any failed drive):
+-----------------------------+
|      btrfs raid 1 /mnt      |
+--------------+--------------+
| /dev/Bcache0 | /dev/Bcache1 |
+--------------+--------------+
|   bcache writeback Cache    |
|           /dev/dm0          |
+--------------+--------------+
| 2 x dm-integrity devices    |
| in mdadm raid 1             |
+--------------+--------------+
| SSD hosting  | SSD hosting  |
| dm-integrity | dm-integrity |
| /dev/sdk1    | /dev/sdl1    |
+--------------+--------------+
| Data         | Data         |
| /dev/sdv1    | /dev/sdw1    |
+--------------+--------------+

D) Full stack: btrfs with 2 (or more) hard drives and two SSD's (one slow, and one very fast) in dm-raid 1 with dm-integrity writeback bcache configuration (safe against any failed drive):
+-----------------------------+
|      btrfs raid 1 /mnt      |
+--------------+--------------+
| /dev/Bcache0 | /dev/Bcache1 |
+--------------+--------------+
|   bcache writeback Cache    |
|           /dev/dm0          |
+--------------+--------------+
| 2 x dm-integrity devices    |
| in mdadm raid 1             |
+--------------+--------------+
| SSD hosting  | SSD hosting  |
| dm-integrity | dm-integrity |
| /dev/sdk1    | /dev/sdl1    |
+--------------+--------------+
| Data         | Data         |
| /dev/sdv1    | /dev/sdw1    |
+--------------+--------------+

In all these setups, the performance of the hard drives is irrelevant, because the speed of the setups comes from the bcache SSD.

Cheers,
Cedric

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


