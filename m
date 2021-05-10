Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C763798AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhEJVAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 17:00:32 -0400
Received: from mail-out2.in.tum.de ([131.159.0.36]:34564 "EHLO
        mail-out2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhEJVAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 17:00:32 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 17:00:31 EDT
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 5A5D64A013D; Mon, 10 May 2021 22:50:17 +0200 (CEST)
Received: (Authenticated sender: fent)
        by mail.in.tum.de (Postfix) with ESMTPSA id 1524A4A00D3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 May 2021 22:50:16 +0200 (CEST)
        (Extended-Queue-bit tech_yiqjt@fff.in.tum.de)
To:     linux-btrfs@vger.kernel.org
From:   Philipp Fent <fent@in.tum.de>
Subject: Leaf corruption due to csum range
Message-ID: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
Date:   Mon, 10 May 2021 22:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6D695880C8D01C3440D98BFF"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------6D695880C8D01C3440D98BFF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I encountered a btrfs error on my system. I run Microsoft SQL Server in
a docker container on a btrfs filesystem on an SSD. When bulk-loading
some benchmark data, my system reproducibly enters in the following
failing state:

[  366.665714] BTRFS critical (device sda): corrupt leaf:
root=18446744073709551610 block=507544305664 slot=0, csum end range
(308900515840) goes beyond the start range (308900384768) of the next
csum item
[  366.665723] BTRFS info (device sda): leaf 507544305664 gen 18292
total ptrs 4 free space 3 owner 18446744073709551610
[  366.665725]  item 0 key (18446744073709551606 128 308891275264)
itemoff 7259 itemsize 9024
[  366.665727]  item 1 key (18446744073709551606 128 308900384768)
itemoff 7067 itemsize 192
[  366.665728]  item 2 key (18446744073709551606 128 309036716032)
itemoff 2587 itemsize 4480
[  366.665730]  item 3 key (18446744073709551606 128 309041303552)
itemoff 103 itemsize 2484
[  366.665731] BTRFS error (device sda): block=507544305664 write time
tree block corruption detected
[  366.665821] BTRFS: error (device sda) in btrfs_sync_log:3136:
errno=-5 IO failure
[  366.665824] BTRFS info (device sda): forced readonly

Please note the erroring ranges:
csum end:   308900515840
Start next: 308900384768
which is a difference of (1 << 17) == 0b100000000000000000 == 128KB
To me, this looks suspiciously like an off-by-one error, but I'm not too
versed in debugging btrfs.

I reproduced this several times on my machine using the attached
scripts. The only obvious similarity between the crashes is this 128KB
csum end / start next. Sometimes a get one corrupt leaf, sometimes many.
I tried to reproduce it on another machine with an HDD, but didn't
encounter this error there.
Can you help me to debug this further?

# uname -a
Linux desk 5.12.2-arch1-1 #1 SMP PREEMPT Fri, 07 May 2021 15:36:06 +0000
x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.11.1
# btrfs fi show
Label: none  uuid: 6733acf5-be40-4fe2-9d6f-819d39e49720
        Total devices 1 FS bytes used 187.11GiB
        devid    1 size 931.51GiB used 208.03GiB path /dev/sda
# btrfs fi df /ssdSpace
Data, single: total=207.00GiB, used=186.67GiB
System, single: total=32.00MiB, used=48.00KiB
Metadata, single: total=1.00GiB, used=450.08MiB
GlobalReserve, single: total=215.41MiB, used=0.00B

--------------6D695880C8D01C3440D98BFF
Content-Type: application/gzip;
 name="btrfsbug.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="btrfsbug.tar.gz"

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
a1a8NrKRjWxkI1r+BYfYZYQAMAAA
--------------6D695880C8D01C3440D98BFF--
