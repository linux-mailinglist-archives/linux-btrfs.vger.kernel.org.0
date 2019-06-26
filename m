Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8814A570F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFZSsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 14:48:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40819 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZSsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 14:48:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3121681wmj.5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdaHfch7mG6GymDgEw0T+oQJeLaHJV3HcCBN5PLUa9k=;
        b=dVTSjz34rTntN3hM/Eaz8vFz+FoZ97MQNnhZXOzrXUBfmGrG5Y5VCiP/HsZGEpTIRw
         AyeWsiAHDn5V4opDr9iomLA9bWkFc3jIGhO+KoOny9eJyAmnGSuivJjBns+rDKdrNvEQ
         j0yAIoFFbDXM02q0CAMEycNliIkSyxNyiDNeK0YgR0D09S4iVNiDC7HxnMl2VXgqZ6Wh
         7MgIPdYVdGagsaFYEG9hXe4gVaxelgRkoGizGv/oHLGZ97uqEeLELVdKNHS4OzFhanbT
         RqbW22iP8KrH4OsTQbY2n0pbj8S0pTimplpK0hZcX3LR1QFJhHbwWnO1cCuLvwI8MwHw
         zB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdaHfch7mG6GymDgEw0T+oQJeLaHJV3HcCBN5PLUa9k=;
        b=Uhi5Nk9tc6Q2pETm1hRKAp9P5NQD+rNg60E2wali+9p3X6prU/nwK/NvRwY2vCJC9G
         t6uy8rphTZXiNsCZxURRp7l5pTZCkslPZd8bUzU4MRlSM5+wdYhQRTzvVppnHx5BQ5EX
         PATEwwTLK0T41vfmHhF4hHDDJVSZZW7pwj3Huc2YvtoqeDeJPe50XG/o+T3fmPF/tv+c
         vjBw07TyXMVGHY7DJT8Bda2B8e9lCnv1+FUgWyXL1yZ4fmefx/2fYHNuKiKhLqYn+4gE
         EYioFpUVdbZqAZhNfTysFSUjf/Lsf71O3ajW8N6f9RvuaRW5uDrKXLH1ktELYdQGVLtU
         xdmA==
X-Gm-Message-State: APjAAAWX5SU4db9v9Z0yRPXPyiai5OXv+LlatZ3kCDRx64eLwT4LrNte
        j1EyCW/7obEW/XD0YICocRAAbAxpqP8kc5Nkx4tRsLNF+9T3Nw==
X-Google-Smtp-Source: APXvYqxx829r7fU7hFKm4FyM5y6SurEdrn2FEha5ZzgNNPt062FoeFFZfYkBfo8s7ftBI308woyHI61cG53a39f3ZFc=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr290311wmb.66.1561574883153;
 Wed, 26 Jun 2019 11:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com> <CAJCQCtT8SE5TYkVniJxhK5ZpE8OoE6c9AVPzs4baHn8C5y5X5w@mail.gmail.com>
 <714f8873-9a38-8886-4262-4d8e43683614@suse.com>
In-Reply-To: <714f8873-9a38-8886-4262-4d8e43683614@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Jun 2019 12:47:52 -0600
Message-ID: <CAJCQCtQ22s4aD6NRH8LKhC1rW1CdcFKdJJNUBKvirTb5Lk+aBg@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 25, 2019 at 12:58 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> But why are your nocompress files being compressed? I just tested latest
> misc-next branch and a mounted fs with -ocomopress=zstd correctly skips
> compression on a file where chattr +C has been set?
>

This is reproducible with zlib and lzo. Upon rotate, the nocow journal
is compressed. And 'btrfs check' complains about them too with "bad
file extent, some csum missing'

compress=zlib set in fstab
journalctl --rotate

    item 98 key (4731175 INODE_ITEM 0) itemoff 54181 itemsize 160
        generation 61345 transid 62912 size 33554432 nbytes 33554432
        block group 0 mode 100640 links 1 uid 0 gid 190 rdev 0
        sequence 12617 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 1561478658.193673946 (2019-06-25 10:04:18)
        ctime 1561574037.650029396 (2019-06-26 12:33:57)
        mtime 1561574028.883189998 (2019-06-26 12:33:48)
        otime 1561478658.193673946 (2019-06-25 10:04:18)
    item 99 key (4731175 INODE_REF 169326) itemoff 54090 itemsize 91
        index 62 namelen 81 name:
system@bf2624eef8134e64a38931ef85b2311e-0000000000012978-00058c2814bec367.journal
    item 100 key (4731175 XATTR_ITEM 843765919) itemoff 54036 itemsize 54
        location key (0 UNKNOWN.0 0) type XATTR
        transid 61345 data_len 8 name_len 16
        name: user.crtime_usec
    item 101 key (4731175 XATTR_ITEM 2038346239) itemoff 53931 itemsize 105
        location key (0 UNKNOWN.0 0) type XATTR
        transid 61345 data_len 52 name_len 23
        name: system.posix_acl_access
        data
    item 102 key (4731175 XATTR_ITEM 3817753667) itemoff 53854 itemsize 77
        location key (0 UNKNOWN.0 0) type XATTR
        transid 61345 data_len 31 name_len 16
        name: security.selinux
        data system_u:object_r:var_log_t:s0
    item 103 key (4731175 EXTENT_DATA 0) itemoff 53801 itemsize 53
        generation 62912 type 1 (regular)
        extent data disk byte 1125711872 nr 24576
        extent data offset 0 nr 131072 ram 131072
        extent compression 1 (zlib)
    item 104 key (4731175 EXTENT_DATA 131072) itemoff 53748 itemsize 53
        generation 62912 type 1 (regular)
        extent data disk byte 1125736448 nr 24576
        extent data offset 0 nr 131072 ram 131072
        extent compression 1 (zlib)


reboot with compress=lzo in fstab
journalctl --rotate

    item 31 key (4736226 INODE_ITEM 0) itemoff 62096 itemsize 160
        generation 62931 transid 62959 size 16777216 nbytes 16777216
        block group 0 mode 100640 links 1 uid 0 gid 190 rdev 0
        sequence 47 flags 0x13(NODATASUM|NODATACOW|PREALLOC)
        atime 1561574634.315474762 (2019-06-26 12:43:54)
        ctime 1561574674.904503161 (2019-06-26 12:44:34)
        mtime 1561574674.902503198 (2019-06-26 12:44:34)
        otime 1561574634.315474762 (2019-06-26 12:43:54)
    item 32 key (4736226 INODE_REF 169326) itemoff 62005 itemsize 91
        index 4 namelen 81 name:
system@316504f5e5cb4e6eab2ad1d018bc4d2c-0000000000000001-00058c3e6d0ff5a3.journal
    item 33 key (4736226 XATTR_ITEM 843765919) itemoff 61951 itemsize 54
        location key (0 UNKNOWN.0 0) type XATTR
        transid 62931 data_len 8 name_len 16
        name: user.crtime_usec
    item 34 key (4736226 XATTR_ITEM 2038346239) itemoff 61846 itemsize 105
        location key (0 UNKNOWN.0 0) type XATTR
        transid 62931 data_len 52 name_len 23
        name: system.posix_acl_access
        data
    item 35 key (4736226 XATTR_ITEM 3817753667) itemoff 61769 itemsize 77
        location key (0 UNKNOWN.0 0) type XATTR
        transid 62931 data_len 31 name_len 16
        name: security.selinux
        data system_u:object_r:var_log_t:s0
    item 36 key (4736226 EXTENT_DATA 0) itemoff 61716 itemsize 53
        generation 62959 type 1 (regular)
        extent data disk byte 1112309760 nr 12288
        extent data offset 0 nr 131072 ram 131072
        extent compression 2 (lzo)
    item 37 key (4736226 EXTENT_DATA 131072) itemoff 61663 itemsize 53
        generation 62959 type 1 (regular)
        extent data disk byte 1114071040 nr 8192
        extent data offset 0 nr 131072 ram 131072
        extent compression 2 (lzo)


Super easy to reproduce.

-- 
Chris Murphy
