Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62DC4A771F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 18:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiBBRws convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 2 Feb 2022 12:52:48 -0500
Received: from 202-142-134-175.ca8e86.mel.static.aussiebb.net ([202.142.134.175]:37882
        "EHLO mail.extremenerds.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346362AbiBBRwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Feb 2022 12:52:47 -0500
Received: from smtpclient.apple (unknown [192.168.1.51])
        by mail.extremenerds.net (Postfix) with ESMTPS id C18A64007A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 04:52:44 +1100 (AEDT)
From:   "A. Duvnjak" <avian@extremenerds.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Errors after attempt to switch to space_cache v2
Message-Id: <607C7B0F-C9C7-4706-85AE-08067C294EBE@extremenerds.net>
Date:   Thu, 3 Feb 2022 04:52:44 +1100
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've got what seems to be serious issues after a failed attempt at changing space_cache to v2, I hope someone can give me a hand.  This is on kernel 5.16.5 with btrfs-progs-5.16.  The btrfs array consisted of three harddrives with data and metadata in raid1 (drives sdc, sdd, and sde).   

To summarise I unmounted my btrfs mountpoint.  But had issues when attempting to clear space cache v1.  i.e. 

# btrfs check --clear-space-cache v1 /dev/sdc
Opening filesystem to check...
ERROR: cannot open device '/dev/sde': Device or resource busy
ERROR: cannot open file system

# btrfs check --clear-space-cache v1 /dev/sde
Opening filesystem to check...
ERROR: cannot open device '/dev/sdc': Device or resource busy
ERROR: cannot open file system

So I decided to mount recovery,ro and take it from there (I think this is where everything started to go pear shaped).
# btrfs check --force --clear-space-cache v1 /dev/sdc
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/sdc
UUID: dcd91ddb-7d8f-4e46-8194-d65d90a3a632
Free space cache cleared

After that I proceeded to mount with v2
# mount /dev/sdc /mnt/btrfs -o space_cache=v2

And everything seemed fine, mount showed -
/dev/sdc on /mnt/btrfs type btrfs (rw,relatime,noacl,space_cache,subvolid=5,subvol=/)

Upon rebooting, I only get errors.  
# dmesg | grep -i btrfs
[    1.492591] Btrfs loaded, crc32c=crc32c-intel, zoned=no, fsverity=no
[    1.780249] BTRFS: device label AFP_SHARES devid 1 transid 559554 /dev/sdc scanned by udevd (611)
[    1.803303] BTRFS: device label AFP_SHARES devid 3 transid 559554 /dev/sde scanned by udevd (599)
[    1.834261] BTRFS: device label AFP_SHARES devid 2 transid 559554 /dev/sdd scanned by udevd (603)
[    3.427014] BTRFS info (device sdc): flagging fs with big metadata feature
[    3.428870] BTRFS info (device sdc): enabling free space tree
[    3.429874] BTRFS info (device sdc): using free space tree
[    3.430862] BTRFS info (device sdc): has skinny extents
[    3.513644] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[    3.526500] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[    3.527492] BTRFS warning (device sdc): failed to read root (objectid=4): -5
[    3.540041] BTRFS error (device sdc): open_ctree failed
[   13.154413] BTRFS info (device sdc): flagging fs with big metadata feature
[   13.154420] BTRFS info (device sdc): enabling free space tree
[   13.154422] BTRFS info (device sdc): using free space tree
[   13.154424] BTRFS info (device sdc): has skinny extents
[   13.232776] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[   13.233110] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[   13.233114] BTRFS warning (device sdc): failed to read root (objectid=4): -5
[   13.246887] BTRFS error (device sdc): open_ctree failed
[   36.522466] BTRFS info (device sdc): flagging fs with big metadata feature
[   36.522470] BTRFS info (device sdc): disk space caching is enabled
[   36.522471] BTRFS info (device sdc): has skinny extents
[   36.564648] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[   36.564787] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[   36.564791] BTRFS warning (device sdc): failed to read root (objectid=4): -5
[   36.569833] BTRFS error (device sdc): open_ctree failed
[   49.273053] BTRFS info (device sdc): flagging fs with big metadata feature
[   49.273060] BTRFS info (device sdc): disk space caching is enabled
[   49.273062] BTRFS info (device sdc): has skinny extents
[   49.313220] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[   49.313358] BTRFS error (device sdc): parent transid verify failed on 8370924699648 wanted 559536 found 559555
[   49.313362] BTRFS warning (device sdc): failed to read root (objectid=4): -5
[   49.318341] BTRFS error (device sdc): open_ctree failed
[  174.364643] BTRFS info (device sdc): flagging fs with big metadata feature
[  174.364650] BTRFS info (device sdc): allowing degraded mounts
[  174.364651] BTRFS info (device sdc): disk space caching is enabled
[  174.364653] BTRFS info (device sdc): has skinny extents
[............]

#mount -t btrfs /dev/sdc /mnt/btrfs
mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.

# btrfs check /dev/sdc
Opening filesystem to check...
parent transid verify failed on 8370924699648 wanted 559536 found 559555
parent transid verify failed on 8370924699648 wanted 559536 found 559555
parent transid verify failed on 8370924699648 wanted 559536 found 559555
Ignoring transid failure
ERROR: root [4 0] level 2 does not match 1

Couldn't setup device tree
ERROR: cannot open file system


If someone can advice how to proceed I would be greatful.


