Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E78E711
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfHOIjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 04:39:15 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41080 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfHOIjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 04:39:15 -0400
Received: by mail-qt1-f176.google.com with SMTP id i4so1569146qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ciLX8mtFt9sD6iexwd0VhqaaCfx2LOobug8Hq7Ux5Sg=;
        b=vBdHrte7V1nWkAF8WZ3tFi/EyBGa1CqCiZosZCSpkEhL9o3GyEHUtLo7Nt2iYN3YMG
         t0d9kzLJRtfNSnG32nxq3fWSgcg+Pep0tN9HZ2+36etG9fQo7YFQOs/iDJ6wsSLlbecK
         mDWAJ1bJalD6cQ7fvVXK/PlfTJgcz6hTcyLPYJk+n4wS92PmPIpxKvsGMWefztPIUQDc
         fVQ9wfRnxrxiDEUvQD4e9+RAF3phVwWLK9FgyxSX4wNhTjQbiV8gWxibUhApRPMA4Iyw
         GNku1H04u+LKOhq8LYRqnWzY7E+BJbiJl+li9L1rYgr8ZT9h3mjMmyLECDUKrmzmW7zk
         bNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ciLX8mtFt9sD6iexwd0VhqaaCfx2LOobug8Hq7Ux5Sg=;
        b=FCPxrBZDIC00GFgcdGIomPrGubA6oZl3XhTJ3zNfmcsPZZ7Sc+NRtHglyCVgm/Cg5N
         O5wkxi7IxlttVRySB9kkY+v2JrSFgo8P63Savl4GNxmX2mjFv00nyrohN8P1O6MA348k
         dBC6D66+5imEQSe+/cci5ImCCk+mZNlqYi5yW+Mu90Z4lD9CLDgf7NfoOceuRqRiXcSL
         EzgNIxLqs9GQmlvL/rh+F03CRbOJrrHm4u6TWoKeNvQslJsfxsI1pAC4wDeRJ8trzGvy
         qe6b/3OpQ23YVTUJfJCGJVGH2INTOAT8Kbh1q4LJiqXzhU2Fr+xBsig5VZySF/ooGJL4
         kamg==
X-Gm-Message-State: APjAAAVMOdm4UZzMJTO4XfKEFU8efglR6+KR1RvgxNZD4dQszUZ72JUk
        +h00XpG4qOU/YaAnTkrlaxOlTVH+JzAiCIqn4KKejzLS
X-Google-Smtp-Source: APXvYqwpbbmkCgCk2MwFGQnk/4WkbCxUV0xCbMyJxh7PYOSUN7yGYR9prGFo5wUM1bh0FQyqnOhFUTi3BiV2mbgk+Ss=
X-Received: by 2002:ac8:6b02:: with SMTP id w2mr2971868qts.35.1565858354633;
 Thu, 15 Aug 2019 01:39:14 -0700 (PDT)
MIME-Version: 1.0
From:   Jim Geo <dim.geo@gmail.com>
Date:   Thu, 15 Aug 2019 11:39:03 +0300
Message-ID: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>
Subject: btrfs corruption: invalid mode: has 00 expect valid S_IF* bit(s)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

my  /home folder is on a single device btrfs partition.
When I ls a directory, I get these messages on ls:
ls: cannot access 'file1' : Input/output error
ls: cannot access 'file2' : Input/output error
ls: cannot access 'file3' : Input/output error

and dmesg says:
[31209.938486] BTRFS critical (device sdd1): corrupt leaf: root=5
block=859701248 slot=93 ino=5830829, invalid mode: has 00 expect valid
S_IF* bit(s)
[31209.938489] BTRFS error (device sdd1): block=859701248 read time
tree block corruption detected
[31209.948749] BTRFS critical (device sdd1): corrupt leaf: root=5
block=859701248 slot=93 ino=5830829, invalid mode: has 00 expect valid
S_IF* bit(s)
[31209.948751] BTRFS error (device sdd1): block=859701248 read time
tree block corruption detected
[31209.949109] BTRFS critical (device sdd1): corrupt leaf: root=5
block=859701248 slot=93 ino=5830829, invalid mode: has 00 expect valid
S_IF* bit(s)
[31209.949110] BTRFS error (device sdd1): block=859701248 read time
tree block corruption detected
[31209.949751] BTRFS critical (device sdd1): corrupt leaf: root=5
block=859701248 slot=93 ino=5830829, invalid mode: has 00 expect valid
S_IF* bit(s)
[31209.949752] BTRFS error (device sdd1): block=859701248 read time
tree block corruption detected
[31209.950163] BTRFS critical (device sdd1): corrupt leaf: root=5
block=859701248 slot=93 ino=5830829, invalid mode: has 00 expect valid
S_IF* bit(s)
[31209.950165] BTRFS error (device sdd1): block=859701248 read time
tree block corruption detected
[31209.950320] BTRFS critical (device sdd1): corrupt leaf: root=5
block=859701248 slot=93 ino=5830829, invalid mode: has 00 expect valid
S_IF* bit(s)
[31209.950321] BTRFS error (device sdd1): block=859701248 read time
tree block corruption detected

I scrubbed the filesystem but no errors were detected/fixed.

btrfs scrub status /home:
scrub status for myuuid
        scrub started at Thu Aug 15 02:24:42 2019 and finished after 03:55:12
        total bytes scrubbed: 2.05TiB with 0 errors

 uname -a:
Linux gentoo 5.2.8-ck #1 SMP PREEMPT Wed Aug 14 20:44:33 EEST 2019
x86_64 Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz GenuineIntel GNU/Linux

btrfs --version:
btrfs-progs v4.19

btrfs fi show:
Label: 'home_btrfs'  uuid:-------
        Total devices 1 FS bytes used 2.04TiB
        devid    1 size 2.13TiB used 2.13TiB path /dev/sdd1

btrfs fi df /home:
Data, single: total=2.12TiB, used=2.04TiB
System, DUP: total=64.00MiB, used=256.00KiB
Metadata, DUP: total=7.00GiB, used=4.48GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

btrfs device stats /home:
[/dev/sdd1].write_io_errs    4
[/dev/sdd1].read_io_errs     3
[/dev/sdd1].flush_io_errs    0
[/dev/sdd1].corruption_errs  0
[/dev/sdd1].generation_errs  0

mount options:
/dev/sdd1 on /home type btrfs
(rw,relatime,space_cache,autodefrag,subvolid=5,subvol=/)

How can I fix this corruption? How can I detect if more
files/directories are affected?

Kind Regards,
Jim
