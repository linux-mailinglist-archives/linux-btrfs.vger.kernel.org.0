Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB72E8C29
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbhACMr0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 3 Jan 2021 07:47:26 -0500
Received: from mail.eclipso.de ([217.69.254.104]:55042 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbhACMrZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 3 Jan 2021 07:47:25 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 1C0090C0
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Jan 2021 13:46:44 +0100 (CET)
Date:   Sun, 03 Jan 2021 13:46:44 +0100
MIME-Version: 1.0
Message-ID: <fe1026c7d3efbf7d0ebb35cddb2c5774@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: btrfs raid 1 with a shared fast read cache, and individual slow write
        caches in front of hard drives, how?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

­I would like to create a btrfs raid array where one device (either hard drive, SSD or flash drive) can fail, and all the data survives.
Also, I would like to have a write cache in front of all the mechanical drives, so they can stay idle until the write cache if full, or data is requested that is not in the read cache.

I've looked at bcache. This can cache multiple block devices with a single read cache, but it cannot be stacked [1], so I cannot give each hard drive it's own (small) write cache, with a shared large read cache like this:
[1] https://bugzilla.kernel.org/show_bug.cgi?id=211011

+--------------------------------------------+
|         btrfs raid 1 (2 copies) /mnt       |
+--------------+--------------+--------------+
| /dev/bcache3 | /dev/bcache4 | /dev/bcache5 |
+--------------+--------------+--------------+
|              Read Cache (SSD)              |
|                /dev/sda4                   |
+--------------+--------------+--------------+
| /dev/bcache0 | /dev/bcache1 | /dev/bcache2 |
+--------------+--------------+--------------+
| Write Cache  | Write Cache  | Write Cache  |
|(Flash Drive) |(Flash Drive) |(Flash Drive) |
| /dev/sda5    | /dev/sda6    | /dev/sda7    |
+--------------+--------------+--------------+
| Data         | Data         | Data         |
| /dev/sda8    | /dev/sda9    | /dev/sda10   |
+--------------+--------------+--------------+

Would it be a good idea to use dm-cache to create pairs of hard drives and flash drives, and then use bcache on top of that to create a big shared read cache like this?

+--------------------------------------------+
|         btrfs raid 1 (2 copies) /mnt       |
+--------------+--------------+--------------+
| /dev/bcache0 | /dev/bcache1 | /dev/bcache2 |
+--------------+--------------+--------------+
|              Read Cache (SSD)              |
|                /dev/sda4                   |
+--------------+--------------+--------------+
| Logical      | Logical      | Logical      |
| Volume 0     | Volume 1     | Volume 2     |
+--------------+--------------+--------------+
| Cache volume | Cache volume | Cache volume |
|(Flash Drive) |(Flash Drive) |(Flash Drive) |
| /dev/sda5    | /dev/sda6    | /dev/sda7    |
+--------------+--------------+--------------+
| Origin volume| Origin volume| Origin volume|
| =Physical    | =Physical    | =Physical    |
| volume (PV)  | volume (PV)  | volume (PV)  |
| /dev/sda8    | /dev/sda9    | /dev/sda10   |
+--------------+--------------+--------------+

Will this stack survive a drive that goes missing? For instance by pulling out the data cable or the power cable of that drive?
Will this stack survive a drive that is silently corrupting data? For instance by dd'ing random data to it?

How would you solve this problem? 

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


