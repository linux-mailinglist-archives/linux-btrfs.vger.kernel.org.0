Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8834D69C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2SHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhC2SHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:07:23 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4FC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 11:07:23 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id l15so4222658uao.12
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xx5F8UiXii1Ii4Bn0O2P50759DT52EiTVxb0w41s/u0=;
        b=zPUjEhD/LTKd0YXE4V84onho+naCdjmSVaLqCBMhfe92PmokhwfwMmtmvVnbF0c7T9
         bsiImYvRzryy+zOPft1wTelm9Hv0j8u8w1wDOCbHx5wQQGUXs8hxSqVhHeNH7m0fWoBb
         CgzVVTpYjLbvAUTGuvU7LWSi6OPeURLHsBGlv62ScM+1lepm6uNpnU+B0qOp/0oBuNFO
         RUQDwoYe5k9qbuCZedDrZlls2fpkLxEXEOveoPaF8GVKvLsoQlcYspfverbbyTWxEKKb
         4/DVUxknIqKkmCIrtB1+J0jEWPSG8AoXFuFIKOa5BKCpH27yqW1YNfZGtWPBPA4eKA7N
         MfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xx5F8UiXii1Ii4Bn0O2P50759DT52EiTVxb0w41s/u0=;
        b=VrBwKkVUkKrl2+pdCSXa8YcOQ5pOFEEKpB/BgT+dUWIp1PAPWohzqMBs/MdHgDGwLF
         YI6+fburhRVWViphDUZKfjTW9Dpqak0HnxfoYLUiWCDpWml8DNvuakEQVk7JBKz9JKXx
         HxmXuTogJCSpVXdmQ/sosO1qYLzD9nU0p4/UPBwoOsJnYIdmy4SliyxH9mV9ZNRUmFDz
         /jzAHVjv1cN/Xn0v3M3qsV/4+89jlGjLOtZlWg6dc8XmbhXGEtuoN0ZIXM2bXhUW3ljU
         aJrpio9/JL4jip1tmoV9C7XCJo3IHCaoCr9l46dVv4V2Lmm2HnNxKg3ffAhnb8SgfhIv
         IEQA==
X-Gm-Message-State: AOAM530j3MgGFXpisqGbwHoJDHdiXyUvOZTiDOnXtDzN6bXY4akdu65f
        2EkOLmvqFv0moy/K0s5JtAjFlXKszecGsA1kKy07hEiLoectlA==
X-Google-Smtp-Source: ABdhPJx+HET0ae9dREMAilLay1XWKAmwXTKNpmi3480njO6qYxK8aSv7WTfmnHBrgsRNdXmAlxcSXgMRA2/PtSM4zf0=
X-Received: by 2002:ab0:36b6:: with SMTP id v22mr14127361uat.123.1617041242542;
 Mon, 29 Mar 2021 11:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
In-Reply-To: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Mar 2021 12:07:05 -0600
Message-ID: <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com>
Subject: Re: Filesystem sometimes Hangs
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 29, 2021 at 5:12 AM Hendrik Friedel <hendrik@friedels.name> wro=
te:
>
> Hello,
>
> I have a filesystem which is sometimes very slow, or even currently
> hangs deleting a file (plain and simple rm in bash).
>
> Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>          Total devices 2 FS bytes used 5.65TiB
>          devid    1 size 7.28TiB used 6.71TiB path /dev/sda1
>          devid    2 size 7.28TiB used 6.71TiB path /dev/sdh1
>
> I did run a scrub without errors.
>
> Checking the logs, I find:
> dmesg -T |grep -i btrfs
> [Mo M=C3=A4r 29 09:29:16 2021] Btrfs loaded, crc32c=3Dcrc32c-intel
> [Mo M=C3=A4r 29 09:29:16 2021] BTRFS: device label DataPool1 devid 2 tran=
sid
> 649014 /dev/sdh1 scanned by btrfs (213)
> [Mo M=C3=A4r 29 09:29:16 2021] BTRFS: device label DataPool1 devid 1 tran=
sid
> 649014 /dev/sda1 scanned by btrfs (213)
> [Mo M=C3=A4r 29 09:29:16 2021] BTRFS: device label Daten devid 1 transid
> 254377 /dev/sdd2 scanned by btrfs (213)
> [Mo M=C3=A4r 29 09:29:16 2021] BTRFS: device label DockerImages devid 1
> transid 209067 /dev/sdc2 scanned by btrfs (213)
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sda1): disk space cachi=
ng
> is enabled
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sda1): has skinny exten=
ts
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdd2): enabling ssd
> optimizations
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdd2): disk space cachi=
ng
> is enabled
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdd2): has skinny exten=
ts
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdc2): turning on sync
> discard
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdc2): enabling ssd
> optimizations
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdc2): disk space cachi=
ng
> is enabled
> [Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdc2): has skinny exten=
ts
> [Mo M=C3=A4r 29 09:29:22 2021] BTRFS info (device sda1): bdev /dev/sda1 e=
rrs:
> wr 133, rd 133, flush 0, corrupt 0, gen 1
>
> Maybe, the last line is concerning?

Yes. Do a 'btrfs scrub' and check dmesg for detailed errors. Next
'btrfs check --readonly' (must be done offline ie booted from usb
stick). And if it all comes up without errors or problems, you can
zero the statistics with 'btrfs dev stats -z'. But otherwise we need
to see the errors to know what's going wrong. It's not normal to have
either read or write errors. It could be related to the problem, or an
additional problem.


>
>
> Syslog tells me:
> Mar 28 20:22:19 homeserver kernel: [1297978.357508] task:btrfs-cleaner
> state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
> Mar 28 20:22:19 homeserver kernel: [1297978.357547]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.357564]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.357577]
> btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.357594]  ?
> btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.357609]
> btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.357622]
> cleaner_kthread+0xfa/0x120 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.357636]  ?
> btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.360473]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.360488]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.360503]
> btrfs_create+0x58/0x1f0 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.363057]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.363072]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:22:19 homeserver kernel: [1297978.363086]
> btrfs_rmdir+0x5c/0x180 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024321] task:btrfs-cleaner
> state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
> Mar 28 20:26:20 homeserver kernel: [1298220.024382]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024419]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024442]
> btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024476]  ?
> btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024504]
> btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024531]
> cleaner_kthread+0xfa/0x120 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.024558]  ?
> btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.030300]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.030331]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:26:20 homeserver kernel: [1298220.030361]
> btrfs_create+0x58/0x1f0 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854109] task:btrfs-cleaner
> state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
> Mar 28 20:28:21 homeserver kernel: [1298340.854151]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854169]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854183]
> btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854202]  ?
> btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854218]
> btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854232]
> cleaner_kthread+0xfa/0x120 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.854247]  ?
> btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.857610]
> wait_current_trans+0xc2/0x120 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.857627]
> start_transaction+0x46d/0x540 [btrfs]
> Mar 28 20:28:21 homeserver kernel: [1298340.857643]
> btrfs_create+0x58/0x1f0 [btrfs]
> Mar 28 20:58:34 homeserver kernel: [1300153.336160] task:btrfs-transacti
> state:D stack:    0 pid:20080 ppid:     2 flags:0x00004000
> Mar 28 20:58:34 homeserver kernel: [1300153.336215]
> btrfs_commit_transaction+0x92b/0xa50 [btrfs]
> Mar 28 20:58:34 homeserver kernel: [1300153.336246]
> transaction_kthread+0x15d/0x180 [btrfs]
> Mar 28 20:58:34 homeserver kernel: [1300153.336273]  ?
> btrfs_cleanup_transaction+0x590/0x590 [btrfs]
>
>
> What could I do to find the cause?

What kernel version?

--=20
Chris Murphy
