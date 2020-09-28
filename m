Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94C27AEF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI1NSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1NSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 09:18:06 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1F7C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 06:18:06 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4C0NP81M1WzQjYX
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 15:18:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 6ggCemgEFd0O for <linux-btrfs@vger.kernel.org>;
        Mon, 28 Sep 2020 15:18:01 +0200 (CEST)
Message-ID: <5df695c82cd7f44da5e57d3a8c8549a01130d759.camel@wittke-web.de>
Subject: Recover from Extent Tree Corruption (maybe due to hardware failure)
From:   Marc Wittke <marc@wittke-web.de>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 28 Sep 2020 10:17:41 -0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.91 / 15.00 / 15.00
X-Rspamd-Queue-Id: 247BE13E2
X-Rspamd-UID: 09cc8e
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi mailing-list,

yesterday I had a catastrophic file system corruption on my notebook. 

The machine was running over night doing basically nothing, but when I had a look in the morning, the file system was mounted readonly. Not thinking a lot about it I decided to reboot the machine, but
it did not came up. Cryptsetup was able to open the volume, but the btrfs rootfs was unable to be mounted. I ended up in the rescue system.

In the meantime I dd-ed the bad partition to a USB disk, and finally reinstalled the system after various rescue attempts. However, I am missing one work of not-pushed development work :(

Can't provide you with all details of the failing system, since it isn't there any more. It was a full patched Fedora 32, so I think the following info from my current system is valid for the previous
as well. Please note that this is coming from the usb drive (/dev/sdc1) that was originally /dev/dm-1. The error messages are identical.

Disk type: intel 600p 2000GB nvme

kernel 5.8.11-200.fc32.x86_64 (unsure, might have been 5.9 already)
btrfs-progs v5.7 

# btrfs fi show
Label: none  uuid: 131112e7-6e32-474c-813a-9c1ce4292c18
	Total devices 1 FS bytes used 535.72GiB
	devid    1 size 1.83TiB used 538.02GiB path /dev/sdc1 

# mount /dev/sdc1 /mnt
mount: /mnt: can't read superblock on /dev/sdc1.

# sudo btrfs rescue super-recover -v /dev/sdc1
All Devices:
	Device: id = 1, name = /dev/sdc1

Before Recovering:
	[All good supers]:
		device name = /dev/sdc1
		superblock bytenr = 65536

		device name = /dev/sdc1
		superblock bytenr = 67108864

		device name = /dev/sdc1
		superblock bytenr = 274877906944

	[All bad supers]:

All supers are valid, no need to recover


# sudo btrfs restore -oi /dev/sdc1 /home/marc/rescued/
checksum verify failed on 385831911424 found 000000C0 wanted 0000001C
checksum verify failed on 385831911424 found 000000C0 wanted 0000001C
bad tree block 385831911424, bytenr mismatch, want=385831911424, have=1900825539188143805
checksum verify failed on 385831911424 found 000000C0 wanted 0000001C
checksum verify failed on 385831911424 found 000000C0 wanted 0000001C
bad tree block 385831911424, bytenr mismatch, want=385831911424, have=1900825539188143805
Error searching -5
Error searching /home/marc/rescued/etc/anaconda
checksum verify failed on 385831911424 found 000000C0 wanted 0000001C
checksum verify failed on 385831911424 found 000000C0 wanted 0000001C
bad tree block 385831911424, bytenr mismatch, want=385831911424, have=1900825539188143805
Error searching -5
... and so on ...
bad tree block 385831682048, bytenr mismatch, want=385831682048, have=18271273693833811190
Error searching -5
Error searching /home/marc/rescued/var


# btrfs check /dev/sdc1
Opening filesystem to check...
Checking filesystem on /dev/sdc1
UUID: 131112e7-6e32-474c-813a-9c1ce4292c18
[1/7] checking root items
checksum verify failed on 385811005440 found 000000D7 wanted 0000007E
checksum verify failed on 385811005440 found 000000D7 wanted 0000007E
bad tree block 385811005440, bytenr mismatch, want=385811005440, have=12032019063440798054
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
checksum verify failed on 385829978112 found 000000EE wanted FFFFFFCD
checksum verify failed on 385829978112 found 000000EE wanted FFFFFFCD
bad tree block 385829978112, bytenr mismatch, want=385829978112, have=389172930910726983
checksum verify failed on 385829978112 found 000000EE wanted FFFFFFCD
checksum verify failed on 385829978112 found 000000EE wanted FFFFFFCD
bad tree block 385829978112, bytenr mismatch, want=385829978112, have=389172930910726983
checksum verify failed on 385829978112 found 000000EE wanted FFFFFFCD
...
backpointer mismatch on [568129818624 4096]
ref mismatch on [568129822720 4096] extent item 0, found 1
data backref 568129822720 root 5 owner 3387874 offset 32802598912 num_refs 0 not found in extent tree
incorrect local backref count on 568129822720 root 5 owner 3387874 offset 32802598912 found 1 wanted 0 back 0x55da67434c10
...
root 5 inode 4269638 errors 2001, no inode item, link count wrong
	unresolved ref dir 267 index 0 namelen 3 name kde filetype 2 errors 6, no dir index, no inode ref
root 5 inode 4288305 errors 2001, no inode item, link count wrong
	unresolved ref dir 267 index 0 namelen 6 name kde4rc filetype 1 errors 6, no dir index, no inode ref
...
ERROR: errors found in fs roots
found 575218155520 bytes used, error(s) found
total csum bytes: 547173716
total tree bytes: 3970580480
total fs tree bytes: 3200319488
total extent tree bytes: 159367168
btree space waste bytes: 603945834
file data blocks allocated: 3481346736128
 referenced 559327043584

# dmesg (relevant portion)
Sep 28 09:46:10 localhost.localdomain kernel: BTRFS info (device sdc1): disk space caching is enabled
Sep 28 09:46:11 localhost.localdomain kernel: BTRFS info (device sdc1): has skinny extents
Sep 28 09:46:15 localhost.localdomain kernel: btree_readpage_end_io_hook: 1 callbacks suppressed
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): bad tree block start, want 385831223296 have 17007041628713579106
Sep 28 09:46:15 localhost.localdomain kernel: BTRFS error (device sdc1): could not do orphan cleanup -5
Sep 28 09:46:16 localhost.localdomain kernel: BTRFS: error (device sdc1) in __btrfs_free_extent:3069: errno=-5 IO failure
Sep 28 09:46:16 localhost.localdomain kernel: BTRFS: error (device sdc1) in btrfs_run_delayed_refs:2173: errno=-5 IO failure
Sep 28 09:46:16 localhost.localdomain kernel: BTRFS error (device sdc1): commit super ret -5
Sep 28 09:46:17 localhost.localdomain kernel: BTRFS error (device sdc1): open_ctree failed

I somehow managed to mount the filesystem readonly with a plethora of options that I copied from somewhere, but none of the directories was readable. Just a lot of question marks.

There is a chance that the drive failed physically (although 18 months old). After reinstallation the system did not boot again, since i ran out of time I sticked the old 256GB SATA SSD and
use it for now. Don't have access to a machine that supports nvme drives to run an extensive test, could run it over night later.

Any suggestions?

Thanks,
Marc



