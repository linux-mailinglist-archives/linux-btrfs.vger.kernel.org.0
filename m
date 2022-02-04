Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DF4A9A59
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiBDNxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 08:53:32 -0500
Received: from vybihal.cz ([37.205.8.242]:42630 "EHLO vybihal.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239939AbiBDNxc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 08:53:32 -0500
Received: from webmail.vybihal.cz (vybihal.cz [IPv6:2a01:430:17:1::ffff:1391])
        by vybihal.cz (Postfix) with ESMTPSA id 9304318AD28
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 14:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vybihal.cz; s=mail;
        t=1643982808; bh=3Ovm0x4wr0tKpSIi81PuHHJGu06Difl6BBZ0cEqv0MA=;
        h=Date:From:To:Subject:From;
        b=IN5R6bp2msbFliW+tesdpEk1vKB7pef+yWr51nS9M+2GhRMe/tttWJmQlvCtgzH3+
         0N63j95DqNAgmhjtCCPCegAh9GxP8MwoIbhQEP/2xgjpm8cuOAuh819LBlBkN5GkrK
         SDphXC8Qm/Ve3rlAJgAr1Dm67VR4q7BnjPKAIdm8=
MIME-Version: 1.0
Date:   Fri, 04 Feb 2022 13:53:28 +0000
From:   =?UTF-8?Q?Josef_Vyb=C3=ADhal?= <josef@vybihal.cz>
To:     linux-btrfs@vger.kernel.org
Subject: failed to repair damaged filesystem, aborting | kernel BUG at
 fs/btrfs/extent-tree.c:4955!
Message-ID: <bd60df7210fdf3ed1dae48a8cb9908a5@vybihal.cz>
X-Sender: josef@vybihal.cz
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, btrfs failed me big time today. I am using archlinux, linux 5.16. 
My laptop started strangely lagging. I discovered, all of the sudden, 
btrfs was mounted ro. I rebooted and then the system acted very weird. I 
have discovered it was because ANY write operation just hangs 
indefinitely. For example 'touch test' just hangs. removing snapshot 
hangs. I should probably mention btrfs is inside of luks.
I have cloned the disk and booted ubuntu live from USB and started 
poking around the clone.

I uploaded dmesg and whole result of btrfs check here: 
https://up.jvi.cz/0X.txt

The SSD drive itself is okay according to SMART. I cloned it no problem.

The filesystem is in a state, that even check --repair can not help it:

backpointer mismatch on [3229016064 28672]
attempting to repair backref discrepancy for bytenr 3229016064
extent start and backref starts don't match, please use btrfs-image on 
this file system and send it to a btrfs developer so they can make fsck 
fix this particular case.  bytenr is 3229016064, bytes is 28672
failed to repair damaged filesystem, aborting

Scrub hangs too:
root@ubuntu:/mnt/jvb# btrfs scrub status .
UUID:             e22cc9ec-1607-413b-91a4-f09a9c03fbeb
Scrub started:    Fri Feb  4 13:28:11 2022
Status:           running
Duration:         0:14:01
Time left:        0:00:00
ETA:              Fri Feb  4 13:42:16 2022
Total to scrub:   394.37GiB
Bytes scrubbed:   0.00B  (0.00%)
Rate:             0.00B/s
Error summary:    no errors found





Is there something I can do to fix it? Whom to send the image with 
metadata? It has 3+ GB.

Or should I start reinstalling and recovering from backup?


Josef
