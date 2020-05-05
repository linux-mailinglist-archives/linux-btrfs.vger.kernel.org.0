Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE31C5277
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEEKDT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEKDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 06:03:19 -0400
X-Greylist: delayed 251 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 May 2020 03:03:19 PDT
Received: from smtp.ixydo.com (unknown [IPv6:2a01:4f8:192:8445:b0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03503C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 03:03:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.ixydo.com (Postfix) with ESMTP id D411CF3FDE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 10:03:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at smtp.ixydo.com
Received: from smtp.ixydo.com ([127.0.0.1])
        by localhost (ht-mx-5.ixydo.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7mPb8HR_UWUE for <linux-btrfs@vger.kernel.org>;
        Tue,  5 May 2020 10:03:16 +0000 (UTC)
Received: from [10.3.2.105] (unknown [88.98.92.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by smtp.ixydo.com (Postfix) with ESMTPSA id 6FAECF3FDA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 10:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ixydo.com 6FAECF3FDA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mx.ixido.net; s=mail;
        t=1588672996; bh=js7NhqYj21vJCBdDlypqVrgIS+hjmGzY+4+mNnL78l8=;
        l=5079; h=Subject:To:References:From:Date:In-Reply-To:From;
        b=wj6USrCsY4SUaG+Xuhd+QjOxoeqyWeQjavn01etkeUMBL4H1pdpXeYXl8RkOGTf1B
         Y7yL3YQceaDnDaWJ3uStzwpF2p6zLapNq1P+dXHS1iB0YE6XfIqsTVmbOp2NnuEgnc
         bKBuqLdsvuHOQbnfcpec9uRQ1T5aT2Hw+fmOBe6631ShG6jTiZ/ORIsUjl1nScQ6iI
         +NiGcmhlXyLGC62VFLKPU6SUZ3bHd78hTGWH/d/8biNzMBH3ClJYqLogunFFvF3qu3
         YxqrodFSkcxgwMou6+I0C/tqGL5BvN9RRlEQjrsvs6/edgq319R6ZT0DHRucUkh8/w
         b7UKYZozeh4Ow==
Subject: Re: BTRFS critical: unable to find logical 39209762816 length 4096
To:     linux-btrfs@vger.kernel.org
References: <85204219-e503-9e61-c4b5-9b3373f8a9f3@ixydo.com>
From:   Jinn <linux-btrfs@mx.ixido.net>
Message-ID: <77ff2ead-a3d5-f26b-f2eb-17013240f76a@ixydo.com>
Date:   Tue, 5 May 2020 11:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <85204219-e503-9e61-c4b5-9b3373f8a9f3@ixydo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I realized I missed a couple of further information commands:

  $ sudo btrfs fi show /mnt/crypt-timemachine
  Label: 'timemachine'  uuid: a09ae23f-f5b9-4ff4-a29a-d2fd81c6d450
          Total devices 1 FS bytes used 680.00KiB
          devid    1 size 2.27TiB used 3.04GiB path /dev/mapper/crypt-timemachine

  $ sudo btrfs fi df /mnt/crypt-timemachine
  Data, single: total=8.00MiB, used=520.00KiB
  System, DUP: total=8.00MiB, used=16.00KiB
  System, single: total=4.00MiB, used=0.00B
  Metadata, DUP: total=1.50GiB, used=144.00KiB
  Metadata, single: total=8.00MiB, used=0.00B
  GlobalReserve, single: total=16.00MiB, used=0.00B

On 05/05/2020 10:59, Jinn wrote:
> Hi,
> 
> I have a filesystem that appears to have lost it's data.  I believe the ATA interface on the
> host has failed, which has lead to this problem.  It would be nice to recover the data if
> possible.  Prior to realizing the ATA bus was the issue I had two other BTRFS filesystems
> connected, all of which were repaired by connecting to another ATA bus then scrubbing.
> 
> This particular filesystem has no subvolume snapshots, though I have been using snapper on
> other filesystems to manage this.
> 
> The filesystem can be mounted without issue, but when I try to scrub it aborts immediately
> with the following status.  Before disconnecting I believe the filesystem was being
> automatically remounted read-only when writes were attempted, though I haven't confirmed this.
> 
>   $ sudo btrfs scrub status /mnt/crypt-timemachine
>   scrub status for a09ae23f-f5b9-4ff4-a29a-d2fd81c6d450
>           scrub started at Mon May  4 14:50:42 2020 and was aborted after 00:00:00
>           total bytes scrubbed: 264.00KiB with 0 errors
> 
> In the kernel logs I see:
> 
>   kernel: BTRFS critical (device dm-4): unable to find logical 39209762816 length 4096
>   kernel: BTRFS critical (device dm-4): unable to find logical 39209762816 length 4096
>   kernel: BTRFS critical (device dm-4): unable to find logical 39209762816 length 16384
> 
> The output of btrfs check:
> 
>   $ sudo btrfs check /dev/mapper/crypt-timemachine
>   Checking filesystem on /dev/mapper/crypt-timemachine
>   UUID: a09ae23f-f5b9-4ff4-a29a-d2fd81c6d450
>   checking extents
>   Couldn't map the block 39209762816
>   Invalid mapping for 39209762816-39209779200, got 588439879680-588976750592
>   Couldn't map the block 39209762816
>   bytenr mismatch, want=39209762816, have=0
>   ref mismatch on [39209762816 16384] extent item 0, found 1
>   tree backref 39209762816 parent 7 root 7 not found in extent tree
>   backpointer mismatch on [39209762816 16384]
>   owner ref check failed [39209762816 16384]
>   ref mismatch on [588965576704 16384] extent item 1, found 0
>   backref 588965576704 root 7 not referenced back 0x55ccdfad6660
>   incorrect global backref count on 588965576704 found 1 wanted 0
>   backpointer mismatch on [588965576704 16384]
>   owner ref check failed [588965576704 16384]
>   ERROR: errors found in extent allocation tree or chunk allocation
>   checking free space cache
>   checking fs roots
>   checking csums
>   Couldn't map the block 39209762816
>   Invalid mapping for 39209762816-39209779200, got 588439879680-588976750592
>   Couldn't map the block 39209762816
>   bytenr mismatch, want=39209762816, have=0
>   Error going to next leaf -5
>   checking root refs
>   found 712704 bytes used, error(s) found
>   total csum bytes: 8
>   total tree bytes: 147456
>   total fs tree bytes: 32768
>   total extent tree bytes: 16384
>   btree space waste bytes: 132656
>   file data blocks allocated: 532480
>    referenced 532480
> 
> SMART output for the disk doesn't suggest any issues with the disk itself, i.e.
> Offline_Uncorrectable, UDMA_CRC_Error_Count, Reallocated_Event_Count,
> Current_Pending_Sector, Reallocated_Sector_Ct, Seek_Error_Rate, are all 0.  Extended offline
> tests are run regularly and have all completed without error.
> 
> I've tried to scrub on multiple hosts with varying kernels and btrfs-progs
> 
> 1. Original host was Debian Buster on a backports kernel:
>    5.4.0-0.bpo.4-amd64 #1 SMP Debian 5.4.19-1~bpo10+1 (2020-03-09) x86_64 GNU/Linux
> 
>    Started with stock btrfs-progs 4.20.1-2, then tried the package from backports,
>    btrfs-progs 5.2.1-1~bpo10+1
> 
> 2. Second host was Ubuntu 18.04 with a mainline kernel:
>    5.6.7-050607-generic #202004230933 SMP Thu Apr 23 09:35:28 UTC 2020 x86_64 GNU/Linux
> 
>    Only tried stock btrfs-progs here: 4.15.1-1build1
> 
>    Disk is connected via a USB to SATA adapter.
> 
> 3. Third system is a stocket Ubuntu 18.04
>    4.15.0-99-generic #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020 x86_64 GNU/Linux
> 
>    With btrfs-progs 4.15.1-1build1.
> 
> At this point is there any hope of recovering the data?  If not, is it worth trying to do a
> repair with `btrfs check`, or anything else?  Or should I just go ahead and re-format the disk?
> 
> Any help is much appreciated.
> 
> Thanks,
> Jinn
> 
