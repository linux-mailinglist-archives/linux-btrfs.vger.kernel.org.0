Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8543115898
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 22:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFV0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 16:26:07 -0500
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:56516 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfLFV0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 16:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1575667565;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Kb/J57ZIs2WYs7b7MhI6mDwQCRcOp50kQTRhz0oyNzc=;
        b=dYpKHT776O7oLa5KJKIFMxb98Fw1EXdTos8xcJ6K+z+0OWu8/P+p79zFypeUiDQA
        1PDDWCwPu/9ENNpmpoRyXW6IsviW9ksGmJVD08cTuDtN3AEFIe9tcITpNR5n5RmV8iK
        jVMmw8o+lSjTqgsTJSmup5LhDZv1Df9YFenr3soM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1575667565;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Kb/J57ZIs2WYs7b7MhI6mDwQCRcOp50kQTRhz0oyNzc=;
        b=L1gnkcWqq35LH+8Q3BUPfmvPLb+dql8K62Jt+UsihCH2OU4Qk37fGu8GVQ25QF76
        gkU3hj5VI1p6cRHkfZBAIPmjBQ++8uyd8L2p2gHI3MsNK74+Vgj9ahcLONt/JF42YUh
        xGeixupaUq+QWXWSPpc3FmnUZGzpVfZyqiALijtI=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Subject: df shows no available space in 5.4.1
Message-ID: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
Date:   Fri, 6 Dec 2019 21:26:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.06-54.240.4.3
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

with kernel 5.4.1 I have the problem that df shows 100% space used. I
can still write to the btrfs volume, but my software looks at the
available space and starts deleting stuff if statfs() says there is a
low amount of available space.

# df -h
Filesystem                                            Size  Used Avail
Use% Mounted on
...
/dev/loop0                                            7.4T  623G     0
100% /media/backup
...

statfs("/media/backup", {f_type=BTRFS_SUPER_MAGIC, f_bsize=4096,
f_blocks=1985810876, f_bfree=1822074245, f_bavail=0, f_files=0,
f_ffree=0, f_fsid={val=[3667078581, 2813298474]}, f_namelen=255,
f_frsize=4096, f_flags=ST_VALID|ST_NOATIME}) = 0

# btrfs fi usage /media/backup
Overall:
    Device size:                   7.40TiB
    Device allocated:            671.02GiB
    Device unallocated:            6.74TiB
    Device missing:                  0.00B
    Used:                        622.49GiB
    Free (estimated):              6.79TiB      (min: 6.79TiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:666.01GiB, Used:617.95GiB
   /dev/loop0    666.01GiB

Metadata,single: Size:5.01GiB, Used:4.54GiB
   /dev/loop0      5.01GiB

System,single: Size:4.00MiB, Used:96.00KiB
   /dev/loop0      4.00MiB

Unallocated:
   /dev/loop0      6.74TiB

# btrfs fi df /media/backup
Data, single: total=666.01GiB, used=617.95GiB
System, single: total=4.00MiB, used=96.00KiB
Metadata, single: total=5.01GiB, used=4.54GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# mount

...
/dev/loop0 on /media/backup type btrfs
(rw,noatime,nossd,discard,space_cache=v2,enospc_debug,skip_balance,commit=86400,subvolid=5,subvol=/)
...

(I remounted with enospc_debug and the available space did not change...)

Regards,
Martin Raiber

