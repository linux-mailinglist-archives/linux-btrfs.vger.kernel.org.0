Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9085634E7E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhC3MvQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 30 Mar 2021 08:51:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhC3MvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 08:51:00 -0400
Received: from [192.168.177.84] ([91.56.89.170]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N1Oft-1lbcvs3BFr-012muW; Tue, 30 Mar 2021 14:50:55 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Chris Murphy" <lists@colorremedies.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re[2]: Filesystem sometimes Hangs
Date:   Tue, 30 Mar 2021 12:50:56 +0000
Message-Id: <em7b647410-6346-4e95-b97a-f45ee2de0037@desktop-g0r648m>
In-Reply-To: <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com>
References: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
 <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.1.1060.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:4CtthETag1BEMcbScnClp17AuOQ01tDX/u/XBse4BJJf5ItU328
 aoAB4guzmAWkWzitcyrYSzu6Pqdzz232y/Sp/LjdxcXh3GCF7iz933n/eCgcSJn77iyso7B
 4znyAPcz9QmUAJuC8rFCtYudDIUUi6nKDKfb+/PLUFl7nXApiyzlkbGRLDUCsf31tVEpxW4
 kBQYulmZBSNZhB6fbWGVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AHSyIdLeHus=:1V2m19fsrOFht40bMgY1k9
 L+twLB2+VPoCI9Ex9dxZshhVPh/9vPawGoA09JN+nFrC6JIZzVV7UE5AZ+g121i5QIajeMhIj
 i4jUeBjZsIpMkz+0a3zo83EuB2pZRHrJVPoh1uTHxK01YIHDL91m3paEB2U8Jn9PeHVMdZ0PU
 4q9z3sFDbD8pYHFQc8Ps0arqRRtH6U7RxwksusobGSBezVkKd196GE/4+zfs0y9d68tVb4keY
 5TivONFvJ2zeFg51QrBVxdIGRFEq+gSDBYGlz1gv3fWu0a4gTLJuy9RR7Biw0lv8EBFuFw30O
 OYdJAde1wI7FXcNMcQvsT0EFCde4+kKm7UkmRs6pQFQViGgS2sTG9kK0TnITqzNlOpk06nXNi
 luizJ+H+2geUSvSMZGMxCq0DXkyaJjLT1+TFQdmhLa7NX6vp4wnFbi4rxyJNmn1GAvS5Ruz/Y
 +ryd7wHYyV73Jy5CJMR1oEzf4qI6Q2JhPLKRepv3F6nmTkjbfY0l
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

  thanks for your reply, Chris.
>>  [Mo Mär 29 09:29:22 2021] BTRFS info (device sda1): bdev /dev/sda1 errs:
>>  wr 133, rd 133, flush 0, corrupt 0, gen 1
>>
>>  Maybe, the last line is concerning?
>
>Yes. Do a 'btrfs scrub' and check dmesg for detailed errors.
[Mo Mär 29 09:29:22 2021] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 133, rd 133, flush 0, corrupt 0, gen 1
[Mo Mär 29 13:10:39 2021] BTRFS info (device sda1): scrub: started on devid 1
[Mo Mär 29 13:10:39 2021] BTRFS info (device sda1): scrub: started on devid 2
[Mo Mär 29 23:30:49 2021] BTRFS info (device sda1): scrub: not finished on devid 2 with status: -125
[Mo Mär 29 23:30:50 2021] BTRFS info (device sda1): scrub: not finished on devid 1 with status: -125
[Di Mär 30 00:04:07 2021] BTRFS info (device sda1): scrub: started on devid 1
[Di Mär 30 00:04:07 2021] BTRFS info (device sda1): scrub: started on devid 2
[Di Mär 30 02:50:09 2021] BTRFS info (device sda1): scrub: finished on devid 1 with status: 0
[Di Mär 30 04:36:59 2021] BTRFS info (device sda1): scrub: finished on devid 2 with status: 0

  There is nothing more, related to btrfs.

What I find in syslog:
Mar 28 20:28:21 homeserver kernel: [1298340.851140] INFO: task btrfs-cleaner:20078 blocked for more than 241 seconds.
Mar 28 20:28:21 homeserver kernel: [1298340.854109] task:btrfs-cleaner   state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
Mar 28 20:28:21 homeserver kernel: [1298340.854151]  wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854169]  start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854183]  btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854202]  ? btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854218]  btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854232]  cleaner_kthread+0xfa/0x120 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854247]  ? btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.857610]  wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.857627]  start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.857643]  btrfs_create+0x58/0x1f0 [btrfs]



>  Next
>'btrfs check --readonly' (must be done offline ie booted from usb
>stick). And if it all comes up without errors or problems, you can
>zero the statistics with 'btrfs dev stats -z'.
No error found. Neither in btrfs check, nor in scrub.
So, shall I reset the stats then?

>But otherwise we need
>to see the errors to know what's going wrong. It's not normal to have
>either read or write errors. It could be related to the problem, or an
>additional problem.

>
>>  Mar 28 20:58:34 homeserver kernel: [1300153.336273]  ?
>>  btrfs_cleanup_transaction+0x590/0x590 [btrfs]
>>
>>
>>  What could I do to find the cause?
>
>What kernel version?

5.10.0-0.bpo.3-amd64

Best regards,
Hendrik

