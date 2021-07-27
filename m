Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70913D8200
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhG0Voc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:44:32 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36758 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhG0Voc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:44:32 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9A112B05909; Tue, 27 Jul 2021 17:42:10 -0400 (EDT)
Date:   Tue, 27 Jul 2021 17:41:57 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
Message-ID: <20210727214049.GH10170@hungrycats.org>
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 01:39:55PM -0400, Dave T wrote:
> What does the list recommend I do in this case?
> 
> starting btrfs scrub ...
> scrub done for 56cea9cf-5374-4a43-b19d-6b0b143dc635
> Scrub started:    Sun Jul 25 00:40:43 2021
> Status:           finished
> Duration:         2:52:45
> Total to scrub:   1.26TiB
> Rate:             113.72MiB/s
> Error summary:    read=1
>   Corrected:      0
>   Uncorrectable:  1
>   Unverified:     0
> ERROR: there are uncorrectable errors

This is a read failure (data not available from device), not a csum error
(data available but not correct).

> dmesg | grep "checksum error at" | tail -n 20
> (no output)

You should be looking for a IO failure on the underlying device (the
one below /dev/mapper/userluks).  Look for log messages that appear just
before btrfs errors, or errors mentioning the device itself:

	dmesg | grep -B99 -i btrfs

	dmesg | grep -C9 sda

> # dmesg | grep -i checksum
> [  +0.001698] xor: automatically using best checksumming function   avx
> (not related to BTRFS, right?)
> 
> # btrfs fi us /path/to/xyz
> Overall:
>     Device size:                   2.73TiB
>     Device allocated:              1.26TiB
>     Device unallocated:            1.47TiB
>     Device missing:                  0.00B
>     Used:                          1.12TiB
>     Free (estimated):              1.60TiB      (min: 888.70GiB)
>     Free (statfs, df):             1.60TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:1.25TiB, Used:1.11TiB (89.38%)
>    /dev/mapper/userluks    1.25TiB
> 
> Metadata,DUP: Size:6.00GiB, Used:5.26GiB (87.67%)
>    /dev/mapper/userluks   12.00GiB
> 
> System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
>    /dev/mapper/userluks   64.00MiB

Since the error was not corrected, it likely occurred in the data blocks.

A metadata error would be correctable, so check wouldn't report it because
the scrub will have already corrected it (assuming the underlying drive
is still healthy enough to remap bad sectors).

> Unallocated:
>    /dev/mapper/userluks    1.47TiB
> 
> # btrfs check /dev/mapper/xyz

That command won't read any data blocks, so it won't see any errors there.

> Opening filesystem to check...
> Checking filesystem on /dev/mapper/xyz
> UUID: 56cea9cf-5374-4a43-b19d-6b0b143dc635
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 1230187327496 bytes used, no error found
> total csum bytes: 1195610680
> total tree bytes: 5648285696
> total fs tree bytes: 4011016192
> total extent tree bytes: 379256832
> btree space waste bytes: 827370015
> file data blocks allocated: 5497457123328
>  referenced 5523039584256
> 
> If more info is needed, please let me know. Recommendations and advice
> are appreciated.
> Thank you.
