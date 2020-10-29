Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18929F61C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 21:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgJ2UXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 16:23:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12D2C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 13:23:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i1so4203077wro.1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hZP3dF6aCVxZFwA4+epNf4Wx3EH6wONBL6yDqMGMHLM=;
        b=TBkxQZbCWgLbaR0bL1Xk5iT3Tr0T0cApn9CRIgdULxeRHrLwfXgZ/cVEtIgyHQ/L8H
         lE8bC5BFaSM2YOQm2bJs34nKeB41UNOMGaoCTK77jpUrVhD9LJ4hYX0jsqKBaYpQqQVX
         WBODpnOYdk+QIEw401C07xVwYVetr+T2oXtL5yLV3/0xzoHTXKA4kHVWP+U3KcdQdh1A
         VZtPGXDST4nCYTDvIbWaHAlmscyTZzJYALw6PWt3gdKH/nqpeB991IfAlgzR+bJSvvVl
         NCOVxSOKAhFZWCZtuwafAArtCpfmFh11oTmszzlGygH3vHRqwm94pMqiV4/wuiaHlAII
         EPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hZP3dF6aCVxZFwA4+epNf4Wx3EH6wONBL6yDqMGMHLM=;
        b=q2bWW1Pwu5STAwDMVLfqHT/qzFZ7HCDunrWCREIA/27UCVQn9cIDTYKWpHkL1Fr4J1
         Mx11YBPV+OTkm3KvlZ4tvBqpyw8DGtlj5xbonkdymndjb/nqGdMWxkuHdvCWAr9Sdo2R
         UUt1fDrSTPfZC6SP1IQGs7tVgGrmWhxOrCL8ODPzrb09nL2exmSrPrVcWSOtaM6Y4FAa
         4k5qYxDZXNhU+3WMLZFrLxSRvBm0lE1Vi/vjMgUR7OgYSZ7aySH8oEtZwS4Bz15ywSZB
         jCwzZMXTnkgXq7pxtTfb++uHaJ55cvcn3MV7kMJvjunZD8o9Oz6+ohVpuo4Hd45Hr6+m
         HrjQ==
X-Gm-Message-State: AOAM533w1ul03jTTRsOPJsdMRsunbD9i6okGx9oqi8US9h3cFZgwUXBO
        g+C0v87D91h35o9DVa9IFQ6wkLa4F4AorS5wwVMOnqmn2PBuNHrImnQ=
X-Google-Smtp-Source: ABdhPJxFqKFD+853j3gFRiD8K5BnJ/mcqvAs4V87AhytaID9+cv2ZFKrVdAeeXeIn0LRcy+ljsb9mYV3x4pzO7q5B/Y=
X-Received: by 2002:a05:6000:1185:: with SMTP id g5mr7862262wrx.42.1604003021437;
 Thu, 29 Oct 2020 13:23:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 29 Oct 2020 14:23:25 -0600
Message-ID: <CAJCQCtQqJY7vSVsQeRP82K1x9VtSYUHK1zmnpfXrtJKFbcYxJQ@mail.gmail.com>
Subject: btrfsck segfaults on root 5 missing its root dir, recreating
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream bug report, contains gdb backtrace of the coredump
https://bugzilla.redhat.com/show_bug.cgi?id=3D1892166

btrfs-progs-5.7-5.fc33.x86_64

Crash happens during
btrfsck --init-extent-tree --backup --progress /dev/sdc4

I'm not sure from the bug report why this command is being run; but at
least it should fail gracefully rather than crashing.

Oct 27 22:39:31 fedora systemd-coredump[1674]: [=F0=9F=A1=95] Process 1663
(btrfsck) of user 0 dumped core.

                                               Stack trace of thread 1663:
                                               #0  0x00005567c4efcda5
btrfs_search_slot (btrfs + 0x73da5)
                                               #1  0x00005567c4f13f53
btrfs_alloc_chunk (btrfs + 0x8af53)
                                               #2  0x00005567c4f070b9
do_chunk_alloc (btrfs + 0x7e0b9)
                                               #3  0x00005567c4f072b1
btrfs_reserve_extent (btrfs + 0x7e2b1)
                                               #4  0x00005567c4f07f45
btrfs_alloc_free_block (btrfs + 0x7ef45)
                                               #5  0x00005567c4efa6d3
__btrfs_cow_block (btrfs + 0x716d3)
                                               #6  0x00005567c4efaf42
btrfs_cow_block (btrfs + 0x71f42)
                                               #7  0x00005567c4efd049
btrfs_search_slot (btrfs + 0x74049)
                                               #8  0x00005567c4eff159
btrfs_insert_empty_items (btrfs + 0x76159)
                                               #9  0x00005567c4eff578
btrfs_insert_item (btrfs + 0x76578)
                                               #10 0x00005567c4f1f464
btrfs_make_root_dir (btrfs + 0x96464)
                                               #11 0x00005567c4ec5441
check_inode_recs.lto_priv.0 (btrfs + 0x3c441)
                                               #12 0x00005567c4ecf81e
cmd_check.lto_priv.0 (btrfs + 0x4681e)
                                               #13 0x00005567c4e9edd0
main (btrfs + 0x15dd0)
                                               #14 0x00007fb0d68e01a2
__libc_start_main (libc.so.6 + 0x281a2)
                                               #15 0x00005567c4e9f10e
_start (btrfs + 0x1610e)

                                               Stack trace of thread 1672:
                                               #0  0x00007fb0d6a990fc
read (libpthread.so.0 + 0x130fc)
                                               #1  0x00005567c4ec22dc
print_status_check.lto_priv.0 (btrfs + 0x392dc)
                                               #2  0x00007fb0d6a8f3f9
start_thread (libpthread.so.0 + 0x93f9)
                                               #3  0x00007fb0d69b9b03
__clone (libc.so.6 + 0x101b03)



--=20
Chris Murphy
