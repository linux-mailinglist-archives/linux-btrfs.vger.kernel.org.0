Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749AA1C5296
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgEEKIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgEEKIb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 06:08:31 -0400
Received: from smtp.ixydo.com (unknown [IPv6:2a01:4f8:192:8445:b0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A0C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 03:08:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.ixydo.com (Postfix) with ESMTP id 363BFF3E35
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 09:59:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at smtp.ixydo.com
Received: from smtp.ixydo.com ([127.0.0.1])
        by localhost (ht-mx-5.ixydo.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xKd4EFKmzWYj for <linux-btrfs@vger.kernel.org>;
        Tue,  5 May 2020 09:59:05 +0000 (UTC)
Received: from [10.3.2.105] (unknown [88.98.92.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.ixydo.com (Postfix) with ESMTPSA id BCB18F3FCB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 09:59:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ixydo.com BCB18F3FCB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mx.ixido.net; s=mail;
        t=1588672745; bh=3Yc3gZAwi8i1r1bgPAqFuw05mpkioVgXFEZZ2NKybJQ=;
        l=4203; h=To:From:Subject:Date:From;
        b=FCmLKiXm4VtiYKwwe3R/0r+WHxta38Doh8HHXslUtmc2DVRMk5CH1ic4DbYs0U2QY
         n90SxY5pTGf/yVR7poeU6Cc5dB5SObdrP0aeHyplbkd4A4k6zH1Y31oF98vBCZasgk
         swVwYOJk0oMI3GyH05wKo4uT0dfP6W+Q3pSUgxGBadVsl6FIdHlhiI2PDJsEOswCJz
         74fgkVQFl2tIjOziRqiLWYV4sTNIOBT8Q5mbwGSMrmODRmyYBsd9t9knDP2Ht/iyKK
         Phw3ny/zcoRiLe7RtWBVoiBwQv/IysFPyEMhSV6sBLOFqG3I/uz83DUnfsny2FxiND
         7TX5JUyyi856A==
To:     linux-btrfs@vger.kernel.org
From:   Jinn <linux-btrfs@mx.ixido.net>
Subject: BTRFS critical: unable to find logical 39209762816 length 4096
Message-ID: <85204219-e503-9e61-c4b5-9b3373f8a9f3@ixydo.com>
Date:   Tue, 5 May 2020 10:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a filesystem that appears to have lost it's data.  I believe the ATA interface on the
host has failed, which has lead to this problem.  It would be nice to recover the data if
possible.  Prior to realizing the ATA bus was the issue I had two other BTRFS filesystems
connected, all of which were repaired by connecting to another ATA bus then scrubbing.

This particular filesystem has no subvolume snapshots, though I have been using snapper on
other filesystems to manage this.

The filesystem can be mounted without issue, but when I try to scrub it aborts immediately
with the following status.  Before disconnecting I believe the filesystem was being
automatically remounted read-only when writes were attempted, though I haven't confirmed this.

  $ sudo btrfs scrub status /mnt/crypt-timemachine
  scrub status for a09ae23f-f5b9-4ff4-a29a-d2fd81c6d450
          scrub started at Mon May  4 14:50:42 2020 and was aborted after 00:00:00
          total bytes scrubbed: 264.00KiB with 0 errors

In the kernel logs I see:

  kernel: BTRFS critical (device dm-4): unable to find logical 39209762816 length 4096
  kernel: BTRFS critical (device dm-4): unable to find logical 39209762816 length 4096
  kernel: BTRFS critical (device dm-4): unable to find logical 39209762816 length 16384

The output of btrfs check:

  $ sudo btrfs check /dev/mapper/crypt-timemachine
  Checking filesystem on /dev/mapper/crypt-timemachine
  UUID: a09ae23f-f5b9-4ff4-a29a-d2fd81c6d450
  checking extents
  Couldn't map the block 39209762816
  Invalid mapping for 39209762816-39209779200, got 588439879680-588976750592
  Couldn't map the block 39209762816
  bytenr mismatch, want=39209762816, have=0
  ref mismatch on [39209762816 16384] extent item 0, found 1
  tree backref 39209762816 parent 7 root 7 not found in extent tree
  backpointer mismatch on [39209762816 16384]
  owner ref check failed [39209762816 16384]
  ref mismatch on [588965576704 16384] extent item 1, found 0
  backref 588965576704 root 7 not referenced back 0x55ccdfad6660
  incorrect global backref count on 588965576704 found 1 wanted 0
  backpointer mismatch on [588965576704 16384]
  owner ref check failed [588965576704 16384]
  ERROR: errors found in extent allocation tree or chunk allocation
  checking free space cache
  checking fs roots
  checking csums
  Couldn't map the block 39209762816
  Invalid mapping for 39209762816-39209779200, got 588439879680-588976750592
  Couldn't map the block 39209762816
  bytenr mismatch, want=39209762816, have=0
  Error going to next leaf -5
  checking root refs
  found 712704 bytes used, error(s) found
  total csum bytes: 8
  total tree bytes: 147456
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 132656
  file data blocks allocated: 532480
   referenced 532480

SMART output for the disk doesn't suggest any issues with the disk itself, i.e.
Offline_Uncorrectable, UDMA_CRC_Error_Count, Reallocated_Event_Count,
Current_Pending_Sector, Reallocated_Sector_Ct, Seek_Error_Rate, are all 0.  Extended offline
tests are run regularly and have all completed without error.

I've tried to scrub on multiple hosts with varying kernels and btrfs-progs

1. Original host was Debian Buster on a backports kernel:
   5.4.0-0.bpo.4-amd64 #1 SMP Debian 5.4.19-1~bpo10+1 (2020-03-09) x86_64 GNU/Linux

   Started with stock btrfs-progs 4.20.1-2, then tried the package from backports,
   btrfs-progs 5.2.1-1~bpo10+1

2. Second host was Ubuntu 18.04 with a mainline kernel:
   5.6.7-050607-generic #202004230933 SMP Thu Apr 23 09:35:28 UTC 2020 x86_64 GNU/Linux

   Only tried stock btrfs-progs here: 4.15.1-1build1

   Disk is connected via a USB to SATA adapter.

3. Third system is a stocket Ubuntu 18.04
   4.15.0-99-generic #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020 x86_64 GNU/Linux

   With btrfs-progs 4.15.1-1build1.

At this point is there any hope of recovering the data?  If not, is it worth trying to do a
repair with `btrfs check`, or anything else?  Or should I just go ahead and re-format the disk?

Any help is much appreciated.

Thanks,
Jinn
