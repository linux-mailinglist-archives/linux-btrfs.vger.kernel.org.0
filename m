Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585A2354549
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhDEQfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhDEQfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 12:35:21 -0400
X-Greylist: delayed 4620 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Apr 2021 09:35:15 PDT
Received: from smtp.steev.me.uk (smtp.steev.me.uk [IPv6:2001:8b0:162c:10::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74550C061756
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Apr 2021 09:35:15 -0700 (PDT)
Received: from [2001:8b0:162c:2:f93c:4b42:7a74:6cb2]
        by smtp.steev.me.uk with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.93.0.4)
        id 1lTQzT-0001gK-Tw
        for linux-btrfs@vger.kernel.org; Mon, 05 Apr 2021 16:18:11 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
Subject: Device missing with RAID1 on boot - observations
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <b9c77dc7-8c72-7c64-9ce8-bcb4555de0c0@steev.me.uk>
Date:   Mon, 5 Apr 2021 16:18:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel: 5.11.8 vanilla, btrfs-progs 5.11.1

I booted a box with a root btrfs raid1 across two devices, /dev/nvme0n1p2 (devid 2) and 
/dev/sda2 (devid 3). For whatever reason during the initrd stage, btrfs device scan was unable 
to see the NVMe device and mounted the rootfs degraded after multiple retries as I had designed 
in the init script.

Once booted apparently the kernel was able to see nvme0n1p2 again (with no intervention from me) 
and btrfs device usage / btrfs filesystem show did not report any missing devices. btrfs scrub 
reported that devid 2 was unwriteable but the scrub completed successfully on devid 3 with no 
errors. New block groups for data and metadata were being created as single on devid 3.

I balanced with -dconvert=single -mconvert=dup which moved all block groups to devid 3 and 
completed successfully; there was nothing remaining on devid 2 so I removed the device from the 
filesystem and re-added it as devid 4. Once I'd balanced the filesystem back to -dconvert=raid1 
-mconvert=raid1 everything was back to normal.

My main observation was that it was very hard to notice that there was an issue. Yes, I'd 
purposefully mounted as degraded, but there was no indication from the btrfs tools as to why new 
block groups were only being created as single on one device: nothing was marked as missing or 
unwriteable. Is this behavour expected? How can a device be unwriteable but not marked as missing?

Was my course of action to correct the issue correct - is there a better way to re-sync a raid1 
device which has temporarily been removed?

(Afterwards I realised what caused the issue - missing libraries in the initrd - and I can 
reproduce it if necessary.)

-- 
Steven Davies

