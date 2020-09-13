Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A898C2680E0
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Sep 2020 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgIMS4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 14:56:54 -0400
Received: from mail.talpidae.net ([176.9.32.230]:38719 "EHLO
        node0.talpidae.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMS4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 14:56:53 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2020 14:56:53 EDT
Received: from talpidae.net (localhost [127.0.0.1])
        by node0.talpidae.net (mail.talpidae.net) with ESMTP id AA1A6B7883D
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Sep 2020 18:47:46 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 13 Sep 2020 20:47:44 +0200
From:   Jonas Zeiger <jonas.zeiger@talpidae.net>
To:     linux-btrfs@vger.kernel.org
Subject: Detecting new partitions fails after "btrfs device scan --forget"
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <1ab4e230fe413c033b195bbd0f7e1db0@talpidae.net>
X-Sender: jonas.zeiger@talpidae.net
Organization: talpidae.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Our automated linux deployments on x86_64 stopped working when switching 
from 5.8.7 to 5.8.8 or 5.8.9 (both tested).

We perform aproximately the following routine on PXE booted servers with 
EMPTY disks (never done IO):

# [Step 1] Wipe disks
# $d == /dev/sda /dev/sdb and so on
btrfs device scan --forget
wipefs --all $d
dd if=/dev/zero of=$d bs=32M count=1
sync
sleep 1
hdparm -z $d

# [Step 2] Partitioning
parted -a optimal -s $d \\
	mklabel gpt \\
	mkpart primary 0% 4M \\
	mkpart primary 4M 10% \\
	name 2 "system" \\
	mkpart primary 10% 100% \\
	name 3 "ceph" \\
	quit

[Step 2] fails with kernel 5.8.8 and 5.8.9 with:
Error: Partition(s) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 
34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 
52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 
70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 
88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 
105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 
119, 120, 121, 122, 123, 124, 125, 126, 127, 128 on /dev/sda have been 
written, but we have been unable to inform the kernel of the change, 
probably because it/they are in use.  As a result, the old partition(s) 
will remain in use.  You should reboot now before making further 
changes.

The partitions do not become visible so the deployment can't continue.

I logged into the system at this point and checked that no filesystem is 
mounted and no relevant messages appear in the console.

The only weird thing I noticed is a lot of these:
[26523.729131] ata3.00: Enabling discard_zeroes_data
[26524.737705] ata3.00: Enabling discard_zeroes_data
[26524.783084] ata7.00: Enabling discard_zeroes_data
[26524.788256] ata7.00: Enabling discard_zeroes_data
[26524.877407] ata7.00: Enabling discard_zeroes_data
[26525.885710] ata7.00: Enabling discard_zeroes_data
[26525.931513] ata4.00: Enabling discard_zeroes_data
[26525.936719] ata4.00: Enabling discard_zeroes_data
[26526.026196] ata4.00: Enabling discard_zeroes_data
[26527.034256] ata4.00: Enabling discard_zeroes_data
[26527.079552] ata8.00: Enabling discard_zeroes_data
...

But that may not have anything to do with this.

Switching back to a 5.8.7 kernel makes the problem go away.

I file this under filesystems (BTRFS) because I noticed a few relevant 
commits in the changelog that mention the word "lock", but I may be 
completely wrong and another subsystem/commit is causing this.

I also created a bugzilla entry tracking this issue:

   https://bugzilla.kernel.org/show_bug.cgi?id=209221
