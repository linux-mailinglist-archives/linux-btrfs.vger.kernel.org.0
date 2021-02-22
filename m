Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE332209E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 21:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhBVUGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 15:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhBVUGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 15:06:34 -0500
X-Greylist: delayed 1651 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Feb 2021 12:05:53 PST
Received: from smtp.steev.me.uk (smtp.steev.me.uk [IPv6:2001:8b0:162c:10::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC83AC061786
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 12:05:53 -0800 (PST)
Received: from [2001:8b0:162c:2:25bd:2aa:7eff:5a0a]
        by smtp.steev.me.uk with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.93.0.4)
        id 1lEH29-001iFl-VT
        for linux-btrfs@vger.kernel.org; Mon, 22 Feb 2021 19:38:18 +0000
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Steven Davies <btrfs-list@steev.me.uk>
Subject: 5.11.0: open ctree failed: devide total_bytes should be at most X but
 found Y
Message-ID: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
Date:   Mon, 22 Feb 2021 19:38:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Booted my system with kernel 5.11.0 vanilla with the first time and received this:

BTRFS info (device nvme0n1p2): has skinny extents
BTRFS error (device nvme0n1p2): device total_bytes should be at most 964757028864 but found 
964770336768
BTRFS error (device nvme0n1p2): failed to read chunk tree: -22

Booting with 5.10.12 has no issues.

# btrfs filesystem usage /
Overall:
     Device size:                 898.51GiB
     Device allocated:            620.06GiB
     Device unallocated:          278.45GiB
     Device missing:                  0.00B
     Used:                        616.58GiB
     Free (estimated):            279.94GiB      (min: 140.72GiB)
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:568.00GiB, Used:566.51GiB (99.74%)
    /dev/nvme0n1p2        568.00GiB

Metadata,DUP: Size:26.00GiB, Used:25.03GiB (96.29%)
    /dev/nvme0n1p2         52.00GiB

System,DUP: Size:32.00MiB, Used:80.00KiB (0.24%)
    /dev/nvme0n1p2         64.00MiB

Unallocated:
    /dev/nvme0n1p2        278.45GiB

# parted -l
Model: Sabrent Rocket Q (nvme)
Disk /dev/nvme0n1: 1000GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system     Name  Flags
  1      1049kB  1075MB  1074MB  fat32                 boot, esp
  2      1075MB  966GB   965GB   btrfs
  3      966GB   1000GB  34.4GB  linux-swap(v1)        swap

What has changed in 5.11 which might cause this?

