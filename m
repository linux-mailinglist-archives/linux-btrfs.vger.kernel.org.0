Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84591A751E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406876AbgDNHoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 03:44:54 -0400
Received: from smtp.mujha-vel.cz ([81.30.225.246]:51447 "EHLO
        smtp.mujha-vel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406802AbgDNHox (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 03:44:53 -0400
X-Greylist: delayed 2143 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 03:44:52 EDT
Received: from [81.30.250.3] (helo=[172.16.1.2])
        by smtp.mujha-vel.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jn@forever.cz>)
        id 1jOFgu-00086f-La; Tue, 14 Apr 2020 09:09:05 +0200
Subject: balance canceling was: Re: slow single -> raid1 conversion (heavy
 write to original LVM volume)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <424ffd2a-2a9b-1cef-c3ac-ad2814f037a1@gmx.com>
From:   jakub nantl <jn@forever.cz>
Message-ID: <ccd87fca-56f2-3fc8-81c0-bdfb2f4aa9f8@forever.cz>
Date:   Tue, 14 Apr 2020 09:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <424ffd2a-2a9b-1cef-c3ac-ad2814f037a1@gmx.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15. 01. 20 4:26,  Qu Wenruo wrote:
> And due to another bug in balance canceling, we can't cancel it.
>
> For the unable to cancel part, there are patches to address it, and
> would get upstream in v5.6 release.

Hello,

looks like balance canceling is still not 100% in 5.6.x:


# btrfs balance status /data/
Balance on '/data/' is running, cancel requested
0 out of about 16 chunks balanced (9 considered), 100% left


Apr 13 23:30:52 sopa kernel: [ 6983.625318] BTRFS info (device dm-0):
balance: start -dusage=100,limit=16
Apr 13 23:30:52 sopa kernel: [ 6983.627286] BTRFS info (device dm-0):
relocating block group 5572244013056 flags data|raid1
Apr 13 23:31:05 sopa kernel: [ 6996.237814] BTRFS info (device dm-0):
relocating block group 5569073119232 flags data|raid1
Apr 13 23:31:40 sopa kernel: [ 7032.178175] BTRFS info (device dm-0):
found 17 extents, stage: move data extents
Apr 13 23:31:46 sopa kernel: [ 7037.711119] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
Apr 13 23:31:49 sopa kernel: [ 7040.767052] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
Apr 13 23:32:00 sopa kernel: [ 7051.885977] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
..

..

Apr 14 06:26:06 sopa kernel: [31897.468487] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
Apr 14 06:26:08 sopa kernel: [31900.034563] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
Apr 14 06:26:10 sopa kernel: [31901.719655] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
Apr 14 06:26:12 sopa kernel: [31903.334506] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers
Apr 14 06:26:12 sopa kernel: [31903.856791] BTRFS info (device dm-0):
found 17 extents, stage: update data pointers


Linux sopa 5.6.4-050604-generic #202004131234 SMP Mon Apr 13 12:36:46
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

# btrfs fi us /data/
Overall:
    Device size:           3.71TiB
    Device allocated:           3.71TiB
    Device unallocated:           2.00MiB
    Device missing:             0.00B
    Used:               3.30TiB
    Free (estimated):         209.16GiB    (min: 209.16GiB)
    Data ratio:                  2.00
    Metadata ratio:              2.00
    Global reserve:         512.00MiB    (used: 0.00B)

Data,RAID1: Size:1.85TiB, Used:1.64TiB
   /dev/mapper/sopa-data       1.85TiB
   /dev/sdb3       1.85TiB

Metadata,RAID1: Size:6.11GiB, Used:4.77GiB
   /dev/mapper/sopa-data       6.11GiB
   /dev/sdb3       6.11GiB

System,RAID1: Size:32.00MiB, Used:304.00KiB
   /dev/mapper/sopa-data      32.00MiB
   /dev/sdb3      32.00MiB

Unallocated:
   /dev/mapper/sopa-data       1.00MiB
   /dev/sdb3       1.00MiB

# btrfs fi show /data/
Label: 'SOPADATA'  uuid: 37b8a62c-68e8-44e4-a3b2-eb572385c3e8
    Total devices 2 FS bytes used 1.65TiB
    devid    1 size 1.86TiB used 1.85TiB path /dev/mapper/sopa-data
    devid    2 size 1.86TiB used 1.85TiB path /dev/sdb3

jn

