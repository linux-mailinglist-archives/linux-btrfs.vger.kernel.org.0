Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6666058C903
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbiHHNHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiHHNHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 09:07:30 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 06:07:26 PDT
Received: from mail-out-02.servage.net (mail-out-02.servage.net [93.90.146.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158E9FD1
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 06:07:26 -0700 (PDT)
X-Halon-ID: e5a712b9-171a-11ed-a59e-005056913d2d
Authorized-sender: u1m2114@blauwurf.info
Received: from [10.2.10.3] (firewall1a.robinson.cam.ac.uk [193.60.93.97])
        by mail-out-01.servage.net (Halon) with ESMTPSA
        id e5a712b9-171a-11ed-a59e-005056913d2d;
        Mon, 08 Aug 2022 15:06:21 +0200 (CEST)
Message-ID: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
Date:   Mon, 8 Aug 2022 13:06:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
From:   Michael Zacherl <ubu@bluemole.com>
Subject: Corrupted btrfs (LUKS), seeking advice
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US, en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
on the occasion of retrofitting a 2TB ssd for my old XPS13 9350 I decided to give btrfs w/ encryption a try (this was in June).
Now, by a dumb mistake, I have a corrupted btrfs (LUKS encrypted).
Since I can't boot from this partition anymore I'm using the distro's live system.
This partition can't be mounted.

# uname -a
Linux EndeavourOS 5.18.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 16 Jun 2022 20:40:45 +0000 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v5.18.1

What I did so far:

# cryptsetup open /dev/nvme0n1p2 luks-test
Enter passphrase for /dev/nvme0n1p2:
[worked]
# mount -o ro,rescue=usebackuproot  /dev/mapper/luks-test /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/mapper/luks-test, missing codepage or helper program, or other error.
        dmesg(1) may have more information after failed mount system call.

      dmesg after this mount attempt:
[ 5179.422225] BTRFS info (device dm-1): flagging fs with big metadata feature
[ 5179.422248] BTRFS info (device dm-1): trying to use backup root at mount time
[ 5179.422255] BTRFS info (device dm-1): using free space tree
[ 5179.422260] BTRFS info (device dm-1): has skinny extents
[ 5179.431117] BTRFS error (device dm-1): parent transid verify failed on 334692352 wanted 14761 found 14765
[ 5179.431338] BTRFS error (device dm-1): parent transid verify failed on 334692352 wanted 14761 found 14765
[ 5179.431358] BTRFS error (device dm-1): failed to read block groups: -5
[ 5179.433358] BTRFS error (device dm-1): open_ctree failed

# btrfs check /dev/mapper/luks-test 2>&1|less -I
parent transid verify failed on 334692352 wanted 14761 found 14765
parent transid verify failed on 334692352 wanted 14761 found 14765
parent transid verify failed on 334692352 wanted 14761 found 14765
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 334643200 wanted 14761 found 14765
parent transid verify failed on 334643200 wanted 14761 found 14765
parent transid verify failed on 334643200 wanted 14761 found 14765
Ignoring transid failure
parent transid verify failed on 334659584 wanted 14761 found 14765
parent transid verify failed on 334659584 wanted 14761 found 14765
parent transid verify failed on 334659584 wanted 14761 found 14765
Ignoring transid failure
parent transid verify failed on 334430208 wanted 6728 found 14763
parent transid verify failed on 334430208 wanted 6728 found 14763
parent transid verify failed on 334430208 wanted 6728 found 14763
Ignoring transid failure
parent transid verify failed on 334675968 wanted 14761 found 14765
parent transid verify failed on 334675968 wanted 14761 found 14765
parent transid verify failed on 334675968 wanted 14761 found 14765
Ignoring transid failure
parent transid verify failed on 335216640 wanted 6728 found 14765
parent transid verify failed on 335216640 wanted 6728 found 14765
parent transid verify failed on 335216640 wanted 6728 found 14765
Ignoring transid failure
parent transid verify failed on 320847872 wanted 14323 found 14763
parent transid verify failed on 320847872 wanted 14323 found 14763
parent transid verify failed on 320847872 wanted 14323 found 14763
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=119848960 item=49 parent level=1 child bytenr=320847872 child level=1
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
parent transid verify failed on 340246528 wanted 14741 found 14764
parent transid verify failed on 340246528 wanted 14741 found 14764
parent transid verify failed on 340246528 wanted 14741 found 14764
Ignoring transid failure
[... skipping many lines]
root 257 inode 1866942 errors 2001, no inode item, link count wrong
         unresolved ref dir 5719 index 9016 namelen 28 name SiteSecurityServiceState.txt filetype 1 errors 4, no inode ref
root 257 inode 1866943 errors 2001, no inode item, link count wrong
         unresolved ref dir 5719 index 9018 namelen 21 name AlternateServices.txt filetype 1 errors 4, no inode ref
root 257 inode 1866989 errors 2001, no inode item, link count wrong
         unresolved ref dir 346 index 16043 namelen 4 name user filetype 1 errors 4, no inode ref
root 257 inode 1866990 errors 2001, no inode item, link count wrong
         unresolved ref dir 1216 index 11701 namelen 46 name 0_3_1920_1080_8b47947fd8179de11b12e22fa2a454c8 filetype 1 errors 4, no inode ref
root 257 inode 1866991 errors 2001, no inode item, link count wrong
         unresolved ref dir 5720 index 6961 namelen 16 name recovery.jsonlz4 filetype 1 errors 4, no inode ref
root 257 inode 1866995 errors 2001, no inode item, link count wrong
         unresolved ref dir 6765 index 134 namelen 42 name 3647222921wleabcEoxlt-eengsairo.sqlite-wal filetype 1 errors 4, no inode ref
parent transid verify failed on 348258304 wanted 14749 found 14766
Ignoring transid failure
parent transid verify failed on 348258304 wanted 14749 found 14766
Ignoring transid failure
parent transid verify failed on 348258304 wanted 14749 found 14766
Ignoring transid failure
parent transid verify failed on 348258304 wanted 14749 found 14766
Ignoring transid failure
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-test
UUID: 2d1dc6b4-84ab-4c64-91a0-669b6228c516
found 83720974336 bytes used, error(s) found
total csum bytes: 50467580
total tree bytes: 266665984
total fs tree bytes: 186236928
total extent tree bytes: 17317888
btree space waste bytes: 40645922
file data blocks allocated: 87345299456
  referenced 47847440384
[less: lines 1364572-1364611/1364611 byte 90015202/90015202 (END)  (press RETURN)]

# btrfs-find-root /dev/mapper/luks-test
parent transid verify failed on 334692352 wanted 14761 found 14765
parent transid verify failed on 334692352 wanted 14761 found 14765
ERROR: failed to read block groups: Input/output error
Superblock thinks the generation is 14761
Superblock thinks the level is 0
Found tree root at 444612608 gen 14761 level 0
Well block 347160576(gen: 14768 level: 0) seems good, but generation/level doesn't match, want gen: 14761 level: 0
Well block 348192768(gen: 14766 level: 0) seems good, but generation/level doesn't match, want gen: 14761 level: 0
Well block 347865088(gen: 14765 level: 0) seems good, but generation/level doesn't match, want gen: 14761 level: 0
Well block 418840576(gen: 14758 level: 0) seems good, but generation/level doesn't match, want gen: 14761 level: 0
Well block 417120256(gen: 14749 level: 0) seems good, but generation/level doesn't match, want gen: 14761 level: 0
Well block 352256000(gen: 14743 level: 0) seems good, but generation/level doesn't match, want gen: 14761 level: 0
[end]

This is what I found out by reading.
A fix - if possible - is out of my league now and don't want to poke around and make things worse.
Any chance to get this FS at least mounted for RO?

Thanks a lot, Michael.
